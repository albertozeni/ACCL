#ifndef _DMA_DEQUEUE_H_
    #define _DMA_DEQUEUE_H_
	#include "hls_stream.h"
	#include "ap_int.h"
	#include "ap_utils.h"

	using namespace hls;

    typedef struct {
        unsigned int addrl;
        unsigned int addrh;
        unsigned int max_len;
        unsigned int dma_tag;
        unsigned int status;
        unsigned int rx_tag;
        unsigned int rx_len;
        unsigned int rx_src;
        unsigned int sequence_number;
    } rx_buffer;
    #define STATUS_IDLE     0x00
    #define STATUS_ENQUEUED 0x01
    #define STATUS_RESERVED 0x02
    #define STATUS_ERROR    0x04
    #define DMA_MAX_BTT     0x7FFFFF

    void dma_dequeue(	unsigned int use_tcp,
				stream<ap_uint<32>> &sts_tcp,
				stream<ap_uint<32>> &sts_udp,
                stream<ap_uint<32>> &header_udp,
				stream<ap_uint<32>> &header_tcp,
				stream<ap_uint<64>> &inflight_queue,
				volatile uint* exchange_mem
    );

#endif
