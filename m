Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9616D3C9B20
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbhGOJLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:11:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39994 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240854AbhGOJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:11:17 -0400
X-UUID: 350fc4c3d2a24286bb94299c72d78ac1-20210715
X-UUID: 350fc4c3d2a24286bb94299c72d78ac1-20210715
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 692527131; Thu, 15 Jul 2021 17:08:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:08:19 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:08:18 +0800
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
Subject: [PATCH v3 08/13] usb: mtu3: support option to disable usb2 ports
Date:   Thu, 15 Jul 2021 17:07:53 +0800
Message-ID: <1626340078-29111-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to disable specific usb2 host ports, it's useful when
a usb2 port is disabled on some platforms, but enabled on others
for the same SoC.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~3: no changes
---
 drivers/usb/mtu3/mtu3.h      |  4 ++++
 drivers/usb/mtu3/mtu3_host.c |  8 +++++++-
 drivers/usb/mtu3/mtu3_plat.c | 11 +++++++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index bc82c7f97ad6..0ae9b33b50ea 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -228,6 +228,9 @@ struct otg_switch_mtk {
  *		host only, device only or dual-role mode
  * @u2_ports: number of usb2.0 host ports
  * @u3_ports: number of usb3.0 host ports
+ * @u2p_dis_msk: mask of disabling usb2 ports, e.g. bit0==1 to
+ *		disable u2port0, bit1==1 to disable u2port1,... etc,
+ *		but when use dual-role mode, can't disable u2port0
  * @u3p_dis_msk: mask of disabling usb3 ports, for example, bit0==1 to
  *		disable u3port0, bit1==1 to disable u3port1,... etc
  * @dbgfs_root: only used when supports manual dual-role switch via debugfs
@@ -252,6 +255,7 @@ struct ssusb_mtk {
 	bool is_host;
 	int u2_ports;
 	int u3_ports;
+	int u2p_dis_msk;
 	int u3p_dis_msk;
 	struct dentry *dbgfs_root;
 	/* usb wakeup for host mode */
diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index 93a1a4c11e1e..6185bac5fecf 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -155,6 +155,9 @@ int ssusb_host_enable(struct ssusb_mtk *ssusb)
 
 	/* power on and enable all u2 ports */
 	for (i = 0; i < num_u2p; i++) {
+		if ((0x1 << i) & ssusb->u2p_dis_msk)
+			continue;
+
 		value = mtu3_readl(ibase, SSUSB_U2_CTRL(i));
 		value &= ~(SSUSB_U2_PORT_PDN | SSUSB_U2_PORT_DIS);
 		value |= SSUSB_U2_PORT_HOST_SEL;
@@ -188,8 +191,11 @@ int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
 		mtu3_writel(ibase, SSUSB_U3_CTRL(i), value);
 	}
 
-	/* power down and disable all u2 ports */
+	/* power down and disable u2 ports except skipped ones */
 	for (i = 0; i < num_u2p; i++) {
+		if ((0x1 << i) & ssusb->u2p_dis_msk)
+			continue;
+
 		value = mtu3_readl(ibase, SSUSB_U2_CTRL(i));
 		value |= SSUSB_U2_PORT_PDN;
 		value |= suspend ? 0 : SSUSB_U2_PORT_DIS;
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index c0615f6e5cce..5162b9988dde 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -225,6 +225,8 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	/* optional property, ignore the error if it does not exist */
 	of_property_read_u32(node, "mediatek,u3p-dis-msk",
 			     &ssusb->u3p_dis_msk);
+	of_property_read_u32(node, "mediatek,u2p-dis-msk",
+			     &ssusb->u2p_dis_msk);
 
 	otg_sx->vbus = devm_regulator_get(dev, "vbus");
 	if (IS_ERR(otg_sx->vbus)) {
@@ -241,6 +243,9 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 		of_property_read_bool(node, "enable-manual-drd");
 	otg_sx->role_sw_used = of_property_read_bool(node, "usb-role-switch");
 
+	/* can't disable port0 when use dual-role mode */
+	ssusb->u2p_dis_msk &= ~0x1;
+
 	if (otg_sx->role_sw_used || otg_sx->manual_drd_enabled)
 		goto out;
 
@@ -253,9 +258,11 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	}
 
 out:
-	dev_info(dev, "dr_mode: %d, is_u3_dr: %d, u3p_dis_msk: %x, drd: %s\n",
-		ssusb->dr_mode, otg_sx->is_u3_drd, ssusb->u3p_dis_msk,
+	dev_info(dev, "dr_mode: %d, is_u3_dr: %d, drd: %s\n",
+		 ssusb->dr_mode, otg_sx->is_u3_drd,
 		otg_sx->manual_drd_enabled ? "manual" : "auto");
+	dev_info(dev, "u2p_dis_msk: %x, u3p_dis_msk: %x\n",
+		 ssusb->u2p_dis_msk, ssusb->u3p_dis_msk);
 
 	return 0;
 }
-- 
2.18.0

