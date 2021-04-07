Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712BD357576
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbhDGUHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355907AbhDGUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:07:40 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E19BC061762
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:07:30 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id cf5so3531621qvb.20
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6diRnkZekp7rckkpsXWg5DBCGJnJP3NdYdgGwctNvO8=;
        b=csiyhr4njzuPfgf5pSrhos+B7wdG3G7S/7nNrIrVtfiUOwLcdYfy713VRfJ57bYvHn
         2/diOifTqOvIAcgoBn8I/GDbfN60B5nmVACRFrf76iBIGlUHjMPX5ojBLoExi2miDj6z
         yotPJRkKW5o9gQQ8od+dBRd2vGZyeQdKKB2I6KoFkKJ0uajM0nlcXcoozZnpd4gYqazS
         huR0zWqOOvAtAKx3S7hqzZgeySlgDOnftRT/6ZtxLDXHrVdE9qhV2nCVsPNghpGwvVb1
         9C033Vw8WccOZAWSwRVpxze9yuGEBgIYm1lIOCZHHeKwz5kzPeGJruSuDTLnWubqiiMP
         od7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6diRnkZekp7rckkpsXWg5DBCGJnJP3NdYdgGwctNvO8=;
        b=IBjVx07wDCxHtV5QP6baboQN5Xw9B8lNhvJKzs/QJfyRkb3KypmiRZ53GMrrFwjAey
         mUFiE/aqhGpM0m21QmYH8QGD75CcqumzKRcFPbFLek3qZtOJMvp7pKvJyoi5U4iVXIqR
         BCEYyx/oEZGMeYjY4bBWcaqNLoA7QID8EtFWCnKCoJxvMaZC77kwO/lMLS7skZjFDbo1
         jkwAPL7+9FIo+03ODWrBA6mOeV0gF6p2ewtyuc56AEQ9boyaNCKDC9AdAavD1jeRkv7S
         aZPnYWNQr6ig7q+9cmrDJy5w6CXBpdB+rBvt8E1JMMX7YYEc+lPIKUqCYDRlCQxnLa1u
         oQEg==
X-Gm-Message-State: AOAM532ISCbiLerGjQFtshKhw9J6vZahDDQaY2C2ffOVahZISJXzBkr0
        WleAYzUuzaMUprJPzXSN/CJ9U1P8nyY=
X-Google-Smtp-Source: ABdhPJxzpt07Z1s/q62rDlJbz4WMkdZxAuhdtmUUHewGRAvWF+rP27gjfYh5HEf88Uh1wMxLPtWHpY9MnOo=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:991:6d08:9e6d:683d])
 (user=badhri job=sendgmr) by 2002:ad4:5767:: with SMTP id r7mr5167852qvx.27.1617826049288;
 Wed, 07 Apr 2021 13:07:29 -0700 (PDT)
Date:   Wed,  7 Apr 2021 13:07:19 -0700
In-Reply-To: <20210407200723.1914388-1-badhri@google.com>
Message-Id: <20210407200723.1914388-2-badhri@google.com>
Mime-Version: 1.0
References: <20210407200723.1914388-1-badhri@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 2/6] usb: typec: tcpm: Address incorrect values of tcpm psy
 for pps supply
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcpm_pd_select_pps_apdo overwrites port->pps_data.min_volt,
port->pps_data.max_volt, port->pps_data.max_curr even before
port partner accepts the requests. This leaves incorrect values
in current_limit and supply_voltage that get exported by
"tcpm-source-psy-". Solving this problem by caching the request
values in req_min_volt, req_max_volt, req_max_curr, req_out_volt,
req_op_curr. min_volt, max_volt, max_curr gets updated once the
partner accepts the request. current_limit, supply_voltage gets updated
once local port's tcpm enters SNK_TRANSITION_SINK when the accepted
current_limit and supply_voltage is enforced.

Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through power_supply")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
Changes since V1:
* Moved to kerneldoc header as suggested by Greg KH.
* Added reviewed by tags.
---
 drivers/usb/typec/tcpm/tcpm.c | 88 +++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4ea4b30ae885..b4a40099d7e9 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -268,12 +268,27 @@ struct pd_mode_data {
 	struct typec_altmode_desc altmode_desc[ALTMODE_DISCOVERY_MAX];
 };
 
+/*
+ * @min_volt: Actual min voltage at the local port
+ * @req_min_volt: Requested min voltage to the port partner
+ * @max_volt: Actual max voltage at the local port
+ * @req_max_volt: Requested max voltage to the port partner
+ * @max_curr: Actual max current at the local port
+ * @req_max_curr: Requested max current of the port partner
+ * @req_out_volt: Requested output voltage to the port partner
+ * @req_op_curr: Requested operating current to the port partner
+ * @supported: Parter has atleast one APDO hence supports PPS
+ * @active: PPS mode is active
+ */
 struct pd_pps_data {
 	u32 min_volt;
+	u32 req_min_volt;
 	u32 max_volt;
+	u32 req_max_volt;
 	u32 max_curr;
-	u32 out_volt;
-	u32 op_curr;
+	u32 req_max_curr;
+	u32 req_out_volt;
+	u32 req_op_curr;
 	bool supported;
 	bool active;
 };
@@ -2498,8 +2513,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			break;
 		case SNK_NEGOTIATE_PPS_CAPABILITIES:
 			/* Revert data back from any requested PPS updates */
-			port->pps_data.out_volt = port->supply_voltage;
-			port->pps_data.op_curr = port->current_limit;
+			port->pps_data.req_out_volt = port->supply_voltage;
+			port->pps_data.req_op_curr = port->current_limit;
 			port->pps_status = (type == PD_CTRL_WAIT ?
 					    -EAGAIN : -EOPNOTSUPP);
 
@@ -2548,8 +2563,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			break;
 		case SNK_NEGOTIATE_PPS_CAPABILITIES:
 			port->pps_data.active = true;
-			port->req_supply_voltage = port->pps_data.out_volt;
-			port->req_current_limit = port->pps_data.op_curr;
+			port->pps_data.min_volt = port->pps_data.req_min_volt;
+			port->pps_data.max_volt = port->pps_data.req_max_volt;
+			port->pps_data.max_curr = port->pps_data.req_max_curr;
+			port->req_supply_voltage = port->pps_data.req_out_volt;
+			port->req_current_limit = port->pps_data.req_op_curr;
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
 		case SOFT_RESET_SEND:
@@ -3108,16 +3126,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 		src = port->source_caps[src_pdo];
 		snk = port->snk_pdo[snk_pdo];
 
-		port->pps_data.min_volt = max(pdo_pps_apdo_min_voltage(src),
-					      pdo_pps_apdo_min_voltage(snk));
-		port->pps_data.max_volt = min(pdo_pps_apdo_max_voltage(src),
-					      pdo_pps_apdo_max_voltage(snk));
-		port->pps_data.max_curr = min_pps_apdo_current(src, snk);
-		port->pps_data.out_volt = min(port->pps_data.max_volt,
-					      max(port->pps_data.min_volt,
-						  port->pps_data.out_volt));
-		port->pps_data.op_curr = min(port->pps_data.max_curr,
-					     port->pps_data.op_curr);
+		port->pps_data.req_min_volt = max(pdo_pps_apdo_min_voltage(src),
+						  pdo_pps_apdo_min_voltage(snk));
+		port->pps_data.req_max_volt = min(pdo_pps_apdo_max_voltage(src),
+						  pdo_pps_apdo_max_voltage(snk));
+		port->pps_data.req_max_curr = min_pps_apdo_current(src, snk);
+		port->pps_data.req_out_volt = min(port->pps_data.max_volt,
+						  max(port->pps_data.min_volt,
+						      port->pps_data.req_out_volt));
+		port->pps_data.req_op_curr = min(port->pps_data.max_curr,
+						 port->pps_data.req_op_curr);
 		power_supply_changed(port->psy);
 	}
 
@@ -3245,10 +3263,10 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
 			tcpm_log(port, "Invalid APDO selected!");
 			return -EINVAL;
 		}
-		max_mv = port->pps_data.max_volt;
-		max_ma = port->pps_data.max_curr;
-		out_mv = port->pps_data.out_volt;
-		op_ma = port->pps_data.op_curr;
+		max_mv = port->pps_data.req_max_volt;
+		max_ma = port->pps_data.req_max_curr;
+		out_mv = port->pps_data.req_out_volt;
+		op_ma = port->pps_data.req_op_curr;
 		break;
 	default:
 		tcpm_log(port, "Invalid PDO selected!");
@@ -3295,8 +3313,8 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
 	tcpm_log(port, "Requesting APDO %d: %u mV, %u mA",
 		 src_pdo_index, out_mv, op_ma);
 
-	port->pps_data.op_curr = op_ma;
-	port->pps_data.out_volt = out_mv;
+	port->pps_data.req_op_curr = op_ma;
+	port->pps_data.req_out_volt = out_mv;
 
 	return 0;
 }
@@ -5429,7 +5447,7 @@ static int tcpm_try_role(struct typec_port *p, int role)
 	return ret;
 }
 
-static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
+static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 req_op_curr)
 {
 	unsigned int target_mw;
 	int ret;
@@ -5447,12 +5465,12 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 		goto port_unlock;
 	}
 
-	if (op_curr > port->pps_data.max_curr) {
+	if (req_op_curr > port->pps_data.max_curr) {
 		ret = -EINVAL;
 		goto port_unlock;
 	}
 
-	target_mw = (op_curr * port->pps_data.out_volt) / 1000;
+	target_mw = (req_op_curr * port->supply_voltage) / 1000;
 	if (target_mw < port->operating_snk_mw) {
 		ret = -EINVAL;
 		goto port_unlock;
@@ -5466,10 +5484,10 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 	}
 
 	/* Round down operating current to align with PPS valid steps */
-	op_curr = op_curr - (op_curr % RDO_PROG_CURR_MA_STEP);
+	req_op_curr = req_op_curr - (req_op_curr % RDO_PROG_CURR_MA_STEP);
 
 	reinit_completion(&port->pps_complete);
-	port->pps_data.op_curr = op_curr;
+	port->pps_data.req_op_curr = req_op_curr;
 	port->pps_status = 0;
 	port->pps_pending = true;
 	mutex_unlock(&port->lock);
@@ -5490,7 +5508,7 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 	return ret;
 }
 
-static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
+static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 req_out_volt)
 {
 	unsigned int target_mw;
 	int ret;
@@ -5508,13 +5526,13 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
 		goto port_unlock;
 	}
 
-	if (out_volt < port->pps_data.min_volt ||
-	    out_volt > port->pps_data.max_volt) {
+	if (req_out_volt < port->pps_data.min_volt ||
+	    req_out_volt > port->pps_data.max_volt) {
 		ret = -EINVAL;
 		goto port_unlock;
 	}
 
-	target_mw = (port->pps_data.op_curr * out_volt) / 1000;
+	target_mw = (port->current_limit * req_out_volt) / 1000;
 	if (target_mw < port->operating_snk_mw) {
 		ret = -EINVAL;
 		goto port_unlock;
@@ -5528,10 +5546,10 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
 	}
 
 	/* Round down output voltage to align with PPS valid steps */
-	out_volt = out_volt - (out_volt % RDO_PROG_VOLT_MV_STEP);
+	req_out_volt = req_out_volt - (req_out_volt % RDO_PROG_VOLT_MV_STEP);
 
 	reinit_completion(&port->pps_complete);
-	port->pps_data.out_volt = out_volt;
+	port->pps_data.req_out_volt = req_out_volt;
 	port->pps_status = 0;
 	port->pps_pending = true;
 	mutex_unlock(&port->lock);
@@ -5589,8 +5607,8 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
 
 	/* Trigger PPS request or move back to standard PDO contract */
 	if (activate) {
-		port->pps_data.out_volt = port->supply_voltage;
-		port->pps_data.op_curr = port->current_limit;
+		port->pps_data.req_out_volt = port->supply_voltage;
+		port->pps_data.req_op_curr = port->current_limit;
 	}
 	mutex_unlock(&port->lock);
 
-- 
2.31.1.295.g9ea45b61b8-goog

