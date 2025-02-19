# /*******************************************************************************
#  Copyright (C) 2021 Xilinx, Inc
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
# *******************************************************************************/

proc create_hier_cell_udp_rx_subsystem { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_rx_subsystem() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_data
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_data
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_control
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_status


  # Create pins
  create_bd_pin -dir I -type clk ap_clk
  create_bd_pin -dir I -type rst ap_rst_n

  # Create rx_fifos, and set properties
  set rx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 rx_fifo ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.IS_ACLK_ASYNC {0} \
   CONFIG.TDATA_NUM_BYTES {64} \
 ] $rx_fifo

  # Create instance: vnx_depacketizer_0, and set properties
  set vnx_depacketizer_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:vnx_depacketizer:1.0 vnx_depacketizer_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net control [get_bd_intf_pins s_axi_control] [get_bd_intf_pins vnx_depacketizer_0/s_axi_control]
  connect_bd_intf_net -intf_net in2fifo [get_bd_intf_pins s_axis_data] [get_bd_intf_pins rx_fifo/S_AXIS]
  connect_bd_intf_net -intf_net fifo2dpkt [get_bd_intf_pins rx_fifo/M_AXIS] [get_bd_intf_pins vnx_depacketizer_0/in_r]
  connect_bd_intf_net -intf_net dpkt2out [get_bd_intf_pins m_axis_data] [get_bd_intf_pins vnx_depacketizer_0/out_r]
  connect_bd_intf_net -intf_net status [get_bd_intf_pins m_axis_status] [get_bd_intf_pins vnx_depacketizer_0/sts_V]

  # Create port connections
  connect_bd_net -net ap_clk [get_bd_pins ap_clk]  [get_bd_pins rx_fifo/s_axis_aclk] [get_bd_pins vnx_depacketizer_0/ap_clk]
  connect_bd_net -net ap_rst_n [get_bd_pins ap_rst_n] [get_bd_pins rx_fifo/s_axis_aresetn] [get_bd_pins vnx_depacketizer_0/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}


proc create_hier_cell_tcp_rx_subsystem { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_rx_subsystem() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_control
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_pktsts
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_tcp_port_status
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_tcp_listen_port
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_tcp_rx_data
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_tcp_rx_data
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_openport_cmd
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_tcp_notification
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_tcp_rx_meta
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_openport_sts
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_tcp_read_pkg

  # Create pins
  create_bd_pin -dir I -type clk ap_clk
  create_bd_pin -dir I -type rst ap_rst_n

  set rx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 rx_fifo ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.IS_ACLK_ASYNC {0} \
   CONFIG.TDATA_NUM_BYTES {64} \
 ] $rx_fifo

  # Create instances of TCP blocks
  set tcp_depacketizer_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:tcp_depacketizer:1.0 tcp_depacketizer_0 ]
  set tcp_openPort_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:tcp_openPort:1.0 tcp_openPort_0 ]
  set tcp_rxHandler_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:tcp_rxHandler:1.0 tcp_rxHandler_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net control [get_bd_intf_pins s_axi_control] [get_bd_intf_pins tcp_depacketizer_0/s_axi_control]

  # various metadata
  connect_bd_intf_net -intf_net notif [get_bd_intf_pins s_axis_tcp_notification] [get_bd_intf_pins tcp_rxHandler_0/s_axis_tcp_notification]
  connect_bd_intf_net -intf_net meta [get_bd_intf_pins s_axis_tcp_rx_meta] [get_bd_intf_pins tcp_rxHandler_0/s_axis_tcp_rx_meta]
  connect_bd_intf_net -intf_net dpktsts [get_bd_intf_pins m_axis_pktsts] [get_bd_intf_pins tcp_depacketizer_0/sts_V]
  connect_bd_intf_net -intf_net rpkg [get_bd_intf_pins m_axis_tcp_read_pkg] [get_bd_intf_pins tcp_rxHandler_0/m_axis_tcp_read_pkg]

  # port management: command/status from/to Microblaze, command/status to/from TCP stack
  connect_bd_intf_net -intf_net openportcmd [get_bd_intf_pins s_axis_openport_cmd] [get_bd_intf_pins tcp_openPort_0/cmd_V]
  connect_bd_intf_net -intf_net openportsts [get_bd_intf_pins m_axis_openport_sts] [get_bd_intf_pins tcp_openPort_0/sts_V]
  connect_bd_intf_net -intf_net listenport [get_bd_intf_pins m_axis_tcp_listen_port] [get_bd_intf_pins tcp_openPort_0/m_axis_tcp_listen_port]
  connect_bd_intf_net -intf_net portsts [get_bd_intf_pins s_axis_tcp_port_status] [get_bd_intf_pins tcp_openPort_0/s_axis_tcp_port_status]

  # main data path through FIFO, RX handler, RX depacketizer
  connect_bd_intf_net -intf_net in2fifo [get_bd_intf_pins s_axis_tcp_rx_data] [get_bd_intf_pins rx_fifo/S_AXIS]
  connect_bd_intf_net -intf_net fifo2rxh [get_bd_intf_pins rx_fifo/M_AXIS] [get_bd_intf_pins tcp_rxHandler_0/s_axis_tcp_rx_data]
  connect_bd_intf_net -intf_net rxh2dpkt [get_bd_intf_pins tcp_depacketizer_0/in_r] [get_bd_intf_pins tcp_rxHandler_0/s_data_out]
  connect_bd_intf_net -intf_net dpkt2out [get_bd_intf_pins m_axis_tcp_rx_data] [get_bd_intf_pins tcp_depacketizer_0/out_r]

  # Create port connections
  connect_bd_net -net ap_clk [get_bd_pins ap_clk]  [get_bd_pins tcp_depacketizer_0/ap_clk] \
                                                   [get_bd_pins tcp_openPort_0/ap_clk] \
                                                   [get_bd_pins tcp_rxHandler_0/ap_clk] \
                                                   [get_bd_pins axi_interconnect_0/ACLK] \
                                                   [get_bd_pins axi_interconnect_0/S00_ACLK] \
                                                   [get_bd_pins axi_interconnect_0/M00_ACLK] \
                                                   [get_bd_pins axi_interconnect_0/M01_ACLK] \
                                                   [get_bd_pins rx_fifo/s_axis_aclk]
  connect_bd_net -net ap_rst_n [get_bd_pins ap_rst_n] [get_bd_pins tcp_depacketizer_0/ap_rst_n] \
                                                      [get_bd_pins tcp_openPort_0/ap_rst_n] \
                                                      [get_bd_pins tcp_rxHandler_0/ap_rst_n] \
                                                      [get_bd_pins axi_interconnect_0/ARESETN] \
                                                      [get_bd_pins axi_interconnect_0/S00_ARESETN] \
                                                      [get_bd_pins axi_interconnect_0/M00_ARESETN] \
                                                      [get_bd_pins axi_interconnect_0/M01_ARESETN] \
                                                      [get_bd_pins rx_fifo/s_axis_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Create instance: rx_subsystem
create_hier_cell_udp_rx_subsystem [current_bd_instance .] udp_rx_subsystem
create_hier_cell_tcp_rx_subsystem [current_bd_instance .] tcp_rx_subsystem
