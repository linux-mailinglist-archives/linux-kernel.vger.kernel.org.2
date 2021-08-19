Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26633F17B2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbhHSLHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbhHSLHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:07:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B2C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:07:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id i28so10868560ljm.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJZ8xIfA9pRmG3itFYtftUsoAj1l+O/B/Z05KVOmdhU=;
        b=DiNhOwNKqMRZQUUSUie4aWsJxApmEtfcbY1ZJ3q59qfNCksrCJ62+t6rGb8KVXCj7J
         WP7acHGz4hUPFc3MYwb4REYKcCFw71jlTduSPztgzfyW5OR5P3Q5IWMYPOtEzhNdMT0A
         n08wWadsWfAUSyc5mjL3NVo6/CWRwWwaPnWFXOi570kBdekF0hK0T1OtTXyPzMTKo686
         Z4iMGzauBM/ypq5AOlS3Y972xJUggHblgC4inNHLFio58gzrVawFrvkQHzNonloGX2EJ
         BGIYnhbw27dgmEgpzwx/mrxU0K7MAoFWBfLZTfF/4CFZ1kmYJOQnt44VznUFjZ7QlE8A
         Kxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJZ8xIfA9pRmG3itFYtftUsoAj1l+O/B/Z05KVOmdhU=;
        b=mF1kXdBsmsrO68B5kUGmRbIgyRSYeHSpjJG+XYEsWlh24DHe0/CFxQYEsWy4BFWUNH
         VbgzP2I4isv4KLHbT2VnZ05Cz7j9+xT8UJsshbAw4c7T7bpQL2OJsGjW03qtXGuHdOmY
         mnB66dXiG4eYz37H8G/mKNFlMz64/Hp4Vr9yfyt7dfItgfBgY6n95zYZW5V8jQKTGw2/
         T/KylN9fPDM9ISFmAw/u1XYaiNjgj+S5ckiR2dvS+/kcekK1piQ7R9r+N9/p3zR8zNTB
         wVrKGcuoUK6Wh7YDLJZ0kIO4TL2wTLWJUdvGnM1UE13U2DnlF+jto/id2tjoai+FhfpL
         4xmQ==
X-Gm-Message-State: AOAM533Ten8E8tA0kEgNFJ9v8e7v1SU+Nzj1eZJJF5v7m/64ppH0Z1+Z
        PdlyYkitcQ7l8Bh3jVhvoMl8DJcCnjAnzQ==
X-Google-Smtp-Source: ABdhPJyzxzsto8hJlZs6YkSU8EtA0zIS7O3nv+WcdIxyjI2D90tXNSxpYWpzIn0zHLlal2KEU760ow==
X-Received: by 2002:a05:651c:542:: with SMTP id q2mr11795598ljp.192.1629371227974;
        Thu, 19 Aug 2021 04:07:07 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id l19sm261131ljj.36.2021.08.19.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:07:07 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 2/5] optee: simplify optee_release()
Date:   Thu, 19 Aug 2021 13:06:52 +0200
Message-Id: <20210819110655.739318-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210819110655.739318-1-jens.wiklander@linaro.org>
References: <20210819110655.739318-1-jens.wiklander@linaro.org>
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

