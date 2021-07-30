Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94F3DB8D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhG3Mqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbhG3Mor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:44:47 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B29C0617A0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:44:00 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id g2-20020a0cdf020000b029033bc8be6d4aso735440qvl.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fjr35flNSax2Mvu6xm+ntxvO2laDJWlsIDTMRXVS8p8=;
        b=rAWAaIUEmf9gxaJGCK1qIL+bo0wKL9p0W0B1EGgP54yE9mlKOvp8WpE8iXrV6Xs5QT
         Lha0joAclhpF9IE6pKXMiNwCWXBoosuI8Fm9HZID5dBuEZlv+F7ZUJAXzrdUqV1sBDv8
         LCT4LXjlRVBlwoOiLgejUybaNligpqxq7+j5FX3zYj/oGX/UswPFIk7rDPeXu8lE2d6L
         nLf25NDi/5lOZE9DfU5anBF5PW9l2vNAG7pvCEzuM1MticmOy5ZiQCalGOYf8UOVRJN6
         6/AZiFpJ2k4E3tjkqeqHh5ZyrzbTpTmT8tQ7VAFpjCG9CCR3rdJJBaVztq0JN+P22MK8
         lJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fjr35flNSax2Mvu6xm+ntxvO2laDJWlsIDTMRXVS8p8=;
        b=DtluGSIplAVRdDFdyA0zrT+8/4JO/UNlYkE2sPc1Wfe7inMb4soaPnd87MlsDjdfm6
         h//eh6l22Y3JEX1NTKJ5/05E9AqWMLiYHOBwYvoMFPUN1Sd3lBEEX8864fH05QYpIThA
         VEiP+JePGVPhIbwTFaF43dU+uDW/KXjsbkIJ6ofY1WuN8huhbWolJLBBTor2kPDCjq1u
         CgJdN6sA2xCRNTVcyt4NlDH7coN2FGpkq1+d11cqaSnk23TTUTd0gceyAwd2mjN0+L7g
         Fr36a4J8uGCOVTvMlN56qHhsEid5V0UAWKnuR3jDPNqclhT0GBR0dvY8mTDmi4TMnTmj
         MWZA==
X-Gm-Message-State: AOAM530ZkEG9WwOWGvPt+Et2XY2dH1V+nS2LRgvGbA9OVK1SQkFtIiKO
        qEByTF4JOp1aclclEvfOB9rdlQXkMQSL
X-Google-Smtp-Source: ABdhPJw/Ja/Uj1+lv3HeRn/iZUVtWrNbi1FBl2j3rpOmuJ0IEFiVwMavlDs67ZniUbV27+zDWl6AQWtfM9Mr
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:6892:a74:4970:a062])
 (user=kyletso job=sendgmr) by 2002:a05:6214:a93:: with SMTP id
 ev19mr2561364qvb.27.1627649039802; Fri, 30 Jul 2021 05:43:59 -0700 (PDT)
Date:   Fri, 30 Jul 2021 20:43:48 +0800
In-Reply-To: <20210730124348.1986638-1-kyletso@google.com>
Message-Id: <20210730124348.1986638-3-kyletso@google.com>
Mime-Version: 1.0
References: <20210730124348.1986638-1-kyletso@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v5 2/2] usb: typec: tcpm: Support non-PD mode
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
"pd-unsupported" property in device tree indicates that the port does
not support PD. If PD is not supported, the device tree property
"typec-power-opmode" shall be added to specify the advertised Rp value
if the port supports SRC role.

Signed-off-by: Kyle Tso <kyletso@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since v4:
- Added Reviewed-by

 drivers/usb/typec/tcpm/tcpm.c | 87 +++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5b22a1c931a9..faea1bf9dce0 100644
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
@@ -815,6 +817,9 @@ static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port)
 	int nr_pdo = port->nr_src_pdo;
 	int i;
 
+	if (!port->pd_supported)
+		return port->src_rp;
+
 	/*
 	 * Search for first entry with matching voltage.
 	 * It should report the maximum supported current.
@@ -3568,9 +3573,11 @@ static int tcpm_src_attach(struct tcpm_port *port)
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
@@ -3600,7 +3607,8 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_vconn:
 	tcpm_set_vconn(port, false);
 out_disable_pd:
-	port->tcpc->set_pd_rx(port->tcpc, false);
+	if (port->pd_supported)
+		port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
 	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
@@ -3804,6 +3812,20 @@ static enum typec_pwr_opmode tcpm_get_pwr_opmode(enum typec_cc_status cc)
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
@@ -3914,6 +3936,10 @@ static void run_state_machine(struct tcpm_port *port)
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
@@ -4161,7 +4187,10 @@ static void run_state_machine(struct tcpm_port *port)
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
@@ -4389,7 +4418,8 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_vbus(port, true);
 		if (port->ams == HARD_RESET)
 			tcpm_ams_finish(port);
-		port->tcpc->set_pd_rx(port->tcpc, true);
+		if (port->pd_supported)
+			port->tcpc->set_pd_rx(port->tcpc, true);
 		tcpm_set_attached_state(port, true);
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
@@ -5898,6 +5928,7 @@ EXPORT_SYMBOL_GPL(tcpm_tcpc_reset);
 static int tcpm_fw_get_caps(struct tcpm_port *port,
 			    struct fwnode_handle *fwnode)
 {
+	const char *opmode_str;
 	const char *cap_str;
 	int ret;
 	u32 mw, frs_current;
@@ -5932,22 +5963,37 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		return ret;
 	port->typec_caps.type = ret;
 	port->port_type = port->typec_caps.type;
+	port->pd_supported = !fwnode_property_read_bool(fwnode, "pd-unsupported");
 
 	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
 	if (port->port_type == TYPEC_PORT_SNK)
 		goto sink;
 
-	/* Get source pdos */
-	ret = fwnode_property_count_u32(fwnode, "source-pdos");
-	if (ret <= 0)
-		return -EINVAL;
+	/* Get Source PDOs for the PD port or Source Rp value for the non-PD port */
+	if (port->pd_supported) {
+		ret = fwnode_property_count_u32(fwnode, "source-pdos");
+		if (ret == 0)
+			return -EINVAL;
+		else if (ret < 0)
+			return ret;
 
-	port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
-	ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
-					     port->src_pdo, port->nr_src_pdo);
-	if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
-					    port->nr_src_pdo))
-		return -EINVAL;
+		port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
+		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
+						     port->src_pdo, port->nr_src_pdo);
+		if (ret)
+			return ret;
+		ret = tcpm_validate_caps(port, port->src_pdo, port->nr_src_pdo);
+		if (ret)
+			return ret;
+	} else {
+		ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &opmode_str);
+		if (ret)
+			return ret;
+		ret = typec_find_pwr_opmode(opmode_str);
+		if (ret < 0)
+			return ret;
+		port->src_rp = tcpm_pwr_opmode_to_rp(ret);
+	}
 
 	if (port->port_type == TYPEC_PORT_SRC)
 		return 0;
@@ -5961,6 +6007,11 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	if (port->typec_caps.prefer_role < 0)
 		return -EINVAL;
 sink:
+	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
+
+	if (!port->pd_supported)
+		return 0;
+
 	/* Get sink pdos */
 	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
 	if (ret <= 0)
@@ -5977,9 +6028,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		return -EINVAL;
 	port->operating_snk_mw = mw / 1000;
 
-	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
-
-	/* FRS can only be supported byb DRP ports */
+	/* FRS can only be supported by DRP ports */
 	if (port->port_type == TYPEC_PORT_DRP) {
 		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
 					       &frs_current);
-- 
2.32.0.554.ge1b32706d8-goog

