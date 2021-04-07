Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9963C357582
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355975AbhDGUIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355933AbhDGUHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:07:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD758C0613D8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:07:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v186so24988422ybe.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gni+OuRztGG9vq8fyGub8QeENwXoTEQ8rz4IMi+bKtk=;
        b=abqPz3iC0Y6rDJvYZsAExnpkiIDKRrjm0+5nGUT9yhzRp9RfNV/jYl8B1nitNgMzqS
         2ojpx0ugRHKAa9LhyqZOMHQYP9volsOw6i3w1ZDzrbXF8DR+kU0wpfRAwcPTZ66kP5cq
         BptQtIDLbdeflTyXLSzUbycHzfjgpjRLN8LYNDgC8e2AgElqPIdKQsLk9thqdQnssaa+
         2W6T/AoW7w3GqcW33ldQoSvUT+CRExK09TNbl1DfAY01/J4SE9DSG4XH/Hq1Ve9Njl0j
         lQ9PMcWh4JRRQDXKB8uByXI4h54UanF17V+kF6vEpA+RMLNvfp+f+4BGFYuLO3Zk/ojB
         u7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gni+OuRztGG9vq8fyGub8QeENwXoTEQ8rz4IMi+bKtk=;
        b=fU9KYFIPcbKDlZFa77SQ+yn+yxtC6x/5k45mbQfK4CToM1PEIIc6BltyYmz0ea3de/
         gCF+TiO3Z1j4Dksc8hwkDlntsPviyorE5MaIh0GN5FRe5X7UBnk6H9enIPqYHKHwsw5A
         RkErdsrQ0igJeP/CjR0n6EVvycpGmlTz116O1baebAYnm0X4S7BKqKq3+0MVriWHb3cu
         8SYR6A4n5K/THBzyYtrdChqWcsaDRT1jyx13A7N0XK8f78sjQ9iKAPIxudY4YUodBP8F
         dNASNZSALL9sW5JKOtfa4SfGEnznfLvr71xPMIbTo+tHf4EIpyRzCSDyIPcmFiu/9+k5
         Hsvw==
X-Gm-Message-State: AOAM530Bmb91JN+Dct+AYahQZgh7C5hXT4fOicF5eY2GRBFxPoZS3uS4
        9Ov9FBP/d7jJd2RK0bKvrjLooqFss/o=
X-Google-Smtp-Source: ABdhPJykren/to6+VFAK9GoVBCT+QUQhMl3sOKzPJvq9xqM77MRf7+ZLoMPrGHCn+gHxaMhr6J/5+T8Xytw=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:991:6d08:9e6d:683d])
 (user=badhri job=sendgmr) by 2002:a25:d07:: with SMTP id 7mr6804424ybn.135.1617826055040;
 Wed, 07 Apr 2021 13:07:35 -0700 (PDT)
Date:   Wed,  7 Apr 2021 13:07:22 -0700
In-Reply-To: <20210407200723.1914388-1-badhri@google.com>
Message-Id: <20210407200723.1914388-5-badhri@google.com>
Mime-Version: 1.0
References: <20210407200723.1914388-1-badhri@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 5/6] usb: typec: tcpm: Allow slow charging loops to comply
 to pSnkStby
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

When a PD charger advertising Rp-3.0 is connected to a sink port, the
sink port current limit would 3A, during SNK_DISCOVERY, till power
negotiation starts. Once the negotiation starts the power limit needs
to drop down to pSnkStby(500mA @ 5V) and to negotiated current limit
once the explicit contract is in place. Not all charging loops can ramp
up to 3A and drop down to 500mA within tSnkStdby which is 15ms. The port
partner might hard reset if tSnkStdby is not met.

To solve this problem, this patch introduces slow-charger-loop which
when set makes the port request PD_P_SNK_STDBY_MW upon entering
SNK_DISCOVERY(instead of 3A or the 1.5A during SNK_DISCOVERY) and the
actual currrent limit after RX of PD_CTRL_PSRDY for PD link or during
SNK_READY for non-pd link.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 770b2edd9a04..b5bed6866a2b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -459,6 +459,12 @@ struct tcpm_port {
 	/* Auto vbus discharge status */
 	bool auto_vbus_discharge_enabled;
 
+	/*
+	 * When set, port requests PD_P_SNK_STDBY_MW upon entering SNK_DISCOVERY and
+	 * the actual currrent limit after RX of PD_CTRL_PSRDY for PD link,
+	 * SNK_READY for non-pd link.
+	 */
+	bool slow_charger_loop;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -4047,9 +4053,12 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_DISCOVERY:
 		if (port->vbus_present) {
-			tcpm_set_current_limit(port,
-					       tcpm_get_current_limit(port),
-					       5000);
+			u32 current_lim = (!port->slow_charger_loop ||
+					   (tcpm_get_current_limit(port) <=
+					    PD_P_SNK_STDBY_MW / 5)) ?
+				tcpm_get_current_limit(port) :
+				PD_P_SNK_STDBY_MW / 5;
+			tcpm_set_current_limit(port, current_lim, 5000);
 			tcpm_set_charge(port, true);
 			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
 			break;
@@ -4161,6 +4170,8 @@ static void run_state_machine(struct tcpm_port *port)
 			port->pwr_opmode = TYPEC_PWR_MODE_PD;
 		}
 
+		if (!port->pd_capable && port->slow_charger_loop)
+			tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
 		mod_enable_frs_delayed_work(port, 0);
@@ -5763,6 +5774,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	port->typec_caps.type = ret;
 	port->port_type = port->typec_caps.type;
 
+	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
 	if (port->port_type == TYPEC_PORT_SNK)
 		goto sink;
 
-- 
2.31.1.295.g9ea45b61b8-goog

