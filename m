Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5F23653ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhDTIVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:21:42 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:57344
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230447AbhDTIVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:21:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPvSqCDpGcmL0vOmpq/HXMNm4eN6Rhp05z1IzRWcT1U9o8/zyWIzU8ExO6H82VJ+rGNl1JGxaBHMASaluX/Xt2cEkmLbu9sqo8MzBnzL4i5/7hDF3pN+EuEogZuNlIBwk6B03ctSbzYl/zi9/3HE5yYpO5Qqzvw1jypKLFXvUxKGbgsP2t9CbgXnHnS9BNuH9ZDqu7xIPbNlOi0JxXszLkrpXRNKEEigZ7yWD/UgHngllmdOGSGP8vYqHOIIlaUDQQ9eXBrohWlcQ8JjQ4X1RBuDJGvLIo8+H5Ussyrfx0dP5xQqpTKMI8z4K8WYTPVuBXk6/4qDl/72DDcdZwxkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iz7qZwjmAjO1+o1W4zvqheQ5KcIloDRS1jjrhDAlAE=;
 b=XxqRcVK7b3q02Di/BByxj7CyF1IZvh9zIoSdWMS9SbK2pzB5E60saoWVPa5MMeCVeQ7nNc/H74aAmUNzppXYXDG90Q/8V/Bq3C1RZr2EaUmvOpZES92yTTcswFbJZCI88HZAiyP7GKg0L0UR93k3cGVp/mLoWCfFbsviNMeuPPXdMErLQjMTWP6z2QAW9HiKj5+ZtRbX8o5MkP37qorJqdQga8gn1CjTt5xUm+Z2lFkbgIvZqWjg8t/yUNBrpPGdS1LoBAMpYtD/qzh4wsRDH84vCprQUGqlkemHyqfzBZL/GQpEXSjnP928qvY7Y5e7b82bUMgJpVIvVl8qBFNrxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iz7qZwjmAjO1+o1W4zvqheQ5KcIloDRS1jjrhDAlAE=;
 b=bewFryfzOr9+po0aq8OOVOy7mVyswU1MrjlsenKmQYTjLgM96hX1Nc5/R/MH2W/DgIIlOHp5AfP+dQizwiB2O715CVqtsZrrUZiq74eAlmI/CjY2kAeAd+6LoMcGbuCTZdjLWrph31mvoXGBp4EdOx8svV1VLxIyYF01vYBLDH0=
Received: from BL0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:2d::26)
 by DM6PR02MB5963.namprd02.prod.outlook.com (2603:10b6:5:150::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Tue, 20 Apr
 2021 08:20:52 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2d:cafe::e6) by BL0PR03CA0013.outlook.office365.com
 (2603:10b6:208:2d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 08:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 08:20:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 01:20:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 20 Apr 2021 01:20:42 -0700
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
        id 1lYlcd-0007C5-R8; Tue, 20 Apr 2021 01:20:40 -0700
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
Subject: [PATCH 5/5] misc: zynqmp: Add afi config driver
Date:   Tue, 20 Apr 2021 13:41:53 +0530
Message-ID: <20210420081153.17020-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210420081153.17020-1-nava.manne@xilinx.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4bb4f4f-6122-4067-b44c-08d903d53688
X-MS-TrafficTypeDiagnostic: DM6PR02MB5963:
X-Microsoft-Antispam-PRVS: <DM6PR02MB59633BEFA5E9816552F7042EC2489@DM6PR02MB5963.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewVTw1SMrIy+SgwfOx/jDd2AAZCqY3VhQM3JixlgNmqSnEQ18ARHSLdYiDCm0IhbEoCggbhFdaVqW0+JG8Thnq59xdfoP8p8sINuYcPZ+/0GSHnACKT9kBBPjMN7RUGb/Pl+RwU+Qgc/5ba5xTHnfGZCpqrwU+CpC7BoJn8OTVzTYr/02OqXx42GRnDah80B8naanIWkzUGdiPbL49+xNTCc8jcCfOfwiN0E9xQbDv+MA97wI1ExAxdnIf2y5Sum/6qgZ309+tRmYRBV/8+KA2QADAKj1puHdVyDW6/JxEi4RQrwNU/hwLy9jTS9dqbRF352dXOKeMUY3q+xtTGPE46NdiDFEqN2pPQU5D/Ak1S1HD8z0wvq1MQIpSiFKQZZ+fRK2Dc5zHjYnsX4W3KjVaPNEbINmCT6sEg3WiiDZCOO3T3/sJZRKyVWaHqsk6OKxlXlIhfGk/42fO5FFCP+FBsIpOjNbWCuyhfwhkkMKedLj+cqBGZV/IkYaWLENlEnPgu5pPTr4UHtvQXITkmF04VEAUzJ9hiRxskvofMqpyDK3+J1jSU9+S3sHQCHVc/jy7rnG7OePGxvg1z/K3/4sPt71PM+R25HL1kAydjj+jOLrI1n0/MH9v5AgEgmxjyUixABvoi2jQcyMC3EGetkcByd/ORDWWIoyos3hwEkddY9hzUf8rKgqmg/qlp4UBYtbPI5W3iJrT52S4v2xwVi3lnxBPD857mo6+KWhJqR77ShqbGCwmTF3vI3pjH60JGR
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(36840700001)(46966006)(47076005)(82740400003)(2906002)(7636003)(82310400003)(70206006)(9786002)(8676002)(5660300002)(26005)(83380400001)(356005)(8936002)(2616005)(70586007)(36756003)(426003)(6636002)(7696005)(478600001)(36906005)(110136005)(186003)(6666004)(921005)(316002)(336012)(1076003)(36860700001)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:20:52.6002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bb4f4f-6122-4067-b44c-08d903d53688
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5963
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds zynqmp afi config driver.This is useful for
the configuration of the PS-PL interface on Zynq US+ MPSoC
platform.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/misc/Kconfig      | 11 ++++++
 drivers/misc/Makefile     |  1 +
 drivers/misc/zynqmp-afi.c | 83 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 drivers/misc/zynqmp-afi.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 877b43b3377d..d1ea1eeb3ac1 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -456,6 +456,17 @@ config ZYNQ_AFI
 	  between PS and PL, the AXI port data path should be configured
 	  with the proper Bus-width values
 
+config ZYNQMP_AFI
+        tristate "Xilinx ZYNQMP AFI support"
+        help
+	  ZynqMP AFI driver support for writing to the AFI registers for
+	  configuring PS_PL Bus-width. Xilinx Zynq US+ MPSoC connect the
+	  PS to the programmable logic (PL) through the AXI port. This AXI
+	  port helps to establish the data path between the PS and PL.
+	  In-order to establish the proper communication path between
+	  PS and PL, the AXI port data path should be configured with
+	  the proper Bus-width values
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e9b03843100f..54bd0edc511e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_ZYNQ_AFI)		+= zynq-afi.o
+obj-$(CONFIG_ZYNQMP_AFI)	+= zynqmp-afi.o
diff --git a/drivers/misc/zynqmp-afi.c b/drivers/misc/zynqmp-afi.c
new file mode 100644
index 000000000000..a318652576d2
--- /dev/null
+++ b/drivers/misc/zynqmp-afi.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx FPGA AFI bridge.
+ * Copyright (c) 2018-2021 Xilinx Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/**
+ * struct zynqmp_afi_fpga - AFI register description
+ * @value: value to be written to the register
+ * @regid: Register id for the register to be written
+ */
+struct zynqmp_afi_fpga {
+	u32 value;
+	u32 regid;
+};
+
+static int zynqmp_afi_fpga_probe(struct platform_device *pdev)
+{
+	struct zynqmp_afi_fpga *zynqmp_afi_fpga;
+	struct device_node *np = pdev->dev.of_node;
+	int i, entries, ret;
+	u32 reg, val;
+
+	zynqmp_afi_fpga = devm_kzalloc(&pdev->dev,
+				       sizeof(*zynqmp_afi_fpga), GFP_KERNEL);
+	if (!zynqmp_afi_fpga)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, zynqmp_afi_fpga);
+
+	entries = of_property_count_u32_elems(np, "config-afi");
+	if (!entries || (entries % 2)) {
+		dev_err(&pdev->dev, "Invalid number of registers\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < entries / 2; i++) {
+		ret = of_property_read_u32_index(np, "config-afi", i * 2, &reg);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to read register\n");
+			return -EINVAL;
+		}
+		ret = of_property_read_u32_index(np, "config-afi", i * 2 + 1,
+						 &val);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to read value\n");
+			return -EINVAL;
+		}
+		ret = zynqmp_pm_afi(reg, val);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "AFI register write error %d\n",
+				ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static const struct of_device_id zynqmp_afi_fpga_ids[] = {
+	{ .compatible = "xlnx,zynqmp-afi-fpga" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, zynqmp_afi_fpga_ids);
+
+static struct platform_driver zynqmp_afi_fpga_driver = {
+	.driver = {
+		.name = "zynqmp-afi-fpga",
+		.of_match_table = zynqmp_afi_fpga_ids,
+	},
+	.probe = zynqmp_afi_fpga_probe,
+};
+module_platform_driver(zynqmp_afi_fpga_driver);
+
+MODULE_DESCRIPTION("ZYNQMP FPGA afi module");
+MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

