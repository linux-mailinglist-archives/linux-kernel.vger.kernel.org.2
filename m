Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC192438B0A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhJXRmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 13:42:51 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:49506 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhJXRms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:42:48 -0400
Received: from pop-os.home ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id ehTsmakZrdmYbehTsmLbF2; Sun, 24 Oct 2021 19:40:26 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 24 Oct 2021 19:40:26 +0200
X-ME-IP: 92.140.161.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dma-mapping: Use 'bitmap_zalloc()' when applicable
Date:   Sun, 24 Oct 2021 19:40:23 +0200
Message-Id: <20976d6fd4af266dec589b40929b53dfddd64b75.1635097161.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dma_mem->bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
improve the semantic and avoid some open-coded arithmetic in allocator
arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 kernel/dma/coherent.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 25fc85a7aebe..375fb3c9538d 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -40,7 +40,6 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 {
 	struct dma_coherent_mem *dma_mem;
 	int pages = size >> PAGE_SHIFT;
-	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 	void *mem_base;
 
 	if (!size)
@@ -53,7 +52,7 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
 	if (!dma_mem)
 		goto out_unmap_membase;
-	dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
+	dma_mem->bitmap = bitmap_zalloc(pages, GFP_KERNEL);
 	if (!dma_mem->bitmap)
 		goto out_free_dma_mem;
 
@@ -81,7 +80,7 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
 		return;
 
 	memunmap(mem->virt_base);
-	kfree(mem->bitmap);
+	bitmap_free(mem->bitmap);
 	kfree(mem);
 }
 
-- 
2.30.2

