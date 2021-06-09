Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C863A10FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbhFIKZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbhFIKZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:25:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395DC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 03:23:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i10so37197750lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhWAyGJlD9+p8kZdXnATTRilEKnyA/MqjWkRehoUA4I=;
        b=HkR1xQNwqeMiqx+NVLs27b5+ZwFRXlx3p4+D5B97yjrlxWl/Gu697qXa4pfLF8m3Zq
         L+nDmXZJilwnb7BCkllXyOAMQfHJdvC/TkdYe1KHcOUhxXg9iPWy+7Ycu6sZrYlerNtL
         BCOeGDWhYAjtH1K+4pPYzBFiIoZTb4HXVstVwsv78j6k/kkx34XNMsCePDku14RFSyNr
         JL/IDgS2JfzBJY78E9v0JPHYsnF9Jyb+QLC+SSOD5vzwllQeBIn9TBhWZ+XlRyT6Jyxd
         KIcpY1mZUt0ZCegWKGQmnib/Kwj3oQBUjI78m/3lFF+1qML/LZJyNLMir3zGGEuL1mT8
         RQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhWAyGJlD9+p8kZdXnATTRilEKnyA/MqjWkRehoUA4I=;
        b=taF6oCJD8fwm+6hMLhYYxHXe0kOaNK1xKXRcr4U91zEW0P7XYll1gGlXB6WWtOy8PP
         RHmpt9MM+y7raniXn8cgh1p8fvREsZ/9xo3S36WuWqG/Mrz9FJDYQq8w0Zr5rrSDIDDf
         jMsLjr1ZtG2WcpQx4aaYdUVRyvySmiy4Tb5IRhJBTvIVIxc+HOt1oD5lqnZH3BOXn2mi
         qt0SxmDLxMxXWClb7IQobu/3jjwr+OEQkh5aR1IBePu6ZnfXLa9734JhrcOcXpHiqYvs
         0Kw2R7Grcja/tw3RyN1BRUQtve/2AhN9WYtV/Oin7RWB0MDipw8dc/OEg8v+IRWLqzaX
         6TzQ==
X-Gm-Message-State: AOAM5322urndJuSqLcfdaaajmiCqMPq90TFwUQ7+intmWIn7Iva2d0jf
        jKLVdA6iX9hro38id1f0bST5fOnNp6c0/JLK
X-Google-Smtp-Source: ABdhPJxLbMg0oh/XLFRzv20keBFEszS5O6B13TgT112e9SXICx8Tp6ARGbiMsBOoE20bmuQG31c4ng==
X-Received: by 2002:a05:6512:3287:: with SMTP id p7mr17886650lfe.213.1623234219190;
        Wed, 09 Jun 2021 03:23:39 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m4sm302966ljp.9.2021.06.09.03.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:23:38 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 2/7] tee: simplify shm pool handling
Date:   Wed,  9 Jun 2021 12:23:19 +0200
Message-Id: <20210609102324.2222332-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609102324.2222332-1-jens.wiklander@linaro.org>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces the shared memory pool based on two pools with a single pool.
The alloc() function pointer in struct tee_shm_pool_ops gets another
parameter, align. This makes it possible to make less than page aligned
allocations from the optional reserved shared memory pool while still
making user space allocations page aligned. With in practice unchanged
behaviour using only a single pool for bookkeeping.

The optee and amdtee drivers are updated as needed to work with this
changed pool handling.

This also removes OPTEE_SHM_NUM_PRIV_PAGES which becomes obsolete with
this change as the private pages can be mixed with the payload pages.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/amdtee/shm_pool.c |  55 ++++++------------
 drivers/tee/optee/Kconfig     |   8 ---
 drivers/tee/optee/core.c      |  72 +++--------------------
 drivers/tee/optee/shm_pool.c  |  51 ++++++++++-------
 drivers/tee/optee/shm_pool.h  |   2 +-
 drivers/tee/tee_private.h     |  11 ----
 drivers/tee/tee_shm.c         |  29 +++++-----
 drivers/tee/tee_shm_pool.c    | 104 +++++++++++-----------------------
 include/linux/tee_drv.h       |  58 +++++++------------
 9 files changed, 120 insertions(+), 270 deletions(-)

diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
index 065854e2db18..81c23f30b455 100644
--- a/drivers/tee/amdtee/shm_pool.c
+++ b/drivers/tee/amdtee/shm_pool.c
@@ -8,13 +8,17 @@
 #include <linux/psp-sev.h>
 #include "amdtee_private.h"
 
-static int pool_op_alloc(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm,
-			 size_t size)
+static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
+			 size_t size, u_int align)
 {
 	unsigned int order = get_order(size);
 	unsigned long va;
 	int rc;
 
+	/*
+	 * Ignore alignment since this is already going to be page aligned
+	 * and there's no need for any larger alignment.
+	 */
 	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!va)
 		return -ENOMEM;
@@ -34,7 +38,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm,
 	return 0;
 }
 
-static void pool_op_free(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm)
+static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
 {
 	/* Unmap the shared memory from TEE */
 	amdtee_unmap_shmem(shm);
@@ -42,52 +46,25 @@ static void pool_op_free(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm)
 	shm->kaddr = NULL;
 }
 
-static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
+static void pool_op_destroy_pool(struct tee_shm_pool *pool)
 {
-	kfree(poolm);
+	kfree(pool);
 }
 
-static const struct tee_shm_pool_mgr_ops pool_ops = {
+static const struct tee_shm_pool_ops pool_ops = {
 	.alloc = pool_op_alloc,
 	.free = pool_op_free,
-	.destroy_poolmgr = pool_op_destroy_poolmgr,
+	.destroy_pool = pool_op_destroy_pool,
 };
 
-static struct tee_shm_pool_mgr *pool_mem_mgr_alloc(void)
-{
-	struct tee_shm_pool_mgr *mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
-
-	if (!mgr)
-		return ERR_PTR(-ENOMEM);
-
-	mgr->ops = &pool_ops;
-
-	return mgr;
-}
-
 struct tee_shm_pool *amdtee_config_shm(void)
 {
-	struct tee_shm_pool_mgr *priv_mgr;
-	struct tee_shm_pool_mgr *dmabuf_mgr;
-	void *rc;
+	struct tee_shm_pool *pool = kzalloc(sizeof(*pool), GFP_KERNEL);
 
-	rc = pool_mem_mgr_alloc();
-	if (IS_ERR(rc))
-		return rc;
-	priv_mgr = rc;
-
-	rc = pool_mem_mgr_alloc();
-	if (IS_ERR(rc)) {
-		tee_shm_pool_mgr_destroy(priv_mgr);
-		return rc;
-	}
-	dmabuf_mgr = rc;
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
 
-	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
-	if (IS_ERR(rc)) {
-		tee_shm_pool_mgr_destroy(priv_mgr);
-		tee_shm_pool_mgr_destroy(dmabuf_mgr);
-	}
+	pool->ops = &pool_ops;
 
-	return rc;
+	return pool;
 }
diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 3ca71e3812ed..f121c224e682 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -7,11 +7,3 @@ config OPTEE
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
-
-config OPTEE_SHM_NUM_PRIV_PAGES
-	int "Private Shared Memory Pages"
-	default 1
-	depends on OPTEE
-	help
-	  This sets the number of private shared memory pages to be
-	  used by OP-TEE TEE driver.
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index ddb8f9ecf307..0c287345f9fe 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -428,33 +428,6 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 	return true;
 }
 
-static struct tee_shm_pool *optee_config_dyn_shm(void)
-{
-	struct tee_shm_pool_mgr *priv_mgr;
-	struct tee_shm_pool_mgr *dmabuf_mgr;
-	void *rc;
-
-	rc = optee_shm_pool_alloc_pages();
-	if (IS_ERR(rc))
-		return rc;
-	priv_mgr = rc;
-
-	rc = optee_shm_pool_alloc_pages();
-	if (IS_ERR(rc)) {
-		tee_shm_pool_mgr_destroy(priv_mgr);
-		return rc;
-	}
-	dmabuf_mgr = rc;
-
-	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
-	if (IS_ERR(rc)) {
-		tee_shm_pool_mgr_destroy(priv_mgr);
-		tee_shm_pool_mgr_destroy(dmabuf_mgr);
-	}
-
-	return rc;
-}
-
 static struct tee_shm_pool *
 optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
 {
@@ -468,10 +441,7 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
 	phys_addr_t begin;
 	phys_addr_t end;
 	void *va;
-	struct tee_shm_pool_mgr *priv_mgr;
-	struct tee_shm_pool_mgr *dmabuf_mgr;
 	void *rc;
-	const int sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
 
 	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
 	if (res.result.status != OPTEE_SMC_RETURN_OK) {
@@ -489,11 +459,6 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
 	paddr = begin;
 	size = end - begin;
 
-	if (size < 2 * OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE) {
-		pr_err("too small shared memory area\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	va = memremap(paddr, size, MEMREMAP_WB);
 	if (!va) {
 		pr_err("shared memory ioremap failed\n");
@@ -501,35 +466,13 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
 	}
 	vaddr = (unsigned long)va;
 
-	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
-					    3 /* 8 bytes aligned */);
-	if (IS_ERR(rc))
-		goto err_memunmap;
-	priv_mgr = rc;
-
-	vaddr += sz;
-	paddr += sz;
-	size -= sz;
-
-	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
+	rc = tee_shm_pool_alloc_res_mem(vaddr, paddr, size,
+					9 /* 512 bytes aligned */);
 	if (IS_ERR(rc))
-		goto err_free_priv_mgr;
-	dmabuf_mgr = rc;
-
-	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
-	if (IS_ERR(rc))
-		goto err_free_dmabuf_mgr;
-
-	*memremaped_shm = va;
-
-	return rc;
+		memunmap(va);
+	else
+		*memremaped_shm = va;
 
-err_free_dmabuf_mgr:
-	tee_shm_pool_mgr_destroy(dmabuf_mgr);
-err_free_priv_mgr:
-	tee_shm_pool_mgr_destroy(priv_mgr);
-err_memunmap:
-	memunmap(va);
 	return rc;
 }
 
@@ -637,7 +580,7 @@ static int optee_probe(struct platform_device *pdev)
 	 * Try to use dynamic shared memory if possible
 	 */
 	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
-		pool = optee_config_dyn_shm();
+		pool = optee_shm_pool_alloc_pages();
 
 	/*
 	 * If dynamic shared memory is not available or failed - try static one
@@ -712,8 +655,7 @@ static int optee_probe(struct platform_device *pdev)
 		tee_device_unregister(optee->teedev);
 		kfree(optee);
 	}
-	if (pool)
-		tee_shm_pool_free(pool);
+	tee_shm_pool_free(pool);
 	if (memremaped_shm)
 		memunmap(memremaped_shm);
 	return rc;
diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index d767eebf30bd..b036714845c1 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -12,13 +12,17 @@
 #include "optee_smc.h"
 #include "shm_pool.h"
 
-static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
-			 struct tee_shm *shm, size_t size)
+static int pool_op_alloc(struct tee_shm_pool *pool,
+			 struct tee_shm *shm, size_t size, u_int align)
 {
 	unsigned int order = get_order(size);
 	struct page *page;
 	int rc = 0;
 
+	/*
+	 * Ignore alignment since this is already going to be page aligned
+	 * and there's no need for any larger alignment.
+	 */
 	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!page)
 		return -ENOMEM;
@@ -27,47 +31,52 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 	shm->paddr = page_to_phys(page);
 	shm->size = PAGE_SIZE << order;
 
-	if (shm->flags & TEE_SHM_DMA_BUF) {
+	if (shm->flags & TEE_SHM_REGISTER) {
 		unsigned int nr_pages = 1 << order, i;
 		struct page **pages;
 
 		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
-		if (!pages)
-			return -ENOMEM;
-
-		for (i = 0; i < nr_pages; i++) {
-			pages[i] = page;
-			page++;
+		if (!pages) {
+			rc = -ENOMEM;
+			goto err;
 		}
 
-		shm->flags |= TEE_SHM_REGISTER;
+		for (i = 0; i < nr_pages; i++)
+			pages[i] = page + i;
+
 		rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
 					(unsigned long)shm->kaddr);
 		kfree(pages);
+		if (rc)
+			goto err;
 	}
 
+	return 0;
+
+err:
+	free_pages((unsigned long)shm->kaddr, order);
 	return rc;
 }
 
-static void pool_op_free(struct tee_shm_pool_mgr *poolm,
+static void pool_op_free(struct tee_shm_pool *pool,
 			 struct tee_shm *shm)
 {
-	if (shm->flags & TEE_SHM_DMA_BUF)
+	if (shm->flags & TEE_SHM_REGISTER)
 		optee_shm_unregister(shm->ctx, shm);
 
 	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
 	shm->kaddr = NULL;
 }
 
-static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
+static void pool_op_destroy_pool(struct tee_shm_pool *pool)
 {
-	kfree(poolm);
+	kfree(pool);
 }
 
-static const struct tee_shm_pool_mgr_ops pool_ops = {
+static const struct tee_shm_pool_ops pool_ops = {
 	.alloc = pool_op_alloc,
 	.free = pool_op_free,
-	.destroy_poolmgr = pool_op_destroy_poolmgr,
+	.destroy_pool = pool_op_destroy_pool,
 };
 
 /**
@@ -76,14 +85,14 @@ static const struct tee_shm_pool_mgr_ops pool_ops = {
  * This pool is used when OP-TEE supports dymanic SHM. In this case
  * command buffers and such are allocated from kernel's own memory.
  */
-struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void)
+struct tee_shm_pool *optee_shm_pool_alloc_pages(void)
 {
-	struct tee_shm_pool_mgr *mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+	struct tee_shm_pool *pool = kzalloc(sizeof(*pool), GFP_KERNEL);
 
-	if (!mgr)
+	if (!pool)
 		return ERR_PTR(-ENOMEM);
 
-	mgr->ops = &pool_ops;
+	pool->ops = &pool_ops;
 
-	return mgr;
+	return pool;
 }
diff --git a/drivers/tee/optee/shm_pool.h b/drivers/tee/optee/shm_pool.h
index 28109d991c4b..7024b9926ada 100644
--- a/drivers/tee/optee/shm_pool.h
+++ b/drivers/tee/optee/shm_pool.h
@@ -9,6 +9,6 @@
 
 #include <linux/tee_drv.h>
 
-struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void);
+struct tee_shm_pool *optee_shm_pool_alloc_pages(void);
 
 #endif
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index e55204df31ce..72376cf38bc0 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -12,17 +12,6 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
-/**
- * struct tee_shm_pool - shared memory pool
- * @private_mgr:	pool manager for shared memory only between kernel
- *			and secure world
- * @dma_buf_mgr:	pool manager for shared memory exported to user space
- */
-struct tee_shm_pool {
-	struct tee_shm_pool_mgr *private_mgr;
-	struct tee_shm_pool_mgr *dma_buf_mgr;
-};
-
 #define TEE_DEVICE_FLAG_REGISTERED	0x1
 #define TEE_MAX_DEV_NAME_LEN		32
 
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 00472f5ce22e..b9dbf4bce149 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -39,14 +39,7 @@ static void tee_shm_release(struct tee_shm *shm)
 	}
 
 	if (shm->flags & TEE_SHM_POOL) {
-		struct tee_shm_pool_mgr *poolm;
-
-		if (shm->flags & TEE_SHM_DMA_BUF)
-			poolm = teedev->pool->dma_buf_mgr;
-		else
-			poolm = teedev->pool->private_mgr;
-
-		poolm->ops->free(poolm, shm);
+		teedev->pool->ops->free(teedev->pool, shm);
 	} else if (shm->flags & TEE_SHM_REGISTER) {
 		int rc = teedev->desc->ops->shm_unregister(shm->ctx, shm);
 
@@ -106,8 +99,8 @@ static const struct dma_buf_ops tee_shm_dma_buf_ops = {
 struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 {
 	struct tee_device *teedev = ctx->teedev;
-	struct tee_shm_pool_mgr *poolm = NULL;
 	struct tee_shm *shm;
+	size_t align;
 	void *ret;
 	int rc;
 
@@ -139,12 +132,18 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 
 	shm->flags = flags | TEE_SHM_POOL;
 	shm->ctx = ctx;
-	if (flags & TEE_SHM_DMA_BUF)
-		poolm = teedev->pool->dma_buf_mgr;
-	else
-		poolm = teedev->pool->private_mgr;
+	if (flags & TEE_SHM_DMA_BUF) {
+		align = PAGE_SIZE;
+		/*
+		 * Request to register the shm in the pool allocator below
+		 * if supported.
+		 */
+		shm->flags |= TEE_SHM_REGISTER;
+	} else {
+		align = 2 * sizeof(long);
+	}
 
-	rc = poolm->ops->alloc(poolm, shm, size);
+	rc = teedev->pool->ops->alloc(teedev->pool, shm, size, align);
 	if (rc) {
 		ret = ERR_PTR(rc);
 		goto err_kfree;
@@ -184,7 +183,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 		mutex_unlock(&teedev->mutex);
 	}
 err_pool_free:
-	poolm->ops->free(poolm, shm);
+	teedev->pool->ops->free(teedev->pool, shm);
 err_kfree:
 	kfree(shm);
 err_dev_put:
diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
index a9f9d50fd181..5ceab73ff1b5 100644
--- a/drivers/tee/tee_shm_pool.c
+++ b/drivers/tee/tee_shm_pool.c
@@ -9,14 +9,16 @@
 #include <linux/tee_drv.h>
 #include "tee_private.h"
 
-static int pool_op_gen_alloc(struct tee_shm_pool_mgr *poolm,
-			     struct tee_shm *shm, size_t size)
+static int pool_op_gen_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
+			     size_t size, u_int align)
 {
 	unsigned long va;
-	struct gen_pool *genpool = poolm->private_data;
-	size_t s = roundup(size, 1 << genpool->min_alloc_order);
+	struct gen_pool *genpool = pool->private_data;
+	size_t a = max(align, 1U << genpool->min_alloc_order);
+	struct genpool_data_align data = { .align = a };
+	size_t s = roundup(size, a);
 
-	va = gen_pool_alloc(genpool, s);
+	va = gen_pool_alloc_algo(genpool, s, gen_pool_first_fit_align, &data);
 	if (!va)
 		return -ENOMEM;
 
@@ -24,107 +26,67 @@ static int pool_op_gen_alloc(struct tee_shm_pool_mgr *poolm,
 	shm->kaddr = (void *)va;
 	shm->paddr = gen_pool_virt_to_phys(genpool, va);
 	shm->size = s;
+	/*
+	 * This is from a static shared memory pool so no need to register
+	 * each chunk, and no need to unregister later either.
+	 */
+	shm->flags &= ~TEE_SHM_REGISTER;
 	return 0;
 }
 
-static void pool_op_gen_free(struct tee_shm_pool_mgr *poolm,
-			     struct tee_shm *shm)
+static void pool_op_gen_free(struct tee_shm_pool *pool, struct tee_shm *shm)
 {
-	gen_pool_free(poolm->private_data, (unsigned long)shm->kaddr,
+	gen_pool_free(pool->private_data, (unsigned long)shm->kaddr,
 		      shm->size);
 	shm->kaddr = NULL;
 }
 
-static void pool_op_gen_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
+static void pool_op_gen_destroy_pool(struct tee_shm_pool *pool)
 {
-	gen_pool_destroy(poolm->private_data);
-	kfree(poolm);
+	gen_pool_destroy(pool->private_data);
+	kfree(pool);
 }
 
-static const struct tee_shm_pool_mgr_ops pool_ops_generic = {
+static const struct tee_shm_pool_ops pool_ops_generic = {
 	.alloc = pool_op_gen_alloc,
 	.free = pool_op_gen_free,
-	.destroy_poolmgr = pool_op_gen_destroy_poolmgr,
+	.destroy_pool = pool_op_gen_destroy_pool,
 };
 
-struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long vaddr,
-							phys_addr_t paddr,
-							size_t size,
-							int min_alloc_order)
+struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
+						phys_addr_t paddr, size_t size,
+						int min_alloc_order)
 {
 	const size_t page_mask = PAGE_SIZE - 1;
-	struct tee_shm_pool_mgr *mgr;
+	struct tee_shm_pool *pool;
 	int rc;
 
 	/* Start and end must be page aligned */
 	if (vaddr & page_mask || paddr & page_mask || size & page_mask)
 		return ERR_PTR(-EINVAL);
 
-	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
-	if (!mgr)
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
 		return ERR_PTR(-ENOMEM);
 
-	mgr->private_data = gen_pool_create(min_alloc_order, -1);
-	if (!mgr->private_data) {
+	pool->private_data = gen_pool_create(min_alloc_order, -1);
+	if (!pool->private_data) {
 		rc = -ENOMEM;
 		goto err;
 	}
 
-	gen_pool_set_algo(mgr->private_data, gen_pool_best_fit, NULL);
-	rc = gen_pool_add_virt(mgr->private_data, vaddr, paddr, size, -1);
+	rc = gen_pool_add_virt(pool->private_data, vaddr, paddr, size, -1);
 	if (rc) {
-		gen_pool_destroy(mgr->private_data);
+		gen_pool_destroy(pool->private_data);
 		goto err;
 	}
 
-	mgr->ops = &pool_ops_generic;
+	pool->ops = &pool_ops_generic;
 
-	return mgr;
+	return pool;
 err:
-	kfree(mgr);
+	kfree(pool);
 
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_GPL(tee_shm_pool_mgr_alloc_res_mem);
-
-static bool check_mgr_ops(struct tee_shm_pool_mgr *mgr)
-{
-	return mgr && mgr->ops && mgr->ops->alloc && mgr->ops->free &&
-		mgr->ops->destroy_poolmgr;
-}
-
-struct tee_shm_pool *tee_shm_pool_alloc(struct tee_shm_pool_mgr *priv_mgr,
-					struct tee_shm_pool_mgr *dmabuf_mgr)
-{
-	struct tee_shm_pool *pool;
-
-	if (!check_mgr_ops(priv_mgr) || !check_mgr_ops(dmabuf_mgr))
-		return ERR_PTR(-EINVAL);
-
-	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
-	if (!pool)
-		return ERR_PTR(-ENOMEM);
-
-	pool->private_mgr = priv_mgr;
-	pool->dma_buf_mgr = dmabuf_mgr;
-
-	return pool;
-}
-EXPORT_SYMBOL_GPL(tee_shm_pool_alloc);
-
-/**
- * tee_shm_pool_free() - Free a shared memory pool
- * @pool:	The shared memory pool to free
- *
- * There must be no remaining shared memory allocated from this pool when
- * this function is called.
- */
-void tee_shm_pool_free(struct tee_shm_pool *pool)
-{
-	if (pool->private_mgr)
-		tee_shm_pool_mgr_destroy(pool->private_mgr);
-	if (pool->dma_buf_mgr)
-		tee_shm_pool_mgr_destroy(pool->dma_buf_mgr);
-	kfree(pool);
-}
-EXPORT_SYMBOL_GPL(tee_shm_pool_free);
+EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_res_mem);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 53b9b2a13a87..62b7c7a55743 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -215,62 +215,39 @@ struct tee_shm {
 };
 
 /**
- * struct tee_shm_pool_mgr - shared memory manager
+ * struct tee_shm_pool - shared memory pool
  * @ops:		operations
  * @private_data:	private data for the shared memory manager
  */
-struct tee_shm_pool_mgr {
-	const struct tee_shm_pool_mgr_ops *ops;
+struct tee_shm_pool {
+	const struct tee_shm_pool_ops *ops;
 	void *private_data;
 };
 
 /**
- * struct tee_shm_pool_mgr_ops - shared memory pool manager operations
+ * struct tee_shm_pool_ops - shared memory pool operations
  * @alloc:		called when allocating shared memory
  * @free:		called when freeing shared memory
- * @destroy_poolmgr:	called when destroying the pool manager
+ * @destroy_pool:	called when destroying the pool
  */
-struct tee_shm_pool_mgr_ops {
-	int (*alloc)(struct tee_shm_pool_mgr *poolmgr, struct tee_shm *shm,
-		     size_t size);
-	void (*free)(struct tee_shm_pool_mgr *poolmgr, struct tee_shm *shm);
-	void (*destroy_poolmgr)(struct tee_shm_pool_mgr *poolmgr);
+struct tee_shm_pool_ops {
+	int (*alloc)(struct tee_shm_pool *pool, struct tee_shm *shm,
+		     size_t size, u_int align);
+	void (*free)(struct tee_shm_pool *pool, struct tee_shm *shm);
+	void (*destroy_pool)(struct tee_shm_pool *pool);
 };
 
-/**
- * tee_shm_pool_alloc() - Create a shared memory pool from shm managers
- * @priv_mgr:	manager for driver private shared memory allocations
- * @dmabuf_mgr:	manager for dma-buf shared memory allocations
- *
- * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
- * in @dmabuf, others will use the range provided by @priv.
- *
- * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
- */
-struct tee_shm_pool *tee_shm_pool_alloc(struct tee_shm_pool_mgr *priv_mgr,
-					struct tee_shm_pool_mgr *dmabuf_mgr);
-
 /*
- * tee_shm_pool_mgr_alloc_res_mem() - Create a shm manager for reserved
- * memory
+ * tee_shm_pool_alloc_res_mem() - Create a shm manager for reserved memory
  * @vaddr:	Virtual address of start of pool
  * @paddr:	Physical address of start of pool
  * @size:	Size in bytes of the pool
  *
- * @returns pointer to a 'struct tee_shm_pool_mgr' or an ERR_PTR on failure.
- */
-struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long vaddr,
-							phys_addr_t paddr,
-							size_t size,
-							int min_alloc_order);
-
-/**
- * tee_shm_pool_mgr_destroy() - Free a shared memory manager
+ * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
  */
-static inline void tee_shm_pool_mgr_destroy(struct tee_shm_pool_mgr *poolm)
-{
-	poolm->ops->destroy_poolmgr(poolm);
-}
+struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
+						phys_addr_t paddr, size_t size,
+						int min_alloc_order);
 
 /**
  * tee_shm_pool_free() - Free a shared memory pool
@@ -279,7 +256,10 @@ static inline void tee_shm_pool_mgr_destroy(struct tee_shm_pool_mgr *poolm)
  * The must be no remaining shared memory allocated from this pool when
  * this function is called.
  */
-void tee_shm_pool_free(struct tee_shm_pool *pool);
+static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
+{
+	pool->ops->destroy_pool(pool);
+}
 
 /**
  * tee_get_drvdata() - Return driver_data pointer
-- 
2.31.1

