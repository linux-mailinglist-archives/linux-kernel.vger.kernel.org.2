Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335C23EE897
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbhHQIhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:37:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54296 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238985AbhHQIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:37:31 -0400
X-UUID: d003182905f04ce783849b1572cab076-20210817
X-UUID: d003182905f04ce783849b1572cab076-20210817
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1769463842; Tue, 17 Aug 2021 16:36:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 Aug 2021 16:36:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 17 Aug
 2021 16:36:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Aug 2021 16:36:46 +0800
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
Subject: [PATCH RESEND 4/9] usb: xhci-mtk: support option to disable usb2 ports
Date:   Tue, 17 Aug 2021 16:36:24 +0800
Message-ID: <1629189389-18779-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1629189389-18779-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1629189389-18779-1-git-send-email-chunfeng.yun@mediatek.com>
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

