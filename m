Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA630C745
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhBBRPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbhBBQU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:20:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3843C061352
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:17:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v17so4160313ybq.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QQFE5jwkjJ77NThauqkBipHFY85tQdjTEdZy4SSPTx0=;
        b=vweDA2y4OSm1/oa4+na9gLHDLog8tG9XQYK7sRC2mFQBRUKR6XyvD6HsbEVqmveYBy
         bbevrSI/Odv48qP97t6WMJ/p0bVDX5QwtXBWjmuNZt3mgnXnuae0tj5ggSTcubfghVoo
         WZ/7nHD3jfOzD0GQTAJzUR3lrOOUg4Qx/OQnjW6Qqxva0pEwtK6LTXD1fiwlBEMiW2hx
         YUVzYCT8KhbPbcuzmQNpiShLtK3uvm2vsGoVApFsS7yiCzvrWIIVOr6xYA9/zKQ3uF6t
         o4cUViMsHClJ2Moi1l2DTYcf7XtYf6GWvt+DukDo55V8uGWHMXck3PND8U9jwjvAI5De
         1fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QQFE5jwkjJ77NThauqkBipHFY85tQdjTEdZy4SSPTx0=;
        b=n/8kBVywRmFf5lxWIaBy7uo8cUZdxNfocnyGGqqgkcUd0iUKo0x1xCsClP+w4yzzTj
         DPg5ilzKz6Va+oIwJnq3xYqN+QnT64idYFmUJ58Q92iBEu0YJT7ppAfiSAJAoeLnPm4J
         IcF6Ekj26BrwTzt3xR/YDwOoiCkb++jNstniMMoDstYUcj0nVSRLRNjRImFMbcXFni4K
         TZOxQR+dDBoRIjh/W9NQMaGZGOsT+aJbV5I5ClwqmJKe3HMmOrqp8FMf4Y5DsNc+rBVv
         5rp+fO1pIOymcXycAjKbMxdbnq9qWEOWBLuaZ8RssMUI9hvJXoD/Zny4puF5qH6Bblwz
         Qubg==
X-Gm-Message-State: AOAM5323u0P+XEstbwc6/JRPgUzhplQlwPPgMCrPVVobaQCPMb93vlMu
        OXBkX7aBkbfS7Pe1CFE86Zpnly+EUqlr
X-Google-Smtp-Source: ABdhPJxttsh9DIV/8Dg++ZL+LOi3ANrU/ZR4tnXWVoFRNaOpLNrLBeVt+xscj2NXJlG11ZdXcBbBjdZXiHHe
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:dd94:c753:a81d:c855])
 (user=kyletso job=sendgmr) by 2002:a25:bb12:: with SMTP id
 z18mr34297721ybg.488.1612282673969; Tue, 02 Feb 2021 08:17:53 -0800 (PST)
Date:   Wed,  3 Feb 2021 00:17:29 +0800
In-Reply-To: <20210202161733.932215-1-kyletso@google.com>
Message-Id: <20210202161733.932215-5-kyletso@google.com>
Mime-Version: 1.0
References: <20210202161733.932215-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v5 4/8] usb: typec: tcpm: Detemine common SVDM Version
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PD Spec Revision 3.0 Version 2.0 + ECNs 2020-12-10
  6.4.4.2.3 Structured VDM Version
  "The Structured VDM Version field of the Discover Identity Command
  sent and received during VDM discovery Shall be used to determine the
  lowest common Structured VDM Version supported by the Port Partners or
  Cable Plug and Shall continue to operate using this Specification
  Revision until they are Detached."

Also clear the fields newly defined in SVDM version 2.0 for
compatibilities.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 49 ++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4b4cd3c585f4..979b7ee6473c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1475,6 +1475,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			const u32 *p, int cnt, u32 *response,
 			enum adev_actions *adev_action)
 {
+	struct typec_port *typec = port->typec_port;
 	struct typec_altmode *pdev;
 	struct pd_mode_data *modep;
 	int rlen = 0;
@@ -1500,10 +1501,21 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			if (PD_VDO_VID(p[0]) != USB_SID_PD)
 				break;
 
+			if (PD_VDO_SVDM_VER(p[0]) < typec_get_svdm_version(typec))
+				typec_set_svdm_version(typec, PD_VDO_SVDM_VER(p[0]));
 			/* 6.4.4.3.1: Only respond as UFP (device) */
 			if (port->data_role == TYPEC_DEVICE &&
 			    port->nr_snk_vdo) {
-				for (i = 0; i <  port->nr_snk_vdo; i++)
+				/*
+				 * Product Type DFP and Connector Type are not defined in SVDM
+				 * version 1.0 and shall be set to zero.
+				 */
+				if (typec_get_svdm_version(typec) < SVDM_VER_2_0)
+					response[1] = port->snk_vdo[0] & ~IDH_DFP_MASK
+						      & ~IDH_CONN_MASK;
+				else
+					response[1] = port->snk_vdo[0];
+				for (i = 1; i <  port->nr_snk_vdo; i++)
 					response[i + 1] = port->snk_vdo[i];
 				rlen = port->nr_snk_vdo + 1;
 			}
@@ -1532,6 +1544,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			response[0] = p[0] | VDO_CMDT(CMDT_RSP_BUSY);
 			rlen = 1;
 		}
+		response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
+			      (VDO_SVDM_VERS(typec_get_svdm_version(typec)));
 		break;
 	case CMDT_RSP_ACK:
 		/* silently drop message if we are not connected */
@@ -1542,19 +1556,23 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 
 		switch (cmd) {
 		case CMD_DISCOVER_IDENT:
+			if (PD_VDO_SVDM_VER(p[0]) < typec_get_svdm_version(typec))
+				typec_set_svdm_version(typec, PD_VDO_SVDM_VER(p[0]));
 			/* 6.4.4.3.1 */
 			svdm_consume_identity(port, p, cnt);
-			response[0] = VDO(USB_SID_PD, 1, SVDM_VER_1_0, CMD_DISCOVER_SVID);
+			response[0] = VDO(USB_SID_PD, 1, typec_get_svdm_version(typec),
+					  CMD_DISCOVER_SVID);
 			rlen = 1;
 			break;
 		case CMD_DISCOVER_SVID:
 			/* 6.4.4.3.2 */
 			if (svdm_consume_svids(port, p, cnt)) {
-				response[0] = VDO(USB_SID_PD, 1, SVDM_VER_1_0,
+				response[0] = VDO(USB_SID_PD, 1, typec_get_svdm_version(typec),
 						  CMD_DISCOVER_SVID);
 				rlen = 1;
 			} else if (modep->nsvids && supports_modal(port)) {
-				response[0] = VDO(modep->svids[0], 1, SVDM_VER_1_0,
+				response[0] = VDO(modep->svids[0], 1,
+						  typec_get_svdm_version(typec),
 						  CMD_DISCOVER_MODES);
 				rlen = 1;
 			}
@@ -1565,7 +1583,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			modep->svid_index++;
 			if (modep->svid_index < modep->nsvids) {
 				u16 svid = modep->svids[modep->svid_index];
-				response[0] = VDO(svid, 1, SVDM_VER_1_0, CMD_DISCOVER_MODES);
+				response[0] = VDO(svid, 1, typec_get_svdm_version(typec),
+						  CMD_DISCOVER_MODES);
 				rlen = 1;
 			} else {
 				tcpm_register_partner_altmodes(port);
@@ -1592,6 +1611,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			/* Unrecognized SVDM */
 			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
 			rlen = 1;
+			response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
+				      (VDO_SVDM_VERS(typec_get_svdm_version(typec)));
 			break;
 		}
 		break;
@@ -1611,6 +1632,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			/* Unrecognized SVDM */
 			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
 			rlen = 1;
+			response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
+				      (VDO_SVDM_VERS(typec_get_svdm_version(typec)));
 			break;
 		}
 		port->vdm_sm_running = false;
@@ -1618,6 +1641,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 	default:
 		response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
 		rlen = 1;
+		response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
+			      (VDO_SVDM_VERS(typec_get_svdm_version(typec)));
 		port->vdm_sm_running = false;
 		break;
 	}
@@ -1695,7 +1720,9 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			break;
 		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
 			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
-				response[0] = VDO(adev->svid, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
+				response[0] = VDO(adev->svid, 1,
+						  typec_get_svdm_version(port->typec_port),
+						  CMD_EXIT_MODE);
 				response[0] |= VDO_OPOS(adev->mode);
 				rlen = 1;
 			}
@@ -1729,7 +1756,8 @@ static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
 
 	/* set VDM header with VID & CMD */
 	header = VDO(vid, ((vid & USB_SID_PD) == USB_SID_PD) ?
-			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION), SVDM_VER_1_0, cmd);
+			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION),
+			typec_get_svdm_version(port->typec_port), cmd);
 	tcpm_queue_vdm(port, header, data, count);
 }
 
@@ -2024,7 +2052,8 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 	u32 header;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, SVDM_VER_1_0, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, vdo ? 2 : 1, typec_get_svdm_version(port->typec_port),
+		     CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
@@ -2036,7 +2065,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 	u32 header;
 
-	header = VDO(altmode->svid, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
+	header = VDO(altmode->svid, 1, typec_get_svdm_version(port->typec_port), CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
@@ -3445,6 +3474,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->attached = false;
 	port->pd_capable = false;
 	port->pps_data.supported = false;
+	typec_set_svdm_version(port->typec_port, port->typec_caps.svdm_version);
 
 	/*
 	 * First Rx ID should be 0; set this to a sentinel of -1 so that
@@ -5952,6 +5982,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->typec_caps.fwnode = tcpc->fwnode;
 	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
 	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
+	port->typec_caps.svdm_version = SVDM_VER_2_0;
 	port->typec_caps.driver_data = port;
 	port->typec_caps.ops = &tcpm_ops;
 	port->typec_caps.orientation_aware = 1;
-- 
2.30.0.365.g02bc693789-goog

