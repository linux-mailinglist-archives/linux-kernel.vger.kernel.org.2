Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E903C9B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbhGOJL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:11:28 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44528 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240846AbhGOJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:11:16 -0400
X-UUID: bf776271c7cb447fbcb6f439a42a5d65-20210715
X-UUID: bf776271c7cb447fbcb6f439a42a5d65-20210715
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 416952941; Thu, 15 Jul 2021 17:08:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:08:18 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:08:17 +0800
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
Subject: [PATCH v3 07/13] usb: mtu3: support property role-switch-default-mode
Date:   Thu, 15 Jul 2021 17:07:52 +0800
Message-ID: <1626340078-29111-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support default mode config when use usb-role-switch

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~3: no changes
---
 drivers/usb/mtu3/mtu3.h    |  2 ++
 drivers/usb/mtu3/mtu3_dr.c | 24 ++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 5546b868b08b..bc82c7f97ad6 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -199,6 +199,7 @@ struct mtu3_gpd_ring {
 * @id_nb : notifier for iddig(idpin) detection
 * @dr_work : work for drd mode switch, used to avoid sleep in atomic context
 * @desired_role : role desired to switch
+* @default_role : default mode while usb role is USB_ROLE_NONE
 * @role_sw : use USB Role Switch to support dual-role switch, can't use
 *		extcon at the same time, and extcon is deprecated.
 * @role_sw_used : true when the USB Role Switch is used.
@@ -212,6 +213,7 @@ struct otg_switch_mtk {
 	struct notifier_block id_nb;
 	struct work_struct dr_work;
 	enum usb_role desired_role;
+	enum usb_role default_role;
 	struct usb_role_switch *role_sw;
 	bool role_sw_used;
 	bool is_u3_drd;
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 318fbc618137..30e7e5fc0f88 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -137,8 +137,12 @@ static void ssusb_mode_sw_work(struct work_struct *work)
 
 	current_role = ssusb->is_host ? USB_ROLE_HOST : USB_ROLE_DEVICE;
 
-	if (desired_role == USB_ROLE_NONE)
+	if (desired_role == USB_ROLE_NONE) {
+		/* the default mode is host as probe does */
 		desired_role = USB_ROLE_HOST;
+		if (otg_sx->default_role == USB_ROLE_DEVICE)
+			desired_role = USB_ROLE_DEVICE;
+	}
 
 	if (current_role == desired_role)
 		return;
@@ -274,17 +278,29 @@ static int ssusb_role_sw_register(struct otg_switch_mtk *otg_sx)
 {
 	struct usb_role_switch_desc role_sx_desc = { 0 };
 	struct ssusb_mtk *ssusb = otg_sx_to_ssusb(otg_sx);
+	struct device *dev = ssusb->dev;
+	enum usb_dr_mode mode;
 
 	if (!otg_sx->role_sw_used)
 		return 0;
 
+	mode = usb_get_role_switch_default_mode(dev);
+	if (mode == USB_DR_MODE_PERIPHERAL)
+		otg_sx->default_role = USB_ROLE_DEVICE;
+	else
+		otg_sx->default_role = USB_ROLE_HOST;
+
 	role_sx_desc.set = ssusb_role_sw_set;
 	role_sx_desc.get = ssusb_role_sw_get;
-	role_sx_desc.fwnode = dev_fwnode(ssusb->dev);
+	role_sx_desc.fwnode = dev_fwnode(dev);
 	role_sx_desc.driver_data = ssusb;
-	otg_sx->role_sw = usb_role_switch_register(ssusb->dev, &role_sx_desc);
+	otg_sx->role_sw = usb_role_switch_register(dev, &role_sx_desc);
+	if (IS_ERR(otg_sx->role_sw))
+		return PTR_ERR(otg_sx->role_sw);
 
-	return PTR_ERR_OR_ZERO(otg_sx->role_sw);
+	ssusb_set_mode(otg_sx, otg_sx->default_role);
+
+	return 0;
 }
 
 int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
-- 
2.18.0

