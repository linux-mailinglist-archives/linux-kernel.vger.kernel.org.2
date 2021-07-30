Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CB53DB54D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhG3IvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:51:17 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41602 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238115AbhG3Iuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:50:51 -0400
X-UUID: fedee033f5f9437e8db3da4b2322d6ba-20210730
X-UUID: fedee033f5f9437e8db3da4b2322d6ba-20210730
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 503012025; Fri, 30 Jul 2021 16:50:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Jul 2021 16:50:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Jul 2021 16:50:40 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 06/11] usb: xhci-mtk: support option to disable usb2 ports
Date:   Fri, 30 Jul 2021 16:49:57 +0800
Message-ID: <1627635002-24521-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
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
 drivers/usb/host/xhci-mtk.c | 12 ++++++++++--
 drivers/usb/host/xhci-mtk.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index f6d161670c4e..12b691547438 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -116,8 +116,11 @@ static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
 		writel(value, &ippc->u3_ctrl_p[i]);
 	}
 
-	/* power on and enable all u2 ports */
+	/* power on and enable all u2 ports except skipped ones */
 	for (i = 0; i < mtk->num_u2_ports; i++) {
+		if (BIT(i) & mtk->u2p_dis_msk)
+			continue;
+
 		value = readl(&ippc->u2_ctrl_p[i]);
 		value &= ~(CTRL_U2_PORT_PDN | CTRL_U2_PORT_DIS);
 		value |= CTRL_U2_PORT_HOST_SEL;
@@ -164,8 +167,11 @@ static int xhci_mtk_host_disable(struct xhci_hcd_mtk *mtk)
 		writel(value, &ippc->u3_ctrl_p[i]);
 	}
 
-	/* power down all u2 ports */
+	/* power down all u2 ports except skipped ones */
 	for (i = 0; i < mtk->num_u2_ports; i++) {
+		if (BIT(i) & mtk->u2p_dis_msk)
+			continue;
+
 		value = readl(&ippc->u2_ctrl_p[i]);
 		value |= CTRL_U2_PORT_PDN;
 		writel(value, &ippc->u2_ctrl_p[i]);
@@ -445,6 +451,8 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	/* optional property, ignore the error if it does not exist */
 	of_property_read_u32(node, "mediatek,u3p-dis-msk",
 			     &mtk->u3p_dis_msk);
+	of_property_read_u32(node, "mediatek,u2p-dis-msk",
+			     &mtk->u2p_dis_msk);
 
 	ret = usb_wakeup_of_property_parse(mtk, node);
 	if (ret) {
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index ace432356c41..0466bc8f7500 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -138,6 +138,7 @@ struct xhci_hcd_mtk {
 	struct mu3c_ippc_regs __iomem *ippc_regs;
 	int num_u2_ports;
 	int num_u3_ports;
+	int u2p_dis_msk;
 	int u3p_dis_msk;
 	struct regulator *vusb33;
 	struct regulator *vbus;
-- 
2.18.0

