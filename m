Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2973A3D233C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhGVLhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhGVLhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:37:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63DBC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 05:18:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g8so8162517lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSM6ywfPZHuzICpAotpTzsAM8ROQzdG3QQ9aBo5KLWA=;
        b=yGzEq1HO6HYKist5tJtIO6GuPpKizbL1aiJrp3zAh47tP5K7vKPx8rb1Vb1MbexGjg
         1uDb/0QES2VYHwwHPKdmayK696Y0VWi2qUcJt/KmZK1POZYovNb3N/iy4O5Jr//aTei1
         kngnZKZ+0NYbtAa27/61rKLZVeaBOub6i6ERJtwHsILeU5MemGTxJQi6OsMk9R6fZFx4
         cvuwzC63QPRSXwKb3HbxGSgw+Pf+Qm82vaqvyggOtUYaJ/ZPVD2xFeLcRckO/BuelQWT
         Whiy1V8CRnkD5yd1143ybB3S1ZHndIzL+WgpVIdERe3nYJwbstCHklW1wqE3dB/72bhi
         KKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSM6ywfPZHuzICpAotpTzsAM8ROQzdG3QQ9aBo5KLWA=;
        b=gj8qSB7o8XxPNqD14c+iTN9sNxGRLfcckp0ffYn2eN1PZMAumzdXKG8zcutdFkpIB6
         uRzBx5DxwIa3XmKbMS2sTlW5AoXITckIWu5qcvnk+ne0r6kfYTuJE441TbmwmnjkKGy2
         D2YGSLVvE3uwfaUspYOf3BftuCHHjnKwsvUf+TD7+MkbVwnhlVUAPrF9+aK5QYB903GE
         NnXpAfPYM41tLOSyV5i9jzYj/KRwzWPCtfmbTxhPJPnGWxvczH6KCiChhblkvlIowGNU
         +9vBC3qBsrHAMzGgE6efldBAczfLOAsA9Ks/r20SnMmb4U21OyKXtgOt4LVIQA7noVAU
         7gOA==
X-Gm-Message-State: AOAM533dCXkF0rKjEGg+x+YrE7pfJrF76VXCznOP39su6C4y69RL703C
        Gcip5R/Gr3A5cfQpFGwf+IApvtpUDuvElg==
X-Google-Smtp-Source: ABdhPJyewI7WVG03WZpVAsBO3LVZPI93odEAapLVJaWAG9LsTOdZsEl/crv/gaHZu8oHcEgSR8pM7g==
X-Received: by 2002:a05:6512:114f:: with SMTP id m15mr9967529lfg.551.1626956287873;
        Thu, 22 Jul 2021 05:18:07 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id b41sm845090ljr.67.2021.07.22.05.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:18:07 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 2/5] optee: simplify optee_release()
Date:   Thu, 22 Jul 2021 14:17:54 +0200
Message-Id: <20210722121757.1944658-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722121757.1944658-1-jens.wiklander@linaro.org>
References: <20210722121757.1944658-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplifies optee_release() with a new helper function,
optee_close_session_helper() which has been factored out from
optee_close_session().

A separate optee_release_supp() is added for the supplicant device.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          | 31 ++++++++++-------
 drivers/tee/optee/core.c          | 55 +++++++++++--------------------
 drivers/tee/optee/optee_private.h |  1 +
 3 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 6e6eb836e9b6..9d8f5a95e42f 100644
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
index ddb8f9ecf307..949223b214c3 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -263,59 +263,42 @@ static int optee_open(struct tee_context *ctx)
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
 
-	shm = tee_shm_alloc(ctx, sizeof(struct optee_msg_arg), TEE_SHM_MAPPED);
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
@@ -339,7 +322,7 @@ static const struct tee_desc optee_desc = {
 static const struct tee_driver_ops optee_supp_ops = {
 	.get_version = optee_get_version,
 	.open = optee_open,
-	.release = optee_release,
+	.release = optee_release_supp,
 	.supp_recv = optee_supp_recv,
 	.supp_send = optee_supp_send,
 	.shm_register = optee_shm_register_supp,
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index e25b216a14ef..2b63b796645e 100644
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

