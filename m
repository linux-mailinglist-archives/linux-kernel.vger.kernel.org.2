Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD133EA19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhCQGxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:53:13 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:61133
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229472AbhCQGxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:53:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+L2zVZZ3vJqQjWCUV5HHisD1pz7A++YYfJ+mYqD8xynsuaZSyJR2CAplw2V+8k+St/Tu07sOQChBBY3WLEM82P4VSPmdFU2JNySA8RTcRLJYc2crxYWSLD0Hd6iUxo4r/bpgHfdarNPg4X4QV+6BNZl+emsjILdmtSQYGpPYcV3Fm/BOdhRC8J4QTbCojsEzDMzszg+O3OQjwgVF5V3f7whP2l3tgJ+okJnwUkwGByThhtJm6k4a8nNN2H970UkDL4zzOjTI1g1RjmQvA3vXGSbG6TGZHd+zTBae9Ml9sCgMCGRFkPKggAbx0SDRFbc7VkcP4BBFfIjr5KBcewF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QfFy5ZerOIWHfkb2cdJaMulW690rPTpulaEysHTRUg=;
 b=RyhZ8oMSc/QownSKp2ejqp087qNwM3FxgpNBIq3fLytKXiaqEqcZUx1HSu8bixKBRdeKglb2iUSxbfI/a4AdkOmY57IyAgywkNr0fWtkuWksekTcpqgRBmMECnmlzyTEbxdGQtvFSRi5wc2wL0w2iosPYtkmSPxIw1i1UzQavQhVB8KIY/8mkjuP/oFtHM52EnCdvEruW45awor+JCCMYT359h4sdxSCwpSOqv+k4KkOeEmH6eiJqfV+nSB5RSE9kDKxEYcLieIBK07cPoKSsnnL6lvnp86uv8aJRoUPDVlftJb9XDjLbYcgQiKc7PCE77Gdncik4Xvsh1jVArOHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QfFy5ZerOIWHfkb2cdJaMulW690rPTpulaEysHTRUg=;
 b=QYlIwvLtkRbnNdk7ZD6l4jRD6WS2q3/x7ptkBQLxVtuYneV+QvZnna5ve13u88/+5PFRobTjRAo+M99Zv08jxdeU4wr9OZHG/uZBjdf61rXFzvLuDrTx51VaV40SUqKDDdivaWlnHf9vwkSFdWF8lSxvgV7XQfaz9nwIW2Rnb9Q=
Received: from DM6PR02CA0115.namprd02.prod.outlook.com (2603:10b6:5:1b4::17)
 by MWHPR02MB2208.namprd02.prod.outlook.com (2603:10b6:300:5b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 06:53:01 +0000
Received: from DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::7e) by DM6PR02CA0115.outlook.office365.com
 (2603:10b6:5:1b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 06:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT057.mail.protection.outlook.com (10.13.5.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Wed, 17 Mar 2021 06:53:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 23:53:00 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 16 Mar 2021 23:53:00 -0700
Envelope-to: git@xilinx.com,
 balbi@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 p.zabel@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.106] (port=48682 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lMQ38-0003gG-NU; Tue, 16 Mar 2021 23:52:59 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id BF730121143; Wed, 17 Mar 2021 12:22:31 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <balbi@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v4 2/2] usb: dwc3: Add driver for Xilinx platforms
Date:   Wed, 17 Mar 2021 12:22:29 +0530
Message-ID: <1615963949-75320-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1615963949-75320-1-git-send-email-manish.narani@xilinx.com>
References: <1615963949-75320-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8227110-9138-4f30-5fce-08d8e9114e8a
X-MS-TrafficTypeDiagnostic: MWHPR02MB2208:
X-Microsoft-Antispam-PRVS: <MWHPR02MB22080DE4D43630CAD88FD22AC16A9@MWHPR02MB2208.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7f7ai8RinF88lLzNF8se8uhhExXAJQUSf9hlqucd/YQZ2FprfF1mTmyDM3H59TLs/gGoWoKk03YOo5cZ1JP6W+Dtq8YZco9L419t79FtdNsqnuo831tE3ue6YtZsi9ad9NZJVre0saMbbMmnEJ2Hrz139tcqpkOMnaXTLqmd8+aku6hj3mqqjTh+rRZLs/zBgjeBTmM0kwuYs1WGeNiaFqQdHUeP/LFO++bfa8iXYW4NGIlEFOVzdOF+Kw5EtNLZaXnZWKplO6WTVVXnZhRcfX0a36ypybN4Bz/3zBE/PW1SV1XOFlmkIUHluIvBDXdDl/4wNKK2j8xCOnGXbX2e906b88Manw1xUmhzqj0a0qJPEK2B67E9yMPcoyvFjXzfO2zeamc+EK5BVp7MCm27V7r9pYwaNgJsJ5luYsgfPm8qjh2gt+VllXbus/Nti+UxfukmaMmaI0NIV9HLhY3BA5SGgn1BXoCVJNK2Qut1dDE22nS6+Pn1UIOAmvjBDkzhuqfg54rE6rOVXeoo7+MsfgzqgZRhq5mrDLl9zuNMYVcR92CGcoA49OepNWbNh5dwG2mZ7Ga19hnQIODI7wLbBOIZYZWYuTnvJAOeIVPzhbJYJ+bL20ZmJqzf4IrgiYdSEPBDfdJjzkDfBsAwoJ+8Uu4er7YS3Fzs8kjq9xBjPtAcqZpEiAAlVGoVUruVqxm
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(36756003)(2616005)(47076005)(36860700001)(83380400001)(110136005)(30864003)(426003)(54906003)(107886003)(82310400003)(8936002)(2906002)(44832011)(356005)(82740400003)(70586007)(478600001)(36906005)(70206006)(7636003)(42186006)(4326008)(6266002)(336012)(8676002)(316002)(5660300002)(26005)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 06:53:01.3432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8227110-9138-4f30-5fce-08d8e9114e8a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for supporting Xilinx platforms. This driver is used
for some sequence of operations required for Xilinx USB controllers.
This driver is also used to choose between PIPE clock coming from SerDes
and the Suspend Clock. Before the controller is out of reset, the clock
selection should be changed to PIPE clock in order to make the USB
controller work. There is a register added in Xilinx USB controller
register space for the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/dwc3/Kconfig          |   9 +
 drivers/usb/dwc3/Makefile         |   1 +
 drivers/usb/dwc3/dwc3-of-simple.c |   1 -
 drivers/usb/dwc3/dwc3-xilinx.c    | 339 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 2133acf..66b1454 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -149,4 +149,13 @@ config USB_DWC3_IMX8MP
 	  functionality.
 	  Say 'Y' or 'M' if you have one such device.
 
+config USB_DWC3_XILINX
+	tristate "Xilinx Platforms"
+	depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
+	default USB_DWC3
+	help
+	  Support Xilinx SoCs with DesignWare Core USB3 IP.
+	  This driver handles both ZynqMP and Versal SoC operations.
+	  Say 'Y' or 'M' if you have one such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 2259f88..2d499de 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
 obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
 obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
 obj-$(CONFIG_USB_DWC3_IMX8MP)		+= dwc3-imx8mp.o
+obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e62ecd2..71fd620 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -172,7 +172,6 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 
 static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "rockchip,rk3399-dwc3" },
-	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
 	{ .compatible = "sprd,sc9860-dwc3" },
 	{ .compatible = "allwinner,sun50i-h6-dwc3" },
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
new file mode 100644
index 0000000..a59e149
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
+ *
+ * Authors: Manish Narani <manish.narani@xilinx.com>
+ *          Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/of_address.h>
+#include <linux/delay.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/io.h>
+
+#include <linux/phy/phy.h>
+
+/* USB phy reset mask register */
+#define XLNX_USB_PHY_RST_EN			0x001C
+#define XLNX_PHY_RST_MASK			0x1
+
+/* Xilinx USB 3.0 IP Register */
+#define XLNX_USB_TRAFFIC_ROUTE_CONFIG		0x005C
+#define XLNX_USB_TRAFFIC_ROUTE_FPD		0x1
+
+/* Versal USB Reset ID */
+#define VERSAL_USB_RESET_ID			0xC104036
+
+#define XLNX_USB_FPD_PIPE_CLK			0x7c
+#define PIPE_CLK_DESELECT			1
+#define PIPE_CLK_SELECT				0
+#define XLNX_USB_FPD_POWER_PRSNT		0x80
+#define FPD_POWER_PRSNT_OPTION			BIT(0)
+
+struct dwc3_xlnx {
+	int				num_clocks;
+	struct clk_bulk_data		*clks;
+	struct device			*dev;
+	void __iomem			*regs;
+	int				(*pltfm_init)(struct dwc3_xlnx *data);
+};
+
+static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
+{
+	u32 reg;
+
+	/*
+	 * Enable or disable ULPI PHY reset from USB Controller.
+	 * This does not actually reset the phy, but just controls
+	 * whether USB controller can or cannot reset ULPI PHY.
+	 */
+	reg = readl(priv_data->regs + XLNX_USB_PHY_RST_EN);
+
+	if (mask)
+		reg &= ~XLNX_PHY_RST_MASK;
+	else
+		reg |= XLNX_PHY_RST_MASK;
+
+	writel(reg, priv_data->regs + XLNX_USB_PHY_RST_EN);
+}
+
+static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
+{
+	struct device		*dev = priv_data->dev;
+	int			ret;
+
+	dwc3_xlnx_mask_phy_rst(priv_data, false);
+
+	/* Assert and De-assert reset */
+	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
+				     PM_RESET_ACTION_ASSERT);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "failed to assert Reset\n");
+		return ret;
+	}
+
+	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
+				     PM_RESET_ACTION_RELEASE);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "failed to De-assert Reset\n");
+		return ret;
+	}
+
+	dwc3_xlnx_mask_phy_rst(priv_data, true);
+
+	return 0;
+}
+
+static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
+{
+	struct device		*dev = priv_data->dev;
+	struct reset_control	*crst, *hibrst, *apbrst;
+	struct phy		*usb3_phy;
+	int			ret;
+	u32			reg;
+
+	usb3_phy = devm_phy_get(dev, "usb3-phy");
+	if (PTR_ERR(usb3_phy) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err;
+	} else if (IS_ERR(usb3_phy)) {
+		usb3_phy = NULL;
+	}
+
+	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
+	if (IS_ERR(crst)) {
+		ret = PTR_ERR(crst);
+		dev_err_probe(dev, ret,
+			      "failed to get core reset signal\n");
+		goto err;
+	}
+
+	hibrst = devm_reset_control_get_exclusive(dev, "usb_hibrst");
+	if (IS_ERR(hibrst)) {
+		ret = PTR_ERR(hibrst);
+		dev_err_probe(dev, ret,
+			      "failed to get hibernation reset signal\n");
+		goto err;
+	}
+
+	apbrst = devm_reset_control_get_exclusive(dev, "usb_apbrst");
+	if (IS_ERR(apbrst)) {
+		ret = PTR_ERR(apbrst);
+		dev_err_probe(dev, ret,
+			      "failed to get APB reset signal\n");
+		goto err;
+	}
+
+	ret = reset_control_assert(crst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert core reset\n");
+		goto err;
+	}
+
+	ret = reset_control_assert(hibrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert hibernation reset\n");
+		goto err;
+	}
+
+	ret = reset_control_assert(apbrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert APB reset\n");
+		goto err;
+	}
+
+	ret = phy_init(usb3_phy);
+	if (ret < 0) {
+		phy_exit(usb3_phy);
+		goto err;
+	}
+
+	ret = reset_control_deassert(apbrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to release APB reset\n");
+		goto err;
+	}
+
+	/* Set PIPE Power Present signal in FPD Power Present Register*/
+	writel(FPD_POWER_PRSNT_OPTION, priv_data->regs + XLNX_USB_FPD_POWER_PRSNT);
+
+	/* Set the PIPE Clock Select bit in FPD PIPE Clock register */
+	writel(PIPE_CLK_SELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
+
+	ret = reset_control_deassert(crst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to release core reset\n");
+		goto err;
+	}
+
+	ret = reset_control_deassert(hibrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to release hibernation reset\n");
+		goto err;
+	}
+
+	ret = phy_power_on(usb3_phy);
+	if (ret < 0) {
+		phy_exit(usb3_phy);
+		goto err;
+	}
+
+	/*
+	 * This routes the USB DMA traffic to go through FPD path instead
+	 * of reaching DDR directly. This traffic routing is needed to
+	 * make SMMU and CCI work with USB DMA.
+	 */
+	if (of_dma_is_coherent(dev->of_node) || device_iommu_mapped(dev)) {
+		reg = readl(priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+		reg |= XLNX_USB_TRAFFIC_ROUTE_FPD;
+		writel(reg, priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+	}
+
+err:
+	return ret;
+}
+
+static const struct of_device_id dwc3_xlnx_of_match[] = {
+	{
+		.compatible = "xlnx,zynqmp-dwc3",
+		.data = &dwc3_xlnx_init_zynqmp,
+	},
+	{
+		.compatible = "xlnx,versal-dwc3",
+		.data = &dwc3_xlnx_init_versal,
+	},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dwc3_xlnx_of_match);
+
+static int dwc3_xlnx_probe(struct platform_device *pdev)
+{
+	struct dwc3_xlnx		*priv_data;
+	struct device			*dev = &pdev->dev;
+	struct device_node		*np = dev->of_node;
+	const struct of_device_id	*match;
+	void __iomem			*regs;
+	int				ret;
+
+	priv_data = devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		dev_err_probe(dev, ret, "failed to map registers\n");
+		return ret;
+	}
+
+	match = of_match_node(dwc3_xlnx_of_match, pdev->dev.of_node);
+
+	priv_data->pltfm_init = match->data;
+	priv_data->regs = regs;
+	priv_data->dev = dev;
+
+	platform_set_drvdata(pdev, priv_data);
+
+	ret = devm_clk_bulk_get_all(priv_data->dev, &priv_data->clks);
+	if (ret < 0)
+		return ret;
+
+	priv_data->num_clocks = ret;
+
+	ret = clk_bulk_prepare_enable(priv_data->num_clocks, priv_data->clks);
+	if (ret)
+		return ret;
+
+	ret = priv_data->pltfm_init(priv_data);
+	if (ret)
+		goto err_clk_put;
+
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret)
+		goto err_clk_put;
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_suspend_ignore_children(dev, false);
+	pm_runtime_get_sync(dev);
+
+	return 0;
+
+err_clk_put:
+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
+
+	return ret;
+}
+
+static int dwc3_xlnx_remove(struct platform_device *pdev)
+{
+	struct dwc3_xlnx	*priv_data = platform_get_drvdata(pdev);
+	struct device		*dev = &pdev->dev;
+
+	of_platform_depopulate(dev);
+
+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
+	priv_data->num_clocks = 0;
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_set_suspended(dev);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_xlnx_suspend_common(struct device *dev)
+{
+	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+
+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_xlnx_resume_common(struct device *dev)
+{
+	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+
+	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
+}
+
+static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_autosuspend(dev);
+
+	return 0;
+}
+
+static UNIVERSAL_DEV_PM_OPS(dwc3_xlnx_dev_pm_ops, dwc3_xlnx_suspend_common,
+			    dwc3_xlnx_resume_common, dwc3_xlnx_runtime_idle);
+
+static struct platform_driver dwc3_xlnx_driver = {
+	.probe		= dwc3_xlnx_probe,
+	.remove		= dwc3_xlnx_remove,
+	.driver		= {
+		.name		= "dwc3-xilinx",
+		.of_match_table	= dwc3_xlnx_of_match,
+		.pm		= &dwc3_xlnx_dev_pm_ops,
+	},
+};
+
+module_platform_driver(dwc3_xlnx_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Xilinx DWC3 controller specific glue driver");
+MODULE_AUTHOR("Manish Narani <manish.narani@xilinx.com>");
+MODULE_AUTHOR("Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>");
-- 
2.1.1

