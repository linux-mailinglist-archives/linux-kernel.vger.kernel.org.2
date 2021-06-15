Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BD43A78C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFOIK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhFOIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:10:28 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550DBC061767
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 01:08:24 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u6-20020ae9c0060000b02903ab0c9eea47so10453038qkk.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xko18XrkHCXyBpt3ikk2FzLxgxz09i1sjsAXmFoqAg8=;
        b=ZwOfOF+lojUQNA/GX+u/2y/DqRDUhJ/cyJhFAYsEnUZbMfZHh1kUvbi7KwZEQGVH/k
         2Gh6FzB/Mb+R8b8bqTyRIVXTPVPrzHhxTNhZ1P2aFBkxtjdbFpKhahG1DA5pGqiJgoMs
         WGwY32aQzgJJbtqqhHbti1002tpwQkd4Oa8aX8Q9bYl8s4XkD4IaoaGK7RIUdhV6K6jM
         V6KpfawAyLuxxuDpPyJLvcZgVOYWv+mvA1uIw/tIdfY5TdNQLijqdghA7kttCAxyuz2B
         qJ6LrZj5NI04+L6tnI1w6q/1tXJgoRV2U7P+2jGe7fopLXyKX85twd63CFmN0WaJm0V9
         iebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xko18XrkHCXyBpt3ikk2FzLxgxz09i1sjsAXmFoqAg8=;
        b=geYt7x5KMubTeViLdw7sInaGxgLRqT+Y6zSAvqLc2f3xVsyxRAykIiy0/zn6omT63m
         cAkPS/zdqFYq2mNMQghb4aySy2XB+Bl+OlLb34gKli5f7wxhGOoWFN4b+QCdUgGAPova
         iiOy/+XY7vwiedAjyot3CIK3y8RI0Xd6AqaLZZwGBgrSiYqy9GRqAN0IszrUHp3f4s00
         hKkSZgeMjgHzREp0QRDR9Cpi0aAK0BU7ghdAUjz/PbbQbM22Gh4eIRgwF71e32f+IUAc
         NwYsriG9nybeqNJpFgfq50Pg6hzuhQzK71KIxk8/cf9PqNSAJwVdhNpdVvYru+w0QtX9
         TRjw==
X-Gm-Message-State: AOAM532lSQe5bJzQDnq5sHEXi7EWPcCuIeiGe/QCZ8k+BQd52K1Q054V
        pIOWRELH0WMsFDSpYzN9W4hDgWEVean4
X-Google-Smtp-Source: ABdhPJyVMnRA5ytRx64mTu898yu2g7uTBAo97G8Qqb67gMkWxkJGCQGy/3livtEFX8GllYgLX6MQXR9HKorJ
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:4b55:a2ec:54ae:3682])
 (user=kyletso job=sendgmr) by 2002:a05:6214:240b:: with SMTP id
 fv11mr3794398qvb.23.1623744503359; Tue, 15 Jun 2021 01:08:23 -0700 (PDT)
Date:   Tue, 15 Jun 2021 16:08:17 +0800
Message-Id: <20210615080817.1417169-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2] usb: typec: tcpm: Relax disconnect threshold during power negotiation
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
PS_RDY. For non-PPS negotiation, relax the disconnect threshold on Sink
after receiving Accept Message to ensure the relaxed setting is enabled
before the voltage collapse. For PPS, relax the threshold before
sending Request Message so that it will not race with Source which
begins to adjust the voltage right after it sends Accept Message.

The real threshold will be set after Sink receives PS_RDY Message.

Fixes: f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
Cc: Badhri Jagan Sridharan <badhri@google.com>
Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v1:
- move the timing of setting threshold up to "before sending Request"
  for PPS power negotiation so that it won't race with the Source.
- PPS: if it fails to send the Request, fallback to previous threshold
- PPS: if the Source doesn't respond Accept, fallback to previous
  threshold
- update the commit message for above changes

 drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0db685d5d9c0..00f3fd7c05d6 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2599,6 +2599,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
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
@@ -2646,6 +2651,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
 			port->pps_data.active = false;
+			/* Voltage is going to be at new level. Relax the threshold here. */
+			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
 		case SNK_NEGOTIATE_PPS_CAPABILITIES:
@@ -3423,6 +3430,9 @@ static int tcpm_pd_send_pps_request(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
+	/* Relax the threshold as voltage will be adjusted right after Accept Message. */
+	tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
+
 	memset(&msg, 0, sizeof(msg));
 	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
 				  port->pwr_role,
@@ -4196,6 +4206,10 @@ static void run_state_machine(struct tcpm_port *port)
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

