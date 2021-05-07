Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9A037602E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhEGGYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhEGGYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:24:10 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F82C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 23:23:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id m7-20020a6545c70000b029020f6af21c77so4796400pgr.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 23:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CAdpc8uV82KrHrWTg/h8bFG11oNTJ3L3pZ5aH8DIgW0=;
        b=JWFbgm3ZYE75AVcrX2V748w9kWED0hI5OevFmn9dFBXIxMwCe1Fx9mdr4/Q1A1tcDe
         k5gj1Zbm0HjIwRl+paAa4wK6e3Xx+5/JMCdyDsmMNhPAGQwWsqcNs0R+RjKtDaGsgFlk
         rU3mXc83rHOfKxlmud1STNLP7xWLoP6yy3Ek88p99lRtCWE29lpIzkxiyh8FgzBudQdn
         zwcobDCCOKIxkmO4FTSSTbWwBH9AvgY4DVLTNCWx4UD1MhbQN/S9rNKMymXIm3p29etS
         c9U+N+rt6nI+PuU2ra4W+BlSdsauXqmI5vOUPfOjFCGZu4XLoD9noxk9FNeILbz0yTP/
         TKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CAdpc8uV82KrHrWTg/h8bFG11oNTJ3L3pZ5aH8DIgW0=;
        b=LHYKNwT3VBa6OQMIDJctE7piZyI+SrPhMYENS+6FsHeUVcis9BGtYHdLDK4K80Kc0n
         InABsn0f9kDLt2voH9471+vcUBWdCbOEqRPPPir/riEU/yznnc/lUbPGQAVx+v/bLWgx
         BMsLGMZZk9P/wrFXLsEYdbxvLcoPaftEvB/whvHXRQGasKWGlvmtF7QfmbOvKyvn8u10
         4yCYf/vUwIqG3OJr3Tr7z6bVdBGt9a+BqdJf6DXhSMEYL09D3l6CrZO92Lj2IQpAqHvw
         t7AhyehobXsUV3hBIGP51T2ZSgAPEmqb9wUvOBf0e6PUy34agiLh5CACe4RzsPSXFSN8
         QI2w==
X-Gm-Message-State: AOAM530QCYcuXPAVTj3RtWMZMAKN4mdpXwPci20u3dgCUfh+dWGmyz/9
        rfIn1O2NivDytWArBqTY9OZpdaMvMHRO
X-Google-Smtp-Source: ABdhPJxxUzUnDwfpShSXP9Sn9aXJUvCyX9YH14rEuGDb4vNxrCcra/N4cyg4a9OHEQL9Z5PDxivDte3osuAR
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:9a5c:8de0:4c79:ba52])
 (user=kyletso job=sendgmr) by 2002:a17:90a:c7c8:: with SMTP id
 gf8mr21692067pjb.113.1620368590221; Thu, 06 May 2021 23:23:10 -0700 (PDT)
Date:   Fri,  7 May 2021 14:22:59 +0800
In-Reply-To: <20210507062300.1945009-1-kyletso@google.com>
Message-Id: <20210507062300.1945009-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210507062300.1945009-1-kyletso@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v3 1/2] usb: typec: tcpm: Send DISCOVER_IDENTITY from
 dedicated work
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current design, DISCOVER_IDENTITY is queued to VDM state machine
immediately in Ready states and never retries if it fails in the AMS.
Move the process to a delayed work so that when it fails for some
reasons (e.g. Sink Tx No Go), it can be retried by queueing the work
again. Also fix a problem that the vdm_state is not set to a proper
state if it is blocked by Collision Avoidance mechanism.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v2:
- no code changes
- add "Reviewed-by:" and "Acked-by:" from v1 mail thread

 drivers/usb/typec/tcpm/tcpm.c | 85 ++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c4fdc00a3bc8..07a449f0e8fa 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -259,6 +259,7 @@ enum frs_typec_current {
 #define ALTMODE_DISCOVERY_MAX	(SVID_DISCOVERY_MAX * MODE_DISCOVERY_MAX)
 
 #define GET_SINK_CAP_RETRY_MS	100
+#define SEND_DISCOVER_RETRY_MS	100
 
 struct pd_mode_data {
 	int svid_index;		/* current SVID index		*/
@@ -366,6 +367,8 @@ struct tcpm_port {
 	struct kthread_work vdm_state_machine;
 	struct hrtimer enable_frs_timer;
 	struct kthread_work enable_frs;
+	struct hrtimer send_discover_timer;
+	struct kthread_work send_discover_work;
 	bool state_machine_running;
 	bool vdm_sm_running;
 
@@ -1178,6 +1181,16 @@ static void mod_enable_frs_delayed_work(struct tcpm_port *port, unsigned int del
 	}
 }
 
+static void mod_send_discover_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
+{
+	if (delay_ms) {
+		hrtimer_start(&port->send_discover_timer, ms_to_ktime(delay_ms), HRTIMER_MODE_REL);
+	} else {
+		hrtimer_cancel(&port->send_discover_timer);
+		kthread_queue_work(port->wq, &port->send_discover_work);
+	}
+}
+
 static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
 			   unsigned int delay_ms)
 {
@@ -1855,6 +1868,9 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 				res = tcpm_ams_start(port, DISCOVER_IDENTITY);
 				if (res == 0)
 					port->send_discover = false;
+				else if (res == -EAGAIN)
+					mod_send_discover_delayed_work(port,
+								       SEND_DISCOVER_RETRY_MS);
 				break;
 			case CMD_DISCOVER_SVID:
 				res = tcpm_ams_start(port, DISCOVER_SVIDS);
@@ -1880,6 +1896,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 			}
 
 			if (res < 0) {
+				port->vdm_state = VDM_STATE_ERR_BUSY;
 				port->vdm_sm_running = false;
 				return;
 			}
@@ -3682,14 +3699,6 @@ static inline enum tcpm_state unattached_state(struct tcpm_port *port)
 	return SNK_UNATTACHED;
 }
 
-static void tcpm_check_send_discover(struct tcpm_port *port)
-{
-	if ((port->data_role == TYPEC_HOST || port->negotiated_rev > PD_REV20) &&
-	    port->send_discover && port->pd_capable)
-		tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
-	port->send_discover = false;
-}
-
 static void tcpm_swap_complete(struct tcpm_port *port, int result)
 {
 	if (port->swap_pending) {
@@ -3926,7 +3935,18 @@ static void run_state_machine(struct tcpm_port *port)
 			break;
 		}
 
-		tcpm_check_send_discover(port);
+		/*
+		 * 6.4.4.3.1 Discover Identity
+		 * "The Discover Identity Command Shall only be sent to SOP when there is an
+		 * Explicit Contract."
+		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
+		 * port->explicit_contract to decide whether to send the command.
+		 */
+		if (port->explicit_contract)
+			mod_send_discover_delayed_work(port, 0);
+		else
+			port->send_discover = false;
+
 		/*
 		 * 6.3.5
 		 * Sending ping messages is not necessary if
@@ -4194,7 +4214,18 @@ static void run_state_machine(struct tcpm_port *port)
 			break;
 		}
 
-		tcpm_check_send_discover(port);
+		/*
+		 * 6.4.4.3.1 Discover Identity
+		 * "The Discover Identity Command Shall only be sent to SOP when there is an
+		 * Explicit Contract."
+		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
+		 * port->explicit_contract.
+		 */
+		if (port->explicit_contract)
+			mod_send_discover_delayed_work(port, 0);
+		else
+			port->send_discover = false;
+
 		power_supply_changed(port->psy);
 		break;
 
@@ -5288,6 +5319,29 @@ static void tcpm_enable_frs_work(struct kthread_work *work)
 	mutex_unlock(&port->lock);
 }
 
+static void tcpm_send_discover_work(struct kthread_work *work)
+{
+	struct tcpm_port *port = container_of(work, struct tcpm_port, send_discover_work);
+
+	mutex_lock(&port->lock);
+	/* No need to send DISCOVER_IDENTITY anymore */
+	if (!port->send_discover)
+		goto unlock;
+
+	/* Retry if the port is not idle */
+	if ((port->state != SRC_READY && port->state != SNK_READY) || port->vdm_sm_running) {
+		mod_send_discover_delayed_work(port, SEND_DISCOVER_RETRY_MS);
+		goto unlock;
+	}
+
+	/* Only send the Message if the port is host for PD rev2.0 */
+	if (port->data_role == TYPEC_HOST || port->negotiated_rev > PD_REV20)
+		tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
+
+unlock:
+	mutex_unlock(&port->lock);
+}
+
 static int tcpm_dr_set(struct typec_port *p, enum typec_data_role data)
 {
 	struct tcpm_port *port = typec_get_drvdata(p);
@@ -6093,6 +6147,14 @@ static enum hrtimer_restart enable_frs_timer_handler(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+static enum hrtimer_restart send_discover_timer_handler(struct hrtimer *timer)
+{
+	struct tcpm_port *port = container_of(timer, struct tcpm_port, send_discover_timer);
+
+	kthread_queue_work(port->wq, &port->send_discover_work);
+	return HRTIMER_NORESTART;
+}
+
 struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 {
 	struct tcpm_port *port;
@@ -6123,12 +6185,15 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	kthread_init_work(&port->vdm_state_machine, vdm_state_machine_work);
 	kthread_init_work(&port->event_work, tcpm_pd_event_handler);
 	kthread_init_work(&port->enable_frs, tcpm_enable_frs_work);
+	kthread_init_work(&port->send_discover_work, tcpm_send_discover_work);
 	hrtimer_init(&port->state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	port->state_machine_timer.function = state_machine_timer_handler;
 	hrtimer_init(&port->vdm_state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	port->vdm_state_machine_timer.function = vdm_state_machine_timer_handler;
 	hrtimer_init(&port->enable_frs_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	port->enable_frs_timer.function = enable_frs_timer_handler;
+	hrtimer_init(&port->send_discover_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	port->send_discover_timer.function = send_discover_timer_handler;
 
 	spin_lock_init(&port->pd_event_lock);
 
-- 
2.31.1.527.g47e6f16901-goog

