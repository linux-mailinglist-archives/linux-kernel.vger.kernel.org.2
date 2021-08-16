Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01E3ECFC9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhHPHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbhHPHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:55:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D05C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:54:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 203-20020a250bd40000b02905933fff7091so15915662ybl.16
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dKcam6Ga3SJWbiTZGs5fd12aDQ0HQybPZuSslYUEuGQ=;
        b=pNrE2wBWB76/2dmyYjbIdq9KoD6bsFVwvrNLKLdHJqtnU6tuO6IDV6fak6YRXT4L4E
         B9ETGV1iCYeAO/r6MtFnL27t6y3qRGDudXV0gCMOIVKK4pr74m1N7M99FdmmPjeyOEKi
         30gXj5bvf0DylxNqNXgSSGp9/66ZK+zgi2QlsozXbbcUVVtQznWnxuwjBYekzNViZ2kO
         oXvOaCak62T6D4f794V5iR2QH9HlrR8RaP4PUmCQbsOv8pFqeBpWEKdXzvcP+aP3Ccmq
         QdmrVwirYXhsDPvzdDCiT7rOLTT1VcS8wqMGsJsmS8DDyEnTa9gYdTWH9abm4AQ7lj6F
         tcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dKcam6Ga3SJWbiTZGs5fd12aDQ0HQybPZuSslYUEuGQ=;
        b=REwTWz8+uZmUgvHPO+i1xQ0uwMUOPtcRr0S3u6Ht5fN7T9HlJmvXlxqGLy78lfE+k4
         ifYip641FBKbxQ0dnFWHmqYsXzTIhaQ+tzlvXz98xzwJ3wl0WlY7bElnqkYisUYPuCB4
         483qCpp51EEAx9gKxGFy9/M7DbXlVILFFL1StF3w+MUli788Qem0JXlhjt7qEZXGfuHj
         4v4Ngxfgc//9V6EJK0QoC1dSDqe5fhprL8wyod9jfQaDqmpC+r9qzHYnHHCTs03Mbttg
         2v9HuCYUbOkHAwDk0WcjrTyYJ/FWW5dI5FfepcvMMVVMnKyR9ICeVgdw3Uuik4NPWHyZ
         QgfQ==
X-Gm-Message-State: AOAM531S59pMwuLXSNqEIgsnLM2xXwATWXt1LsMBnfTBl8jIo/LW1QIc
        Uu/LSSVjqhutHR9L28/+GEIwfuN8+UmV
X-Google-Smtp-Source: ABdhPJyq0QJAemFusQC0q/4zj0Vb7bL9euSjCVtdjrsQDcX3xMQppjf/IjihIc/YPmZix/QKMWqme2XAPhhn
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:71e4:80a2:2271:7fc7])
 (user=kyletso job=sendgmr) by 2002:a25:25c6:: with SMTP id
 l189mr8863683ybl.170.1629100496608; Mon, 16 Aug 2021 00:54:56 -0700 (PDT)
Date:   Mon, 16 Aug 2021 15:54:49 +0800
Message-Id: <20210816075449.2236547-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH] usb: typec: tcpm: Raise vdm_sm_running flag only when VDM SM
 is running
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the port is going to send Discover_Identity Message, vdm_sm_running
flag was intentionally set before entering Ready States in order to
avoid the conflict because the port and the port partner might start
AMS at almost the same time after entering Ready States.

However, the original design has a problem. When the port is doing
DR_SWAP from Device to Host, it raises the flag. Later in the
tcpm_send_discover_work, the flag blocks the procedure of sending the
Discover_Identity and it might never be cleared until disconnection.

Since there exists another flag send_discover representing that the port
is going to send Discover_Identity or not, it is enough to use that flag
to prevent the conflict. Also change the timing of the set/clear of
vdm_sm_running to indicate whether the VDM SM is actually running or
not.

Fixes: c34e85fa69b9 ("usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work")
Cc: Badhri Jagan Sridharan <badhri@google.com>
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 81 ++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5b22a1c931a9..c05ddfbaff08 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -341,6 +341,7 @@ struct tcpm_port {
 	bool vbus_source;
 	bool vbus_charge;
 
+	/* Set to true when Discover_Identity Command is expected to be sent in Ready states. */
 	bool send_discover;
 	bool op_vsafe5v;
 
@@ -370,6 +371,7 @@ struct tcpm_port {
 	struct hrtimer send_discover_timer;
 	struct kthread_work send_discover_work;
 	bool state_machine_running;
+	/* Set to true when VDM State Machine has following actions. */
 	bool vdm_sm_running;
 
 	struct completion tx_complete;
@@ -1431,6 +1433,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 	/* Set ready, vdm state machine will actually send */
 	port->vdm_retries = 0;
 	port->vdm_state = VDM_STATE_READY;
+	port->vdm_sm_running = true;
 
 	mod_vdm_delayed_work(port, 0);
 }
@@ -1673,7 +1676,6 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 				rlen = 1;
 			} else {
 				tcpm_register_partner_altmodes(port);
-				port->vdm_sm_running = false;
 			}
 			break;
 		case CMD_ENTER_MODE:
@@ -1721,14 +1723,12 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 				      (VDO_SVDM_VERS(svdm_version));
 			break;
 		}
-		port->vdm_sm_running = false;
 		break;
 	default:
 		response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
 		rlen = 1;
 		response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
 			      (VDO_SVDM_VERS(svdm_version));
-		port->vdm_sm_running = false;
 		break;
 	}
 
@@ -1765,6 +1765,20 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 	}
 
 	if (PD_VDO_SVDM(p[0])) {
+		/*
+		 * Here a SVDM is received (INIT or RSP or unknown). Set the vdm_sm_running in
+		 * advance because we are dropping the lock but may send VDMs soon.
+		 * For the cases of INIT received:
+		 *  - If no response to send, it will be cleared later in this function.
+		 *  - If there are responses to send, it will be cleared in the state machine.
+		 * For the cases of RSP received:
+		 *  - If no further INIT to send, it will be cleared later in this function.
+		 *  - Otherwise, it will be cleared in the state machine if timeout or it will go
+		 *    back here until no further INIT to send.
+		 * For the cases of unknown type received:
+		 *  - We will send NAK and the flag will be cleared in the state machine.
+		 */
+		port->vdm_sm_running = true;
 		rlen = tcpm_pd_svdm(port, adev, p, cnt, response, &adev_action);
 	} else {
 		if (port->negotiated_rev >= PD_REV30)
@@ -1833,6 +1847,8 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 
 	if (rlen > 0)
 		tcpm_queue_vdm(port, response[0], &response[1], rlen - 1);
+	else
+		port->vdm_sm_running = false;
 }
 
 static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
@@ -1898,8 +1914,10 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		 * if there's traffic or we're not in PDO ready state don't send
 		 * a VDM.
 		 */
-		if (port->state != SRC_READY && port->state != SNK_READY)
+		if (port->state != SRC_READY && port->state != SNK_READY) {
+			port->vdm_sm_running = false;
 			break;
+		}
 
 		/* TODO: AMS operation for Unstructured VDM */
 		if (PD_VDO_SVDM(vdo_hdr) && PD_VDO_CMDT(vdo_hdr) == CMDT_INIT) {
@@ -2555,10 +2573,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 								       TYPEC_PWR_MODE_PD,
 								       port->pps_data.active,
 								       port->supply_voltage);
-				/* Set VDM running flag ASAP */
-				if (port->data_role == TYPEC_HOST &&
-				    port->send_discover)
-					port->vdm_sm_running = true;
 				tcpm_set_state(port, SNK_READY, 0);
 			} else {
 				/*
@@ -2596,14 +2610,10 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
 			/* USB PD specification, Figure 8-43 */
-			if (port->explicit_contract) {
+			if (port->explicit_contract)
 				next_state = SNK_READY;
-				if (port->data_role == TYPEC_HOST &&
-				    port->send_discover)
-					port->vdm_sm_running = true;
-			} else {
+			else
 				next_state = SNK_WAIT_CAPABILITIES;
-			}
 
 			/* Threshold was relaxed before sending Request. Restore it back. */
 			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
@@ -2618,10 +2628,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			port->pps_status = (type == PD_CTRL_WAIT ?
 					    -EAGAIN : -EOPNOTSUPP);
 
-			if (port->data_role == TYPEC_HOST &&
-			    port->send_discover)
-				port->vdm_sm_running = true;
-
 			/* Threshold was relaxed before sending Request. Restore it back. */
 			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
 							       port->pps_data.active,
@@ -2697,10 +2703,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			}
 			break;
 		case DR_SWAP_SEND:
-			if (port->data_role == TYPEC_DEVICE &&
-			    port->send_discover)
-				port->vdm_sm_running = true;
-
 			tcpm_set_state(port, DR_SWAP_CHANGE_DR, 0);
 			break;
 		case PR_SWAP_SEND:
@@ -2738,7 +2740,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 					   PD_MSG_CTRL_NOT_SUPP,
 					   NONE_AMS);
 		} else {
-			if (port->vdm_sm_running) {
+			if (port->send_discover) {
 				tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
 				break;
 			}
@@ -2754,7 +2756,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 					   PD_MSG_CTRL_NOT_SUPP,
 					   NONE_AMS);
 		} else {
-			if (port->vdm_sm_running) {
+			if (port->send_discover) {
 				tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
 				break;
 			}
@@ -2763,7 +2765,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		}
 		break;
 	case PD_CTRL_VCONN_SWAP:
-		if (port->vdm_sm_running) {
+		if (port->send_discover) {
 			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
 			break;
 		}
@@ -4479,18 +4481,20 @@ static void run_state_machine(struct tcpm_port *port)
 	/* DR_Swap states */
 	case DR_SWAP_SEND:
 		tcpm_pd_send_control(port, PD_CTRL_DR_SWAP);
+		if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20)
+			port->send_discover = true;
 		tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
 				    PD_T_SENDER_RESPONSE);
 		break;
 	case DR_SWAP_ACCEPT:
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
-		/* Set VDM state machine running flag ASAP */
-		if (port->data_role == TYPEC_DEVICE && port->send_discover)
-			port->vdm_sm_running = true;
+		if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20)
+			port->send_discover = true;
 		tcpm_set_state_cond(port, DR_SWAP_CHANGE_DR, 0);
 		break;
 	case DR_SWAP_SEND_TIMEOUT:
 		tcpm_swap_complete(port, -ETIMEDOUT);
+		port->send_discover = false;
 		tcpm_ams_finish(port);
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
@@ -4502,7 +4506,6 @@ static void run_state_machine(struct tcpm_port *port)
 		} else {
 			tcpm_set_roles(port, true, port->pwr_role,
 				       TYPEC_HOST);
-			port->send_discover = true;
 		}
 		tcpm_ams_finish(port);
 		tcpm_set_state(port, ready_state(port), 0);
@@ -4645,8 +4648,6 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case VCONN_SWAP_SEND_TIMEOUT:
 		tcpm_swap_complete(port, -ETIMEDOUT);
-		if (port->data_role == TYPEC_HOST && port->send_discover)
-			port->vdm_sm_running = true;
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case VCONN_SWAP_START:
@@ -4662,14 +4663,10 @@ static void run_state_machine(struct tcpm_port *port)
 	case VCONN_SWAP_TURN_ON_VCONN:
 		tcpm_set_vconn(port, true);
 		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
-		if (port->data_role == TYPEC_HOST && port->send_discover)
-			port->vdm_sm_running = true;
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case VCONN_SWAP_TURN_OFF_VCONN:
 		tcpm_set_vconn(port, false);
-		if (port->data_role == TYPEC_HOST && port->send_discover)
-			port->vdm_sm_running = true;
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 
@@ -4677,8 +4674,6 @@ static void run_state_machine(struct tcpm_port *port)
 	case PR_SWAP_CANCEL:
 	case VCONN_SWAP_CANCEL:
 		tcpm_swap_complete(port, port->swap_status);
-		if (port->data_role == TYPEC_HOST && port->send_discover)
-			port->vdm_sm_running = true;
 		if (port->pwr_role == TYPEC_SOURCE)
 			tcpm_set_state(port, SRC_READY, 0);
 		else
@@ -5028,9 +5023,6 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 	switch (port->state) {
 	case SNK_TRANSITION_SINK_VBUS:
 		port->explicit_contract = true;
-		/* Set the VDM flag ASAP */
-		if (port->data_role == TYPEC_HOST && port->send_discover)
-			port->vdm_sm_running = true;
 		tcpm_set_state(port, SNK_READY, 0);
 		break;
 	case SNK_DISCOVERY:
@@ -5425,15 +5417,18 @@ static void tcpm_send_discover_work(struct kthread_work *work)
 	if (!port->send_discover)
 		goto unlock;
 
+	if (port->data_role == TYPEC_DEVICE && port->negotiated_rev < PD_REV30) {
+		port->send_discover = false;
+		goto unlock;
+	}
+
 	/* Retry if the port is not idle */
 	if ((port->state != SRC_READY && port->state != SNK_READY) || port->vdm_sm_running) {
 		mod_send_discover_delayed_work(port, SEND_DISCOVER_RETRY_MS);
 		goto unlock;
 	}
 
-	/* Only send the Message if the port is host for PD rev2.0 */
-	if (port->data_role == TYPEC_HOST || port->negotiated_rev > PD_REV20)
-		tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
+	tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
 
 unlock:
 	mutex_unlock(&port->lock);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

