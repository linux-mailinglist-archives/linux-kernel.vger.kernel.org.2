Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB141441A74
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhKALM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhKALM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:12:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB16C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 04:09:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y4so1626754pfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 04:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjP7EiSip2lMP++fVvZN1YkNdLGyaDvQGVduRDBFuEw=;
        b=R6a3GQVvMF+u/duUgdYMWT7Pkja+oWaZga8QGUWWXZLX8pYAVi6hELRUVfJ8DM4r5W
         YZRlXaRGyBi8Wl4QRSO/kYDm+4+4OEQSxvlfD9sgDNAdhxVLt9zUxZG90fkL92zG0dAk
         WMwimMXCkatikiO+PzTctdWNy5knMx11hW4J09t4Bsf01HaVqDcMIJ/fxqyrFjKpvzh1
         wv3D8spLgrEzh4I+6JM+bU5y8O7fgcI83K1FjGEMn9c8RSkaKTbWpy8QeRzq/AciI215
         RJmo3vFRF/KHqwCpJRhBTiccz7GUY4zpXzlBUbT4bNzWPpEl8SvYuahFEXO1vFX9tsds
         mTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjP7EiSip2lMP++fVvZN1YkNdLGyaDvQGVduRDBFuEw=;
        b=jJ4E9Ibs8g0csEPNeTDmDkwuXTHY1EzjwjXyLpUO43Qh5SXNeh8bIpqNN0MlhQWdF8
         YHlI8+WJYLDKDVfy3V372kNNd2jQcABrCGmjIl4IyTwrpXBEWDQT0BPjOv4qxVWOws1k
         fHTp+cG8mx65f52gCVJtHsf+fzbRX/hRgulnCqHeX2xlXs5aT9T26aR6nCxiEreGIwrX
         2BH3yJM211PChKawagTSvxM9xl7qxs4NkraYDjjNjYSjdTVm2YiVDyLeSvu3aAPn5e1J
         +T7myaHoSaBaotCt+XS3HUwcq8ZAONyEaiv9qaR6SlfejcHMlp6BmxOAWa/TU8zfrUlk
         Lt6A==
X-Gm-Message-State: AOAM531Kw2/RQCFEx/+nGiSn2VrYQOk/N9b/cWVNXXi4dtm3Cs3rkXPk
        U3LmfYOdybbUAhOpLPnU72U=
X-Google-Smtp-Source: ABdhPJyn4aJwwWubcR0Gq8Sm41vqA0DKeUnAkTNg6Q0ci5cdCxeuyjKbfiAwN1dt+xh/HmjWhQIV3g==
X-Received: by 2002:a05:6a00:138c:b0:480:fb91:8123 with SMTP id t12-20020a056a00138c00b00480fb918123mr655719pfg.17.1635764994691;
        Mon, 01 Nov 2021 04:09:54 -0700 (PDT)
Received: from localhost.localdomain ([122.161.50.72])
        by smtp.googlemail.com with ESMTPSA id m15sm13355451pjf.49.2021.11.01.04.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 04:09:54 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com
Cc:     dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] staging: vchiq: Replace global state with per device state
Date:   Mon,  1 Nov 2021 16:39:21 +0530
Message-Id: <5b51970f601c4bf5165fc70174085a809b3c0316.1635764115.git.ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635764115.git.ojaswin98@gmail.com>
References: <cover.1635764115.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver has a global g_state variable which is initialised
during probe and directly used all over the driver code. However, this
prevents the driver to support multiple VideoCore VPUs at the same time.

Replace this global state with a per device state which is initialised
and allocated during probing.

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 100 ++++++++++++++----
 .../interface/vchiq_arm/vchiq_arm.h           |  12 ++-
 .../interface/vchiq_arm/vchiq_core.c          |   2 +-
 .../interface/vchiq_arm/vchiq_core.h          |   3 +-
 .../interface/vchiq_arm/vchiq_dev.c           |  64 +++++++----
 5 files changed, 138 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index c650a32bcedf..a6ad0829c7e8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -63,7 +63,7 @@ int vchiq_arm_log_level = VCHIQ_LOG_DEFAULT;
 int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
 
 DEFINE_SPINLOCK(msg_queue_spinlock);
-struct vchiq_state g_state;
+static struct vchiq_state *g_state;
 
 static struct platform_device *bcm2835_camera;
 static struct platform_device *bcm2835_audio;
@@ -156,6 +156,13 @@ static enum vchiq_status
 vchiq_blocking_bulk_transfer(unsigned int handle, void *data,
 			     unsigned int size, enum vchiq_bulk_dir dir);
 
+/* Accessor function for static state variable */
+static inline struct vchiq_state *
+vchiq_get_state(void)
+{
+	return g_state;
+}
+
 static irqreturn_t
 vchiq_doorbell_irq(int irq, void *dev_id)
 {
@@ -652,6 +659,17 @@ int vchiq_dump_platform_state(void *dump_context)
 #define VCHIQ_INIT_RETRIES 10
 int vchiq_initialise(struct vchiq_instance **instance_out)
 {
+	/*
+	 * TODO: vchiq_initialise is called from either the IOCTL functions of
+	 * the cdev or from other kernel modules directly. When called from ioctl
+	 * we have a reference to the state and we can pass it in, but this is not
+	 * possible when calling it from a different kernel module.
+	 *
+	 * This forces us to use a global state in the driver, which is not ideal
+	 * if we want to support multiple devices with a single driver. We need to
+	 * find a way around this
+	 */
+
 	struct vchiq_state *state;
 	struct vchiq_instance *instance = NULL;
 	int i, ret;
@@ -663,7 +681,7 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
 	 */
 	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
 		state = vchiq_get_state();
-		if (state)
+		if (vchiq_validate_state(state))
 			break;
 		usleep_range(500, 600);
 	}
@@ -984,9 +1002,10 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	       void *bulk_userdata)
 {
 	struct vchiq_completion_data_kernel *completion;
+	struct vchiq_state *state = instance->state;
 	int insert;
 
-	DEBUG_INITIALISE(g_state.local);
+	DEBUG_INITIALISE(state->local);
 
 	insert = instance->completion_insert;
 	while ((insert - instance->completion_remove) >= MAX_COMPLETIONS) {
@@ -1052,12 +1071,9 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 	struct user_service *user_service;
 	struct vchiq_service *service;
 	struct vchiq_instance *instance;
+	struct vchiq_state *state;
 	bool skip_completion = false;
 
-	DEBUG_INITIALISE(g_state.local);
-
-	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-
 	service = handle_to_service(handle);
 	if (WARN_ON(!service))
 		return VCHIQ_SUCCESS;
@@ -1065,6 +1081,12 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 	user_service = (struct user_service *)service->base.userdata;
 	instance = user_service->instance;
 
+	state = instance->state;
+
+	DEBUG_INITIALISE(state->local);
+
+	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+
 	if (!instance || instance->closing)
 		return VCHIQ_SUCCESS;
 
@@ -1186,13 +1208,15 @@ int vchiq_dump(void *dump_context, const char *str, int len)
 	return 0;
 }
 
-int vchiq_dump_platform_instances(void *dump_context)
+int vchiq_dump_platform_instances(void *dump_context, struct vchiq_state *state)
 {
-	struct vchiq_state *state = vchiq_get_state();
 	char buf[80];
 	int len;
 	int i;
 
+	if (!vchiq_validate_state(state))
+		return -EINVAL;
+
 	/*
 	 * There is no list of instances, so instead scan all services,
 	 * marking those that have been dumped.
@@ -1271,17 +1295,25 @@ int vchiq_dump_platform_service_state(void *dump_context,
 	return vchiq_dump(dump_context, buf, len + 1);
 }
 
+/**
+ *	vchiq_validate_state -	Validate the state. Return NULL if invalid
+ *				else return the state back
+ *
+ *	@state			The state to validate
+ *
+ *	Returns unchanged state if state is valid, else returns NULL.
+ */
 struct vchiq_state *
-vchiq_get_state(void)
+vchiq_validate_state(struct vchiq_state *state)
 {
-	if (!g_state.remote)
-		pr_err("%s: g_state.remote == NULL\n", __func__);
-	else if (g_state.remote->initialised != 1)
-		pr_notice("%s: g_state.remote->initialised != 1 (%d)\n",
-			  __func__, g_state.remote->initialised);
-
-	return (g_state.remote &&
-		(g_state.remote->initialised == 1)) ? &g_state : NULL;
+	if (!state->remote)
+		pr_err("%s: state->remote == NULL\n", __func__);
+	else if (state->remote->initialised != 1)
+		pr_notice("%s: state->remote->initialised != 1 (%d)\n",
+			  __func__, state->remote->initialised);
+
+	return (state->remote &&
+		(state->remote->initialised == 1)) ? state : NULL;
 }
 
 /*
@@ -1763,6 +1795,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	struct device_node *fw_node;
 	const struct of_device_id *of_id;
 	struct vchiq_drvdata *drvdata;
+	struct vchiq_device *vchiq_dev;
 	int err;
 
 	of_id = of_match_node(vchiq_of_match, pdev->dev.of_node);
@@ -1784,7 +1817,18 @@ static int vchiq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, drvdata);
 
-	err = vchiq_platform_init(pdev, &g_state);
+	vchiq_dev = kzalloc(sizeof(struct vchiq_device), GFP_KERNEL);
+	vchiq_dev->state = kzalloc(sizeof(struct vchiq_state), GFP_KERNEL);
+	vchiq_dev->vchiq_pdev = *pdev;
+
+	g_state = vchiq_dev->state;
+
+	if (!vchiq_dev || !vchiq_dev->state) {
+		dev_err(&pdev->dev, "Out of memory\n");
+		return -ENOMEM;
+	}
+
+	err = vchiq_platform_init(pdev, vchiq_dev->state);
 	if (err)
 		goto failed_platform_init;
 
@@ -1798,7 +1842,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	 * Simply exit on error since the function handles cleanup in
 	 * cases of failure.
 	 */
-	err = vchiq_register_chrdev(&pdev->dev);
+	err = vchiq_register_chrdev(vchiq_dev);
 	if (err) {
 		vchiq_log_warning(vchiq_arm_log_level,
 				  "Failed to initialize vchiq cdev");
@@ -1811,6 +1855,12 @@ static int vchiq_probe(struct platform_device *pdev)
 	return 0;
 
 failed_platform_init:
+	kfree(vchiq_dev->state);
+	vchiq_dev->state = NULL;
+
+	kfree(vchiq_dev);
+	vchiq_dev = NULL;
+
 	vchiq_log_warning(vchiq_arm_log_level, "could not initialize vchiq platform");
 error_exit:
 	return err;
@@ -1818,11 +1868,21 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static int vchiq_remove(struct platform_device *pdev)
 {
+	struct vchiq_device *vchiq_dev;
+
 	platform_device_unregister(bcm2835_audio);
 	platform_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
 
+	vchiq_dev = container_of(pdev, struct vchiq_device, vchiq_pdev);
+
+	kfree(vchiq_dev->state);
+	vchiq_dev->state = NULL;
+
+	kfree(vchiq_dev);
+	vchiq_dev = NULL;
+
 	return 0;
 }
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 2aa46b119a46..8a1d803a3423 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -69,6 +69,13 @@ struct vchiq_instance {
 	struct vchiq_debugfs_node debugfs_node;
 };
 
+/* Used to store per device information */
+struct vchiq_device {
+	struct vchiq_state *state;
+	struct miscdevice mdev;
+	struct platform_device vchiq_pdev;
+};
+
 struct dump_context {
 	char __user *buf;
 	size_t actual;
@@ -80,10 +87,9 @@ extern int vchiq_arm_log_level;
 extern int vchiq_susp_log_level;
 
 extern spinlock_t msg_queue_spinlock;
-extern struct vchiq_state g_state;
 
 extern struct vchiq_state *
-vchiq_get_state(void);
+vchiq_validate_state(struct vchiq_state *state);
 
 enum vchiq_status
 vchiq_use_service(unsigned int handle);
@@ -128,7 +134,7 @@ extern void
 vchiq_deregister_chrdev(void);
 
 extern int
-vchiq_register_chrdev(struct device *parent);
+vchiq_register_chrdev(struct vchiq_device *vdev);
 
 #else
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index ab97a35e63f9..30ca1eba658d 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3515,7 +3515,7 @@ int vchiq_dump_state(void *dump_context, struct vchiq_state *state)
 	if (err)
 		return err;
 
-	err = vchiq_dump_platform_instances(dump_context);
+	err = vchiq_dump_platform_instances(dump_context, state);
 	if (err)
 		return err;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 3e50910ecba3..6c321b959a20 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -11,6 +11,7 @@
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
 #include <linux/raspberrypi/vchiq.h>
+#include <linux/miscdevice.h>
 
 #include "vchiq_cfg.h"
 
@@ -570,7 +571,7 @@ int vchiq_dump(void *dump_context, const char *str, int len);
 
 int vchiq_dump_platform_state(void *dump_context);
 
-int vchiq_dump_platform_instances(void *dump_context);
+int vchiq_dump_platform_instances(void *dump_context, struct vchiq_state *state);
 
 int vchiq_dump_platform_service_state(void *dump_context, struct vchiq_service *service);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 2325844b0880..e208f334af2b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -39,6 +39,11 @@ static const char *const ioctl_names[] = {
 
 static_assert(ARRAY_SIZE(ioctl_names) == (VCHIQ_IOC_MAX + 1));
 
+static inline struct vchiq_device *to_vchiq_device(struct miscdevice *mdev)
+{
+	return container_of(mdev, struct vchiq_device, mdev);
+}
+
 static void
 user_service_free(void *userdata)
 {
@@ -208,9 +213,10 @@ static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
 	struct user_service *user_service;
 	struct vchiq_service *service;
 	struct vchiq_header *header;
+	struct vchiq_state *state = instance->state;
 	int ret;
 
-	DEBUG_INITIALISE(g_state.local);
+	DEBUG_INITIALISE(state->local);
 	DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
 	service = find_service_for_instance(instance, args->handle);
 	if (!service)
@@ -435,12 +441,12 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 				      struct vchiq_await_completion *args,
 				      int __user *msgbufcountp)
 {
+	struct vchiq_state *state = instance->state;
 	int msgbufcount;
 	int remove;
 	int ret;
 
-	DEBUG_INITIALISE(g_state.local);
-
+	DEBUG_INITIALISE(state->local);
 	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
 	if (!instance->connected)
 		return -ENOTCONN;
@@ -1167,12 +1173,19 @@ vchiq_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int vchiq_open(struct inode *inode, struct file *file)
 {
-	struct vchiq_state *state = vchiq_get_state();
 	struct vchiq_instance *instance;
+	struct vchiq_state *state;
+	struct vchiq_device *vdev;
+	struct miscdevice *mdev;
+
+	mdev = file->private_data;
+
+	vdev = to_vchiq_device(mdev);
+	state = vdev->state;
 
 	vchiq_log_info(vchiq_arm_log_level, "vchiq_open");
 
-	if (!state) {
+	if (!vchiq_validate_state(state)) {
 		vchiq_log_error(vchiq_arm_log_level,
 				"vchiq has no connection to VideoCore");
 		return -ENOTCONN;
@@ -1201,7 +1214,7 @@ static int vchiq_open(struct inode *inode, struct file *file)
 static int vchiq_release(struct inode *inode, struct file *file)
 {
 	struct vchiq_instance *instance = file->private_data;
-	struct vchiq_state *state = vchiq_get_state();
+	struct vchiq_state *state = instance->state;
 	struct vchiq_service *service;
 	int ret = 0;
 	int i;
@@ -1209,7 +1222,7 @@ static int vchiq_release(struct inode *inode, struct file *file)
 	vchiq_log_info(vchiq_arm_log_level, "%s: instance=%lx", __func__,
 		       (unsigned long)instance);
 
-	if (!state) {
+	if (!vchiq_validate_state(state)) {
 		ret = -EPERM;
 		goto out;
 	}
@@ -1310,6 +1323,8 @@ static ssize_t
 vchiq_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct dump_context context;
+	struct vchiq_instance *instance = file->private_data;
+	struct vchiq_state *state = instance->state;
 	int err;
 
 	context.buf = buf;
@@ -1317,7 +1332,7 @@ vchiq_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	context.space = count;
 	context.offset = *ppos;
 
-	err = vchiq_dump_state(&context, &g_state);
+	err = vchiq_dump_state(&context, state);
 	if (err)
 		return err;
 
@@ -1338,12 +1353,7 @@ vchiq_fops = {
 	.read = vchiq_read
 };
 
-static struct miscdevice vchiq_miscdev = {
-	.fops = &vchiq_fops,
-	.minor = MISC_DYNAMIC_MINOR,
-	.name = "vchiq",
-
-};
+static struct miscdevice *vchiq_miscdev;
 
 /**
  *	vchiq_register_chrdev - Register the char driver for vchiq
@@ -1353,11 +1363,25 @@ static struct miscdevice vchiq_miscdev = {
  *
  *	Returns 0 on success else returns the error code.
  */
-int vchiq_register_chrdev(struct device *parent)
+int vchiq_register_chrdev(struct vchiq_device *vdev)
 {
-	vchiq_miscdev.parent = parent;
+	int err;
+
+	vdev->mdev.fops = &vchiq_fops;
+	vdev->mdev.minor = MISC_DYNAMIC_MINOR;
+	vdev->mdev.parent = &vdev->vchiq_pdev.dev;
+	// TODO: Dynamically allocate name here
+	vdev->mdev.name = "vchiq";
+
+	err = misc_register(&vdev->mdev);
+	if (err) {
+		goto error;
+	}
+
+	vchiq_miscdev = &vdev->mdev;
 
-	return misc_register(&vchiq_miscdev);
+error:
+	return err;
 }
 
 /**
@@ -1366,5 +1390,9 @@ int vchiq_register_chrdev(struct device *parent)
  */
 void vchiq_deregister_chrdev(void)
 {
-	misc_deregister(&vchiq_miscdev);
+	// TODO: This deregsiter will not be able to handle multiple devices
+	// since the vchiq_miscdev pointer will always point to the most recent
+	// cdev.
+	misc_deregister(vchiq_miscdev);
+	vchiq_miscdev = NULL;
 }
-- 
2.25.1

