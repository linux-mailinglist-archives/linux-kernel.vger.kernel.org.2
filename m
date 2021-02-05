Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE46310A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBELnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:43:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11685 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhBELkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:40:08 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DXD1F3fFxzlH82;
        Fri,  5 Feb 2021 19:37:37 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.232) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 19:39:07 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <m.szyprowski@samsung.com>, <hch@lst.de>, <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v3 1/2] dma-mapping: benchmark: use u8 for reserved field in uAPI structure
Date:   Sat, 6 Feb 2021 00:33:24 +1300
Message-ID: <20210205113325.19556-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code put five u32 before a u64 expansion[10] array. Five is
odd, this will cause trouble in the extension of the structure by adding
new features. This patch moves to use u8 for reserved field to avoid
future alignment risk.
Meanwhile, it also clears the memory of struct map_benchmark in tools,
otherwise, if users use old version to run on newer kernel, the random
expansion value will cause side effect on newer kernel.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/dma/map_benchmark.c                      | 2 +-
 tools/testing/selftests/dma/dma_map_benchmark.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 1b1b8ff875cb..da95df381483 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -36,7 +36,7 @@ struct map_benchmark {
 	__s32 node; /* which numa node this benchmark will run on */
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
-	__u64 expansion[10];	/* For future use */
+	__u8 expansion[84];	/* For future use */
 };
 
 struct map_benchmark_data {
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index 7065163a8388..537d65968c48 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -6,6 +6,7 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
@@ -35,7 +36,7 @@ struct map_benchmark {
 	__s32 node; /* which numa node this benchmark will run on */
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
-	__u64 expansion[10];	/* For future use */
+	__u8 expansion[84];	/* For future use */
 };
 
 int main(int argc, char **argv)
@@ -102,6 +103,7 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	memset(&map, 0, sizeof(map));
 	map.seconds = seconds;
 	map.threads = threads;
 	map.node = node;
-- 
2.25.1

