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

#include "dma_dequeue.h"
#include <stdio.h>

using namespace hls;
using namespace std;

int main(){
	stream<ap_uint<32>> sts_dma_tcp	, sts_dma_udp;
	stream<ap_uint<32>> header_tcp	, header_udp;
	stream<ap_uint<64>> inflight_queue;
	int num_test_spares = 10;
	int initial_btt		= 100,  initial_tag     = 0x42, initial_src = 0, initial_sequence_number = 666;

	void * ptr 					 = malloc(sizeof(rx_buffer)*num_test_spares+sizeof(unsigned int));
	//create a fake memory
	*((unsigned int *)ptr) 	=  num_test_spares;
	rx_buffer * buffers 	= ( (rx_buffer *) (((uint *)ptr) + 1 ) );
	cout << "Exchange memory: " << ptr << endl;
	//fill buffers with dummy data only even buffer are enqueued
	for(int i = 0; i < num_test_spares; i++ ){
		
		buffers[i].status = (i % 2) == 0 ? STATUS_ENQUEUED : STATUS_RESERVED;
		buffers[i].addrl  = 0xdeadbeef + i ;
		buffers[i].addrh  = 0;
		cout << "Buffer "<< i << " status:" << buffers[i].status << " addr: " << hex << buffers[i].addrh << hex << buffers[i].addrl << endl;
		if ( (i % 2) == 0 ){

			//put spare_buffer_addr in the inflight queue
			inflight_queue.write((long long int) buffers); 
			//create header 
			header_tcp.write((initial_btt 			 + i) & DMA_MAX_BTT);
			header_tcp.write(initial_tag 			 + i);
			header_tcp.write(initial_src 			 + i);
			header_tcp.write(initial_sequence_number + i);
			//create dma sts
			if( i % 4 == 0){
				sts_dma_tcp.write(0x000000f0);
			}else{
				sts_dma_tcp.write(0x80000000 | ((initial_btt + 1) & DMA_MAX_BTT) << 8 );
			}
		}
	}

	dma_dequeue( 1, sts_dma_udp, sts_dma_tcp, header_udp, header_tcp, inflight_queue, (uint *)ptr);

	for(int i = 0; i < num_test_spares; i++ ){
		if (i %2 ){
			assert(buffers[i].status == STATUS_RESERVED) ;
			assert(buffers[i].addrl  == 0xdeadbeef + i ) ;
			assert(buffers[i].addrh  == 0			   ) ;
		}else if( (i % 4) == 1){
			assert(buffers[i].status == STATUS_ERROR) ;
			assert(buffers[i].addrl  == 0xdeadbeef + i ) ;
			assert(buffers[i].addrh  == 0			   ) ;
		}else{
			assert(buffers[i].status == STATUS_RESERVED) ;
			assert(buffers[i].addrl  == 0xdeadbeef + i ) ;
			assert(buffers[i].addrh  == 0			   ) ;
		}
		
		cout << "Buffer "<< i << " status:" << buffers[i].status << " addr: " << hex << buffers[i].addrh << hex << buffers[i].addrl << endl;
		
	}
	cout << "Test passed"<< endl;
	return 0;
}
