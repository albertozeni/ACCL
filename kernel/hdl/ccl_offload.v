/*******************************************************************************
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

`timescale 1 ps / 1 ps

module ccl_offload
(
  input ap_clk,
  input ap_rst_n,
  input bscan_0_bscanid_en,
  input bscan_0_capture,
  input bscan_0_drck,
  input bscan_0_reset,
  input bscan_0_sel,
  input bscan_0_shift,
  input bscan_0_tck,
  input bscan_0_tdi,
  output bscan_0_tdo,
  input bscan_0_tms,
  input bscan_0_update,
  output [63:0]m_axi_0_araddr,
  output [1:0]m_axi_0_arburst,
  output [3:0]m_axi_0_arcache,
  output [7:0]m_axi_0_arlen,
  output [2:0]m_axi_0_arprot,
  input m_axi_0_arready,
  output [2:0]m_axi_0_arsize,
  output [3:0]m_axi_0_aruser,
  output m_axi_0_arvalid,
  output [63:0]m_axi_0_awaddr,
  output [1:0]m_axi_0_awburst,
  output [3:0]m_axi_0_awcache,
  output [7:0]m_axi_0_awlen,
  output [2:0]m_axi_0_awprot,
  input m_axi_0_awready,
  output [2:0]m_axi_0_awsize,
  output [3:0]m_axi_0_awuser,
  output m_axi_0_awvalid,
  output m_axi_0_bready,
  input [1:0]m_axi_0_bresp,
  input m_axi_0_bvalid,
  input [511:0]m_axi_0_rdata,
  input m_axi_0_rlast,
  output m_axi_0_rready,
  input [1:0]m_axi_0_rresp,
  input m_axi_0_rvalid,
  output [511:0]m_axi_0_wdata,
  output m_axi_0_wlast,
  input m_axi_0_wready,
  output [63:0]m_axi_0_wstrb,
  output m_axi_0_wvalid,
  output [63:0]m_axi_1_araddr,
  output [1:0]m_axi_1_arburst,
  output [3:0]m_axi_1_arcache,
  output [7:0]m_axi_1_arlen,
  output [2:0]m_axi_1_arprot,
  input m_axi_1_arready,
  output [2:0]m_axi_1_arsize,
  output [3:0]m_axi_1_aruser,
  output m_axi_1_arvalid,
  output [63:0]m_axi_1_awaddr,
  output [1:0]m_axi_1_awburst,
  output [3:0]m_axi_1_awcache,
  output [7:0]m_axi_1_awlen,
  output [2:0]m_axi_1_awprot,
  input m_axi_1_awready,
  output [2:0]m_axi_1_awsize,
  output [3:0]m_axi_1_awuser,
  output m_axi_1_awvalid,
  output m_axi_1_bready,
  input [1:0]m_axi_1_bresp,
  input m_axi_1_bvalid,
  input [511:0]m_axi_1_rdata,
  input m_axi_1_rlast,
  output m_axi_1_rready,
  input [1:0]m_axi_1_rresp,
  input m_axi_1_rvalid,
  output [511:0]m_axi_1_wdata,
  output m_axi_1_wlast,
  input m_axi_1_wready,
  output [63:0]m_axi_1_wstrb,
  output m_axi_1_wvalid,
  output [63:0]m_axi_2_araddr,
  output [1:0]m_axi_2_arburst,
  output [3:0]m_axi_2_arcache,
  output [7:0]m_axi_2_arlen,
  output [2:0]m_axi_2_arprot,
  input m_axi_2_arready,
  output [2:0]m_axi_2_arsize,
  output [3:0]m_axi_2_aruser,
  output m_axi_2_arvalid,
  output [63:0]m_axi_2_awaddr,
  output [1:0]m_axi_2_awburst,
  output [3:0]m_axi_2_awcache,
  output [7:0]m_axi_2_awlen,
  output [2:0]m_axi_2_awprot,
  input m_axi_2_awready,
  output [2:0]m_axi_2_awsize,
  output [3:0]m_axi_2_awuser,
  output m_axi_2_awvalid,
  output m_axi_2_bready,
  input [1:0]m_axi_2_bresp,
  input m_axi_2_bvalid,
  input [511:0]m_axi_2_rdata,
  input m_axi_2_rlast,
  output m_axi_2_rready,
  input [1:0]m_axi_2_rresp,
  input m_axi_2_rvalid,
  output [511:0]m_axi_2_wdata,
  output m_axi_2_wlast,
  input m_axi_2_wready,
  output [63:0]m_axi_2_wstrb,
  output m_axi_2_wvalid,
  output [511:0]m_axis_arith_op0_tdata,
  output [63:0]m_axis_arith_op0_tkeep,
  output [0:0]m_axis_arith_op0_tlast,
  input [0:0]m_axis_arith_op0_tready,
  output [63:0]m_axis_arith_op0_tstrb,
  output [0:0]m_axis_arith_op0_tvalid,
  output [511:0]m_axis_arith_op1_tdata,
  output [63:0]m_axis_arith_op1_tkeep,
  output [0:0]m_axis_arith_op1_tlast,
  input [0:0]m_axis_arith_op1_tready,
  output [63:0]m_axis_arith_op1_tstrb,
  output [0:0]m_axis_arith_op1_tvalid,
  output [511:0]m_axis_krnl_tdata,
  output [63:0]m_axis_krnl_tkeep,
  output [0:0]m_axis_krnl_tlast,
  input [0:0]m_axis_krnl_tready,
  output [63:0]m_axis_krnl_tstrb,
  output [0:0]m_axis_krnl_tvalid,
  output [15:0]m_axis_tcp_listen_port_tdata,
  output [1:0]m_axis_tcp_listen_port_tkeep,
  output [0:0]m_axis_tcp_listen_port_tlast,
  input m_axis_tcp_listen_port_tready,
  output [1:0]m_axis_tcp_listen_port_tstrb,
  output m_axis_tcp_listen_port_tvalid,
  output [63:0]m_axis_tcp_open_connection_tdata,
  output [7:0]m_axis_tcp_open_connection_tkeep,
  output [0:0]m_axis_tcp_open_connection_tlast,
  input m_axis_tcp_open_connection_tready,
  output [7:0]m_axis_tcp_open_connection_tstrb,
  output m_axis_tcp_open_connection_tvalid,
  output [31:0]m_axis_tcp_read_pkg_tdata,
  output [3:0]m_axis_tcp_read_pkg_tkeep,
  output [0:0]m_axis_tcp_read_pkg_tlast,
  input m_axis_tcp_read_pkg_tready,
  output [3:0]m_axis_tcp_read_pkg_tstrb,
  output m_axis_tcp_read_pkg_tvalid,
  output [511:0]m_axis_tcp_tx_data_tdata,
  output [63:0]m_axis_tcp_tx_data_tkeep,
  output m_axis_tcp_tx_data_tlast,
  input m_axis_tcp_tx_data_tready,
  output m_axis_tcp_tx_data_tvalid,
  output [31:0]m_axis_tcp_tx_meta_tdata,
  output [3:0]m_axis_tcp_tx_meta_tkeep,
  output [0:0]m_axis_tcp_tx_meta_tlast,
  input m_axis_tcp_tx_meta_tready,
  output [3:0]m_axis_tcp_tx_meta_tstrb,
  output m_axis_tcp_tx_meta_tvalid,
  output [511:0]m_axis_udp_tx_data_tdata,
  output [15:0]m_axis_udp_tx_data_tdest,
  output [63:0]m_axis_udp_tx_data_tkeep,
  output m_axis_udp_tx_data_tlast,
  input m_axis_udp_tx_data_tready,
  output m_axis_udp_tx_data_tvalid,
  input [12:0]s_axi_control_araddr,
  input [2:0]s_axi_control_arprot,
  output s_axi_control_arready,
  input s_axi_control_arvalid,
  input [12:0]s_axi_control_awaddr,
  input [2:0]s_axi_control_awprot,
  output s_axi_control_awready,
  input s_axi_control_awvalid,
  input s_axi_control_bready,
  output [1:0]s_axi_control_bresp,
  output s_axi_control_bvalid,
  output [31:0]s_axi_control_rdata,
  input s_axi_control_rready,
  output [1:0]s_axi_control_rresp,
  output s_axi_control_rvalid,
  input [31:0]s_axi_control_wdata,
  output s_axi_control_wready,
  input [3:0]s_axi_control_wstrb,
  input s_axi_control_wvalid,
  input [511:0]s_axis_arith_res_tdata,
  input [63:0]s_axis_arith_res_tkeep,
  input [0:0]s_axis_arith_res_tlast,
  output [0:0]s_axis_arith_res_tready,
  input [63:0]s_axis_arith_res_tstrb,
  input [0:0]s_axis_arith_res_tvalid,
  input [511:0]s_axis_krnl_tdata,
  input [63:0]s_axis_krnl_tkeep,
  input [0:0]s_axis_krnl_tlast,
  output [0:0]s_axis_krnl_tready,
  input [63:0]s_axis_krnl_tstrb,
  input [0:0]s_axis_krnl_tvalid,
  input [127:0]s_axis_tcp_notification_tdata,
  input [15:0]s_axis_tcp_notification_tkeep,
  input [0:0]s_axis_tcp_notification_tlast,
  output s_axis_tcp_notification_tready,
  input [15:0]s_axis_tcp_notification_tstrb,
  input s_axis_tcp_notification_tvalid,
  input [127:0]s_axis_tcp_open_status_tdata,
  input [15:0]s_axis_tcp_open_status_tkeep,
  input [0:0]s_axis_tcp_open_status_tlast,
  output s_axis_tcp_open_status_tready,
  input [15:0]s_axis_tcp_open_status_tstrb,
  input s_axis_tcp_open_status_tvalid,
  input [7:0]s_axis_tcp_port_status_tdata,
  input [0:0]s_axis_tcp_port_status_tkeep,
  input [0:0]s_axis_tcp_port_status_tlast,
  output s_axis_tcp_port_status_tready,
  input [0:0]s_axis_tcp_port_status_tstrb,
  input s_axis_tcp_port_status_tvalid,
  input [511:0]s_axis_tcp_rx_data_tdata,
  input [63:0]s_axis_tcp_rx_data_tkeep,
  input s_axis_tcp_rx_data_tlast,
  output s_axis_tcp_rx_data_tready,
  input [63:0]s_axis_tcp_rx_data_tstrb,
  input s_axis_tcp_rx_data_tvalid,
  input [15:0]s_axis_tcp_rx_meta_tdata,
  input [1:0]s_axis_tcp_rx_meta_tkeep,
  input [0:0]s_axis_tcp_rx_meta_tlast,
  output s_axis_tcp_rx_meta_tready,
  input [1:0]s_axis_tcp_rx_meta_tstrb,
  input s_axis_tcp_rx_meta_tvalid,
  input [63:0]s_axis_tcp_tx_status_tdata,
  input [7:0]s_axis_tcp_tx_status_tkeep,
  input [0:0]s_axis_tcp_tx_status_tlast,
  output s_axis_tcp_tx_status_tready,
  input [7:0]s_axis_tcp_tx_status_tstrb,
  input s_axis_tcp_tx_status_tvalid,
  input [511:0]s_axis_udp_rx_data_tdata,
  input [15:0]s_axis_udp_rx_data_tdest,
  input [63:0]s_axis_udp_rx_data_tkeep,
  input s_axis_udp_rx_data_tlast,
  output s_axis_udp_rx_data_tready,
  input s_axis_udp_rx_data_tvalid
);

  ccl_offload_bd ccl_offload_bd_i
       (.ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .bscan_0_bscanid_en(bscan_0_bscanid_en),
        .bscan_0_capture(bscan_0_capture),
        .bscan_0_drck(bscan_0_drck),
        .bscan_0_reset(bscan_0_reset),
        .bscan_0_sel(bscan_0_sel),
        .bscan_0_shift(bscan_0_shift),
        .bscan_0_tck(bscan_0_tck),
        .bscan_0_tdi(bscan_0_tdi),
        .bscan_0_tdo(bscan_0_tdo),
        .bscan_0_tms(bscan_0_tms),
        .bscan_0_update(bscan_0_update),
        .m_axi_0_araddr(m_axi_0_araddr),
        .m_axi_0_arburst(m_axi_0_arburst),
        .m_axi_0_arcache(m_axi_0_arcache),
        .m_axi_0_arlen(m_axi_0_arlen),
        .m_axi_0_arprot(m_axi_0_arprot),
        .m_axi_0_arready(m_axi_0_arready),
        .m_axi_0_arsize(m_axi_0_arsize),
        .m_axi_0_aruser(m_axi_0_aruser),
        .m_axi_0_arvalid(m_axi_0_arvalid),
        .m_axi_0_awaddr(m_axi_0_awaddr),
        .m_axi_0_awburst(m_axi_0_awburst),
        .m_axi_0_awcache(m_axi_0_awcache),
        .m_axi_0_awlen(m_axi_0_awlen),
        .m_axi_0_awprot(m_axi_0_awprot),
        .m_axi_0_awready(m_axi_0_awready),
        .m_axi_0_awsize(m_axi_0_awsize),
        .m_axi_0_awuser(m_axi_0_awuser),
        .m_axi_0_awvalid(m_axi_0_awvalid),
        .m_axi_0_bready(m_axi_0_bready),
        .m_axi_0_bresp(m_axi_0_bresp),
        .m_axi_0_bvalid(m_axi_0_bvalid),
        .m_axi_0_rdata(m_axi_0_rdata),
        .m_axi_0_rlast(m_axi_0_rlast),
        .m_axi_0_rready(m_axi_0_rready),
        .m_axi_0_rresp(m_axi_0_rresp),
        .m_axi_0_rvalid(m_axi_0_rvalid),
        .m_axi_0_wdata(m_axi_0_wdata),
        .m_axi_0_wlast(m_axi_0_wlast),
        .m_axi_0_wready(m_axi_0_wready),
        .m_axi_0_wstrb(m_axi_0_wstrb),
        .m_axi_0_wvalid(m_axi_0_wvalid),
        .m_axi_1_araddr(m_axi_1_araddr),
        .m_axi_1_arburst(m_axi_1_arburst),
        .m_axi_1_arcache(m_axi_1_arcache),
        .m_axi_1_arlen(m_axi_1_arlen),
        .m_axi_1_arprot(m_axi_1_arprot),
        .m_axi_1_arready(m_axi_1_arready),
        .m_axi_1_arsize(m_axi_1_arsize),
        .m_axi_1_aruser(m_axi_1_aruser),
        .m_axi_1_arvalid(m_axi_1_arvalid),
        .m_axi_1_awaddr(m_axi_1_awaddr),
        .m_axi_1_awburst(m_axi_1_awburst),
        .m_axi_1_awcache(m_axi_1_awcache),
        .m_axi_1_awlen(m_axi_1_awlen),
        .m_axi_1_awprot(m_axi_1_awprot),
        .m_axi_1_awready(m_axi_1_awready),
        .m_axi_1_awsize(m_axi_1_awsize),
        .m_axi_1_awuser(m_axi_1_awuser),
        .m_axi_1_awvalid(m_axi_1_awvalid),
        .m_axi_1_bready(m_axi_1_bready),
        .m_axi_1_bresp(m_axi_1_bresp),
        .m_axi_1_bvalid(m_axi_1_bvalid),
        .m_axi_1_rdata(m_axi_1_rdata),
        .m_axi_1_rlast(m_axi_1_rlast),
        .m_axi_1_rready(m_axi_1_rready),
        .m_axi_1_rresp(m_axi_1_rresp),
        .m_axi_1_rvalid(m_axi_1_rvalid),
        .m_axi_1_wdata(m_axi_1_wdata),
        .m_axi_1_wlast(m_axi_1_wlast),
        .m_axi_1_wready(m_axi_1_wready),
        .m_axi_1_wstrb(m_axi_1_wstrb),
        .m_axi_1_wvalid(m_axi_1_wvalid),
        .m_axi_2_araddr(m_axi_2_araddr),
        .m_axi_2_arburst(m_axi_2_arburst),
        .m_axi_2_arcache(m_axi_2_arcache),
        .m_axi_2_arlen(m_axi_2_arlen),
        .m_axi_2_arprot(m_axi_2_arprot),
        .m_axi_2_arready(m_axi_2_arready),
        .m_axi_2_arsize(m_axi_2_arsize),
        .m_axi_2_aruser(m_axi_2_aruser),
        .m_axi_2_arvalid(m_axi_2_arvalid),
        .m_axi_2_awaddr(m_axi_2_awaddr),
        .m_axi_2_awburst(m_axi_2_awburst),
        .m_axi_2_awcache(m_axi_2_awcache),
        .m_axi_2_awlen(m_axi_2_awlen),
        .m_axi_2_awprot(m_axi_2_awprot),
        .m_axi_2_awready(m_axi_2_awready),
        .m_axi_2_awsize(m_axi_2_awsize),
        .m_axi_2_awuser(m_axi_2_awuser),
        .m_axi_2_awvalid(m_axi_2_awvalid),
        .m_axi_2_bready(m_axi_2_bready),
        .m_axi_2_bresp(m_axi_2_bresp),
        .m_axi_2_bvalid(m_axi_2_bvalid),
        .m_axi_2_rdata(m_axi_2_rdata),
        .m_axi_2_rlast(m_axi_2_rlast),
        .m_axi_2_rready(m_axi_2_rready),
        .m_axi_2_rresp(m_axi_2_rresp),
        .m_axi_2_rvalid(m_axi_2_rvalid),
        .m_axi_2_wdata(m_axi_2_wdata),
        .m_axi_2_wlast(m_axi_2_wlast),
        .m_axi_2_wready(m_axi_2_wready),
        .m_axi_2_wstrb(m_axi_2_wstrb),
        .m_axi_2_wvalid(m_axi_2_wvalid),
        .m_axis_arith_op0_tdata(m_axis_arith_op0_tdata),
        .m_axis_arith_op0_tkeep(m_axis_arith_op0_tkeep),
        .m_axis_arith_op0_tlast(m_axis_arith_op0_tlast),
        .m_axis_arith_op0_tready(m_axis_arith_op0_tready),
        .m_axis_arith_op0_tstrb(m_axis_arith_op0_tstrb),
        .m_axis_arith_op0_tvalid(m_axis_arith_op0_tvalid),
        .m_axis_arith_op1_tdata(m_axis_arith_op1_tdata),
        .m_axis_arith_op1_tkeep(m_axis_arith_op1_tkeep),
        .m_axis_arith_op1_tlast(m_axis_arith_op1_tlast),
        .m_axis_arith_op1_tready(m_axis_arith_op1_tready),
        .m_axis_arith_op1_tstrb(m_axis_arith_op1_tstrb),
        .m_axis_arith_op1_tvalid(m_axis_arith_op1_tvalid),
        .m_axis_krnl_tdata(m_axis_krnl_tdata),
        .m_axis_krnl_tkeep(m_axis_krnl_tkeep),
        .m_axis_krnl_tlast(m_axis_krnl_tlast),
        .m_axis_krnl_tready(m_axis_krnl_tready),
        .m_axis_krnl_tstrb(m_axis_krnl_tstrb),
        .m_axis_krnl_tvalid(m_axis_krnl_tvalid),
        .m_axis_tcp_listen_port_tdata(m_axis_tcp_listen_port_tdata),
        .m_axis_tcp_listen_port_tkeep(m_axis_tcp_listen_port_tkeep),
        .m_axis_tcp_listen_port_tlast(m_axis_tcp_listen_port_tlast),
        .m_axis_tcp_listen_port_tready(m_axis_tcp_listen_port_tready),
        .m_axis_tcp_listen_port_tstrb(m_axis_tcp_listen_port_tstrb),
        .m_axis_tcp_listen_port_tvalid(m_axis_tcp_listen_port_tvalid),
        .m_axis_tcp_open_connection_tdata(m_axis_tcp_open_connection_tdata),
        .m_axis_tcp_open_connection_tkeep(m_axis_tcp_open_connection_tkeep),
        .m_axis_tcp_open_connection_tlast(m_axis_tcp_open_connection_tlast),
        .m_axis_tcp_open_connection_tready(m_axis_tcp_open_connection_tready),
        .m_axis_tcp_open_connection_tstrb(m_axis_tcp_open_connection_tstrb),
        .m_axis_tcp_open_connection_tvalid(m_axis_tcp_open_connection_tvalid),
        .m_axis_tcp_read_pkg_tdata(m_axis_tcp_read_pkg_tdata),
        .m_axis_tcp_read_pkg_tkeep(m_axis_tcp_read_pkg_tkeep),
        .m_axis_tcp_read_pkg_tlast(m_axis_tcp_read_pkg_tlast),
        .m_axis_tcp_read_pkg_tready(m_axis_tcp_read_pkg_tready),
        .m_axis_tcp_read_pkg_tstrb(m_axis_tcp_read_pkg_tstrb),
        .m_axis_tcp_read_pkg_tvalid(m_axis_tcp_read_pkg_tvalid),
        .m_axis_tcp_tx_data_tdata(m_axis_tcp_tx_data_tdata),
        .m_axis_tcp_tx_data_tkeep(m_axis_tcp_tx_data_tkeep),
        .m_axis_tcp_tx_data_tlast(m_axis_tcp_tx_data_tlast),
        .m_axis_tcp_tx_data_tready(m_axis_tcp_tx_data_tready),
        .m_axis_tcp_tx_data_tvalid(m_axis_tcp_tx_data_tvalid),
        .m_axis_tcp_tx_meta_tdata(m_axis_tcp_tx_meta_tdata),
        .m_axis_tcp_tx_meta_tkeep(m_axis_tcp_tx_meta_tkeep),
        .m_axis_tcp_tx_meta_tlast(m_axis_tcp_tx_meta_tlast),
        .m_axis_tcp_tx_meta_tready(m_axis_tcp_tx_meta_tready),
        .m_axis_tcp_tx_meta_tstrb(m_axis_tcp_tx_meta_tstrb),
        .m_axis_tcp_tx_meta_tvalid(m_axis_tcp_tx_meta_tvalid),
        .m_axis_udp_tx_data_tdata(m_axis_udp_tx_data_tdata),
        .m_axis_udp_tx_data_tdest(m_axis_udp_tx_data_tdest),
        .m_axis_udp_tx_data_tkeep(m_axis_udp_tx_data_tkeep),
        .m_axis_udp_tx_data_tlast(m_axis_udp_tx_data_tlast),
        .m_axis_udp_tx_data_tready(m_axis_udp_tx_data_tready),
        .m_axis_udp_tx_data_tvalid(m_axis_udp_tx_data_tvalid),
        .s_axi_control_araddr(s_axi_control_araddr),
        .s_axi_control_arprot(s_axi_control_arprot),
        .s_axi_control_arready(s_axi_control_arready),
        .s_axi_control_arvalid(s_axi_control_arvalid),
        .s_axi_control_awaddr(s_axi_control_awaddr),
        .s_axi_control_awprot(s_axi_control_awprot),
        .s_axi_control_awready(s_axi_control_awready),
        .s_axi_control_awvalid(s_axi_control_awvalid),
        .s_axi_control_bready(s_axi_control_bready),
        .s_axi_control_bresp(s_axi_control_bresp),
        .s_axi_control_bvalid(s_axi_control_bvalid),
        .s_axi_control_rdata(s_axi_control_rdata),
        .s_axi_control_rready(s_axi_control_rready),
        .s_axi_control_rresp(s_axi_control_rresp),
        .s_axi_control_rvalid(s_axi_control_rvalid),
        .s_axi_control_wdata(s_axi_control_wdata),
        .s_axi_control_wready(s_axi_control_wready),
        .s_axi_control_wstrb(s_axi_control_wstrb),
        .s_axi_control_wvalid(s_axi_control_wvalid),
        .s_axis_arith_res_tdata(s_axis_arith_res_tdata),
        .s_axis_arith_res_tkeep(s_axis_arith_res_tkeep),
        .s_axis_arith_res_tlast(s_axis_arith_res_tlast),
        .s_axis_arith_res_tready(s_axis_arith_res_tready),
        .s_axis_arith_res_tstrb(s_axis_arith_res_tstrb),
        .s_axis_arith_res_tvalid(s_axis_arith_res_tvalid),
        .s_axis_krnl_tdata(s_axis_krnl_tdata),
        .s_axis_krnl_tkeep(s_axis_krnl_tkeep),
        .s_axis_krnl_tlast(s_axis_krnl_tlast),
        .s_axis_krnl_tready(s_axis_krnl_tready),
        .s_axis_krnl_tstrb(s_axis_krnl_tstrb),
        .s_axis_krnl_tvalid(s_axis_krnl_tvalid),
        .s_axis_tcp_notification_tdata(s_axis_tcp_notification_tdata),
        .s_axis_tcp_notification_tkeep(s_axis_tcp_notification_tkeep),
        .s_axis_tcp_notification_tlast(s_axis_tcp_notification_tlast),
        .s_axis_tcp_notification_tready(s_axis_tcp_notification_tready),
        .s_axis_tcp_notification_tstrb(s_axis_tcp_notification_tstrb),
        .s_axis_tcp_notification_tvalid(s_axis_tcp_notification_tvalid),
        .s_axis_tcp_open_status_tdata(s_axis_tcp_open_status_tdata),
        .s_axis_tcp_open_status_tkeep(s_axis_tcp_open_status_tkeep),
        .s_axis_tcp_open_status_tlast(s_axis_tcp_open_status_tlast),
        .s_axis_tcp_open_status_tready(s_axis_tcp_open_status_tready),
        .s_axis_tcp_open_status_tstrb(s_axis_tcp_open_status_tstrb),
        .s_axis_tcp_open_status_tvalid(s_axis_tcp_open_status_tvalid),
        .s_axis_tcp_port_status_tdata(s_axis_tcp_port_status_tdata),
        .s_axis_tcp_port_status_tkeep(s_axis_tcp_port_status_tkeep),
        .s_axis_tcp_port_status_tlast(s_axis_tcp_port_status_tlast),
        .s_axis_tcp_port_status_tready(s_axis_tcp_port_status_tready),
        .s_axis_tcp_port_status_tstrb(s_axis_tcp_port_status_tstrb),
        .s_axis_tcp_port_status_tvalid(s_axis_tcp_port_status_tvalid),
        .s_axis_tcp_rx_data_tdata(s_axis_tcp_rx_data_tdata),
        .s_axis_tcp_rx_data_tkeep(s_axis_tcp_rx_data_tkeep),
        .s_axis_tcp_rx_data_tlast(s_axis_tcp_rx_data_tlast),
        .s_axis_tcp_rx_data_tready(s_axis_tcp_rx_data_tready),
        .s_axis_tcp_rx_data_tstrb(s_axis_tcp_rx_data_tstrb),
        .s_axis_tcp_rx_data_tvalid(s_axis_tcp_rx_data_tvalid),
        .s_axis_tcp_rx_meta_tdata(s_axis_tcp_rx_meta_tdata),
        .s_axis_tcp_rx_meta_tkeep(s_axis_tcp_rx_meta_tkeep),
        .s_axis_tcp_rx_meta_tlast(s_axis_tcp_rx_meta_tlast),
        .s_axis_tcp_rx_meta_tready(s_axis_tcp_rx_meta_tready),
        .s_axis_tcp_rx_meta_tstrb(s_axis_tcp_rx_meta_tstrb),
        .s_axis_tcp_rx_meta_tvalid(s_axis_tcp_rx_meta_tvalid),
        .s_axis_tcp_tx_status_tdata(s_axis_tcp_tx_status_tdata),
        .s_axis_tcp_tx_status_tkeep(s_axis_tcp_tx_status_tkeep),
        .s_axis_tcp_tx_status_tlast(s_axis_tcp_tx_status_tlast),
        .s_axis_tcp_tx_status_tready(s_axis_tcp_tx_status_tready),
        .s_axis_tcp_tx_status_tstrb(s_axis_tcp_tx_status_tstrb),
        .s_axis_tcp_tx_status_tvalid(s_axis_tcp_tx_status_tvalid),
        .s_axis_udp_rx_data_tdata(s_axis_udp_rx_data_tdata),
        .s_axis_udp_rx_data_tdest(s_axis_udp_rx_data_tdest),
        .s_axis_udp_rx_data_tkeep(s_axis_udp_rx_data_tkeep),
        .s_axis_udp_rx_data_tlast(s_axis_udp_rx_data_tlast),
        .s_axis_udp_rx_data_tready(s_axis_udp_rx_data_tready),
        .s_axis_udp_rx_data_tvalid(s_axis_udp_rx_data_tvalid)
        );

endmodule
