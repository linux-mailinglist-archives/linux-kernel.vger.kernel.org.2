Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF669345F44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhCWNPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231479AbhCWNO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:14:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52E7C61994;
        Tue, 23 Mar 2021 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616505266;
        bh=VE4+YI2xIAIgMpAU9ZesbWu5To4HS1xvaH16j+iZa50=;
        h=From:To:Cc:Subject:Date:From;
        b=iBNiCVwRwpezP+rQRhalfZ3VsBExuWHJcVNxlqelqwizqnNOQ/EzG/GvSnRSpQiAG
         iCuQWhABkn4uxP8U473s/2qr+ceNF7ydi17brd48Bmlz2Jhh+AUBN8ryACuEPxrgIP
         9kCUUktvahRE0FziRhTMCobhVp1ICs68l1Oe8oUAPDCmZoLzjcyaQg9WdL8XCU7sa4
         asEAo1xCOxqkay8VPWyD13khabDTvE1NaflRR0HY7PZMVHgtyVZSnSIIyLB6Gpfro3
         qwd8EQk3q74/uLzNc9BKraiT4X7jEU4HjPiBcjw2uftKI2TBgIP6wXQecvKb0PptBw
         gvB8M5PrUUqNg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dma-mapping: fix out of bounds access in CMA
Date:   Tue, 23 Mar 2021 14:14:13 +0100
Message-Id: <20210323131423.2581218-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Dereferencing a zero-length array is always a bug, and we get a warning
with 'make W=1' here:

arch/arm/mm/dma-mapping.c: In function 'dma_contiguous_early_fixup':
arch/arm/mm/dma-mapping.c:395:15: error: array subscript <unknown> is outside array bounds of 'struct dma_contig_early_reserve[0]' [-Werror=array-bounds]
  395 |  dma_mmu_remap[dma_mmu_remap_num].base = base;
      |  ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
arch/arm/mm/dma-mapping.c:389:40: note: while referencing 'dma_mmu_remap'
  389 | static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;
      |                                        ^~~~~~~~~~~~~
arch/arm/mm/dma-mapping.c:396:15: error: array subscript <unknown> is outside array bounds of 'struct dma_contig_early_reserve[0]' [-Werror=array-bounds]

Add a runtime check to prevent this from happening, while also
avoiding the compile-time warning.

Fixes: c79095092834 ("ARM: integrate CMA with DMA-mapping subsystem")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/dma-mapping.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c4b8df2ad328..af29344fb150 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -392,6 +392,11 @@ static int dma_mmu_remap_num __initdata;
 
 void __init dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
 {
+	if (!MAX_CMA_AREAS || dma_mmu_remap_num >= MAX_CMA_AREAS) {
+		WARN_ONCE(1, "number of CMA areas\n");
+		return;
+	}
+
 	dma_mmu_remap[dma_mmu_remap_num].base = base;
 	dma_mmu_remap[dma_mmu_remap_num].size = size;
 	dma_mmu_remap_num++;
@@ -400,6 +405,10 @@ void __init dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
 void __init dma_contiguous_remap(void)
 {
 	int i;
+
+	if (!MAX_CMA_AREAS)
+		return;
+
 	for (i = 0; i < dma_mmu_remap_num; i++) {
 		phys_addr_t start = dma_mmu_remap[i].base;
 		phys_addr_t end = start + dma_mmu_remap[i].size;
-- 
2.29.2

