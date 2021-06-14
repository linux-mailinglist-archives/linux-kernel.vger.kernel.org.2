Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480B83A6F30
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhFNTgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:36:22 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34730 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbhFNTgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:36:19 -0400
Received: by mail-pg1-f173.google.com with SMTP id g22so4406511pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8D59ook5WFfYYoXNhVbW5VqJDEMvKrUIizCE9OvRW8s=;
        b=HUz3pP30ULImz2f4pLxf7G90pTMaAZNcqD4WCQjsmmzkwrJQlPN95RXoFh0pvblO2e
         q4I/ZoUAxpA+UyzJXpkTJXMg/jCNmj5DlPcq5VWDDMx0hJZHX8CuFLLGGw5LxC1CvBI1
         wFxIfdmSVu/frV9clDfVoSiHNrPAv9NW6W5Z+YUhYlxo2ypi559XzxPFE+wDRVfF3prE
         t/Yoj3Cxb0dDK1wBR3RRu3rdSM59vzuYrn+mSMkT5aWlDHRlGKYbLrd8Gr/pFZJWcLwj
         r9p1HuK7Gf5awqnT9k66tlTPD+VWVwUbg1MBQrTD5EQz2Cdns+epP0Gohk/niyBEyFlz
         FFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8D59ook5WFfYYoXNhVbW5VqJDEMvKrUIizCE9OvRW8s=;
        b=WcWud53qdlhKBgCAQ0PNiSGKDjKgMqsGgsZ+5tc5mJjL8xx9ELabvklWEyZk0jIesW
         PBjmbM9JrKO9Pn4vMRB/bKTFJblnRlza4yyko8Tjc4EmybDHZjMjaGHen4hCQ1Ubua4t
         kTkQC6KOQ8niJDT42Q9aQKAfCgAA5lnHYYXBdzpet9+6QFtNJlnKVXtdXFh0dFU8JMgT
         JLtXVL5efELyj2IknLyPAlR4KtWBpg+1DXnW4gHkX6yUycbPvXBo7UoeGJF+TFED1+yE
         +iJLOUbZOFO8BzXk1iYHMYGQUyqrMlkSfR6DrcIRKJ4M15NNRJ3yCGbCr7tieA9W/YXR
         Y5vg==
X-Gm-Message-State: AOAM531A/iSGZG5ygOo+MwKhnDFBM5uzEVQBV+SHzmp0xiG8ppvFeIpI
        +AYnSU4/CiCu5isCNYZJzJs=
X-Google-Smtp-Source: ABdhPJycFUIToF75FtPWxuALpRVwnWDdnnQZ1uplLIc42L97OS1O5SQa+teD7bVJ6eSEscRcaweTGw==
X-Received: by 2002:a63:4b59:: with SMTP id k25mr18537984pgl.252.1623699195372;
        Mon, 14 Jun 2021 12:33:15 -0700 (PDT)
Received: from ojas ([122.177.234.250])
        by smtp.gmail.com with ESMTPSA id c15sm14302407pgt.68.2021.06.14.12.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:33:14 -0700 (PDT)
Date:   Tue, 15 Jun 2021 01:03:03 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        phil@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] staging: vchiq: Move vchiq char driver to its own file
Message-ID: <921016d9ce7dcb261ec01f9ed070ef56399ab512.1623698773.git.ojaswin98@gmail.com>
References: <cover.1623698773.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623698773.git.ojaswin98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the initialization and creation of vchiq char driver and device
files from the vchiq platform initialisation code. The char driver code
now resides in vchiq_dev.c and the platform code resides in the original
vchiq_arm.c file.

This commit focuses on separating the code into different files while
maintaining the same functionality. It does not completely decouple them
as the cdev init code is still called from the platform's vchiq_probe()
function.

Summary of changes:

 *  Definition of functions and variables shared by cdev and platform
    code are moved to vchiq_arm.h while declaration stays in vchiq_arm.c

 *  Declaration and definition of functions and variables only used by
    cdev code are moved to vchiq_dev.c file.

 *  Defined vchiq_deregister_chrdev() and vchiq_register_chrdev(..) in
    vchiq_dev.c which handle cdev creation and deletion. They are called
    by the platfrom code during probe().

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 drivers/staging/vc04_services/Makefile        |    1 +
 .../interface/vchiq_arm/vchiq_arm.c           | 1885 ++---------------
 .../interface/vchiq_arm/vchiq_arm.h           |   73 +
 .../interface/vchiq_arm/vchiq_dev.c           | 1488 +++++++++++++
 4 files changed, 1770 insertions(+), 1677 deletions(-)
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c

diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index fc42251ec5ef..700cd62fe346 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -7,6 +7,7 @@ vchiq-objs := \
    interface/vchiq_arm/vchiq_2835_arm.o \
    interface/vchiq_arm/vchiq_debugfs.o \
    interface/vchiq_arm/vchiq_connected.o \
+   interface/vchiq_arm/vchiq_dev.o \
 
 obj-$(CONFIG_SND_BCM2835)		+= bcm2835-audio/
 obj-$(CONFIG_VIDEO_BCM2835)		+= bcm2835-camera/
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index a936102dbc34..480bb328c215 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -38,12 +38,6 @@
 #undef MODULE_PARAM_PREFIX
 #define MODULE_PARAM_PREFIX DEVICE_NAME "."
 
-/* Some per-instance constants */
-#define MAX_COMPLETIONS 128
-#define MAX_SERVICES 64
-#define MAX_ELEMENTS 8
-#define MSG_QUEUE_SIZE 128
-
 #define KEEPALIVE_VER 1
 #define KEEPALIVE_VER_MIN KEEPALIVE_VER
 
@@ -51,62 +45,9 @@
 int vchiq_arm_log_level = VCHIQ_LOG_DEFAULT;
 int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
 
-struct user_service {
-	struct vchiq_service *service;
-	void __user *userdata;
-	struct vchiq_instance *instance;
-	char is_vchi;
-	char dequeue_pending;
-	char close_pending;
-	int message_available_pos;
-	int msg_insert;
-	int msg_remove;
-	struct completion insert_event;
-	struct completion remove_event;
-	struct completion close_event;
-	struct vchiq_header *msg_queue[MSG_QUEUE_SIZE];
-};
-
-struct bulk_waiter_node {
-	struct bulk_waiter bulk_waiter;
-	int pid;
-	struct list_head list;
-};
-
-struct vchiq_instance {
-	struct vchiq_state *state;
-	struct vchiq_completion_data_kernel completions[MAX_COMPLETIONS];
-	int completion_insert;
-	int completion_remove;
-	struct completion insert_event;
-	struct completion remove_event;
-	struct mutex completion_mutex;
-
-	int connected;
-	int closing;
-	int pid;
-	int mark;
-	int use_close_delivered;
-	int trace;
-
-	struct list_head bulk_waiter_list;
-	struct mutex bulk_waiter_list_mutex;
-
-	struct vchiq_debugfs_node debugfs_node;
-};
-
-struct dump_context {
-	char __user *buf;
-	size_t actual;
-	size_t space;
-	loff_t offset;
-};
+struct vchiq_state g_state;
+DEFINE_SPINLOCK(msg_queue_spinlock);
 
-static struct cdev    vchiq_cdev;
-static dev_t          vchiq_devid;
-static struct vchiq_state g_state;
-static struct class  *vchiq_class;
-static DEFINE_SPINLOCK(msg_queue_spinlock);
 static struct platform_device *bcm2835_camera;
 static struct platform_device *bcm2835_audio;
 static struct platform_device *bcm2835_codec;
@@ -126,30 +67,6 @@ static struct vchiq_drvdata bcm2711_drvdata = {
 	.use_36bit_addrs = true,
 };
 
-static const char *const ioctl_names[] = {
-	"CONNECT",
-	"SHUTDOWN",
-	"CREATE_SERVICE",
-	"REMOVE_SERVICE",
-	"QUEUE_MESSAGE",
-	"QUEUE_BULK_TRANSMIT",
-	"QUEUE_BULK_RECEIVE",
-	"AWAIT_COMPLETION",
-	"DEQUEUE_MESSAGE",
-	"GET_CLIENT_ID",
-	"GET_CONFIG",
-	"CLOSE_SERVICE",
-	"USE_SERVICE",
-	"RELEASE_SERVICE",
-	"SET_SERVICE_OPTION",
-	"DUMP_PHYS_MEM",
-	"LIB_VERSION",
-	"CLOSE_DELIVERED"
-};
-
-vchiq_static_assert(ARRAY_SIZE(ioctl_names) ==
-		    (VCHIQ_IOC_MAX + 1));
-
 static enum vchiq_status
 vchiq_blocking_bulk_transfer(unsigned int handle, void *data,
 	unsigned int size, enum vchiq_bulk_dir dir);
@@ -463,1551 +380,241 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data,
 	if (found) {
 		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
 
-		if (bulk) {
-			/* This thread has an outstanding bulk transfer. */
-			/* FIXME: why compare a dma address to a pointer? */
-			if ((bulk->data != (dma_addr_t)(uintptr_t)data) ||
-				(bulk->size != size)) {
-				/* This is not a retry of the previous one.
-				 * Cancel the signal when the transfer
-				 * completes.
-				 */
-				spin_lock(&bulk_waiter_spinlock);
-				bulk->userdata = NULL;
-				spin_unlock(&bulk_waiter_spinlock);
-			}
-		}
-	} else {
-		waiter = kzalloc(sizeof(struct bulk_waiter_node), GFP_KERNEL);
-		if (!waiter) {
-			vchiq_log_error(vchiq_core_log_level,
-				"%s - out of memory", __func__);
-			return VCHIQ_ERROR;
-		}
-	}
-
-	status = vchiq_bulk_transfer(handle, data, NULL, size,
-				     &waiter->bulk_waiter,
-				     VCHIQ_BULK_MODE_BLOCKING, dir);
-	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
-		!waiter->bulk_waiter.bulk) {
-		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
-
-		if (bulk) {
-			/* Cancel the signal when the transfer
-			 * completes.
-			 */
-			spin_lock(&bulk_waiter_spinlock);
-			bulk->userdata = NULL;
-			spin_unlock(&bulk_waiter_spinlock);
-		}
-		kfree(waiter);
-	} else {
-		waiter->pid = current->pid;
-		mutex_lock(&instance->bulk_waiter_list_mutex);
-		list_add(&waiter->list, &instance->bulk_waiter_list);
-		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		vchiq_log_info(vchiq_arm_log_level,
-				"saved bulk_waiter %pK for pid %d",
-				waiter, current->pid);
-	}
-
-	return status;
-}
-/****************************************************************************
-*
-*   add_completion
-*
-***************************************************************************/
-
-static enum vchiq_status
-add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
-	       struct vchiq_header *header, struct user_service *user_service,
-	       void *bulk_userdata)
-{
-	struct vchiq_completion_data_kernel *completion;
-	int insert;
-
-	DEBUG_INITIALISE(g_state.local)
-
-	insert = instance->completion_insert;
-	while ((insert - instance->completion_remove) >= MAX_COMPLETIONS) {
-		/* Out of space - wait for the client */
-		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-		vchiq_log_trace(vchiq_arm_log_level,
-			"%s - completion queue full", __func__);
-		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
-		if (wait_for_completion_interruptible(
-					&instance->remove_event)) {
-			vchiq_log_info(vchiq_arm_log_level,
-				"service_callback interrupted");
-			return VCHIQ_RETRY;
-		} else if (instance->closing) {
-			vchiq_log_info(vchiq_arm_log_level,
-				"service_callback closing");
-			return VCHIQ_SUCCESS;
-		}
-		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-	}
-
-	completion = &instance->completions[insert & (MAX_COMPLETIONS - 1)];
-
-	completion->header = header;
-	completion->reason = reason;
-	/* N.B. service_userdata is updated while processing AWAIT_COMPLETION */
-	completion->service_userdata = user_service->service;
-	completion->bulk_userdata = bulk_userdata;
-
-	if (reason == VCHIQ_SERVICE_CLOSED) {
-		/* Take an extra reference, to be held until
-		   this CLOSED notification is delivered. */
-		lock_service(user_service->service);
-		if (instance->use_close_delivered)
-			user_service->close_pending = 1;
-	}
-
-	/* A write barrier is needed here to ensure that the entire completion
-		record is written out before the insert point. */
-	wmb();
-
-	if (reason == VCHIQ_MESSAGE_AVAILABLE)
-		user_service->message_available_pos = insert;
-
-	insert++;
-	instance->completion_insert = insert;
-
-	complete(&instance->insert_event);
-
-	return VCHIQ_SUCCESS;
-}
-
-/****************************************************************************
-*
-*   service_callback
-*
-***************************************************************************/
-
-static enum vchiq_status
-service_callback(enum vchiq_reason reason, struct vchiq_header *header,
-		 unsigned int handle, void *bulk_userdata)
-{
-	/* How do we ensure the callback goes to the right client?
-	** The service_user data points to a user_service record
-	** containing the original callback and the user state structure, which
-	** contains a circular buffer for completion records.
-	*/
-	struct user_service *user_service;
-	struct vchiq_service *service;
-	struct vchiq_instance *instance;
-	bool skip_completion = false;
-
-	DEBUG_INITIALISE(g_state.local)
-
-	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-
-	service = handle_to_service(handle);
-	BUG_ON(!service);
-	user_service = (struct user_service *)service->base.userdata;
-	instance = user_service->instance;
-
-	if (!instance || instance->closing)
-		return VCHIQ_SUCCESS;
-
-	vchiq_log_trace(vchiq_arm_log_level,
-		"%s - service %lx(%d,%p), reason %d, header %lx, "
-		"instance %lx, bulk_userdata %lx",
-		__func__, (unsigned long)user_service,
-		service->localport, user_service->userdata,
-		reason, (unsigned long)header,
-		(unsigned long)instance, (unsigned long)bulk_userdata);
-
-	if (header && user_service->is_vchi) {
-		spin_lock(&msg_queue_spinlock);
-		while (user_service->msg_insert ==
-			(user_service->msg_remove + MSG_QUEUE_SIZE)) {
-			spin_unlock(&msg_queue_spinlock);
-			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-			DEBUG_COUNT(MSG_QUEUE_FULL_COUNT);
-			vchiq_log_trace(vchiq_arm_log_level,
-				"service_callback - msg queue full");
-			/* If there is no MESSAGE_AVAILABLE in the completion
-			** queue, add one
-			*/
-			if ((user_service->message_available_pos -
-				instance->completion_remove) < 0) {
-				enum vchiq_status status;
-
-				vchiq_log_info(vchiq_arm_log_level,
-					"Inserting extra MESSAGE_AVAILABLE");
-				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-				status = add_completion(instance, reason,
-					NULL, user_service, bulk_userdata);
-				if (status != VCHIQ_SUCCESS) {
-					DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-					return status;
-				}
-			}
-
-			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-			if (wait_for_completion_interruptible(
-						&user_service->remove_event)) {
-				vchiq_log_info(vchiq_arm_log_level,
-					"%s interrupted", __func__);
-				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-				return VCHIQ_RETRY;
-			} else if (instance->closing) {
-				vchiq_log_info(vchiq_arm_log_level,
-					"%s closing", __func__);
-				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-				return VCHIQ_ERROR;
-			}
-			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-			spin_lock(&msg_queue_spinlock);
-		}
-
-		user_service->msg_queue[user_service->msg_insert &
-			(MSG_QUEUE_SIZE - 1)] = header;
-		user_service->msg_insert++;
-
-		/* If there is a thread waiting in DEQUEUE_MESSAGE, or if
-		** there is a MESSAGE_AVAILABLE in the completion queue then
-		** bypass the completion queue.
-		*/
-		if (((user_service->message_available_pos -
-			instance->completion_remove) >= 0) ||
-			user_service->dequeue_pending) {
-			user_service->dequeue_pending = 0;
-			skip_completion = true;
-		}
-
-		spin_unlock(&msg_queue_spinlock);
-		complete(&user_service->insert_event);
-
-		header = NULL;
-	}
-	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-
-	if (skip_completion)
-		return VCHIQ_SUCCESS;
-
-	return add_completion(instance, reason, header, user_service,
-		bulk_userdata);
-}
-
-/****************************************************************************
-*
-*   user_service_free
-*
-***************************************************************************/
-static void
-user_service_free(void *userdata)
-{
-	kfree(userdata);
-}
-
-/****************************************************************************
-*
-*   close_delivered
-*
-***************************************************************************/
-static void close_delivered(struct user_service *user_service)
-{
-	vchiq_log_info(vchiq_arm_log_level,
-		"%s(handle=%x)",
-		__func__, user_service->service->handle);
-
-	if (user_service->close_pending) {
-		/* Allow the underlying service to be culled */
-		unlock_service(user_service->service);
-
-		/* Wake the user-thread blocked in close_ or remove_service */
-		complete(&user_service->close_event);
-
-		user_service->close_pending = 0;
-	}
-}
-
-struct vchiq_io_copy_callback_context {
-	struct vchiq_element *element;
-	size_t element_offset;
-	unsigned long elements_to_go;
-};
-
-static ssize_t vchiq_ioc_copy_element_data(void *context, void *dest,
-					   size_t offset, size_t maxsize)
-{
-	struct vchiq_io_copy_callback_context *cc = context;
-	size_t total_bytes_copied = 0;
-	size_t bytes_this_round;
-
-	while (total_bytes_copied < maxsize) {
-		if (!cc->elements_to_go)
-			return total_bytes_copied;
-
-		if (!cc->element->size) {
-			cc->elements_to_go--;
-			cc->element++;
-			cc->element_offset = 0;
-			continue;
-		}
-
-		bytes_this_round = min(cc->element->size - cc->element_offset,
-				       maxsize - total_bytes_copied);
-
-		if (copy_from_user(dest + total_bytes_copied,
-				  cc->element->data + cc->element_offset,
-				  bytes_this_round))
-			return -EFAULT;
-
-		cc->element_offset += bytes_this_round;
-		total_bytes_copied += bytes_this_round;
-
-		if (cc->element_offset == cc->element->size) {
-			cc->elements_to_go--;
-			cc->element++;
-			cc->element_offset = 0;
-		}
-	}
-
-	return maxsize;
-}
-
-/**************************************************************************
- *
- *   vchiq_ioc_queue_message
- *
- **************************************************************************/
-static int
-vchiq_ioc_queue_message(unsigned int handle,
-			struct vchiq_element *elements,
-			unsigned long count)
-{
-	struct vchiq_io_copy_callback_context context;
-	enum vchiq_status status = VCHIQ_SUCCESS;
-	unsigned long i;
-	size_t total_size = 0;
-
-	context.element = elements;
-	context.element_offset = 0;
-	context.elements_to_go = count;
-
-	for (i = 0; i < count; i++) {
-		if (!elements[i].data && elements[i].size != 0)
-			return -EFAULT;
-
-		total_size += elements[i].size;
-	}
-
-	status = vchiq_queue_message(handle, vchiq_ioc_copy_element_data,
-				     &context, total_size);
-
-	if (status == VCHIQ_ERROR)
-		return -EIO;
-	else if (status == VCHIQ_RETRY)
-		return -EINTR;
-	return 0;
-}
-
-static int vchiq_ioc_create_service(struct vchiq_instance *instance,
-				    struct vchiq_create_service *args)
-{
-	struct user_service *user_service = NULL;
-	struct vchiq_service *service;
-	enum vchiq_status status = VCHIQ_SUCCESS;
-	struct vchiq_service_params_kernel params;
-	int srvstate;
-
-	user_service = kmalloc(sizeof(*user_service), GFP_KERNEL);
-	if (!user_service)
-		return -ENOMEM;
-
-	if (args->is_open) {
-		if (!instance->connected) {
-			kfree(user_service);
-			return -ENOTCONN;
-		}
-		srvstate = VCHIQ_SRVSTATE_OPENING;
-	} else {
-		srvstate = instance->connected ?
-			 VCHIQ_SRVSTATE_LISTENING : VCHIQ_SRVSTATE_HIDDEN;
-	}
-
-	params = (struct vchiq_service_params_kernel) {
-		.fourcc   = args->params.fourcc,
-		.callback = service_callback,
-		.userdata = user_service,
-		.version  = args->params.version,
-		.version_min = args->params.version_min,
-	};
-	service = vchiq_add_service_internal(instance->state, &params,
-					     srvstate, instance,
-					     user_service_free);
-	if (!service) {
-		kfree(user_service);
-		return -EEXIST;
-	}
-
-	user_service->service = service;
-	user_service->userdata = args->params.userdata;
-	user_service->instance = instance;
-	user_service->is_vchi = (args->is_vchi != 0);
-	user_service->dequeue_pending = 0;
-	user_service->close_pending = 0;
-	user_service->message_available_pos = instance->completion_remove - 1;
-	user_service->msg_insert = 0;
-	user_service->msg_remove = 0;
-	init_completion(&user_service->insert_event);
-	init_completion(&user_service->remove_event);
-	init_completion(&user_service->close_event);
-
-	if (args->is_open) {
-		status = vchiq_open_service_internal(service, instance->pid);
-		if (status != VCHIQ_SUCCESS) {
-			vchiq_remove_service(service->handle);
-			return (status == VCHIQ_RETRY) ?
-				-EINTR : -EIO;
-		}
-	}
-	args->handle = service->handle;
-
-	return 0;
-}
-
-static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
-				     struct vchiq_dequeue_message *args)
-{
-	struct user_service *user_service;
-	struct vchiq_service *service;
-	struct vchiq_header *header;
-	int ret;
-
-	DEBUG_INITIALISE(g_state.local)
-	DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-	service = find_service_for_instance(instance, args->handle);
-	if (!service)
-		return -EINVAL;
-
-	user_service = (struct user_service *)service->base.userdata;
-	if (user_service->is_vchi == 0) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	spin_lock(&msg_queue_spinlock);
-	if (user_service->msg_remove == user_service->msg_insert) {
-		if (!args->blocking) {
-			spin_unlock(&msg_queue_spinlock);
-			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-			ret = -EWOULDBLOCK;
-			goto out;
-		}
-		user_service->dequeue_pending = 1;
-		ret = 0;
-		do {
-			spin_unlock(&msg_queue_spinlock);
-			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-			if (wait_for_completion_interruptible(
-				&user_service->insert_event)) {
-				vchiq_log_info(vchiq_arm_log_level,
-					"DEQUEUE_MESSAGE interrupted");
-				ret = -EINTR;
-				break;
-			}
-			spin_lock(&msg_queue_spinlock);
-		} while (user_service->msg_remove ==
-			user_service->msg_insert);
-
-		if (ret)
-			goto out;
-	}
-
-	BUG_ON((int)(user_service->msg_insert -
-		user_service->msg_remove) < 0);
-
-	header = user_service->msg_queue[user_service->msg_remove &
-		(MSG_QUEUE_SIZE - 1)];
-	user_service->msg_remove++;
-	spin_unlock(&msg_queue_spinlock);
-
-	complete(&user_service->remove_event);
-	if (!header) {
-		ret = -ENOTCONN;
-	} else if (header->size <= args->bufsize) {
-		/* Copy to user space if msgbuf is not NULL */
-		if (!args->buf || (copy_to_user(args->buf,
-					header->data, header->size) == 0)) {
-			ret = header->size;
-			vchiq_release_message(service->handle, header);
-		} else
-			ret = -EFAULT;
-	} else {
-		vchiq_log_error(vchiq_arm_log_level,
-			"header %pK: bufsize %x < size %x",
-			header, args->bufsize, header->size);
-		WARN(1, "invalid size\n");
-		ret = -EMSGSIZE;
-	}
-	DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-out:
-	unlock_service(service);
-	return ret;
-}
-
-static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
-				      struct vchiq_queue_bulk_transfer *args,
-				      enum vchiq_bulk_dir dir,
-				      enum vchiq_bulk_mode __user *mode)
-{
-	struct vchiq_service *service;
-	struct bulk_waiter_node *waiter = NULL;
-	bool found = false;
-	void *userdata;
-	int status = 0;
-	int ret;
-
-	service = find_service_for_instance(instance, args->handle);
-	if (!service)
-		return -EINVAL;
-
-	if (args->mode == VCHIQ_BULK_MODE_BLOCKING) {
-		waiter = kzalloc(sizeof(struct bulk_waiter_node),
-			GFP_KERNEL);
-		if (!waiter) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		userdata = &waiter->bulk_waiter;
-	} else if (args->mode == VCHIQ_BULK_MODE_WAITING) {
-		mutex_lock(&instance->bulk_waiter_list_mutex);
-		list_for_each_entry(waiter, &instance->bulk_waiter_list,
-				    list) {
-			if (waiter->pid == current->pid) {
-				list_del(&waiter->list);
-				found = true;
-				break;
-			}
-		}
-		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		if (!found) {
-			vchiq_log_error(vchiq_arm_log_level,
-				"no bulk_waiter found for pid %d",
-				current->pid);
-			ret = -ESRCH;
-			goto out;
-		}
-		vchiq_log_info(vchiq_arm_log_level,
-			"found bulk_waiter %pK for pid %d", waiter,
-			current->pid);
-		userdata = &waiter->bulk_waiter;
-	} else {
-		userdata = args->userdata;
-	}
-
-	/*
-	 * FIXME address space mismatch:
-	 * args->data may be interpreted as a kernel pointer
-	 * in create_pagelist() called from vchiq_bulk_transfer(),
-	 * accessing kernel data instead of user space, based on the
-	 * address.
-	 */
-	status = vchiq_bulk_transfer(args->handle, NULL, args->data, args->size,
-				     userdata, args->mode, dir);
-
-	if (!waiter) {
-		ret = 0;
-		goto out;
-	}
-
-	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
-		!waiter->bulk_waiter.bulk) {
-		if (waiter->bulk_waiter.bulk) {
-			/* Cancel the signal when the transfer
-			** completes. */
-			spin_lock(&bulk_waiter_spinlock);
-			waiter->bulk_waiter.bulk->userdata = NULL;
-			spin_unlock(&bulk_waiter_spinlock);
-		}
-		kfree(waiter);
-		ret = 0;
-	} else {
-		const enum vchiq_bulk_mode mode_waiting =
-			VCHIQ_BULK_MODE_WAITING;
-		waiter->pid = current->pid;
-		mutex_lock(&instance->bulk_waiter_list_mutex);
-		list_add(&waiter->list, &instance->bulk_waiter_list);
-		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		vchiq_log_info(vchiq_arm_log_level,
-			"saved bulk_waiter %pK for pid %d",
-			waiter, current->pid);
-
-		ret = put_user(mode_waiting, mode);
-	}
-out:
-	unlock_service(service);
-	if (ret)
-		return ret;
-	else if (status == VCHIQ_ERROR)
-		return -EIO;
-	else if (status == VCHIQ_RETRY)
-		return -EINTR;
-	return 0;
-}
-
-/* read a user pointer value from an array pointers in user space */
-static inline int vchiq_get_user_ptr(void __user **buf, void __user *ubuf, int index)
-{
-	int ret;
-
-	if (in_compat_syscall()) {
-		compat_uptr_t ptr32;
-		compat_uptr_t __user *uptr = ubuf;
-		ret = get_user(ptr32, uptr + index);
-		*buf = compat_ptr(ptr32);
-	} else {
-		uintptr_t ptr, __user *uptr = ubuf;
-		ret = get_user(ptr, uptr + index);
-		*buf = (void __user *)ptr;
-	}
-
-	return ret;
-}
-
-struct vchiq_completion_data32 {
-	enum vchiq_reason reason;
-	compat_uptr_t header;
-	compat_uptr_t service_userdata;
-	compat_uptr_t bulk_userdata;
-};
-
-static int vchiq_put_completion(struct vchiq_completion_data __user *buf,
-				struct vchiq_completion_data *completion,
-				int index)
-{
-	struct vchiq_completion_data32 __user *buf32 = (void __user *)buf;
-
-	if (in_compat_syscall()) {
-		struct vchiq_completion_data32 tmp = {
-			.reason		  = completion->reason,
-			.header		  = ptr_to_compat(completion->header),
-			.service_userdata = ptr_to_compat(completion->service_userdata),
-			.bulk_userdata	  = ptr_to_compat(completion->bulk_userdata),
-		};
-		if (copy_to_user(&buf32[index], &tmp, sizeof(tmp)))
-			return -EFAULT;
-	} else {
-		if (copy_to_user(&buf[index], completion, sizeof(*completion)))
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
-				      struct vchiq_await_completion *args,
-				      int __user *msgbufcountp)
-{
-	int msgbufcount;
-	int remove;
-	int ret;
-
-	DEBUG_INITIALISE(g_state.local)
-
-	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-	if (!instance->connected) {
-		return -ENOTCONN;
-	}
-
-	mutex_lock(&instance->completion_mutex);
-
-	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-	while ((instance->completion_remove ==
-		instance->completion_insert)
-		&& !instance->closing) {
-		int rc;
-
-		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-		mutex_unlock(&instance->completion_mutex);
-		rc = wait_for_completion_interruptible(
-					&instance->insert_event);
-		mutex_lock(&instance->completion_mutex);
-		if (rc) {
-			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-			vchiq_log_info(vchiq_arm_log_level,
-				"AWAIT_COMPLETION interrupted");
-			ret = -EINTR;
-			goto out;
-		}
-	}
-	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-
-	msgbufcount = args->msgbufcount;
-	remove = instance->completion_remove;
-
-	for (ret = 0; ret < args->count; ret++) {
-		struct vchiq_completion_data_kernel *completion;
-		struct vchiq_completion_data user_completion;
-		struct vchiq_service *service;
-		struct user_service *user_service;
-		struct vchiq_header *header;
-
-		if (remove == instance->completion_insert)
-			break;
-
-		completion = &instance->completions[
-			remove & (MAX_COMPLETIONS - 1)];
-
-		/*
-		 * A read memory barrier is needed to stop
-		 * prefetch of a stale completion record
-		 */
-		rmb();
-
-		service = completion->service_userdata;
-		user_service = service->base.userdata;
-
-		memset(&user_completion, 0, sizeof(user_completion));
-		user_completion = (struct vchiq_completion_data) {
-			.reason = completion->reason,
-			.service_userdata = user_service->userdata,
-		};
-
-		header = completion->header;
-		if (header) {
-			void __user *msgbuf;
-			int msglen;
-
-			msglen = header->size + sizeof(struct vchiq_header);
-			/* This must be a VCHIQ-style service */
-			if (args->msgbufsize < msglen) {
-				vchiq_log_error(vchiq_arm_log_level,
-					"header %pK: msgbufsize %x < msglen %x",
-					header, args->msgbufsize, msglen);
-				WARN(1, "invalid message size\n");
-				if (ret == 0)
-					ret = -EMSGSIZE;
-				break;
-			}
-			if (msgbufcount <= 0)
-				/* Stall here for lack of a
-				** buffer for the message. */
-				break;
-			/* Get the pointer from user space */
-			msgbufcount--;
-			if (vchiq_get_user_ptr(&msgbuf, args->msgbufs,
-						msgbufcount)) {
-				if (ret == 0)
-					ret = -EFAULT;
-				break;
-			}
-
-			/* Copy the message to user space */
-			if (copy_to_user(msgbuf, header, msglen)) {
-				if (ret == 0)
-					ret = -EFAULT;
-				break;
-			}
-
-			/* Now it has been copied, the message
-			** can be released. */
-			vchiq_release_message(service->handle, header);
-
-			/* The completion must point to the
-			** msgbuf. */
-			user_completion.header = msgbuf;
-		}
-
-		if ((completion->reason == VCHIQ_SERVICE_CLOSED) &&
-		    !instance->use_close_delivered)
-			unlock_service(service);
-
-		/*
-		 * FIXME: address space mismatch, does bulk_userdata
-		 * actually point to user or kernel memory?
-		 */
-		user_completion.bulk_userdata = completion->bulk_userdata;
-
-		if (vchiq_put_completion(args->buf, &user_completion, ret)) {
-			if (ret == 0)
-				ret = -EFAULT;
-			break;
-		}
-
-		/*
-		 * Ensure that the above copy has completed
-		 * before advancing the remove pointer.
-		 */
-		mb();
-		remove++;
-		instance->completion_remove = remove;
-	}
-
-	if (msgbufcount != args->msgbufcount) {
-		if (put_user(msgbufcount, msgbufcountp))
-			ret = -EFAULT;
-	}
-out:
-	if (ret)
-		complete(&instance->remove_event);
-	mutex_unlock(&instance->completion_mutex);
-	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-
-	return ret;
-}
-
-/****************************************************************************
-*
-*   vchiq_ioctl
-*
-***************************************************************************/
-static long
-vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct vchiq_instance *instance = file->private_data;
-	enum vchiq_status status = VCHIQ_SUCCESS;
-	struct vchiq_service *service = NULL;
-	long ret = 0;
-	int i, rc;
-
-	vchiq_log_trace(vchiq_arm_log_level,
-		"%s - instance %pK, cmd %s, arg %lx",
-		__func__, instance,
-		((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) &&
-		(_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
-		ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
-
-	switch (cmd) {
-	case VCHIQ_IOC_SHUTDOWN:
-		if (!instance->connected)
-			break;
-
-		/* Remove all services */
-		i = 0;
-		while ((service = next_service_by_instance(instance->state,
-			instance, &i))) {
-			status = vchiq_remove_service(service->handle);
-			unlock_service(service);
-			if (status != VCHIQ_SUCCESS)
-				break;
-		}
-		service = NULL;
-
-		if (status == VCHIQ_SUCCESS) {
-			/* Wake the completion thread and ask it to exit */
-			instance->closing = 1;
-			complete(&instance->insert_event);
-		}
-
-		break;
-
-	case VCHIQ_IOC_CONNECT:
-		if (instance->connected) {
-			ret = -EINVAL;
-			break;
-		}
-		rc = mutex_lock_killable(&instance->state->mutex);
-		if (rc) {
-			vchiq_log_error(vchiq_arm_log_level,
-				"vchiq: connect: could not lock mutex for "
-				"state %d: %d",
-				instance->state->id, rc);
-			ret = -EINTR;
-			break;
-		}
-		status = vchiq_connect_internal(instance->state, instance);
-		mutex_unlock(&instance->state->mutex);
-
-		if (status == VCHIQ_SUCCESS)
-			instance->connected = 1;
-		else
-			vchiq_log_error(vchiq_arm_log_level,
-				"vchiq: could not connect: %d", status);
-		break;
-
-	case VCHIQ_IOC_CREATE_SERVICE: {
-		struct vchiq_create_service __user *argp;
-		struct vchiq_create_service args;
-
-		argp = (void __user *)arg;
-		if (copy_from_user(&args, argp, sizeof(args))) {
-			ret = -EFAULT;
-			break;
-		}
-
-		ret = vchiq_ioc_create_service(instance, &args);
-		if (ret < 0)
-			break;
-
-		if (put_user(args.handle, &argp->handle)) {
-			vchiq_remove_service(args.handle);
-			ret = -EFAULT;
-		}
-	} break;
-
-	case VCHIQ_IOC_CLOSE_SERVICE:
-	case VCHIQ_IOC_REMOVE_SERVICE: {
-		unsigned int handle = (unsigned int)arg;
-		struct user_service *user_service;
-
-		service = find_service_for_instance(instance, handle);
-		if (!service) {
-			ret = -EINVAL;
-			break;
-		}
-
-		user_service = service->base.userdata;
-
-		/* close_pending is false on first entry, and when the
-		   wait in vchiq_close_service has been interrupted. */
-		if (!user_service->close_pending) {
-			status = (cmd == VCHIQ_IOC_CLOSE_SERVICE) ?
-				 vchiq_close_service(service->handle) :
-				 vchiq_remove_service(service->handle);
-			if (status != VCHIQ_SUCCESS)
-				break;
-		}
-
-		/* close_pending is true once the underlying service
-		   has been closed until the client library calls the
-		   CLOSE_DELIVERED ioctl, signalling close_event. */
-		if (user_service->close_pending &&
-			wait_for_completion_interruptible(
-				&user_service->close_event))
-			status = VCHIQ_RETRY;
-		break;
-	}
-
-	case VCHIQ_IOC_USE_SERVICE:
-	case VCHIQ_IOC_RELEASE_SERVICE:	{
-		unsigned int handle = (unsigned int)arg;
-
-		service = find_service_for_instance(instance, handle);
-		if (service) {
-			status = (cmd == VCHIQ_IOC_USE_SERVICE)	?
-				vchiq_use_service_internal(service) :
-				vchiq_release_service_internal(service);
-			if (status != VCHIQ_SUCCESS) {
-				vchiq_log_error(vchiq_susp_log_level,
-					"%s: cmd %s returned error %d for "
-					"service %c%c%c%c:%03d",
-					__func__,
-					(cmd == VCHIQ_IOC_USE_SERVICE) ?
-						"VCHIQ_IOC_USE_SERVICE" :
-						"VCHIQ_IOC_RELEASE_SERVICE",
-					status,
-					VCHIQ_FOURCC_AS_4CHARS(
-						service->base.fourcc),
-					service->client_id);
-				ret = -EINVAL;
-			}
-		} else
-			ret = -EINVAL;
-	} break;
-
-	case VCHIQ_IOC_QUEUE_MESSAGE: {
-		struct vchiq_queue_message args;
-
-		if (copy_from_user(&args, (const void __user *)arg,
-				   sizeof(args))) {
-			ret = -EFAULT;
-			break;
-		}
-
-		service = find_service_for_instance(instance, args.handle);
-
-		if (service && (args.count <= MAX_ELEMENTS)) {
-			/* Copy elements into kernel space */
-			struct vchiq_element elements[MAX_ELEMENTS];
-
-			if (copy_from_user(elements, args.elements,
-				args.count * sizeof(struct vchiq_element)) == 0)
-				ret = vchiq_ioc_queue_message(args.handle, elements,
-							      args.count);
-			else
-				ret = -EFAULT;
-		} else {
-			ret = -EINVAL;
-		}
-	} break;
-
-	case VCHIQ_IOC_QUEUE_BULK_TRANSMIT:
-	case VCHIQ_IOC_QUEUE_BULK_RECEIVE: {
-		struct vchiq_queue_bulk_transfer args;
-		struct vchiq_queue_bulk_transfer __user *argp;
-
-		enum vchiq_bulk_dir dir =
-			(cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT) ?
-			VCHIQ_BULK_TRANSMIT : VCHIQ_BULK_RECEIVE;
-
-		argp = (void __user *)arg;
-		if (copy_from_user(&args, argp, sizeof(args))) {
-			ret = -EFAULT;
-			break;
-		}
-
-		ret = vchiq_irq_queue_bulk_tx_rx(instance, &args,
-						 dir, &argp->mode);
-	} break;
-
-	case VCHIQ_IOC_AWAIT_COMPLETION: {
-		struct vchiq_await_completion args;
-		struct vchiq_await_completion __user *argp;
-
-		argp = (void __user *)arg;
-		if (copy_from_user(&args, argp, sizeof(args))) {
-			ret = -EFAULT;
-			break;
-		}
-
-		ret = vchiq_ioc_await_completion(instance, &args,
-						 &argp->msgbufcount);
-	} break;
-
-	case VCHIQ_IOC_DEQUEUE_MESSAGE: {
-		struct vchiq_dequeue_message args;
-
-		if (copy_from_user(&args, (const void __user *)arg,
-				   sizeof(args))) {
-			ret = -EFAULT;
-			break;
-		}
-
-		ret = vchiq_ioc_dequeue_message(instance, &args);
-	} break;
-
-	case VCHIQ_IOC_GET_CLIENT_ID: {
-		unsigned int handle = (unsigned int)arg;
-
-		ret = vchiq_get_client_id(handle);
-	} break;
-
-	case VCHIQ_IOC_GET_CONFIG: {
-		struct vchiq_get_config args;
-		struct vchiq_config config;
-
-		if (copy_from_user(&args, (const void __user *)arg,
-				   sizeof(args))) {
-			ret = -EFAULT;
-			break;
-		}
-		if (args.config_size > sizeof(config)) {
-			ret = -EINVAL;
-			break;
-		}
-
-		vchiq_get_config(&config);
-		if (copy_to_user(args.pconfig, &config, args.config_size)) {
-			ret = -EFAULT;
-			break;
-		}
-	} break;
-
-	case VCHIQ_IOC_SET_SERVICE_OPTION: {
-		struct vchiq_set_service_option args;
-
-		if (copy_from_user(&args, (const void __user *)arg,
-				   sizeof(args))) {
-			ret = -EFAULT;
-			break;
-		}
-
-		service = find_service_for_instance(instance, args.handle);
-		if (!service) {
-			ret = -EINVAL;
-			break;
-		}
-
-		status = vchiq_set_service_option(
-				args.handle, args.option, args.value);
-	} break;
-
-	case VCHIQ_IOC_LIB_VERSION: {
-		unsigned int lib_version = (unsigned int)arg;
-
-		if (lib_version < VCHIQ_VERSION_MIN)
-			ret = -EINVAL;
-		else if (lib_version >= VCHIQ_VERSION_CLOSE_DELIVERED)
-			instance->use_close_delivered = 1;
-	} break;
-
-	case VCHIQ_IOC_CLOSE_DELIVERED: {
-		unsigned int handle = (unsigned int)arg;
-
-		service = find_closed_service_for_instance(instance, handle);
-		if (service) {
-			struct user_service *user_service =
-				(struct user_service *)service->base.userdata;
-			close_delivered(user_service);
-		} else
-			ret = -EINVAL;
-	} break;
-
-	default:
-		ret = -ENOTTY;
-		break;
-	}
-
-	if (service)
-		unlock_service(service);
-
-	if (ret == 0) {
-		if (status == VCHIQ_ERROR)
-			ret = -EIO;
-		else if (status == VCHIQ_RETRY)
-			ret = -EINTR;
-	}
-
-	if ((status == VCHIQ_SUCCESS) && (ret < 0) && (ret != -EINTR) &&
-		(ret != -EWOULDBLOCK))
-		vchiq_log_info(vchiq_arm_log_level,
-			"  ioctl instance %pK, cmd %s -> status %d, %ld",
-			instance,
-			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
-				ioctl_names[_IOC_NR(cmd)] :
-				"<invalid>",
-			status, ret);
-	else
-		vchiq_log_trace(vchiq_arm_log_level,
-			"  ioctl instance %pK, cmd %s -> status %d, %ld",
-			instance,
-			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
-				ioctl_names[_IOC_NR(cmd)] :
-				"<invalid>",
-			status, ret);
-
-	return ret;
-}
-
-#if defined(CONFIG_COMPAT)
-
-struct vchiq_service_params32 {
-	int fourcc;
-	compat_uptr_t callback;
-	compat_uptr_t userdata;
-	short version; /* Increment for non-trivial changes */
-	short version_min; /* Update for incompatible changes */
-};
-
-struct vchiq_create_service32 {
-	struct vchiq_service_params32 params;
-	int is_open;
-	int is_vchi;
-	unsigned int handle; /* OUT */
-};
-
-#define VCHIQ_IOC_CREATE_SERVICE32 \
-	_IOWR(VCHIQ_IOC_MAGIC, 2, struct vchiq_create_service32)
-
-static long
-vchiq_compat_ioctl_create_service(
-	struct file *file,
-	unsigned int cmd,
-	struct vchiq_create_service32 __user *ptrargs32)
-{
-	struct vchiq_create_service args;
-	struct vchiq_create_service32 args32;
-	long ret;
-
-	if (copy_from_user(&args32, ptrargs32, sizeof(args32)))
-		return -EFAULT;
-
-	args = (struct vchiq_create_service) {
-		.params = {
-			.fourcc	     = args32.params.fourcc,
-			.callback    = compat_ptr(args32.params.callback),
-			.userdata    = compat_ptr(args32.params.userdata),
-			.version     = args32.params.version,
-			.version_min = args32.params.version_min,
-		},
-		.is_open = args32.is_open,
-		.is_vchi = args32.is_vchi,
-		.handle  = args32.handle,
-	};
-
-	ret = vchiq_ioc_create_service(file->private_data, &args);
-	if (ret < 0)
-		return ret;
-
-	if (put_user(args.handle, &ptrargs32->handle)) {
-		vchiq_remove_service(args.handle);
-		return -EFAULT;
-	}
-
-	return 0;
-}
-
-struct vchiq_element32 {
-	compat_uptr_t data;
-	unsigned int size;
-};
-
-struct vchiq_queue_message32 {
-	unsigned int handle;
-	unsigned int count;
-	compat_uptr_t elements;
-};
-
-#define VCHIQ_IOC_QUEUE_MESSAGE32 \
-	_IOW(VCHIQ_IOC_MAGIC,  4, struct vchiq_queue_message32)
-
-static long
-vchiq_compat_ioctl_queue_message(struct file *file,
-				 unsigned int cmd,
-				 struct vchiq_queue_message32 __user *arg)
-{
-	struct vchiq_queue_message args;
-	struct vchiq_queue_message32 args32;
-	struct vchiq_service *service;
-	int ret;
-
-	if (copy_from_user(&args32, arg, sizeof(args32)))
-		return -EFAULT;
-
-	args = (struct vchiq_queue_message) {
-		.handle   = args32.handle,
-		.count    = args32.count,
-		.elements = compat_ptr(args32.elements),
-	};
-
-	if (args32.count > MAX_ELEMENTS)
-		return -EINVAL;
-
-	service = find_service_for_instance(file->private_data, args.handle);
-	if (!service)
-		return -EINVAL;
-
-	if (args32.elements && args32.count) {
-		struct vchiq_element32 element32[MAX_ELEMENTS];
-		struct vchiq_element elements[MAX_ELEMENTS];
-		unsigned int count;
-
-		if (copy_from_user(&element32, args.elements,
-				   sizeof(element32))) {
-			unlock_service(service);
-			return -EFAULT;
-		}
-
-		for (count = 0; count < args32.count; count++) {
-			elements[count].data =
-				compat_ptr(element32[count].data);
-			elements[count].size = element32[count].size;
-		}
-		ret = vchiq_ioc_queue_message(args.handle, elements,
-					      args.count);
-	} else {
-		ret = -EINVAL;
-	}
-	unlock_service(service);
-
-	return ret;
-}
-
-struct vchiq_queue_bulk_transfer32 {
-	unsigned int handle;
-	compat_uptr_t data;
-	unsigned int size;
-	compat_uptr_t userdata;
-	enum vchiq_bulk_mode mode;
-};
-
-#define VCHIQ_IOC_QUEUE_BULK_TRANSMIT32 \
-	_IOWR(VCHIQ_IOC_MAGIC, 5, struct vchiq_queue_bulk_transfer32)
-#define VCHIQ_IOC_QUEUE_BULK_RECEIVE32 \
-	_IOWR(VCHIQ_IOC_MAGIC, 6, struct vchiq_queue_bulk_transfer32)
-
-static long
-vchiq_compat_ioctl_queue_bulk(struct file *file,
-			      unsigned int cmd,
-			      struct vchiq_queue_bulk_transfer32 __user *argp)
-{
-	struct vchiq_queue_bulk_transfer32 args32;
-	struct vchiq_queue_bulk_transfer args;
-	enum vchiq_bulk_dir dir = (cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT32) ?
-				  VCHIQ_BULK_TRANSMIT : VCHIQ_BULK_RECEIVE;
-
-	if (copy_from_user(&args32, argp, sizeof(args32)))
-		return -EFAULT;
-
-	args = (struct vchiq_queue_bulk_transfer) {
-		.handle   = args32.handle,
-		.data	  = compat_ptr(args32.data),
-		.size	  = args32.size,
-		.userdata = compat_ptr(args32.userdata),
-		.mode	  = args32.mode,
-	};
-
-	return vchiq_irq_queue_bulk_tx_rx(file->private_data, &args,
-					  dir, &argp->mode);
-}
-
-struct vchiq_await_completion32 {
-	unsigned int count;
-	compat_uptr_t buf;
-	unsigned int msgbufsize;
-	unsigned int msgbufcount; /* IN/OUT */
-	compat_uptr_t msgbufs;
-};
-
-#define VCHIQ_IOC_AWAIT_COMPLETION32 \
-	_IOWR(VCHIQ_IOC_MAGIC, 7, struct vchiq_await_completion32)
-
-static long
-vchiq_compat_ioctl_await_completion(struct file *file,
-				    unsigned int cmd,
-				    struct vchiq_await_completion32 __user *argp)
-{
-	struct vchiq_await_completion args;
-	struct vchiq_await_completion32 args32;
-
-	if (copy_from_user(&args32, argp, sizeof(args32)))
-		return -EFAULT;
-
-	args = (struct vchiq_await_completion) {
-		.count		= args32.count,
-		.buf		= compat_ptr(args32.buf),
-		.msgbufsize	= args32.msgbufsize,
-		.msgbufcount	= args32.msgbufcount,
-		.msgbufs	= compat_ptr(args32.msgbufs),
-	};
-
-	return vchiq_ioc_await_completion(file->private_data, &args,
-					  &argp->msgbufcount);
-}
-
-struct vchiq_dequeue_message32 {
-	unsigned int handle;
-	int blocking;
-	unsigned int bufsize;
-	compat_uptr_t buf;
-};
-
-#define VCHIQ_IOC_DEQUEUE_MESSAGE32 \
-	_IOWR(VCHIQ_IOC_MAGIC, 8, struct vchiq_dequeue_message32)
-
-static long
-vchiq_compat_ioctl_dequeue_message(struct file *file,
-				   unsigned int cmd,
-				   struct vchiq_dequeue_message32 __user *arg)
-{
-	struct vchiq_dequeue_message32 args32;
-	struct vchiq_dequeue_message args;
+		if (bulk) {
+			/* This thread has an outstanding bulk transfer. */
+			/* FIXME: why compare a dma address to a pointer? */
+			if ((bulk->data != (dma_addr_t)(uintptr_t)data) ||
+				(bulk->size != size)) {
+				/* This is not a retry of the previous one.
+				 * Cancel the signal when the transfer
+				 * completes.
+				 */
+				spin_lock(&bulk_waiter_spinlock);
+				bulk->userdata = NULL;
+				spin_unlock(&bulk_waiter_spinlock);
+			}
+		}
+	} else {
+		waiter = kzalloc(sizeof(struct bulk_waiter_node), GFP_KERNEL);
+		if (!waiter) {
+			vchiq_log_error(vchiq_core_log_level,
+				"%s - out of memory", __func__);
+			return VCHIQ_ERROR;
+		}
+	}
 
-	if (copy_from_user(&args32, arg, sizeof(args32)))
-		return -EFAULT;
+	status = vchiq_bulk_transfer(handle, data, NULL, size,
+				     &waiter->bulk_waiter,
+				     VCHIQ_BULK_MODE_BLOCKING, dir);
+	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
+	    !waiter->bulk_waiter.bulk) {
+		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
 
-	args = (struct vchiq_dequeue_message) {
-		.handle		= args32.handle,
-		.blocking	= args32.blocking,
-		.bufsize	= args32.bufsize,
-		.buf		= compat_ptr(args32.buf),
-	};
+		if (bulk) {
+			/* Cancel the signal when the transfer
+			 * completes.
+			 */
+			spin_lock(&bulk_waiter_spinlock);
+			bulk->userdata = NULL;
+			spin_unlock(&bulk_waiter_spinlock);
+		}
+		kfree(waiter);
+	} else {
+		waiter->pid = current->pid;
+		mutex_lock(&instance->bulk_waiter_list_mutex);
+		list_add(&waiter->list, &instance->bulk_waiter_list);
+		mutex_unlock(&instance->bulk_waiter_list_mutex);
+		vchiq_log_info(vchiq_arm_log_level,
+			       "saved bulk_waiter %pK for pid %d",
+			       waiter, current->pid);
+	}
 
-	return vchiq_ioc_dequeue_message(file->private_data, &args);
+	return status;
 }
 
-struct vchiq_get_config32 {
-	unsigned int config_size;
-	compat_uptr_t pconfig;
-};
-
-#define VCHIQ_IOC_GET_CONFIG32 \
-	_IOWR(VCHIQ_IOC_MAGIC, 10, struct vchiq_get_config32)
+/****************************************************************************
+ *
+ *   add_completion
+ *
+ ***************************************************************************/
 
-static long
-vchiq_compat_ioctl_get_config(struct file *file,
-			      unsigned int cmd,
-			      struct vchiq_get_config32 __user *arg)
+static enum vchiq_status
+add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
+	       struct vchiq_header *header, struct user_service *user_service,
+	       void *bulk_userdata)
 {
-	struct vchiq_get_config32 args32;
-	struct vchiq_config config;
-	void __user *ptr;
-
-	if (copy_from_user(&args32, arg, sizeof(args32)))
-		return -EFAULT;
-	if (args32.config_size > sizeof(config))
-		return -EINVAL;
-
-	vchiq_get_config(&config);
-	ptr = compat_ptr(args32.pconfig);
-	if (copy_to_user(ptr, &config, args32.config_size))
-		return -EFAULT;
+	struct vchiq_completion_data_kernel *completion;
+	int insert;
 
-	return 0;
-}
+	DEBUG_INITIALISE(g_state.local)
 
-static long
-vchiq_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	void __user *argp = compat_ptr(arg);
-	switch (cmd) {
-	case VCHIQ_IOC_CREATE_SERVICE32:
-		return vchiq_compat_ioctl_create_service(file, cmd, argp);
-	case VCHIQ_IOC_QUEUE_MESSAGE32:
-		return vchiq_compat_ioctl_queue_message(file, cmd, argp);
-	case VCHIQ_IOC_QUEUE_BULK_TRANSMIT32:
-	case VCHIQ_IOC_QUEUE_BULK_RECEIVE32:
-		return vchiq_compat_ioctl_queue_bulk(file, cmd, argp);
-	case VCHIQ_IOC_AWAIT_COMPLETION32:
-		return vchiq_compat_ioctl_await_completion(file, cmd, argp);
-	case VCHIQ_IOC_DEQUEUE_MESSAGE32:
-		return vchiq_compat_ioctl_dequeue_message(file, cmd, argp);
-	case VCHIQ_IOC_GET_CONFIG32:
-		return vchiq_compat_ioctl_get_config(file, cmd, argp);
-	default:
-		return vchiq_ioctl(file, cmd, (unsigned long)argp);
+	insert = instance->completion_insert;
+	while ((insert - instance->completion_remove) >= MAX_COMPLETIONS) {
+		/* Out of space - wait for the client */
+		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+		vchiq_log_trace(vchiq_arm_log_level,
+			        "%s - completion queue full", __func__);
+		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
+		if (wait_for_completion_interruptible(
+					&instance->remove_event)) {
+			vchiq_log_info(vchiq_arm_log_level,
+				       "service_callback interrupted");
+			return VCHIQ_RETRY;
+		} else if (instance->closing) {
+			vchiq_log_info(vchiq_arm_log_level,
+				       "service_callback closing");
+			return VCHIQ_SUCCESS;
+		}
+		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 	}
-}
-
-#endif
 
-static int vchiq_open(struct inode *inode, struct file *file)
-{
-	struct vchiq_state *state = vchiq_get_state();
-	struct vchiq_instance *instance;
+	completion = &instance->completions[insert & (MAX_COMPLETIONS - 1)];
 
-	vchiq_log_info(vchiq_arm_log_level, "vchiq_open");
+	completion->header = header;
+	completion->reason = reason;
+	/* N.B. service_userdata is updated while processing AWAIT_COMPLETION */
+	completion->service_userdata = user_service->service;
+	completion->bulk_userdata = bulk_userdata;
 
-	if (!state) {
-		vchiq_log_error(vchiq_arm_log_level,
-				"vchiq has no connection to VideoCore");
-		return -ENOTCONN;
+	if (reason == VCHIQ_SERVICE_CLOSED) {
+		/*
+		 * Take an extra reference, to be held until 
+		 * this CLOSED notification is delivered.
+		 */
+		lock_service(user_service->service);
+		if (instance->use_close_delivered)
+			user_service->close_pending = 1;
 	}
 
-	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
-	if (!instance)
-		return -ENOMEM;
-
-	instance->state = state;
-	instance->pid = current->tgid;
+	/*
+	 * A write barrier is needed here to ensure that the entire completion
+	 * record is written out before the insert point.
+	 */
+	wmb();
 
-	vchiq_debugfs_add_instance(instance);
+	if (reason == VCHIQ_MESSAGE_AVAILABLE)
+		user_service->message_available_pos = insert;
 
-	init_completion(&instance->insert_event);
-	init_completion(&instance->remove_event);
-	mutex_init(&instance->completion_mutex);
-	mutex_init(&instance->bulk_waiter_list_mutex);
-	INIT_LIST_HEAD(&instance->bulk_waiter_list);
+	insert++;
+	instance->completion_insert = insert;
 
-	file->private_data = instance;
+	complete(&instance->insert_event);
 
-	return 0;
+	return VCHIQ_SUCCESS;
 }
 
-static int vchiq_release(struct inode *inode, struct file *file)
+/****************************************************************************
+ *
+ *   service_callback
+ *
+ **************************************************************************
+ */
+enum vchiq_status
+service_callback(enum vchiq_reason reason, struct vchiq_header *header,
+		 unsigned int handle, void *bulk_userdata)
 {
-	struct vchiq_instance *instance = file->private_data;
-	struct vchiq_state *state = vchiq_get_state();
+	/*
+	 * How do we ensure the callback goes to the right client?
+	 * The service_user data points to a user_service record
+	 * containing the original callback and the user state structure, which
+	 * contains a circular buffer for completion records.
+	 */
+	struct user_service *user_service;
 	struct vchiq_service *service;
-	int ret = 0;
-	int i;
-
-	vchiq_log_info(vchiq_arm_log_level, "%s: instance=%lx", __func__,
-		       (unsigned long)instance);
-
-	if (!state) {
-		ret = -EPERM;
-		goto out;
-	}
-
-	/* Ensure videocore is awake to allow termination. */
-	vchiq_use_internal(instance->state, NULL, USE_TYPE_VCHIQ);
-
-	mutex_lock(&instance->completion_mutex);
-
-	/* Wake the completion thread and ask it to exit */
-	instance->closing = 1;
-	complete(&instance->insert_event);
-
-	mutex_unlock(&instance->completion_mutex);
-
-	/* Wake the slot handler if the completion queue is full. */
-	complete(&instance->remove_event);
-
-	/* Mark all services for termination... */
-	i = 0;
-	while ((service = next_service_by_instance(state, instance, &i))) {
-		struct user_service *user_service = service->base.userdata;
+	struct vchiq_instance *instance;
+	bool skip_completion = false;
 
-		/* Wake the slot handler if the msg queue is full. */
-		complete(&user_service->remove_event);
+	DEBUG_INITIALISE(g_state.local)
 
-		vchiq_terminate_service_internal(service);
-		unlock_service(service);
-	}
+	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 
-	/* ...and wait for them to die */
-	i = 0;
-	while ((service = next_service_by_instance(state, instance, &i))) {
-		struct user_service *user_service = service->base.userdata;
+	service = handle_to_service(handle);
+	BUG_ON(!service);
+	user_service = (struct user_service *)service->base.userdata;
+	instance = user_service->instance;
 
-		wait_for_completion(&service->remove_event);
+	if (!instance || instance->closing)
+		return VCHIQ_SUCCESS;
 
-		BUG_ON(service->srvstate != VCHIQ_SRVSTATE_FREE);
+	vchiq_log_trace(vchiq_arm_log_level,
+			"%s - service %lx(%d,%p), reason %d, header %lx, "
+			"instance %lx, bulk_userdata %lx",
+			__func__, (unsigned long)user_service,
+			service->localport, user_service->userdata,
+			reason, (unsigned long)header,
+			(unsigned long)instance, (unsigned long)bulk_userdata);
 
+	if (header && user_service->is_vchi) {
 		spin_lock(&msg_queue_spinlock);
-
-		while (user_service->msg_remove != user_service->msg_insert) {
-			struct vchiq_header *header;
-			int m = user_service->msg_remove & (MSG_QUEUE_SIZE - 1);
-
-			header = user_service->msg_queue[m];
-			user_service->msg_remove++;
+		while (user_service->msg_insert ==
+			(user_service->msg_remove + MSG_QUEUE_SIZE)) {
 			spin_unlock(&msg_queue_spinlock);
+			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+			DEBUG_COUNT(MSG_QUEUE_FULL_COUNT);
+			vchiq_log_trace(vchiq_arm_log_level,
+					"%s - msg queue full", __func__);
+			/* If there is no MESSAGE_AVAILABLE in the completion
+			 * queue, add one
+			 */
+			if ((user_service->message_available_pos -
+				instance->completion_remove) < 0) {
+				enum vchiq_status status;
+
+				vchiq_log_info(vchiq_arm_log_level,
+				       "Inserting extra MESSAGE_AVAILABLE");
+				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+				status = add_completion(instance, reason,
+					NULL, user_service, bulk_userdata);
+				if (status != VCHIQ_SUCCESS) {
+					DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+					return status;
+				}
+			}
 
-			if (header)
-				vchiq_release_message(service->handle, header);
+			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+			if (wait_for_completion_interruptible(
+						&user_service->remove_event)) {
+				vchiq_log_info(vchiq_arm_log_level,
+					       "%s interrupted", __func__);
+				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+				return VCHIQ_RETRY;
+			} else if (instance->closing) {
+				vchiq_log_info(vchiq_arm_log_level,
+					       "%s closing", __func__);
+				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+				return VCHIQ_ERROR;
+			}
+			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			spin_lock(&msg_queue_spinlock);
 		}
 
-		spin_unlock(&msg_queue_spinlock);
-
-		unlock_service(service);
-	}
-
-	/* Release any closed services */
-	while (instance->completion_remove !=
-		instance->completion_insert) {
-		struct vchiq_completion_data_kernel *completion;
-		struct vchiq_service *service;
+		user_service->msg_queue[user_service->msg_insert &
+			(MSG_QUEUE_SIZE - 1)] = header;
+		user_service->msg_insert++;
 
-		completion = &instance->completions[
-			instance->completion_remove & (MAX_COMPLETIONS - 1)];
-		service = completion->service_userdata;
-		if (completion->reason == VCHIQ_SERVICE_CLOSED) {
-			struct user_service *user_service =
-							service->base.userdata;
-
-			/* Wake any blocked user-thread */
-			if (instance->use_close_delivered)
-				complete(&user_service->close_event);
-			unlock_service(service);
+		/* If there is a thread waiting in DEQUEUE_MESSAGE, or if
+		 * there is a MESSAGE_AVAILABLE in the completion queue then
+		 * bypass the completion queue.
+		 */
+		if (((user_service->message_available_pos -
+			instance->completion_remove) >= 0) ||
+			user_service->dequeue_pending) {
+			user_service->dequeue_pending = 0;
+			skip_completion = true;
 		}
-		instance->completion_remove++;
-	}
 
-	/* Release the PEER service count. */
-	vchiq_release_internal(instance->state, NULL);
-
-	{
-		struct bulk_waiter_node *waiter, *next;
+		spin_unlock(&msg_queue_spinlock);
+		complete(&user_service->insert_event);
 
-		list_for_each_entry_safe(waiter, next,
-					 &instance->bulk_waiter_list, list) {
-			list_del(&waiter->list);
-			vchiq_log_info(vchiq_arm_log_level,
-				"bulk_waiter - cleaned up %pK for pid %d",
-				waiter, waiter->pid);
-			kfree(waiter);
-		}
+		header = NULL;
 	}
+	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 
-	vchiq_debugfs_remove_instance(instance);
-
-	kfree(instance);
-	file->private_data = NULL;
+	if (skip_completion)
+		return VCHIQ_SUCCESS;
 
-out:
-	return ret;
+	return add_completion(instance, reason, header, user_service,
+		bulk_userdata);
 }
 
 /****************************************************************************
@@ -2154,33 +761,6 @@ int vchiq_dump_platform_service_state(void *dump_context,
 	return vchiq_dump(dump_context, buf, len + 1);
 }
 
-/****************************************************************************
-*
-*   vchiq_read
-*
-***************************************************************************/
-
-static ssize_t
-vchiq_read(struct file *file, char __user *buf,
-	size_t count, loff_t *ppos)
-{
-	struct dump_context context;
-	int err;
-
-	context.buf = buf;
-	context.actual = 0;
-	context.space = count;
-	context.offset = *ppos;
-
-	err = vchiq_dump_state(&context, &g_state);
-	if (err)
-		return err;
-
-	*ppos += context.actual;
-
-	return context.actual;
-}
-
 struct vchiq_state *
 vchiq_get_state(void)
 {
@@ -2195,18 +775,6 @@ vchiq_get_state(void)
 		(g_state.remote->initialised == 1)) ? &g_state : NULL;
 }
 
-static const struct file_operations
-vchiq_fops = {
-	.owner = THIS_MODULE,
-	.unlocked_ioctl = vchiq_ioctl,
-#if defined(CONFIG_COMPAT)
-	.compat_ioctl = vchiq_compat_ioctl,
-#endif
-	.open = vchiq_open,
-	.release = vchiq_release,
-	.read = vchiq_read
-};
-
 /*
  * Autosuspend related functionality
  */
@@ -2218,7 +786,7 @@ vchiq_keepalive_vchiq_callback(enum vchiq_reason reason,
 	void *bulk_user)
 {
 	vchiq_log_error(vchiq_susp_log_level,
-		"%s callback reason %d", __func__, reason);
+		        "%s callback reason %d", __func__, reason);
 	return 0;
 }
 
@@ -2249,14 +817,14 @@ vchiq_keepalive_thread_func(void *v)
 	status = vchiq_connect(instance);
 	if (status != VCHIQ_SUCCESS) {
 		vchiq_log_error(vchiq_susp_log_level,
-			"%s vchiq_connect failed %d", __func__, status);
+			        "%s vchiq_connect failed %d", __func__, status);
 		goto shutdown;
 	}
 
 	status = vchiq_add_service(instance, &params, &ka_handle);
 	if (status != VCHIQ_SUCCESS) {
 		vchiq_log_error(vchiq_susp_log_level,
-			"%s vchiq_open_service failed %d", __func__, status);
+			        "%s vchiq_open_service failed %d", __func__, status);
 		goto shutdown;
 	}
 
@@ -2740,7 +1308,6 @@ static int vchiq_probe(struct platform_device *pdev)
 	struct device_node *fw_node;
 	const struct of_device_id *of_id;
 	struct vchiq_drvdata *drvdata;
-	struct device *vchiq_dev;
 	int err;
 
 	of_id = of_match_node(vchiq_of_match, pdev->dev.of_node);
@@ -2766,28 +1333,18 @@ static int vchiq_probe(struct platform_device *pdev)
 	if (err)
 		goto failed_platform_init;
 
-	cdev_init(&vchiq_cdev, &vchiq_fops);
-	vchiq_cdev.owner = THIS_MODULE;
-	err = cdev_add(&vchiq_cdev, vchiq_devid, 1);
-	if (err) {
-		vchiq_log_error(vchiq_arm_log_level,
-			"Unable to register device");
-		goto failed_platform_init;
-	}
-
-	vchiq_dev = device_create(vchiq_class, &pdev->dev, vchiq_devid, NULL,
-				  "vchiq");
-	if (IS_ERR(vchiq_dev)) {
-		err = PTR_ERR(vchiq_dev);
-		goto failed_device_create;
-	}
-
 	vchiq_debugfs_init();
 
 	vchiq_log_info(vchiq_arm_log_level,
-		"vchiq: initialised - version %d (min %d), device %d.%d",
-		VCHIQ_VERSION, VCHIQ_VERSION_MIN,
-		MAJOR(vchiq_devid), MINOR(vchiq_devid));
+		"vchiq: platform initialised - version %d (min %d)",
+		VCHIQ_VERSION, VCHIQ_VERSION_MIN);
+
+	/*
+	 * We don't handle error here since the function handles
+	 * cleanup in cases of failure. Further, we can proceed
+	 * even if this function fails.
+	 */
+	vchiq_register_chrdev(&pdev->dev);
 
 	vcsm_cma = vchiq_register_child(pdev, "vcsm-cma");
 	bcm2835_codec = vchiq_register_child(pdev, "bcm2835-codec");
@@ -2797,8 +1354,6 @@ static int vchiq_probe(struct platform_device *pdev)
 
 	return 0;
 
-failed_device_create:
-	cdev_del(&vchiq_cdev);
 failed_platform_init:
 	vchiq_log_warning(vchiq_arm_log_level, "could not load vchiq");
 	return err;
@@ -2812,8 +1367,7 @@ static int vchiq_remove(struct platform_device *pdev)
 	platform_device_unregister(bcm2835_codec);
 	platform_device_unregister(vcsm_cma);
 	vchiq_debugfs_deinit();
-	device_destroy(vchiq_class, vchiq_devid);
-	cdev_del(&vchiq_cdev);
+	vchiq_deregister_chrdev();
 
 	return 0;
 }
@@ -2831,32 +1385,11 @@ static int __init vchiq_driver_init(void)
 {
 	int ret;
 
-	vchiq_class = class_create(THIS_MODULE, DEVICE_NAME);
-	if (IS_ERR(vchiq_class)) {
-		pr_err("Failed to create vchiq class\n");
-		return PTR_ERR(vchiq_class);
-	}
-
-	ret = alloc_chrdev_region(&vchiq_devid, 0, 1, DEVICE_NAME);
-	if (ret) {
-		pr_err("Failed to allocate vchiq's chrdev region\n");
-		goto class_destroy;
-	}
-
 	ret = platform_driver_register(&vchiq_driver);
 	if (ret) {
 		pr_err("Failed to register vchiq driver\n");
-		goto region_unregister;
 	}
 
-	return 0;
-
-region_unregister:
-	unregister_chrdev_region(vchiq_devid, 1);
-
-class_destroy:
-	class_destroy(vchiq_class);
-
 	return ret;
 }
 module_init(vchiq_driver_init);
@@ -2864,8 +1397,6 @@ module_init(vchiq_driver_init);
 static void __exit vchiq_driver_exit(void)
 {
 	platform_driver_unregister(&vchiq_driver);
-	unregister_chrdev_region(vchiq_devid, 1);
-	class_destroy(vchiq_class);
 }
 module_exit(vchiq_driver_exit);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index f8b1c005af62..7cfd9eb36b99 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -14,6 +14,12 @@
 #include "vchiq_core.h"
 #include "vchiq_debugfs.h"
 
+/* Some per-instance constants */
+#define MAX_COMPLETIONS 128
+#define MAX_SERVICES 64
+#define MAX_ELEMENTS 8
+#define MSG_QUEUE_SIZE 128
+
 enum USE_TYPE_E {
 	USE_TYPE_SERVICE,
 	USE_TYPE_VCHIQ
@@ -56,8 +62,65 @@ struct vchiq_drvdata {
 	struct rpi_firmware *fw;
 };
 
+struct user_service {
+	struct vchiq_service *service;
+	void __user *userdata;
+	struct vchiq_instance *instance;
+	char is_vchi;
+	char dequeue_pending;
+	char close_pending;
+	int message_available_pos;
+	int msg_insert;
+	int msg_remove;
+	struct completion insert_event;
+	struct completion remove_event;
+	struct completion close_event;
+	struct vchiq_header *msg_queue[MSG_QUEUE_SIZE];
+};
+
+struct bulk_waiter_node {
+	struct bulk_waiter bulk_waiter;
+	int pid;
+	struct list_head list;
+};
+
+struct vchiq_instance {
+	struct vchiq_state *state;
+	struct vchiq_completion_data_kernel completions[MAX_COMPLETIONS];
+	int completion_insert;
+	int completion_remove;
+	struct completion insert_event;
+	struct completion remove_event;
+	struct mutex completion_mutex;
+
+	int connected;
+	int closing;
+	int pid;
+	int mark;
+	int use_close_delivered;
+	int trace;
+
+	struct list_head bulk_waiter_list;
+	struct mutex bulk_waiter_list_mutex;
+
+	struct vchiq_debugfs_node debugfs_node;
+};
+
+struct dump_context {
+	char __user *buf;
+	size_t actual;
+	size_t space;
+	loff_t offset;
+};
+
 extern int vchiq_arm_log_level;
 extern int vchiq_susp_log_level;
+extern spinlock_t msg_queue_spinlock;
+/*
+ * Declaring the state variable here since it is shared between char driver and
+ * platform driver initialization code.
+ */
+extern struct vchiq_state g_state;
 
 int vchiq_platform_init(struct platform_device *pdev,
 			struct vchiq_state *state);
@@ -112,4 +175,14 @@ vchiq_instance_get_trace(struct vchiq_instance *instance);
 extern void
 vchiq_instance_set_trace(struct vchiq_instance *instance, int trace);
 
+extern void
+vchiq_deregister_chrdev(void);
+
+extern int
+vchiq_register_chrdev(struct device *parent);
+
+enum vchiq_status
+service_callback(enum vchiq_reason reason, struct vchiq_header *header,
+		 unsigned int handle, void *bulk_userdata);
+
 #endif /* VCHIQ_ARM_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
new file mode 100644
index 000000000000..034dc7de0656
--- /dev/null
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -0,0 +1,1488 @@
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/compat.h>
+
+#include "vchiq_core.h"
+#include "vchiq_ioctl.h"
+#include "vchiq_arm.h"
+#include "vchiq_debugfs.h"
+
+#define DEVICE_NAME "vchiq"
+
+static struct cdev    vchiq_cdev;
+static dev_t          vchiq_devid;
+static struct class  *vchiq_class;
+
+static const char *const ioctl_names[] = {
+	"CONNECT",
+	"SHUTDOWN",
+	"CREATE_SERVICE",
+	"REMOVE_SERVICE",
+	"QUEUE_MESSAGE",
+	"QUEUE_BULK_TRANSMIT",
+	"QUEUE_BULK_RECEIVE",
+	"AWAIT_COMPLETION",
+	"DEQUEUE_MESSAGE",
+	"GET_CLIENT_ID",
+	"GET_CONFIG",
+	"CLOSE_SERVICE",
+	"USE_SERVICE",
+	"RELEASE_SERVICE",
+	"SET_SERVICE_OPTION",
+	"DUMP_PHYS_MEM",
+	"LIB_VERSION",
+	"CLOSE_DELIVERED"
+};
+
+vchiq_static_assert(ARRAY_SIZE(ioctl_names) ==
+		    (VCHIQ_IOC_MAX + 1));
+
+static void
+user_service_free(void *userdata)
+{
+	kfree(userdata);
+}
+
+static void close_delivered(struct user_service *user_service)
+{
+	vchiq_log_info(vchiq_arm_log_level,
+		       "%s(handle=%x)",
+		       __func__, user_service->service->handle);
+
+	if (user_service->close_pending) {
+		/* Allow the underlying service to be culled */
+		unlock_service(user_service->service);
+
+		/* Wake the user-thread blocked in close_ or remove_service */
+		complete(&user_service->close_event);
+
+		user_service->close_pending = 0;
+	}
+}
+
+struct vchiq_io_copy_callback_context {
+	struct vchiq_element *element;
+	size_t element_offset;
+	unsigned long elements_to_go;
+};
+
+static ssize_t vchiq_ioc_copy_element_data(void *context, void *dest,
+					   size_t offset, size_t maxsize)
+{
+	struct vchiq_io_copy_callback_context *cc = context;
+	size_t total_bytes_copied = 0;
+	size_t bytes_this_round;
+
+	while (total_bytes_copied < maxsize) {
+		if (!cc->elements_to_go)
+			return total_bytes_copied;
+
+		if (!cc->element->size) {
+			cc->elements_to_go--;
+			cc->element++;
+			cc->element_offset = 0;
+			continue;
+		}
+
+		bytes_this_round = min(cc->element->size - cc->element_offset,
+				       maxsize - total_bytes_copied);
+
+		if (copy_from_user(dest + total_bytes_copied,
+				   cc->element->data + cc->element_offset,
+				   bytes_this_round))
+			return -EFAULT;
+
+		cc->element_offset += bytes_this_round;
+		total_bytes_copied += bytes_this_round;
+
+		if (cc->element_offset == cc->element->size) {
+			cc->elements_to_go--;
+			cc->element++;
+			cc->element_offset = 0;
+		}
+	}
+
+	return maxsize;
+}
+
+static int
+vchiq_ioc_queue_message(unsigned int handle,
+			struct vchiq_element *elements,
+			unsigned long count)
+{
+	struct vchiq_io_copy_callback_context context;
+	enum vchiq_status status = VCHIQ_SUCCESS;
+	unsigned long i;
+	size_t total_size = 0;
+
+	context.element = elements;
+	context.element_offset = 0;
+	context.elements_to_go = count;
+
+	for (i = 0; i < count; i++) {
+		if (!elements[i].data && elements[i].size != 0)
+			return -EFAULT;
+
+		total_size += elements[i].size;
+	}
+
+	status = vchiq_queue_message(handle, vchiq_ioc_copy_element_data,
+				     &context, total_size);
+
+	if (status == VCHIQ_ERROR)
+		return -EIO;
+	else if (status == VCHIQ_RETRY)
+		return -EINTR;
+	return 0;
+}
+
+/* read a user pointer value from an array pointers in user space */
+static inline int vchiq_get_user_ptr(void __user **buf, void __user *ubuf, int index)
+{
+	int ret;
+
+	if (in_compat_syscall()) {
+		compat_uptr_t ptr32;
+
+		compat_uptr_t __user *uptr = ubuf;
+		ret = get_user(ptr32, uptr + index);
+		*buf = compat_ptr(ptr32);
+	} else {
+		uintptr_t ptr, __user *uptr = ubuf;
+
+		ret = get_user(ptr, uptr + index);
+		*buf = (void __user *)ptr;
+	}
+
+	return ret;
+}
+
+struct vchiq_completion_data32 {
+	enum vchiq_reason reason;
+	compat_uptr_t header;
+	compat_uptr_t service_userdata;
+	compat_uptr_t bulk_userdata;
+};
+
+static int vchiq_put_completion(struct vchiq_completion_data __user *buf,
+				struct vchiq_completion_data *completion,
+				int index)
+{
+	struct vchiq_completion_data32 __user *buf32 = (void __user *)buf;
+
+	if (in_compat_syscall()) {
+		struct vchiq_completion_data32 tmp = {
+			.reason		  = completion->reason,
+			.header		  = ptr_to_compat(completion->header),
+			.service_userdata = ptr_to_compat(completion->service_userdata),
+			.bulk_userdata	  = ptr_to_compat(completion->bulk_userdata),
+		};
+		if (copy_to_user(&buf32[index], &tmp, sizeof(tmp)))
+			return -EFAULT;
+	} else {
+		if (copy_to_user(&buf[index], completion, sizeof(*completion)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
+				      struct vchiq_await_completion *args,
+				      int __user *msgbufcountp)
+{
+	int msgbufcount;
+	int remove;
+	int ret;
+
+	DEBUG_INITIALISE(g_state.local)
+
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+	if (!instance->connected)
+		return -ENOTCONN;
+
+	mutex_lock(&instance->completion_mutex);
+
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+	while ((instance->completion_remove == instance->completion_insert)
+		&& !instance->closing) {
+		int rc;
+
+		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+		mutex_unlock(&instance->completion_mutex);
+		rc = wait_for_completion_interruptible(
+					&instance->insert_event);
+		mutex_lock(&instance->completion_mutex);
+		if (rc) {
+			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+			vchiq_log_info(vchiq_arm_log_level,
+				       "AWAIT_COMPLETION interrupted");
+			ret = -EINTR;
+			goto out;
+		}
+	}
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+
+	msgbufcount = args->msgbufcount;
+	remove = instance->completion_remove;
+
+	for (ret = 0; ret < args->count; ret++) {
+		struct vchiq_completion_data_kernel *completion;
+		struct vchiq_completion_data user_completion;
+		struct vchiq_service *service;
+		struct user_service *user_service;
+		struct vchiq_header *header;
+
+		if (remove == instance->completion_insert)
+			break;
+
+		completion = &instance->completions[
+			remove & (MAX_COMPLETIONS - 1)];
+
+		/*
+		 * A read memory barrier is needed to stop
+		 * prefetch of a stale completion record
+		 */
+		rmb();
+
+		service = completion->service_userdata;
+		user_service = service->base.userdata;
+
+		memset(&user_completion, 0, sizeof(user_completion));
+		user_completion = (struct vchiq_completion_data) {
+			.reason = completion->reason,
+			.service_userdata = user_service->userdata,
+		};
+
+		header = completion->header;
+		if (header) {
+			void __user *msgbuf;
+			int msglen;
+
+			msglen = header->size + sizeof(struct vchiq_header);
+			/* This must be a VCHIQ-style service */
+			if (args->msgbufsize < msglen) {
+				vchiq_log_error(vchiq_arm_log_level,
+					"header %pK: msgbufsize %x < msglen %x",
+					header, args->msgbufsize, msglen);
+				WARN(1, "invalid message size\n");
+				if (ret == 0)
+					ret = -EMSGSIZE;
+				break;
+			}
+			if (msgbufcount <= 0)
+				/*
+				 * Stall here for lack of a
+				 * buffer for the message.
+				 */
+				break;
+			/* Get the pointer from user space */
+			msgbufcount--;
+			if (vchiq_get_user_ptr(&msgbuf, args->msgbufs,
+					       msgbufcount)) {
+				if (ret == 0)
+					ret = -EFAULT;
+				break;
+			}
+
+			/* Copy the message to user space */
+			if (copy_to_user(msgbuf, header, msglen)) {
+				if (ret == 0)
+					ret = -EFAULT;
+				break;
+			}
+
+			/* Now it has been copied, the message
+			 * can be released.
+			 */
+			vchiq_release_message(service->handle, header);
+
+			/* The completion must point to the
+			 * msgbuf.
+			 */
+			user_completion.header = msgbuf;
+		}
+
+		if ((completion->reason == VCHIQ_SERVICE_CLOSED) &&
+		    !instance->use_close_delivered)
+			unlock_service(service);
+
+		/*
+		 * FIXME: address space mismatch, does bulk_userdata
+		 * actually point to user or kernel memory?
+		 */
+		user_completion.bulk_userdata = completion->bulk_userdata;
+
+		if (vchiq_put_completion(args->buf, &user_completion, ret)) {
+			if (ret == 0)
+				ret = -EFAULT;
+			break;
+		}
+
+		/*
+		 * Ensure that the above copy has completed
+		 * before advancing the remove pointer.
+		 */
+		mb();
+		remove++;
+		instance->completion_remove = remove;
+	}
+
+	if (msgbufcount != args->msgbufcount) {
+		if (put_user(msgbufcount, msgbufcountp))
+			ret = -EFAULT;
+	}
+out:
+	if (ret)
+		complete(&instance->remove_event);
+	mutex_unlock(&instance->completion_mutex);
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+
+	return ret;
+}
+
+static int vchiq_ioc_create_service(struct vchiq_instance *instance,
+				    struct vchiq_create_service *args)
+{
+	struct user_service *user_service = NULL;
+	struct vchiq_service *service;
+	enum vchiq_status status = VCHIQ_SUCCESS;
+	struct vchiq_service_params_kernel params;
+	int srvstate;
+
+	user_service = kmalloc(sizeof(*user_service), GFP_KERNEL);
+	if (!user_service)
+		return -ENOMEM;
+
+	if (args->is_open) {
+		if (!instance->connected) {
+			kfree(user_service);
+			return -ENOTCONN;
+		}
+		srvstate = VCHIQ_SRVSTATE_OPENING;
+	} else {
+		srvstate = instance->connected ?
+			 VCHIQ_SRVSTATE_LISTENING : VCHIQ_SRVSTATE_HIDDEN;
+	}
+
+	params = (struct vchiq_service_params_kernel) {
+		.fourcc   = args->params.fourcc,
+		.callback = service_callback,
+		.userdata = user_service,
+		.version  = args->params.version,
+		.version_min = args->params.version_min,
+	};
+	service = vchiq_add_service_internal(instance->state, &params,
+					     srvstate, instance,
+					     user_service_free);
+	if (!service) {
+		kfree(user_service);
+		return -EEXIST;
+	}
+
+	user_service->service = service;
+	user_service->userdata = args->params.userdata;
+	user_service->instance = instance;
+	user_service->is_vchi = (args->is_vchi != 0);
+	user_service->dequeue_pending = 0;
+	user_service->close_pending = 0;
+	user_service->message_available_pos = instance->completion_remove - 1;
+	user_service->msg_insert = 0;
+	user_service->msg_remove = 0;
+	init_completion(&user_service->insert_event);
+	init_completion(&user_service->remove_event);
+	init_completion(&user_service->close_event);
+
+	if (args->is_open) {
+		status = vchiq_open_service_internal(service, instance->pid);
+		if (status != VCHIQ_SUCCESS) {
+			vchiq_remove_service(service->handle);
+			return (status == VCHIQ_RETRY) ?
+				-EINTR : -EIO;
+		}
+	}
+	args->handle = service->handle;
+
+	return 0;
+}
+
+static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
+				     struct vchiq_dequeue_message *args)
+{
+	struct user_service *user_service;
+	struct vchiq_service *service;
+	struct vchiq_header *header;
+	int ret;
+
+	DEBUG_INITIALISE(g_state.local)
+	DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+	service = find_service_for_instance(instance, args->handle);
+	if (!service)
+		return -EINVAL;
+
+	user_service = (struct user_service *)service->base.userdata;
+	if (user_service->is_vchi == 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	spin_lock(&msg_queue_spinlock);
+	if (user_service->msg_remove == user_service->msg_insert) {
+		if (!args->blocking) {
+			spin_unlock(&msg_queue_spinlock);
+			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+			ret = -EWOULDBLOCK;
+			goto out;
+		}
+		user_service->dequeue_pending = 1;
+		ret = 0;
+		do {
+			spin_unlock(&msg_queue_spinlock);
+			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+			if (wait_for_completion_interruptible(
+				&user_service->insert_event)) {
+				vchiq_log_info(vchiq_arm_log_level,
+					       "DEQUEUE_MESSAGE interrupted");
+				ret = -EINTR;
+				break;
+			}
+			spin_lock(&msg_queue_spinlock);
+		} while (user_service->msg_remove ==
+			user_service->msg_insert);
+
+		if (ret)
+			goto out;
+	}
+
+	BUG_ON((int)(user_service->msg_insert -
+		user_service->msg_remove) < 0);
+
+	header = user_service->msg_queue[user_service->msg_remove &
+		(MSG_QUEUE_SIZE - 1)];
+	user_service->msg_remove++;
+	spin_unlock(&msg_queue_spinlock);
+
+	complete(&user_service->remove_event);
+	if (!header) {
+		ret = -ENOTCONN;
+	} else if (header->size <= args->bufsize) {
+		/* Copy to user space if msgbuf is not NULL */
+		if (!args->buf || (copy_to_user(args->buf,
+					header->data, header->size) == 0)) {
+			ret = header->size;
+			vchiq_release_message(service->handle, header);
+		} else {
+			ret = -EFAULT;
+		}
+	} else {
+		vchiq_log_error(vchiq_arm_log_level,
+				"header %pK: bufsize %x < size %x",
+				header, args->bufsize, header->size);
+		WARN(1, "invalid size\n");
+		ret = -EMSGSIZE;
+	}
+	DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+out:
+	unlock_service(service);
+	return ret;
+}
+
+static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
+				      struct vchiq_queue_bulk_transfer *args,
+				      enum vchiq_bulk_dir dir,
+				      enum vchiq_bulk_mode __user *mode)
+{
+	struct vchiq_service *service;
+	struct bulk_waiter_node *waiter = NULL;
+	bool found = false;
+	void *userdata;
+	int status = 0;
+	int ret;
+
+	service = find_service_for_instance(instance, args->handle);
+	if (!service)
+		return -EINVAL;
+
+	if (args->mode == VCHIQ_BULK_MODE_BLOCKING) {
+		waiter = kzalloc(sizeof(struct bulk_waiter_node),
+				 GFP_KERNEL);
+		if (!waiter) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		userdata = &waiter->bulk_waiter;
+	} else if (args->mode == VCHIQ_BULK_MODE_WAITING) {
+		mutex_lock(&instance->bulk_waiter_list_mutex);
+		list_for_each_entry(waiter, &instance->bulk_waiter_list,
+				    list) {
+			if (waiter->pid == current->pid) {
+				list_del(&waiter->list);
+				found = true;
+				break;
+			}
+		}
+		mutex_unlock(&instance->bulk_waiter_list_mutex);
+		if (!found) {
+			vchiq_log_error(vchiq_arm_log_level,
+					"no bulk_waiter found for pid %d",
+					current->pid);
+			ret = -ESRCH;
+			goto out;
+		}
+		vchiq_log_info(vchiq_arm_log_level,
+			       "found bulk_waiter %pK for pid %d", waiter,
+			       current->pid);
+		userdata = &waiter->bulk_waiter;
+	} else {
+		userdata = args->userdata;
+	}
+
+	/*
+	 * FIXME address space mismatch:
+	 * args->data may be interpreted as a kernel pointer
+	 * in create_pagelist() called from vchiq_bulk_transfer(),
+	 * accessing kernel data instead of user space, based on the
+	 * address.
+	 */
+	status = vchiq_bulk_transfer(args->handle, NULL, args->data, args->size,
+				     userdata, args->mode, dir);
+
+	if (!waiter) {
+		ret = 0;
+		goto out;
+	}
+
+	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
+		!waiter->bulk_waiter.bulk) {
+		if (waiter->bulk_waiter.bulk) {
+			/* Cancel the signal when the transfer
+			 * completes.
+			 */
+			spin_lock(&bulk_waiter_spinlock);
+			waiter->bulk_waiter.bulk->userdata = NULL;
+			spin_unlock(&bulk_waiter_spinlock);
+		}
+		kfree(waiter);
+		ret = 0;
+	} else {
+		const enum vchiq_bulk_mode mode_waiting =
+			VCHIQ_BULK_MODE_WAITING;
+		waiter->pid = current->pid;
+		mutex_lock(&instance->bulk_waiter_list_mutex);
+		list_add(&waiter->list, &instance->bulk_waiter_list);
+		mutex_unlock(&instance->bulk_waiter_list_mutex);
+		vchiq_log_info(vchiq_arm_log_level,
+			       "saved bulk_waiter %pK for pid %d",
+			       waiter, current->pid);
+
+		ret = put_user(mode_waiting, mode);
+	}
+out:
+	unlock_service(service);
+	if (ret)
+		return ret;
+	else if (status == VCHIQ_ERROR)
+		return -EIO;
+	else if (status == VCHIQ_RETRY)
+		return -EINTR;
+	return 0;
+}
+
+/****************************************************************************
+ *
+ *   vchiq_read
+ *
+ **************************************************************************
+ */
+static ssize_t
+vchiq_read(struct file *file, char __user *buf,
+	size_t count, loff_t *ppos)
+{
+	struct dump_context context;
+	int err;
+
+	context.buf = buf;
+	context.actual = 0;
+	context.space = count;
+	context.offset = *ppos;
+
+	err = vchiq_dump_state(&context, &g_state);
+	if (err)
+		return err;
+
+	*ppos += context.actual;
+
+	return context.actual;
+}
+
+/****************************************************************************
+*
+*   vchiq_open
+*
+***************************************************************************/
+static int vchiq_open(struct inode *inode, struct file *file)
+{
+	struct vchiq_state *state = vchiq_get_state();
+	struct vchiq_instance *instance;
+
+	vchiq_log_info(vchiq_arm_log_level, "vchiq_open");
+
+	if (!state) {
+		vchiq_log_error(vchiq_arm_log_level,
+				"vchiq has no connection to VideoCore");
+		return -ENOTCONN;
+	}
+
+	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
+	if (!instance)
+		return -ENOMEM;
+
+	instance->state = state;
+	instance->pid = current->tgid;
+
+	vchiq_debugfs_add_instance(instance);
+
+	init_completion(&instance->insert_event);
+	init_completion(&instance->remove_event);
+	mutex_init(&instance->completion_mutex);
+	mutex_init(&instance->bulk_waiter_list_mutex);
+	INIT_LIST_HEAD(&instance->bulk_waiter_list);
+
+	file->private_data = instance;
+
+	return 0;
+}
+
+/****************************************************************************
+ *
+ *   vchiq_release
+ *
+ **************************************************************************
+ */
+static int vchiq_release(struct inode *inode, struct file *file)
+{
+	struct vchiq_instance *instance = file->private_data;
+	struct vchiq_state *state = vchiq_get_state();
+	struct vchiq_service *service;
+	int ret = 0;
+	int i;
+
+	vchiq_log_info(vchiq_arm_log_level, "%s: instance=%lx", __func__,
+		       (unsigned long)instance);
+
+	if (!state) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	/* Ensure videocore is awake to allow termination. */
+	vchiq_use_internal(instance->state, NULL, USE_TYPE_VCHIQ);
+
+	mutex_lock(&instance->completion_mutex);
+
+	/* Wake the completion thread and ask it to exit */
+	instance->closing = 1;
+	complete(&instance->insert_event);
+
+	mutex_unlock(&instance->completion_mutex);
+
+	/* Wake the slot handler if the completion queue is full. */
+	complete(&instance->remove_event);
+
+	/* Mark all services for termination... */
+	i = 0;
+	while ((service = next_service_by_instance(state, instance, &i))) {
+		struct user_service *user_service = service->base.userdata;
+
+		/* Wake the slot handler if the msg queue is full. */
+		complete(&user_service->remove_event);
+
+		vchiq_terminate_service_internal(service);
+		unlock_service(service);
+	}
+
+	/* ...and wait for them to die */
+	i = 0;
+	while ((service = next_service_by_instance(state, instance, &i))) {
+		struct user_service *user_service = service->base.userdata;
+
+		wait_for_completion(&service->remove_event);
+
+		BUG_ON(service->srvstate != VCHIQ_SRVSTATE_FREE);
+
+		spin_lock(&msg_queue_spinlock);
+
+		while (user_service->msg_remove != user_service->msg_insert) {
+			struct vchiq_header *header;
+			int m = user_service->msg_remove & (MSG_QUEUE_SIZE - 1);
+
+			header = user_service->msg_queue[m];
+			user_service->msg_remove++;
+			spin_unlock(&msg_queue_spinlock);
+
+			if (header)
+				vchiq_release_message(service->handle, header);
+			spin_lock(&msg_queue_spinlock);
+		}
+
+		spin_unlock(&msg_queue_spinlock);
+
+		unlock_service(service);
+	}
+
+	/* Release any closed services */
+	while (instance->completion_remove !=
+		instance->completion_insert) {
+		struct vchiq_completion_data_kernel *completion;
+		struct vchiq_service *service;
+
+		completion = &instance->completions[
+			instance->completion_remove & (MAX_COMPLETIONS - 1)];
+		service = completion->service_userdata;
+		if (completion->reason == VCHIQ_SERVICE_CLOSED) {
+			struct user_service *user_service =
+							service->base.userdata;
+
+			/* Wake any blocked user-thread */
+			if (instance->use_close_delivered)
+				complete(&user_service->close_event);
+			unlock_service(service);
+		}
+		instance->completion_remove++;
+	}
+
+	/* Release the PEER service count. */
+	vchiq_release_internal(instance->state, NULL);
+
+	{
+		struct bulk_waiter_node *waiter, *next;
+
+		list_for_each_entry_safe(waiter, next,
+					 &instance->bulk_waiter_list, list) {
+			list_del(&waiter->list);
+			vchiq_log_info(vchiq_arm_log_level,
+				"bulk_waiter - cleaned up %pK for pid %d",
+				waiter, waiter->pid);
+			kfree(waiter);
+		}
+	}
+
+	vchiq_debugfs_remove_instance(instance);
+
+	kfree(instance);
+	file->private_data = NULL;
+
+out:
+	return ret;
+}
+
+/****************************************************************************
+ *
+ *   vchiq_ioctl
+ *
+ **************************************************************************
+ */
+static long
+vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct vchiq_instance *instance = file->private_data;
+	enum vchiq_status status = VCHIQ_SUCCESS;
+	struct vchiq_service *service = NULL;
+	long ret = 0;
+	int i, rc;
+
+	vchiq_log_trace(vchiq_arm_log_level,
+			"%s - instance %pK, cmd %s, arg %lx",
+			__func__, instance,
+			((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) &&
+			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
+			ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
+
+	switch (cmd) {
+	case VCHIQ_IOC_SHUTDOWN:
+		if (!instance->connected)
+			break;
+
+		/* Remove all services */
+		i = 0;
+		while ((service = next_service_by_instance(instance->state,
+			instance, &i))) {
+			status = vchiq_remove_service(service->handle);
+			unlock_service(service);
+			if (status != VCHIQ_SUCCESS)
+				break;
+		}
+		service = NULL;
+
+		if (status == VCHIQ_SUCCESS) {
+			/* Wake the completion thread and ask it to exit */
+			instance->closing = 1;
+			complete(&instance->insert_event);
+		}
+
+		break;
+
+	case VCHIQ_IOC_CONNECT:
+		if (instance->connected) {
+			ret = -EINVAL;
+			break;
+		}
+		rc = mutex_lock_killable(&instance->state->mutex);
+		if (rc) {
+			vchiq_log_error(vchiq_arm_log_level,
+				"vchiq: connect: could not lock mutex for "
+				"state %d: %d",
+				instance->state->id, rc);
+			ret = -EINTR;
+			break;
+		}
+		status = vchiq_connect_internal(instance->state, instance);
+		mutex_unlock(&instance->state->mutex);
+
+		if (status == VCHIQ_SUCCESS)
+			instance->connected = 1;
+		else
+			vchiq_log_error(vchiq_arm_log_level,
+					"vchiq: could not connect: %d", status);
+		break;
+
+	case VCHIQ_IOC_CREATE_SERVICE: {
+		struct vchiq_create_service __user *argp;
+		struct vchiq_create_service args;
+
+		argp = (void __user *)arg;
+		if (copy_from_user(&args, argp, sizeof(args))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = vchiq_ioc_create_service(instance, &args);
+		if (ret < 0)
+			break;
+
+		if (put_user(args.handle, &argp->handle)) {
+			vchiq_remove_service(args.handle);
+			ret = -EFAULT;
+		}
+	} break;
+
+	case VCHIQ_IOC_CLOSE_SERVICE:
+	case VCHIQ_IOC_REMOVE_SERVICE: {
+		unsigned int handle = (unsigned int)arg;
+		struct user_service *user_service;
+
+		service = find_service_for_instance(instance, handle);
+		if (!service) {
+			ret = -EINVAL;
+			break;
+		}
+
+		user_service = service->base.userdata;
+
+		/*
+		 * close_pending is false on first entry, and when the
+		 * wait in vchiq_close_service has been interrupted.
+		 */
+		if (!user_service->close_pending) {
+			status = (cmd == VCHIQ_IOC_CLOSE_SERVICE) ?
+				 vchiq_close_service(service->handle) :
+				 vchiq_remove_service(service->handle);
+			if (status != VCHIQ_SUCCESS)
+				break;
+		}
+
+		/*
+		 * close_pending is true once the underlying service
+		 * has been closed until the client library calls the
+		 * CLOSE_DELIVERED ioctl, signalling close_event.
+		 */
+		if (user_service->close_pending &&
+			wait_for_completion_interruptible(
+				&user_service->close_event))
+			status = VCHIQ_RETRY;
+		break;
+	}
+
+	case VCHIQ_IOC_USE_SERVICE:
+	case VCHIQ_IOC_RELEASE_SERVICE:	{
+		unsigned int handle = (unsigned int)arg;
+
+		service = find_service_for_instance(instance, handle);
+		if (service) {
+			status = (cmd == VCHIQ_IOC_USE_SERVICE)	?
+				vchiq_use_service_internal(service) :
+				vchiq_release_service_internal(service);
+			if (status != VCHIQ_SUCCESS) {
+				vchiq_log_error(vchiq_susp_log_level,
+					"%s: cmd %s returned error %d for "
+					"service %c%c%c%c:%03d",
+					__func__,
+					(cmd == VCHIQ_IOC_USE_SERVICE) ?
+						"VCHIQ_IOC_USE_SERVICE" :
+						"VCHIQ_IOC_RELEASE_SERVICE",
+					status,
+					VCHIQ_FOURCC_AS_4CHARS(
+						service->base.fourcc),
+					service->client_id);
+				ret = -EINVAL;
+			}
+		} else
+			ret = -EINVAL;
+	} break;
+
+	case VCHIQ_IOC_QUEUE_MESSAGE: {
+		struct vchiq_queue_message args;
+
+		if (copy_from_user(&args, (const void __user *)arg,
+				   sizeof(args))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		service = find_service_for_instance(instance, args.handle);
+
+		if (service && (args.count <= MAX_ELEMENTS)) {
+			/* Copy elements into kernel space */
+			struct vchiq_element elements[MAX_ELEMENTS];
+
+			if (copy_from_user(elements, args.elements,
+				args.count * sizeof(struct vchiq_element)) == 0)
+				ret = vchiq_ioc_queue_message(args.handle, elements,
+							      args.count);
+			else
+				ret = -EFAULT;
+		} else {
+			ret = -EINVAL;
+		}
+	} break;
+
+	case VCHIQ_IOC_QUEUE_BULK_TRANSMIT:
+	case VCHIQ_IOC_QUEUE_BULK_RECEIVE: {
+		struct vchiq_queue_bulk_transfer args;
+		struct vchiq_queue_bulk_transfer __user *argp;
+
+		enum vchiq_bulk_dir dir =
+			(cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT) ?
+			VCHIQ_BULK_TRANSMIT : VCHIQ_BULK_RECEIVE;
+
+		argp = (void __user *)arg;
+		if (copy_from_user(&args, argp, sizeof(args))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = vchiq_irq_queue_bulk_tx_rx(instance, &args,
+						 dir, &argp->mode);
+	} break;
+
+	case VCHIQ_IOC_AWAIT_COMPLETION: {
+		struct vchiq_await_completion args;
+		struct vchiq_await_completion __user *argp;
+
+		argp = (void __user *)arg;
+		if (copy_from_user(&args, argp, sizeof(args))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = vchiq_ioc_await_completion(instance, &args,
+						 &argp->msgbufcount);
+	} break;
+
+	case VCHIQ_IOC_DEQUEUE_MESSAGE: {
+		struct vchiq_dequeue_message args;
+
+		if (copy_from_user(&args, (const void __user *)arg,
+				   sizeof(args))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = vchiq_ioc_dequeue_message(instance, &args);
+	} break;
+
+	case VCHIQ_IOC_GET_CLIENT_ID: {
+		unsigned int handle = (unsigned int)arg;
+
+		ret = vchiq_get_client_id(handle);
+	} break;
+
+	case VCHIQ_IOC_GET_CONFIG: {
+		struct vchiq_get_config args;
+		struct vchiq_config config;
+
+		if (copy_from_user(&args, (const void __user *)arg,
+				   sizeof(args))) {
+			ret = -EFAULT;
+			break;
+		}
+		if (args.config_size > sizeof(config)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		vchiq_get_config(&config);
+		if (copy_to_user(args.pconfig, &config, args.config_size)) {
+			ret = -EFAULT;
+			break;
+		}
+	} break;
+
+	case VCHIQ_IOC_SET_SERVICE_OPTION: {
+		struct vchiq_set_service_option args;
+
+		if (copy_from_user(&args, (const void __user *)arg,
+				   sizeof(args))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		service = find_service_for_instance(instance, args.handle);
+		if (!service) {
+			ret = -EINVAL;
+			break;
+		}
+
+		status = vchiq_set_service_option(
+				args.handle, args.option, args.value);
+	} break;
+
+	case VCHIQ_IOC_LIB_VERSION: {
+		unsigned int lib_version = (unsigned int)arg;
+
+		if (lib_version < VCHIQ_VERSION_MIN)
+			ret = -EINVAL;
+		else if (lib_version >= VCHIQ_VERSION_CLOSE_DELIVERED)
+			instance->use_close_delivered = 1;
+	} break;
+
+	case VCHIQ_IOC_CLOSE_DELIVERED: {
+		unsigned int handle = (unsigned int)arg;
+
+		service = find_closed_service_for_instance(instance, handle);
+		if (service) {
+			struct user_service *user_service =
+				(struct user_service *)service->base.userdata;
+			close_delivered(user_service);
+		} else
+			ret = -EINVAL;
+	} break;
+
+	default:
+		ret = -ENOTTY;
+		break;
+	}
+
+	if (service)
+		unlock_service(service);
+
+	if (ret == 0) {
+		if (status == VCHIQ_ERROR)
+			ret = -EIO;
+		else if (status == VCHIQ_RETRY)
+			ret = -EINTR;
+	}
+
+	if ((status == VCHIQ_SUCCESS) && (ret < 0) && (ret != -EINTR) &&
+		(ret != -EWOULDBLOCK))
+		vchiq_log_info(vchiq_arm_log_level,
+			"  ioctl instance %pK, cmd %s -> status %d, %ld",
+			instance,
+			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
+				ioctl_names[_IOC_NR(cmd)] :
+				"<invalid>",
+			status, ret);
+	else
+		vchiq_log_trace(vchiq_arm_log_level,
+			"  ioctl instance %pK, cmd %s -> status %d, %ld",
+			instance,
+			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
+				ioctl_names[_IOC_NR(cmd)] :
+				"<invalid>",
+			status, ret);
+
+	return ret;
+}
+
+/****************************************************************************
+ *
+ * compat IOCTL related functions
+ *
+ ****************************************************************************/
+#if defined(CONFIG_COMPAT)
+
+struct vchiq_service_params32 {
+	int fourcc;
+	compat_uptr_t callback;
+	compat_uptr_t userdata;
+	short version; /* Increment for non-trivial changes */
+	short version_min; /* Update for incompatible changes */
+};
+
+struct vchiq_create_service32 {
+	struct vchiq_service_params32 params;
+	int is_open;
+	int is_vchi;
+	unsigned int handle; /* OUT */
+};
+
+#define VCHIQ_IOC_CREATE_SERVICE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 2, struct vchiq_create_service32)
+
+static long
+vchiq_compat_ioctl_create_service(
+	struct file *file,
+	unsigned int cmd,
+	struct vchiq_create_service32 __user *ptrargs32)
+{
+	struct vchiq_create_service args;
+	struct vchiq_create_service32 args32;
+	long ret;
+
+	if (copy_from_user(&args32, ptrargs32, sizeof(args32)))
+		return -EFAULT;
+
+	args = (struct vchiq_create_service) {
+		.params = {
+			.fourcc	     = args32.params.fourcc,
+			.callback    = compat_ptr(args32.params.callback),
+			.userdata    = compat_ptr(args32.params.userdata),
+			.version     = args32.params.version,
+			.version_min = args32.params.version_min,
+		},
+		.is_open = args32.is_open,
+		.is_vchi = args32.is_vchi,
+		.handle  = args32.handle,
+	};
+
+	ret = vchiq_ioc_create_service(file->private_data, &args);
+	if (ret < 0)
+		return ret;
+
+	if (put_user(args.handle, &ptrargs32->handle)) {
+		vchiq_remove_service(args.handle);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+struct vchiq_element32 {
+	compat_uptr_t data;
+	unsigned int size;
+};
+
+struct vchiq_queue_message32 {
+	unsigned int handle;
+	unsigned int count;
+	compat_uptr_t elements;
+};
+
+#define VCHIQ_IOC_QUEUE_MESSAGE32 \
+	_IOW(VCHIQ_IOC_MAGIC,  4, struct vchiq_queue_message32)
+
+static long
+vchiq_compat_ioctl_queue_message(struct file *file,
+				 unsigned int cmd,
+				 struct vchiq_queue_message32 __user *arg)
+{
+	struct vchiq_queue_message args;
+	struct vchiq_queue_message32 args32;
+	struct vchiq_service *service;
+	int ret;
+
+	if (copy_from_user(&args32, arg, sizeof(args32)))
+		return -EFAULT;
+
+	args = (struct vchiq_queue_message) {
+		.handle   = args32.handle,
+		.count    = args32.count,
+		.elements = compat_ptr(args32.elements),
+	};
+
+	if (args32.count > MAX_ELEMENTS)
+		return -EINVAL;
+
+	service = find_service_for_instance(file->private_data, args.handle);
+	if (!service)
+		return -EINVAL;
+
+	if (args32.elements && args32.count) {
+		struct vchiq_element32 element32[MAX_ELEMENTS];
+		struct vchiq_element elements[MAX_ELEMENTS];
+		unsigned int count;
+
+		if (copy_from_user(&element32, args.elements,
+				   sizeof(element32))) {
+			unlock_service(service);
+			return -EFAULT;
+		}
+
+		for (count = 0; count < args32.count; count++) {
+			elements[count].data =
+				compat_ptr(element32[count].data);
+			elements[count].size = element32[count].size;
+		}
+		ret = vchiq_ioc_queue_message(args.handle, elements,
+					      args.count);
+	} else {
+		ret = -EINVAL;
+	}
+	unlock_service(service);
+
+	return ret;
+}
+
+struct vchiq_queue_bulk_transfer32 {
+	unsigned int handle;
+	compat_uptr_t data;
+	unsigned int size;
+	compat_uptr_t userdata;
+	enum vchiq_bulk_mode mode;
+};
+
+#define VCHIQ_IOC_QUEUE_BULK_TRANSMIT32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 5, struct vchiq_queue_bulk_transfer32)
+#define VCHIQ_IOC_QUEUE_BULK_RECEIVE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 6, struct vchiq_queue_bulk_transfer32)
+
+static long
+vchiq_compat_ioctl_queue_bulk(struct file *file,
+			      unsigned int cmd,
+			      struct vchiq_queue_bulk_transfer32 __user *argp)
+{
+	struct vchiq_queue_bulk_transfer32 args32;
+	struct vchiq_queue_bulk_transfer args;
+	enum vchiq_bulk_dir dir = (cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT32) ?
+				  VCHIQ_BULK_TRANSMIT : VCHIQ_BULK_RECEIVE;
+
+	if (copy_from_user(&args32, argp, sizeof(args32)))
+		return -EFAULT;
+
+	args = (struct vchiq_queue_bulk_transfer) {
+		.handle   = args32.handle,
+		.data	  = compat_ptr(args32.data),
+		.size	  = args32.size,
+		.userdata = compat_ptr(args32.userdata),
+		.mode	  = args32.mode,
+	};
+
+	return vchiq_irq_queue_bulk_tx_rx(file->private_data, &args,
+					  dir, &argp->mode);
+}
+
+struct vchiq_await_completion32 {
+	unsigned int count;
+	compat_uptr_t buf;
+	unsigned int msgbufsize;
+	unsigned int msgbufcount; /* IN/OUT */
+	compat_uptr_t msgbufs;
+};
+
+#define VCHIQ_IOC_AWAIT_COMPLETION32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 7, struct vchiq_await_completion32)
+
+static long
+vchiq_compat_ioctl_await_completion(struct file *file,
+				    unsigned int cmd,
+				    struct vchiq_await_completion32 __user *argp)
+{
+	struct vchiq_await_completion args;
+	struct vchiq_await_completion32 args32;
+
+	if (copy_from_user(&args32, argp, sizeof(args32)))
+		return -EFAULT;
+
+	args = (struct vchiq_await_completion) {
+		.count		= args32.count,
+		.buf		= compat_ptr(args32.buf),
+		.msgbufsize	= args32.msgbufsize,
+		.msgbufcount	= args32.msgbufcount,
+		.msgbufs	= compat_ptr(args32.msgbufs),
+	};
+
+	return vchiq_ioc_await_completion(file->private_data, &args,
+					  &argp->msgbufcount);
+}
+
+struct vchiq_dequeue_message32 {
+	unsigned int handle;
+	int blocking;
+	unsigned int bufsize;
+	compat_uptr_t buf;
+};
+
+#define VCHIQ_IOC_DEQUEUE_MESSAGE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 8, struct vchiq_dequeue_message32)
+
+static long
+vchiq_compat_ioctl_dequeue_message(struct file *file,
+				   unsigned int cmd,
+				   struct vchiq_dequeue_message32 __user *arg)
+{
+	struct vchiq_dequeue_message32 args32;
+	struct vchiq_dequeue_message args;
+
+	if (copy_from_user(&args32, arg, sizeof(args32)))
+		return -EFAULT;
+
+	args = (struct vchiq_dequeue_message) {
+		.handle		= args32.handle,
+		.blocking	= args32.blocking,
+		.bufsize	= args32.bufsize,
+		.buf		= compat_ptr(args32.buf),
+	};
+
+	return vchiq_ioc_dequeue_message(file->private_data, &args);
+}
+
+struct vchiq_get_config32 {
+	unsigned int config_size;
+	compat_uptr_t pconfig;
+};
+
+#define VCHIQ_IOC_GET_CONFIG32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 10, struct vchiq_get_config32)
+
+static long
+vchiq_compat_ioctl_get_config(struct file *file,
+			      unsigned int cmd,
+			      struct vchiq_get_config32 __user *arg)
+{
+	struct vchiq_get_config32 args32;
+	struct vchiq_config config;
+	void __user *ptr;
+
+	if (copy_from_user(&args32, arg, sizeof(args32)))
+		return -EFAULT;
+	if (args32.config_size > sizeof(config))
+		return -EINVAL;
+
+	vchiq_get_config(&config);
+	ptr = compat_ptr(args32.pconfig);
+	if (copy_to_user(ptr, &config, args32.config_size))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ *
+ *   vchiq_compat_ioctl
+ *
+ */
+static long
+vchiq_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = compat_ptr(arg);
+	switch (cmd) {
+	case VCHIQ_IOC_CREATE_SERVICE32:
+		return vchiq_compat_ioctl_create_service(file, cmd, argp);
+	case VCHIQ_IOC_QUEUE_MESSAGE32:
+		return vchiq_compat_ioctl_queue_message(file, cmd, argp);
+	case VCHIQ_IOC_QUEUE_BULK_TRANSMIT32:
+	case VCHIQ_IOC_QUEUE_BULK_RECEIVE32:
+		return vchiq_compat_ioctl_queue_bulk(file, cmd, argp);
+	case VCHIQ_IOC_AWAIT_COMPLETION32:
+		return vchiq_compat_ioctl_await_completion(file, cmd, argp);
+	case VCHIQ_IOC_DEQUEUE_MESSAGE32:
+		return vchiq_compat_ioctl_dequeue_message(file, cmd, argp);
+	case VCHIQ_IOC_GET_CONFIG32:
+		return vchiq_compat_ioctl_get_config(file, cmd, argp);
+	default:
+		return vchiq_ioctl(file, cmd, (unsigned long)argp);
+	}
+}
+
+/* compat IOCTL end */
+#endif
+
+static const struct file_operations
+vchiq_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = vchiq_ioctl,
+#if defined(CONFIG_COMPAT)
+	.compat_ioctl = vchiq_compat_ioctl,
+#endif
+	.open = vchiq_open,
+	.release = vchiq_release,
+	.read = vchiq_read
+};
+
+/**
+ *	vchiq_register_chrdev - Register the char driver for vchiq
+ *				and create the necessary class and
+ *				device files in userspace.
+ *	@parent		The parent of the char device.
+ *
+ *	Returns 0 on success else returns the error code.
+ */
+int vchiq_register_chrdev(struct device *parent)
+{
+	struct device *vchiq_dev;
+	int ret;
+
+	vchiq_class = class_create(THIS_MODULE, DEVICE_NAME);
+	if (IS_ERR(vchiq_class)) {
+		pr_err("Failed to create vchiq class\n");
+		ret = PTR_ERR(vchiq_class);
+		goto error_exit;
+	}
+
+	ret = alloc_chrdev_region(&vchiq_devid, 0, 1, DEVICE_NAME);
+	if (ret) {
+		pr_err("vchiq: Failed to allocate vchiq's chrdev region\n");
+		goto alloc_region_error;
+	}
+
+	cdev_init(&vchiq_cdev, &vchiq_fops);
+	vchiq_cdev.owner = THIS_MODULE;
+	ret = cdev_add(&vchiq_cdev, vchiq_devid, 1);
+	if (ret) {
+		vchiq_log_error(vchiq_arm_log_level,
+			"Unable to register vchiq char device");
+		goto cdev_add_error;
+	}
+
+	vchiq_dev = device_create(vchiq_class, parent, vchiq_devid, NULL,
+				DEVICE_NAME);
+	if (IS_ERR(vchiq_dev)) {
+		vchiq_log_error(vchiq_arm_log_level,
+			"Failed to create vchiq char device node");
+		ret = PTR_ERR(vchiq_dev);
+		goto device_create_error;
+	}
+
+	vchiq_log_info(vchiq_arm_log_level,
+		"vchiq char dev initialised successfully - device %d.%d",
+			MAJOR(vchiq_devid), MINOR(vchiq_devid));
+
+	return 0;
+
+device_create_error:
+	cdev_del(&vchiq_cdev);
+
+cdev_add_error:
+	unregister_chrdev_region(vchiq_devid, 1);
+
+alloc_region_error:
+	class_destroy(vchiq_class);
+
+error_exit:
+	return ret;
+}
+
+/**
+ *	vchiq_deregister_chrdev	- Deregister and cleanup the vchiq char
+ *				  driver and device files
+ */
+void vchiq_deregister_chrdev(void)
+{
+	device_destroy(vchiq_class, vchiq_devid);
+	cdev_del(&vchiq_cdev);
+	unregister_chrdev_region(vchiq_devid, 1);
+	class_destroy(vchiq_class);
+}
-- 
2.25.1

