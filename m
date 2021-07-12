Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB45C3C4850
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhGLGhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 02:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbhGLGaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:30:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F034C028BA7;
        Sun, 11 Jul 2021 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=beM8fTJDPaLnKCeeGRk85GXcYvQNxhia1GMUUJGaUo8=; b=o2m4AAjPPOwEANBCECmW+IDLQl
        SCrxeIXMJkPAWxGKoQyPE70bdBKQSCgOmWgN+J+2z2C4uenkIrHK+Q83i4EmI5CQl40G1ULfC4Gpb
        mkjxKHO7+/C0hS3oWTqoKT6gSDjZPh1abW0pQvLE+2RuAw0HWddRWHZVc1c8vxGtnBltpXK2U671e
        CQwkjrxAwl+C6LUTMG5tR+NIjMa84o2lwVGH0/qoztBh2mloJD1mqMyrLRablFbBGeJdJOVqoDByD
        flvW0aCcJ3xtq7srGwc/1O20Gnol6iCihR5ual04IxxLfH95hYVP6MtMCiTySMvL1PO93JPVqg82t
        /UWUkW3Q==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2pGP-00Gx15-41; Mon, 12 Jul 2021 06:18:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Brian Cain <bcain@codeaurora.org>
Cc:     Dillon Min <dillon.minfei@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dma-direct: add support for dma_coherent_default_memory
Date:   Mon, 12 Jul 2021 08:16:58 +0200
Message-Id: <20210712061704.4162464-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712061704.4162464-1-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option to allocate uncached memory for dma_alloc_coherent from
the global dma_coherent_default_memory.  This will allow to move
arm-nommu (and eventually other platforms) to use generic code for
allocating uncached memory from a pre-populated pool.

Note that this is a different pool from the one that platforms that
can remap at runtime use for GFP_ATOMIC allocations for now, although
there might be opportunities to eventually end up with a common codebase
for the two use cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
---
 kernel/dma/Kconfig  |  4 ++++
 kernel/dma/direct.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 77b405508743..725cfd51762b 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -93,6 +93,10 @@ config DMA_COHERENT_POOL
 	select GENERIC_ALLOCATOR
 	bool
 
+config DMA_GLOBAL_POOL
+	select DMA_DECLARE_COHERENT
+	bool
+
 config DMA_REMAP
 	bool
 	depends on MMU
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f737e3347059..d1d0258ed6d0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -156,9 +156,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
 	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
 	    !dev_is_dma_coherent(dev))
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 
+	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	    !dev_is_dma_coherent(dev))
+		return dma_alloc_from_global_coherent(dev, size, dma_handle);
+
 	/*
 	 * Remapping or decrypting memory may block. If either is required and
 	 * we can't block, allocate the memory from the atomic pools.
@@ -255,11 +260,19 @@ void dma_direct_free(struct device *dev, size_t size,
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
 	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
 	    !dev_is_dma_coherent(dev)) {
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
 		return;
 	}
 
+	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	    !dev_is_dma_coherent(dev)) {
+		if (!dma_release_from_global_coherent(page_order, cpu_addr))
+			WARN_ON_ONCE(1);
+		return;
+	}
+
 	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
@@ -462,6 +475,8 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
+	if (dma_mmap_from_global_coherent(vma, cpu_addr, size, &ret))
+		return ret;
 
 	if (vma->vm_pgoff >= count || user_count > count - vma->vm_pgoff)
 		return -ENXIO;
-- 
2.30.2

