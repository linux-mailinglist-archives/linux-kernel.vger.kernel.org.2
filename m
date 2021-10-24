Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552C5438B43
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhJXSJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:09:22 -0400
Received: from mail-co1nam11on2082.outbound.protection.outlook.com ([40.107.220.82]:61345
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232038AbhJXSJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:09:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uij3AzBPksC/4dSzdAk/weL45dxYVFMvBcyLYwHys5NOPIAhaUxgPF+zTuZCYWNQotpdWa/Us+LrEhdMEoSy3/4QFTBuoySf9aoNDkKa5V88yQ38/X3l1LHFSeUKQWVPCLagbvFw7wcukj0+iDRoFbwxIgpxCX27JWt7bSbN9jHfgprCp2teB224xfcxZz4ufLPcxzxXJvbes5lziiUt6HWQDECG0ely2d00z9sEl2fBNGSnvMXe+DsbocE78FXOgRwYxb3nwQ51UqLfoe5K2ZvWMy7N5soKEYH36x35ZYk/S+G5Eb+7YDXT9dI6Rt1hNrKsd/F+NGgfYtP+iu0jdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tib4BTJ3K/NzuqbZk6MFuv+tjwI8W0onTD3SEiMp0TU=;
 b=exnV4cWRmqIrk7s2znVvfZBfxTocGhA6z63fj5OK+/9fgJCsYaw7vOMPstmNfncVpLBDsUesULC2GN9y1NmyDbYGSgPlbJflTAFpOFrJ9CYum9GixnGdwlIiXq1jAi9xzdxEIpFWIdxV/e1iWOC12er1+qq6NEBK8BynLqsdTv9+OaUVkOfQ2iawIzJKAr1bxhlSUpzOan/KfvahuL66UNfB91q5u/BlF10fw1bZFvy0+d6yZF5J/iftrqOMHpOfYo7RQLGw3IdGNKU0f5hEooMJ5achGVx+JtcyNEIUijWuj6BUWkbxv2lo9N9KqyLcOqes6RIAB+Ia3QHCVOQ1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tib4BTJ3K/NzuqbZk6MFuv+tjwI8W0onTD3SEiMp0TU=;
 b=BA+z/l89WP3q3a3TV57XYpX9W5pBKwrlhb8PttknBnEcGgbGj1ZdfENVsfOHQvWStphXhw4a95xu8gufevYSeCRsiRBxEKpvYE/3HKBNMQZqRtEnjbtbXCQj9afwNfQk0QeBf6y5gxnhFAXdY9dcXtZdnHrXHQqHYCVFBAf2f/M=
Received: from SA9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::7) by
 SJ0PR02MB7549.namprd02.prod.outlook.com (2603:10b6:a03:329::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Sun, 24 Oct 2021 18:06:50 +0000
Received: from SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::c7) by SA9P221CA0002.outlook.office365.com
 (2603:10b6:806:25::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 18:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0010.mail.protection.outlook.com (10.97.4.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Sun, 24 Oct 2021 18:06:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 24 Oct 2021 11:06:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 24 Oct 2021 11:06:42 -0700
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 --to=robh+dt@kernel.org,
 mka@chromium.org,
 ravisadineni@chromium.org,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.35] (port=56658 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1mehtJ-0002dJ-Tc; Sun, 24 Oct 2021 11:06:42 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <--to=robh+dt@kernel.org>,
        <mka@chromium.org>, <ravisadineni@chromium.org>,
        <stern@rowland.harvard.edu>, <alcooperx@gmail.com>,
        <michal.simek@xilinx.com>
CC:     <piyush.mehta@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 2/2] usb: misc: usb244: add support for USB2 ultra fast sd controller
Date:   Sun, 24 Oct 2021 23:36:28 +0530
Message-ID: <20211024180628.2992108-3-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024180628.2992108-1-piyush.mehta@xilinx.com>
References: <20211024180628.2992108-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2b9b24d-02f4-4696-968e-08d997190ce1
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7549:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7549D269971814CC8DBC532AD4829@SJ0PR02MB7549.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtMyiHeVreObI/w00CdAFPm7tDemCOw1aqUMMIUBEB4c7A31rJveXVCOegQyRAFOvm4fwHeD/reAn8nFh9Zp+3vmvok0rkU4QM5dlFktVk5MFNgzjVgOPjdPpG/FEJJo2ROtO57XY/if2Ts3fZ4juACvnCUaF7rTg1AkhdpXTg8oSPhc5PS53fFlJB/he2a96c/bfs0Uys5tWUe9wNqT33iZjLnVqh9u7wcbJ7awfOTyH73wrmbBkYfnjuHQIshgtx5cucFwFkIK/FnUJndyJsD7Esk+HpAQXo0pd+UpBe63dUn6fK+rul/KuzCWPi0KLbq22F5Bnl0Jj6SUS8JrlO2TLg3AMfkTImam9t/LrpJALzIYx91IitHGbrM65Y7a0pB1z2pdbTFU7ud7MyUt3fLISYnn4HaFjFnGuWkMXtbASHPGQLiXcCc3YNxWP6F4PRti1SCcCW8NNXmbEBX67O8hBXPeTtYxu4IEw3nm9n9y2GpA938r6/u7dO1Z2UGT64qauKhb/dwVud6hS3cYxlLXY5hzTm8jrrXvJcVfnkrYNaXprlakD+0KksyA1jbw/x/9zKEXVJayQN5LSI/1DUDzb0q0RiK2Tx7PsMYR4SPpRgxMUhB9Kg3fb4mRHBK9WCYuTxQcQqUPmMQ1BYHHw3v/2g+n7UzyqMMF+a5AqLowy/CNXC8imJymlmY7E6sOyoPMdXyDjOFnUiZt/cNCEYFotsfbQvqign16t2m5hmY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(70206006)(83380400001)(1076003)(107886003)(82310400003)(36860700001)(8936002)(7636003)(47076005)(70586007)(356005)(4326008)(2906002)(54906003)(110136005)(36906005)(316002)(7696005)(5660300002)(508600001)(6636002)(44832011)(336012)(2616005)(9786002)(426003)(186003)(6666004)(8676002)(36756003)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 18:06:49.4923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b9b24d-02f4-4696-968e-08d997190ce1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7549
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip's USB224x family of Hi-Speed USB 2.0 flash media card controllers
provides an ultra-fast interface between a USB host controller and flash
media cards.

This patch adds a GPIO based usb-sd reset for USB2244 USB2 ultra fast
SD controller. This usb2244 driver trigger sd reset signal after soft
reset or core Reset. The SD needs to be resetted after completion of
phy initialization. After the toggling of gpio, controller gets out
form reset. USB2244 is a simple platform device driver.

As part of the reset, sets the direction of the pin to output before
toggling the pin. Delay of microseconds is added in between low and
high to meet the setup and hold time requirement of the reset.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/usb/misc/Kconfig   |  8 ++++++
 drivers/usb/misc/Makefile  |  1 +
 drivers/usb/misc/usb2244.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 drivers/usb/misc/usb2244.c

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 8f11443..5480c50 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -233,6 +233,14 @@ config USB_EZUSB_FX2
 	  Say Y here if you need EZUSB device support.
 	  (Cypress FX/FX2/FX2LP microcontrollers)
 
+config USB_USB2244
+	tristate "Microchip USB2244 Ultra Fast USB 2.0 SD driver"
+	depends on GPIOLIB
+	help
+	  This option enables support for Microchip USB2244 Ultra Fast USB 2.0
+	  SD controller. This driver reset the gpio pin makes controller out of
+	  reset.
+
 config USB_HUB_USB251XB
 	tristate "USB251XB Hub Controller Configuration Driver"
 	depends on I2C
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 5f4e598..ec22c12 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_USB_TRANCEVIBRATOR)	+= trancevibrator.o
 obj-$(CONFIG_USB_USS720)		+= uss720.o
 obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
 obj-$(CONFIG_USB_YUREX)			+= yurex.o
+obj-$(CONFIG_USB_USB2244)		+= usb2244.o
 obj-$(CONFIG_USB_HUB_USB251XB)		+= usb251xb.o
 obj-$(CONFIG_USB_HSIC_USB3503)		+= usb3503.o
 obj-$(CONFIG_USB_HSIC_USB4604)		+= usb4604.o
diff --git a/drivers/usb/misc/usb2244.c b/drivers/usb/misc/usb2244.c
new file mode 100644
index 0000000..c9613b6
--- /dev/null
+++ b/drivers/usb/misc/usb2244.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Microchip USB2244 Ultra Fast USB 2.0 Multi-Format,
+ * SD/MMC, and MS Flash Media Controllers
+ *
+ * Copyright (c) 2021 Xilinx, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+
+struct usb2244 {
+	struct gpio_desc *reset_gpio;
+};
+
+static int usb2244_init_hw(struct device *dev, struct usb2244 *data)
+{
+	data = devm_kzalloc(dev, sizeof(struct usb2244), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio)) {
+		dev_err_probe(dev, PTR_ERR(data->reset_gpio),
+			      "Failed to request reset GPIO %ld, errcode",
+			      PTR_ERR(data->reset_gpio));
+		return PTR_ERR(data->reset_gpio);
+	}
+
+	/* Toggle RESET_N to reset the hub. */
+	gpiod_set_value_cansleep(data->reset_gpio, 0);
+	usleep_range(5, 10);
+	gpiod_set_value_cansleep(data->reset_gpio, 1);
+	msleep(5);
+
+	return 0;
+}
+
+static int usb2244_probe(struct platform_device *pdev)
+{
+	struct usb2244 *data = NULL;
+
+	/* Trigger gpio reset to the hub. */
+	return usb2244_init_hw(&pdev->dev, data);
+}
+
+static const struct of_device_id usb2244_of_match[] = {
+	{ .compatible = "microchip,usb2244", },
+	{ }
+};
+
+static struct platform_driver usb2244_driver = {
+	.driver = {
+		.name = "microchip,usb2244",
+		.of_match_table	= usb2244_of_match,
+	},
+	.probe = usb2244_probe,
+};
+
+module_platform_driver(usb2244_driver);
+
+MODULE_AUTHOR("Piyush Mehta <piyush.mehta@xilinx.com>");
+MODULE_DESCRIPTION("USB2244 Ultra Fast SD-Controller");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

