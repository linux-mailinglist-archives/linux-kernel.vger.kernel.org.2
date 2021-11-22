Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF636458955
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 07:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhKVGcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 01:32:10 -0500
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:2368
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232591AbhKVGcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 01:32:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcdKou8YToW+bw7RuhWeqhFCrEpikl6ReWK3oVwuMe6xE2bV9+NcFtmwm9vuZe4DotgY0q9e2zFYpKzo7sfVJSGXbC1x843R7evfhufQFz+GAdRtt8+1VWL0scOCYSJh3fvpq7yi1V4PV54G7927OfnDjDVKqtvFAwpJBhdffEBXmWsimfBmeeWASlrQSsnm+X0cwYh40wprMSOTz0jJ9hBXMx1DShF9UVgU+xi8LVez9JrXgR05dI30e4uEUYdvabQc8RApGCuCi7iKLCmvAAFNZoInTHfunA9N4cMUIiDIy4INdcAA719kMNqmKswxrXonJ7e/SN5msq0zpz8E0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN910XI6z3skkYOzoacoTmkdp3jER45kd98bZV0orvQ=;
 b=ev5/v7aHJeY61tHsU0DVf9/FrfnixuWaBHIVjQ5n2x86tDhxFUm1+fGscFujPSJI7B4ky1gw237O1hG+MwVFQpGVBILCk8oe28NK5C6OjwgHCpZIbnCunlpsPvMaaJMH6Ijt0dApWimiJOQyOc8DmPSnLNvhovUM/rTxLJ+rUxj3bS65VqIwydI4v7Bk2iemAurbuxSVJmZgEvOEfvIKL47MEIMe2DfxTr2ziw7Q+0Pn58SBlAXK5MOjkkqcTbyAiIrWDCZ7cbeFzmB0szpOKEP8zV1om6adJ/iQqnE0M+MrzWEutZvyXymM2yj90au+pkfVFTIZCmTdUpe+F/USJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN910XI6z3skkYOzoacoTmkdp3jER45kd98bZV0orvQ=;
 b=P8zFyc80B3xID62sSoUEaouA1o80zmaFuw2A8joxY5hauEIChmiQoGZ8Umjwd0foD/k8mpofAs5t6cafstLmjk9pP0sOYp0uHqpm2tOhP/UKv4C/fZoGZDoSF4zgg6/uN3GARyLv3GgpAm2V1xxXqI4GAzQ3RbUyOWMfOamYXAM=
Received: from DM6PR08CA0049.namprd08.prod.outlook.com (2603:10b6:5:1e0::23)
 by CO1PR02MB8489.namprd02.prod.outlook.com (2603:10b6:303:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Mon, 22 Nov
 2021 06:28:58 +0000
Received: from DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::90) by DM6PR08CA0049.outlook.office365.com
 (2603:10b6:5:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Mon, 22 Nov 2021 06:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT012.mail.protection.outlook.com (10.13.5.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 06:28:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 21 Nov 2021 22:28:56 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 21 Nov 2021 22:28:56 -0800
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 robh+dt@kernel.org,
 mka@chromium.org,
 ravisadineni@chromium.org,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.35] (port=53536 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1mp2oy-0001Mv-DQ; Sun, 21 Nov 2021 22:28:56 -0800
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mka@chromium.org>, <ravisadineni@chromium.org>,
        <stern@rowland.harvard.edu>, <alcooperx@gmail.com>,
        <michal.simek@xilinx.com>
CC:     <piyush.mehta@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH V2 2/2] usb: misc: usb244: add support for USB2 ultra fast sd controller
Date:   Mon, 22 Nov 2021 11:58:34 +0530
Message-ID: <20211122062834.1812005-3-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122062834.1812005-1-piyush.mehta@xilinx.com>
References: <20211122062834.1812005-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e646402a-0ef4-4b36-eb4f-08d9ad815dc2
X-MS-TrafficTypeDiagnostic: CO1PR02MB8489:
X-Microsoft-Antispam-PRVS: <CO1PR02MB8489F4228999313666DD5C5AD49F9@CO1PR02MB8489.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T6GHFw3l+uYU5QtaYU2T2S0BqszzXgzu0tIwDI+3Va0A7QPmbDy+2WP3QCojmo4xhvABmFB2olYWB9KlN/UcmvhRwMS9zfF80jfQfDl+0M1B9kXnJBg8gMOp8N2q/tzF79UVt1UfziMp2DmMEY8kk0858KpzliD9q6sttWpfoHNIReOWn8RXSmYvZwURAjuiyoa3BZFgrzvKOalvk2npiIrnHtbTgAMhPPrtCy7s2bAdCEO4FcQd9WIVFDbLa1VcDKI4b2ehkuNk+Cnp3nJDebG2uY2b58IvLbpIfM+F1u4fS0FKIKJjliLoD7F73jG8d3txN9Ajsk0kOybhI2f9wvlkxy9tocXOAPUG7Sz7xilkvwY88gMWlppYu5wrYZO248ULu6/a1cnG6b5ZsWTPbOpGXiIcawTYmiBCUUCFSa8Q9nYnUvJszMEafL+IfLEwdPa5aFdMHTVMvLsuH9zuW0/+fNpxIzEaAELV/K8nb5lN1DMoS8Rc8CYuZhN2c84BtOk/8nPy/JFrJIWosY4iiAqP3+6jzmBE9JPSBAr0t0MhlqA4aAMzBEtbTdpk26cncL3U38pPRmjDxT5aGArN5vu/MUCXbwLp8d08e2sZLCQje4wv2UZylLq/Jchfvtts/Z5Rcvm0whYx78coy65mwwVnsVNxD4w25FlAA2X9HsaBI+XdzCniJbyBDQ7kTYqNEnrvT6Yiwoc26Hu/Jiqr+j9Y9/qhsiNz0fdf3MScwQWz9Qx37hDdSYvjSGzeIWIagpq4L1qh2wNCqR7du1MBQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(107886003)(7636003)(6666004)(36756003)(36906005)(9786002)(5660300002)(966005)(356005)(4326008)(83380400001)(7696005)(44832011)(70206006)(70586007)(1076003)(54906003)(2616005)(110136005)(6636002)(8676002)(316002)(426003)(508600001)(2906002)(8936002)(336012)(36860700001)(82310400003)(47076005)(186003)(26005)(102446001)(15866825006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 06:28:58.4167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e646402a-0ef4-4b36-eb4f-08d9ad815dc2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8489
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
toggling the pin. Delay of microseconds is added in between high and
low to meet the setup and hold time requirement of the reset.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
Changes for V2:
- Update reset polarity, make reset ACTIVE LOW in the usb2244 driver.
- Fix WARNING: msleep < 20ms can sleep for up to 20ms by changing msleep to
  usleep_range()
---
 drivers/usb/misc/Kconfig   | 10 +++++++
 drivers/usb/misc/Makefile  |  1 +
 drivers/usb/misc/usb2244.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 drivers/usb/misc/usb2244.c

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 8f11443..e1c66a2 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -215,6 +215,16 @@ config USB_ISIGHTFW
 	  driver beforehand. Tools for doing so are available at
 	  http://bersace03.free.fr
 
+config USB_USB2244
+	tristate "Microchip USB2244 Ultra Fast USB 2.0 SD driver"
+	depends on GPIOLIB
+	help
+	  Say Y or M here if you want to reset Microchip USB2244 Ultra Fast
+	  USB 2.0 SD controller.
+	  This option enables support for Microchip USB2244 Ultra Fast USB 2.0
+	  SD controller. This driver reset the gpio pin makes controller out of
+	  reset.
+
 config USB_YUREX
 	tristate "USB YUREX driver support"
 	help
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 5f4e598..5b4af7d 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_USB_LEGOTOWER)		+= legousbtower.o
 obj-$(CONFIG_USB_TEST)			+= usbtest.o
 obj-$(CONFIG_USB_EHSET_TEST_FIXTURE)    += ehset.o
 obj-$(CONFIG_USB_TRANCEVIBRATOR)	+= trancevibrator.o
+obj-$(CONFIG_USB_USB2244)		+= usb2244.o
 obj-$(CONFIG_USB_USS720)		+= uss720.o
 obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
 obj-$(CONFIG_USB_YUREX)			+= yurex.o
diff --git a/drivers/usb/misc/usb2244.c b/drivers/usb/misc/usb2244.c
new file mode 100644
index 0000000..5a868c2
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
+	data->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(data->reset_gpio)) {
+		dev_err_probe(dev, PTR_ERR(data->reset_gpio),
+			      "Failed to request reset GPIO %ld, errcode",
+			      PTR_ERR(data->reset_gpio));
+		return PTR_ERR(data->reset_gpio);
+	}
+
+	/* Toggle RESET_N to reset the hub. */
+	gpiod_set_value_cansleep(data->reset_gpio, 1);
+	usleep_range(5, 10);
+	gpiod_set_value_cansleep(data->reset_gpio, 0);
+	usleep_range(5000, 6000);
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

