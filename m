Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6722939F03E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFHIAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:00:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53422 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230473AbhFHIAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:00:03 -0400
X-UUID: 8c09d2b8981a42c8b79a01d95003533d-20210608
X-UUID: 8c09d2b8981a42c8b79a01d95003533d-20210608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 911552793; Tue, 08 Jun 2021 15:58:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:58:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:58:05 +0800
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
Subject: [PATCH 10/23] usb: mtu3: rebuild role switch flow of extcon
Date:   Tue, 8 Jun 2021 15:57:36 +0800
Message-ID: <1623139069-8173-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch to plan to use the same work to
handle role switch for all three supported ways.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h    |  9 +++---
 drivers/usb/mtu3/mtu3_dr.c | 61 +++++++++++++++++++++-----------------
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index df2856782426..daf2b294ccdf 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -21,6 +21,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 
 struct mtu3;
 struct mtu3_ep;
@@ -193,8 +194,8 @@ struct mtu3_gpd_ring {
 * @vbus: vbus 5V used by host mode
 * @edev: external connector used to detect vbus and iddig changes
 * @id_nb : notifier for iddig(idpin) detection
-* @id_work : work of iddig detection notifier
-* @id_event : event of iddig detecion notifier
+* @dr_work : work for drd mode switch, used to avoid sleep in atomic context
+* @desired_role : role desired to switch
 * @role_sw : use USB Role Switch to support dual-role switch, can't use
 *		extcon at the same time, and extcon is deprecated.
 * @role_sw_used : true when the USB Role Switch is used.
@@ -206,8 +207,8 @@ struct otg_switch_mtk {
 	struct regulator *vbus;
 	struct extcon_dev *edev;
 	struct notifier_block id_nb;
-	struct work_struct id_work;
-	unsigned long id_event;
+	struct work_struct dr_work;
+	enum usb_role desired_role;
 	struct usb_role_switch *role_sw;
 	bool role_sw_used;
 	bool is_u3_drd;
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 7eabce9d5f3b..1cf56f129b15 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -7,8 +7,6 @@
  * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
  */
 
-#include <linux/usb/role.h>
-
 #include "mtu3.h"
 #include "mtu3_dr.h"
 #include "mtu3_debug.h"
@@ -124,16 +122,28 @@ int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on)
 	return 0;
 }
 
-static void ssusb_set_role(struct otg_switch_mtk *otg_sx, enum usb_role role)
+static void ssusb_mode_sw_work(struct work_struct *work)
 {
+	struct otg_switch_mtk *otg_sx =
+		container_of(work, struct otg_switch_mtk, dr_work);
 	struct ssusb_mtk *ssusb =
 		container_of(otg_sx, struct ssusb_mtk, otg_switch);
 	struct mtu3 *mtu = ssusb->u3d;
+	enum usb_role desired_role = otg_sx->desired_role;
+	enum usb_role current_role;
+
+	current_role = ssusb->is_host ? USB_ROLE_HOST : USB_ROLE_DEVICE;
+
+	if (desired_role == USB_ROLE_NONE)
+		desired_role = USB_ROLE_HOST;
 
-	dev_dbg(ssusb->dev, "set role : %d\n", role);
-	mtu3_dbg_trace(ssusb->dev, "set role : %d", role);
+	if (current_role == desired_role)
+		return;
+
+	dev_dbg(ssusb->dev, "set role : %s\n", usb_role_string(desired_role));
+	mtu3_dbg_trace(ssusb->dev, "set role : %s", usb_role_string(desired_role));
 
-	switch (role) {
+	switch (desired_role) {
 	case USB_ROLE_HOST:
 		mtu3_stop(mtu);
 		switch_port_to_host(ssusb);
@@ -147,35 +157,30 @@ static void ssusb_set_role(struct otg_switch_mtk *otg_sx, enum usb_role role)
 		mtu3_start(mtu);
 		break;
 	case USB_ROLE_NONE:
-		break;
 	default:
 		dev_err(ssusb->dev, "invalid role\n");
 	}
 }
 
-static void ssusb_id_work(struct work_struct *work)
+static void ssusb_set_mode(struct otg_switch_mtk *otg_sx, enum usb_role role)
 {
-	struct otg_switch_mtk *otg_sx =
-		container_of(work, struct otg_switch_mtk, id_work);
+	struct ssusb_mtk *ssusb =
+		container_of(otg_sx, struct ssusb_mtk, otg_switch);
 
-	if (otg_sx->id_event)
-		ssusb_set_role(otg_sx, USB_ROLE_HOST);
-	else
-		ssusb_set_role(otg_sx, USB_ROLE_DEVICE);
+	if (ssusb->dr_mode != USB_DR_MODE_OTG)
+		return;
+
+	otg_sx->desired_role = role;
+	queue_work(system_freezable_wq, &otg_sx->dr_work);
 }
 
-/*
- * @ssusb_id_notifier is called in atomic context, but ssusb_set_role()
- * may sleep, so use work queue here
- */
 static int ssusb_id_notifier(struct notifier_block *nb,
 	unsigned long event, void *ptr)
 {
 	struct otg_switch_mtk *otg_sx =
 		container_of(nb, struct otg_switch_mtk, id_nb);
 
-	otg_sx->id_event = event;
-	schedule_work(&otg_sx->id_work);
+	ssusb_set_mode(otg_sx, event ? USB_ROLE_HOST : USB_ROLE_DEVICE);
 
 	return NOTIFY_DONE;
 }
@@ -199,12 +204,12 @@ static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
 		return ret;
 	}
 
-	dev_dbg(ssusb->dev, "EXTCON_USB_HOST: %d\n",
-		extcon_get_state(edev, EXTCON_USB_HOST));
+	ret = extcon_get_state(edev, EXTCON_USB_HOST);
+	dev_dbg(ssusb->dev, "EXTCON_USB_HOST: %d\n", ret);
 
 	/* default as host, switch to device mode if needed */
-	if (extcon_get_state(edev, EXTCON_USB_HOST) == false)
-		ssusb_set_role(otg_sx, USB_ROLE_DEVICE);
+	if (!ret)
+		ssusb_set_mode(otg_sx, USB_ROLE_DEVICE);
 
 	return 0;
 }
@@ -221,10 +226,10 @@ void ssusb_mode_switch(struct ssusb_mtk *ssusb, int to_host)
 
 	if (to_host) {
 		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_HOST);
-		ssusb_set_role(otg_sx, USB_ROLE_HOST);
+		ssusb_set_mode(otg_sx, USB_ROLE_HOST);
 	} else {
 		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_DEVICE);
-		ssusb_set_role(otg_sx, USB_ROLE_DEVICE);
+		ssusb_set_mode(otg_sx, USB_ROLE_DEVICE);
 	}
 }
 
@@ -298,7 +303,7 @@ int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 	int ret = 0;
 
-	INIT_WORK(&otg_sx->id_work, ssusb_id_work);
+	INIT_WORK(&otg_sx->dr_work, ssusb_mode_sw_work);
 
 	if (otg_sx->manual_drd_enabled)
 		ssusb_dr_debugfs_init(ssusb);
@@ -314,6 +319,6 @@ void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
-	cancel_work_sync(&otg_sx->id_work);
+	cancel_work_sync(&otg_sx->dr_work);
 	usb_role_switch_unregister(otg_sx->role_sw);
 }
-- 
2.18.0

