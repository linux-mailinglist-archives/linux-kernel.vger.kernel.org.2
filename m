Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C34354A2A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbhDFBhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243153AbhDFBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:37:01 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDC9C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 18:36:53 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id o9so9919992pgm.15
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 18:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c3n433xmYnCpqFjGIFKdSm/7zryixA8gEg9lhBxEXcY=;
        b=AZDXdbGnkLjjsELLd/XRsVieSO0Yc9EPyYRkHI5cYiame0Ld9QM6qdmYeI+pXH8o2f
         ofiDMfz3Hh5Mq/xhlXl7ZvQ9ueSw1n5Mzxt/E+cG7WfqN6cvtxyhiYH6YDucp7i0Nham
         eAIkEDKGrPZR/NhVVkeER93Wfiv1SI6RJ+vCANE6MXzL1N26yJZ3WJsRsdzXcOb83xw0
         yaBwxiN+jXUKqUvuM0Fq6mciD3bgQPtFdyAYDRqytywuQLBNmcLD83lUwRQhnSFfliBQ
         204uYhLjMDK3U2+fxfD90K1spAAcNNtCG8gIwwfJdLon914cAjsvlO8aRZR+r0dSlEWz
         OFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c3n433xmYnCpqFjGIFKdSm/7zryixA8gEg9lhBxEXcY=;
        b=l3kq/9wQKIAeK6HqEGnEvozm0YXO/jFNapVoB3YBIDbjaL2Ui0RyC4BFa8mmgkuJwJ
         L2k6l9EQRLlnfzg0ZB7ox3PV/mmULICE8CvisRXev8dgRf4gqL6iFrzf9u9m4GLOc/JO
         25XwVndl/y8hs55fnfsNREqqy1hZt4Me9PG6s9ITdtXJD0j+k3CPerf3ZGOr3dyoIPAJ
         cK7mjyuJeHrv2M/MSHYgB1PJEUO2df+y35bqe+Bp3UeA49Am2K8ffWHuE+EW+iExNuSF
         JTQOLCwMNE+DC8KYuMeaTTd7h0fgAIIIW4kwuKuNrWb83GtNv+BD9GEffDdIkdVaq+om
         BPqw==
X-Gm-Message-State: AOAM5305qmBxaR33YZLXXGVlVvHV38NhNaVcgmZdSGgdKcr11R10cogv
        JEzQbJbyZTtmdja0n/ZWGCEEeuejkWw=
X-Google-Smtp-Source: ABdhPJyl/ghhih4ik2fPW24rpQ0STtecAeEs4TCpjZg9Kkm493gI9aF2qxBvP/K9llrhg5UPbQn+LMB0pMo=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:7080:32f9:cd15:6178])
 (user=badhri job=sendgmr) by 2002:a62:ac1a:0:b029:1f9:5ca4:dd4d with SMTP id
 v26-20020a62ac1a0000b02901f95ca4dd4dmr25588691pfe.68.1617673012563; Mon, 05
 Apr 2021 18:36:52 -0700 (PDT)
Date:   Mon,  5 Apr 2021 18:36:39 -0700
In-Reply-To: <20210406013643.3280369-1-badhri@google.com>
Message-Id: <20210406013643.3280369-3-badhri@google.com>
Mime-Version: 1.0
References: <20210406013643.3280369-1-badhri@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v1 2/6] usb: typec: tcpm: Address incorrect values of tcpm psy
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
---
 drivers/usb/typec/tcpm/tcpm.c | 84 ++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 03eca5061132..d43774cc2ccf 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -269,11 +269,22 @@ struct pd_mode_data {
 };
 
 struct pd_pps_data {
+	/* Actual min voltage at the local port */
 	u32 min_volt;
+	/* Requested min voltage to the port partner */
+	u32 req_min_volt;
+	/* Actual max voltage at the local port */
 	u32 max_volt;
+	/* Requested max voltage to the port partner */
+	u32 req_max_volt;
+	/* Actual max current at the local port */
 	u32 max_curr;
-	u32 out_volt;
-	u32 op_curr;
+	/* Requested max current of the port partner */
+	u32 req_max_curr;
+	/* Requested output voltage to the port partner */
+	u32 req_out_volt;
+	/* Requested operating current to the port partner */
+	u32 req_op_curr;
 	bool supported;
 	bool active;
 };
@@ -2498,8 +2509,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			break;
 		case SNK_NEGOTIATE_PPS_CAPABILITIES:
 			/* Revert data back from any requested PPS updates */
-			port->pps_data.out_volt = port->supply_voltage;
-			port->pps_data.op_curr = port->current_limit;
+			port->pps_data.req_out_volt = port->supply_voltage;
+			port->pps_data.req_op_curr = port->current_limit;
 			port->pps_status = (type == PD_CTRL_WAIT ?
 					    -EAGAIN : -EOPNOTSUPP);
 
@@ -2548,8 +2559,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
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
@@ -3108,16 +3122,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
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
 
@@ -3245,10 +3259,10 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
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
@@ -3295,8 +3309,8 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
 	tcpm_log(port, "Requesting APDO %d: %u mV, %u mA",
 		 src_pdo_index, out_mv, op_ma);
 
-	port->pps_data.op_curr = op_ma;
-	port->pps_data.out_volt = out_mv;
+	port->pps_data.req_op_curr = op_ma;
+	port->pps_data.req_out_volt = out_mv;
 
 	return 0;
 }
@@ -5429,7 +5443,7 @@ static int tcpm_try_role(struct typec_port *p, int role)
 	return ret;
 }
 
-static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
+static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 req_op_curr)
 {
 	unsigned int target_mw;
 	int ret;
@@ -5447,12 +5461,12 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
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
@@ -5466,10 +5480,10 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
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
@@ -5490,7 +5504,7 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 	return ret;
 }
 
-static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
+static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 req_out_volt)
 {
 	unsigned int target_mw;
 	int ret;
@@ -5508,13 +5522,13 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
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
@@ -5528,10 +5542,10 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
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
@@ -5589,8 +5603,8 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
 
 	/* Trigger PPS request or move back to standard PDO contract */
 	if (activate) {
-		port->pps_data.out_volt = port->supply_voltage;
-		port->pps_data.op_curr = port->current_limit;
+		port->pps_data.req_out_volt = port->supply_voltage;
+		port->pps_data.req_op_curr = port->current_limit;
 	}
 	mutex_unlock(&port->lock);
 
-- 
2.31.0.208.g409f899ff0-goog

