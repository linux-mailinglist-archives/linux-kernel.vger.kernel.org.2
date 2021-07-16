Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A103CB563
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhGPJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhGPJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:42:29 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63AC061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 02:39:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z93-20020a17090a6d66b0290175a6c43dbfso2566924pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=i5RVB4vHIQ9nfl4HYaBlwICiig5AVs5as0lKSOXIVDA=;
        b=jrCQeC/33Kk/hYXadEHP+UjkiH1AYtQsmDTNok9CcevcsGhAt1Wtaj/X1w0Y/biakA
         fZTmYevuEaBlxOk1/0zuU4/llrPnRvhtCzVWQg6t/fGZ+rVq3SMgXT0FI+cftuHWHqh0
         3YbgovKaIWCIm7IrMY7LnjaEwViDKM933FbV0l7r1cdbrUJRdaADDcABoPvoKrauB+tB
         WDgdQtCLkUe9nV5ji73GLOSNCdmgdMc9uJ7U3JS6IJjm09xGf2VeRvQe25b1i+xePnns
         1Df/cqU3kTv6G4DW7Jmga/xtRFHNj6PXFkKbcaCyRv0OewdKjWGKb9zEXa4TL+FtxbHw
         7oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=i5RVB4vHIQ9nfl4HYaBlwICiig5AVs5as0lKSOXIVDA=;
        b=mw+j1iz4jljICw2IJiWwHZoDjGv7M6QJYsRyeWoPLj9YFIooxayNYtRCd9YxdiRSVS
         vJAV9YAz2plfBtYM9W6+bJPtpr0gzgwCF2RrakZyQbGCW5nXSZf+q6KdKwIGqAUuXdsf
         1n2FoWoye4gQFf7spizmPSyMqtSUFsistWfTUSI7dWrCEevJKuJPzuENrnPpnz1nYuDj
         uVBKo4LfVCudj7ZlSskelRn2tygOZPb4+P/k3MC1toTcKIE/YEbaBQUgoTLPZM5CTFf+
         yFsArTe7blp26p0uSae/n+/sjvvtYmUohnrhqxU3iYGPsqBywRWPUDsylvdSUcbg1+WU
         ZQTg==
X-Gm-Message-State: AOAM533jFxWh7QK8R49RrJgg7DUSeJUX9Gv2IX3LX97bbi3VFygLVCpk
        dN5oYzLS6YyY3/oK/oMIvF34F62Wv/Bi
X-Google-Smtp-Source: ABdhPJx9plZN4fOdWaJMHqmQCeH4GXQeo/NMpNI6gdN00S6W00+o5rI1ZMqqLDJmO7as07bHoUv3EjE8GxPn
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:4ff3:81:775d:165c])
 (user=kyletso job=sendgmr) by 2002:a62:cd47:0:b029:329:714e:cce2 with SMTP id
 o68-20020a62cd470000b0290329714ecce2mr9622583pfg.22.1626428374280; Fri, 16
 Jul 2021 02:39:34 -0700 (PDT)
Date:   Fri, 16 Jul 2021 17:39:16 +0800
Message-Id: <20210716093916.1516845-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH] usb: typec: tcpm: Support non-PD mode
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcpm.c could work well without PD capabilities. Do not block the probe
if capabilities are not defined in fwnode and skip the PD power
negotiation in the state machine.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 50 ++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5b22a1c931a9..a42de5e17d24 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3914,6 +3914,8 @@ static void run_state_machine(struct tcpm_port *port)
 		if (port->ams == POWER_ROLE_SWAP ||
 		    port->ams == FAST_ROLE_SWAP)
 			tcpm_ams_finish(port);
+		if (!port->nr_src_pdo)
+			tcpm_set_state(port, SRC_READY, 0);
 		port->upcoming_state = SRC_SEND_CAPABILITIES;
 		tcpm_ams_start(port, POWER_NEGOTIATION);
 		break;
@@ -4161,7 +4163,10 @@ static void run_state_machine(struct tcpm_port *port)
 				current_lim = PD_P_SNK_STDBY_MW / 5;
 			tcpm_set_current_limit(port, current_lim, 5000);
 			tcpm_set_charge(port, true);
-			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
+			if (!port->nr_snk_pdo)
+				tcpm_set_state(port, SNK_READY, 0);
+			else
+				tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
 			break;
 		}
 		/*
@@ -5939,15 +5944,17 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 
 	/* Get source pdos */
 	ret = fwnode_property_count_u32(fwnode, "source-pdos");
-	if (ret <= 0)
-		return -EINVAL;
+	if (ret < 0)
+		ret = 0;
 
 	port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
-	ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
-					     port->src_pdo, port->nr_src_pdo);
-	if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
-					    port->nr_src_pdo))
-		return -EINVAL;
+	if (port->nr_src_pdo) {
+		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
+						     port->src_pdo, port->nr_src_pdo);
+		if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
+						    port->nr_src_pdo))
+			return -EINVAL;
+	}
 
 	if (port->port_type == TYPEC_PORT_SRC)
 		return 0;
@@ -5963,19 +5970,21 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 sink:
 	/* Get sink pdos */
 	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
-	if (ret <= 0)
-		return -EINVAL;
+	if (ret < 0)
+		ret = 0;
 
 	port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
-	ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
-					     port->snk_pdo, port->nr_snk_pdo);
-	if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
-					    port->nr_snk_pdo))
-		return -EINVAL;
+	if (port->nr_snk_pdo) {
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
+	}
 
 	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
 
@@ -6283,9 +6292,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	int err;
 
 	if (!dev || !tcpc ||
-	    !tcpc->get_vbus || !tcpc->set_cc || !tcpc->get_cc ||
-	    !tcpc->set_polarity || !tcpc->set_vconn || !tcpc->set_vbus ||
-	    !tcpc->set_pd_rx || !tcpc->set_roles || !tcpc->pd_transmit)
+	    !tcpc->get_vbus || !tcpc->set_cc || !tcpc->get_cc || !tcpc->set_polarity ||
+	    !tcpc->set_vconn || !tcpc->set_vbus || !tcpc->set_roles)
 		return ERR_PTR(-EINVAL);
 
 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-- 
2.32.0.402.g57bb445576-goog

