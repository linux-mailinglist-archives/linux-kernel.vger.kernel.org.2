Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7E310110
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhBDXv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:51:28 -0500
Received: from foss.arm.com ([217.140.110.172]:40874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhBDXv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:51:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8822FD6E;
        Thu,  4 Feb 2021 15:50:39 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C5C63F719;
        Thu,  4 Feb 2021 15:50:38 -0800 (PST)
Subject: Re: [PATCH] dma-mapping: benchmark: pretend DMA is transmitting
To:     Barry Song <song.bao.hua@hisilicon.com>, m.szyprowski@samsung.com,
        hch@lst.de, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linuxarm@openeuler.org
References: <20210204225847.8884-1-song.bao.hua@hisilicon.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8d714a55-7bbc-128e-3e39-492ebf204223@arm.com>
Date:   Thu, 4 Feb 2021 23:50:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204225847.8884-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-04 22:58, Barry Song wrote:
> In a real dma mapping user case, after dma_map is done, data will be
> transmit. Thus, in multi-threaded user scenario, IOMMU contention
> should not be that severe. For example, if users enable multiple
> threads to send network packets through 1G/10G/100Gbps NIC, usually
> the steps will be: map -> transmission -> unmap.  Transmission delay
> reduces the contention of IOMMU. Here a delay is added to simulate
> the transmission for TX case so that the tested result could be
> more accurate.
> 
> RX case would be much more tricky. It is not supported yet.

I guess it might be a reasonable approximation to map several pages, 
then unmap them again after a slightly more random delay. Or maybe 
divide the threads into pairs of mappers and unmappers respectively 
filling up and draining proper little buffer pools.

> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   kernel/dma/map_benchmark.c                      | 11 +++++++++++
>   tools/testing/selftests/dma/dma_map_benchmark.c | 17 +++++++++++++++--
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 1b1b8ff875cb..1976db7e34e4 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -21,6 +21,7 @@
>   #define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
>   #define DMA_MAP_MAX_THREADS	1024
>   #define DMA_MAP_MAX_SECONDS	300
> +#define DMA_MAP_MAX_TRANS_DELAY	(10 * 1000 * 1000) /* 10ms */

Using MSEC_PER_SEC might be sufficiently self-documenting?

>   #define DMA_MAP_BIDIRECTIONAL	0
>   #define DMA_MAP_TO_DEVICE	1
> @@ -36,6 +37,7 @@ struct map_benchmark {
>   	__s32 node; /* which numa node this benchmark will run on */
>   	__u32 dma_bits; /* DMA addressing capability */
>   	__u32 dma_dir; /* DMA data direction */
> +	__u32 dma_trans_ns; /* time for DMA transmission in ns */
>   	__u64 expansion[10];	/* For future use */
>   };
>   
> @@ -87,6 +89,10 @@ static int map_benchmark_thread(void *data)
>   		map_etime = ktime_get();
>   		map_delta = ktime_sub(map_etime, map_stime);
>   
> +		/* Pretend DMA is transmitting */
> +		if (map->dir != DMA_FROM_DEVICE)
> +			ndelay(map->bparam.dma_trans_ns);

TBH I think the option of a fixed delay between map and unmap might be a 
handy thing in general, so having the direction check at all seems 
needlessly restrictive. As long as the driver implements all the basic 
building blocks, combining them to simulate specific traffic patterns 
can be left up to the benchmark tool.

Robin.

> +
>   		unmap_stime = ktime_get();
>   		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE, map->dir);
>   		unmap_etime = ktime_get();
> @@ -218,6 +224,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
>   			return -EINVAL;
>   		}
>   
> +		if (map->bparam.dma_trans_ns > DMA_MAP_MAX_TRANS_DELAY) {
> +			pr_err("invalid transmission delay\n");
> +			return -EINVAL;
> +		}
> +
>   		if (map->bparam.node != NUMA_NO_NODE &&
>   		    !node_possible(map->bparam.node)) {
>   			pr_err("invalid numa node\n");
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 7065163a8388..dbf426e2fb7f 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -14,6 +14,7 @@
>   #define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
>   #define DMA_MAP_MAX_THREADS	1024
>   #define DMA_MAP_MAX_SECONDS     300
> +#define DMA_MAP_MAX_TRANS_DELAY	(10 * 1000 * 1000) /* 10ms */
>   
>   #define DMA_MAP_BIDIRECTIONAL	0
>   #define DMA_MAP_TO_DEVICE	1
> @@ -35,6 +36,7 @@ struct map_benchmark {
>   	__s32 node; /* which numa node this benchmark will run on */
>   	__u32 dma_bits; /* DMA addressing capability */
>   	__u32 dma_dir; /* DMA data direction */
> +	__u32 dma_trans_ns; /* delay for DMA transmission in ns */
>   	__u64 expansion[10];	/* For future use */
>   };
>   
> @@ -45,12 +47,12 @@ int main(int argc, char **argv)
>   	/* default single thread, run 20 seconds on NUMA_NO_NODE */
>   	int threads = 1, seconds = 20, node = -1;
>   	/* default dma mask 32bit, bidirectional DMA */
> -	int bits = 32, dir = DMA_MAP_BIDIRECTIONAL;
> +	int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
>   
>   	int cmd = DMA_MAP_BENCHMARK;
>   	char *p;
>   
> -	while ((opt = getopt(argc, argv, "t:s:n:b:d:")) != -1) {
> +	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:")) != -1) {
>   		switch (opt) {
>   		case 't':
>   			threads = atoi(optarg);
> @@ -67,6 +69,9 @@ int main(int argc, char **argv)
>   		case 'd':
>   			dir = atoi(optarg);
>   			break;
> +		case 'x':
> +			xdelay = atoi(optarg);
> +			break;
>   		default:
>   			return -1;
>   		}
> @@ -84,6 +89,12 @@ int main(int argc, char **argv)
>   		exit(1);
>   	}
>   
> +	if (xdelay < 0 || xdelay > DMA_MAP_MAX_TRANS_DELAY) {
> +		fprintf(stderr, "invalid transmit delay, must be in 0-%d\n",
> +			DMA_MAP_MAX_TRANS_DELAY);
> +		exit(1);
> +	}
> +
>   	/* suppose the mininum DMA zone is 1MB in the world */
>   	if (bits < 20 || bits > 64) {
>   		fprintf(stderr, "invalid dma mask bit, must be in 20-64\n");
> @@ -107,6 +118,8 @@ int main(int argc, char **argv)
>   	map.node = node;
>   	map.dma_bits = bits;
>   	map.dma_dir = dir;
> +	map.dma_trans_ns = xdelay;
> +
>   	if (ioctl(fd, cmd, &map)) {
>   		perror("ioctl");
>   		exit(1);
> 
