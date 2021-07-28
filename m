Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE9A3D8AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhG1J3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhG1J3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:29:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71968C061764
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:29:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a2532830000b029058328f1b02eso1848843yby.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l5yKvXjQ8S/W0y/XNebRWWjDHarzrh79K/doATDwMR4=;
        b=gaMN5SEfV1eft1jbLB9r/qJanlNFIo4DqD83bYWIuUcEpfIExks4K/XTkvDafm/12F
         DjGwHLkeBH7+FwAZn69m7x9Ga2VKb/OE4Xn4J3th0qmpfavxvM5CjdUwqzSN915XqF1q
         eKh/vakSQauLQJRHaZUFQq0eJr4p9i+oe7M1L5A/62UtVQTBJDLhwLf1HhQFCKVxUIS/
         9kVEWaTugdQQ38zOGFL5BPWcMuSnWx4Gsyz6tYHB5/9usSMIoTTaC8siLQtJHZSmvoOH
         QseCcFbWhmdqWAwDSNQDK3aNiGb3gPfsNoZyth27GEDAzbB55WNTs7rCBKV3eD9AfZw0
         8UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l5yKvXjQ8S/W0y/XNebRWWjDHarzrh79K/doATDwMR4=;
        b=QufJNWGSzvychRpJJmhcbuIPy8Vxj0pgIUTG2Re+RfiwVhiaVII7V0CCTRbw6uaUyM
         i2kOZ81ErVHQrWzwgO4zGyYOuDqYfDehIH5njXG5ghm9DzD+QXp0hP8V9rl5RHsyYKv6
         bOEUkrzAkKp3qUBGeMnfKAOJbRS+uujk7BVRFmtR2DNzQMnvNH6fcCIaB00Bfpui4Yd+
         zykl5zCT4CFYczhV0iqkZQEmueBzPzCK5Zwj61kVQPKQ6c2EcNC07vr/M2ZOCoW1Go6M
         qM1pRoPjoQUKg3Y5yChT2/vSh5KSWZH43eIiMjIX0lufq67+QW1436gN7qfDg1Q7MlpN
         OhJw==
X-Gm-Message-State: AOAM530L3VDc4E5YHdzbjo9dDL5Nn7m+fzqjMB5UR8YxiaX0TvBXTv9Q
        vwmCwXOUjoZcKeq7rmwG0sIWQc3IWh/t
X-Google-Smtp-Source: ABdhPJwM2k70JZA/Cyd8J9ASauzN+CGEocnhvVzX5dwnGVbFWBTZX8W43wmvT1BarCWfiyhSCx7ObvzHRWTX
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:da7f:a21b:ee74:66a2])
 (user=kyletso job=sendgmr) by 2002:a25:ca88:: with SMTP id
 a130mr38241072ybg.4.1627464589705; Wed, 28 Jul 2021 02:29:49 -0700 (PDT)
Date:   Wed, 28 Jul 2021 17:29:30 +0800
In-Reply-To: <20210728092930.2552619-1-kyletso@google.com>
Message-Id: <20210728092930.2552619-3-kyletso@google.com>
Mime-Version: 1.0
References: <20210728092930.2552619-1-kyletso@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 2/2] usb: typec: tcpm: Support non-PD mode
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
not support PD. If "pd-unsupported" is not found, "typec-power-opmode"
shall be added to specify the advertised Rp value if the port supports
SRC role.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
changes since v2:
- Changed the control flow if the port is SNK or DRP. Return directly if
  the flag is false (PD not supported). Read "self-powered" before that.

 drivers/usb/typec/tcpm/tcpm.c | 88 ++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5b22a1c931a9..d8d6ef8c6282 100644
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
@@ -5932,22 +5964,37 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		return ret;
 	port->typec_caps.type = ret;
 	port->port_type = port->typec_caps.type;
+	port->pd_supported = !fwnode_property_read_bool(fwnode, "pd-unsupported");
 
 	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
+
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
@@ -5961,6 +6008,13 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	if (port->typec_caps.prefer_role < 0)
 		return -EINVAL;
 sink:
+	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
+
+	if (!port->pd_supported) {
+		port->nr_snk_pdo = 0;
+		return 0;
+	}
+
 	/* Get sink pdos */
 	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
 	if (ret <= 0)
@@ -5977,9 +6031,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
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
2.32.0.432.gabb21c7263-goog

