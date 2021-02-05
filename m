Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292A63103A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhBEDfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhBEDfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:35:44 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BEFC0617A7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 19:34:30 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 70so4601936qkh.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 19:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2sRzvrtkMNmjYd9r0z3mnWmtmszbFHlTUAv1bsnMvco=;
        b=cb7SV9xVklC4mvbofOON9+GX9Pl7vI2DeLyjvNzgz5vZH1Hu2MdR6WZAWZadOLv95F
         eahEYsdr8eN0zbwcwU7GWiqce2bvdgg0ptLMkDLjWAISKuYWCHxI2avN9XsHY1MhgreF
         kAqbXv5ymU7mjQRQpY6oRq0n8i6c+xcXNcjDsVjXd0GmHF8N+ni2ykAqddxVGMwwT29w
         JOmOI4jBmqK4A1N7FBZms3mwgzBLcDZL8udmHcG0S5IY/y6/OQ5u4ISIkuDnIHPwv6tT
         ts0A+g5jqd7H9/Xptt02qbbB2ca8MaKIO/4sTk1hy2+hxhLVUv903UVJbpTC6YAGPx3T
         JP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2sRzvrtkMNmjYd9r0z3mnWmtmszbFHlTUAv1bsnMvco=;
        b=FBzxouP2oocJBip0d2eJSKEyQGvu2LvXPX0RzO5ZM4dYkMDXPl8uwSJb9CtDmyUAda
         zvmH9F6OmSWhKB5zOoNEqiQf0J8z8En/exZjzaGKnFMwJ2oJlXvRHh8NowEwUTI1FQIo
         orPiUcr3ry36adE0O9l5vyniTCTsZWQ46Ie1/KFSvXY4YcfZtgiTriH58NW3xv0KF4Cy
         8lhsFv2M8cQV53SXAxfH2kSwn9mmbr2J1WP5F0A8qpHgdLdWN37eqV1zK+NF0AuwZqgU
         clxOrAuF0ZGTuIwVWIcX7RbDWGeyO9U+Pg7eqZsevmPeyNH9kNKtYhq0oXPgcSCEhUtd
         wKJg==
X-Gm-Message-State: AOAM532k5POnokytt1mQtczGBLhGyvBHUTCVee9LsiOhe4f7QrBX+KiF
        BDs/fiPkCo17tp54MAe5O/J5OdutyB4+
X-Google-Smtp-Source: ABdhPJwzsh6lyjRIV3qJFMLawffw1w6x+NFlnPr41QpnmccPNj2j882p6UZeT8jrdHzDniPT8oSk+m58apuB
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:dd94:c753:a81d:c855])
 (user=kyletso job=sendgmr) by 2002:a0c:f98b:: with SMTP id
 t11mr2519561qvn.11.1612496069820; Thu, 04 Feb 2021 19:34:29 -0800 (PST)
Date:   Fri,  5 Feb 2021 11:34:10 +0800
In-Reply-To: <20210205033415.3320439-1-kyletso@google.com>
Message-Id: <20210205033415.3320439-3-kyletso@google.com>
Mime-Version: 1.0
References: <20210205033415.3320439-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v6 2/7] usb: pd: Make SVDM Version configurable in VDM header
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

PD Rev 3.0 introduces SVDM Version 2.0. This patch makes the field
configuable in the header in order to be able to be compatible with
older SVDM version.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v5:
- no change

 drivers/usb/typec/altmodes/displayport.c |  2 +-
 drivers/usb/typec/tcpm/tcpm.c            | 16 ++++++++--------
 drivers/usb/typec/ucsi/displayport.c     |  6 +++---
 include/linux/usb/pd_vdo.h               |  7 +++++--
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index e62e5e3da01e..0abc3121238f 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -15,7 +15,7 @@
 #include <linux/usb/typec_dp.h>
 #include "displayport.h"
 
-#define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, cmd) | \
+#define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, SVDM_VER_1_0, cmd) | \
 					 VDO_OPOS(USB_TYPEC_DP_MODE))
 
 enum {
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 8558ab006885..9aadb1e1bec5 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1544,17 +1544,17 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 		case CMD_DISCOVER_IDENT:
 			/* 6.4.4.3.1 */
 			svdm_consume_identity(port, p, cnt);
-			response[0] = VDO(USB_SID_PD, 1, CMD_DISCOVER_SVID);
+			response[0] = VDO(USB_SID_PD, 1, SVDM_VER_1_0, CMD_DISCOVER_SVID);
 			rlen = 1;
 			break;
 		case CMD_DISCOVER_SVID:
 			/* 6.4.4.3.2 */
 			if (svdm_consume_svids(port, p, cnt)) {
-				response[0] = VDO(USB_SID_PD, 1,
+				response[0] = VDO(USB_SID_PD, 1, SVDM_VER_1_0,
 						  CMD_DISCOVER_SVID);
 				rlen = 1;
 			} else if (modep->nsvids && supports_modal(port)) {
-				response[0] = VDO(modep->svids[0], 1,
+				response[0] = VDO(modep->svids[0], 1, SVDM_VER_1_0,
 						  CMD_DISCOVER_MODES);
 				rlen = 1;
 			}
@@ -1565,7 +1565,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			modep->svid_index++;
 			if (modep->svid_index < modep->nsvids) {
 				u16 svid = modep->svids[modep->svid_index];
-				response[0] = VDO(svid, 1, CMD_DISCOVER_MODES);
+				response[0] = VDO(svid, 1, SVDM_VER_1_0, CMD_DISCOVER_MODES);
 				rlen = 1;
 			} else {
 				tcpm_register_partner_altmodes(port);
@@ -1695,7 +1695,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			break;
 		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
 			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
-				response[0] = VDO(adev->svid, 1, CMD_EXIT_MODE);
+				response[0] = VDO(adev->svid, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
 				response[0] |= VDO_OPOS(adev->mode);
 				rlen = 1;
 			}
@@ -1729,7 +1729,7 @@ static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
 
 	/* set VDM header with VID & CMD */
 	header = VDO(vid, ((vid & USB_SID_PD) == USB_SID_PD) ?
-			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION), cmd);
+			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION), SVDM_VER_1_0, cmd);
 	tcpm_queue_vdm(port, header, data, count);
 }
 
@@ -2024,7 +2024,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 	u32 header;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, vdo ? 2 : 1, SVDM_VER_1_0, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
@@ -2036,7 +2036,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 	u32 header;
 
-	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
+	header = VDO(altmode->svid, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 261131c9e37c..1d387bddefb9 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -83,7 +83,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	 * mode, and letting the alt mode driver continue.
 	 */
 
-	dp->header = VDO(USB_TYPEC_DP_SID, 1, CMD_ENTER_MODE);
+	dp->header = VDO(USB_TYPEC_DP_SID, 1, SVDM_VER_1_0, CMD_ENTER_MODE);
 	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
 	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
 
@@ -120,7 +120,7 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
 	if (ret < 0)
 		goto out_unlock;
 
-	dp->header = VDO(USB_TYPEC_DP_SID, 1, CMD_EXIT_MODE);
+	dp->header = VDO(USB_TYPEC_DP_SID, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
 	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
 	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
 
@@ -200,7 +200,7 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 
 	switch (cmd_type) {
 	case CMDT_INIT:
-		dp->header = VDO(USB_TYPEC_DP_SID, 1, cmd);
+		dp->header = VDO(USB_TYPEC_DP_SID, 1, SVDM_VER_1_0, cmd);
 		dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
 
 		switch (cmd) {
diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index 5de7f550f93e..b057250704e8 100644
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
+#define VDO(vid, type, ver, custom)			\
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
-- 
2.30.0.365.g02bc693789-goog

