Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6C3A97BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhFPKju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhFPKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:39:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C68C0611C6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q20so3547780lfo.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdRv9iNdXE4gJIWcq1jF51m1svA1oer9OapZtgMeh2g=;
        b=wipB/JbjELJxzVH9FmaefDw5Qpb2ICTrnBmhdbC30Z5///ALfSOxhow3EEAUIsjEL0
         /antU4lxT56Qskyw8KSi75erRKG23+g0eV98pM656bFa69qREpzn42Z+xAKY9E164lue
         C+MzYzL6h+Wgo8i6JA4A1HT8jBHFBtrQ41vOdN3ZZHEmz5sokhzWpEE1pd2wfnzW9C0R
         T1fusOkjbTB0QimPtrTpWSYO61LGkebt4eE21+EjrgoJw/cn8k7FGY7G5Abeg3QpHjrJ
         UMxOLPIotSjy7s/sJGHRb5unxCUt9n+9do8Lb0JjySZcdaU5WvhpzIaGoJkR566Ymn+G
         jEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdRv9iNdXE4gJIWcq1jF51m1svA1oer9OapZtgMeh2g=;
        b=DdWqb1VF6b0eWzIKEX57d4VXSZIw/Ds9moICMPy4GBi/lCJ1FkVbvAnrkCVBF2Pk8Z
         1pi0cdBy8dFYMD8t3ls/ScMEO8UC5bIzIea82eS/Ot70K/Qb/PAiyezxMWUF+AUQoBdW
         iU3CJNv3SKPjhKwGDVl/DNNOayCZGqsTDcDnNhyQCulRnO5ZK79rpzGOUYhuV2a563sy
         StGvE5qGv+7+Ar+oKrgp9NgB4aro5xOu/X+39qfE5KR4PKyCNW5GqZcA1YQRzZCNHYU2
         ZpI9RDEMkqbrRURU5+8mRnRA2rmzmxcLqC8gn4AKfWGu0rzdeUQxVlEvVEu7eObmIGAE
         GGpA==
X-Gm-Message-State: AOAM5300WHheUq1Mrdjq0Y5zdgxJYuzodDMQJr+9GpWCIVoXOIWZ4/gR
        DUEFBAULS5KgbDvBdxXJ/Xto1icO0hGXrQ==
X-Google-Smtp-Source: ABdhPJxNr0ELEcnEGHK5cgQ9BY0z38SR2BRGizAKQ7NavBa8/4UQ8W0rlKIO2vNBqhSTbzxcXRIPDw==
X-Received: by 2002:a19:4f09:: with SMTP id d9mr3119208lfb.501.1623839834749;
        Wed, 16 Jun 2021 03:37:14 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m17sm205621lfh.288.2021.06.16.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:37:14 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 6/7] optee: separate notification functions
Date:   Wed, 16 Jun 2021 12:36:48 +0200
Message-Id: <20210616103649.2662395-7-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616103649.2662395-1-jens.wiklander@linaro.org>
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renames struct optee_wait_queue to struct optee_notif and all related
functions to optee_notif_*().

The implementation is changed to allow sending a notification from an
atomic state, that is from the top half of an interrupt handler.

Waiting for keys is currently only used when secure world is waiting for
a mutex or condition variable. The old implementation could handle any
32-bit key while this new implementation is restricted to only 8 bits or
the maximum value 255. A upper value is needed since a bitmap is
allocated to allow an interrupt handler to only set a bit in case the
waiter hasn't had the time yet to allocate and register a completion.

The keys are currently only representing secure world threads which
number usually are never even close to 255 so it should be safe for now.
In future ABI updates the maximum value of the key will be communicated
while the driver is initializing.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/core.c          |  13 +++-
 drivers/tee/optee/notif.c         | 125 ++++++++++++++++++++++++++++++
 drivers/tee/optee/optee_private.h |  19 +++--
 drivers/tee/optee/optee_rpc_cmd.h |  31 ++++----
 drivers/tee/optee/rpc.c           |  73 ++---------------
 6 files changed, 171 insertions(+), 91 deletions(-)
 create mode 100644 drivers/tee/optee/notif.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 3aa33ea9e6a6..df55e4ad5370 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_OPTEE) += optee.o
 optee-objs += core.o
 optee-objs += call.o
+optee-objs += notif.o
 optee-objs += rpc.o
 optee-objs += supp.o
 optee-objs += shm_pool.o
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index ddb8f9ecf307..2272696ac986 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -583,6 +583,7 @@ static int optee_remove(struct platform_device *pdev)
 	 */
 	optee_disable_shm_cache(optee);
 
+	optee_notif_uninit(optee);
 	/*
 	 * The two devices have to be unregistered before we can free the
 	 * other resources.
@@ -593,7 +594,6 @@ static int optee_remove(struct platform_device *pdev)
 	tee_shm_pool_free(optee->pool);
 	if (optee->memremaped_shm)
 		memunmap(optee->memremaped_shm);
-	optee_wait_queue_exit(&optee->wait_queue);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
 
@@ -681,18 +681,23 @@ static int optee_probe(struct platform_device *pdev)
 
 	mutex_init(&optee->call_queue.mutex);
 	INIT_LIST_HEAD(&optee->call_queue.waiters);
-	optee_wait_queue_init(&optee->wait_queue);
 	optee_supp_init(&optee->supp);
 	optee->memremaped_shm = memremaped_shm;
 	optee->pool = pool;
 
+	platform_set_drvdata(pdev, optee);
+
+	rc = optee_notif_init(optee, 255);
+	if (rc) {
+		optee_remove(pdev);
+		return rc;
+	}
+
 	optee_enable_shm_cache(optee);
 
 	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
 		pr_info("dynamic shared memory is enabled\n");
 
-	platform_set_drvdata(pdev, optee);
-
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc) {
 		optee_remove(pdev);
diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
new file mode 100644
index 000000000000..a28fa03dcd0e
--- /dev/null
+++ b/drivers/tee/optee/notif.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015-2021, Linaro Limited
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/tee_drv.h>
+#include "optee_private.h"
+
+struct notif_entry {
+	struct list_head link;
+	struct completion c;
+	u_int key;
+};
+
+static bool have_key(struct optee *optee, u_int key)
+{
+	struct notif_entry *entry;
+
+	list_for_each_entry(entry, &optee->notif.db, link)
+		if (entry->key == key)
+			return true;
+
+	return false;
+}
+
+int optee_notif_wait(struct optee *optee, u_int key)
+{
+	unsigned long flags;
+	struct notif_entry *entry;
+	int rc = 0;
+
+	if (key > optee->notif.max_key)
+		return -EINVAL;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	init_completion(&entry->c);
+	entry->key = key;
+
+	spin_lock_irqsave(&optee->notif.lock, flags);
+
+	/*
+	 * If the bit is already set it means that the key has already
+	 * been posted and we must not wait.
+	 */
+	if (test_bit(key, optee->notif.bitmap)) {
+		clear_bit(key, optee->notif.bitmap);
+		goto out;
+	}
+
+	/*
+	 * Check if someone is already waiting for this key. If there is
+	 * it's a programming error.
+	 */
+	if (have_key(optee, key)) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	list_add_tail(&entry->link, &optee->notif.db);
+
+	/*
+	 * Unlock temporarily and wait for completion.
+	 */
+	spin_unlock_irqrestore(&optee->notif.lock, flags);
+	wait_for_completion(&entry->c);
+	spin_lock_irqsave(&optee->notif.lock, flags);
+
+	list_del(&entry->link);
+out:
+	spin_unlock_irqrestore(&optee->notif.lock, flags);
+
+	kfree(entry);
+
+	return rc;
+}
+
+int optee_notif_send(struct optee *optee, u_int key)
+{
+	unsigned long flags;
+	struct notif_entry *entry;
+
+	if (key > optee->notif.max_key)
+		return -EINVAL;
+
+	spin_lock_irqsave(&optee->notif.lock, flags);
+
+	list_for_each_entry(entry, &optee->notif.db, link)
+		if (entry->key == key) {
+			complete(&entry->c);
+			goto out;
+		}
+
+	/* Only set the bit in case there where nobody waiting */
+	set_bit(key, optee->notif.bitmap);
+out:
+	spin_unlock_irqrestore(&optee->notif.lock, flags);
+
+	return 0;
+}
+
+int optee_notif_init(struct optee *optee, u_int max_key)
+{
+	spin_lock_init(&optee->notif.lock);
+	INIT_LIST_HEAD(&optee->notif.db);
+	optee->notif.bitmap = bitmap_zalloc(max_key, GFP_KERNEL);
+	if (!optee->notif.bitmap)
+		return -ENOMEM;
+
+	optee->notif.max_key = max_key;
+
+	return 0;
+}
+
+void optee_notif_uninit(struct optee *optee)
+{
+	kfree(optee->notif.bitmap);
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index e25b216a14ef..7dc058d008b2 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -35,10 +35,12 @@ struct optee_call_queue {
 	struct list_head waiters;
 };
 
-struct optee_wait_queue {
-	/* Serializes access to this struct */
-	struct mutex mu;
+struct optee_notif {
+	u_int max_key;
+	/* Serializes access to the elements below in this struct */
+	spinlock_t lock;
 	struct list_head db;
+	u_long *bitmap;
 };
 
 /**
@@ -72,8 +74,7 @@ struct optee_supp {
  * @teedev:		client device
  * @invoke_fn:		function to issue smc or hvc
  * @call_queue:		queue of threads waiting to call @invoke_fn
- * @wait_queue:		queue of threads from secure world waiting for a
- *			secure world sync object
+ * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
  * @memremaped_shm	virtual address of memory in shared memory pool
@@ -88,7 +89,7 @@ struct optee {
 	struct tee_device *teedev;
 	optee_invoke_fn *invoke_fn;
 	struct optee_call_queue call_queue;
-	struct optee_wait_queue wait_queue;
+	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
 	void *memremaped_shm;
@@ -131,8 +132,10 @@ void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
 		      struct optee_call_ctx *call_ctx);
 void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx);
 
-void optee_wait_queue_init(struct optee_wait_queue *wq);
-void optee_wait_queue_exit(struct optee_wait_queue *wq);
+int optee_notif_init(struct optee *optee, u_int max_key);
+void optee_notif_uninit(struct optee *optee);
+int optee_notif_wait(struct optee *optee, u_int key);
+int optee_notif_send(struct optee *optee, u_int key);
 
 u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 			struct tee_param *param);
diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_cmd.h
index b8275140cef8..f3f06e0994a7 100644
--- a/drivers/tee/optee/optee_rpc_cmd.h
+++ b/drivers/tee/optee/optee_rpc_cmd.h
@@ -28,24 +28,27 @@
 #define OPTEE_RPC_CMD_GET_TIME		3
 
 /*
- * Wait queue primitive, helper for secure world to implement a wait queue.
+ * Notification from/to secure world.
  *
- * If secure world needs to wait for a secure world mutex it issues a sleep
- * request instead of spinning in secure world. Conversely is a wakeup
- * request issued when a secure world mutex with a thread waiting thread is
- * unlocked.
+ * If secure world needs to wait for something, for instance a mutex, it
+ * does a notification wait request instead of spinning in secure world.
+ * Conversely can a synchronous notification can be sent when a secure
+ * world mutex with a thread waiting thread is unlocked.
  *
- * Waiting on a key
- * [in]    value[0].a	    OPTEE_RPC_WAIT_QUEUE_SLEEP
- * [in]    value[0].b	    Wait key
+ * This interface can also be used to wait for a asynchronous notification
+ * which instead is sent via a non-secure interrupt.
  *
- * Waking up a key
- * [in]    value[0].a	    OPTEE_RPC_WAIT_QUEUE_WAKEUP
- * [in]    value[0].b	    Wakeup key
+ * Waiting on notification
+ * [in]    value[0].a	    OPTEE_RPC_NOTIFICATION_WAIT
+ * [in]    value[0].b	    notification value
+ *
+ * Sending a synchronous notification
+ * [in]    value[0].a	    OPTEE_RPC_NOTIFICATION_SEND
+ * [in]    value[0].b	    notification value
  */
-#define OPTEE_RPC_CMD_WAIT_QUEUE	4
-#define OPTEE_RPC_WAIT_QUEUE_SLEEP	0
-#define OPTEE_RPC_WAIT_QUEUE_WAKEUP	1
+#define OPTEE_RPC_CMD_NOTIFICATION	4
+#define OPTEE_RPC_NOTIFICATION_WAIT	0
+#define OPTEE_RPC_NOTIFICATION_SEND	1
 
 /*
  * Suspend execution
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 1849180b0278..e5b931f50db2 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015-2016, Linaro Limited
+ * Copyright (c) 2015-2021, Linaro Limited
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -14,23 +14,6 @@
 #include "optee_smc.h"
 #include "optee_rpc_cmd.h"
 
-struct wq_entry {
-	struct list_head link;
-	struct completion c;
-	u32 key;
-};
-
-void optee_wait_queue_init(struct optee_wait_queue *priv)
-{
-	mutex_init(&priv->mu);
-	INIT_LIST_HEAD(&priv->db);
-}
-
-void optee_wait_queue_exit(struct optee_wait_queue *priv)
-{
-	mutex_destroy(&priv->mu);
-}
-
 static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
 {
 	struct timespec64 ts;
@@ -143,48 +126,6 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 }
 #endif
 
-static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
-{
-	struct wq_entry *w;
-
-	mutex_lock(&wq->mu);
-
-	list_for_each_entry(w, &wq->db, link)
-		if (w->key == key)
-			goto out;
-
-	w = kmalloc(sizeof(*w), GFP_KERNEL);
-	if (w) {
-		init_completion(&w->c);
-		w->key = key;
-		list_add_tail(&w->link, &wq->db);
-	}
-out:
-	mutex_unlock(&wq->mu);
-	return w;
-}
-
-static void wq_sleep(struct optee_wait_queue *wq, u32 key)
-{
-	struct wq_entry *w = wq_entry_get(wq, key);
-
-	if (w) {
-		wait_for_completion(&w->c);
-		mutex_lock(&wq->mu);
-		list_del(&w->link);
-		mutex_unlock(&wq->mu);
-		kfree(w);
-	}
-}
-
-static void wq_wakeup(struct optee_wait_queue *wq, u32 key)
-{
-	struct wq_entry *w = wq_entry_get(wq, key);
-
-	if (w)
-		complete(&w->c);
-}
-
 static void handle_rpc_func_cmd_wq(struct optee *optee,
 				   struct optee_msg_arg *arg)
 {
@@ -196,11 +137,13 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
 		goto bad;
 
 	switch (arg->params[0].u.value.a) {
-	case OPTEE_RPC_WAIT_QUEUE_SLEEP:
-		wq_sleep(&optee->wait_queue, arg->params[0].u.value.b);
+	case OPTEE_RPC_NOTIFICATION_WAIT:
+		if (optee_notif_wait(optee, arg->params[0].u.value.b))
+			goto bad;
 		break;
-	case OPTEE_RPC_WAIT_QUEUE_WAKEUP:
-		wq_wakeup(&optee->wait_queue, arg->params[0].u.value.b);
+	case OPTEE_RPC_NOTIFICATION_SEND:
+		if (optee_notif_send(optee, arg->params[0].u.value.b))
+			goto bad;
 		break;
 	default:
 		goto bad;
@@ -463,7 +406,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
 	case OPTEE_RPC_CMD_GET_TIME:
 		handle_rpc_func_cmd_get_time(arg);
 		break;
-	case OPTEE_RPC_CMD_WAIT_QUEUE:
+	case OPTEE_RPC_CMD_NOTIFICATION:
 		handle_rpc_func_cmd_wq(optee, arg);
 		break;
 	case OPTEE_RPC_CMD_SUSPEND:
-- 
2.31.1

