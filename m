Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A93D797A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhG0PNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbhG0PNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:13:20 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EDBC061765
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 08:13:20 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j22-20020a17090a7e96b0290175fc969950so3514055pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hbGtnsIAzxr6tiUv7BNyp1DfTM1V3RQ/gpLoDyjw7h4=;
        b=OGR/DHizIFvoeZavNRaqUL3+y6L8WzeRBOOndgl94sRCYx59qK5N8gKk5UGXPfvlTG
         95Fc2/3UG+z44lAP+rT0lwvdt2WeY32EAIi8dASfF1aKa132+zgsH+8z5toBU9/Dfhjx
         PChqutqyOYmVt8vLxPzvpGxnAEdeJ3QCJ8JYFYwB5RGXZJi1xGEk/suySvTGmGfiZTxv
         bf1dZwM7wTTfQPy3s3yc1Hh+exw8oV1dqP94JvaYwRVOyGZjlSkpxcaEhT+YViQNtUHt
         hjjR9HiO56iggvMM11Oxdqo3uP9iRc6/6p6MHNxYRZpLs19IX6DqzXRJEYUBpBHeq+Qi
         Dnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hbGtnsIAzxr6tiUv7BNyp1DfTM1V3RQ/gpLoDyjw7h4=;
        b=XTEQJuEGLhHWIChpfZFHxZbgkoS8CVyrLfnYyKrwV1SLcrSckyMxzxY/Wvxzf5RBpz
         ReWBO5GuxyosopqJumT42g90PU7a05JdXkhZDbwxOlnJz6+AQ+LKGTXwV7YiVWXxh2Bn
         jlyMOKYiRP85ng2MevLv9HxDocKcguM9kbo+w520Odf2ZubEPV7ad4MS8v0wHoy9eCGy
         SWztQrz0+jfpPSFgwiZBsjS9buvkk1gI/CVVCCfxwYv9w9L34fgv7PwOzxovpSqta+nD
         kZL0XNEtLxj0hS69bXPqUMyOBQDqdhKYE00dtM8vTqgQ7f+mx1QwNfS4306Yb3w6iQdF
         ppAg==
X-Gm-Message-State: AOAM532sbbwRFZOCdRGImWCBrorZH4rZdpYMEUByu6ATTGVgIML8E56X
        S7fc6bfyOEvaktWwvj6G/M4hlY6vp1T0
X-Google-Smtp-Source: ABdhPJy4bCselEXuoX3UVrzUMZ4jb0x8Kpqxznmzuac+GSP2eSARHKtIDNWX+CY+F1M3jT7SXdzTEMJJCr6u
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:da7f:a21b:ee74:66a2])
 (user=kyletso job=sendgmr) by 2002:a17:90b:3556:: with SMTP id
 lt22mr4848786pjb.174.1627398799814; Tue, 27 Jul 2021 08:13:19 -0700 (PDT)
Date:   Tue, 27 Jul 2021 23:13:07 +0800
In-Reply-To: <20210727151307.2178352-1-kyletso@google.com>
Message-Id: <20210727151307.2178352-3-kyletso@google.com>
Mime-Version: 1.0
References: <20210727151307.2178352-1-kyletso@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 2/2] usb: typec: tcpm: Support non-PD mode
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if the Type-C controller supports PD, it is doable to disable PD
capabilities with the current state machine in TCPM. Without enabling RX
in low-level drivers and with skipping the power negotiation, the port
is eligible to be a non-PD Type-C port. Use new flags whose values are
populated from the device tree to decide the port PD capability. Adding
"pd-supported" property in device tree indicates that the port supports
PD. If "pd-supported" is not found, "typec-power-opmode" shall be added
to specify the advertised Rp value if the port supports SRC role.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
changes since v1:
- Revised the patch to use dt properties
- Added back the checks of callbacks set_pd_rx and pd_transmit
- Added src_rp to indicate which Rp value should be used in SRC. This
  variable is derived from dt property "typec-power-opmode"

 drivers/usb/typec/tcpm/tcpm.c | 108 +++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5b22a1c931a9..4cf77c787f54 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -316,6 +316,7 @@ struct tcpm_port {
 	struct typec_partner *partner;
 
 	enum typec_cc_status cc_req;
+	enum typec_cc_status src_rp;	/* work only if pd_supported == false */
 
 	enum typec_cc_status cc1;
 	enum typec_cc_status cc2;
@@ -323,6 +324,7 @@ struct tcpm_port {
 
 	bool attached;
 	bool connected;
+	bool pd_supported;
 	enum typec_port_type port_type;
 
 	/*
@@ -804,6 +806,7 @@ static void tcpm_apply_rc(struct tcpm_port *port)
 	}
 }
 
+
 /*
  * Determine RP value to set based on maximum current supported
  * by a port if configured as source.
@@ -815,6 +818,9 @@ static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port)
 	int nr_pdo = port->nr_src_pdo;
 	int i;
 
+	if (!port->pd_supported)
+		return port->src_rp;
+
 	/*
 	 * Search for first entry with matching voltage.
 	 * It should report the maximum supported current.
@@ -3568,9 +3574,11 @@ static int tcpm_src_attach(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
-	ret = port->tcpc->set_pd_rx(port->tcpc, true);
-	if (ret < 0)
-		goto out_disable_mux;
+	if (port->pd_supported) {
+		ret = port->tcpc->set_pd_rx(port->tcpc, true);
+		if (ret < 0)
+			goto out_disable_mux;
+	}
 
 	/*
 	 * USB Type-C specification, version 1.2,
@@ -3600,7 +3608,8 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_vconn:
 	tcpm_set_vconn(port, false);
 out_disable_pd:
-	port->tcpc->set_pd_rx(port->tcpc, false);
+	if (port->pd_supported)
+		port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
 	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
@@ -3804,6 +3813,20 @@ static enum typec_pwr_opmode tcpm_get_pwr_opmode(enum typec_cc_status cc)
 	}
 }
 
+static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
+{
+	switch (opmode) {
+	case TYPEC_PWR_MODE_USB:
+		return TYPEC_CC_RP_DEF;
+	case TYPEC_PWR_MODE_1_5A:
+		return TYPEC_CC_RP_1_5;
+	case TYPEC_PWR_MODE_3_0A:
+	case TYPEC_PWR_MODE_PD:
+	default:
+		return TYPEC_CC_RP_3_0;
+	}
+}
+
 static void run_state_machine(struct tcpm_port *port)
 {
 	int ret;
@@ -3914,6 +3937,10 @@ static void run_state_machine(struct tcpm_port *port)
 		if (port->ams == POWER_ROLE_SWAP ||
 		    port->ams == FAST_ROLE_SWAP)
 			tcpm_ams_finish(port);
+		if (!port->pd_supported) {
+			tcpm_set_state(port, SRC_READY, 0);
+			break;
+		}
 		port->upcoming_state = SRC_SEND_CAPABILITIES;
 		tcpm_ams_start(port, POWER_NEGOTIATION);
 		break;
@@ -4161,7 +4188,10 @@ static void run_state_machine(struct tcpm_port *port)
 				current_lim = PD_P_SNK_STDBY_MW / 5;
 			tcpm_set_current_limit(port, current_lim, 5000);
 			tcpm_set_charge(port, true);
-			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
+			if (!port->pd_supported)
+				tcpm_set_state(port, SNK_READY, 0);
+			else
+				tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
 			break;
 		}
 		/*
@@ -4389,7 +4419,8 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_vbus(port, true);
 		if (port->ams == HARD_RESET)
 			tcpm_ams_finish(port);
-		port->tcpc->set_pd_rx(port->tcpc, true);
+		if (port->pd_supported)
+			port->tcpc->set_pd_rx(port->tcpc, true);
 		tcpm_set_attached_state(port, true);
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
@@ -5898,6 +5929,7 @@ EXPORT_SYMBOL_GPL(tcpm_tcpc_reset);
 static int tcpm_fw_get_caps(struct tcpm_port *port,
 			    struct fwnode_handle *fwnode)
 {
+	const char *opmode_str;
 	const char *cap_str;
 	int ret;
 	u32 mw, frs_current;
@@ -5932,22 +5964,36 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		return ret;
 	port->typec_caps.type = ret;
 	port->port_type = port->typec_caps.type;
+	port->pd_supported = fwnode_property_read_bool(fwnode, "pd-supported");
 
 	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
 	if (port->port_type == TYPEC_PORT_SNK)
 		goto sink;
 
 	/* Get source pdos */
-	ret = fwnode_property_count_u32(fwnode, "source-pdos");
-	if (ret <= 0)
-		return -EINVAL;
+	if (port->pd_supported) {
+		ret = fwnode_property_count_u32(fwnode, "source-pdos");
+		if (ret <= 0)
+			return -EINVAL;
 
-	port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
-	ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
-					     port->src_pdo, port->nr_src_pdo);
-	if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
-					    port->nr_src_pdo))
-		return -EINVAL;
+		port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
+		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
+						     port->src_pdo, port->nr_src_pdo);
+		if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
+						    port->nr_src_pdo))
+			return -EINVAL;
+	} else {
+		port->nr_src_pdo = 0;
+		ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &opmode_str);
+		if (ret == 0) {
+			ret = typec_find_pwr_opmode(opmode_str);
+			if (ret < 0)
+				return ret;
+			port->src_rp = tcpm_pwr_opmode_to_rp(ret);
+		} else {
+			return ret;
+		}
+	}
 
 	if (port->port_type == TYPEC_PORT_SRC)
 		return 0;
@@ -5962,25 +6008,29 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		return -EINVAL;
 sink:
 	/* Get sink pdos */
-	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
-	if (ret <= 0)
-		return -EINVAL;
+	if (port->pd_supported) {
+		ret = fwnode_property_count_u32(fwnode, "sink-pdos");
+		if (ret <= 0)
+			return -EINVAL;
 
-	port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
-	ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
-					     port->snk_pdo, port->nr_snk_pdo);
-	if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
-					    port->nr_snk_pdo))
-		return -EINVAL;
+		port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
+		ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
+						     port->snk_pdo, port->nr_snk_pdo);
+		if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
+						    port->nr_snk_pdo))
+			return -EINVAL;
 
-	if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
-		return -EINVAL;
-	port->operating_snk_mw = mw / 1000;
+		if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
+			return -EINVAL;
+		port->operating_snk_mw = mw / 1000;
+	} else {
+		port->nr_snk_pdo = 0;
+	}
 
 	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
 
-	/* FRS can only be supported byb DRP ports */
-	if (port->port_type == TYPEC_PORT_DRP) {
+	/* FRS can only be supported by DRP ports */
+	if (port->port_type == TYPEC_PORT_DRP && port->pd_supported) {
 		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
 					       &frs_current);
 		if (ret >= 0 && frs_current <= FRS_5V_3A)
-- 
2.32.0.432.gabb21c7263-goog

