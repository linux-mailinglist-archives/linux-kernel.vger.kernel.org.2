Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C4D36540B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhDTI0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhDTI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:26:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40888C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:26:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j4so20711025lfp.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDRPN4ck5c/LMQMDRR6RqCECkMdMxHcVqcxleCtfwRg=;
        b=Q05QfvFMXF2/pyyy2Ue7j7Rc8U3HIouXGj15VCi8LVLnFj7hU2w1sPbRZH58bzRNEK
         8Sqx3LRHhCpFJXkfn+BSOC4sNxTWQ7K8K5gp0OInTayRnSNs56ULa2/uNLCFnQ5gGLJf
         NIcveJwn6ChhigWtJnRZxw/kUgI/0poZt03hURnEwOhB3YvrUphi+lizrYA5Ko8diKTc
         KzaKXmDmaC3cKR4mpslWJ2E35rK62VGhgJaCR/gFAHtEIZmbPt+YXZI1Uz7pmvITs6Zn
         cZBTDgTB6jcUJj3nKUAF/c/ECEx4g/ShjlQFc3wms52Pv8hG2Zu/Y9zZBHp6875ys6rZ
         9yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDRPN4ck5c/LMQMDRR6RqCECkMdMxHcVqcxleCtfwRg=;
        b=Df9qGTUSfbVdVyiueUgiY2tIAxcdA8+BeJj9pkJ6SCqUM9/1IwxUxabvxb7/Pzh19t
         VvY4lriHLAnGP+EDtas3ewp2WtAa1eoJe+h4Hj1FEIwWmTLdigt2ql6KD7UC5mjAJ/X7
         Q8JUM/ZBDYqyz30gOfRfX2NikSJPyW1vW3Q3KeylQlsKkxgk+M3G0Z0zleHmdvSf4sE0
         ZnRQACHRfXeDfQQLIZy7Qg3Wfu48fkb6It+Ni9n+vXRxQuEjxg19jlQmxKVKWgHD8Dc0
         cA7ENCUs0pI/AaYYtfUZVgW7NsjDZcIa30DAYUlKby92BnRROUqfvGBqiPEcDC6eU/fT
         quOg==
X-Gm-Message-State: AOAM533Zj7Br120l1vRHcKLMz5Gdd6KnTWsghpMHETdtvy6mCykOTwPv
        duyh5x+NMzWKABjNhNzcn2hqtS8eIxvpBw==
X-Google-Smtp-Source: ABdhPJx0E2W7V/TpdQDr8e2kPEtL/EFp3oKQI3IdvmVr2VQpru3ZXohnLT2Enf37tSSFjr6tQqR3NQ==
X-Received: by 2002:ac2:4aca:: with SMTP id m10mr11297426lfp.255.1618907173384;
        Tue, 20 Apr 2021 01:26:13 -0700 (PDT)
Received: from jade.urgonet (h-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id o16sm2077751lfu.228.2021.04.20.01.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 01:26:12 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] optee: use export_uuid() to copy client UUID
Date:   Tue, 20 Apr 2021 10:25:47 +0200
Message-Id: <20210420082547.3542261-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this patch optee_open_session() was making assumptions about
the internal format of uuid_t by casting a memory location in a
parameter struct to uuid_t *. Fix this using export_uuid() to get a well
defined binary representation and also add an octets field in struct
optee_msg_param in order to avoid casting.

Fixes: c5b4312bea5d ("tee: optee: Add support for session login client UUID generation")
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c      | 6 ++++--
 drivers/tee/optee/optee_msg.h | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 7a77e375b503..6b52f0c526ba 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -216,6 +216,7 @@ int optee_open_session(struct tee_context *ctx,
 	struct optee_msg_arg *msg_arg;
 	phys_addr_t msg_parg;
 	struct optee_session *sess = NULL;
+	uuid_t client_uuid;
 
 	/* +2 for the meta parameters added below */
 	shm = get_msg_arg(ctx, arg->num_params + 2, &msg_arg, &msg_parg);
@@ -236,10 +237,11 @@ int optee_open_session(struct tee_context *ctx,
 	memcpy(&msg_arg->params[0].u.value, arg->uuid, sizeof(arg->uuid));
 	msg_arg->params[1].u.value.c = arg->clnt_login;
 
-	rc = tee_session_calc_client_uuid((uuid_t *)&msg_arg->params[1].u.value,
-					  arg->clnt_login, arg->clnt_uuid);
+	rc = tee_session_calc_client_uuid(&client_uuid, arg->clnt_login,
+					  arg->clnt_uuid);
 	if (rc)
 		goto out;
+	export_uuid(msg_arg->params[1].u.octets, &client_uuid);
 
 	rc = optee_to_msg_param(msg_arg->params + 2, arg->num_params, param);
 	if (rc)
diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 81ff593ac4ec..e3d72d09c484 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -9,7 +9,7 @@
 #include <linux/types.h>
 
 /*
- * This file defines the OP-TEE message protocol used to communicate
+ * This file defines the OP-TEE message protocol (ABI) used to communicate
  * with an instance of OP-TEE running in secure world.
  *
  * This file is divided into two sections.
@@ -144,9 +144,10 @@ struct optee_msg_param_value {
  * @tmem:	parameter by temporary memory reference
  * @rmem:	parameter by registered memory reference
  * @value:	parameter by opaque value
+ * @octets:	parameter by octet string
  *
  * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value is used in
- * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value,
+ * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value or octets,
  * OPTEE_MSG_ATTR_TYPE_TMEM_* indicates @tmem and
  * OPTEE_MSG_ATTR_TYPE_RMEM_* indicates @rmem,
  * OPTEE_MSG_ATTR_TYPE_NONE indicates that none of the members are used.
@@ -157,6 +158,7 @@ struct optee_msg_param {
 		struct optee_msg_param_tmem tmem;
 		struct optee_msg_param_rmem rmem;
 		struct optee_msg_param_value value;
+		u8 octets[24];
 	} u;
 };
 
-- 
2.25.1

