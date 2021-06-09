Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094343A1100
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbhFIK0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:26:35 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:42841 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhFIK0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:26:33 -0400
Received: by mail-lf1-f52.google.com with SMTP id j2so9588017lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9L1UST91CNAHLkSPICX3VPuq32tNYAEanaTNNZO0q8=;
        b=IYOk8I54rWLZ5Np2R1bzEFwVy5KwKmcdQ4BTvvnwJbTEsg6OiNsdY2CBZoYILdQfXx
         VLbfJxVpa66mnOx2V4bYHwexFzVqSD2UJGHdrWCJq9QbmwwI4d5aCOBk4JF2Ad11zEjm
         IjMcAVXyZVai5sdwgeKdfmWyTmzP6iwafOBPLyjsPlcZ30LrDMsZKJMy26zYNBUntUbO
         rfk8FwfoyHkiV4TDwAsiwv4ij4C0pJ1JZ3PKTCJjzxLQyPiLBeSOdK3bC2DlCDN4U2/f
         ySkUMzcFYkYlffC0o+Mp1osFIWtaYtSfD21GYwgC4VB0Hy6kKq1Y+vqsVZrNnWO/zzzs
         XuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9L1UST91CNAHLkSPICX3VPuq32tNYAEanaTNNZO0q8=;
        b=GBN/8xLTMK7VLmBK90s7mDRn85oUtgKQYctToAsa5hDkaOWD8AAlbVJchtL6MkTojz
         wbVCjk6DYckNMM4pUyYA240l3DeM5Pzvb/93vBOi4eXSrOgfO/tBjSKzeDjRyJJQwtnv
         SKSdX2vAuPNTkbt8ZktD4tIa0jffRIyynuquRAjkoC1SPEW6Cl1JwHJGeZh19K7wF3Mr
         Y4ASJ1xyNNzqXg6xrj5N0iRPYBu4gwqPJKXKqSyT7/GZGX9XQlaXHycinRaFBSfQypJN
         EwIYs3FMoxNJGVBBvxZ2AJWbdvSs93qYrP9xbvmsGwwo00n6zHdOAjj60cuPkskxhLt+
         aLPA==
X-Gm-Message-State: AOAM530ilCkO1U6g33GxJJYCiEepvcVe53BxoohPFTHsZPvXTHRZFuaa
        /djAKnwkTH5nbTEU5srXZm2zxjWZzkwi3GiV
X-Google-Smtp-Source: ABdhPJyq82dDCmEPp1H3l89ON8o2eLljF8JtSjMCVEN2Y9jxHB/b7oKBppGWd3jdmwYwhqXem/TJsg==
X-Received: by 2002:a05:6512:3146:: with SMTP id s6mr18254687lfi.173.1623234218296;
        Wed, 09 Jun 2021 03:23:38 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m4sm302966ljp.9.2021.06.09.03.23.37
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
Subject: [PATCH 1/7] tee: remove unused tee_shm_pool_alloc_res_mem()
Date:   Wed,  9 Jun 2021 12:23:18 +0200
Message-Id: <20210609102324.2222332-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609102324.2222332-1-jens.wiklander@linaro.org>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the drivers in the TEE subsystem uses
tee_shm_pool_alloc_res_mem() so remove the function.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm_pool.c | 56 --------------------------------------
 include/linux/tee_drv.h    | 30 --------------------
 2 files changed, 86 deletions(-)

diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
index fcbb461fc59c..a9f9d50fd181 100644
--- a/drivers/tee/tee_shm_pool.c
+++ b/drivers/tee/tee_shm_pool.c
@@ -47,62 +47,6 @@ static const struct tee_shm_pool_mgr_ops pool_ops_generic = {
 	.destroy_poolmgr = pool_op_gen_destroy_poolmgr,
 };
 
-/**
- * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
- * memory range
- * @priv_info:	Information for driver private shared memory pool
- * @dmabuf_info: Information for dma-buf shared memory pool
- *
- * Start and end of pools will must be page aligned.
- *
- * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
- * in @dmabuf, others will use the range provided by @priv.
- *
- * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
- */
-struct tee_shm_pool *
-tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
-			   struct tee_shm_pool_mem_info *dmabuf_info)
-{
-	struct tee_shm_pool_mgr *priv_mgr;
-	struct tee_shm_pool_mgr *dmabuf_mgr;
-	void *rc;
-
-	/*
-	 * Create the pool for driver private shared memory
-	 */
-	rc = tee_shm_pool_mgr_alloc_res_mem(priv_info->vaddr, priv_info->paddr,
-					    priv_info->size,
-					    3 /* 8 byte aligned */);
-	if (IS_ERR(rc))
-		return rc;
-	priv_mgr = rc;
-
-	/*
-	 * Create the pool for dma_buf shared memory
-	 */
-	rc = tee_shm_pool_mgr_alloc_res_mem(dmabuf_info->vaddr,
-					    dmabuf_info->paddr,
-					    dmabuf_info->size, PAGE_SHIFT);
-	if (IS_ERR(rc))
-		goto err_free_priv_mgr;
-	dmabuf_mgr = rc;
-
-	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
-	if (IS_ERR(rc))
-		goto err_free_dmabuf_mgr;
-
-	return rc;
-
-err_free_dmabuf_mgr:
-	tee_shm_pool_mgr_destroy(dmabuf_mgr);
-err_free_priv_mgr:
-	tee_shm_pool_mgr_destroy(priv_mgr);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_res_mem);
-
 struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long vaddr,
 							phys_addr_t paddr,
 							size_t size,
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 54269e47ac9a..53b9b2a13a87 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -272,36 +272,6 @@ static inline void tee_shm_pool_mgr_destroy(struct tee_shm_pool_mgr *poolm)
 	poolm->ops->destroy_poolmgr(poolm);
 }
 
-/**
- * struct tee_shm_pool_mem_info - holds information needed to create a shared
- * memory pool
- * @vaddr:	Virtual address of start of pool
- * @paddr:	Physical address of start of pool
- * @size:	Size in bytes of the pool
- */
-struct tee_shm_pool_mem_info {
-	unsigned long vaddr;
-	phys_addr_t paddr;
-	size_t size;
-};
-
-/**
- * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
- * memory range
- * @priv_info:	 Information for driver private shared memory pool
- * @dmabuf_info: Information for dma-buf shared memory pool
- *
- * Start and end of pools will must be page aligned.
- *
- * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
- * in @dmabuf, others will use the range provided by @priv.
- *
- * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
- */
-struct tee_shm_pool *
-tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
-			   struct tee_shm_pool_mem_info *dmabuf_info);
-
 /**
  * tee_shm_pool_free() - Free a shared memory pool
  * @pool:	The shared memory pool to free
-- 
2.31.1

