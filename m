Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A70B43AE19
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhJZIej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbhJZIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:34:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04029C061224
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:31:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j9so15514074lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+9z2EfdlYsEsGVZoY4HZfXkM9azMHRigSobjHBV2Os=;
        b=PxPJU4agRXE5H4HmioOeSejjQDdu/4DWD9htBoUJoH9pM8l4IWYjKXYYXzooRJgi0e
         E6OtgsK0RAOTsdY21jJ87VaOdxb4PJiCb0hDukXRgoNOUxLbm6zlHpf3JWeM6JWvK2aJ
         abT6NM2CyJzx/POXzXPwQ/x1G9wKybuaSvWlyPbfHM9tP8fTSPrQulsk/HwuXuUXiPeb
         RJ3BMmU8Sae88rfwah2qInPIUuBrD77GgF2CXv/yBATW9+ncvK3/eArUO/2K1nzFpnI9
         1VnhycFAEqGDVr0vNf/nhy0Ek9by+03cbAbmT52ELrtfXVka+TyfijgYNEUvTva6KR4t
         zGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+9z2EfdlYsEsGVZoY4HZfXkM9azMHRigSobjHBV2Os=;
        b=Cldov5BCixc2/iDt9L0wKsMGpZrwh5iprUcdUv0o0xtZUquxX0NLHkt+JIIU/l7Kw/
         98MSoz+K5Ej/5uLSNrY6v/qfV7YJldwCkjqeG+2/W3fY+yxzfH9RB9Vu2peI3Owvfael
         LYMYJH8PQI6qj9Ngig7GKT64GGLhJg2JGEGMnbvPuGsKZTTO0Im6xXX01X+Z6oou1Om1
         uLN/Ic2+4sbPCDf4SSLVz6QLvPWXtPnvo1XizrX0hoSpyeBRaSBQcQBioaBQuQcbM2tD
         Z1tTqESShn4k7CM27O6y9xEcoULusRmyn0OgHOP5r4zctAmuGrMVWZoCkL77jFDXz/M4
         155g==
X-Gm-Message-State: AOAM531WRZ9te8l9G7LhqkKy1AtI5cD9rCyzowlP4ATA3KnePACCE2Nx
        6YZA0pxZfQU0rAjwwcTGJClkWFQLYn9+nUsB
X-Google-Smtp-Source: ABdhPJzjLW6D/YDxnfsYAhy/KEjZD7cgaKMoRqX1eqJxgpq/IvjFsHj+qwOJ5NwFXriVIIBTau/57w==
X-Received: by 2002:ac2:4309:: with SMTP id l9mr21517443lfh.667.1635237108113;
        Tue, 26 Oct 2021 01:31:48 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id e4sm1944598ljn.131.2021.10.26.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 01:31:47 -0700 (PDT)
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
        Marc Zyngier <maz@kernel.org>, jens.vankeirsbilck@kuleuven.be,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 5/6] optee: separate notification functions
Date:   Tue, 26 Oct 2021 10:31:37 +0200
Message-Id: <20211026083138.1818705-6-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026083138.1818705-1-jens.wiklander@linaro.org>
References: <20211026083138.1818705-1-jens.wiklander@linaro.org>
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

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/core.c          |   2 +-
 drivers/tee/optee/ffa_abi.c       |   6 +-
 drivers/tee/optee/notif.c         | 125 ++++++++++++++++++++++++++++++
 drivers/tee/optee/optee_private.h |  26 +++++--
 drivers/tee/optee/optee_rpc_cmd.h |  31 ++++----
 drivers/tee/optee/rpc.c           |  71 ++---------------
 drivers/tee/optee/smc_abi.c       |  10 ++-
 8 files changed, 181 insertions(+), 91 deletions(-)
 create mode 100644 drivers/tee/optee/notif.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 66b8a17f14c4..a6eff388d300 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_OPTEE) += optee.o
 optee-objs += core.o
 optee-objs += call.o
+optee-objs += notif.o
 optee-objs += rpc.o
 optee-objs += supp.o
 optee-objs += device.o
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index ab2edfcc6c70..ba7300ca9ddf 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -159,6 +159,7 @@ void optee_remove_common(struct optee *optee)
 	/* Unregister OP-TEE specific client devices on TEE bus */
 	optee_unregister_devices();
 
+	optee_notif_uninit(optee);
 	/*
 	 * The two devices have to be unregistered before we can free the
 	 * other resources.
@@ -167,7 +168,6 @@ void optee_remove_common(struct optee *optee)
 	tee_device_unregister(optee->teedev);
 
 	tee_shm_pool_free(optee->pool);
-	optee_wait_queue_exit(&optee->wait_queue);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
 }
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 6defd1ec982a..4a3e28b3270c 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -856,9 +856,13 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	mutex_init(&optee->ffa.mutex);
 	mutex_init(&optee->call_queue.mutex);
 	INIT_LIST_HEAD(&optee->call_queue.waiters);
-	optee_wait_queue_init(&optee->wait_queue);
 	optee_supp_init(&optee->supp);
 	ffa_dev_set_drvdata(ffa_dev, optee);
+	rc = optee_notif_init(optee, OPTEE_DEFAULT_MAX_NOTIF_VALUE);
+	if (rc) {
+		optee_ffa_remove(ffa_dev);
+		return rc;
+	}
 
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc) {
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
index 6660e05298db..68fd28f8c6e9 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -28,6 +28,13 @@
 
 #define TEEC_ORIGIN_COMMS		0x00000002
 
+/*
+ * This value should be larger than the number threads in secure world to
+ * meet the need from secure world. The number of threads in secure world
+ * are usually not even close to 255 so we should be safe for now.
+ */
+#define OPTEE_DEFAULT_MAX_NOTIF_VALUE	255
+
 typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
 				unsigned long, unsigned long, unsigned long,
 				unsigned long, unsigned long,
@@ -44,10 +51,12 @@ struct optee_call_queue {
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
@@ -129,8 +138,7 @@ struct optee_ops {
  * @smc:		specific to SMC ABI
  * @ffa:		specific to FF-A ABI
  * @call_queue:		queue of threads waiting to call @invoke_fn
- * @wait_queue:		queue of threads from secure world waiting for a
- *			secure world sync object
+ * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
  * @rpc_arg_count:	If > 0 number of RPC parameters to make room for
@@ -147,7 +155,7 @@ struct optee {
 		struct optee_ffa ffa;
 	};
 	struct optee_call_queue call_queue;
-	struct optee_wait_queue wait_queue;
+	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
 	unsigned int rpc_arg_count;
@@ -185,8 +193,10 @@ struct optee_call_ctx {
 	size_t num_entries;
 };
 
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
index cd642e340eaf..e69bc6380683 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -12,23 +12,6 @@
 #include "optee_private.h"
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
@@ -144,48 +127,6 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
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
@@ -197,11 +138,13 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
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
@@ -319,7 +262,7 @@ void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
 	case OPTEE_RPC_CMD_GET_TIME:
 		handle_rpc_func_cmd_get_time(arg);
 		break;
-	case OPTEE_RPC_CMD_WAIT_QUEUE:
+	case OPTEE_RPC_CMD_NOTIFICATION:
 		handle_rpc_func_cmd_wq(optee, arg);
 		break;
 	case OPTEE_RPC_CMD_SUSPEND:
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 6196d7c3888f..00a7ff00a7c0 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1288,11 +1288,17 @@ static int optee_probe(struct platform_device *pdev)
 
 	mutex_init(&optee->call_queue.mutex);
 	INIT_LIST_HEAD(&optee->call_queue.waiters);
-	optee_wait_queue_init(&optee->wait_queue);
 	optee_supp_init(&optee->supp);
 	optee->smc.memremaped_shm = memremaped_shm;
 	optee->pool = pool;
 
+	platform_set_drvdata(pdev, optee);
+	rc = optee_notif_init(optee, OPTEE_DEFAULT_MAX_NOTIF_VALUE);
+	if (rc) {
+		optee_remove(pdev);
+		return rc;
+	}
+
 	/*
 	 * Ensure that there are no pre-existing shm objects before enabling
 	 * the shm cache so that there's no chance of receiving an invalid
@@ -1307,8 +1313,6 @@ static int optee_probe(struct platform_device *pdev)
 	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
 		pr_info("dynamic shared memory is enabled\n");
 
-	platform_set_drvdata(pdev, optee);
-
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc) {
 		optee_smc_remove(pdev);
-- 
2.31.1

