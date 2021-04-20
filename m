Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E423653E9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhDTIV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:21:27 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:48577
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230372AbhDTIVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:21:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0VXRD1JKPwcR88qvqD+K98Wia0yjgtYcQq+zXJnA1NXjQphkhYDGcEvxR9IKJ6e6dJQyKS6w4DgSPcbM5Tx0P8gfBRUmjLFHyEaonL7pSgq4gT8TorOj8pauGuvaSjuhwfv6WK+Oti5XH3mjG5pHzgQD2CcMIPwUooHtxqrM2XWzqCjMiAWTqhkOOnF5VnSOWA8G5qk6T4A59Xako6GsL3DdXhi6T589eFtrHajKNq2oZaU+AZjVsjha7bEBe7evhmBWg7D8rqTVBAb33glySzG2vs3n6Oj03CJZNwhXuiM+FJT3h9XWw7HFJm+aEDBnLG6XIf8kdq5BkuhtgulWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzTrF6VT2Y5PvWPifvff2hiDP/uv6MvaBjiiR783Fg8=;
 b=P2PqhQvh1YK50WRuDk7gKNkvW2QW1Ng7ji254IewD7r7MWpdyr40blHJ/EUhZVUM36SM4eVT5bAEnQGfPBfiH09RZhrKZDY/h/lKzHWo2Mj7bI0Qxuhp1vVI2qMipgAklzFepxxi8uDm54EErpnIWzu22jkxu1IKfGnOeW2jAPL5oCHATnuGThJUHXJrBdIW03AecjjfX5cbjQoe1eFkOtU3Bsgdvol1OT6LrBVNU6D03VsajQfi9IFXI4Ek2i6iHWMfNrKQFHSMRPAlEmUrV44Tz2KOJ03iWud8LU9GWnRn/6n/tcJzSwhl8+BRQhvUm/nFX8zNp4m8M7OOkBRcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzTrF6VT2Y5PvWPifvff2hiDP/uv6MvaBjiiR783Fg8=;
 b=rgRXiE8Kc+bjtDoSDaORwrG886Xxy0eX5HInJnEq/hIiZvD7r1GJrmtBANeQVTHhjULZ2MfkKHvqXfomViGCg+WHUye8uQ9SLV4vMEz5iE4dBROJ4PPxWTrYXkObHcHM2qmSJX+CWblwXZdF5t/Z+OBOSN2OkbCdx3Fj0eOAuBA=
Received: from CY4PR18CA0066.namprd18.prod.outlook.com (2603:10b6:903:13f::28)
 by SN6PR02MB5022.namprd02.prod.outlook.com (2603:10b6:805:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 08:20:35 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13f:cafe::68) by CY4PR18CA0066.outlook.office365.com
 (2603:10b6:903:13f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Tue, 20 Apr 2021 08:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 08:20:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 01:20:28 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 20 Apr 2021 01:20:28 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=45276 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lYlcR-0007C5-4j; Tue, 20 Apr 2021 01:20:27 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <nava.manne@xilinx.com>, <rajan.vaja@xilinx.com>,
        <jolly.shah@xilinx.com>, <tejas.patel@xilinx.com>,
        <amit.sunil.dhamne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>,
        <git@xilinx.com>
Subject: [PATCH 2/5] misc: zynq: Add afi config driver
Date:   Tue, 20 Apr 2021 13:41:50 +0530
Message-ID: <20210420081153.17020-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210420081153.17020-1-nava.manne@xilinx.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e12b6698-a878-49ce-bba4-08d903d52c21
X-MS-TrafficTypeDiagnostic: SN6PR02MB5022:
X-Microsoft-Antispam-PRVS: <SN6PR02MB50224035A5D107243C73D2FEC2489@SN6PR02MB5022.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETa1Cm+ljiRLwBeL6+BtrSIiCQiFCpxJeSCCq6E3lTuTB0C55bUensUR7/M4FyNCovWzUqpsp2g9DQ6d9h5J8H12PoYt1UnAhQ4OgP7VX2sq0RLOlActCqi82pheX5bdNgj/apFNA/dcSjorFXLCtjZHZZaWrV8407pnK1c6fGdYjYR1nQoc37Ok0qLdstxAVZBvQCG/xehPr58THChjqGkMjDygsi8yBNCS9BwRNnoB77Fwj5dy3DIM1qJflaHQtL92PNt94WB8t3npw3a7rsExweykmqUd4HrZpcjPtRyP2C6D0WDX0SIe74AmlY3cmc/JSKyist+8MrZJRE97gsV6yRQryo8czUV94ldIxZFlx2zE4XYv79QbgYmjD/WP1bMeC4He6MSFUP3ZdTxljEBvt0OsRI+/Ouq6eROjogm8u4MZ9eyTLS53mHd4sEXFvsss+HQN8a3oy3xvVWQSXhWrtt64Kwgej7+Uxo7Au3asIK17yVHNJN5jWxRFHZm5RAXD4U78jhPH9f4NOp3wKqHVUveS29EwZaXrE2+RmMELmWPTaz+K79D5dKi52RuKYWdQxBztxoIjK98F53KCTiehTXLcaU6dYiYIeh+urMYzZskI4BrHSmZT7zO3EqosvtdUAKm9GpSfmJmwMPOj1uqE7oy9MgHkEwKq/gz+D0jC4kA3FS5nTgE3fxqlNGEf7l9xlPtAuw6jCscPVKjkQK0fSEsT5SCsymU/ACCY713bDyQLdnT6MczotxnPhKq+
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(36860700001)(26005)(426003)(356005)(186003)(82310400003)(70586007)(7636003)(8936002)(47076005)(336012)(8676002)(5660300002)(2616005)(110136005)(36756003)(82740400003)(316002)(2906002)(6666004)(7696005)(36906005)(9786002)(921005)(1076003)(6636002)(70206006)(83380400001)(478600001)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:20:35.2311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12b6698-a878-49ce-bba4-08d903d52c21
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds zynq afi config driver. This is useful for
the configuration of the PS-PL interface on zynq platform.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/misc/Kconfig    | 11 ++++++
 drivers/misc/Makefile   |  1 +
 drivers/misc/zynq-afi.c | 81 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 drivers/misc/zynq-afi.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f532c59bb59b..877b43b3377d 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -445,6 +445,17 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.
 
+config ZYNQ_AFI
+	tristate "Xilinx ZYNQ AFI support"
+	help
+	  Zynq AFI driver support for writing to the AFI registers
+	  for configuring PS_PL Bus-width. Xilinx Zynq SoC connect
+	  the PS to the programmable logic (PL) through the AXI port.
+	  This AXI port helps to establish the data path between the
+	  PS and PL.In-order to establish the proper communication path
+	  between PS and PL, the AXI port data path should be configured
+	  with the proper Bus-width values
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 99b6f15a3c70..e9b03843100f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,3 +56,4 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-$(CONFIG_ZYNQ_AFI)		+= zynq-afi.o
diff --git a/drivers/misc/zynq-afi.c b/drivers/misc/zynq-afi.c
new file mode 100644
index 000000000000..04317d1bdb98
--- /dev/null
+++ b/drivers/misc/zynq-afi.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx ZYNQ AFI driver.
+ * Copyright (c) 2018-2021 Xilinx Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+/* Registers and special values for doing register-based operations */
+#define AFI_RDCHAN_CTRL_OFFSET	0x00
+#define AFI_WRCHAN_CTRL_OFFSET	0x14
+
+#define AFI_BUSWIDTH_MASK	0x01
+
+/**
+ * struct afi_fpga - AFI register description
+ * @membase:	pointer to register struct
+ * @afi_width:	AFI bus width to be written
+ */
+struct zynq_afi_fpga {
+	void __iomem	*membase;
+	u32		afi_width;
+};
+
+static int zynq_afi_fpga_probe(struct platform_device *pdev)
+{
+	struct zynq_afi_fpga *afi_fpga;
+	struct resource *res;
+	u32 reg_val;
+	u32 val;
+
+	afi_fpga = devm_kzalloc(&pdev->dev, sizeof(*afi_fpga), GFP_KERNEL);
+	if (!afi_fpga)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	afi_fpga->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(afi_fpga->membase))
+		return PTR_ERR(afi_fpga->membase);
+
+	val = device_property_read_u32(&pdev->dev, "xlnx,afi-width",
+				       &afi_fpga->afi_width);
+	if (val) {
+		dev_err(&pdev->dev, "failed to get the afi bus width\n");
+		return -EINVAL;
+	}
+
+	reg_val = readl(afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
+	reg_val &= ~AFI_BUSWIDTH_MASK;
+	writel(reg_val | afi_fpga->afi_width,
+	       afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
+	reg_val = readl(afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
+	reg_val &= ~AFI_BUSWIDTH_MASK;
+	writel(reg_val | afi_fpga->afi_width,
+	       afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
+
+	return 0;
+}
+
+static const struct of_device_id zynq_afi_fpga_ids[] = {
+	{ .compatible = "xlnx,zynq-afi-fpga" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, zynq_afi_fpga_ids);
+
+static struct platform_driver zynq_afi_fpga_driver = {
+	.driver = {
+		.name = "zynq-afi-fpga",
+		.of_match_table = zynq_afi_fpga_ids,
+	},
+	.probe = zynq_afi_fpga_probe,
+};
+module_platform_driver(zynq_afi_fpga_driver);
+
+MODULE_DESCRIPTION("ZYNQ FPGA AFI module");
+MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

