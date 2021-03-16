Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CBC33E0E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhCPV5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCPV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:57:03 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49AC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:57:03 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id da16so26305219qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6DfkZN7WQbO1dvbjrdbjBHr+qM1rCOx1KfIaAxgNHAw=;
        b=RmnPRgfnot0nvRyG2KYcw9NGB4ZvTwu9Igo7aDUa0v8DYGP12qcseVIbhjRiNJ/+uC
         X9Zz8L+09dHMJQYpEyyoKSBmkx+o9d26i0jb/7HcIeElMU4NsXQerYAwjgl6BuXcsmwe
         OdjYwfyVGMHkDjpdcfAZBkE0p6L2wUVUN4q+77H9EQe8iEebfD49iT9/tKwdrKdXdNs2
         ekLoYHO6ptkiLYW8sxBlcmi+iOy+9nmqp2W1dbZwWZvNSZIwR3ON1Dugrl45Hr942Oxn
         VdX3JYqqT/ei+W/6E6cNbOd92PzpKmZNczxv5EnLoR+JVf8YIwJ8rL9vue1on0rneoum
         nBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6DfkZN7WQbO1dvbjrdbjBHr+qM1rCOx1KfIaAxgNHAw=;
        b=Tb/+pm1qYXvTIJAJMvVFdZ5hInETbZXrAtVGSflVsR1wZqBH2PsGb1K+MpdsYNN6Y6
         w87s+9EkUf7BEOf8+3ebFLqAf2g81YAsrtFUHYm+9n3TLAoLNw4+1SStIY9jdtB746D5
         JoliCG9wJoLKHBRPHARrLEA2oqkytfcHWMmgfErqKWN4cdeIeVVdky4/Oz/mUMAdkACD
         kr7QRlOSRiboZvFNAyHPrDTYAHYBRGEIs0aSg1sI1enY0WA/vBJVRt2eaT7rBPKdZNoO
         Fh0fV4xEDPSKXO713MfJscuk4uyMWBLBM/EGh2QnvZQbNr7lytvL21NNMlLpZv4Dzd1Y
         Oh6Q==
X-Gm-Message-State: AOAM5307Iixw86GmZMme2U5ntiUzjisoPVg0ut/5dg9qD1tFPxpmwBuG
        VCCgD3+tek53BVFexwNbJUPHzl/dXfk=
X-Google-Smtp-Source: ABdhPJz6tEHn3wR8lIfXg5Ff/co+kHwF3TzWU0RX2p1hKNtmrEA++I2Me3P9dZxPY6pWwm81PCku2iF39mY=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:e53d:77e7:f975:af74])
 (user=badhri job=sendgmr) by 2002:a0c:8ec1:: with SMTP id y1mr2065111qvb.11.1615931822559;
 Tue, 16 Mar 2021 14:57:02 -0700 (PDT)
Date:   Tue, 16 Mar 2021 14:56:57 -0700
Message-Id: <20210316215657.387357-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] usb: typec: tcpm: Invoke power_supply_changed for tcpm-source-psy-
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcpm-source-psy- does not invoke power_supply_changed API when
one of the published power supply property is changed.
power_supply_changed needs to be called to notify
userspace clients(uevents) and kernel clients.

Fixes: f2a8aa053c176("typec: tcpm: Represent source supply through
power_supply")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 11d0c40bc47d..e8936ea17f80 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -945,6 +945,7 @@ static int tcpm_set_current_limit(struct tcpm_port *port, u32 max_ma, u32 mv)
 
 	port->supply_voltage = mv;
 	port->current_limit = max_ma;
+	power_supply_changed(port->psy);
 
 	if (port->tcpc->set_current_limit)
 		ret = port->tcpc->set_current_limit(port->tcpc, max_ma, mv);
@@ -2931,6 +2932,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 
 	port->pps_data.supported = false;
 	port->usb_type = POWER_SUPPLY_USB_TYPE_PD;
+	power_supply_changed(port->psy);
 
 	/*
 	 * Select the source PDO providing the most power which has a
@@ -2955,6 +2957,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 				port->pps_data.supported = true;
 				port->usb_type =
 					POWER_SUPPLY_USB_TYPE_PD_PPS;
+				power_supply_changed(port->psy);
 			}
 			continue;
 		default:
@@ -3112,6 +3115,7 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 						  port->pps_data.out_volt));
 		port->pps_data.op_curr = min(port->pps_data.max_curr,
 					     port->pps_data.op_curr);
+		power_supply_changed(port->psy);
 	}
 
 	return src_pdo;
@@ -3347,6 +3351,7 @@ static int tcpm_set_charge(struct tcpm_port *port, bool charge)
 			return ret;
 	}
 	port->vbus_charge = charge;
+	power_supply_changed(port->psy);
 	return 0;
 }
 
@@ -3530,6 +3535,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
 	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
+	power_supply_changed(port->psy);
 	port->nr_sink_caps = 0;
 	port->sink_cap_done = false;
 	if (port->tcpc->enable_frs)
@@ -5957,7 +5963,7 @@ static int tcpm_psy_set_prop(struct power_supply *psy,
 		ret = -EINVAL;
 		break;
 	}
-
+	power_supply_changed(port->psy);
 	return ret;
 }
 
@@ -6110,6 +6116,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	err = devm_tcpm_psy_register(port);
 	if (err)
 		goto out_role_sw_put;
+	power_supply_changed(port->psy);
 
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (IS_ERR(port->typec_port)) {
-- 
2.31.0.rc2.261.g7f71774620-goog

