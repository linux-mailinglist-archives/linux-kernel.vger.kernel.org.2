Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1AB35EB03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbhDNCkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343790AbhDNCk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:40:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C800DC06138D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:40:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p68so11709095ybg.20
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zITHXmYSEGrpR+08cIDRIpeKXQIvom7Nfxqoy64vyVU=;
        b=C1p05V8aXy0pUNoTlGHaPYXjPdNLHBzel2rlneXFncHcWnkOvSdECMtDQ3AQ682zD7
         X/6FxFdlQa3fVGrePXOfP8vqSM3xAZGdvEqCMmICSeLh/TmVwu3+exKCgKliDUNIeHzE
         /ZXHoCc6cxMD4n1NRrrjCUVRabA7zJnq/bTI/MmWNrbBbZeZkK5rQu9dxu4fHb/ALIFc
         w5J5GZeJ8SmsN8r/TxPC1SBkaqBM5Eyxr47lLF5OlH7zUK5YY8c7IlY+AdTccXhmvXKD
         jYPwja3I2+OCtDSP4j/J3Cuztv69uKG7r+fgZo/n78C5JVpIAjmhArq1e3DhS8aLZyfv
         MXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zITHXmYSEGrpR+08cIDRIpeKXQIvom7Nfxqoy64vyVU=;
        b=MLuWfyyzBMBzPGUoT2zMuv9tOXlwTLtgCctZ4Hbnid+vurayIpNUjexY1f96HG7DvS
         4flP1DVdzpZvCbIDkWx7KnIKxlZK1fqn8SiVMPdduEySxkYZYxhtOxu/ZXeMylghwh9z
         +eGzA4thU6qWdzpZqvRI1O6m8ghExoH/hXZTlTiMAlIN6Brmh5BPAriyrwvnYGM94vOs
         7e67pjhtPCnXVIvR413V/6mt6zoPmvMB288mnU9pE/SdbvIChDQAW30Jm16wvFlTmi6V
         s/LgbMFc2Amph3O5XSCZ8C+odlOg9Fp+7DhXu3/MqE0oFrCXuM6FJKJAws3LwHPYgsPF
         zV2A==
X-Gm-Message-State: AOAM531FjJOPTnBhc5ydNykMYGmmbLzAI1xvLJFyHrc1KBG8CaqOF9MH
        BBdwqB+J6Kn+qas3GXBebSbp3dnZIlg=
X-Google-Smtp-Source: ABdhPJzefCYV5RXeI1VVZejUFS4/Tj7hrJeXqx6rLWZBPHyUW2YanGEB8xs/PP2eljYU+4K1f38RrBF4+R8=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:91dd:58ac:7590:aa21])
 (user=badhri job=sendgmr) by 2002:a25:d181:: with SMTP id i123mr26623226ybg.387.1618368007045;
 Tue, 13 Apr 2021 19:40:07 -0700 (PDT)
Date:   Tue, 13 Apr 2021 19:39:59 -0700
In-Reply-To: <20210414024000.4175263-1-badhri@google.com>
Message-Id: <20210414024000.4175263-2-badhri@google.com>
Mime-Version: 1.0
References: <20210414024000.4175263-1-badhri@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v3 2/3] usb: typec: tcpm: Allow slow charging loops to comply
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

