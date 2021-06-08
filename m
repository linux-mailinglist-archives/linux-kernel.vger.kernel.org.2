Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94039F041
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFHIA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:00:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53488 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231157AbhFHIAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:00:06 -0400
X-UUID: 231562fd6c9a49229c7ddd20d27c4f01-20210608
X-UUID: 231562fd6c9a49229c7ddd20d27c4f01-20210608
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 617785521; Tue, 08 Jun 2021 15:58:10 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:58:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:58:07 +0800
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
Subject: [PATCH 13/23] usb: mtu3: rebuild role switch get/set hooks
Date:   Tue, 8 Jun 2021 15:57:39 +0800
Message-ID: <1623139069-8173-14-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper ssusb_set_mode() to do role switch instead
of manual switch helper;
Remove unnecessary local variable when get role status

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_dr.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index cf9e5b59a77e..318fbc618137 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -256,13 +256,9 @@ void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
 static int ssusb_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
 {
 	struct ssusb_mtk *ssusb = usb_role_switch_get_drvdata(sw);
-	bool to_host = false;
-
-	if (role == USB_ROLE_HOST)
-		to_host = true;
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
-	if (to_host ^ ssusb->is_host)
-		ssusb_mode_switch(ssusb, to_host);
+	ssusb_set_mode(otg_sx, role);
 
 	return 0;
 }
@@ -270,11 +266,8 @@ static int ssusb_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
 static enum usb_role ssusb_role_sw_get(struct usb_role_switch *sw)
 {
 	struct ssusb_mtk *ssusb = usb_role_switch_get_drvdata(sw);
-	enum usb_role role;
-
-	role = ssusb->is_host ? USB_ROLE_HOST : USB_ROLE_DEVICE;
 
-	return role;
+	return ssusb->is_host ? USB_ROLE_HOST : USB_ROLE_DEVICE;
 }
 
 static int ssusb_role_sw_register(struct otg_switch_mtk *otg_sx)
-- 
2.18.0

