Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686CC309D71
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhAaPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbhAaPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 10:20:26 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F65C0613ED
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 07:18:59 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id v65so6582278qtd.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 07:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NPq9Lh5Mf5AkxQ9yc4WG8QMvBaUfIn3iAZ0v3U9TYFs=;
        b=RGdLS9RlQrXQNfga3CXXMcsOHhEztsTyHsssDdOCKodtBNDnD/g+zmlIfTj5nOY1Eh
         RoIwpIWR7odkhrqEUYAqLiY/8GuYC34QvfAG7ES+ptDpaQQk66RKKSjGkUCK98d1A9Bi
         3tnS6venKKsvKtAPZW4u5daNObMxf8BG89yR8bIs/TPRWX2Lc8LPXYdzdy4beh92yNZ2
         cOCO1bc5iOp+X1kMzmK6tW29sYBKyq+2pmr73mcRGPCEKXaGI3enBT8VJJCNWnlYWITb
         ZjikgfnUqUqCZ4ME0l3yOqLChrVAIUDyy1FAk+le0oaZ3zM/Ej1isyRz/bhhnes54KW7
         itew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NPq9Lh5Mf5AkxQ9yc4WG8QMvBaUfIn3iAZ0v3U9TYFs=;
        b=gq4Nswd73wEgQd8O0ccdf6pBeevNCvYigfK2WEGOVLagXT3zb77iXchA/Qkm7rtuZa
         mvdSPD0PKnnbpGkVKLcKetDJP2H8kC7ZoJfMxNg81eQl+A2mvQWpN8uXxEbhtarAjCCM
         ezdAjlHqBGWrsSgxwHkpiiFr2LlGNfXUOyLY+Q60gaenJVRml4yp6kKd7R6oBoKTRwjM
         RA15lsKDgCNvL4/WQ1Dq8KzgsW1beHmoId1Cg2fqKGDKxRdSbg8QBZvJYcU9lH+XFCro
         GpbhLZkh/gUCDA2wMq78f79L+xYK12jg05PK7ZjyHYzVxZHrj7BP4uv67Ne+DOac8DVL
         fgKA==
X-Gm-Message-State: AOAM530tlZCfTxWKcV2Za9FIUE5F5JexjZdNFG0scN90NYEn/cGEx7gn
        oMYeMMIzVD0L2m8yI+5mmuDK2SOspDEi
X-Google-Smtp-Source: ABdhPJweGc3VFluJFkf2fjxeh8r/R7rIQ5ljsA5KSTiCqVUK+MZiBrVItj9PSJJai/Ankpwv65bnrX34VcBo
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:5d70:9e45:7deb:72a7])
 (user=kyletso job=sendgmr) by 2002:a05:6214:443:: with SMTP id
 cc3mr11674904qvb.17.1612106338685; Sun, 31 Jan 2021 07:18:58 -0800 (PST)
Date:   Sun, 31 Jan 2021 23:18:30 +0800
In-Reply-To: <20210131151832.215931-1-kyletso@google.com>
Message-Id: <20210131151832.215931-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210131151832.215931-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 1/3] usb: typec: Determine common SVDM Versions
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
compatibilities. And fix some VDO definitions changed in the Spec.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v1:
- removed the "local" variables (svdm_version) in tcpm.c and
  (altmodes/ucsi)/displayport.c
- added a member "svdm_version" in struct typec_capabilities indicating
  the default SVDM version of the port
- added a member "common_svdm_ver" in struct typec_port indicating the
  common SVDM version between the port and the partner
- implemented the get/set API of the common_svdm_ver in typec/class.c so
  that clients can read/update the common SVDM version
- added more definitions of Product Type VDOs

 drivers/usb/typec/altmodes/displayport.c |   5 +-
 drivers/usb/typec/class.c                |  21 +-
 drivers/usb/typec/tcpm/tcpm.c            |  49 +++-
 drivers/usb/typec/ucsi/displayport.c     |  10 +-
 drivers/usb/typec/ucsi/ucsi.c            |   2 +
 include/linux/usb/pd_vdo.h               | 315 +++++++++++++++++------
 include/linux/usb/typec.h                |  10 +
 7 files changed, 323 insertions(+), 89 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index e62e5e3da01e..26c40240a6b6 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -15,7 +15,8 @@
 #include <linux/usb/typec_dp.h>
 #include "displayport.h"
 
-#define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, cmd) | \
+#define COMMON_SVDM_VER(_dp)		(typec_get_common_svdm_version((_dp)->typec))
+#define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, COMMON_SVDM_VER(_dp), cmd) | \
 					 VDO_OPOS(USB_TYPEC_DP_MODE))
 
 enum {
@@ -62,6 +63,7 @@ struct dp_altmode {
 	struct work_struct work;
 	struct typec_altmode *alt;
 	const struct typec_altmode *port;
+	struct typec_port *typec;
 };
 
 static int dp_altmode_notify(struct dp_altmode *dp)
@@ -536,6 +538,7 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	mutex_init(&dp->lock);
 	dp->port = port;
 	dp->alt = alt;
+	dp->typec = typec_altmode2port(alt);
 
 	alt->desc = "DisplayPort";
 	alt->ops = &dp_altmode_ops;
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 8f77669f9cf4..10fee74c16d3 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -49,6 +49,7 @@ struct typec_port {
 	enum typec_role			vconn_role;
 	enum typec_pwr_opmode		pwr_opmode;
 	enum typec_port_type		port_type;
+	enum usb_pd_svdm_ver		common_svdm_ver;
 	struct mutex			port_type_lock;
 
 	enum typec_orientation		orientation;
@@ -86,7 +87,7 @@ static const char * const typec_accessory_modes[] = {
 
 /* Product types defined in USB PD Specification R3.0 V2.0 */
 static const char * const product_type_ufp[8] = {
-	[IDH_PTYPE_UNDEF]		= "undefined",
+	[IDH_PTYPE_NOT_UFP]		= "not_ufp",
 	[IDH_PTYPE_HUB]			= "hub",
 	[IDH_PTYPE_PERIPH]		= "peripheral",
 	[IDH_PTYPE_PSD]			= "psd",
@@ -94,17 +95,17 @@ static const char * const product_type_ufp[8] = {
 };
 
 static const char * const product_type_dfp[8] = {
-	[IDH_PTYPE_DFP_UNDEF]		= "undefined",
+	[IDH_PTYPE_NOT_DFP]		= "not_dfp",
 	[IDH_PTYPE_DFP_HUB]		= "hub",
 	[IDH_PTYPE_DFP_HOST]		= "host",
 	[IDH_PTYPE_DFP_PB]		= "power_brick",
-	[IDH_PTYPE_DFP_AMC]		= "amc",
 };
 
 static const char * const product_type_cable[8] = {
-	[IDH_PTYPE_UNDEF]		= "undefined",
+	[IDH_PTYPE_NOT_CABLE]		= "not_cable",
 	[IDH_PTYPE_PCABLE]		= "passive",
 	[IDH_PTYPE_ACABLE]		= "active",
+	[IDH_PTYPE_VPD]			= "vpd",
 };
 
 static struct usb_pd_identity *get_pd_identity(struct device *dev)
@@ -1788,6 +1789,18 @@ int typec_find_port_data_role(const char *name)
 }
 EXPORT_SYMBOL_GPL(typec_find_port_data_role);
 
+void typec_set_common_svdm_version(struct typec_port *port, enum usb_pd_svdm_ver ver)
+{
+	port->common_svdm_ver = ver;
+}
+EXPORT_SYMBOL_GPL(typec_set_common_svdm_version);
+
+enum usb_pd_svdm_ver typec_get_common_svdm_version(struct typec_port *port)
+{
+	return port->common_svdm_ver;
+}
+EXPORT_SYMBOL_GPL(typec_get_common_svdm_version);
+
 /* ------------------------------------------ */
 /* API for Multiplexer/DeMultiplexer Switches */
 
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0afd8ef692e8..403a483645dd 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1470,11 +1470,13 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
 }
 
 #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
+#define common_svdm_ver(typec)	(typec_get_common_svdm_version(typec))
 
 static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			const u32 *p, int cnt, u32 *response,
 			enum adev_actions *adev_action)
 {
+	struct typec_port *typec = port->typec_port;
 	struct typec_altmode *pdev;
 	struct pd_mode_data *modep;
 	int rlen = 0;
@@ -1500,10 +1502,21 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			if (PD_VDO_VID(p[0]) != USB_SID_PD)
 				break;
 
+			if (PD_VDO_SVDM_VER(p[0]) < common_svdm_ver(typec))
+				typec_set_common_svdm_version(typec, PD_VDO_SVDM_VER(p[0]));
 			/* 6.4.4.3.1: Only respond as UFP (device) */
 			if (port->data_role == TYPEC_DEVICE &&
 			    port->nr_snk_vdo) {
-				for (i = 0; i <  port->nr_snk_vdo; i++)
+				/*
+				 * Product Type DFP and Connector Type are not defined in SVDM
+				 * version 1.0 and shall be set to zero.
+				 */
+				if (common_svdm_ver(typec) < SVDM_VER_2_0)
+					response[1] = port->snk_vdo[0] & ~IDH_DFP_MASK
+						      & ~IDH_CONN_MASK;
+				else
+					response[1] = port->snk_vdo[0];
+				for (i = 1; i <  port->nr_snk_vdo; i++)
 					response[i + 1] = port->snk_vdo[i];
 				rlen = port->nr_snk_vdo + 1;
 			}
@@ -1532,6 +1545,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			response[0] = p[0] | VDO_CMDT(CMDT_RSP_BUSY);
 			rlen = 1;
 		}
+		response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
+			      (VDO_SVDM_VERS(common_svdm_ver(typec)));
 		break;
 	case CMDT_RSP_ACK:
 		/* silently drop message if we are not connected */
@@ -1542,19 +1557,22 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 
 		switch (cmd) {
 		case CMD_DISCOVER_IDENT:
+			if (PD_VDO_SVDM_VER(p[0]) < common_svdm_ver(typec))
+				typec_set_common_svdm_version(typec, PD_VDO_SVDM_VER(p[0]));
 			/* 6.4.4.3.1 */
 			svdm_consume_identity(port, p, cnt);
-			response[0] = VDO(USB_SID_PD, 1, CMD_DISCOVER_SVID);
+			response[0] = VDO(USB_SID_PD, 1, common_svdm_ver(typec),
+					  CMD_DISCOVER_SVID);
 			rlen = 1;
 			break;
 		case CMD_DISCOVER_SVID:
 			/* 6.4.4.3.2 */
 			if (svdm_consume_svids(port, p, cnt)) {
-				response[0] = VDO(USB_SID_PD, 1,
+				response[0] = VDO(USB_SID_PD, 1, common_svdm_ver(typec),
 						  CMD_DISCOVER_SVID);
 				rlen = 1;
 			} else if (modep->nsvids && supports_modal(port)) {
-				response[0] = VDO(modep->svids[0], 1,
+				response[0] = VDO(modep->svids[0], 1, common_svdm_ver(typec),
 						  CMD_DISCOVER_MODES);
 				rlen = 1;
 			}
@@ -1565,7 +1583,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			modep->svid_index++;
 			if (modep->svid_index < modep->nsvids) {
 				u16 svid = modep->svids[modep->svid_index];
-				response[0] = VDO(svid, 1, CMD_DISCOVER_MODES);
+				response[0] = VDO(svid, 1, common_svdm_ver(typec),
+						  CMD_DISCOVER_MODES);
 				rlen = 1;
 			} else {
 				tcpm_register_partner_altmodes(port);
@@ -1592,6 +1611,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			/* Unrecognized SVDM */
 			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
 			rlen = 1;
+			response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
+				      (VDO_SVDM_VERS(common_svdm_ver(typec)));
 			break;
 		}
 		break;
@@ -1611,6 +1632,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			/* Unrecognized SVDM */
 			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
 			rlen = 1;
+			response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
+				      (VDO_SVDM_VERS(common_svdm_ver(typec)));
 			break;
 		}
 		port->vdm_sm_running = false;
@@ -1618,6 +1641,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 	default:
 		response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
 		rlen = 1;
+		response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
+			      (VDO_SVDM_VERS(common_svdm_ver(typec)));
 		port->vdm_sm_running = false;
 		break;
 	}
@@ -1695,7 +1720,9 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			break;
 		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
 			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
-				response[0] = VDO(adev->svid, 1, CMD_EXIT_MODE);
+				response[0] = VDO(adev->svid, 1,
+						  common_svdm_ver(port->typec_port),
+						  CMD_EXIT_MODE);
 				response[0] |= VDO_OPOS(adev->mode);
 				rlen = 1;
 			}
@@ -1729,7 +1756,8 @@ static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
 
 	/* set VDM header with VID & CMD */
 	header = VDO(vid, ((vid & USB_SID_PD) == USB_SID_PD) ?
-			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION), cmd);
+			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION),
+			common_svdm_ver(port->typec_port), cmd);
 	tcpm_queue_vdm(port, header, data, count);
 }
 
@@ -2024,7 +2052,8 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 	u32 header;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, vdo ? 2 : 1, common_svdm_ver(port->typec_port),
+		     CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
@@ -2036,7 +2065,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 	u32 header;
 
-	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
+	header = VDO(altmode->svid, 1, common_svdm_ver(port->typec_port), CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
@@ -3445,6 +3474,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->attached = false;
 	port->pd_capable = false;
 	port->pps_data.supported = false;
+	typec_set_common_svdm_version(port->typec_port, port->typec_caps.svdm_version);
 
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
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 261131c9e37c..af47b3a631d6 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -14,6 +14,7 @@
 #define UCSI_CMD_SET_NEW_CAM(_con_num_, _enter_, _cam_, _am_)		\
 	 (UCSI_SET_NEW_CAM | ((_con_num_) << 16) | ((_enter_) << 23) |	\
 	  ((_cam_) << 24) | ((u64)(_am_) << 32))
+#define common_svdm_ver(dp)  (typec_get_common_svdm_version((dp)->con->port))
 
 struct ucsi_dp {
 	struct typec_displayport_data data;
@@ -83,7 +84,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	 * mode, and letting the alt mode driver continue.
 	 */
 
-	dp->header = VDO(USB_TYPEC_DP_SID, 1, CMD_ENTER_MODE);
+	dp->header = VDO(USB_TYPEC_DP_SID, 1, common_svdm_ver(dp), CMD_ENTER_MODE);
 	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
 	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
 
@@ -120,7 +121,7 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
 	if (ret < 0)
 		goto out_unlock;
 
-	dp->header = VDO(USB_TYPEC_DP_SID, 1, CMD_EXIT_MODE);
+	dp->header = VDO(USB_TYPEC_DP_SID, 1, common_svdm_ver(dp), CMD_EXIT_MODE);
 	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
 	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
 
@@ -200,7 +201,10 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 
 	switch (cmd_type) {
 	case CMDT_INIT:
-		dp->header = VDO(USB_TYPEC_DP_SID, 1, cmd);
+		if (PD_VDO_SVDM_VER(header) < common_svdm_ver(dp))
+			typec_set_common_svdm_version(dp->con->port, PD_VDO_SVDM_VER(header));
+
+		dp->header = VDO(USB_TYPEC_DP_SID, 1, common_svdm_ver(dp), cmd);
 		dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
 
 		switch (cmd) {
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index ca3f4194ad90..b8d693cc7b77 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -764,6 +764,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	if (con->status.change & UCSI_CONSTAT_CONNECT_CHANGE) {
 		typec_set_pwr_role(con->port, role);
+		typec_set_common_svdm_version(con->port, con->typec_cap.svdm_version);
 
 		switch (UCSI_CONSTAT_PARTNER_TYPE(con->status.flags)) {
 		case UCSI_CONSTAT_PARTNER_TYPE_UFP:
@@ -1052,6 +1053,7 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 
 	cap->revision = ucsi->cap.typec_version;
 	cap->pd_revision = ucsi->cap.pd_version;
+	cap->svdm_version = SVDM_VER_2_0;
 	cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
 
 	if (con->cap.op_mode & UCSI_CONCAP_OPMODE_AUDIO_ACCESSORY)
diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index 8c08eeb9a74b..c30d893c9c81 100644
--- a/include/linux/usb/pd_vdo.h
+++ b/include/linux/usb/pd_vdo.h
@@ -21,22 +21,24 @@
  * ----------
  * <31:16>  :: SVID
  * <15>     :: VDM type ( 1b == structured, 0b == unstructured )
- * <14:13>  :: Structured VDM version (can only be 00 == 1.0 currently)
+ * <14:13>  :: Structured VDM version
  * <12:11>  :: reserved
  * <10:8>   :: object position (1-7 valid ... used for enter/exit mode only)
  * <7:6>    :: command type (SVDM only?)
  * <5>      :: reserved (SVDM), command type (UVDM)
  * <4:0>    :: command
  */
-#define VDO(vid, type, custom)				\
+#define VDO(vid, type, ver, custom)				\
 	(((vid) << 16) |				\
 	 ((type) << 15) |				\
+	 ((ver) << 13) |				\
 	 ((custom) & 0x7FFF))
 
 #define VDO_SVDM_TYPE		(1 << 15)
 #define VDO_SVDM_VERS(x)	((x) << 13)
 #define VDO_OPOS(x)		((x) << 8)
 #define VDO_CMDT(x)		((x) << 6)
+#define VDO_SVDM_VERS_MASK	VDO_SVDM_VERS(0x3)
 #define VDO_OPOS_MASK		VDO_OPOS(0x7)
 #define VDO_CMDT_MASK		VDO_CMDT(0x3)
 
@@ -74,6 +76,7 @@
 
 #define PD_VDO_VID(vdo)		((vdo) >> 16)
 #define PD_VDO_SVDM(vdo)	(((vdo) >> 15) & 1)
+#define PD_VDO_SVDM_VER(vdo)	(((vdo) >> 13) & 0x3)
 #define PD_VDO_OPOS(vdo)	(((vdo) >> 8) & 0x7)
 #define PD_VDO_CMD(vdo)		((vdo) & 0x1f)
 #define PD_VDO_CMDT(vdo)	(((vdo) >> 6) & 0x3)
@@ -103,34 +106,46 @@
  * --------------------
  * <31>     :: data capable as a USB host
  * <30>     :: data capable as a USB device
- * <29:27>  :: product type (UFP / Cable)
+ * <29:27>  :: product type (UFP / Cable / VPD)
  * <26>     :: modal operation supported (1b == yes)
- * <25:16>  :: product type (DFP)
+ * <25:23>  :: product type (DFP) (SVDM version 2.0+ only; set to zero in version 1.0)
+ * <22:21>  :: connector type (SVDM version 2.0+ only; set to zero in version 1.0)
+ * <20:16>  :: Reserved, Shall be set to zero
  * <15:0>   :: USB-IF assigned VID for this cable vendor
  */
-#define IDH_PTYPE_UNDEF		0
+/* SOP Product Type (UFP) */
+#define IDH_PTYPE_NOT_UFP	0
 #define IDH_PTYPE_HUB		1
 #define IDH_PTYPE_PERIPH	2
 #define IDH_PTYPE_PSD		3
 #define IDH_PTYPE_AMA		5
 
+/* SOP' Product Type (Cable Plug / VPD) */
+#define IDH_PTYPE_NOT_CABLE	0
 #define IDH_PTYPE_PCABLE	3
 #define IDH_PTYPE_ACABLE	4
+#define IDH_PTYPE_VPD		6
 
-#define IDH_PTYPE_DFP_UNDEF	0
+/* SOP Product Type (DFP) */
+#define IDH_PTYPE_NOT_DFP	0
 #define IDH_PTYPE_DFP_HUB	1
 #define IDH_PTYPE_DFP_HOST	2
 #define IDH_PTYPE_DFP_PB	3
-#define IDH_PTYPE_DFP_AMC	4
 
-#define VDO_IDH(usbh, usbd, ptype, is_modal, vid)		\
-	((usbh) << 31 | (usbd) << 30 | ((ptype) & 0x7) << 27	\
-	 | (is_modal) << 26 | ((vid) & 0xffff))
+/* ID Header Mask */
+#define IDH_DFP_MASK		GENMASK(25, 23)
+#define IDH_CONN_MASK		GENMASK(22, 21)
+
+#define VDO_IDH(usbh, usbd, ufp_cable, is_modal, dfp, conn, vid)		\
+	((usbh) << 31 | (usbd) << 30 | ((ufp_cable) & 0x7) << 27		\
+	 | (is_modal) << 26 | ((dfp) & 0x7) << 23 | ((conn) & 0x3) << 21	\
+	 | ((vid) & 0xffff))
 
 #define PD_IDH_PTYPE(vdo)	(((vdo) >> 27) & 0x7)
 #define PD_IDH_VID(vdo)		((vdo) & 0xffff)
 #define PD_IDH_MODAL_SUPP(vdo)	((vdo) & (1 << 26))
 #define PD_IDH_DFP_PTYPE(vdo)	(((vdo) >> 23) & 0x7)
+#define PD_IDH_CONN_TYPE(vdo)	(((vdo) >> 21) & 0x3)
 
 /*
  * Cert Stat VDO
@@ -138,6 +153,7 @@
  * <31:0>  : USB-IF assigned XID for this cable
  */
 #define PD_CSTAT_XID(vdo)	(vdo)
+#define VDO_CERT(xid)		((xid) & 0xffffffff)
 
 /*
  * Product VDO
@@ -149,112 +165,267 @@
 #define PD_PRODUCT_PID(vdo)	(((vdo) >> 16) & 0xffff)
 
 /*
- * UFP VDO1
+ * UFP VDO (PD Revision 3.0+ only)
  * --------
  * <31:29> :: UFP VDO version
  * <28>    :: Reserved
  * <27:24> :: Device capability
- * <23:6>  :: Reserved
+ * <23:22> :: Connector type (10b == receptacle, 11b == captive plug)
+ * <21:11> :: Reserved
+ * <10:8>  :: Vconn power (AMA only)
+ * <7>     :: Vconn required (AMA only, 0b == no, 1b == yes)
+ * <6>     :: Vbus required (AMA only, 0b == yes, 1b == no)
  * <5:3>   :: Alternate modes
  * <2:0>   :: USB highest speed
  */
-#define PD_VDO1_UFP_DEVCAP(vdo)	(((vdo) & GENMASK(27, 24)) >> 24)
+#define PD_VDO_UFP_DEVCAP(vdo)	(((vdo) & GENMASK(27, 24)) >> 24)
+
+/* UFP VDO Version */
+#define UFP_VDO_VER1_2		2
 
+/* Device Capability */
 #define DEV_USB2_CAPABLE	BIT(0)
 #define DEV_USB2_BILLBOARD	BIT(1)
 #define DEV_USB3_CAPABLE	BIT(2)
 #define DEV_USB4_CAPABLE	BIT(3)
 
+/* Connector Type */
+#define UFP_RECEPTACLE		2
+#define UFP_CAPTIVE		3
+
+/* Vconn Power (AMA only, set to AMA_VCONN_NOT_REQ if Vconn is not required) */
+#define AMA_VCONN_PWR_1W	0
+#define AMA_VCONN_PWR_1W5	1
+#define AMA_VCONN_PWR_2W	2
+#define AMA_VCONN_PWR_3W	3
+#define AMA_VCONN_PWR_4W	4
+#define AMA_VCONN_PWR_5W	5
+#define AMA_VCONN_PWR_6W	6
+
+/* Vconn Required (AMA only) */
+#define AMA_VCONN_NOT_REQ	0
+#define AMA_VCONN_REQ		1
+
+/* Vbus Required (AMA only) */
+#define AMA_VBUS_REQ		0
+#define AMA_VBUS_NOT_REQ	1
+
+/* Alternate Modes */
+#define UFP_ALTMODE_NOT_SUPP	0
+#define UFP_ALTMODE_TBT3	BIT(0)
+#define UFP_ALTMODE_RECFG	BIT(1)
+#define UFP_ALTMODE_NO_RECFG	BIT(2)
+
+/* USB Highest Speed */
+#define UFP_USB2_ONLY		0
+#define UFP_USB32_GEN1		1
+#define UFP_USB32_4_GEN2	2
+#define UFP_USB4_GEN3		3
+
+#define VDO_UFP(ver, cap, conn, vcpwr, vcr, vbr, alt, spd)			\
+	(((ver) & 0x7) << 29 | ((cap) & 0xf) << 24 | ((conn) & 0x3) << 22	\
+	 | ((vcpwr) & 0x7) << 8 | (vcr) << 7 | (vbr) << 6 | ((alt) & 0x7) << 3	\
+	 | ((spd) & 0x7))
+
 /*
- * DFP VDO
+ * DFP VDO (PD Revision 3.0+ only)
  * --------
  * <31:29> :: DFP VDO version
  * <28:27> :: Reserved
  * <26:24> :: Host capability
- * <23:5>  :: Reserved
+ * <23:22> :: Connector type (10b == receptacle, 11b == captive plug)
+ * <21:5>  :: Reserved
  * <4:0>   :: Port number
  */
 #define PD_VDO_DFP_HOSTCAP(vdo)	(((vdo) & GENMASK(26, 24)) >> 24)
 
+#define DFP_VDO_VER1_1		1
 #define HOST_USB2_CAPABLE	BIT(0)
 #define HOST_USB3_CAPABLE	BIT(1)
 #define HOST_USB4_CAPABLE	BIT(2)
+#define DFP_RECEPTACLE		2
+#define DFP_CAPTIVE		3
+
+#define VDO_DFP(ver, cap, conn, pnum)						\
+	(((ver) & 0x7) << 29 | ((cap) & 0x7) << 24 | ((conn) & 0x3) << 22	\
+	 | ((pnum) & 0x1f))
 
 /*
- * Cable VDO
+ * Passive Cable VDO
  * ---------
  * <31:28> :: Cable HW version
  * <27:24> :: Cable FW version
- * <23:20> :: Reserved, Shall be set to zero
- * <19:18> :: type-C to Type-A/B/C/Captive (00b == A, 01 == B, 10 == C, 11 == Captive)
- * <17>    :: Type-C to Plug/Receptacle (0b == plug, 1b == receptacle)
+ * <23:21> :: VDO version
+ * <20>    :: Reserved, Shall be set to zero
+ * <19:18> :: Type-C to Type-C/Captive (10b == C, 11b == Captive)
+ * <17>    :: Reserved, Shall be set to zero
  * <16:13> :: cable latency (0001 == <10ns(~1m length))
- * <12:11> :: cable termination type (11b == both ends active VCONN req)
- * <10>    :: SSTX1 Directionality support (0b == fixed, 1b == cfgable)
- * <9>     :: SSTX2 Directionality support
- * <8>     :: SSRX1 Directionality support
- * <7>     :: SSRX2 Directionality support
- * <6:5>   :: Vbus current handling capability
+ * <12:11> :: cable termination type (10b == Vconn not req, 01b == Vconn req)
+ * <10:9>  :: Maximum Vbus voltage (00b == 20V, 01b == 30V, 10b == 40V, 11b == 50V)
+ * <8:7>   :: Reserved, Shall be set to zero
+ * <6:5>   :: Vbus current handling capability (01b == 3A, 10b == 5A)
+ * <4:3>   :: Reserved, Shall be set to zero
+ * <2:0>   :: USB highest speed
+ *
+ * Active Cable VDO 1
+ * ---------
+ * <31:28> :: Cable HW version
+ * <27:24> :: Cable FW version
+ * <23:21> :: VDO version
+ * <20>    :: Reserved, Shall be set to zero
+ * <19:18> :: Connector type (10b == C, 11b == Captive)
+ * <17>    :: Reserved, Shall be set to zero
+ * <16:13> :: cable latency (0001 == <10ns(~1m length))
+ * <12:11> :: cable termination type (10b == one end active, 11b == both ends active VCONN req)
+ * <10:9>  :: Maximum Vbus voltage (00b == 20V, 01b == 30V, 10b == 40V, 11b == 50V)
+ * <8>     :: SBU supported (0b == supported, 1b == not supported)
+ * <7>     :: SBU type (0b == passive, 1b == active)
+ * <6:5>   :: Vbus current handling capability (01b == 3A, 10b == 5A)
  * <4>     :: Vbus through cable (0b == no, 1b == yes)
  * <3>     :: SOP" controller present? (0b == no, 1b == yes)
- * <2:0>   :: USB SS Signaling support
+ * <2:0>   :: USB highest speed
  */
-#define CABLE_ATYPE		0
-#define CABLE_BTYPE		1
+/* Cable VDO Version */
+#define CABLE_VDO_VER1_0	0
+#define CABLE_VDO_VER1_3	3
+
+/* Connector Type */
 #define CABLE_CTYPE		2
 #define CABLE_CAPTIVE		3
-#define CABLE_PLUG		0
-#define CABLE_RECEPTACLE	1
-#define CABLE_CURR_1A5		0
+
+/* Cable Latency */
+#define CABLE_LATENCY_1M	1
+#define CABLE_LATENCY_2M	2
+#define CABLE_LATENCY_3M	3
+#define CABLE_LATENCY_4M	4
+#define CABLE_LATENCY_5M	5
+#define CABLE_LATENCY_6M	6
+#define CABLE_LATENCY_7M	7
+#define CABLE_LATENCY_7M_PLUS	8
+
+/* Cable Termination Type */
+#define PCABLE_VCONN_NOT_REQ	0
+#define PCABLE_VCONN_REQ	1
+#define ACABLE_ONE_END		2
+#define ACABLE_BOTH_END		3
+
+/* Maximum Vbus Voltage */
+#define CABLE_MAX_VBUS_20V	0
+#define CABLE_MAX_VBUS_30V	1
+#define CABLE_MAX_VBUS_40V	2
+#define CABLE_MAX_VBUS_50V	3
+
+/* Active Cable SBU Supported/Type */
+#define ACABLE_SBU_SUPP		0
+#define ACABLE_SBU_NOT_SUPP	1
+#define ACABLE_SBU_PASSIVE	0
+#define ACABLE_SBU_ACTIVE	1
+
+/* Vbus Current Handling Capability */
+#define CABLE_CURR_DEF		0
 #define CABLE_CURR_3A		1
 #define CABLE_CURR_5A		2
-#define CABLE_USBSS_U2_ONLY	0
-#define CABLE_USBSS_U31_GEN1	1
-#define CABLE_USBSS_U31_GEN2	2
-#define VDO_CABLE(hw, fw, cbl, gdr, lat, term, tx1d, tx2d, rx1d, rx2d, cur,\
-		  vps, sopp, usbss) \
-	(((hw) & 0x7) << 28 | ((fw) & 0x7) << 24 | ((cbl) & 0x3) << 18	\
-	 | (gdr) << 17 | ((lat) & 0x7) << 13 | ((term) & 0x3) << 11	\
-	 | (tx1d) << 10 | (tx2d) << 9 | (rx1d) << 8 | (rx2d) << 7	\
-	 | ((cur) & 0x3) << 5 | (vps) << 4 | (sopp) << 3		\
-	 | ((usbss) & 0x7))
+
+/* USB Highest Speed */
+#define CABLE_USB2_ONLY		0
+#define CABLE_USB32_GEN1	1
+#define CABLE_USB32_4_GEN2	2
+#define CABLE_USB4_GEN3		3
+
+#define VDO_PCABLE(hw, fw, ver, conn, lat, term, vbm, cur, spd)			\
+	(((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21		\
+	 | ((conn) & 0x3) << 18 | ((lat) & 0xf) << 13 | ((term) & 0x3) << 11	\
+	 | ((vbm) & 0x3) << 9 | ((cur) & 0x3) << 5 | ((spd) & 0x7))
+#define VDO_ACABLE1(hw, fw, ver, conn, lat, term, vbm, sbu, sbut, cur, vbt, sopp, spd) \
+	(((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21		\
+	 | ((conn) & 0x3) << 18	| ((lat) & 0xf) << 13 | ((term) & 0x3) << 11	\
+	 | ((vbm) & 0x3) << 9 | (sbu) << 8 | (sbut) << 7 | ((cur) & 0x3) << 5	\
+	 | (vbt) << 4 | (sopp) << 3 | ((spd) & 0x7))
+
 #define VDO_TYPEC_CABLE_TYPE(vdo)	(((vdo) >> 18) & 0x3)
 
 /*
- * AMA VDO
+ * Active Cable VDO 2
  * ---------
- * <31:28> :: Cable HW version
- * <27:24> :: Cable FW version
- * <23:12> :: Reserved, Shall be set to zero
- * <11>    :: SSTX1 Directionality support (0b == fixed, 1b == cfgable)
- * <10>    :: SSTX2 Directionality support
- * <9>     :: SSRX1 Directionality support
- * <8>     :: SSRX2 Directionality support
- * <7:5>   :: Vconn power
- * <4>     :: Vconn power required
- * <3>     :: Vbus power required
- * <2:0>   :: USB SS Signaling support
+ * <31:24> :: Maximum operating temperature
+ * <23:16> :: Shutdown temperature
+ * <15>    :: Reserved, Shall be set to zero
+ * <14:12> :: U3/CLd power
+ * <11>    :: U3 to U0 transition mode (0b == direct, 1b == through U3S)
+ * <10>    :: Physical connection (0b == copper, 1b == optical)
+ * <9>     :: Active element (0b == redriver, 1b == retimer)
+ * <8>     :: USB4 supported (0b == yes, 1b == no)
+ * <7:6>   :: USB2 hub hops consumed
+ * <5>     :: USB2 supported (0b == yes, 1b == no)
+ * <4>     :: USB3.2 supported (0b == yes, 1b == no)
+ * <3>     :: USB lanes supported (0b == one lane, 1b == two lanes)
+ * <2>     :: Optically isolated active cable (0b == no, 1b == yes)
+ * <1>     :: Reserved, Shall be set to zero
+ * <0>     :: USB gen (0b == gen1, 1b == gen2+)
  */
-#define VDO_AMA(hw, fw, tx1d, tx2d, rx1d, rx2d, vcpwr, vcr, vbr, usbss) \
-	(((hw) & 0x7) << 28 | ((fw) & 0x7) << 24			\
-	 | (tx1d) << 11 | (tx2d) << 10 | (rx1d) << 9 | (rx2d) << 8	\
-	 | ((vcpwr) & 0x7) << 5 | (vcr) << 4 | (vbr) << 3		\
-	 | ((usbss) & 0x7))
-
-#define PD_VDO_AMA_VCONN_REQ(vdo)	(((vdo) >> 4) & 1)
-#define PD_VDO_AMA_VBUS_REQ(vdo)	(((vdo) >> 3) & 1)
+/* U3/CLd Power*/
+#define ACAB2_U3_CLD_10MW_PLUS	0
+#define ACAB2_U3_CLD_10MW	1
+#define ACAB2_U3_CLD_5MW	2
+#define ACAB2_U3_CLD_1MW	3
+#define ACAB2_U3_CLD_500UW	4
+#define ACAB2_U3_CLD_200UW	5
+#define ACAB2_U3_CLD_50UW	6
+
+/* Other Active Cable VDO 2 Fields */
+#define ACAB2_U3U0_DIRECT	0
+#define ACAB2_U3U0_U3S		1
+#define ACAB2_PHY_COPPER	0
+#define ACAB2_PHY_OPTICAL	1
+#define ACAB2_REDRIVER		0
+#define ACAB2_RETIMER		1
+#define ACAB2_USB4_SUPP		0
+#define ACAB2_USB4_NOT_SUPP	1
+#define ACAB2_USB2_SUPP		0
+#define ACAB2_USB2_NOT_SUPP	1
+#define ACAB2_USB32_SUPP	0
+#define ACAB2_USB32_NOT_SUPP	1
+#define ACAB2_LANES_ONE		0
+#define ACAB2_LANES_TWO		1
+#define ACAB2_OPT_ISO_NO	0
+#define ACAB2_OPT_ISO_YES	1
+#define ACAB2_GEN_1		0
+#define ACAB2_GEN_2_PLUS	1
+
+#define VDO_ACABLE2(mtemp, stemp, u3p, trans, phy, ele, u4, hops, u2, u32, lane, iso, gen)	\
+	(((mtemp) & 0xff) << 24 | ((stemp) & 0xff) << 16 | ((u3p) & 0x7) << 12	\
+	 | (trans) << 11 | (phy) << 10 | (ele) << 9 | (u4) << 8			\
+	 | ((hops) & 0x3) << 6 | (u2) << 5 | (u32) << 4 | (lane) << 3		\
+	 | (iso) << 2 | (gen))
 
-#define AMA_VCONN_PWR_1W	0
-#define AMA_VCONN_PWR_1W5	1
-#define AMA_VCONN_PWR_2W	2
-#define AMA_VCONN_PWR_3W	3
-#define AMA_VCONN_PWR_4W	4
-#define AMA_VCONN_PWR_5W	5
-#define AMA_VCONN_PWR_6W	6
-#define AMA_USBSS_U2_ONLY	0
-#define AMA_USBSS_U31_GEN1	1
-#define AMA_USBSS_U31_GEN2	2
-#define AMA_USBSS_BBONLY	3
+/*
+ * VPD VDO
+ * ---------
+ * <31:28> :: HW version
+ * <27:24> :: FW version
+ * <23:21> :: VDO version
+ * <20:17> :: Reserved, Shall be set to zero
+ * <16:15> :: Maximum Vbus voltage (00b == 20V, 01b == 30V, 10b == 40V, 11b == 50V)
+ * <14>    :: Charge through current support (0b == 3A, 1b == 5A)
+ * <13>    :: Reserved, Shall be set to zero
+ * <12:7>  :: Vbus impedance
+ * <6:1>   :: Ground impedance
+ * <0>     :: Charge through support (0b == no, 1b == yes)
+ */
+#define VPD_VDO_VER1_0		0
+#define VPD_MAX_VBUS_20V	0
+#define VPD_MAX_VBUS_30V	1
+#define VPD_MAX_VBUS_40V	2
+#define VPD_MAX_VBUS_50V	3
+#define VPDCT_CURR_3A		0
+#define VPDCT_CURR_5A		1
+#define VPDCT_NOT_SUPP		0
+#define VPDCT_SUPP		1
+
+#define VDO_VPD(hw, fw, ver, vbm, curr, vbi, gi, ct)			\
+	(((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21	\
+	 | ((vbm) & 0x3) << 15 | (curr) << 14 | ((vbi) & 0x3f) << 7	\
+	 | ((gi) & 0x3f) << 1 | (ct))
 
 /*
  * SVDM Discover SVIDs request -> response
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 54475323f83b..df0cb1e595a1 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -206,12 +206,19 @@ struct typec_operations {
 			     enum typec_port_type type);
 };
 
+enum usb_pd_svdm_ver {
+	SVDM_VER_1_0 = 0,
+	SVDM_VER_2_0 = 1,
+	SVDM_VER_MAX = SVDM_VER_2_0,
+};
+
 /*
  * struct typec_capability - USB Type-C Port Capabilities
  * @type: Supported power role of the port
  * @data: Supported data role of the port
  * @revision: USB Type-C Specification release. Binary coded decimal
  * @pd_revision: USB Power Delivery Specification revision if supported
+ * @svdm_version: USB PD Structured VDM version if supported
  * @prefer_role: Initial role preference (DRP ports).
  * @accessory: Supported Accessory Modes
  * @fwnode: Optional fwnode of the port
@@ -225,6 +232,7 @@ struct typec_capability {
 	enum typec_port_data	data;
 	u16			revision; /* 0120H = "1.2" */
 	u16			pd_revision; /* 0300H = "3.0" */
+	enum usb_pd_svdm_ver	svdm_version;
 	int			prefer_role;
 	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
 	unsigned int		orientation_aware:1;
@@ -275,4 +283,6 @@ int typec_find_orientation(const char *name);
 int typec_find_port_power_role(const char *name);
 int typec_find_power_role(const char *name);
 int typec_find_port_data_role(const char *name);
+void typec_set_common_svdm_version(struct typec_port *port, enum usb_pd_svdm_ver);
+enum usb_pd_svdm_ver typec_get_common_svdm_version(struct typec_port *port);
 #endif /* __LINUX_USB_TYPEC_H */
-- 
2.30.0.365.g02bc693789-goog

