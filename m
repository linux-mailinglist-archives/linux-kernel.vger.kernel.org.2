Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6F30A4B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhBAJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhBAJxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:53:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413D9C061574
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:53:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f127so18909753ybf.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=w3O3/2zqeTmsdJyNuY/T8kp88eScwBpknYzFYt5yJ8A=;
        b=HiTjVg/Gqq+aRDAg+MYk5NmLL2nxjRFKGc2XBBtahjZYD5q9kHsFGtd2Fg3F5PmjqY
         xcKp487Eqb4YPUuwPiZpNgOaOvFwudu5/m/+xI1QGHPC4/oqDGkmoT5gmVkUppnMQykx
         wHMesmpauYemNpIxCd0fbwfUE28etVv+ghUryRAyDVxMrQhuY9oXz38zbdLVf2tVIRSs
         Mea+zeCo8Xl0fOg7Wu9FDiFu0K40J8LTjZYuQ02yXo1jS92shLsi8e+YLBcNZBYse/3R
         M6fa1MXVVklHQ0eV9NAEOBAVlKUFNpZPkE2qRJvUSc06DJ6vAMCfKbirCnVu/JJK/hIH
         9T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=w3O3/2zqeTmsdJyNuY/T8kp88eScwBpknYzFYt5yJ8A=;
        b=B/uDIn71hSE7C79tYTEVSLuVgQXE2RZiqSp0CtkKJOAudNhp6gQZ6lidkx2qjl1MxL
         QStqkfytzLsx2leOaKiRkZZZM2+ZhGnB1TqoOise9cU9830Lek1W+VKcZTg+wU92oYxn
         Yb5b/lA3KksudkJUeMOtvZSKrCSx8PNntgkdQ4i62M0qaAtNLc9lxtQXXKXlMEYUnH76
         +2pOyadwTcsNggmGfkrWtR+P4TEZqxlJWSNs5O0szaZ/sxoloJxcXtWlos2Ma+zzzvT4
         Bao/UVDIo4TJLbvc3NNlvi6TnPGhMIACDU4ILLSQlqK8FnTPKyxQn4Tl6HPeXQOAv5f3
         HLFQ==
X-Gm-Message-State: AOAM531FOaAcDQj4sEtySyMWFfZJiBjn/bFB/DatKFidUwF5Jb+zKVGZ
        v9Iwq5Z2Ggv7YpVgvWNCoOa8yG6qp24=
X-Google-Smtp-Source: ABdhPJzoUc/DBefRkwvuujOn6QjOhOtxFBQmHNSiMa2FSHliFCgBVtwoubGO7pDG9E/0COhE5bDgeMDoV2w=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:a4ea:: with SMTP id g97mr23935040ybi.286.1612173194351;
 Mon, 01 Feb 2021 01:53:14 -0800 (PST)
Date:   Mon,  1 Feb 2021 01:53:07 -0800
Message-Id: <20210201095309.39486-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v1 1/3] usb: typec: tcpm: Add Callback to Usb Communication
 capable partner
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB Communications Capable bit indicates if port
partner is capable of communication over the USB data lines
(e.g. D+/- or SS Tx/Rx). Notify the status of the bit to low
level drivers to perform chip specific operation.
For instance, low level driver enables USB switches on D+/D-
lines to set up data path when the bit is set.

Refactored from patch initially authored by
Kyle Tso <kyletso@google.com>

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 16 ++++++++++++++++
 include/linux/usb/tcpm.h      |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0afd8ef692e8..96190b4d46a7 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -298,6 +298,7 @@ struct tcpm_port {
 	struct usb_pd_identity partner_ident;
 	struct typec_partner_desc partner_desc;
 	struct typec_partner *partner;
+	bool partner_usb_comm_capable;
 
 	enum typec_cc_status cc_req;
 
@@ -3429,6 +3430,16 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
 	memset(modep, 0, sizeof(*modep));
 }
 
+static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, bool capable)
+{
+	tcpm_log(port, "Setting usb_comm capable %s", capable ? "true" : "false");
+
+	if (port->tcpc->set_partner_usb_comm_capable)
+		port->tcpc->set_partner_usb_comm_capable(port->tcpc, capable);
+
+	port->partner_usb_comm_capable = capable;
+}
+
 static void tcpm_reset_port(struct tcpm_port *port)
 {
 	int ret;
@@ -3445,6 +3456,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->attached = false;
 	port->pd_capable = false;
 	port->pps_data.supported = false;
+	tcpm_set_partner_usb_comm_capable(port, false);
 
 	/*
 	 * First Rx ID should be 0; set this to a sentinel of -1 so that
@@ -3785,6 +3797,8 @@ static void run_state_machine(struct tcpm_port *port)
 			}
 		} else {
 			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+			port->partner_usb_comm_capable = port->sink_request & RDO_USB_COMM;
+			tcpm_set_partner_usb_comm_capable(port, port->partner_usb_comm_capable);
 			tcpm_set_state(port, SRC_TRANSITION_SUPPLY,
 				       PD_T_SRC_TRANSITION);
 		}
@@ -4004,6 +4018,8 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_NEGOTIATE_CAPABILITIES:
 		port->pd_capable = true;
+		port->partner_usb_comm_capable = port->sink_request & RDO_USB_COMM;
+		tcpm_set_partner_usb_comm_capable(port, port->partner_usb_comm_capable);
 		port->hard_reset_count = 0;
 		ret = tcpm_pd_send_request(port);
 		if (ret < 0) {
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 3af99f85e8b9..42fcfbe10590 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -108,6 +108,10 @@ enum tcpm_transmit_type {
  *		is supported by TCPC, set this callback for TCPM to query
  *		whether vbus is at VSAFE0V when needed.
  *		Returns true when vbus is at VSAFE0V, false otherwise.
+ * @set_partner_usb_comm_capable:
+ *              Optional; The USB Communications Capable bit indicates if port
+ *              partner is capable of communication over the USB data lines
+ *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -139,6 +143,7 @@ struct tcpc_dev {
 	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
 						 bool pps_active, u32 requested_vbus_voltage);
 	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
+	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
 };
 
 struct tcpm_port;
-- 
2.30.0.365.g02bc693789-goog

