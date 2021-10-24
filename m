Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29809438C1B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhJXV2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhJXV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:28:09 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B1C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:48 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id ba39so4180621vkb.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvdeL2mylV00dnj30N+QXKuYxoelUln6BpZfLAEVDTE=;
        b=RfASH8siOB0ZDt/6Z4A9zIPk3iTADoQ4ZRuW/tOKMrZEcxMvbHJnyFI+kakqM0WZNM
         gX9vRmgJJL9mso1AGEagIrykfxixCIk2eHx1+7c4zGUyAThVF7P+GYltK15bNjJgjTbM
         FNBCOqwZHP5rMbQSpVdKEkbD/nGhjhx/zz9re/LhT2rv1A12y9ohfCVFg10Qh/cs+IW6
         hTF+6gkXVncw+EWUj73YaA0ic8F5AORQeXwvh9QAyByeY9rYk63ErVJTXIS4e1K8ySAw
         myTYUX7CM4C1v8VUGUDdhLVC+npNgQ3JRPjnN2lTj8gq9w3I+mEahSWD4X+7BsKGqS+A
         iCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvdeL2mylV00dnj30N+QXKuYxoelUln6BpZfLAEVDTE=;
        b=KKmOT9K3Zcu+2GaYRIs51sN37SCqpy6t5YcBqipYLf8Cstj5gXyei/bvxcqFAOMddz
         XgtZrQnNSCgJMuaXmqp+K7y1ZCTVzkwqIXhY+tf837JXGrym7T0Cx8bizmuCFnwJ0dh6
         f/F49RFmHPQuWBEJWW7reyqySCFYkgEIcURL4kaAnkAjP+ldo8/fdgknSdrn2wgXME5b
         lwGwN7do9+yRYrlvj93F6Jzo9L8dw3sUFEBr3RwWburJXNZ7Sx4Y2GgdHE4zIw3S9+LT
         gKWb7uLVUsH/78lOSbONpkGQAh2d1PABbTLnC6CR/L+JXn/if8xibbXc8K8NYzLiiTJ4
         WNeg==
X-Gm-Message-State: AOAM530Vzctzp2IvLnzkVzO54uUg70odIhk+yztmlStID/IVxouzFVAP
        tKS9XX87Rpspd5zIxNa4Ljs=
X-Google-Smtp-Source: ABdhPJw8NuvuvsuIZV1hIptayJCOvlI2Db+U+Pr4w5D3PPgppqONVcnC2AiUJOGE4aAswkZoo+iPDg==
X-Received: by 2002:a05:6122:c89:: with SMTP id ba9mr11880354vkb.25.1635110746902;
        Sun, 24 Oct 2021 14:25:46 -0700 (PDT)
Received: from localhost.localdomain ([191.83.215.63])
        by smtp.gmail.com with ESMTPSA id 45sm8847869uaq.8.2021.10.24.14.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 14:25:46 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 2/8] staging: vchiq_core: cleanup code alignment issues
Date:   Sun, 24 Oct 2021 18:25:18 -0300
Message-Id: <20211024212524.370078-3-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211024212524.370078-1-gascoar@gmail.com>
References: <20211024212524.370078-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix code alignment issues reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 715 +++++++-----------
 .../interface/vchiq_arm/vchiq_core.h          |  12 +-
 2 files changed, 286 insertions(+), 441 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index a205f769d5d3..d64d6a0427eb 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -228,9 +228,9 @@ static inline void
 vchiq_set_service_state(struct vchiq_service *service, int newstate)
 {
 	vchiq_log_info(vchiq_core_log_level, "%d: srv:%d %s->%s",
-		service->state->id, service->localport,
-		srvstate_names[service->srvstate],
-		srvstate_names[newstate]);
+		       service->state->id, service->localport,
+		       srvstate_names[service->srvstate],
+		       srvstate_names[newstate]);
 	service->srvstate = newstate;
 }
 
@@ -276,8 +276,7 @@ find_service_by_port(struct vchiq_state *state, int localport)
 }
 
 struct vchiq_service *
-find_service_for_instance(struct vchiq_instance *instance,
-	unsigned int handle)
+find_service_for_instance(struct vchiq_instance *instance, unsigned int handle)
 {
 	struct vchiq_service *service;
 
@@ -298,8 +297,7 @@ find_service_for_instance(struct vchiq_instance *instance,
 }
 
 struct vchiq_service *
-find_closed_service_for_instance(struct vchiq_instance *instance,
-	unsigned int handle)
+find_closed_service_for_instance(struct vchiq_instance *instance, unsigned int handle)
 {
 	struct vchiq_service *service;
 
@@ -466,14 +464,13 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 	enum vchiq_status status;
 
 	vchiq_log_trace(vchiq_core_log_level, "%d: callback:%d (%s, %pK, %pK)",
-		service->state->id, service->localport, reason_names[reason],
-		header, bulk_userdata);
-	status = service->base.callback(reason, header, service->handle,
-		bulk_userdata);
+			service->state->id, service->localport, reason_names[reason],
+			header, bulk_userdata);
+	status = service->base.callback(reason, header, service->handle, bulk_userdata);
 	if (status == VCHIQ_ERROR) {
 		vchiq_log_warning(vchiq_core_log_level,
-			"%d: ignoring ERROR from callback to service %x",
-			service->state->id, service->handle);
+				  "%d: ignoring ERROR from callback to service %x",
+				  service->state->id, service->handle);
 		status = VCHIQ_SUCCESS;
 	}
 
@@ -488,9 +485,8 @@ vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate)
 {
 	enum vchiq_connstate oldstate = state->conn_state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: %s->%s", state->id,
-		conn_state_names[oldstate],
-		conn_state_names[newstate]);
+	vchiq_log_info(vchiq_core_log_level, "%d: %s->%s", state->id, conn_state_names[oldstate],
+		       conn_state_names[newstate]);
 	state->conn_state = newstate;
 	vchiq_platform_conn_state_changed(state, oldstate, newstate);
 }
@@ -693,8 +689,7 @@ reserve_space(struct vchiq_state *state, size_t space, int is_blocking)
 			remote_event_signal(&state->remote->trigger);
 
 			if (!is_blocking ||
-				(wait_for_completion_interruptible(
-				&state->slot_available_event)))
+			    (wait_for_completion_interruptible(&state->slot_available_event)))
 				return NULL; /* No space available */
 		}
 
@@ -739,11 +734,9 @@ process_free_data_message(struct vchiq_state *state, BITSET_T *service_found,
 		complete(&quota->quota_event);
 	} else if (count == 0) {
 		vchiq_log_error(vchiq_core_log_level,
-			"service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
-			port,
-			quota->message_use_count,
-			header, msgid, header->msgid,
-			header->size);
+				"service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
+				port, quota->message_use_count, header, msgid, header->msgid,
+				header->size);
 		WARN(1, "invalid message use count\n");
 	}
 	if (!BITSET_IS_SET(service_found, port)) {
@@ -762,17 +755,12 @@ process_free_data_message(struct vchiq_state *state, BITSET_T *service_found,
 			 * it has dropped below its quota
 			 */
 			complete(&quota->quota_event);
-			vchiq_log_trace(vchiq_core_log_level,
-				"%d: pfq:%d %x@%pK - slot_use->%d",
-				state->id, port,
-				header->size, header,
-				count - 1);
+			vchiq_log_trace(vchiq_core_log_level, "%d: pfq:%d %x@%pK - slot_use->%d",
+					state->id, port, header->size, header, count - 1);
 		} else {
 			vchiq_log_error(vchiq_core_log_level,
 					"service %d slot_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
-				port, count, header,
-				msgid, header->msgid,
-				header->size);
+					port, count, header, msgid, header->msgid, header->size);
 			WARN(1, "bad slot use count\n");
 		}
 	}
@@ -814,8 +802,8 @@ process_free_queue(struct vchiq_state *state, BITSET_T *service_found,
 		rmb();
 
 		vchiq_log_trace(vchiq_core_log_level, "%d: pfq %d=%pK %x %x",
-			state->id, slot_index, data,
-			local->slot_queue_recycle, slot_queue_available);
+				state->id, slot_index, data, local->slot_queue_recycle,
+				slot_queue_available);
 
 		/* Initialise the bitmask for services which have used this slot */
 		memset(service_found, 0, length);
@@ -836,9 +824,8 @@ process_free_queue(struct vchiq_state *state, BITSET_T *service_found,
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
 				vchiq_log_error(vchiq_core_log_level,
-					"pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
-					pos, header, msgid, header->msgid,
-					header->size);
+						"pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
+						pos, header, msgid, header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
 		}
@@ -967,7 +954,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		 * slots
 		 */
 		while ((tx_end_index != state->previous_data_index) &&
-			(state->data_use_count == state->data_quota)) {
+		       (state->data_use_count == state->data_quota)) {
 			VCHIQ_STATS_INC(state, data_stalls);
 			spin_unlock(&quota_spinlock);
 			mutex_unlock(&state->slot_mutex);
@@ -981,7 +968,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			tx_end_index = SLOT_QUEUE_INDEX_FROM_POS(
 				state->local_tx_pos + stride - 1);
 			if ((tx_end_index == state->previous_data_index) ||
-				(state->data_use_count < state->data_quota)) {
+			    (state->data_use_count < state->data_quota)) {
 				/* Pass the signal on to other waiters */
 				complete(&state->data_quota_event);
 				break;
@@ -989,15 +976,13 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		}
 
 		while ((quota->message_use_count == quota->message_quota) ||
-			((tx_end_index != quota->previous_tx_index) &&
+		       ((tx_end_index != quota->previous_tx_index) &&
 			(quota->slot_use_count == quota->slot_quota))) {
 			spin_unlock(&quota_spinlock);
 			vchiq_log_trace(vchiq_core_log_level,
-				"%d: qm:%d %s,%zx - quota stall (msg %d, slot %d)",
-				state->id, service->localport,
-				msg_type_str(type), size,
-				quota->message_use_count,
-				quota->slot_use_count);
+					"%d: qm:%d %s,%zx - quota stall (msg %d, slot %d)",
+					state->id, service->localport, msg_type_str(type), size,
+					quota->message_use_count, quota->slot_use_count);
 			VCHIQ_SERVICE_STATS_INC(service, quota_stalls);
 			mutex_unlock(&state->slot_mutex);
 			if (wait_for_completion_interruptible(
@@ -1039,11 +1024,9 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		int tx_end_index;
 		int slot_use_count;
 
-		vchiq_log_info(vchiq_core_log_level,
-			"%d: qm %s@%pK,%zx (%d->%d)",
-			state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-			header, size, VCHIQ_MSG_SRCPORT(msgid),
-			VCHIQ_MSG_DSTPORT(msgid));
+		vchiq_log_info(vchiq_core_log_level, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
+			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
+			       VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 
 		WARN_ON(flags & (QMFLAGS_NO_MUTEX_LOCK |
 				 QMFLAGS_NO_MUTEX_UNLOCK));
@@ -1096,19 +1079,16 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 
 		if (slot_use_count)
 			vchiq_log_trace(vchiq_core_log_level,
-				"%d: qm:%d %s,%zx - slot_use->%d (hdr %p)",
-				state->id, service->localport,
-				msg_type_str(VCHIQ_MSG_TYPE(msgid)), size,
-				slot_use_count, header);
+					"%d: qm:%d %s,%zx - slot_use->%d (hdr %p)", state->id,
+					service->localport, msg_type_str(VCHIQ_MSG_TYPE(msgid)),
+					size, slot_use_count, header);
 
 		VCHIQ_SERVICE_STATS_INC(service, ctrl_tx_count);
 		VCHIQ_SERVICE_STATS_ADD(service, ctrl_tx_bytes, size);
 	} else {
-		vchiq_log_info(vchiq_core_log_level,
-			"%d: qm %s@%pK,%zx (%d->%d)", state->id,
-			msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-			header, size, VCHIQ_MSG_SRCPORT(msgid),
-			VCHIQ_MSG_DSTPORT(msgid));
+		vchiq_log_info(vchiq_core_log_level, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
+			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
+			       VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 		if (size != 0) {
 			/*
 			 * It is assumed for now that this code path
@@ -1137,13 +1117,10 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
 		vchiq_log_info(SRVTRACE_LEVEL(service),
-			"Sent Msg %s(%u) to %c%c%c%c s:%u d:%d len:%zu",
-			msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-			VCHIQ_MSG_TYPE(msgid),
-			VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
-			VCHIQ_MSG_SRCPORT(msgid),
-			VCHIQ_MSG_DSTPORT(msgid),
-			size);
+			       "Sent Msg %s(%u) to %c%c%c%c s:%u d:%d len:%zu",
+			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
+			       VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
+			       VCHIQ_MSG_DSTPORT(msgid), size);
 	}
 
 	/* Make sure the new header is visible to the peer. */
@@ -1193,9 +1170,8 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 		int oldmsgid = header->msgid;
 
 		if (oldmsgid != VCHIQ_MSGID_PADDING)
-			vchiq_log_error(vchiq_core_log_level,
-				"%d: qms - msgid %x, not PADDING",
-				state->id, oldmsgid);
+			vchiq_log_error(vchiq_core_log_level, "%d: qms - msgid %x, not PADDING",
+					state->id, oldmsgid);
 	}
 
 	vchiq_log_info(vchiq_sync_log_level,
@@ -1240,13 +1216,10 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
 		vchiq_log_trace(vchiq_sync_log_level,
-			"Sent Sync Msg %s(%u) to %c%c%c%c s:%u d:%d len:%d",
-			msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-			VCHIQ_MSG_TYPE(msgid),
-			VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
-			VCHIQ_MSG_SRCPORT(msgid),
-			VCHIQ_MSG_DSTPORT(msgid),
-			size);
+				"Sent Sync Msg %s(%u) to %c%c%c%c s:%u d:%d len:%d",
+				msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
+				VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
+				VCHIQ_MSG_DSTPORT(msgid), size);
 	}
 
 	remote_event_signal(&state->remote->sync_trigger);
@@ -1272,8 +1245,7 @@ release_slot(struct vchiq_state *state, struct vchiq_slot_info *slot_info,
 	if (header) {
 		int msgid = header->msgid;
 
-		if (((msgid & VCHIQ_MSGID_CLAIMED) == 0) ||
-			(service && service->closing)) {
+		if (((msgid & VCHIQ_MSGID_CLAIMED) == 0) || (service && service->closing)) {
 			mutex_unlock(&state->recycle_mutex);
 			return;
 		}
@@ -1300,10 +1272,9 @@ release_slot(struct vchiq_state *state, struct vchiq_slot_info *slot_info,
 			VCHIQ_SLOT_QUEUE_MASK] =
 			SLOT_INDEX_FROM_INFO(state, slot_info);
 		state->remote->slot_queue_recycle = slot_queue_recycle + 1;
-		vchiq_log_info(vchiq_core_log_level,
-			"%d: %s %d - recycle->%x", state->id, __func__,
-			SLOT_INDEX_FROM_INFO(state, slot_info),
-			state->remote->slot_queue_recycle);
+		vchiq_log_info(vchiq_core_log_level, "%d: %s %d - recycle->%x", state->id, __func__,
+			       SLOT_INDEX_FROM_INFO(state, slot_info),
+			       state->remote->slot_queue_recycle);
 
 		/*
 		 * A write barrier is necessary, but remote_event_signal
@@ -1338,11 +1309,9 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 {
 	enum vchiq_status status = VCHIQ_SUCCESS;
 
-	vchiq_log_trace(vchiq_core_log_level,
-		"%d: nb:%d %cx - p=%x rn=%x r=%x",
-		service->state->id, service->localport,
-		(queue == &service->bulk_tx) ? 't' : 'r',
-		queue->process, queue->remote_notify, queue->remove);
+	vchiq_log_trace(vchiq_core_log_level, "%d: nb:%d %cx - p=%x rn=%x r=%x", service->state->id,
+			service->localport, (queue == &service->bulk_tx) ? 't' : 'r',
+			queue->process, queue->remote_notify, queue->remove);
 
 	queue->remote_notify = queue->process;
 
@@ -1357,21 +1326,16 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 		if (bulk->data && service->instance) {
 			if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED) {
 				if (bulk->dir == VCHIQ_BULK_TRANSMIT) {
-					VCHIQ_SERVICE_STATS_INC(service,
-						bulk_tx_count);
-					VCHIQ_SERVICE_STATS_ADD(service,
-						bulk_tx_bytes,
-						bulk->actual);
+					VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
+					VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
+								bulk->actual);
 				} else {
-					VCHIQ_SERVICE_STATS_INC(service,
-						bulk_rx_count);
-					VCHIQ_SERVICE_STATS_ADD(service,
-						bulk_rx_bytes,
-						bulk->actual);
+					VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
+					VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
+								bulk->actual);
 				}
 			} else {
-				VCHIQ_SERVICE_STATS_INC(service,
-					bulk_aborted_count);
+				VCHIQ_SERVICE_STATS_INC(service, bulk_aborted_count);
 			}
 			if (bulk->mode == VCHIQ_BULK_MODE_BLOCKING) {
 				struct bulk_waiter *waiter;
@@ -1386,8 +1350,8 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 			} else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
 				enum vchiq_reason reason =
 						get_bulk_reason(bulk);
-				status = make_service_callback(service,
-					reason,	NULL, bulk->userdata);
+				status = make_service_callback(service, reason,	NULL,
+							       bulk->userdata);
 				if (status == VCHIQ_RETRY)
 					break;
 			}
@@ -1400,9 +1364,8 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 		status = VCHIQ_SUCCESS;
 
 	if (status == VCHIQ_RETRY)
-		request_poll(service->state, service,
-			(queue == &service->bulk_tx) ?
-			VCHIQ_POLL_TXNOTIFY : VCHIQ_POLL_RXNOTIFY);
+		request_poll(service->state, service, (queue == &service->bulk_tx) ?
+			     VCHIQ_POLL_TXNOTIFY : VCHIQ_POLL_RXNOTIFY);
 
 	return status;
 }
@@ -1443,15 +1406,10 @@ poll_services_of_group(struct vchiq_state *state, int group)
 							 VCHIQ_SUCCESS)
 				request_poll(state, service, VCHIQ_POLL_REMOVE);
 		} else if (service_flags & BIT(VCHIQ_POLL_TERMINATE)) {
-			vchiq_log_info(vchiq_core_log_level,
-				"%d: ps - terminate %d<->%d",
-				state->id, service->localport,
-				service->remoteport);
-			if (vchiq_close_service_internal(
-				service, NO_CLOSE_RECVD) !=
-				VCHIQ_SUCCESS)
-				request_poll(state, service,
-					     VCHIQ_POLL_TERMINATE);
+			vchiq_log_info(vchiq_core_log_level, "%d: ps - terminate %d<->%d",
+				       state->id, service->localport, service->remoteport);
+			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD) != VCHIQ_SUCCESS)
+				request_poll(state, service, VCHIQ_POLL_TERMINATE);
 		}
 		if (service_flags & BIT(VCHIQ_POLL_TXNOTIFY))
 			notify_bulks(service, &service->bulk_tx, RETRY_POLL);
@@ -1478,18 +1436,16 @@ abort_outstanding_bulks(struct vchiq_service *service,
 {
 	int is_tx = (queue == &service->bulk_tx);
 
-	vchiq_log_trace(vchiq_core_log_level,
-		"%d: aob:%d %cx - li=%x ri=%x p=%x",
-		service->state->id, service->localport, is_tx ? 't' : 'r',
-		queue->local_insert, queue->remote_insert, queue->process);
+	vchiq_log_trace(vchiq_core_log_level, "%d: aob:%d %cx - li=%x ri=%x p=%x",
+			service->state->id, service->localport, is_tx ? 't' : 'r',
+			queue->local_insert, queue->remote_insert, queue->process);
 
 	WARN_ON((int)(queue->local_insert - queue->process) < 0);
 	WARN_ON((int)(queue->remote_insert - queue->process) < 0);
 
 	while ((queue->process != queue->local_insert) ||
-		(queue->process != queue->remote_insert)) {
-		struct vchiq_bulk *bulk =
-				&queue->bulks[BULK_INDEX(queue->process)];
+	       (queue->process != queue->remote_insert)) {
+		struct vchiq_bulk *bulk = &queue->bulks[BULK_INDEX(queue->process)];
 
 		if (queue->process == queue->remote_insert) {
 			/* fabricate a matching dummy bulk */
@@ -1502,12 +1458,10 @@ abort_outstanding_bulks(struct vchiq_service *service,
 			vchiq_complete_bulk(bulk);
 
 			vchiq_log_info(SRVTRACE_LEVEL(service),
-				"%s %c%c%c%c d:%d ABORTED - tx len:%d, rx len:%d",
-				is_tx ? "Send Bulk to" : "Recv Bulk from",
-				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
-				service->remoteport,
-				bulk->size,
-				bulk->remote_size);
+				       "%s %c%c%c%c d:%d ABORTED - tx len:%d, rx len:%d",
+				       is_tx ? "Send Bulk to" : "Recv Bulk from",
+				       VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
+				       service->remoteport, bulk->size, bulk->remote_size);
 		} else {
 			/* fabricate a matching dummy bulk */
 			bulk->data = 0;
@@ -1540,10 +1494,8 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 
 	payload = (struct vchiq_open_payload *)header->data;
 	fourcc = payload->fourcc;
-	vchiq_log_info(vchiq_core_log_level,
-		"%d: prs OPEN@%pK (%d->'%c%c%c%c')",
-		state->id, header, localport,
-		VCHIQ_FOURCC_AS_4CHARS(fourcc));
+	vchiq_log_info(vchiq_core_log_level, "%d: prs OPEN@%pK (%d->'%c%c%c%c')",
+		       state->id, header, localport, VCHIQ_FOURCC_AS_4CHARS(fourcc));
 
 	service = get_listening_service(state, fourcc);
 	if (!service)
@@ -1553,8 +1505,7 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 	version = payload->version;
 	version_min = payload->version_min;
 
-	if ((service->version < version_min) ||
-		(version < service->version_min)) {
+	if ((service->version < version_min) || (version < service->version_min)) {
 		/* Version mismatch */
 		vchiq_loud_error_header();
 		vchiq_loud_error("%d: service %d (%c%c%c%c) "
@@ -1583,25 +1534,18 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 
 		/* Acknowledge the OPEN */
 		if (service->sync) {
-			if (queue_message_sync(state, NULL, openack_id,
-				memcpy_copy_callback,
-				&ack_payload,
-				sizeof(ack_payload),
-				0) == VCHIQ_RETRY)
+			if (queue_message_sync(state, NULL, openack_id, memcpy_copy_callback,
+					       &ack_payload, sizeof(ack_payload), 0) == VCHIQ_RETRY)
 				goto bail_not_ready;
 		} else {
-			if (queue_message(state, NULL, openack_id,
-				memcpy_copy_callback,
-				&ack_payload,
-				sizeof(ack_payload),
-				0) == VCHIQ_RETRY)
+			if (queue_message(state, NULL, openack_id, memcpy_copy_callback,
+					  &ack_payload, sizeof(ack_payload), 0) == VCHIQ_RETRY)
 				goto bail_not_ready;
 		}
 
 		/* The service is now open */
-		vchiq_set_service_state(service,
-			service->sync ? VCHIQ_SRVSTATE_OPENSYNC
-			: VCHIQ_SRVSTATE_OPEN);
+		vchiq_set_service_state(service, service->sync ? VCHIQ_SRVSTATE_OPENSYNC
+					: VCHIQ_SRVSTATE_OPEN);
 	}
 
 	/* Success - the message has been dealt with */
@@ -1611,7 +1555,7 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 fail_open:
 	/* No available service, or an invalid request - send a CLOSE */
 	if (queue_message(state, NULL, MAKE_CLOSE(0, VCHIQ_MSG_SRCPORT(msgid)),
-		NULL, NULL, 0, 0) == VCHIQ_RETRY)
+			  NULL, NULL, 0, 0) == VCHIQ_RETRY)
 		goto bail_not_ready;
 
 	return 1;
@@ -1675,22 +1619,19 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			 */
 			if (service)
 				vchiq_service_put(service);
-			service = get_connected_service(state,
-				remoteport);
+			service = get_connected_service(state, remoteport);
 			if (service)
 				vchiq_log_warning(vchiq_core_log_level,
-					"%d: prs %s@%pK (%d->%d) - found connected service %d",
-					state->id, msg_type_str(type),
-					header, remoteport, localport,
-					service->localport);
+						  "%d: prs %s@%pK (%d->%d) - found connected service %d",
+						  state->id, msg_type_str(type), header,
+						  remoteport, localport, service->localport);
 		}
 
 		if (!service) {
 			vchiq_log_error(vchiq_core_log_level,
-				"%d: prs %s@%pK (%d->%d) - invalid/closed service %d",
-				state->id, msg_type_str(type),
-				header, remoteport, localport,
-				localport);
+					"%d: prs %s@%pK (%d->%d) - invalid/closed service %d",
+					state->id, msg_type_str(type), header, remoteport,
+					localport, localport);
 			goto skip_message;
 		}
 		break;
@@ -1705,21 +1646,18 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			? service->base.fourcc
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 		vchiq_log_info(SRVTRACE_LEVEL(service),
-			"Rcvd Msg %s(%u) from %c%c%c%c s:%d d:%d len:%d",
-			msg_type_str(type), type,
-			VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
-			remoteport, localport, size);
+			       "Rcvd Msg %s(%u) from %c%c%c%c s:%d d:%d len:%d",
+			       msg_type_str(type), type, VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
+			       remoteport, localport, size);
 		if (size > 0)
-			vchiq_log_dump_mem("Rcvd", 0, header->data,
-				min(16, size));
+			vchiq_log_dump_mem("Rcvd", 0, header->data, min(16, size));
 	}
 
 	if (((unsigned long)header & VCHIQ_SLOT_MASK) +
 	    calc_stride(size) > VCHIQ_SLOT_SIZE) {
 		vchiq_log_error(vchiq_core_log_level,
-			"header %pK (msgid %x) - size %x too big for slot",
-			header, (unsigned int)msgid,
-			(unsigned int)size);
+				"header %pK (msgid %x) - size %x too big for slot",
+				header, (unsigned int)msgid, (unsigned int)size);
 		WARN(1, "oversized for slot\n");
 	}
 
@@ -1736,66 +1674,55 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 				header->data;
 			service->peer_version = payload->version;
 		}
-		vchiq_log_info(vchiq_core_log_level,
-			"%d: prs OPENACK@%pK,%x (%d->%d) v:%d",
-			state->id, header, size, remoteport, localport,
-			service->peer_version);
+		vchiq_log_info(vchiq_core_log_level, "%d: prs OPENACK@%pK,%x (%d->%d) v:%d",
+			       state->id, header, size, remoteport, localport,
+			       service->peer_version);
 		if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
 			service->remoteport = remoteport;
-			vchiq_set_service_state(service,
-				VCHIQ_SRVSTATE_OPEN);
+			vchiq_set_service_state(service, VCHIQ_SRVSTATE_OPEN);
 			complete(&service->remove_event);
 		} else {
-			vchiq_log_error(vchiq_core_log_level,
-				"OPENACK received in state %s",
-				srvstate_names[service->srvstate]);
+			vchiq_log_error(vchiq_core_log_level, "OPENACK received in state %s",
+					srvstate_names[service->srvstate]);
 		}
 		break;
 	case VCHIQ_MSG_CLOSE:
 		WARN_ON(size); /* There should be no data */
 
-		vchiq_log_info(vchiq_core_log_level,
-			"%d: prs CLOSE@%pK (%d->%d)",
-			state->id, header, remoteport, localport);
+		vchiq_log_info(vchiq_core_log_level, "%d: prs CLOSE@%pK (%d->%d)",
+			       state->id, header, remoteport, localport);
 
 		mark_service_closing_internal(service, 1);
 
-		if (vchiq_close_service_internal(service,
-			CLOSE_RECVD) == VCHIQ_RETRY)
+		if (vchiq_close_service_internal(service, CLOSE_RECVD) == VCHIQ_RETRY)
 			goto bail_not_ready;
 
-		vchiq_log_info(vchiq_core_log_level,
-			"Close Service %c%c%c%c s:%u d:%d",
-			VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
-			service->localport,
-			service->remoteport);
+		vchiq_log_info(vchiq_core_log_level, "Close Service %c%c%c%c s:%u d:%d",
+			       VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
+			       service->localport, service->remoteport);
 		break;
 	case VCHIQ_MSG_DATA:
-		vchiq_log_info(vchiq_core_log_level,
-			"%d: prs DATA@%pK,%x (%d->%d)",
-			state->id, header, size, remoteport, localport);
+		vchiq_log_info(vchiq_core_log_level, "%d: prs DATA@%pK,%x (%d->%d)",
+			       state->id, header, size, remoteport, localport);
 
 		if ((service->remoteport == remoteport) &&
 		    (service->srvstate == VCHIQ_SRVSTATE_OPEN)) {
 			header->msgid = msgid | VCHIQ_MSGID_CLAIMED;
 			claim_slot(state->rx_info);
 			DEBUG_TRACE(PARSE_LINE);
-			if (make_service_callback(service,
-				VCHIQ_MESSAGE_AVAILABLE, header,
-				NULL) == VCHIQ_RETRY) {
+			if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
+						  NULL) == VCHIQ_RETRY) {
 				DEBUG_TRACE(PARSE_LINE);
 				goto bail_not_ready;
 			}
 			VCHIQ_SERVICE_STATS_INC(service, ctrl_rx_count);
-			VCHIQ_SERVICE_STATS_ADD(service, ctrl_rx_bytes,
-				size);
+			VCHIQ_SERVICE_STATS_ADD(service, ctrl_rx_bytes, size);
 		} else {
 			VCHIQ_STATS_INC(state, error_count);
 		}
 		break;
 	case VCHIQ_MSG_CONNECT:
-		vchiq_log_info(vchiq_core_log_level,
-			"%d: prs CONNECT@%pK", state->id, header);
+		vchiq_log_info(vchiq_core_log_level, "%d: prs CONNECT@%pK", state->id, header);
 		state->version_common =	((struct vchiq_slot_zero *)
 					 state->slot_data)->version;
 		complete(&state->connect);
@@ -1827,11 +1754,10 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			if ((int)(queue->remote_insert -
 				queue->local_insert) >= 0) {
 				vchiq_log_error(vchiq_core_log_level,
-					"%d: prs %s@%pK (%d->%d) unexpected (ri=%d,li=%d)",
-					state->id, msg_type_str(type),
-					header, remoteport, localport,
-					queue->remote_insert,
-					queue->local_insert);
+						"%d: prs %s@%pK (%d->%d) unexpected (ri=%d,li=%d)",
+						state->id, msg_type_str(type), header, remoteport,
+						localport, queue->remote_insert,
+						queue->local_insert);
 				mutex_unlock(&service->bulk_mutex);
 				break;
 			}
@@ -1844,24 +1770,18 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 				goto bail_not_ready;
 			}
 
-			bulk = &queue->bulks[
-				BULK_INDEX(queue->remote_insert)];
+			bulk = &queue->bulks[BULK_INDEX(queue->remote_insert)];
 			bulk->actual = *(int *)header->data;
 			queue->remote_insert++;
 
-			vchiq_log_info(vchiq_core_log_level,
-				"%d: prs %s@%pK (%d->%d) %x@%pad",
-				state->id, msg_type_str(type),
-				header, remoteport, localport,
-				bulk->actual, &bulk->data);
+			vchiq_log_info(vchiq_core_log_level, "%d: prs %s@%pK (%d->%d) %x@%pad",
+				       state->id, msg_type_str(type), header, remoteport, localport,
+				       bulk->actual, &bulk->data);
 
-			vchiq_log_trace(vchiq_core_log_level,
-				"%d: prs:%d %cx li=%x ri=%x p=%x",
-				state->id, localport,
-				(type == VCHIQ_MSG_BULK_RX_DONE) ?
-					'r' : 't',
-				queue->local_insert,
-				queue->remote_insert, queue->process);
+			vchiq_log_trace(vchiq_core_log_level, "%d: prs:%d %cx li=%x ri=%x p=%x",
+					state->id, localport,
+					(type == VCHIQ_MSG_BULK_RX_DONE) ? 'r' : 't',
+					queue->local_insert, queue->remote_insert, queue->process);
 
 			DEBUG_TRACE(PARSE_LINE);
 			WARN_ON(queue->process == queue->local_insert);
@@ -1874,35 +1794,30 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		}
 		break;
 	case VCHIQ_MSG_PADDING:
-		vchiq_log_trace(vchiq_core_log_level,
-			"%d: prs PADDING@%pK,%x",
-			state->id, header, size);
+		vchiq_log_trace(vchiq_core_log_level, "%d: prs PADDING@%pK,%x",
+				state->id, header, size);
 		break;
 	case VCHIQ_MSG_PAUSE:
 		/* If initiated, signal the application thread */
-		vchiq_log_trace(vchiq_core_log_level,
-			"%d: prs PAUSE@%pK,%x",
-			state->id, header, size);
+		vchiq_log_trace(vchiq_core_log_level, "%d: prs PAUSE@%pK,%x",
+				state->id, header, size);
 		if (state->conn_state == VCHIQ_CONNSTATE_PAUSED) {
-			vchiq_log_error(vchiq_core_log_level,
-				"%d: PAUSE received in state PAUSED",
-				state->id);
+			vchiq_log_error(vchiq_core_log_level, "%d: PAUSE received in state PAUSED",
+					state->id);
 			break;
 		}
 		if (state->conn_state != VCHIQ_CONNSTATE_PAUSE_SENT) {
 			/* Send a PAUSE in response */
-			if (queue_message(state, NULL, MAKE_PAUSE,
-				NULL, NULL, 0, QMFLAGS_NO_MUTEX_UNLOCK)
-			    == VCHIQ_RETRY)
+			if (queue_message(state, NULL, MAKE_PAUSE, NULL, NULL, 0,
+					  QMFLAGS_NO_MUTEX_UNLOCK) == VCHIQ_RETRY)
 				goto bail_not_ready;
 		}
 		/* At this point slot_mutex is held */
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_PAUSED);
 		break;
 	case VCHIQ_MSG_RESUME:
-		vchiq_log_trace(vchiq_core_log_level,
-			"%d: prs RESUME@%pK,%x",
-			state->id, header, size);
+		vchiq_log_trace(vchiq_core_log_level, "%d: prs RESUME@%pK,%x",
+				state->id, header, size);
 		/* Release the slot mutex */
 		mutex_unlock(&state->slot_mutex);
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
@@ -1918,9 +1833,8 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		break;
 
 	default:
-		vchiq_log_error(vchiq_core_log_level,
-			"%d: prs invalid msgid %x@%pK,%x",
-			state->id, msgid, header, size);
+		vchiq_log_error(vchiq_core_log_level, "%d: prs invalid msgid %x@%pK,%x",
+				state->id, msgid, header, size);
 		WARN(1, "invalid message\n");
 		break;
 	}
@@ -2030,8 +1944,7 @@ handle_poll(struct vchiq_state *state)
 			 * since the PAUSE should have flushed
 			 * through outstanding messages.
 			 */
-			vchiq_log_error(vchiq_core_log_level,
-				"Failed to send RESUME message");
+			vchiq_log_error(vchiq_core_log_level, "Failed to send RESUME message");
 		}
 		break;
 	default:
@@ -2129,9 +2042,9 @@ sync_func(void *v)
 
 		if (!service) {
 			vchiq_log_error(vchiq_sync_log_level,
-				"%d: sf %s@%pK (%d->%d) - invalid/closed service %d",
-				state->id, msg_type_str(type),
-				header, remoteport, localport, localport);
+					"%d: sf %s@%pK (%d->%d) - invalid/closed service %d",
+					state->id, msg_type_str(type), header,
+					remoteport, localport, localport);
 			release_message_sync(state, header);
 			continue;
 		}
@@ -2143,13 +2056,11 @@ sync_func(void *v)
 				? service->base.fourcc
 				: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 			vchiq_log_trace(vchiq_sync_log_level,
-				"Rcvd Msg %s from %c%c%c%c s:%d d:%d len:%d",
-				msg_type_str(type),
-				VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
-				remoteport, localport, size);
+					"Rcvd Msg %s from %c%c%c%c s:%d d:%d len:%d",
+					msg_type_str(type), VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
+					remoteport, localport, size);
 			if (size > 0)
-				vchiq_log_dump_mem("Rcvd", 0, header->data,
-					min(16, size));
+				vchiq_log_dump_mem("Rcvd", 0, header->data, min(16, size));
 		}
 
 		switch (type) {
@@ -2160,14 +2071,12 @@ sync_func(void *v)
 					header->data;
 				service->peer_version = payload->version;
 			}
-			vchiq_log_info(vchiq_sync_log_level,
-				"%d: sf OPENACK@%pK,%x (%d->%d) v:%d",
-				state->id, header, size, remoteport, localport,
-				service->peer_version);
+			vchiq_log_info(vchiq_sync_log_level, "%d: sf OPENACK@%pK,%x (%d->%d) v:%d",
+				       state->id, header, size, remoteport, localport,
+				       service->peer_version);
 			if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
 				service->remoteport = remoteport;
-				vchiq_set_service_state(service,
-					VCHIQ_SRVSTATE_OPENSYNC);
+				vchiq_set_service_state(service, VCHIQ_SRVSTATE_OPENSYNC);
 				service->sync = 1;
 				complete(&service->remove_event);
 			}
@@ -2175,25 +2084,22 @@ sync_func(void *v)
 			break;
 
 		case VCHIQ_MSG_DATA:
-			vchiq_log_trace(vchiq_sync_log_level,
-				"%d: sf DATA@%pK,%x (%d->%d)",
-				state->id, header, size, remoteport, localport);
+			vchiq_log_trace(vchiq_sync_log_level, "%d: sf DATA@%pK,%x (%d->%d)",
+					state->id, header, size, remoteport, localport);
 
 			if ((service->remoteport == remoteport) &&
 			    (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)) {
-				if (make_service_callback(service,
-					VCHIQ_MESSAGE_AVAILABLE, header,
-					NULL) == VCHIQ_RETRY)
+				if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
+							  NULL) == VCHIQ_RETRY)
 					vchiq_log_error(vchiq_sync_log_level,
-						"synchronous callback to service %d returns VCHIQ_RETRY",
-						localport);
+							"synchronous callback to service %d returns VCHIQ_RETRY",
+							localport);
 			}
 			break;
 
 		default:
-			vchiq_log_error(vchiq_sync_log_level,
-				"%d: sf unexpected msgid %x@%pK,%x",
-				state->id, msgid, header, size);
+			vchiq_log_error(vchiq_sync_log_level, "%d: sf unexpected msgid %x@%pK,%x",
+					state->id, msgid, header, size);
 			release_message_sync(state, header);
 			break;
 		}
@@ -2236,9 +2142,8 @@ vchiq_init_slots(void *mem_base, int mem_size)
 	num_slots -= first_data_slot;
 
 	if (num_slots < 4) {
-		vchiq_log_error(vchiq_core_log_level,
-			"%s - insufficient memory %x bytes",
-			__func__, mem_size);
+		vchiq_log_error(vchiq_core_log_level, "%s - insufficient memory %x bytes",
+				__func__, mem_size);
 		return NULL;
 	}
 
@@ -2329,7 +2234,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	state->default_slot_quota = state->slot_queue_available / 2;
 	state->default_message_quota =
 		min((unsigned short)(state->default_slot_quota * 256),
-		(unsigned short)~0);
+		    (unsigned short)~0);
 
 	state->previous_data_index = -1;
 	state->data_use_count = 0;
@@ -2358,9 +2263,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	 * bring up slot handler thread
 	 */
 	snprintf(threadname, sizeof(threadname), "vchiq-slot/%d", state->id);
-	state->slot_handler_thread = kthread_create(&slot_handler_func,
-		(void *)state,
-		threadname);
+	state->slot_handler_thread = kthread_create(&slot_handler_func, (void *)state, threadname);
 
 	if (IS_ERR(state->slot_handler_thread)) {
 		vchiq_loud_error_header();
@@ -2371,9 +2274,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	set_user_nice(state->slot_handler_thread, -19);
 
 	snprintf(threadname, sizeof(threadname), "vchiq-recy/%d", state->id);
-	state->recycle_thread = kthread_create(&recycle_func,
-		(void *)state,
-		threadname);
+	state->recycle_thread = kthread_create(&recycle_func, (void *)state, threadname);
 	if (IS_ERR(state->recycle_thread)) {
 		vchiq_loud_error_header();
 		vchiq_loud_error("couldn't create thread %s", threadname);
@@ -2384,9 +2285,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	set_user_nice(state->recycle_thread, -19);
 
 	snprintf(threadname, sizeof(threadname), "vchiq-sync/%d", state->id);
-	state->sync_thread = kthread_create(&sync_func,
-		(void *)state,
-		threadname);
+	state->sync_thread = kthread_create(&sync_func, (void *)state, threadname);
 	if (IS_ERR(state->sync_thread)) {
 		vchiq_loud_error_header();
 		vchiq_loud_error("couldn't create thread %s", threadname);
@@ -2602,12 +2501,9 @@ vchiq_add_service_internal(struct vchiq_state *state,
 	/* Bring this service online */
 	vchiq_set_service_state(service, srvstate);
 
-	vchiq_log_info(vchiq_core_msg_log_level,
-		"%s Service %c%c%c%c SrcPort:%d",
-		(srvstate == VCHIQ_SRVSTATE_OPENING)
-		? "Open" : "Add",
-		VCHIQ_FOURCC_AS_4CHARS(params->fourcc),
-		service->localport);
+	vchiq_log_info(vchiq_core_msg_log_level, "%s Service %c%c%c%c SrcPort:%d",
+		       (srvstate == VCHIQ_SRVSTATE_OPENING) ? "Open" : "Add",
+		       VCHIQ_FOURCC_AS_4CHARS(params->fourcc), service->localport);
 
 	/* Don't unlock the service - leave it with a ref_count of 1. */
 
@@ -2702,19 +2598,15 @@ release_service_messages(struct vchiq_service *service)
 			int msgid = header->msgid;
 			int port = VCHIQ_MSG_DSTPORT(msgid);
 
-			if ((port == service->localport) &&
-				(msgid & VCHIQ_MSGID_CLAIMED)) {
-				vchiq_log_info(vchiq_core_log_level,
-					"  fsi - hdr %pK", header);
-				release_slot(state, slot_info, header,
-					NULL);
+			if ((port == service->localport) && (msgid & VCHIQ_MSGID_CLAIMED)) {
+				vchiq_log_info(vchiq_core_log_level, "  fsi - hdr %pK", header);
+				release_slot(state, slot_info, header, NULL);
 			}
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
 				vchiq_log_error(vchiq_core_log_level,
-					"fsi - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
-					pos, header, msgid,
-					header->msgid, header->size);
+						"fsi - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
+						pos, header, msgid, header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
 		}
@@ -2768,15 +2660,13 @@ close_service_complete(struct vchiq_service *service, int failstate)
 	case VCHIQ_SRVSTATE_LISTENING:
 		break;
 	default:
-		vchiq_log_error(vchiq_core_log_level,
-			"%s(%x) called in state %s", __func__,
-			service->handle, srvstate_names[service->srvstate]);
+		vchiq_log_error(vchiq_core_log_level, "%s(%x) called in state %s", __func__,
+				service->handle, srvstate_names[service->srvstate]);
 		WARN(1, "%s in unexpected state\n", __func__);
 		return VCHIQ_ERROR;
 	}
 
-	status = make_service_callback(service,
-		VCHIQ_SERVICE_CLOSED, NULL, NULL);
+	status = make_service_callback(service, VCHIQ_SERVICE_CLOSED, NULL, NULL);
 
 	if (status != VCHIQ_RETRY) {
 		int uc = service->service_use_count;
@@ -2817,9 +2707,8 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	int close_id = MAKE_CLOSE(service->localport,
 				  VCHIQ_MSG_DSTPORT(service->remoteport));
 
-	vchiq_log_info(vchiq_core_log_level, "%d: csi:%d,%d (%s)",
-		service->state->id, service->localport, close_recvd,
-		srvstate_names[service->srvstate]);
+	vchiq_log_info(vchiq_core_log_level, "%d: csi:%d,%d (%s)", service->state->id,
+		       service->localport, close_recvd, srvstate_names[service->srvstate]);
 
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_CLOSED:
@@ -2827,9 +2716,8 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	case VCHIQ_SRVSTATE_LISTENING:
 	case VCHIQ_SRVSTATE_CLOSEWAIT:
 		if (close_recvd) {
-			vchiq_log_error(vchiq_core_log_level,
-				"%s(1) called in state %s",
-				__func__, srvstate_names[service->srvstate]);
+			vchiq_log_error(vchiq_core_log_level, "%s(1) called in state %s",
+					__func__, srvstate_names[service->srvstate]);
 		} else if (is_server) {
 			if (service->srvstate == VCHIQ_SRVSTATE_LISTENING) {
 				status = VCHIQ_ERROR;
@@ -2838,8 +2726,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 				service->remoteport = VCHIQ_PORT_FREE;
 				if (service->srvstate ==
 					VCHIQ_SRVSTATE_CLOSEWAIT)
-					vchiq_set_service_state(service,
-						VCHIQ_SRVSTATE_LISTENING);
+					vchiq_set_service_state(service, VCHIQ_SRVSTATE_LISTENING);
 			}
 			complete(&service->remove_event);
 		} else {
@@ -2849,13 +2736,11 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	case VCHIQ_SRVSTATE_OPENING:
 		if (close_recvd) {
 			/* The open was rejected - tell the user */
-			vchiq_set_service_state(service,
-				VCHIQ_SRVSTATE_CLOSEWAIT);
+			vchiq_set_service_state(service, VCHIQ_SRVSTATE_CLOSEWAIT);
 			complete(&service->remove_event);
 		} else {
 			/* Shutdown mid-open - let the other side know */
-			status = queue_message(state, service, close_id,
-				NULL, NULL, 0, 0);
+			status = queue_message(state, service, close_id, NULL, NULL, 0, 0);
 		}
 		break;
 
@@ -2871,8 +2756,8 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 		release_service_messages(service);
 
 		if (status == VCHIQ_SUCCESS)
-			status = queue_message(state, service, close_id,
-				NULL, NULL, 0, QMFLAGS_NO_MUTEX_UNLOCK);
+			status = queue_message(state, service, close_id, NULL,
+					       NULL, 0, QMFLAGS_NO_MUTEX_UNLOCK);
 
 		if (status != VCHIQ_SUCCESS) {
 			if (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)
@@ -2896,8 +2781,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 		if (service->sync)
 			mutex_unlock(&state->sync_mutex);
 
-		status = close_service_complete(service,
-				VCHIQ_SRVSTATE_CLOSERECVD);
+		status = close_service_complete(service, VCHIQ_SRVSTATE_CLOSERECVD);
 		break;
 
 	case VCHIQ_SRVSTATE_CLOSESENT:
@@ -2911,23 +2795,19 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 		}
 
 		if (status == VCHIQ_SUCCESS)
-			status = close_service_complete(service,
-				VCHIQ_SRVSTATE_CLOSERECVD);
+			status = close_service_complete(service, VCHIQ_SRVSTATE_CLOSERECVD);
 		break;
 
 	case VCHIQ_SRVSTATE_CLOSERECVD:
 		if (!close_recvd && is_server)
 			/* Force into LISTENING mode */
-			vchiq_set_service_state(service,
-				VCHIQ_SRVSTATE_LISTENING);
-		status = close_service_complete(service,
-			VCHIQ_SRVSTATE_CLOSERECVD);
+			vchiq_set_service_state(service, VCHIQ_SRVSTATE_LISTENING);
+		status = close_service_complete(service, VCHIQ_SRVSTATE_CLOSERECVD);
 		break;
 
 	default:
-		vchiq_log_error(vchiq_core_log_level,
-			"%s(%d) called in state %s", __func__,
-			close_recvd, srvstate_names[service->srvstate]);
+		vchiq_log_error(vchiq_core_log_level, "%s(%d) called in state %s", __func__,
+				close_recvd, srvstate_names[service->srvstate]);
 		break;
 	}
 
@@ -2940,8 +2820,8 @@ vchiq_terminate_service_internal(struct vchiq_service *service)
 {
 	struct vchiq_state *state = service->state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: tsi - (%d<->%d)",
-		state->id, service->localport, service->remoteport);
+	vchiq_log_info(vchiq_core_log_level, "%d: tsi - (%d<->%d)", state->id,
+		       service->localport, service->remoteport);
 
 	mark_service_closing(service);
 
@@ -2955,8 +2835,7 @@ vchiq_free_service_internal(struct vchiq_service *service)
 {
 	struct vchiq_state *state = service->state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: fsi - (%d)",
-		state->id, service->localport);
+	vchiq_log_info(vchiq_core_log_level, "%d: fsi - (%d)", state->id, service->localport);
 
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_OPENING:
@@ -2966,10 +2845,8 @@ vchiq_free_service_internal(struct vchiq_service *service)
 	case VCHIQ_SRVSTATE_CLOSEWAIT:
 		break;
 	default:
-		vchiq_log_error(vchiq_core_log_level,
-			"%d: fsi - (%d) in state %s",
-			state->id, service->localport,
-			srvstate_names[service->srvstate]);
+		vchiq_log_error(vchiq_core_log_level, "%d: fsi - (%d) in state %s", state->id,
+				service->localport, srvstate_names[service->srvstate]);
 		return;
 	}
 
@@ -2989,17 +2866,15 @@ vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instanc
 
 	/* Find all services registered to this client and enable them. */
 	i = 0;
-	while ((service = next_service_by_instance(state, instance,
-		&i)) !=	NULL) {
+	while ((service = next_service_by_instance(state, instance, &i)) != NULL) {
 		if (service->srvstate == VCHIQ_SRVSTATE_HIDDEN)
-			vchiq_set_service_state(service,
-				VCHIQ_SRVSTATE_LISTENING);
+			vchiq_set_service_state(service, VCHIQ_SRVSTATE_LISTENING);
 		vchiq_service_put(service);
 	}
 
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED) {
-		if (queue_message(state, NULL, MAKE_CONNECT, NULL, NULL,
-			0, QMFLAGS_IS_BLOCKING) == VCHIQ_RETRY)
+		if (queue_message(state, NULL, MAKE_CONNECT, NULL, NULL, 0,
+				  QMFLAGS_IS_BLOCKING) == VCHIQ_RETRY)
 			return VCHIQ_RETRY;
 
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTING);
@@ -3024,8 +2899,7 @@ vchiq_shutdown_internal(struct vchiq_state *state, struct vchiq_instance *instan
 
 	/* Find all services registered to this client and remove them. */
 	i = 0;
-	while ((service = next_service_by_instance(state, instance,
-		&i)) !=	NULL) {
+	while ((service = next_service_by_instance(state, instance, &i)) != NULL) {
 		(void)vchiq_remove_service(service->handle);
 		vchiq_service_put(service);
 	}
@@ -3041,9 +2915,8 @@ vchiq_close_service(unsigned int handle)
 	if (!service)
 		return VCHIQ_ERROR;
 
-	vchiq_log_info(vchiq_core_log_level,
-		"%d: close_service:%d",
-		service->state->id, service->localport);
+	vchiq_log_info(vchiq_core_log_level, "%d: close_service:%d",
+		       service->state->id, service->localport);
 
 	if ((service->srvstate == VCHIQ_SRVSTATE_FREE) ||
 	    (service->srvstate == VCHIQ_SRVSTATE_LISTENING) ||
@@ -3074,9 +2947,9 @@ vchiq_close_service(unsigned int handle)
 			break;
 
 		vchiq_log_warning(vchiq_core_log_level,
-			"%d: close_service:%d - waiting in state %s",
-			service->state->id, service->localport,
-			srvstate_names[service->srvstate]);
+				  "%d: close_service:%d - waiting in state %s",
+				  service->state->id, service->localport,
+				  srvstate_names[service->srvstate]);
 	}
 
 	if ((status == VCHIQ_SUCCESS) &&
@@ -3100,9 +2973,8 @@ vchiq_remove_service(unsigned int handle)
 	if (!service)
 		return VCHIQ_ERROR;
 
-	vchiq_log_info(vchiq_core_log_level,
-		"%d: remove_service:%d",
-		service->state->id, service->localport);
+	vchiq_log_info(vchiq_core_log_level, "%d: remove_service:%d",
+		       service->state->id, service->localport);
 
 	if (service->srvstate == VCHIQ_SRVSTATE_FREE) {
 		vchiq_service_put(service);
@@ -3136,9 +3008,9 @@ vchiq_remove_service(unsigned int handle)
 			break;
 
 		vchiq_log_warning(vchiq_core_log_level,
-			"%d: remove_service:%d - waiting in state %s",
-			service->state->id, service->localport,
-			srvstate_names[service->srvstate]);
+				  "%d: remove_service:%d - waiting in state %s",
+				  service->state->id, service->localport,
+				  srvstate_names[service->srvstate]);
 	}
 
 	if ((status == VCHIQ_SUCCESS) &&
@@ -3158,11 +3030,9 @@ vchiq_remove_service(unsigned int handle)
  * When called in blocking mode, the userdata field points to a bulk_waiter
  * structure.
  */
-enum vchiq_status vchiq_bulk_transfer(unsigned int handle,
-				   void *offset, void __user *uoffset,
-				   int size, void *userdata,
-				   enum vchiq_bulk_mode mode,
-				   enum vchiq_bulk_dir dir)
+enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __user *uoffset,
+				      int size, void *userdata, enum vchiq_bulk_mode mode,
+				      enum vchiq_bulk_dir dir)
 {
 	struct vchiq_service *service = find_service_by_handle(handle);
 	struct vchiq_bulk_queue *queue;
@@ -3245,10 +3115,9 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle,
 
 	wmb();
 
-	vchiq_log_info(vchiq_core_log_level,
-		"%d: bt (%d->%d) %cx %x@%pad %pK",
-		state->id, service->localport, service->remoteport, dir_char,
-		size, &bulk->data, userdata);
+	vchiq_log_info(vchiq_core_log_level, "%d: bt (%d->%d) %cx %x@%pad %pK",
+		       state->id, service->localport, service->remoteport,
+		       dir_char, size, &bulk->data, userdata);
 
 	/*
 	 * The slot mutex must be held when the service is being closed, so
@@ -3283,11 +3152,9 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle,
 	mutex_unlock(&state->slot_mutex);
 	mutex_unlock(&service->bulk_mutex);
 
-	vchiq_log_trace(vchiq_core_log_level,
-		"%d: bt:%d %cx li=%x ri=%x p=%x",
-		state->id,
-		service->localport, dir_char,
-		queue->local_insert, queue->remote_insert, queue->process);
+	vchiq_log_trace(vchiq_core_log_level, "%d: bt:%d %cx li=%x ri=%x p=%x",
+			state->id, service->localport, dir_char, queue->local_insert,
+			queue->remote_insert, queue->process);
 
 waiting:
 	vchiq_service_put(service);
@@ -3349,11 +3216,11 @@ vchiq_queue_message(unsigned int handle,
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_OPEN:
 		status = queue_message(service->state, service, data_id,
-				copy_callback, context, size, 1);
+				       copy_callback, context, size, 1);
 		break;
 	case VCHIQ_SRVSTATE_OPENSYNC:
 		status = queue_message_sync(service->state, service, data_id,
-				copy_callback, context, size, 1);
+					    copy_callback, context, size, 1);
 		break;
 	default:
 		status = VCHIQ_ERROR;
@@ -3468,8 +3335,7 @@ void vchiq_get_config(struct vchiq_config *config)
 }
 
 int
-vchiq_set_service_option(unsigned int handle,
-	enum vchiq_service_option option, int value)
+vchiq_set_service_option(unsigned int handle, enum vchiq_service_option option, int value)
 {
 	struct vchiq_service *service = find_service_by_handle(handle);
 	struct vchiq_service_quota *quota;
@@ -3563,16 +3429,14 @@ vchiq_dump_shared_state(void *dump_context, struct vchiq_state *state,
 	int len;
 	int err;
 
-	len = scnprintf(buf, sizeof(buf),
-		"  %s: slots %d-%d tx_pos=%x recycle=%x",
-		label, shared->slot_first, shared->slot_last,
-		shared->tx_pos, shared->slot_queue_recycle);
+	len = scnprintf(buf, sizeof(buf), "  %s: slots %d-%d tx_pos=%x recycle=%x",
+			label, shared->slot_first, shared->slot_last,
+			shared->tx_pos, shared->slot_queue_recycle);
 	err = vchiq_dump(dump_context, buf, len + 1);
 	if (err)
 		return err;
 
-	len = scnprintf(buf, sizeof(buf),
-		"    Slots claimed:");
+	len = scnprintf(buf, sizeof(buf), "    Slots claimed:");
 	err = vchiq_dump(dump_context, buf, len + 1);
 	if (err)
 		return err;
@@ -3581,9 +3445,8 @@ vchiq_dump_shared_state(void *dump_context, struct vchiq_state *state,
 		struct vchiq_slot_info slot_info =
 						*SLOT_INFO_FROM_INDEX(state, i);
 		if (slot_info.use_count != slot_info.release_count) {
-			len = scnprintf(buf, sizeof(buf),
-				"      %d: %d/%d", i, slot_info.use_count,
-				slot_info.release_count);
+			len = scnprintf(buf, sizeof(buf), "      %d: %d/%d", i, slot_info.use_count,
+					slot_info.release_count);
 			err = vchiq_dump(dump_context, buf, len + 1);
 			if (err)
 				return err;
@@ -3592,7 +3455,7 @@ vchiq_dump_shared_state(void *dump_context, struct vchiq_state *state,
 
 	for (i = 1; i < shared->debug[DEBUG_ENTRIES]; i++) {
 		len = scnprintf(buf, sizeof(buf), "    DEBUG: %s = %d(%x)",
-			debug_names[i], shared->debug[i], shared->debug[i]);
+				debug_names[i], shared->debug[i], shared->debug[i]);
 		err = vchiq_dump(dump_context, buf, len + 1);
 		if (err)
 			return err;
@@ -3608,45 +3471,43 @@ int vchiq_dump_state(void *dump_context, struct vchiq_state *state)
 	int err;
 
 	len = scnprintf(buf, sizeof(buf), "State %d: %s", state->id,
-		conn_state_names[state->conn_state]);
+			conn_state_names[state->conn_state]);
 	err = vchiq_dump(dump_context, buf, len + 1);
 	if (err)
 		return err;
 
-	len = scnprintf(buf, sizeof(buf),
-		"  tx_pos=%x(@%pK), rx_pos=%x(@%pK)",
-		state->local->tx_pos,
-		state->tx_data + (state->local_tx_pos & VCHIQ_SLOT_MASK),
-		state->rx_pos,
-		state->rx_data + (state->rx_pos & VCHIQ_SLOT_MASK));
+	len = scnprintf(buf, sizeof(buf), "  tx_pos=%x(@%pK), rx_pos=%x(@%pK)",
+			state->local->tx_pos,
+			state->tx_data + (state->local_tx_pos & VCHIQ_SLOT_MASK),
+			state->rx_pos,
+			state->rx_data + (state->rx_pos & VCHIQ_SLOT_MASK));
 	err = vchiq_dump(dump_context, buf, len + 1);
 	if (err)
 		return err;
 
-	len = scnprintf(buf, sizeof(buf),
-		"  Version: %d (min %d)",
-		VCHIQ_VERSION, VCHIQ_VERSION_MIN);
+	len = scnprintf(buf, sizeof(buf), "  Version: %d (min %d)",
+			VCHIQ_VERSION, VCHIQ_VERSION_MIN);
 	err = vchiq_dump(dump_context, buf, len + 1);
 	if (err)
 		return err;
 
 	if (VCHIQ_ENABLE_STATS) {
 		len = scnprintf(buf, sizeof(buf),
-			"  Stats: ctrl_tx_count=%d, ctrl_rx_count=%d, error_count=%d",
-			state->stats.ctrl_tx_count, state->stats.ctrl_rx_count,
-			state->stats.error_count);
+				"  Stats: ctrl_tx_count=%d, ctrl_rx_count=%d, error_count=%d",
+				state->stats.ctrl_tx_count, state->stats.ctrl_rx_count,
+				state->stats.error_count);
 		err = vchiq_dump(dump_context, buf, len + 1);
 		if (err)
 			return err;
 	}
 
 	len = scnprintf(buf, sizeof(buf),
-		"  Slots: %d available (%d data), %d recyclable, %d stalls (%d data)",
-		((state->slot_queue_available * VCHIQ_SLOT_SIZE) -
+			"  Slots: %d available (%d data), %d recyclable, %d stalls (%d data)",
+			((state->slot_queue_available * VCHIQ_SLOT_SIZE) -
 			state->local_tx_pos) / VCHIQ_SLOT_SIZE,
-		state->data_quota - state->data_use_count,
-		state->local->slot_queue_recycle - state->slot_queue_available,
-		state->stats.slot_stalls, state->stats.data_stalls);
+			state->data_quota - state->data_use_count,
+			state->local->slot_queue_recycle - state->slot_queue_available,
+			state->stats.slot_stalls, state->stats.data_stalls);
 	err = vchiq_dump(dump_context, buf, len + 1);
 	if (err)
 		return err;
@@ -3710,21 +3571,17 @@ int vchiq_dump_service_state(void *dump_context, struct vchiq_service *service)
 				"%u", service->remoteport);
 
 			if (service->public_fourcc != VCHIQ_FOURCC_INVALID)
-				scnprintf(remoteport + len2,
-					sizeof(remoteport) - len2,
-					" (client %x)", service->client_id);
+				scnprintf(remoteport + len2, sizeof(remoteport) - len2,
+					  " (client %x)", service->client_id);
 		} else {
 			strscpy(remoteport, "n/a", sizeof(remoteport));
 		}
 
 		len += scnprintf(buf + len, sizeof(buf) - len,
-			" '%c%c%c%c' remote %s (msg use %d/%d, slot use %d/%d)",
-			VCHIQ_FOURCC_AS_4CHARS(fourcc),
-			remoteport,
-			quota->message_use_count,
-			quota->message_quota,
-			quota->slot_use_count,
-			quota->slot_quota);
+				 " '%c%c%c%c' remote %s (msg use %d/%d, slot use %d/%d)",
+				 VCHIQ_FOURCC_AS_4CHARS(fourcc), remoteport,
+				 quota->message_use_count, quota->message_quota,
+				 quota->slot_use_count, quota->slot_quota);
 
 		err = vchiq_dump(dump_context, buf, len + 1);
 		if (err)
@@ -3737,13 +3594,13 @@ int vchiq_dump_service_state(void *dump_context, struct vchiq_service *service)
 			service->bulk_rx.remote_insert;
 
 		len = scnprintf(buf, sizeof(buf),
-			"  Bulk: tx_pending=%d (size %d), rx_pending=%d (size %d)",
-			tx_pending,
-			tx_pending ? service->bulk_tx.bulks[
-			BULK_INDEX(service->bulk_tx.remove)].size : 0,
-			rx_pending,
-			rx_pending ? service->bulk_rx.bulks[
-			BULK_INDEX(service->bulk_rx.remove)].size : 0);
+				"  Bulk: tx_pending=%d (size %d), rx_pending=%d (size %d)",
+				tx_pending,
+				tx_pending ?
+				service->bulk_tx.bulks[BULK_INDEX(service->bulk_tx.remove)].size :
+				0, rx_pending, rx_pending ?
+				service->bulk_rx.bulks[BULK_INDEX(service->bulk_rx.remove)].size :
+				0);
 
 		if (VCHIQ_ENABLE_STATS) {
 			err = vchiq_dump(dump_context, buf, len + 1);
@@ -3751,32 +3608,27 @@ int vchiq_dump_service_state(void *dump_context, struct vchiq_service *service)
 				return err;
 
 			len = scnprintf(buf, sizeof(buf),
-				"  Ctrl: tx_count=%d, tx_bytes=%llu, rx_count=%d, rx_bytes=%llu",
-				service->stats.ctrl_tx_count,
-				service->stats.ctrl_tx_bytes,
-				service->stats.ctrl_rx_count,
-				service->stats.ctrl_rx_bytes);
+					"  Ctrl: tx_count=%d, tx_bytes=%llu, rx_count=%d, rx_bytes=%llu",
+					service->stats.ctrl_tx_count, service->stats.ctrl_tx_bytes,
+					service->stats.ctrl_rx_count, service->stats.ctrl_rx_bytes);
 			err = vchiq_dump(dump_context, buf, len + 1);
 			if (err)
 				return err;
 
 			len = scnprintf(buf, sizeof(buf),
-				"  Bulk: tx_count=%d, tx_bytes=%llu, rx_count=%d, rx_bytes=%llu",
-				service->stats.bulk_tx_count,
-				service->stats.bulk_tx_bytes,
-				service->stats.bulk_rx_count,
-				service->stats.bulk_rx_bytes);
+					"  Bulk: tx_count=%d, tx_bytes=%llu, rx_count=%d, rx_bytes=%llu",
+					service->stats.bulk_tx_count, service->stats.bulk_tx_bytes,
+					service->stats.bulk_rx_count, service->stats.bulk_rx_bytes);
 			err = vchiq_dump(dump_context, buf, len + 1);
 			if (err)
 				return err;
 
 			len = scnprintf(buf, sizeof(buf),
-				"  %d quota stalls, %d slot stalls, %d bulk stalls, %d aborted, %d errors",
-				service->stats.quota_stalls,
-				service->stats.slot_stalls,
-				service->stats.bulk_stalls,
-				service->stats.bulk_aborted_count,
-				service->stats.error_count);
+					"  %d quota stalls, %d slot stalls, %d bulk stalls, %d aborted, %d errors",
+					service->stats.quota_stalls, service->stats.slot_stalls,
+					service->stats.bulk_stalls,
+					service->stats.bulk_aborted_count,
+					service->stats.error_count);
 		}
 	}
 
@@ -3793,9 +3645,9 @@ void
 vchiq_loud_error_header(void)
 {
 	vchiq_log_error(vchiq_core_log_level,
-		"============================================================================");
+			"============================================================================");
 	vchiq_log_error(vchiq_core_log_level,
-		"============================================================================");
+			"============================================================================");
 	vchiq_log_error(vchiq_core_log_level, "=====");
 }
 
@@ -3804,9 +3656,9 @@ vchiq_loud_error_footer(void)
 {
 	vchiq_log_error(vchiq_core_log_level, "=====");
 	vchiq_log_error(vchiq_core_log_level,
-		"============================================================================");
+			"============================================================================");
 	vchiq_log_error(vchiq_core_log_level,
-		"============================================================================");
+			"============================================================================");
 }
 
 enum vchiq_status vchiq_send_remote_use(struct vchiq_state *state)
@@ -3826,8 +3678,7 @@ enum vchiq_status vchiq_send_remote_use_active(struct vchiq_state *state)
 			     NULL, NULL, 0, 0);
 }
 
-void vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem,
-	size_t num_bytes)
+void vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem, size_t num_bytes)
 {
 	const u8  *mem = void_mem;
 	size_t          offset;
@@ -3856,11 +3707,9 @@ void vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem,
 		*s++ = '\0';
 
 		if (label && (*label != '\0'))
-			vchiq_log_trace(VCHIQ_LOG_TRACE,
-				"%s: %08x: %s", label, addr, line_buf);
+			vchiq_log_trace(VCHIQ_LOG_TRACE, "%s: %08x: %s", label, addr, line_buf);
 		else
-			vchiq_log_trace(VCHIQ_LOG_TRACE,
-				"%08x: %s", addr, line_buf);
+			vchiq_log_trace(VCHIQ_LOG_TRACE, "%08x: %s", addr, line_buf);
 
 		addr += 16;
 		mem += 16;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index de1e861c4ed3..893b07698268 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -531,12 +531,10 @@ extern struct vchiq_service *
 find_service_by_port(struct vchiq_state *state, int localport);
 
 extern struct vchiq_service *
-find_service_for_instance(struct vchiq_instance *instance,
-	unsigned int handle);
+find_service_for_instance(struct vchiq_instance *instance, unsigned int handle);
 
 extern struct vchiq_service *
-find_closed_service_for_instance(struct vchiq_instance *instance,
-	unsigned int handle);
+find_closed_service_for_instance(struct vchiq_instance *instance, unsigned int handle);
 
 extern struct vchiq_service *
 __next_service_by_instance(struct vchiq_state *state,
@@ -586,8 +584,7 @@ extern int
 vchiq_dump_platform_instances(void *dump_context);
 
 extern int
-vchiq_dump_platform_service_state(void *dump_context,
-	struct vchiq_service *service);
+vchiq_dump_platform_service_state(void *dump_context, struct vchiq_service *service);
 
 extern int
 vchiq_use_service_internal(struct vchiq_service *service);
@@ -625,8 +622,7 @@ extern void
 vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate);
 
 extern void
-vchiq_log_dump_mem(const char *label, uint32_t addr, const void *voidMem,
-	size_t numBytes);
+vchiq_log_dump_mem(const char *label, uint32_t addr, const void *voidMem, size_t numBytes);
 
 extern enum vchiq_status vchiq_remove_service(unsigned int service);
 
-- 
2.33.1

