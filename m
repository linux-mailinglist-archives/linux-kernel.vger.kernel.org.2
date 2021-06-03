Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C6139AED7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhFCXsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:48:43 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:45625 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhFCXsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:48:41 -0400
Received: by mail-wm1-f45.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so337001wmg.4;
        Thu, 03 Jun 2021 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5zwHb5JJpo7v5xTk/X/GqdyEimkvpYSrxpNmqWP23Y=;
        b=bN1w0yQKeM5MbS+v0lz/I/j20yyU0TcE+yfj3f/55xei3sn2yWcNVbx183hhCDWwqm
         Jc5giLduHvXtDmhbX/FHEV3/6x1vdeRq3/YRZuHz5uPtM6VOQJcC/mQy4RrP5BV2n4jP
         +Y1utTAFehpnScXu4gt9QI8sxv9VN5V9QpBXgHHPYTlbl6KOVRTxpCGPxo4lmgNF2TE6
         eOGoCcvvO51q9kcc5aHKaC+wO1V00oKnaiejijdI969ybk67uKezUyQMXRJm9QAAdRME
         vQBn1AiQ7jRr6+no8wAfi5LBeEU0joufINL6sc0jvj/TaDWlCR6DmkpVNi2z5EXHYJat
         99HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5zwHb5JJpo7v5xTk/X/GqdyEimkvpYSrxpNmqWP23Y=;
        b=E8pXfWHTKgQDyqXuq0yEubueNLTZsXD01EpXyfc90qUKr6R5x95Grj320PTTDEcoq2
         4ClpzC/301h7vlBYVXlji4WFZ3l5kXQT+c266eO3GPMoSX3tJ3OHyY+rCn6MIx2fmA6i
         to+KSIYuE6RzB4FHWff1iXHgOTOnBXxOrvIrWZ1UIv/CVV1n+JxWu8h75OaSI5/AVJRN
         LzaWYzNfA+aSeqQZyHkqYdjSwiOuQR6jewKOZdThTHAUM5UAcBFXa8WDsdXo7O9ohZNb
         ahy1zX1Od07k/uvGcLmfXZq8cyruIK8ykTF9N71uiHWO9eYGybHkl5H9E5R0QVwwVqp0
         4/Wg==
X-Gm-Message-State: AOAM532k5pw3CuWI2Fc/jnx+AdBXJr37A9D6fDAz0qQQpp6UV/6yOkCv
        kaIlzM953BHKAf/ciEBRlSI=
X-Google-Smtp-Source: ABdhPJwje2cv3aVrpDJVp0nOgnB3Us+W4tqHIRM6ck4imuzZUnYjDaQ1IDJvevMIx7BL6+/u1fdPMA==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr756207wml.51.1622763947291;
        Thu, 03 Jun 2021 16:45:47 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a11sm4743386wrr.48.2021.06.03.16.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:45:46 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] platform/surface: aggregator_cdev: Add support for forwarding events to user-space
Date:   Fri,  4 Jun 2021 01:45:23 +0200
Message-Id: <20210603234526.2503590-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603234526.2503590-1-luzmaximilian@gmail.com>
References: <20210603234526.2503590-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, debugging unknown events requires writing a custom driver.
This is somewhat difficult, slow to adapt, and not entirely
user-friendly for quickly trying to figure out things on devices of some
third-party user. We can do better. We already have a user-space
interface intended for debugging SAM EC requests, so let's add support
for receiving events to that.

This commit provides support for receiving events by reading from the
controller file. It additionally introduces two new IOCTLs to control
which event categories will be forwarded. Specifically, a user-space
client can specify which target categories it wants to receive events
from by registering the corresponding notifier(s) via the IOCTLs and
after that, read the received events by reading from the controller
device.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +-
 .../surface/surface_aggregator_cdev.c         | 457 +++++++++++++++++-
 include/uapi/linux/surface_aggregator/cdev.h  |  41 +-
 3 files changed, 474 insertions(+), 26 deletions(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 9bfc2b510c64..1409e40e6345 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -325,7 +325,7 @@ Code  Seq#    Include File                                           Comments
 0xA3  90-9F  linux/dtlk.h
 0xA4  00-1F  uapi/linux/tee.h                                        Generic TEE subsystem
 0xA4  00-1F  uapi/asm/sgx.h                                          <mailto:linux-sgx@vger.kernel.org>
-0xA5  01     linux/surface_aggregator/cdev.h                         Microsoft Surface Platform System Aggregator
+0xA5  01-05  linux/surface_aggregator/cdev.h                         Microsoft Surface Platform System Aggregator
                                                                      <mailto:luzmaximilian@gmail.com>
 0xA5  20-2F  linux/surface_aggregator/dtx.h                          Microsoft Surface DTX driver
                                                                      <mailto:luzmaximilian@gmail.com>
diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index 79e28fab7e40..807930144039 100644
--- a/drivers/platform/surface/surface_aggregator_cdev.c
+++ b/drivers/platform/surface/surface_aggregator_cdev.c
@@ -3,29 +3,69 @@
  * Provides user-space access to the SSAM EC via the /dev/surface/aggregator
  * misc device. Intended for debugging and development.
  *
- * Copyright (C) 2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2020-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/fs.h>
+#include <linux/ioctl.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/poll.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/vmalloc.h>
 
 #include <linux/surface_aggregator/cdev.h>
 #include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/serial_hub.h>
 
 #define SSAM_CDEV_DEVICE_NAME	"surface_aggregator_cdev"
 
+
+/* -- Main structures. ------------------------------------------------------ */
+
+enum ssam_cdev_device_state {
+	SSAM_CDEV_DEVICE_SHUTDOWN_BIT = BIT(0),
+};
+
 struct ssam_cdev {
 	struct kref kref;
 	struct rw_semaphore lock;
+
+	struct device *dev;
 	struct ssam_controller *ctrl;
 	struct miscdevice mdev;
+	unsigned long flags;
+
+	struct rw_semaphore client_lock;  /* Guards client list. */
+	struct list_head client_list;
+};
+
+struct ssam_cdev_client;
+
+struct ssam_cdev_notifier {
+	struct ssam_cdev_client *client;
+	struct ssam_event_notifier nf;
+};
+
+struct ssam_cdev_client {
+	struct ssam_cdev *cdev;
+	struct list_head node;
+
+	struct mutex notifier_lock;	/* Guards notifier access for registration */
+	struct ssam_cdev_notifier *notifier[SSH_NUM_EVENTS];
+
+	struct mutex read_lock;		/* Guards FIFO buffer read access */
+	struct mutex write_lock;	/* Guards FIFO buffer write access */
+	DECLARE_KFIFO(buffer, u8, 4096);
+
+	wait_queue_head_t waitq;
+	struct fasync_struct *fasync;
 };
 
 static void __ssam_cdev_release(struct kref *kref)
@@ -47,24 +87,169 @@ static void ssam_cdev_put(struct ssam_cdev *cdev)
 		kref_put(&cdev->kref, __ssam_cdev_release);
 }
 
-static int ssam_cdev_device_open(struct inode *inode, struct file *filp)
+
+/* -- Notifier handling. ---------------------------------------------------- */
+
+static u32 ssam_cdev_notifier(struct ssam_event_notifier *nf, const struct ssam_event *in)
 {
-	struct miscdevice *mdev = filp->private_data;
-	struct ssam_cdev *cdev = container_of(mdev, struct ssam_cdev, mdev);
+	struct ssam_cdev_notifier *cdev_nf = container_of(nf, struct ssam_cdev_notifier, nf);
+	struct ssam_cdev_client *client = cdev_nf->client;
+	struct ssam_cdev_event event;
+	size_t n = struct_size(&event, data, in->length);
+
+	/* Translate event. */
+	event.target_category = in->target_category;
+	event.target_id = in->target_id;
+	event.command_id = in->command_id;
+	event.instance_id = in->instance_id;
+	event.length = in->length;
+
+	mutex_lock(&client->write_lock);
+
+	/* Make sure we have enough space. */
+	if (kfifo_avail(&client->buffer) < n) {
+		dev_warn(client->cdev->dev,
+			 "buffer full, dropping event (tc: %#04x, tid: %#04x, cid: %#04x, iid: %#04x)\n",
+			 in->target_category, in->target_id, in->command_id, in->instance_id);
+		mutex_unlock(&client->write_lock);
+		return 0;
+	}
 
-	filp->private_data = ssam_cdev_get(cdev);
-	return stream_open(inode, filp);
+	/* Copy event header and payload. */
+	kfifo_in(&client->buffer, (const u8 *)&event, struct_size(&event, data, 0));
+	kfifo_in(&client->buffer, &in->data[0], in->length);
+
+	mutex_unlock(&client->write_lock);
+
+	/* Notify waiting readers. */
+	kill_fasync(&client->fasync, SIGIO, POLL_IN);
+	wake_up_interruptible(&client->waitq);
+
+	/*
+	 * Don't mark events as handled, this is the job of a proper driver and
+	 * not the debugging interface.
+	 */
+	return 0;
 }
 
-static int ssam_cdev_device_release(struct inode *inode, struct file *filp)
+static int ssam_cdev_notifier_register(struct ssam_cdev_client *client, u8 tc, int priority)
 {
-	ssam_cdev_put(filp->private_data);
-	return 0;
+	const u16 rqid = ssh_tc_to_rqid(tc);
+	const u16 event = ssh_rqid_to_event(rqid);
+	struct ssam_cdev_notifier *nf;
+	int status;
+
+	/* Validate notifier target category. */
+	if (!ssh_rqid_is_event(rqid))
+		return -EINVAL;
+
+	mutex_lock(&client->notifier_lock);
+
+	/* Check if the notifier has already been registered. */
+	if (client->notifier[event]) {
+		mutex_unlock(&client->notifier_lock);
+		return -EEXIST;
+	}
+
+	/* Allocate new notifier. */
+	nf = kzalloc(sizeof(*nf), GFP_KERNEL);
+	if (!nf) {
+		mutex_unlock(&client->notifier_lock);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Create a dummy notifier with the minimal required fields for
+	 * observer registration. Note that we can skip fully specifying event
+	 * and registry here as we do not need any matching and use silent
+	 * registration, which does not enable the corresponding event.
+	 */
+	nf->client = client;
+	nf->nf.base.fn = ssam_cdev_notifier;
+	nf->nf.base.priority = priority;
+	nf->nf.event.id.target_category = tc;
+	nf->nf.event.mask = 0;	/* Do not do any matching. */
+	nf->nf.flags = SSAM_EVENT_NOTIFIER_OBSERVER;
+
+	/* Register notifier. */
+	status = ssam_notifier_register(client->cdev->ctrl, &nf->nf);
+	if (status)
+		kfree(nf);
+	else
+		client->notifier[event] = nf;
+
+	mutex_unlock(&client->notifier_lock);
+	return status;
 }
 
-static long ssam_cdev_request(struct ssam_cdev *cdev, unsigned long arg)
+static int ssam_cdev_notifier_unregister(struct ssam_cdev_client *client, u8 tc)
+{
+	const u16 rqid = ssh_tc_to_rqid(tc);
+	const u16 event = ssh_rqid_to_event(rqid);
+	int status;
+
+	/* Validate notifier target category. */
+	if (!ssh_rqid_is_event(rqid))
+		return -EINVAL;
+
+	mutex_lock(&client->notifier_lock);
+
+	/* Check if the notifier is currently registered. */
+	if (!client->notifier[event]) {
+		mutex_unlock(&client->notifier_lock);
+		return -ENOENT;
+	}
+
+	/* Unregister and free notifier. */
+	status = ssam_notifier_unregister(client->cdev->ctrl, &client->notifier[event]->nf);
+	kfree(client->notifier[event]);
+	client->notifier[event] = NULL;
+
+	mutex_unlock(&client->notifier_lock);
+	return status;
+}
+
+static void ssam_cdev_notifier_unregister_all(struct ssam_cdev_client *client)
+{
+	int i;
+
+	down_read(&client->cdev->lock);
+
+	/*
+	 * This function may be used during shutdown, thus we need to test for
+	 * cdev->ctrl instead of the SSAM_CDEV_DEVICE_SHUTDOWN_BIT bit.
+	 */
+	if (client->cdev->ctrl) {
+		for (i = 0; i < SSH_NUM_EVENTS; i++)
+			ssam_cdev_notifier_unregister(client, i + 1);
+
+	} else {
+		int count = 0;
+
+		/*
+		 * Device has been shut down. Any notifier remaining is a bug,
+		 * so warn about that as this would otherwise hardly be
+		 * noticeable. Nevertheless, free them as well.
+		 */
+		mutex_lock(&client->notifier_lock);
+		for (i = 0; i < SSH_NUM_EVENTS; i++) {
+			count += !!(client->notifier[i]);
+			kfree(client->notifier[i]);
+			client->notifier[i] = NULL;
+		}
+		mutex_unlock(&client->notifier_lock);
+
+		WARN_ON(count > 0);
+	}
+
+	up_read(&client->cdev->lock);
+}
+
+
+/* -- IOCTL functions. ------------------------------------------------------ */
+
+static long ssam_cdev_request(struct ssam_cdev_client *client, struct ssam_cdev_request __user *r)
 {
-	struct ssam_cdev_request __user *r;
 	struct ssam_cdev_request rqst;
 	struct ssam_request spec = {};
 	struct ssam_response rsp = {};
@@ -72,7 +257,6 @@ static long ssam_cdev_request(struct ssam_cdev *cdev, unsigned long arg)
 	void __user *rspdata;
 	int status = 0, ret = 0, tmp;
 
-	r = (struct ssam_cdev_request __user *)arg;
 	ret = copy_struct_from_user(&rqst, sizeof(rqst), r, sizeof(*r));
 	if (ret)
 		goto out;
@@ -152,7 +336,7 @@ static long ssam_cdev_request(struct ssam_cdev *cdev, unsigned long arg)
 	}
 
 	/* Perform request. */
-	status = ssam_request_sync(cdev->ctrl, &spec, &rsp);
+	status = ssam_request_sync(client->cdev->ctrl, &spec, &rsp);
 	if (status)
 		goto out;
 
@@ -177,48 +361,244 @@ static long ssam_cdev_request(struct ssam_cdev *cdev, unsigned long arg)
 	return ret;
 }
 
-static long __ssam_cdev_device_ioctl(struct ssam_cdev *cdev, unsigned int cmd,
+static long ssam_cdev_notif_register(struct ssam_cdev_client *client,
+				     const struct ssam_cdev_notifier_desc __user *d)
+{
+	struct ssam_cdev_notifier_desc desc;
+	long ret;
+
+	ret = copy_struct_from_user(&desc, sizeof(desc), d, sizeof(*d));
+	if (ret)
+		return ret;
+
+	return ssam_cdev_notifier_register(client, desc.target_category, desc.priority);
+}
+
+static long ssam_cdev_notif_unregister(struct ssam_cdev_client *client,
+				       const struct ssam_cdev_notifier_desc __user *d)
+{
+	struct ssam_cdev_notifier_desc desc;
+	long ret;
+
+	ret = copy_struct_from_user(&desc, sizeof(desc), d, sizeof(*d));
+	if (ret)
+		return ret;
+
+	return ssam_cdev_notifier_unregister(client, desc.target_category);
+}
+
+
+/* -- File operations. ------------------------------------------------------ */
+
+static int ssam_cdev_device_open(struct inode *inode, struct file *filp)
+{
+	struct miscdevice *mdev = filp->private_data;
+	struct ssam_cdev_client *client;
+	struct ssam_cdev *cdev = container_of(mdev, struct ssam_cdev, mdev);
+
+	/* Initialize client */
+	client = vzalloc(sizeof(*client));
+	if (!client)
+		return -ENOMEM;
+
+	client->cdev = ssam_cdev_get(cdev);
+
+	INIT_LIST_HEAD(&client->node);
+
+	mutex_init(&client->notifier_lock);
+
+	mutex_init(&client->read_lock);
+	mutex_init(&client->write_lock);
+	INIT_KFIFO(client->buffer);
+	init_waitqueue_head(&client->waitq);
+
+	filp->private_data = client;
+
+	/* Attach client. */
+	down_write(&cdev->client_lock);
+
+	if (test_bit(SSAM_CDEV_DEVICE_SHUTDOWN_BIT, &cdev->flags)) {
+		up_write(&cdev->client_lock);
+		ssam_cdev_put(client->cdev);
+		vfree(client);
+		return -ENODEV;
+	}
+	list_add_tail(&client->node, &cdev->client_list);
+
+	up_write(&cdev->client_lock);
+
+	stream_open(inode, filp);
+	return 0;
+}
+
+static int ssam_cdev_device_release(struct inode *inode, struct file *filp)
+{
+	struct ssam_cdev_client *client = filp->private_data;
+
+	/* Force-unregister all remaining notifiers of this client. */
+	ssam_cdev_notifier_unregister_all(client);
+
+	/* Detach client. */
+	down_write(&client->cdev->client_lock);
+	list_del(&client->node);
+	up_write(&client->cdev->client_lock);
+
+	/* Free client. */
+	mutex_destroy(&client->write_lock);
+	mutex_destroy(&client->read_lock);
+
+	mutex_destroy(&client->notifier_lock);
+
+	ssam_cdev_put(client->cdev);
+	vfree(client);
+
+	return 0;
+}
+
+static long __ssam_cdev_device_ioctl(struct ssam_cdev_client *client, unsigned int cmd,
 				     unsigned long arg)
 {
 	switch (cmd) {
 	case SSAM_CDEV_REQUEST:
-		return ssam_cdev_request(cdev, arg);
+		return ssam_cdev_request(client, (struct ssam_cdev_request __user *)arg);
+
+	case SSAM_CDEV_NOTIF_REGISTER:
+		return ssam_cdev_notif_register(client,
+						(struct ssam_cdev_notifier_desc __user *)arg);
+
+	case SSAM_CDEV_NOTIF_UNREGISTER:
+		return ssam_cdev_notif_unregister(client,
+						  (struct ssam_cdev_notifier_desc __user *)arg);
 
 	default:
 		return -ENOTTY;
 	}
 }
 
-static long ssam_cdev_device_ioctl(struct file *file, unsigned int cmd,
-				   unsigned long arg)
+static long ssam_cdev_device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct ssam_cdev *cdev = file->private_data;
+	struct ssam_cdev_client *client = file->private_data;
 	long status;
 
 	/* Ensure that controller is valid for as long as we need it. */
+	if (down_read_killable(&client->cdev->lock))
+		return -ERESTARTSYS;
+
+	if (test_bit(SSAM_CDEV_DEVICE_SHUTDOWN_BIT, &client->cdev->flags)) {
+		up_read(&client->cdev->lock);
+		return -ENODEV;
+	}
+
+	status = __ssam_cdev_device_ioctl(client, cmd, arg);
+
+	up_read(&client->cdev->lock);
+	return status;
+}
+
+static ssize_t ssam_cdev_read(struct file *file, char __user *buf, size_t count, loff_t *offs)
+{
+	struct ssam_cdev_client *client = file->private_data;
+	struct ssam_cdev *cdev = client->cdev;
+	unsigned int copied;
+	int status = 0;
+
 	if (down_read_killable(&cdev->lock))
 		return -ERESTARTSYS;
 
-	if (!cdev->ctrl) {
+	/* Make sure we're not shut down. */
+	if (test_bit(SSAM_CDEV_DEVICE_SHUTDOWN_BIT, &cdev->flags)) {
 		up_read(&cdev->lock);
 		return -ENODEV;
 	}
 
-	status = __ssam_cdev_device_ioctl(cdev, cmd, arg);
+	do {
+		/* Check availability, wait if necessary. */
+		if (kfifo_is_empty(&client->buffer)) {
+			up_read(&cdev->lock);
+
+			if (file->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			status = wait_event_interruptible(client->waitq,
+							  !kfifo_is_empty(&client->buffer) ||
+							  test_bit(SSAM_CDEV_DEVICE_SHUTDOWN_BIT,
+								   &cdev->flags));
+			if (status < 0)
+				return status;
+
+			if (down_read_killable(&cdev->lock))
+				return -ERESTARTSYS;
+
+			/* Need to check that we're not shut down again. */
+			if (test_bit(SSAM_CDEV_DEVICE_SHUTDOWN_BIT, &cdev->flags)) {
+				up_read(&cdev->lock);
+				return -ENODEV;
+			}
+		}
+
+		/* Try to read from FIFO. */
+		if (mutex_lock_interruptible(&client->read_lock)) {
+			up_read(&cdev->lock);
+			return -ERESTARTSYS;
+		}
+
+		status = kfifo_to_user(&client->buffer, buf, count, &copied);
+		mutex_unlock(&client->read_lock);
+
+		if (status < 0) {
+			up_read(&cdev->lock);
+			return status;
+		}
+
+		/* We might not have gotten anything, check this here. */
+		if (copied == 0 && (file->f_flags & O_NONBLOCK)) {
+			up_read(&cdev->lock);
+			return -EAGAIN;
+		}
+	} while (copied == 0);
 
 	up_read(&cdev->lock);
-	return status;
+	return copied;
+}
+
+static __poll_t ssam_cdev_poll(struct file *file, struct poll_table_struct *pt)
+{
+	struct ssam_cdev_client *client = file->private_data;
+	__poll_t events = 0;
+
+	if (test_bit(SSAM_CDEV_DEVICE_SHUTDOWN_BIT, &client->cdev->flags))
+		return EPOLLHUP | EPOLLERR;
+
+	poll_wait(file, &client->waitq, pt);
+
+	if (!kfifo_is_empty(&client->buffer))
+		events |= EPOLLIN | EPOLLRDNORM;
+
+	return events;
+}
+
+static int ssam_cdev_fasync(int fd, struct file *file, int on)
+{
+	struct ssam_cdev_client *client = file->private_data;
+
+	return fasync_helper(fd, file, on, &client->fasync);
 }
 
 static const struct file_operations ssam_controller_fops = {
 	.owner          = THIS_MODULE,
 	.open           = ssam_cdev_device_open,
 	.release        = ssam_cdev_device_release,
+	.read           = ssam_cdev_read,
+	.poll           = ssam_cdev_poll,
+	.fasync         = ssam_cdev_fasync,
 	.unlocked_ioctl = ssam_cdev_device_ioctl,
 	.compat_ioctl   = ssam_cdev_device_ioctl,
-	.llseek         = noop_llseek,
+	.llseek         = no_llseek,
 };
 
+
+/* -- Device and driver setup ----------------------------------------------- */
+
 static int ssam_dbg_device_probe(struct platform_device *pdev)
 {
 	struct ssam_controller *ctrl;
@@ -236,6 +616,7 @@ static int ssam_dbg_device_probe(struct platform_device *pdev)
 	kref_init(&cdev->kref);
 	init_rwsem(&cdev->lock);
 	cdev->ctrl = ctrl;
+	cdev->dev = &pdev->dev;
 
 	cdev->mdev.parent   = &pdev->dev;
 	cdev->mdev.minor    = MISC_DYNAMIC_MINOR;
@@ -243,6 +624,9 @@ static int ssam_dbg_device_probe(struct platform_device *pdev)
 	cdev->mdev.nodename = "surface/aggregator";
 	cdev->mdev.fops     = &ssam_controller_fops;
 
+	init_rwsem(&cdev->client_lock);
+	INIT_LIST_HEAD(&cdev->client_list);
+
 	status = misc_register(&cdev->mdev);
 	if (status) {
 		kfree(cdev);
@@ -256,8 +640,32 @@ static int ssam_dbg_device_probe(struct platform_device *pdev)
 static int ssam_dbg_device_remove(struct platform_device *pdev)
 {
 	struct ssam_cdev *cdev = platform_get_drvdata(pdev);
+	struct ssam_cdev_client *client;
 
-	misc_deregister(&cdev->mdev);
+	/*
+	 * Mark device as shut-down. Prevent new clients from being added and
+	 * new operations from being executed.
+	 */
+	set_bit(SSAM_CDEV_DEVICE_SHUTDOWN_BIT, &cdev->flags);
+
+	down_write(&cdev->client_lock);
+
+	/* Remove all notifiers registered by us. */
+	list_for_each_entry(client, &cdev->client_list, node) {
+		ssam_cdev_notifier_unregister_all(client);
+	}
+
+	/* Wake up async clients. */
+	list_for_each_entry(client, &cdev->client_list, node) {
+		kill_fasync(&client->fasync, SIGIO, POLL_HUP);
+	}
+
+	/* Wake up blocking clients. */
+	list_for_each_entry(client, &cdev->client_list, node) {
+		wake_up_interruptible(&client->waitq);
+	}
+
+	up_write(&cdev->client_lock);
 
 	/*
 	 * The controller is only guaranteed to be valid for as long as the
@@ -266,8 +674,11 @@ static int ssam_dbg_device_remove(struct platform_device *pdev)
 	 */
 	down_write(&cdev->lock);
 	cdev->ctrl = NULL;
+	cdev->dev = NULL;
 	up_write(&cdev->lock);
 
+	misc_deregister(&cdev->mdev);
+
 	ssam_cdev_put(cdev);
 	return 0;
 }
diff --git a/include/uapi/linux/surface_aggregator/cdev.h b/include/uapi/linux/surface_aggregator/cdev.h
index fbcce04abfe9..4f393fafc235 100644
--- a/include/uapi/linux/surface_aggregator/cdev.h
+++ b/include/uapi/linux/surface_aggregator/cdev.h
@@ -6,7 +6,7 @@
  * device. This device provides direct user-space access to the SSAM EC.
  * Intended for debugging and development.
  *
- * Copyright (C) 2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2020-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _UAPI_LINUX_SURFACE_AGGREGATOR_CDEV_H
@@ -73,6 +73,43 @@ struct ssam_cdev_request {
 	} response;
 } __attribute__((__packed__));
 
-#define SSAM_CDEV_REQUEST	_IOWR(0xA5, 1, struct ssam_cdev_request)
+/**
+ * struct ssam_cdev_notifier_desc - Notifier descriptor.
+ * @priority:        Priority value determining the order in which notifier
+ *                   callbacks will be called. A higher value means higher
+ *                   priority, i.e. the associated callback will be executed
+ *                   earlier than other (lower priority) callbacks.
+ * @target_category: The event target category for which this notifier should
+ *                   receive events.
+ *
+ * Specifies the notifier that should be registered or unregistered,
+ * specifically with which priority and for which target category of events.
+ */
+struct ssam_cdev_notifier_desc {
+	__s32 priority;
+	__u8 target_category;
+} __attribute__((__packed__));
+
+/**
+ * struct ssam_cdev_event - SSAM event sent by the EC.
+ * @target_category: Target category of the event source. See &enum ssam_ssh_tc.
+ * @target_id:       Target ID of the event source.
+ * @command_id:      Command ID of the event.
+ * @instance_id:     Instance ID of the event source.
+ * @length:          Length of the event payload in bytes.
+ * @data:            Event payload data.
+ */
+struct ssam_cdev_event {
+	__u8 target_category;
+	__u8 target_id;
+	__u8 command_id;
+	__u8 instance_id;
+	__u16 length;
+	__u8 data[];
+} __attribute__((__packed__));
+
+#define SSAM_CDEV_REQUEST		_IOWR(0xA5, 1, struct ssam_cdev_request)
+#define SSAM_CDEV_NOTIF_REGISTER	_IOW(0xA5, 2, struct ssam_cdev_notifier_desc)
+#define SSAM_CDEV_NOTIF_UNREGISTER	_IOW(0xA5, 3, struct ssam_cdev_notifier_desc)
 
 #endif /* _UAPI_LINUX_SURFACE_AGGREGATOR_CDEV_H */
-- 
2.31.1

