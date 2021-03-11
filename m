Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C90336F86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhCKKDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhCKKDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:03:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10227C061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 02:03:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p136so25158273ybc.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 02:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CRNU10dE7NxeMKiM3/VubFTm8e+uK3lL18S+85iKjKQ=;
        b=cafRhH+x5rWf2c1lFP7ECa+O9orzzMObUYfuqhXIXmH/8sFQniXUbst9qKGfCtmEWf
         a9HNw1JscmQ7zirvQHuy7/A5M/a+rLhr07xMt9dmJDG4OK0TLgR5HmRA7qBh0HjY07Mh
         q03Fwg+iXTz69Mf6m41BA+jhYp8iwfdFtTyA+q1/7qiG9Sl+swDTU/XVbIz4Dvognkfc
         rzt7za27zMn5qPrM1MOH/XnXChWw/uZixXNV00YsupuR9FLiucwlPXcZjYwWbf+wC+A2
         VXVfct/++arONw8a01nW1ZovtwIKf855RZXOs5D0q5kh52MzzTpevn7fLLikbo/H/Mc2
         8+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CRNU10dE7NxeMKiM3/VubFTm8e+uK3lL18S+85iKjKQ=;
        b=oQKplu5XsPsdNHYJLBLHPR9Eu95zVaupAyGiTxiR1YvPWhajElq2limj98HnaAcO7m
         bX2gXpvIG2FzjJmBP4pFAZAiy2NagV8XNwJxPUdJBdSVsbB3lZ32kjD/GvMUmURi9Izp
         I5lD+gwzQEzimpRQwPhCM1ZGb+zBUpERRUnLlquEW09PSVHCd39r3K0yPeLQlVUf1QW1
         tSgABXIjQMc97YF0ODpN+xCbCC+1upZTiBdL8sWJm2kvnUVGr5okujMx44dT01SjfnG4
         nI21qu/RyW20dhW6pvkr6Amapg89qzerZWTNqhxyStbBVI7iDB+m5RGbc92HRulgLze5
         1IzA==
X-Gm-Message-State: AOAM5305sB2mC0o35D/56qW12PEBdj92GftxcKsC4QzjrIWlqJS+Jh/8
        bB+o48X88asRH5vlU58Y3kMJtCK+Lp0=
X-Google-Smtp-Source: ABdhPJwGroWnEcfRIYk/XLlG3oXkauoNAbxeMmveVpOyyWibs3L0OWadMvmEoy35hkvGkUbumZvPAc/9EI4=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:39e6:8b30:8665:4bec])
 (user=badhri job=sendgmr) by 2002:a5b:690:: with SMTP id j16mr10696794ybq.251.1615456999256;
 Thu, 11 Mar 2021 02:03:19 -0800 (PST)
Date:   Thu, 11 Mar 2021 02:03:10 -0800
Message-Id: <20210311100313.3591254-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 1/4] usb: typec: tcpm: Add callback to notify pd_capable partner
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>, devicetree@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change informs lower level tcpc drivers of pd_capable
partner. This is useful while setting current limit for the
charging path.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 20 +++++++++++++++-----
 include/linux/usb/tcpm.h      |  3 +++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 11d0c40bc47d..e9886e850b84 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -952,6 +952,16 @@ static int tcpm_set_current_limit(struct tcpm_port *port, u32 max_ma, u32 mv)
 	return ret;
 }
 
+static void tcpm_set_pd_capable(struct tcpm_port *port, bool capable)
+{
+	tcpm_log(port, "Partner pd capable %s", capable ? "true" : "false");
+
+	if (port->tcpc->set_pd_capable)
+		port->tcpc->set_pd_capable(port->tcpc, capable);
+
+	port->pd_capable = capable;
+}
+
 static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
 {
 	return port->tcpc->set_roles(port->tcpc, attached, port->pwr_role,
@@ -3444,7 +3454,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 	if (ret < 0)
 		goto out_disable_vconn;
 
-	port->pd_capable = false;
+	tcpm_set_pd_capable(port, false);
 
 	port->partner = NULL;
 
@@ -3509,7 +3519,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_unregister_altmodes(port);
 	tcpm_typec_disconnect(port);
 	port->attached = false;
-	port->pd_capable = false;
+	tcpm_set_pd_capable(port, false);
 	port->pps_data.supported = false;
 	tcpm_set_partner_usb_comm_capable(port, false);
 
@@ -3583,7 +3593,7 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
-	port->pd_capable = false;
+	tcpm_set_pd_capable(port, false);
 
 	port->partner = NULL;
 
@@ -3813,7 +3823,7 @@ static void run_state_machine(struct tcpm_port *port)
 			 */
 			/* port->hard_reset_count = 0; */
 			port->caps_count = 0;
-			port->pd_capable = true;
+			tcpm_set_pd_capable(port, true);
 			tcpm_set_state_cond(port, SRC_SEND_CAPABILITIES_TIMEOUT,
 					    PD_T_SEND_SOURCE_CAP);
 		}
@@ -4074,7 +4084,7 @@ static void run_state_machine(struct tcpm_port *port)
 		}
 		break;
 	case SNK_NEGOTIATE_CAPABILITIES:
-		port->pd_capable = true;
+		tcpm_set_pd_capable(port, true);
 		tcpm_set_partner_usb_comm_capable(port,
 						  !!(port->source_caps[0] & PDO_FIXED_USB_COMM));
 		port->hard_reset_count = 0;
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 42fcfbe10590..d5d7293bc34d 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -112,6 +112,8 @@ enum tcpm_transmit_type {
  *              Optional; The USB Communications Capable bit indicates if port
  *              partner is capable of communication over the USB data lines
  *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
+ * @set_pd_capable:
+ *		Optional; Called to notify if the partner is pd capable.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -144,6 +146,7 @@ struct tcpc_dev {
 						 bool pps_active, u32 requested_vbus_voltage);
 	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
 	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
+	void (*set_pd_capable)(struct tcpc_dev *dev, bool enable);
 };
 
 struct tcpm_port;
-- 
2.31.0.rc2.261.g7f71774620-goog

