Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF39392953
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhE0IQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbhE0IP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:15:57 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2631EC061761
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:14:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id p20so5156132ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSMhRaAh0/rjMIx1myzNsTqUJ67O67HuU1P0C4BZ2/I=;
        b=wzK1Hi4vYmsLpZCDIXCjm0zp9CnM9C1xYsygrV0BGofYNtX4CrQtd9VNaXcukxUdMG
         RCAb7y9UPzhvEH0zNDrKMlmHj6IbuPzU9YTs5UiXTxrQCDsu1tjTH1DRkwVKcBWK8X9Q
         zzSLTR2yUXKpHRuk3EfHy5uuSTs2Um9rjtZFk2DSzq6KHyyPd+iQwOubzUWO0atTjSrJ
         9hd1u2Ssd99gvpyw5iIK4pnhZ9/jAFGN0YMqT8FI+Z0Oa7DPJyRYKLcKvCiip9lI8g3S
         IfwpRNlmNrvcPMGAVoM1dYEIq4dVXwFgE0pxYAliPLPhFHAkWQjRtfF/lPbdmVSHXNDV
         wyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSMhRaAh0/rjMIx1myzNsTqUJ67O67HuU1P0C4BZ2/I=;
        b=ImlcMTcLoNRQCmjNXxn5psc12LpaRuM3v9aU9rKEJWL9ieCYkMn1XNnLlWXRKEMQri
         Xf8FFrlC1DMJfKlAgjnRZ2FjcIWn8Qzw/XQB+ZiifC9oUZZgV3NcOFQhwcTisAQ9CchC
         v8zZhMY7IXxIvj0nNjSZ904FOg7aqY44ytjyysaoxKlyqM1lVl4xSlp02E/L6XH4rYm9
         hJcmbl59P2vje6izWxmmdI/FOW7yVQx1eevZzipLieZgwSvNB0MJGSTSIw0bqP/6lKPl
         4rPTWpF7Y/4wftjy2K+9Z7YPSG7sJOXoaL2UfFU2bEeFgNegTzH3l0yq5gBA1ovS0mbW
         08yA==
X-Gm-Message-State: AOAM532Q84+jXkyUr9ct8CldnHdb41AoB0Mp/wKmntp2hQf6BIjkODYQ
        7OUZCa8JVN5S6pckto9S0dF8/jod96KBsw==
X-Google-Smtp-Source: ABdhPJzhgB4bIzeYPaVnRvMpVrs3HXWrIxydein8yQ5xgTc+Hm/aKHhTImpzExRk5//tbYDefTDBQA==
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr1671425ljj.89.1622103261222;
        Thu, 27 May 2021 01:14:21 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id z10sm133186lfe.228.2021.05.27.01.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:14:20 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 4/5] optee: add a FF-A memory pool
Date:   Thu, 27 May 2021 10:14:03 +0200
Message-Id: <20210527081404.1433177-5-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527081404.1433177-1-jens.wiklander@linaro.org>
References: <20210527081404.1433177-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a memory pool to be used when the driver uses FF-A [1] as transport
layer.

[1] https://developer.arm.com/documentation/den0077/latest
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/shm_pool.c | 65 +++++++++++++++++++++++++++++++++---
 drivers/tee/optee/shm_pool.h |  1 +
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index d767eebf30bd..d2116cb39c8b 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -12,8 +12,14 @@
 #include "optee_smc.h"
 #include "shm_pool.h"
 
-static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
-			 struct tee_shm *shm, size_t size)
+static int
+pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
+		     struct tee_shm *shm, size_t size,
+		     int (*shm_register)(struct tee_context *ctx,
+					 struct tee_shm *shm,
+					 struct page **pages,
+					 size_t num_pages,
+					 unsigned long start))
 {
 	unsigned int order = get_order(size);
 	struct page *page;
@@ -27,7 +33,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 	shm->paddr = page_to_phys(page);
 	shm->size = PAGE_SIZE << order;
 
-	if (shm->flags & TEE_SHM_DMA_BUF) {
+	if (shm_register) {
 		unsigned int nr_pages = 1 << order, i;
 		struct page **pages;
 
@@ -41,14 +47,23 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		}
 
 		shm->flags |= TEE_SHM_REGISTER;
-		rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
-					(unsigned long)shm->kaddr);
+		rc = shm_register(shm->ctx, shm, pages, nr_pages,
+				  (unsigned long)shm->kaddr);
 		kfree(pages);
 	}
 
 	return rc;
 }
 
+static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
+			 struct tee_shm *shm, size_t size)
+{
+	if (!(shm->flags & TEE_SHM_DMA_BUF))
+		return pool_op_alloc_helper(poolm, shm, size, NULL);
+
+	return pool_op_alloc_helper(poolm, shm, size, optee_shm_register);
+}
+
 static void pool_op_free(struct tee_shm_pool_mgr *poolm,
 			 struct tee_shm *shm)
 {
@@ -87,3 +102,43 @@ struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void)
 
 	return mgr;
 }
+
+#ifdef CONFIG_ARM_FFA_TRANSPORT
+static int pool_ffa_op_alloc(struct tee_shm_pool_mgr *poolm,
+			     struct tee_shm *shm, size_t size)
+{
+	return pool_op_alloc_helper(poolm, shm, size, optee_ffa_shm_register);
+}
+
+static void pool_ffa_op_free(struct tee_shm_pool_mgr *poolm,
+			     struct tee_shm *shm)
+{
+	optee_ffa_shm_unregister(shm->ctx, shm);
+	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	shm->kaddr = NULL;
+}
+
+static const struct tee_shm_pool_mgr_ops pool_ffa_ops = {
+	.alloc = pool_ffa_op_alloc,
+	.free = pool_ffa_op_free,
+	.destroy_poolmgr = pool_op_destroy_poolmgr,
+};
+
+/**
+ * optee_ffa_shm_pool_alloc_pages() - create page-based allocator pool
+ *
+ * This pool is used with OP-TEE over FF-A. In this case command buffers
+ * and such are allocated from kernel's own memory.
+ */
+struct tee_shm_pool_mgr *optee_ffa_shm_pool_alloc_pages(void)
+{
+	struct tee_shm_pool_mgr *mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+
+	if (!mgr)
+		return ERR_PTR(-ENOMEM);
+
+	mgr->ops = &pool_ffa_ops;
+
+	return mgr;
+}
+#endif /*CONFIG_ARM_FFA_TRANSPORT*/
diff --git a/drivers/tee/optee/shm_pool.h b/drivers/tee/optee/shm_pool.h
index 28109d991c4b..34c5fd74a3ff 100644
--- a/drivers/tee/optee/shm_pool.h
+++ b/drivers/tee/optee/shm_pool.h
@@ -10,5 +10,6 @@
 #include <linux/tee_drv.h>
 
 struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void);
+struct tee_shm_pool_mgr *optee_ffa_shm_pool_alloc_pages(void);
 
 #endif
-- 
2.25.1

