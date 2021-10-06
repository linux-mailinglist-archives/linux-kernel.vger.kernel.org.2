Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DAF42388B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbhJFHLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbhJFHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:11:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F5CC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:09:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t9so6356591lfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vBdWBM0UW4kI+oJm3DDC8ZI0wyWMqjtOzMb/smR/vC8=;
        b=xN2xFYNdBFo9f+Eig16FNlM+M08j6F57PkLcV7EAZIgFkAWu+fva33L0Nb9zG3Aq3k
         yx3bJtzkoVAOcKJc/m/PGRadK8EhB2OROz30ZPI0gcMxYTdt7j81rKRvr6crmMfNvk6+
         81hDxyfjqMPyDG9O2SAQbDnZCBt47+C11nDvPkV891tL9tLwBu74BswcnOvK4OhzB+C3
         PVdKxhxur6MKkzYmaVZsyLHBxyCYzPftjXRPvq97eoLj0ZD8aitEMrQTVPppIZ/AfxR8
         NJI3lQtQIRxOUvuJAOqCR0VPUqK+cDU14k6J1znQRFayW01RF1wJGbbrvrOmBOiY94LW
         RdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vBdWBM0UW4kI+oJm3DDC8ZI0wyWMqjtOzMb/smR/vC8=;
        b=i9sLdh3epVQBMBxVYW36zSRtDbij7Xk2E5L3WXFw8mRzrprvCKV5cQ8yWE6uEg7PTj
         q5PNyiOCdWJOGNzfD8IgAF7oYxAPpRL35rYFHBmJTuHRfP6Vg5xCx1WisOJ6ZtFeP511
         BNqFU8TOt8rOldcrKVjHsY2rPOZYnxz/9M91/NY5VHdI9BWveuorrMBVr9H/Ws0r9kFO
         g6C2NxKdpCyKN5mLZHOSfncHZztBaVziQR0AaE2HJSseOzPsR3eR6iMX9J7Mz7ZpfX0A
         c8AC4nHIBeHUgNfNgdC5oPYR2LgmnoLhp5le8c1jjuZ49xT4oGgaJ2gClEuZnZDGN3GR
         +mbw==
X-Gm-Message-State: AOAM5331SmpfhufWyZy34EaiqrdvKAa8hNhcXtuAOvN1aF4q32a94GMC
        HcN4c+MiHHxq2V1No2a/jL20cz1YPoquaw==
X-Google-Smtp-Source: ABdhPJwUJWaPZSsc43Fp2TAhFNvB3UDPKp+t8SByGt3pbW91TKh13hnVBpIUsnDqItQQMcddB3Q1nA==
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr26778632ljj.527.1633504149826;
        Wed, 06 Oct 2021 00:09:09 -0700 (PDT)
Received: from jade.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u15sm2381032lfl.20.2021.10.06.00.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 00:09:09 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v6 2/5] optee: simplify optee_release()
Date:   Wed,  6 Oct 2021 09:08:59 +0200
Message-Id: <20211006070902.2531311-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006070902.2531311-1-jens.wiklander@linaro.org>
References: <20211006070902.2531311-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplifies optee_release() with a new helper function,
optee_close_session_helper() which has been factored out from
optee_close_session().

A separate optee_release_supp() is added for the supplicant device.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          | 31 ++++++++++-------
 drivers/tee/optee/core.c          | 56 +++++++++++--------------------
 drivers/tee/optee/optee_private.h |  1 +
 3 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 945f03da0223..103976df2062 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -288,12 +288,28 @@ int optee_open_session(struct tee_context *ctx,
 	return rc;
 }
 
-int optee_close_session(struct tee_context *ctx, u32 session)
+int optee_close_session_helper(struct tee_context *ctx, u32 session)
 {
-	struct optee_context_data *ctxdata = ctx->data;
 	struct tee_shm *shm;
 	struct optee_msg_arg *msg_arg;
 	phys_addr_t msg_parg;
+
+	shm = get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
+	if (IS_ERR(shm))
+		return PTR_ERR(shm);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
+	msg_arg->session = session;
+	optee_do_call_with_arg(ctx, msg_parg);
+
+	tee_shm_free(shm);
+
+	return 0;
+}
+
+int optee_close_session(struct tee_context *ctx, u32 session)
+{
+	struct optee_context_data *ctxdata = ctx->data;
 	struct optee_session *sess;
 
 	/* Check that the session is valid and remove it from the list */
@@ -306,16 +322,7 @@ int optee_close_session(struct tee_context *ctx, u32 session)
 		return -EINVAL;
 	kfree(sess);
 
-	shm = get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
-
-	msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
-	msg_arg->session = session;
-	optee_do_call_with_arg(ctx, msg_parg);
-
-	tee_shm_free(shm);
-	return 0;
+	return optee_close_session_helper(ctx, session);
 }
 
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 5ce13b099d7d..86a1ae8d296d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -264,60 +264,42 @@ static int optee_open(struct tee_context *ctx)
 	return 0;
 }
 
-static void optee_release(struct tee_context *ctx)
+static void optee_release_helper(struct tee_context *ctx,
+				 int (*close_session)(struct tee_context *ctx,
+						      u32 session))
 {
 	struct optee_context_data *ctxdata = ctx->data;
-	struct tee_device *teedev = ctx->teedev;
-	struct optee *optee = tee_get_drvdata(teedev);
-	struct tee_shm *shm;
-	struct optee_msg_arg *arg = NULL;
-	phys_addr_t parg;
 	struct optee_session *sess;
 	struct optee_session *sess_tmp;
 
 	if (!ctxdata)
 		return;
 
-	shm = tee_shm_alloc(ctx, sizeof(struct optee_msg_arg),
-			    TEE_SHM_MAPPED | TEE_SHM_PRIV);
-	if (!IS_ERR(shm)) {
-		arg = tee_shm_get_va(shm, 0);
-		/*
-		 * If va2pa fails for some reason, we can't call into
-		 * secure world, only free the memory. Secure OS will leak
-		 * sessions and finally refuse more sessions, but we will
-		 * at least let normal world reclaim its memory.
-		 */
-		if (!IS_ERR(arg))
-			if (tee_shm_va2pa(shm, arg, &parg))
-				arg = NULL; /* prevent usage of parg below */
-	}
-
 	list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list,
 				 list_node) {
 		list_del(&sess->list_node);
-		if (!IS_ERR_OR_NULL(arg)) {
-			memset(arg, 0, sizeof(*arg));
-			arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
-			arg->session = sess->session_id;
-			optee_do_call_with_arg(ctx, parg);
-		}
+		close_session(ctx, sess->session_id);
 		kfree(sess);
 	}
 	kfree(ctxdata);
+	ctx->data = NULL;
+}
 
-	if (!IS_ERR(shm))
-		tee_shm_free(shm);
+static void optee_release(struct tee_context *ctx)
+{
+	optee_release_helper(ctx, optee_close_session_helper);
+}
 
-	ctx->data = NULL;
+static void optee_release_supp(struct tee_context *ctx)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
 
-	if (teedev == optee->supp_teedev) {
-		if (optee->scan_bus_wq) {
-			destroy_workqueue(optee->scan_bus_wq);
-			optee->scan_bus_wq = NULL;
-		}
-		optee_supp_release(&optee->supp);
+	optee_release_helper(ctx, optee_close_session_helper);
+	if (optee->scan_bus_wq) {
+		destroy_workqueue(optee->scan_bus_wq);
+		optee->scan_bus_wq = NULL;
 	}
+	optee_supp_release(&optee->supp);
 }
 
 static const struct tee_driver_ops optee_ops = {
@@ -341,7 +323,7 @@ static const struct tee_desc optee_desc = {
 static const struct tee_driver_ops optee_supp_ops = {
 	.get_version = optee_get_version,
 	.open = optee_open,
-	.release = optee_release,
+	.release = optee_release_supp,
 	.supp_recv = optee_supp_recv,
 	.supp_send = optee_supp_send,
 	.shm_register = optee_shm_register_supp,
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index dbdd367be156..d9f5f3f7ba58 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -152,6 +152,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg);
 int optee_open_session(struct tee_context *ctx,
 		       struct tee_ioctl_open_session_arg *arg,
 		       struct tee_param *param);
+int optee_close_session_helper(struct tee_context *ctx, u32 session);
 int optee_close_session(struct tee_context *ctx, u32 session);
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 		      struct tee_param *param);
-- 
2.31.1

