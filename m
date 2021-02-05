Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48639310291
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBECHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:07:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12029 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhBECHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:07:06 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWzJc4Y7YzjJKf;
        Fri,  5 Feb 2021 10:05:04 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.19) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 10:06:17 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <m.szyprowski@samsung.com>, <hch@lst.de>, <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
Date:   Fri, 5 Feb 2021 15:00:35 +1300
Message-ID: <20210205020035.25340-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.19]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a real dma mapping user case, after dma_map is done, data will be
transmit. Thus, in multi-threaded user scenario, IOMMU contention
should not be that severe. For example, if users enable multiple
threads to send network packets through 1G/10G/100Gbps NIC, usually
the steps will be: map -> transmission -> unmap.  Transmission delay
reduces the contention of IOMMU.

Here a delay is added to simulate the transmission between map and unmap
so that the tested result could be more accurate for TX and simple RX.
A typical TX transmission for NIC would be like: map -> TX -> unmap
since the socket buffers come from OS. Simple RX model eg. disk driver,
is also map -> RX -> unmap, but real RX model in a NIC could be more
complicated considering packets can come spontaneously and many drivers
are using pre-mapped buffers pool. This is in the TBD list.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2: cleanup according to Robin's feedback. thanks, Robin.

 kernel/dma/map_benchmark.c                    | 10 ++++++++++
 .../testing/selftests/dma/dma_map_benchmark.c | 19 +++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 1b1b8ff875cb..06636406a245 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -21,6 +21,7 @@
 #define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
 #define DMA_MAP_MAX_THREADS	1024
 #define DMA_MAP_MAX_SECONDS	300
+#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC) /* 10ms */
 
 #define DMA_MAP_BIDIRECTIONAL	0
 #define DMA_MAP_TO_DEVICE	1
@@ -36,6 +37,7 @@ struct map_benchmark {
 	__s32 node; /* which numa node this benchmark will run on */
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
+	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u64 expansion[10];	/* For future use */
 };
 
@@ -87,6 +89,9 @@ static int map_benchmark_thread(void *data)
 		map_etime = ktime_get();
 		map_delta = ktime_sub(map_etime, map_stime);
 
+		/* Pretend DMA is transmitting */
+		ndelay(map->bparam.dma_trans_ns);
+
 		unmap_stime = ktime_get();
 		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE, map->dir);
 		unmap_etime = ktime_get();
@@ -218,6 +223,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 		}
 
+		if (map->bparam.dma_trans_ns > DMA_MAP_MAX_TRANS_DELAY) {
+			pr_err("invalid transmission delay\n");
+			return -EINVAL;
+		}
+
 		if (map->bparam.node != NUMA_NO_NODE &&
 		    !node_possible(map->bparam.node)) {
 			pr_err("invalid numa node\n");
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index 7065163a8388..a370290d9503 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -11,9 +11,12 @@
 #include <sys/mman.h>
 #include <linux/types.h>
 
+#define NSEC_PER_MSEC	1000000L
+
 #define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
 #define DMA_MAP_MAX_THREADS	1024
 #define DMA_MAP_MAX_SECONDS     300
+#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC) /* 10ms */
 
 #define DMA_MAP_BIDIRECTIONAL	0
 #define DMA_MAP_TO_DEVICE	1
@@ -35,6 +38,7 @@ struct map_benchmark {
 	__s32 node; /* which numa node this benchmark will run on */
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
+	__u32 dma_trans_ns; /* delay for DMA transmission in ns */
 	__u64 expansion[10];	/* For future use */
 };
 
@@ -45,12 +49,12 @@ int main(int argc, char **argv)
 	/* default single thread, run 20 seconds on NUMA_NO_NODE */
 	int threads = 1, seconds = 20, node = -1;
 	/* default dma mask 32bit, bidirectional DMA */
-	int bits = 32, dir = DMA_MAP_BIDIRECTIONAL;
+	int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
 
 	int cmd = DMA_MAP_BENCHMARK;
 	char *p;
 
-	while ((opt = getopt(argc, argv, "t:s:n:b:d:")) != -1) {
+	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:")) != -1) {
 		switch (opt) {
 		case 't':
 			threads = atoi(optarg);
@@ -67,6 +71,9 @@ int main(int argc, char **argv)
 		case 'd':
 			dir = atoi(optarg);
 			break;
+		case 'x':
+			xdelay = atoi(optarg);
+			break;
 		default:
 			return -1;
 		}
@@ -84,6 +91,12 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (xdelay < 0 || xdelay > DMA_MAP_MAX_TRANS_DELAY) {
+		fprintf(stderr, "invalid transmit delay, must be in 0-%ld\n",
+			DMA_MAP_MAX_TRANS_DELAY);
+		exit(1);
+	}
+
 	/* suppose the mininum DMA zone is 1MB in the world */
 	if (bits < 20 || bits > 64) {
 		fprintf(stderr, "invalid dma mask bit, must be in 20-64\n");
@@ -107,6 +120,8 @@ int main(int argc, char **argv)
 	map.node = node;
 	map.dma_bits = bits;
 	map.dma_dir = dir;
+	map.dma_trans_ns = xdelay;
+
 	if (ioctl(fd, cmd, &map)) {
 		perror("ioctl");
 		exit(1);
-- 
2.25.1

