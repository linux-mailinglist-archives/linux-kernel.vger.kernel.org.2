Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC23C9B24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbhGOJLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:11:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40070 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240878AbhGOJLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:11:20 -0400
X-UUID: e96fc41491124eaa81a0bb0e1692d07f-20210715
X-UUID: e96fc41491124eaa81a0bb0e1692d07f-20210715
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1806519201; Thu, 15 Jul 2021 17:08:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:08:21 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:08:21 +0800
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
Subject: [PATCH v3 11/13] usb: mtu3: add helper to power on/down device
Date:   Thu, 15 Jul 2021 17:07:56 +0800
Message-ID: <1626340078-29111-12-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper to power on/down device ports and ip, it will be
used when support device suspend/resume

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~3: no changes
---
 drivers/usb/mtu3/mtu3_core.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 6d23acb4fffc..648e970d77ba 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -141,6 +141,28 @@ static void mtu3_device_disable(struct mtu3 *mtu)
 	mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 }
 
+static void mtu3_dev_power_on(struct mtu3 *mtu)
+{
+	void __iomem *ibase = mtu->ippc_base;
+
+	mtu3_clrbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
+	if (mtu->is_u3_ip)
+		mtu3_clrbits(ibase, SSUSB_U3_CTRL(0), SSUSB_U3_PORT_PDN);
+
+	mtu3_clrbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_PDN);
+}
+
+static void mtu3_dev_power_down(struct mtu3 *mtu)
+{
+	void __iomem *ibase = mtu->ippc_base;
+
+	if (mtu->is_u3_ip)
+		mtu3_setbits(ibase, SSUSB_U3_CTRL(0), SSUSB_U3_PORT_PDN);
+
+	mtu3_setbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_PDN);
+	mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
+}
+
 /* reset U3D's device module. */
 static void mtu3_device_reset(struct mtu3 *mtu)
 {
@@ -333,12 +355,7 @@ void mtu3_start(struct mtu3 *mtu)
 	dev_dbg(mtu->dev, "%s devctl 0x%x\n", __func__,
 		mtu3_readl(mbase, U3D_DEVICE_CONTROL));
 
-	mtu3_clrbits(mtu->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
-	if (mtu->is_u3_ip)
-		mtu3_clrbits(mtu->ippc_base, SSUSB_U3_CTRL(0), SSUSB_U3_PORT_PDN);
-
-	mtu3_clrbits(mtu->ippc_base, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_PDN);
-
+	mtu3_dev_power_on(mtu);
 	mtu3_csr_init(mtu);
 	mtu3_set_speed(mtu, mtu->speed);
 
@@ -360,12 +377,7 @@ void mtu3_stop(struct mtu3 *mtu)
 		mtu3_dev_on_off(mtu, 0);
 
 	mtu->is_active = 0;
-
-	if (mtu->is_u3_ip)
-		mtu3_setbits(mtu->ippc_base, SSUSB_U3_CTRL(0), SSUSB_U3_PORT_PDN);
-
-	mtu3_setbits(mtu->ippc_base, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_PDN);
-	mtu3_setbits(mtu->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
+	mtu3_dev_power_down(mtu);
 }
 
 /* for non-ep0 */
-- 
2.18.0

