Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D339673F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhEaRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhEaRig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:38:36 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C11C053A3E
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 09:49:39 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id h32-20020a17090a29a3b0290161dfc5d1bfso245425pjd.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DSMo94ePvCP7FwF99U0atNGClZu5aO1FYBWZFjCuV1c=;
        b=AzeORoHfGE78HCM8FNlvMVGZJ5BsGJhOgq92lqSmJdvBwbinFxJPhCnziGuDVD8SoF
         B9r1oolc5PU46Q8A60KXMoX473Kyb1BDne67EKNwDPO4NkLCJodR4uGyw9LI3IbdWU2d
         VUu9aryb+Lh67dOGLC/IOPFyPHu47Ldj+aa1t8UJpNboLQtVfUSWalvY+Lh/2cb+j1ns
         HkKem8RMVBupHiQqHcR60LPr8jrx/zGwXy9kKz9ZMowCRNwCbgYSc9+Nn3vXHmTWeWqJ
         R7ZkaQeDmfFWN0uWZgBGIzCMVXV4kCIsj5wV6MVeh4i/fqCBngyE2LZghp67g0XJDh4n
         WJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DSMo94ePvCP7FwF99U0atNGClZu5aO1FYBWZFjCuV1c=;
        b=eAyTcmNcXckhNdNZ479JkVQQIK6+65FLWGT2jqg/Ba491fjKNlSvGOktEX+I39DY4H
         8OdTMwyHwttUXIboVDQoS+or7Or4pT11kxb6n3vkfYIKX/ZEXHNnK3hd4E3s0z4Jlndj
         WWexeQiPKex0t+RVuFr78ZdmybNDW6j8HWdyptNqqDUr+b6Ne29Kwtx46ELEE+eEoigs
         32PSpedIwNaP0kCAfY1VR3ZSeQGQGV3x96Q7Au9KGTtDxQA/GLk8UdaAkCHCip9qgrmV
         npwY+ikRi9D5bE8kYagDEBwvISrvkMjrEm4nptFRiDdUdnwy9Nah2268Yd8rKE9MOcq2
         9r2A==
X-Gm-Message-State: AOAM531skuG73lj0S7pv9X97b8tAEibyU8vqswB6xvJpQSLZgbGrSarD
        rGZa5mm7HIph9Bo8Dm+FffC1fbTXTS9Z
X-Google-Smtp-Source: ABdhPJwuoO2NE86olYY0c8XXdZoW/gUTl4qp0gl+KWGXcV/CrWpYGGJQVJgxTj2LtUnrvlIb5qSQV8KVo2U+
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:c9e8:9a17:9774:bcd3])
 (user=kyletso job=sendgmr) by 2002:a62:7d4e:0:b029:2e9:ac1c:2769 with SMTP id
 y75-20020a627d4e0000b02902e9ac1c2769mr11682848pfc.57.1622479778806; Mon, 31
 May 2021 09:49:38 -0700 (PDT)
Date:   Tue,  1 Jun 2021 00:49:28 +0800
Message-Id: <20210531164928.2368606-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH] usb: typec: tcpm: Properly handle Alert and Status Messages
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, Adam.Thomson.Opensource@diasemi.com
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When receiving Alert Message, if it is not unexpected but is
unsupported for some reason, the port should return Not_Supported
Message response.

Also, according to PD3.0 Spec 6.5.2.1.4 Event Flags Field, the
OTP/OVP/OCP flags in the Event Flags field in Status Message no longer
require Get_PPS_Status Message to clear them. Thus remove it when
receiving Status Message with those flags being set.

In addition, add the missing AMS operations for Status Message.

Fixes: 64f7c494a3c0 ("typec: tcpm: Add support for sink PPS related messages")
Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c  | 52 ++++++++++++++++++----------------
 include/linux/usb/pd_ext_sdb.h |  4 ---
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0db685d5d9c0..3101753b3182 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2211,20 +2211,25 @@ static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
 
 	if (!type) {
 		tcpm_log(port, "Alert message received with no type");
+		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
 		return;
 	}
 
 	/* Just handling non-battery alerts for now */
 	if (!(type & USB_PD_ADO_TYPE_BATT_STATUS_CHANGE)) {
-		switch (port->state) {
-		case SRC_READY:
-		case SNK_READY:
+		if (port->pwr_role == TYPEC_SOURCE) {
+			port->upcoming_state = GET_STATUS_SEND;
+			tcpm_ams_start(port, GETTING_SOURCE_SINK_STATUS);
+		} else {
+			/*
+			 * Do not check SinkTxOk here in case the Source doesn't set its Rp to
+			 * SinkTxOk in time.
+			 */
+			port->ams = GETTING_SOURCE_SINK_STATUS;
 			tcpm_set_state(port, GET_STATUS_SEND, 0);
-			break;
-		default:
-			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
-			break;
 		}
+	} else {
+		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
 	}
 }
 
@@ -2468,7 +2473,12 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 		tcpm_pd_handle_state(port, BIST_RX, BIST, 0);
 		break;
 	case PD_DATA_ALERT:
-		tcpm_handle_alert(port, msg->payload, cnt);
+		if (port->state != SRC_READY && port->state != SNK_READY)
+			tcpm_pd_handle_state(port, port->pwr_role == TYPEC_SOURCE ?
+					     SRC_SOFT_RESET_WAIT_SNK_TX : SNK_SOFT_RESET,
+					     NONE_AMS, 0);
+		else
+			tcpm_handle_alert(port, msg->payload, cnt);
 		break;
 	case PD_DATA_BATT_STATUS:
 	case PD_DATA_GET_COUNTRY_INFO:
@@ -2792,24 +2802,16 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 
 	switch (type) {
 	case PD_EXT_STATUS:
-		/*
-		 * If PPS related events raised then get PPS status to clear
-		 * (see USB PD 3.0 Spec, 6.5.2.4)
-		 */
-		if (msg->ext_msg.data[USB_PD_EXT_SDB_EVENT_FLAGS] &
-		    USB_PD_EXT_SDB_PPS_EVENTS)
-			tcpm_pd_handle_state(port, GET_PPS_STATUS_SEND,
-					     GETTING_SOURCE_SINK_STATUS, 0);
-
-		else
-			tcpm_pd_handle_state(port, ready_state(port), NONE_AMS, 0);
-		break;
 	case PD_EXT_PPS_STATUS:
-		/*
-		 * For now the PPS status message is used to clear events
-		 * and nothing more.
-		 */
-		tcpm_pd_handle_state(port, ready_state(port), NONE_AMS, 0);
+		if (port->ams == GETTING_SOURCE_SINK_STATUS) {
+			tcpm_ams_finish(port);
+			tcpm_set_state(port, ready_state(port), 0);
+		} else {
+			/* unexpected Status or PPS_Status Message */
+			tcpm_pd_handle_state(port, port->pwr_role == TYPEC_SOURCE ?
+					     SRC_SOFT_RESET_WAIT_SNK_TX : SNK_SOFT_RESET,
+					     NONE_AMS, 0);
+		}
 		break;
 	case PD_EXT_SOURCE_CAP_EXT:
 	case PD_EXT_GET_BATT_CAP:
diff --git a/include/linux/usb/pd_ext_sdb.h b/include/linux/usb/pd_ext_sdb.h
index 0eb83ce19597..b517ebc8f0ff 100644
--- a/include/linux/usb/pd_ext_sdb.h
+++ b/include/linux/usb/pd_ext_sdb.h
@@ -24,8 +24,4 @@ enum usb_pd_ext_sdb_fields {
 #define USB_PD_EXT_SDB_EVENT_OVP		BIT(3)
 #define USB_PD_EXT_SDB_EVENT_CF_CV_MODE		BIT(4)
 
-#define USB_PD_EXT_SDB_PPS_EVENTS	(USB_PD_EXT_SDB_EVENT_OCP |	\
-					 USB_PD_EXT_SDB_EVENT_OTP |	\
-					 USB_PD_EXT_SDB_EVENT_OVP)
-
 #endif /* __LINUX_USB_PD_EXT_SDB_H */
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

