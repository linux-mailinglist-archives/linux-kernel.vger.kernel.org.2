Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7E310651
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhBEII1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhBEIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:07:36 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D190C061794
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 00:06:30 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so3804818pfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 00:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGslspb5ZylZ8O2t/OXWAgcgjW5wijqWH0egOe8ik7I=;
        b=myIEhqRzrTikD8EItrnbeyf5x9l+O7Db+kYOX/uF/5YLTldD3qEiitvk/zymRNh1nf
         UdidOIpR8pxH9oBWs0ZimTUW2/nA4Nd2oNrtZSb+ybMj+Ee5VVbJ2S0PDYSJgV+7V+ij
         Y1xRIiFT8GDSh9M1dOyDVMcimak6xUOHE5hI3n6Ul8DMPdzK46MqqDIHXXS6d+IjwXDg
         yVOSYtiDkxpppCcR273ZVLICDotzauJ/m5GpvMWT6IHnqo1q9RmfxhgKE+xVvjqB+OrX
         iLbsppKzlvpOQ90V4hwOjKAwsWppvN+0Fra8i9u0M5rjaVbuPAjZWTSugG32ObW6kkoy
         zb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bGslspb5ZylZ8O2t/OXWAgcgjW5wijqWH0egOe8ik7I=;
        b=uXm9F/LkgP/W4UHqE1Fd0VANLS9S0zvytSC9NQV/JC8j28RIdSgTNJyM0oA0GKVaRQ
         wn5uSBTFunroiozti5zCilsjsADQZtjIOHXJ0n7fJGWLk/Td9REPq8rLhTu28c9wCxLL
         zgnArOlsLDTisTq/8uWTTIKMTbWV3uVhwr6jrTksk96XyXJ6IKyu8imC6snyauQnMcdJ
         0m7ZOK7sFx6P7SV3hOI+L7PKM0Yn4dhAcrIFB580rcgsObNV3eWueRJ6JNzM5XvPrpuV
         QqO44nIllMsC6Or9ibvhDULO41P3QOz8WY5eKwbBxgru+Kkb7j/CA0s3YoNSEkleootC
         acFg==
X-Gm-Message-State: AOAM5313vJrKUMgdtaLFrs9VhUVyIAKzc+RKqL0nlmU1cQm8n9kxVuYJ
        cCsKiFuefdCd3Clu1EzA9mhcTo/1YCdQCg==
X-Google-Smtp-Source: ABdhPJzU4JdgWWY9tKHhmR96s6DGwgFRranOd/IzqxxC3jYaykmK4MxZFD94Gt6pxtBeA1R3QeiLbA==
X-Received: by 2002:a62:19d1:0:b029:1d7:f8f2:7b04 with SMTP id 200-20020a6219d10000b02901d7f8f27b04mr1403660pfz.10.1612512389229;
        Fri, 05 Feb 2021 00:06:29 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 32sm9520070pgq.80.2021.02.05.00.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 00:06:28 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH v6 2/7] drm: ttm_pool: Rename the ttm_pool_dma structure to ttm_pool_page_dat
Date:   Fri,  5 Feb 2021 08:06:16 +0000
Message-Id: <20210205080621.3102035-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205080621.3102035-1-john.stultz@linaro.org>
References: <20210205080621.3102035-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simply renames the ttm_pool_dma structure to
ttm_pool_page_dat, as we will extend it to store more then just
dma related info in it.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Ørjan Eide <orjan.eide@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: James Jones <jajones@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 37 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 11e0313db0ea..c0274e256be3 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -37,18 +37,17 @@
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
 #endif
-
 #include <drm/ttm/ttm_pool.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_tt.h>
 
 /**
- * struct ttm_pool_dma - Helper object for coherent DMA mappings
+ * struct ttm_pool_page_dat - Helper object for coherent DMA mappings
  *
  * @addr: original DMA address returned for the mapping
  * @vaddr: original vaddr return for the mapping and order in the lower bits
  */
-struct ttm_pool_dma {
+struct ttm_pool_page_dat {
 	dma_addr_t addr;
 	unsigned long vaddr;
 };
@@ -75,7 +74,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 					unsigned int order)
 {
 	unsigned long attr = DMA_ATTR_FORCE_CONTIGUOUS;
-	struct ttm_pool_dma *dma;
+	struct ttm_pool_page_dat *dat;
 	struct page *p;
 	void *vaddr;
 
@@ -94,15 +93,15 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 		return p;
 	}
 
-	dma = kmalloc(sizeof(*dma), GFP_KERNEL);
-	if (!dma)
+	dat = kmalloc(sizeof(*dat), GFP_KERNEL);
+	if (!dat)
 		return NULL;
 
 	if (order)
 		attr |= DMA_ATTR_NO_WARN;
 
 	vaddr = dma_alloc_attrs(pool->dev, (1ULL << order) * PAGE_SIZE,
-				&dma->addr, gfp_flags, attr);
+				&dat->addr, gfp_flags, attr);
 	if (!vaddr)
 		goto error_free;
 
@@ -114,12 +113,12 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	else
 		p = virt_to_page(vaddr);
 
-	dma->vaddr = (unsigned long)vaddr | order;
-	p->private = (unsigned long)dma;
+	dat->vaddr = (unsigned long)vaddr | order;
+	p->private = (unsigned long)dat;
 	return p;
 
 error_free:
-	kfree(dma);
+	kfree(dat);
 	return NULL;
 }
 
@@ -128,7 +127,7 @@ static void ttm_pool_free_page(struct ttm_pool *pool, enum ttm_caching caching,
 			       unsigned int order, struct page *p)
 {
 	unsigned long attr = DMA_ATTR_FORCE_CONTIGUOUS;
-	struct ttm_pool_dma *dma;
+	struct ttm_pool_page_dat *dat;
 	void *vaddr;
 
 #ifdef CONFIG_X86
@@ -147,11 +146,11 @@ static void ttm_pool_free_page(struct ttm_pool *pool, enum ttm_caching caching,
 	if (order)
 		attr |= DMA_ATTR_NO_WARN;
 
-	dma = (void *)p->private;
-	vaddr = (void *)(dma->vaddr & PAGE_MASK);
-	dma_free_attrs(pool->dev, (1UL << order) * PAGE_SIZE, vaddr, dma->addr,
+	dat = (void *)p->private;
+	vaddr = (void *)(dat->vaddr & PAGE_MASK);
+	dma_free_attrs(pool->dev, (1UL << order) * PAGE_SIZE, vaddr, dat->addr,
 		       attr);
-	kfree(dma);
+	kfree(dat);
 }
 
 /* Apply a new caching to an array of pages */
@@ -184,9 +183,9 @@ static int ttm_pool_map(struct ttm_pool *pool, unsigned int order,
 	unsigned int i;
 
 	if (pool->use_dma_alloc) {
-		struct ttm_pool_dma *dma = (void *)p->private;
+		struct ttm_pool_page_dat *dat = (void *)p->private;
 
-		addr = dma->addr;
+		addr = dat->addr;
 	} else {
 		size_t size = (1ULL << order) * PAGE_SIZE;
 
@@ -324,9 +323,9 @@ static unsigned int ttm_pool_shrink(void)
 static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
 {
 	if (pool->use_dma_alloc) {
-		struct ttm_pool_dma *dma = (void *)p->private;
+		struct ttm_pool_page_dat *dat = (void *)p->private;
 
-		return dma->vaddr & ~PAGE_MASK;
+		return dat->vaddr & ~PAGE_MASK;
 	}
 
 	return p->private;
-- 
2.25.1

