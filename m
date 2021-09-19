Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CBA410D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 00:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhISWHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 18:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhISWHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 18:07:52 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E334AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:26 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t4so36200413qkb.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXkmP1OzNV7PT3AxAD5FlqL42D9tRcrdPIr2arQBUbk=;
        b=ki/Ta0J1UvIBpKG254LdfM7MDCeYWZolwuRGnleeUlVrwcpOT00ozev986hSGmpdcn
         JggPJvRJAg8erzoMKkbtbdCwSG/DkGZJG9vjUU6mWcxu07/VhtERRF4jvCXSCTksbE9Q
         t4+3pmbNS/esoA2UrvO83Sg60F0RxKSUa1zgSRn0giwiKfIXrmysjxeNTr/4ZDvRmXZO
         /XfF7S6ca73A2IC+cv6d8957vftH035eHMWWK2tW+UziH6cNOxp4UNwUKpFqR/ARgoYK
         KucqSb3olbZLKAfja8DeQRpW2uCp1BBwb0j2VNDK2PBU0IwDUtUGKdztCPBQwcmeYGcd
         uq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXkmP1OzNV7PT3AxAD5FlqL42D9tRcrdPIr2arQBUbk=;
        b=Rns9CyR4wFPGC/3TvBR+u88FkOJ5LOZv5ZSx+3djG//AlwPg6CrDZXnYWDI2ct8nIc
         kTfbaE2OIiKkXANLoACRPnk8aRu6cPFPa75yCM4GxUp2iIaZaazqv9rq30MgJi+45rqc
         p0TIj6Yhi/gLnuFaofM9FBk5mE6Kl7Vd9POaO9CGTgAY/4OqlQcYTCFaZ3IITPe1s508
         lKPfEsnS5cEYcAyuiVJEAzl1h6TJuJ6ycpvT/xXWVZ4nDD9YbpbvPTLf4J/Vy+etRDF4
         cwFc7UPrsLbJYnYyb5s7GwIayfUi21iRYhZqodOxWojzcY0TKSbmUaPadaof59cMmGWw
         j6hQ==
X-Gm-Message-State: AOAM533bWRQOhW8Q7rEz3XkQaTMVI9pGilMnHSCK/Dh9iWQaqZDKlehE
        rm50sEOReu3xXsEos/2IXKs=
X-Google-Smtp-Source: ABdhPJylW+dJGRQCR4IUxkvBe64UCjylJyebSsOsTvw3p+TDiifBJaeHDlsfcpOSWNMSDadGkireng==
X-Received: by 2002:a37:9eca:: with SMTP id h193mr8194042qke.127.1632089185655;
        Sun, 19 Sep 2021 15:06:25 -0700 (PDT)
Received: from localhost.localdomain ([191.84.236.195])
        by smtp.gmail.com with ESMTPSA id t23sm246313qkj.31.2021.09.19.15.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 15:06:24 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 1/7] staging: vchiq_arm: cleanup code alignment issues
Date:   Sun, 19 Sep 2021 18:59:08 -0300
Message-Id: <20210919215914.539805-2-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919215914.539805-1-gascoar@gmail.com>
References: <20210919215914.539805-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix code alignment issues.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 208 +++++++-----------
 1 file changed, 79 insertions(+), 129 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index b25369a13452..22de17f64ed2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -115,7 +115,7 @@ static DEFINE_SEMAPHORE(g_free_fragments_mutex);
 
 static enum vchiq_status
 vchiq_blocking_bulk_transfer(unsigned int handle, void *data,
-	unsigned int size, enum vchiq_bulk_dir dir);
+			     unsigned int size, enum vchiq_bulk_dir dir);
 
 static irqreturn_t
 vchiq_doorbell_irq(int irq, void *dev_id)
@@ -251,11 +251,8 @@ create_pagelist(char *buf, char __user *ubuf,
 		}
 		/* do not try and release vmalloc pages */
 	} else {
-		actual_pages = pin_user_pages_fast(
-					  (unsigned long)ubuf & PAGE_MASK,
-					  num_pages,
-					  type == PAGELIST_READ,
-					  pages);
+		actual_pages = pin_user_pages_fast((unsigned long)ubuf & PAGE_MASK, num_pages,
+						   type == PAGELIST_READ, pages);
 
 		if (actual_pages != num_pages) {
 			vchiq_log_info(vchiq_arm_log_level,
@@ -325,9 +322,9 @@ create_pagelist(char *buf, char __user *ubuf,
 
 	/* Partial cache lines (fragments) require special measures */
 	if ((type == PAGELIST_READ) &&
-		((pagelist->offset & (g_cache_line_size - 1)) ||
-		((pagelist->offset + pagelist->length) &
-		(g_cache_line_size - 1)))) {
+	    ((pagelist->offset & (g_cache_line_size - 1)) ||
+	    ((pagelist->offset + pagelist->length) &
+	    (g_cache_line_size - 1)))) {
 		char *fragments;
 
 		if (down_interruptible(&g_free_fragments_sema)) {
@@ -391,7 +388,7 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
 			kunmap(pages[0]);
 		}
 		if ((actual >= 0) && (head_bytes < actual) &&
-			(tail_bytes != 0)) {
+		    (tail_bytes != 0)) {
 			memcpy((char *)kmap(pages[num_pages - 1]) +
 				((pagelist->offset + actual) &
 				(PAGE_SIZE - 1) & ~(g_cache_line_size - 1)),
@@ -504,9 +501,8 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 	}
 
 	g_dev = dev;
-	vchiq_log_info(vchiq_arm_log_level,
-		"vchiq_init - done (slots %pK, phys %pad)",
-		vchiq_slot_zero, &slot_phys);
+	vchiq_log_info(vchiq_arm_log_level, "vchiq_init - done (slots %pK, phys %pad)",
+		       vchiq_slot_zero, &slot_phys);
 
 	vchiq_call_connected_callbacks();
 
@@ -593,8 +589,7 @@ int vchiq_dump_platform_state(void *dump_context)
 	char buf[80];
 	int len;
 
-	len = snprintf(buf, sizeof(buf),
-		"  Platform: 2835 (VC master)");
+	len = snprintf(buf, sizeof(buf), "  Platform: 2835 (VC master)");
 	return vchiq_dump(dump_context, buf, len + 1);
 }
 
@@ -617,20 +612,18 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
 		usleep_range(500, 600);
 	}
 	if (i == VCHIQ_INIT_RETRIES) {
-		vchiq_log_error(vchiq_core_log_level,
-			"%s: videocore not initialized\n", __func__);
+		vchiq_log_error(vchiq_core_log_level, "%s: videocore not initialized\n", __func__);
 		ret = -ENOTCONN;
 		goto failed;
 	} else if (i > 0) {
 		vchiq_log_warning(vchiq_core_log_level,
-			"%s: videocore initialized after %d retries\n",
-			__func__, i);
+				  "%s: videocore initialized after %d retries\n", __func__, i);
 	}
 
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
 	if (!instance) {
 		vchiq_log_error(vchiq_core_log_level,
-			"%s: error allocating vchiq instance\n", __func__);
+				"%s: error allocating vchiq instance\n", __func__);
 		ret = -ENOMEM;
 		goto failed;
 	}
@@ -645,8 +638,7 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
 	ret = 0;
 
 failed:
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, ret);
+	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, ret);
 
 	return ret;
 }
@@ -659,9 +651,8 @@ void free_bulk_waiter(struct vchiq_instance *instance)
 	list_for_each_entry_safe(waiter, next,
 				 &instance->bulk_waiter_list, list) {
 		list_del(&waiter->list);
-		vchiq_log_info(vchiq_arm_log_level,
-				"bulk_waiter - cleaned up %pK for pid %d",
-				waiter, waiter->pid);
+		vchiq_log_info(vchiq_arm_log_level, "bulk_waiter - cleaned up %pK for pid %d",
+			       waiter, waiter->pid);
 		kfree(waiter);
 	}
 }
@@ -679,8 +670,7 @@ enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance)
 
 	mutex_unlock(&state->mutex);
 
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
+	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
 
 	free_bulk_waiter(instance);
 	kfree(instance);
@@ -700,8 +690,7 @@ enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
 	struct vchiq_state *state = instance->state;
 
 	if (mutex_lock_killable(&state->mutex)) {
-		vchiq_log_trace(vchiq_core_log_level,
-			"%s: call to mutex_lock failed", __func__);
+		vchiq_log_trace(vchiq_core_log_level, "%s: call to mutex_lock failed", __func__);
 		status = VCHIQ_RETRY;
 		goto failed;
 	}
@@ -713,8 +702,7 @@ enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
 	mutex_unlock(&state->mutex);
 
 failed:
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
+	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
 
 	return status;
 }
@@ -736,12 +724,7 @@ vchiq_add_service(struct vchiq_instance *instance,
 		? VCHIQ_SRVSTATE_LISTENING
 		: VCHIQ_SRVSTATE_HIDDEN;
 
-	service = vchiq_add_service_internal(
-		state,
-		params,
-		srvstate,
-		instance,
-		NULL);
+	service = vchiq_add_service_internal(state, params, srvstate, instance, NULL);
 
 	if (service) {
 		*phandle = service->handle;
@@ -750,8 +733,7 @@ vchiq_add_service(struct vchiq_instance *instance,
 		status = VCHIQ_ERROR;
 	}
 
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
+	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
 
 	return status;
 }
@@ -770,11 +752,7 @@ vchiq_open_service(struct vchiq_instance *instance,
 	if (!vchiq_is_connected(instance))
 		goto failed;
 
-	service = vchiq_add_service_internal(state,
-		params,
-		VCHIQ_SRVSTATE_OPENING,
-		instance,
-		NULL);
+	service = vchiq_add_service_internal(state, params, VCHIQ_SRVSTATE_OPENING, instance, NULL);
 
 	if (service) {
 		*phandle = service->handle;
@@ -786,8 +764,7 @@ vchiq_open_service(struct vchiq_instance *instance,
 	}
 
 failed:
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
+	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
 
 	return status;
 }
@@ -809,8 +786,8 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
 						     VCHIQ_BULK_TRANSMIT);
 			break;
 		case VCHIQ_BULK_MODE_BLOCKING:
-			status = vchiq_blocking_bulk_transfer(handle,
-				(void *)data, size, VCHIQ_BULK_TRANSMIT);
+			status = vchiq_blocking_bulk_transfer(handle, (void *)data, size,
+							      VCHIQ_BULK_TRANSMIT);
 			break;
 		default:
 			return VCHIQ_ERROR;
@@ -846,8 +823,8 @@ enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
 						     mode, VCHIQ_BULK_RECEIVE);
 			break;
 		case VCHIQ_BULK_MODE_BLOCKING:
-			status = vchiq_blocking_bulk_transfer(handle,
-				(void *)data, size, VCHIQ_BULK_RECEIVE);
+			status = vchiq_blocking_bulk_transfer(handle, (void *)data, size,
+							      VCHIQ_BULK_RECEIVE);
 			break;
 		default:
 			return VCHIQ_ERROR;
@@ -902,8 +879,7 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 		if (bulk) {
 			/* This thread has an outstanding bulk transfer. */
 			/* FIXME: why compare a dma address to a pointer? */
-			if ((bulk->data != (dma_addr_t)(uintptr_t)data) ||
-				(bulk->size != size)) {
+			if ((bulk->data != (dma_addr_t)(uintptr_t)data) || (bulk->size != size)) {
 				/*
 				 * This is not a retry of the previous one.
 				 * Cancel the signal when the transfer completes.
@@ -916,8 +892,7 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 	} else {
 		waiter = kzalloc(sizeof(*waiter), GFP_KERNEL);
 		if (!waiter) {
-			vchiq_log_error(vchiq_core_log_level,
-				"%s - out of memory", __func__);
+			vchiq_log_error(vchiq_core_log_level, "%s - out of memory", __func__);
 			return VCHIQ_ERROR;
 		}
 	}
@@ -925,8 +900,7 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 	status = vchiq_bulk_transfer(handle, data, NULL, size,
 				     &waiter->bulk_waiter,
 				     VCHIQ_BULK_MODE_BLOCKING, dir);
-	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
-		!waiter->bulk_waiter.bulk) {
+	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
 		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
 
 		if (bulk) {
@@ -941,9 +915,8 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_add(&waiter->list, &instance->bulk_waiter_list);
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		vchiq_log_info(vchiq_arm_log_level,
-				"saved bulk_waiter %pK for pid %d",
-				waiter, current->pid);
+		vchiq_log_info(vchiq_arm_log_level, "saved bulk_waiter %pK for pid %d", waiter,
+			       current->pid);
 	}
 
 	return status;
@@ -963,17 +936,13 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	while ((insert - instance->completion_remove) >= MAX_COMPLETIONS) {
 		/* Out of space - wait for the client */
 		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-		vchiq_log_trace(vchiq_arm_log_level,
-			"%s - completion queue full", __func__);
+		vchiq_log_trace(vchiq_arm_log_level, "%s - completion queue full", __func__);
 		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
-		if (wait_for_completion_interruptible(
-					&instance->remove_event)) {
-			vchiq_log_info(vchiq_arm_log_level,
-				"service_callback interrupted");
+		if (wait_for_completion_interruptible(&instance->remove_event)) {
+			vchiq_log_info(vchiq_arm_log_level, "service_callback interrupted");
 			return VCHIQ_RETRY;
 		} else if (instance->closing) {
-			vchiq_log_info(vchiq_arm_log_level,
-				"service_callback closing");
+			vchiq_log_info(vchiq_arm_log_level, "service_callback closing");
 			return VCHIQ_SUCCESS;
 		}
 		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
@@ -1044,11 +1013,10 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 		return VCHIQ_SUCCESS;
 
 	vchiq_log_trace(vchiq_arm_log_level,
-		"%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
-		__func__, (unsigned long)user_service,
-		service->localport, user_service->userdata,
-		reason, (unsigned long)header,
-		(unsigned long)instance, (unsigned long)bulk_userdata);
+			"%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
+			__func__, (unsigned long)user_service, service->localport,
+			user_service->userdata, reason, (unsigned long)header,
+			(unsigned long)instance, (unsigned long)bulk_userdata);
 
 	if (header && user_service->is_vchi) {
 		spin_lock(&msg_queue_spinlock);
@@ -1057,8 +1025,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 			spin_unlock(&msg_queue_spinlock);
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			DEBUG_COUNT(MSG_QUEUE_FULL_COUNT);
-			vchiq_log_trace(vchiq_arm_log_level,
-				"service_callback - msg queue full");
+			vchiq_log_trace(vchiq_arm_log_level, "service_callback - msg queue full");
 			/*
 			 * If there is no MESSAGE_AVAILABLE in the completion
 			 * queue, add one
@@ -1068,10 +1035,10 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 				enum vchiq_status status;
 
 				vchiq_log_info(vchiq_arm_log_level,
-					"Inserting extra MESSAGE_AVAILABLE");
+					       "Inserting extra MESSAGE_AVAILABLE");
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-				status = add_completion(instance, reason,
-					NULL, user_service, bulk_userdata);
+				status = add_completion(instance, reason, NULL, user_service,
+							bulk_userdata);
 				if (status != VCHIQ_SUCCESS) {
 					DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 					return status;
@@ -1079,15 +1046,12 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 			}
 
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-			if (wait_for_completion_interruptible(
-						&user_service->remove_event)) {
-				vchiq_log_info(vchiq_arm_log_level,
-					"%s interrupted", __func__);
+			if (wait_for_completion_interruptible(&user_service->remove_event)) {
+				vchiq_log_info(vchiq_arm_log_level, "%s interrupted", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				return VCHIQ_RETRY;
 			} else if (instance->closing) {
-				vchiq_log_info(vchiq_arm_log_level,
-					"%s closing", __func__);
+				vchiq_log_info(vchiq_arm_log_level, "%s closing", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				return VCHIQ_ERROR;
 			}
@@ -1238,12 +1202,10 @@ int vchiq_dump_platform_service_state(void *dump_context,
 
 	len = scnprintf(buf, sizeof(buf), "  instance %pK", service->instance);
 
-	if ((service->base.callback == service_callback) &&
-		user_service->is_vchi) {
-		len += scnprintf(buf + len, sizeof(buf) - len,
-			", %d/%d messages",
-			user_service->msg_insert - user_service->msg_remove,
-			MSG_QUEUE_SIZE);
+	if ((service->base.callback == service_callback) && user_service->is_vchi) {
+		len += scnprintf(buf + len, sizeof(buf) - len, ", %d/%d messages",
+				 user_service->msg_insert - user_service->msg_remove,
+				 MSG_QUEUE_SIZE);
 
 		if (user_service->dequeue_pending)
 			len += scnprintf(buf + len, sizeof(buf) - len,
@@ -1276,8 +1238,7 @@ vchiq_keepalive_vchiq_callback(enum vchiq_reason reason,
 			       struct vchiq_header *header,
 			       unsigned int service_user, void *bulk_user)
 {
-	vchiq_log_error(vchiq_susp_log_level,
-		"%s callback reason %d", __func__, reason);
+	vchiq_log_error(vchiq_susp_log_level, "%s callback reason %d", __func__, reason);
 	return 0;
 }
 
@@ -1301,22 +1262,22 @@ vchiq_keepalive_thread_func(void *v)
 
 	ret = vchiq_initialise(&instance);
 	if (ret) {
-		vchiq_log_error(vchiq_susp_log_level,
-			"%s vchiq_initialise failed %d", __func__, ret);
+		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_initialise failed %d", __func__,
+				ret);
 		goto exit;
 	}
 
 	status = vchiq_connect(instance);
 	if (status != VCHIQ_SUCCESS) {
-		vchiq_log_error(vchiq_susp_log_level,
-			"%s vchiq_connect failed %d", __func__, status);
+		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_connect failed %d", __func__,
+				status);
 		goto shutdown;
 	}
 
 	status = vchiq_add_service(instance, &params, &ka_handle);
 	if (status != VCHIQ_SUCCESS) {
-		vchiq_log_error(vchiq_susp_log_level,
-			"%s vchiq_open_service failed %d", __func__, status);
+		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_open_service failed %d", __func__,
+				status);
 		goto shutdown;
 	}
 
@@ -1324,8 +1285,7 @@ vchiq_keepalive_thread_func(void *v)
 		long rc = 0, uc = 0;
 
 		if (wait_for_completion_interruptible(&arm_state->ka_evt)) {
-			vchiq_log_error(vchiq_susp_log_level,
-				"%s interrupted", __func__);
+			vchiq_log_error(vchiq_susp_log_level, "%s interrupted", __func__);
 			flush_signals(current);
 			continue;
 		}
@@ -1346,16 +1306,15 @@ vchiq_keepalive_thread_func(void *v)
 			status = vchiq_use_service(ka_handle);
 			if (status != VCHIQ_SUCCESS) {
 				vchiq_log_error(vchiq_susp_log_level,
-					"%s vchiq_use_service error %d",
-					__func__, status);
+						"%s vchiq_use_service error %d", __func__, status);
 			}
 		}
 		while (rc--) {
 			status = vchiq_release_service(ka_handle);
 			if (status != VCHIQ_SUCCESS) {
 				vchiq_log_error(vchiq_susp_log_level,
-					"%s vchiq_release_service error %d",
-					__func__, status);
+						"%s vchiq_release_service error %d", __func__,
+						status);
 			}
 		}
 	}
@@ -1417,9 +1376,8 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	local_uc = ++arm_state->videocore_use_count;
 	++(*entity_uc);
 
-	vchiq_log_trace(vchiq_susp_log_level,
-		"%s %s count %d, state count %d",
-		__func__, entity, *entity_uc, local_uc);
+	vchiq_log_trace(vchiq_susp_log_level, "%s %s count %d, state count %d", __func__, entity,
+			*entity_uc, local_uc);
 
 	write_unlock_bh(&arm_state->susp_res_lock);
 
@@ -1433,8 +1391,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 			if (status == VCHIQ_SUCCESS)
 				ack_cnt--;
 			else
-				atomic_add(ack_cnt,
-					&arm_state->ka_use_ack_count);
+				atomic_add(ack_cnt, &arm_state->ka_use_ack_count);
 		}
 	}
 
@@ -1477,10 +1434,8 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 	--arm_state->videocore_use_count;
 	--(*entity_uc);
 
-	vchiq_log_trace(vchiq_susp_log_level,
-		"%s %s count %d, state count %d",
-		__func__, entity, *entity_uc,
-		arm_state->videocore_use_count);
+	vchiq_log_trace(vchiq_susp_log_level, "%s %s count %d, state count %d", __func__, entity,
+			*entity_uc, arm_state->videocore_use_count);
 
 unlock:
 	write_unlock_bh(&arm_state->susp_res_lock);
@@ -1575,8 +1530,7 @@ vchiq_use_service(unsigned int handle)
 	struct vchiq_service *service = find_service_by_handle(handle);
 
 	if (service) {
-		ret = vchiq_use_internal(service->state, service,
-				USE_TYPE_SERVICE);
+		ret = vchiq_use_internal(service->state, service, USE_TYPE_SERVICE);
 		vchiq_service_put(service);
 	}
 	return ret;
@@ -1666,17 +1620,14 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 			"with non-zero use-count", active_services, found);
 
 	for (i = 0; i < found; i++) {
-		vchiq_log_warning(vchiq_susp_log_level,
-			"----- %c%c%c%c:%d service count %d %s",
-			VCHIQ_FOURCC_AS_4CHARS(service_data[i].fourcc),
-			service_data[i].clientid,
-			service_data[i].use_count,
-			service_data[i].use_count ? nz : "");
+		vchiq_log_warning(vchiq_susp_log_level, "----- %c%c%c%c:%d service count %d %s",
+				  VCHIQ_FOURCC_AS_4CHARS(service_data[i].fourcc),
+				  service_data[i].clientid, service_data[i].use_count,
+				  service_data[i].use_count ? nz : "");
 	}
-	vchiq_log_warning(vchiq_susp_log_level,
-		"----- VCHIQ use count count %d", peer_count);
-	vchiq_log_warning(vchiq_susp_log_level,
-		"--- Overall vchiq instance use count %d", vc_use_count);
+	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count count %d", peer_count);
+	vchiq_log_warning(vchiq_susp_log_level, "--- Overall vchiq instance use count %d",
+			  vc_use_count);
 
 	kfree(service_data);
 }
@@ -1699,10 +1650,9 @@ vchiq_check_service(struct vchiq_service *service)
 
 	if (ret == VCHIQ_ERROR) {
 		vchiq_log_error(vchiq_susp_log_level,
-			"%s ERROR - %c%c%c%c:%d service count %d, state count %d", __func__,
-			VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
-			service->client_id, service->service_use_count,
-			arm_state->videocore_use_count);
+				"%s ERROR - %c%c%c%c:%d service count %d, state count %d", __func__,
+				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc), service->client_id,
+				service->service_use_count, arm_state->videocore_use_count);
 		vchiq_dump_service_use_state(service->state);
 	}
 out:
@@ -1717,7 +1667,7 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 	char threadname[16];
 
 	vchiq_log_info(vchiq_susp_log_level, "%d: %s->%s", state->id,
-		get_conn_state_name(oldstate), get_conn_state_name(newstate));
+		       get_conn_state_name(oldstate), get_conn_state_name(newstate));
 	if (state->conn_state != VCHIQ_CONNSTATE_CONNECTED)
 		return;
 
-- 
2.33.0

