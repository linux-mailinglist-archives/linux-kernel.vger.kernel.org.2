Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C2939F03F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhFHIA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:00:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49376 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230525AbhFHIAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:00:04 -0400
X-UUID: 6942b27bea5b4653b3877847b9233af5-20210608
X-UUID: 6942b27bea5b4653b3877847b9233af5-20210608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 889753829; Tue, 08 Jun 2021 15:58:08 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:58:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:58:06 +0800
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
Subject: [PATCH 11/23] usb: mtu3: add helper to get pointer of ssusb_mtk struct
Date:   Tue, 8 Jun 2021 15:57:37 +0800
Message-ID: <1623139069-8173-12-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to get pointer of ssusb_mtk struct from the pointer
of otg_switch_mtk struct.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_dr.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 1cf56f129b15..486d26a366b8 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -14,6 +14,11 @@
 #define USB2_PORT 2
 #define USB3_PORT 3
 
+static inline struct ssusb_mtk *otg_sx_to_ssusb(struct otg_switch_mtk *otg_sx)
+{
+	return container_of(otg_sx, struct ssusb_mtk, otg_switch);
+}
+
 static void toggle_opstate(struct ssusb_mtk *ssusb)
 {
 	if (!ssusb->otg_switch.is_u3_drd) {
@@ -98,8 +103,7 @@ static void switch_port_to_device(struct ssusb_mtk *ssusb)
 
 int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on)
 {
-	struct ssusb_mtk *ssusb =
-		container_of(otg_sx, struct ssusb_mtk, otg_switch);
+	struct ssusb_mtk *ssusb = otg_sx_to_ssusb(otg_sx);
 	struct regulator *vbus = otg_sx->vbus;
 	int ret;
 
@@ -126,8 +130,7 @@ static void ssusb_mode_sw_work(struct work_struct *work)
 {
 	struct otg_switch_mtk *otg_sx =
 		container_of(work, struct otg_switch_mtk, dr_work);
-	struct ssusb_mtk *ssusb =
-		container_of(otg_sx, struct ssusb_mtk, otg_switch);
+	struct ssusb_mtk *ssusb = otg_sx_to_ssusb(otg_sx);
 	struct mtu3 *mtu = ssusb->u3d;
 	enum usb_role desired_role = otg_sx->desired_role;
 	enum usb_role current_role;
@@ -164,8 +167,7 @@ static void ssusb_mode_sw_work(struct work_struct *work)
 
 static void ssusb_set_mode(struct otg_switch_mtk *otg_sx, enum usb_role role)
 {
-	struct ssusb_mtk *ssusb =
-		container_of(otg_sx, struct ssusb_mtk, otg_switch);
+	struct ssusb_mtk *ssusb = otg_sx_to_ssusb(otg_sx);
 
 	if (ssusb->dr_mode != USB_DR_MODE_OTG)
 		return;
@@ -187,8 +189,7 @@ static int ssusb_id_notifier(struct notifier_block *nb,
 
 static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
 {
-	struct ssusb_mtk *ssusb =
-		container_of(otg_sx, struct ssusb_mtk, otg_switch);
+	struct ssusb_mtk *ssusb = otg_sx_to_ssusb(otg_sx);
 	struct extcon_dev *edev = otg_sx->edev;
 	int ret;
 
@@ -283,8 +284,7 @@ static enum usb_role ssusb_role_sw_get(struct usb_role_switch *sw)
 static int ssusb_role_sw_register(struct otg_switch_mtk *otg_sx)
 {
 	struct usb_role_switch_desc role_sx_desc = { 0 };
-	struct ssusb_mtk *ssusb =
-		container_of(otg_sx, struct ssusb_mtk, otg_switch);
+	struct ssusb_mtk *ssusb = otg_sx_to_ssusb(otg_sx);
 
 	if (!otg_sx->role_sw_used)
 		return 0;
-- 
2.18.0

