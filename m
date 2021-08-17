Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEB33EE8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbhHQIhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:37:55 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53354 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239121AbhHQIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:37:31 -0400
X-UUID: 4eb339bec2f64170aa73568d9d403155-20210817
X-UUID: 4eb339bec2f64170aa73568d9d403155-20210817
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 677208711; Tue, 17 Aug 2021 16:36:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 Aug 2021 16:36:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 17 Aug 2021 16:36:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Aug 2021 16:36:50 +0800
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
Subject: [PATCH RESEND 9/9] usb: xhci-mtk: modify the SOF/ITP interval for mt8195
Date:   Tue, 17 Aug 2021 16:36:29 +0800
Message-ID: <1629189389-18779-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1629189389-18779-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1629189389-18779-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 USB controllers on MT8195, the controllers (IP1~IP3,
exclude IP0) have a wrong default SOF/ITP interval which is
calculated from the frame counter clock 24Mhz by default, but
in fact, the frame counter clock is 48Mhz, so we should set
the accurate interval according to 48Mhz for those controllers.
Note: the first controller no need set it.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 65 +++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 12b691547438..7ff0cd707ba1 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -57,6 +57,27 @@
 /* u2_phy_pll register */
 #define CTRL_U2_FORCE_PLL_STB	BIT(28)
 
+/* xHCI CSR */
+#define LS_EOF_CFG		0x930
+#define LSEOF_OFFSET		0x89
+
+#define FS_EOF_CFG		0x934
+#define FSEOF_OFFSET		0x2e
+
+#define SS_GEN1_EOF_CFG		0x93c
+#define SSG1EOF_OFFSET		0x78
+
+#define HFCNTR_CFG		0x944
+#define ITP_DELTA_CLK		(0xa << 1)
+#define ITP_DELTA_CLK_MASK	GENMASK(5, 1)
+#define FRMCNT_LEV1_RANG	(0x12b << 8)
+#define FRMCNT_LEV1_RANG_MASK	GENMASK(19, 8)
+
+#define SS_GEN2_EOF_CFG		0x990
+#define SSG2EOF_OFFSET		0x3c
+
+#define XSEOF_OFFSET_MASK	GENMASK(11, 0)
+
 /* usb remote wakeup registers in syscon */
 
 /* mt8173 etc */
@@ -87,6 +108,46 @@ enum ssusb_uwk_vers {
 	SSUSB_UWK_V1_2,		/* specific revision 1.2 */
 };
 
+/*
+ * MT8195 has 4 controllers, the controller1~3's default SOF/ITP interval
+ * is calculated from the frame counter clock 24M, but in fact, the clock
+ * is 48M, add workaround for it.
+ */
+static void xhci_mtk_set_frame_interval(struct xhci_hcd_mtk *mtk)
+{
+	struct device *dev = mtk->dev;
+	struct usb_hcd *hcd = mtk->hcd;
+	u32 value;
+
+	if (!of_device_is_compatible(dev->of_node, "mediatek,mt8195-xhci"))
+		return;
+
+	value = readl(hcd->regs + HFCNTR_CFG);
+	value &= ~(ITP_DELTA_CLK_MASK | FRMCNT_LEV1_RANG_MASK);
+	value |= (ITP_DELTA_CLK | FRMCNT_LEV1_RANG);
+	writel(value, hcd->regs + HFCNTR_CFG);
+
+	value = readl(hcd->regs + LS_EOF_CFG);
+	value &= ~XSEOF_OFFSET_MASK;
+	value |= LSEOF_OFFSET;
+	writel(value, hcd->regs + LS_EOF_CFG);
+
+	value = readl(hcd->regs + FS_EOF_CFG);
+	value &= ~XSEOF_OFFSET_MASK;
+	value |= FSEOF_OFFSET;
+	writel(value, hcd->regs + FS_EOF_CFG);
+
+	value = readl(hcd->regs + SS_GEN1_EOF_CFG);
+	value &= ~XSEOF_OFFSET_MASK;
+	value |= SSG1EOF_OFFSET;
+	writel(value, hcd->regs + SS_GEN1_EOF_CFG);
+
+	value = readl(hcd->regs + SS_GEN2_EOF_CFG);
+	value &= ~XSEOF_OFFSET_MASK;
+	value |= SSG2EOF_OFFSET;
+	writel(value, hcd->regs + SS_GEN2_EOF_CFG);
+}
+
 static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
 {
 	struct mu3c_ippc_regs __iomem *ippc = mtk->ippc_regs;
@@ -368,6 +429,9 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
 		ret = xhci_mtk_ssusb_config(mtk);
 		if (ret)
 			return ret;
+
+		/* workaround only for mt8195 */
+		xhci_mtk_set_frame_interval(mtk);
 	}
 
 	ret = xhci_gen_setup(hcd, xhci_mtk_quirks);
@@ -716,6 +780,7 @@ static const struct dev_pm_ops xhci_mtk_pm_ops = {
 
 static const struct of_device_id mtk_xhci_of_match[] = {
 	{ .compatible = "mediatek,mt8173-xhci"},
+	{ .compatible = "mediatek,mt8195-xhci"},
 	{ .compatible = "mediatek,mtk-xhci"},
 	{ },
 };
-- 
2.18.0

