Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149C73495E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhCYPpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCYPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:44:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B894C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:44:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o126so3261724lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSMhRaAh0/rjMIx1myzNsTqUJ67O67HuU1P0C4BZ2/I=;
        b=EFKuh+lJ9rIFnC8y5rU4o8VuR5CXMEyL4syonu1xoPso3+1efItVAIODBBtxJu6HOz
         9OdKJHOf7uFynDibDEPArpPqHRN/Vj9KpsRf0Qq+8Z+p2WjVOq0QX2PbV+T+iR92YLHe
         MxfbOrq+MlOQlFSfeEBQkoG+smcd3ySJOH4AmdlwNNeFqcFlmHIv9RPBrTnPKX/PyBi7
         3vfSFkIwwGqd3owY9p85ozgMxUgh9VJo8gEOAQN9DC3R/Dq14jF483sTFXieQtDnXroH
         KzrggQme1gsorGdxr+MuqnsSrmkuB5S3wzBkeq4xz2UuVUtvIKGXTkY45uVnKohlaRCF
         ELFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSMhRaAh0/rjMIx1myzNsTqUJ67O67HuU1P0C4BZ2/I=;
        b=SKivzqgWGEhvXgRGQHEWqW1zS7y/12hnb3E8UaGc2YZwVcxDJbrXnn9PYm/NmBy8AQ
         yfoV/OsR5kQVGaTtOPLIpPzo/OamPV1kDmMm5LzNrdW7K1H/B5aSGdAAWC+5MFKDvRmH
         /3QSGT9cX3NpYdpMLjROGs8djUIuYKH9PBBlnchUl0kiey+tq3VJYHyxOVOYQ2QU6zHO
         wNarPIbiTTo0asAZsWgj3djuNcj8YhMcbvov4tUs/qO4ynDaY0lLYe2Tbd7ME3nLC+PA
         BGg5Ix3OAzpGinjZAiPGWu4Vj64PoWGt4VYShLBSAwfaejogXqXIwJ42t9nyCqZLCKE4
         tI5Q==
X-Gm-Message-State: AOAM533RnX/7uCnLTD/cwpD0NHPx+WWNQUZD5A6ZssaNjctC/Y+YYJde
        B5Dq5b/z+iDlejntpPv37spNWg28T6O0HHVC
X-Google-Smtp-Source: ABdhPJwb5w57NuuGD741guscv+zO4NeeLTibb/qQCJDVLFcWKCp06a7alF830Xu+/+cw57Os0NaFLw==
X-Received: by 2002:a19:b03:: with SMTP id 3mr5493439lfl.236.1616687080578;
        Thu, 25 Mar 2021 08:44:40 -0700 (PDT)
Received: from jade.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id m27sm770916ljc.109.2021.03.25.08.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:44:40 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 5/6] optee: add a FF-A memory pool
Date:   Thu, 25 Mar 2021 16:44:25 +0100
Message-Id: <20210325154426.3520148-6-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325154426.3520148-1-jens.wiklander@linaro.org>
References: <20210325154426.3520148-1-jens.wiklander@linaro.org>
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

