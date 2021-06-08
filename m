Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B2239F03C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhFHIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:00:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53409 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230508AbhFHIAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:00:02 -0400
X-UUID: 85fd1e8ed4a440da9bc54b8049bee8e1-20210608
X-UUID: 85fd1e8ed4a440da9bc54b8049bee8e1-20210608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 3534966; Tue, 08 Jun 2021 15:58:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:58:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:58:03 +0800
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
Subject: [PATCH 08/23] usb: mtu3: drop support vbus detection
Date:   Tue, 8 Jun 2021 15:57:34 +0800
Message-ID: <1623139069-8173-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now it's never used on any platform, and will not used
later.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h    |  7 ------
 drivers/usb/mtu3/mtu3_dr.c | 50 ++------------------------------------
 2 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 531b9c78d7c3..df2856782426 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -192,10 +192,6 @@ struct mtu3_gpd_ring {
 /**
 * @vbus: vbus 5V used by host mode
 * @edev: external connector used to detect vbus and iddig changes
-* @vbus_nb: notifier for vbus detection
-* @vbus_work : work of vbus detection notifier, used to avoid sleep in
-*		notifier callback which is atomic context
-* @vbus_event : event of vbus detecion notifier
 * @id_nb : notifier for iddig(idpin) detection
 * @id_work : work of iddig detection notifier
 * @id_event : event of iddig detecion notifier
@@ -209,9 +205,6 @@ struct mtu3_gpd_ring {
 struct otg_switch_mtk {
 	struct regulator *vbus;
 	struct extcon_dev *edev;
-	struct notifier_block vbus_nb;
-	struct work_struct vbus_work;
-	unsigned long vbus_event;
 	struct notifier_block id_nb;
 	struct work_struct id_work;
 	unsigned long id_event;
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 82301001f2f6..89ad448f2b2d 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -147,10 +147,6 @@ int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on)
 	return 0;
 }
 
-/*
- * switch to host: -> MTU3_VBUS_OFF --> MTU3_ID_GROUND
- * switch to device: -> MTU3_ID_FLOAT --> MTU3_VBUS_VALID
- */
 static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
 	enum mtu3_vbus_id_state status)
 {
@@ -163,6 +159,7 @@ static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
 
 	switch (status) {
 	case MTU3_ID_GROUND:
+		mtu3_stop(mtu);
 		switch_port_to_host(ssusb);
 		ssusb_set_vbus(otg_sx, 1);
 		ssusb->is_host = true;
@@ -171,11 +168,6 @@ static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
 		ssusb->is_host = false;
 		ssusb_set_vbus(otg_sx, 0);
 		switch_port_to_device(ssusb);
-		break;
-	case MTU3_VBUS_OFF:
-		mtu3_stop(mtu);
-		break;
-	case MTU3_VBUS_VALID:
 		mtu3_start(mtu);
 		break;
 	default:
@@ -194,17 +186,6 @@ static void ssusb_id_work(struct work_struct *work)
 		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
 }
 
-static void ssusb_vbus_work(struct work_struct *work)
-{
-	struct otg_switch_mtk *otg_sx =
-		container_of(work, struct otg_switch_mtk, vbus_work);
-
-	if (otg_sx->vbus_event)
-		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
-	else
-		ssusb_set_mailbox(otg_sx, MTU3_VBUS_OFF);
-}
-
 /*
  * @ssusb_id_notifier is called in atomic context, but @ssusb_set_mailbox
  * may sleep, so use work queue here
@@ -221,18 +202,6 @@ static int ssusb_id_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static int ssusb_vbus_notifier(struct notifier_block *nb,
-	unsigned long event, void *ptr)
-{
-	struct otg_switch_mtk *otg_sx =
-		container_of(nb, struct otg_switch_mtk, vbus_nb);
-
-	otg_sx->vbus_event = event;
-	schedule_work(&otg_sx->vbus_work);
-
-	return NOTIFY_DONE;
-}
-
 static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
 {
 	struct ssusb_mtk *ssusb =
@@ -244,14 +213,6 @@ static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
 	if (!edev)
 		return 0;
 
-	otg_sx->vbus_nb.notifier_call = ssusb_vbus_notifier;
-	ret = devm_extcon_register_notifier(ssusb->dev, edev, EXTCON_USB,
-					&otg_sx->vbus_nb);
-	if (ret < 0) {
-		dev_err(ssusb->dev, "failed to register notifier for USB\n");
-		return ret;
-	}
-
 	otg_sx->id_nb.notifier_call = ssusb_id_notifier;
 	ret = devm_extcon_register_notifier(ssusb->dev, edev, EXTCON_USB_HOST,
 					&otg_sx->id_nb);
@@ -260,15 +221,12 @@ static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
 		return ret;
 	}
 
-	dev_dbg(ssusb->dev, "EXTCON_USB: %d, EXTCON_USB_HOST: %d\n",
-		extcon_get_state(edev, EXTCON_USB),
+	dev_dbg(ssusb->dev, "EXTCON_USB_HOST: %d\n",
 		extcon_get_state(edev, EXTCON_USB_HOST));
 
 	/* default as host, switch to device mode if needed */
 	if (extcon_get_state(edev, EXTCON_USB_HOST) == false)
 		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
-	if (extcon_get_state(edev, EXTCON_USB) == true)
-		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
 
 	return 0;
 }
@@ -285,12 +243,10 @@ void ssusb_mode_switch(struct ssusb_mtk *ssusb, int to_host)
 
 	if (to_host) {
 		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_HOST);
-		ssusb_set_mailbox(otg_sx, MTU3_VBUS_OFF);
 		ssusb_set_mailbox(otg_sx, MTU3_ID_GROUND);
 	} else {
 		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_DEVICE);
 		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
-		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
 	}
 }
 
@@ -365,7 +321,6 @@ int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 	int ret = 0;
 
 	INIT_WORK(&otg_sx->id_work, ssusb_id_work);
-	INIT_WORK(&otg_sx->vbus_work, ssusb_vbus_work);
 
 	if (otg_sx->manual_drd_enabled)
 		ssusb_dr_debugfs_init(ssusb);
@@ -382,6 +337,5 @@ void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
 	cancel_work_sync(&otg_sx->id_work);
-	cancel_work_sync(&otg_sx->vbus_work);
 	usb_role_switch_unregister(otg_sx->role_sw);
 }
-- 
2.18.0

