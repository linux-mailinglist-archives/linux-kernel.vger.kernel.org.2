Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EC33A9576
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhFPJDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFPJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:03:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E18C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:01:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r5-20020a2582850000b02905381b1b616eso1949895ybk.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3M0UKlv9SOpLXUL9qCPgM2BG4Do5o9apkVkW/TG2GZY=;
        b=XUUaWCKmiuW4vDogg4QoHBx8qvu2ygQ5gyuUydllq4h5NX0BZFN3ZgFb/opCPL9Haq
         JWmayPho/GZFgz9Da110xPx/UXrlBT/2W80DWm3Lb8pmJ0ODrvmwwwRmPVEF/2XuLb+E
         sJImWCIX0ilq5YpZFF1sRelBfRbtaOlp30NwzxS1BwxWOazp3oZGGxBKJR8F+/rrv6dy
         2bsAvAVWCAXPDokwd7GHCN+4rRJLH4qOMXEan6oF8RrxSaTv0wm7OimbmFCtvHHvTWxY
         9oEAshM/jUwG3Mfi4n7EluXJhOXsl4KY7JAIsTfypH9Et8TubFZwwLGdxGGKCcQPk0JR
         YNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3M0UKlv9SOpLXUL9qCPgM2BG4Do5o9apkVkW/TG2GZY=;
        b=A7U3E+XaS3ZyTbLV0rOptFS2HWr0oupkv1E535TjgHxxQZKCwzQnDbBVWXIvoYf81X
         iY2nNF1BNkqFiF4ErKJJsg1ixTvclxdi4cHrjAsqJeMRR3X2hWyM5fZ3Zzhm4uCB86J3
         ESRljlhqKCvf8MIPTlbEhlwPTQTuBub1PZsIwMvK88TlSRk3zDlq0witOIbgegzEoXG1
         mR+2StGz5Xch4sfpir5bpsFxy2J3FNWmQ3HCSORydycrsbPXYHfHNlCgl4jDOzRcia0r
         hq/1KBSpmwTPh6xaNcyKR50SnDa89c0tKT2MHngyx0C0pe+nJOVNmkAD0hn0hRpUu62O
         dd4Q==
X-Gm-Message-State: AOAM5314YxmbIrdVj/H3VmmGgur3YfbSIkvrE1b9Y9Tmh08ZddR2S+JP
        +LK92kkPJ/cWw7NZJ8IZxFLOaXbHFkOe
X-Google-Smtp-Source: ABdhPJwng0J1nrvO5rVrzAydm5TO3Oi6kIALs3pguNbRP6QqiQuA2oZhFG6nu3vAmNLpZ4Br5VgOMwi/Ic6Q
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:490b:5c68:72a5:d6d7])
 (user=kyletso job=sendgmr) by 2002:a25:9bc4:: with SMTP id
 w4mr4516910ybo.168.1623834067902; Wed, 16 Jun 2021 02:01:07 -0700 (PDT)
Date:   Wed, 16 Jun 2021 17:01:02 +0800
Message-Id: <20210616090102.1897674-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v3] usb: typec: tcpm: Relax disconnect threshold during power negotiation
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the voltage is being decreased in power negotiation, the Source will
set the power supply to operate at the new voltage level before sending
PS_RDY. Relax the threshold before sending Request Message so that it
will not race with Source which begins to adjust the voltage right after
it sends Accept Message (PPS) or tSrcTransition (25~35ms) after it sends
Accept Message (non-PPS).

The real threshold will be set after Sink receives PS_RDY Message.

Fixes: f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
Cc: Badhri Jagan Sridharan <badhri@google.com>
Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes in v3:
- move the timing of setting threshold for Fixed RDO as I did for PPS in
  v2, i.e. move it to tcpm_pd_send_request.
- add Cc: tag for Badhri
- update the commit message for the above changes

Changes in v2:
- move the timing of setting threshold up to "before sending Request"
  for PPS power negotiation so that it won't race with the Source.
- PPS: if it fails to send the Request, fallback to previous threshold
- PPS: if the Source doesn't respond Accept, fallback to previous
  threshold
- update the commit message for above changes

 drivers/usb/typec/tcpm/tcpm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 197556038ba4..b1d310ab84c4 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2604,6 +2604,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			} else {
 				next_state = SNK_WAIT_CAPABILITIES;
 			}
+
+			/* Threshold was relaxed before sending Request. Restore it back. */
+			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
+							       port->pps_data.active,
+							       port->supply_voltage);
 			tcpm_set_state(port, next_state, 0);
 			break;
 		case SNK_NEGOTIATE_PPS_CAPABILITIES:
@@ -2617,6 +2622,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			    port->send_discover)
 				port->vdm_sm_running = true;
 
+			/* Threshold was relaxed before sending Request. Restore it back. */
+			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
+							       port->pps_data.active,
+							       port->supply_voltage);
+
 			tcpm_set_state(port, SNK_READY, 0);
 			break;
 		case DR_SWAP_SEND:
@@ -3336,6 +3346,12 @@ static int tcpm_pd_send_request(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Relax the threshold as voltage will be adjusted after Accept Message plus tSrcTransition.
+	 * It is safer to modify the threshold here.
+	 */
+	tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
+
 	memset(&msg, 0, sizeof(msg));
 	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
 				  port->pwr_role,
@@ -3433,6 +3449,9 @@ static int tcpm_pd_send_pps_request(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
+	/* Relax the threshold as voltage will be adjusted right after Accept Message. */
+	tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
+
 	memset(&msg, 0, sizeof(msg));
 	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
 				  port->pwr_role,
@@ -4196,6 +4215,10 @@ static void run_state_machine(struct tcpm_port *port)
 		port->hard_reset_count = 0;
 		ret = tcpm_pd_send_request(port);
 		if (ret < 0) {
+			/* Restore back to the original state */
+			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
+							       port->pps_data.active,
+							       port->supply_voltage);
 			/* Let the Source send capabilities again. */
 			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
 		} else {
@@ -4206,6 +4229,10 @@ static void run_state_machine(struct tcpm_port *port)
 	case SNK_NEGOTIATE_PPS_CAPABILITIES:
 		ret = tcpm_pd_send_pps_request(port);
 		if (ret < 0) {
+			/* Restore back to the original state */
+			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
+							       port->pps_data.active,
+							       port->supply_voltage);
 			port->pps_status = ret;
 			/*
 			 * If this was called due to updates to sink
-- 
2.32.0.272.g935e593368-goog

