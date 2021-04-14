Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B680935F629
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349523AbhDNO1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346222AbhDNO10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:27:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FEDC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:27:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k199so17385210ybf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JZNxMt0kYcdl81T06jwbz7bLyJzhVKeZXhsmaV0aays=;
        b=ZE7ec79JRJhAh8rz0SBhyvoILEfHFixFNghu6rEe2f1YexSR3aZx4u+OAuxRxQfX3W
         /Dtmoy4YPFGN+3lcE9oqKdLqdiRpM74GPwct/F7KBAIU2CwOCU2yk7Kgf59LNemHq+1Y
         uSP1VagOZTjumSCMsAhS15UE16C6RetQ0qKVUJbpghHeTvheg/ppOohtfLqDhqgBdYeZ
         IwEUiYg9324fRGmLYSKgprJY/aTsC0Xe+0KCg8//udlWAxRBJn4hMC0W8N7Kbtmo3oRk
         e2rGI+NfAXOM0aoT7GwkbQyfqau27dQEsl6Bavpz754cnIi326VDG4jGJ7VZLJ1HnVwB
         ADow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JZNxMt0kYcdl81T06jwbz7bLyJzhVKeZXhsmaV0aays=;
        b=TpT/iqUjViXQtfITpo7gvk0kqWjoyXMD/stMHJ+5Lwx+VBMX7BlREh54EnIkRDnz1n
         ZnmSCr2ZjOANtc81UI+qVDBI+94v8uZvM2BPneEXDRpIM4buy1xu1utXr7s2FG2GEUta
         XbNkqx9Jvvk7Fn8M8Mk6oi0Ebz84fF9KxG4zrzM1yFZVMTPK1WrxbYwuqbk4ARFZvWtw
         Xf0XfNN1VVB07oRH+fI2R99YmrPco+CxK7l3mCECWHTM05DM9liR/yBhWfKinUpQGRS4
         iPOdhi89kX4ECAQrk0zFDCpUBRP4+y9DIZWPjG2nF4eeAij3DNnGnU62VziCsZtyJUEK
         aUIw==
X-Gm-Message-State: AOAM533th/MMwJ+3DKR06VeVsmZeCMf9xKNFQVKHTcbHls43zNjZZkVv
        u1xVcMCS4UeImZ8UwhvQ6sMRiXJ6gio=
X-Google-Smtp-Source: ABdhPJxBXTM7Q7HPBfGGbJx2oJtJgz+0hipcgbym5Sq9aj2qEf2V897DLXh+m+8SP5J3+G90lrqV+m3pUXE=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:91dd:58ac:7590:aa21])
 (user=badhri job=sendgmr) by 2002:a25:cc84:: with SMTP id l126mr31805689ybf.487.1618410422394;
 Wed, 14 Apr 2021 07:27:02 -0700 (PDT)
Date:   Wed, 14 Apr 2021 07:26:55 -0700
In-Reply-To: <20210414142656.63749-1-badhri@google.com>
Message-Id: <20210414142656.63749-2-badhri@google.com>
Mime-Version: 1.0
References: <20210414142656.63749-1-badhri@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v4 2/3] usb: typec: tcpm: Allow slow charging loops to comply
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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes since V3:
* Added reviewed-by tag from Heikki
Changes since V2:
* Refactored code based on Heikki's suggestion
---
 drivers/usb/typec/tcpm/tcpm.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index aedc8bb9532a..2ad5e14a6867 100644
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
@@ -4047,9 +4053,11 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_DISCOVERY:
 		if (port->vbus_present) {
-			tcpm_set_current_limit(port,
-					       tcpm_get_current_limit(port),
-					       5000);
+			u32 current_lim = tcpm_get_current_limit(port);
+
+			if (port->slow_charger_loop || (current_lim > PD_P_SNK_STDBY_MW / 5))
+				current_lim = PD_P_SNK_STDBY_MW / 5;
+			tcpm_set_current_limit(port, current_lim, 5000);
 			tcpm_set_charge(port, true);
 			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
 			break;
@@ -4161,6 +4169,8 @@ static void run_state_machine(struct tcpm_port *port)
 			port->pwr_opmode = TYPEC_PWR_MODE_PD;
 		}
 
+		if (!port->pd_capable && port->slow_charger_loop)
+			tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
 		mod_enable_frs_delayed_work(port, 0);
@@ -5763,6 +5773,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	port->typec_caps.type = ret;
 	port->port_type = port->typec_caps.type;
 
+	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
 	if (port->port_type == TYPEC_PORT_SNK)
 		goto sink;
 
-- 
2.31.1.295.g9ea45b61b8-goog

