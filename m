Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C4939F039
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhFHIAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:00:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49337 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230475AbhFHIAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:00:01 -0400
X-UUID: 46e9a1638e11407b8b74b780c374e03a-20210608
X-UUID: 46e9a1638e11407b8b74b780c374e03a-20210608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1208718175; Tue, 08 Jun 2021 15:58:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:58:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:58:04 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yuwen Ng <yuwen.ng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 09/23] usb: mtu3: use enum usb_role instead of private defined ones
Date:   Tue, 8 Jun 2021 15:57:35 +0800
Message-ID: <1623139069-8173-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we mainly use usb-role-switch to set dual role mode, and all
three ways supported use the same function to switch mode, use
usb_role enum will make code clear

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_dr.c | 52 +++++++++++---------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 89ad448f2b2d..7eabce9d5f3b 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -16,29 +16,6 @@
 #define USB2_PORT 2
 #define USB3_PORT 3
 
-enum mtu3_vbus_id_state {
-	MTU3_ID_FLOAT = 1,
-	MTU3_ID_GROUND,
-	MTU3_VBUS_OFF,
-	MTU3_VBUS_VALID,
-};
-
-static char *mailbox_state_string(enum mtu3_vbus_id_state state)
-{
-	switch (state) {
-	case MTU3_ID_FLOAT:
-		return "ID_FLOAT";
-	case MTU3_ID_GROUND:
-		return "ID_GROUND";
-	case MTU3_VBUS_OFF:
-		return "VBUS_OFF";
-	case MTU3_VBUS_VALID:
-		return "VBUS_VALID";
-	default:
-		return "UNKNOWN";
-	}
-}
-
 static void toggle_opstate(struct ssusb_mtk *ssusb)
 {
 	if (!ssusb->otg_switch.is_u3_drd) {
@@ -147,31 +124,32 @@ int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on)
 	return 0;
 }
 
-static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
-	enum mtu3_vbus_id_state status)
+static void ssusb_set_role(struct otg_switch_mtk *otg_sx, enum usb_role role)
 {
 	struct ssusb_mtk *ssusb =
 		container_of(otg_sx, struct ssusb_mtk, otg_switch);
 	struct mtu3 *mtu = ssusb->u3d;
 
-	dev_dbg(ssusb->dev, "mailbox %s\n", mailbox_state_string(status));
-	mtu3_dbg_trace(ssusb->dev, "mailbox %s", mailbox_state_string(status));
+	dev_dbg(ssusb->dev, "set role : %d\n", role);
+	mtu3_dbg_trace(ssusb->dev, "set role : %d", role);
 
-	switch (status) {
-	case MTU3_ID_GROUND:
+	switch (role) {
+	case USB_ROLE_HOST:
 		mtu3_stop(mtu);
 		switch_port_to_host(ssusb);
 		ssusb_set_vbus(otg_sx, 1);
 		ssusb->is_host = true;
 		break;
-	case MTU3_ID_FLOAT:
+	case USB_ROLE_DEVICE:
 		ssusb->is_host = false;
 		ssusb_set_vbus(otg_sx, 0);
 		switch_port_to_device(ssusb);
 		mtu3_start(mtu);
 		break;
+	case USB_ROLE_NONE:
+		break;
 	default:
-		dev_err(ssusb->dev, "invalid state\n");
+		dev_err(ssusb->dev, "invalid role\n");
 	}
 }
 
@@ -181,13 +159,13 @@ static void ssusb_id_work(struct work_struct *work)
 		container_of(work, struct otg_switch_mtk, id_work);
 
 	if (otg_sx->id_event)
-		ssusb_set_mailbox(otg_sx, MTU3_ID_GROUND);
+		ssusb_set_role(otg_sx, USB_ROLE_HOST);
 	else
-		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
+		ssusb_set_role(otg_sx, USB_ROLE_DEVICE);
 }
 
 /*
- * @ssusb_id_notifier is called in atomic context, but @ssusb_set_mailbox
+ * @ssusb_id_notifier is called in atomic context, but ssusb_set_role()
  * may sleep, so use work queue here
  */
 static int ssusb_id_notifier(struct notifier_block *nb,
@@ -226,7 +204,7 @@ static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
 
 	/* default as host, switch to device mode if needed */
 	if (extcon_get_state(edev, EXTCON_USB_HOST) == false)
-		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
+		ssusb_set_role(otg_sx, USB_ROLE_DEVICE);
 
 	return 0;
 }
@@ -243,10 +221,10 @@ void ssusb_mode_switch(struct ssusb_mtk *ssusb, int to_host)
 
 	if (to_host) {
 		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_HOST);
-		ssusb_set_mailbox(otg_sx, MTU3_ID_GROUND);
+		ssusb_set_role(otg_sx, USB_ROLE_HOST);
 	} else {
 		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_DEVICE);
-		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
+		ssusb_set_role(otg_sx, USB_ROLE_DEVICE);
 	}
 }
 
-- 
2.18.0

