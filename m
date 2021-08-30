Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65F13FB37B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhH3J4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:56:14 -0400
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:42945
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233248AbhH3J4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:56:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7ztmyEmBX6rcKa/vMiijDxB8Sm7CiL6hl7BxfZ6nmFgHtJH8yQoeKlvcNHhZO3ap9192mfDP/PfTwMwdLP14cEa9yTezOieQ2OkpD1U2J8w/NjxkRXEiC2KhTc+XtwKVy6TX9BuNmzGOagv3awHt5yVzIFH4VnzbgL9458OpDTc1d4UMtabLNt0qmH/UfgXncsOHdl5AsFwwUI7OYFA3CPi8089w5/nKLXhxl8msfLoKuzkWXWdNB3JZQ2psfknxdFNkuSKGgflFzV+sgOJHH6iBE2b5u8CVfsdloIw3ymGdoP9p3oTrPtAUx9WpJS6fO+tFAkEY3Q8aPaDGR93OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s47QFcFmSRPiolz2fjDz2yIY91VrxZQ1u5Adv/EuPIA=;
 b=OS/gh3I46Zvuaiap+oRzOP5DWOE2AGlWV6Pig4qHUpuMCLZgqPRj6Pht3SVFynMhIlN1wQYaPDyjzGTiwTIBYH7LFgx7snbfGj/UNB8uNcfU+oH0xT0bTyDVFDI053O7gJO9pMU6XfqdABUMSI67JAa3H+ohQuCeuFiMVUgAnXbrtBlbazaeDPvH/0JG6JFazE5P0nOkWfj+Tk8jvQr5pXoLdOb7aqunaQ7AFN705fR0ETTZ1CR8kii7RMLMoDK8mqYoZcz+3Ix/TpR/sK8eYpz6xYb7rVJ/rBcOs4yyvxyYPHFg2tnGNfS4U+ryI1dY9aXev9BhbNs4+Reh5d8lhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s47QFcFmSRPiolz2fjDz2yIY91VrxZQ1u5Adv/EuPIA=;
 b=OwMcvTBVq8Xm6uJfSVfJ1dnenEnqQBzsrjPBmrE8PAg813m1wGUDh2pVrO62c7H/fpm8xzt1X8ai5cHRO/V13GsAXzlhCKN4YdOimy1fMHA8MDPI+sKtRG1kW0d8W73uushwWp7+7rGXuSA2PEQWfGNrRw7vT9kVjn8RXqOy4FpJgOqbEPs87dJqiBo5e2CJN2mUgNdstVRlxRxlWLscDNFxH2s2cCFa8V5zii4hZg2QgAhdGNHb9tonwDEnO44BA0I2sKCuswghNeDJCCCu5PTEHk2iq+MBnbnYzdtdNqmp+ueCTv4Pf9CnLDowdXXhee9liPDzxb7Wdm0Nzh7BOQ==
Received: from DM5PR2001CA0001.namprd20.prod.outlook.com (2603:10b6:4:16::11)
 by BN6PR12MB1412.namprd12.prod.outlook.com (2603:10b6:404:1b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21; Mon, 30 Aug
 2021 09:55:17 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::91) by DM5PR2001CA0001.outlook.office365.com
 (2603:10b6:4:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Mon, 30 Aug 2021 09:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 09:55:16 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Aug
 2021 09:55:15 +0000
Received: from pshete-ubuntu.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 Aug 2021 09:55:15 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpio: tegra: add multiple interrupt support
Date:   Mon, 30 Aug 2021 15:25:12 +0530
Message-ID: <20210830095512.24796-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 131e742c-d4b7-4064-5c78-08d96b9c4538
X-MS-TrafficTypeDiagnostic: BN6PR12MB1412:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1412A58FEE3ADAA0F6A0599DB7CB9@BN6PR12MB1412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukhXQzRH3KEgC1Fzy02swmWq4nShr6q6DVEyaUNUeaFz1Gx3widepxyy8hviY+PnM6NDFSAzWb82sPNSoWfdFtq725GyU4byI09TP/1Z7X1AyhheruyUzIZaYSv2IQvrWMeTvljwqh22RN8JVAr8Zsht/rAHr55L3hOvO38YvmeB3lwPmj51/tFNGoEOXtve0EQQfZ8Q+2rDgXb+XXgpDJc7BGrSuMI6QtwIUkPX23fA/z9vv/Bk9HZKZJ0lWc+N9iIGJfD3YAFykFJa2BzmU/HPv7UagVO2eH+Lwm2b7sdfrYrVWD0URoh+b+ER3/nS9fQtoDqYccDldryjkGm8HraO3cM7wlpUH2n2N/3+A/+ACIxxaQJHjbwa3+Qa9GvomvantbqeLu5F181mdIA1Dn2uQydN1XTio/e0Ket7Vp4r2eTvxk39Vc01k3pXEJtHd2mn3up2jB154YbNT/Lz1ZYIW4MkDw6q1FBmcpxnkfcbSBk2kLwBlaOUFZv1omftyaFUVqoDNyoMkYeDS9AB6df78v0vc/EHbGMLuoiFsFaumssk/wXRC5V7UYB2qSefqyvKfSVVAjAQD86GXxh/+ledm+Dt3HR2rC7OSgw2PwG0FJoqeo9fKuXUksQabJ4GzX40hkUiA16FAUZsND+5XjIYsUnxaTCKdrxR6GOZHH/NkXpH+r9pvSGHchENWVPMraItIInDTLEUM0w9Uacwkg==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(36840700001)(46966006)(83380400001)(2616005)(82310400003)(7636003)(26005)(70586007)(70206006)(86362001)(478600001)(2906002)(356005)(82740400003)(6666004)(186003)(6916009)(426003)(1076003)(7696005)(5660300002)(8676002)(336012)(36860700001)(36756003)(316002)(36906005)(47076005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 09:55:16.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131e742c-d4b7-4064-5c78-08d96b9c4538
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1412
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pshete <pshete@nvidia.com>

T19x GPIO controller's support multiple interrupts. The GPIO
controller is capable to route 8 interrupts per controller in
case of NON-AON GPIO's and 4 interrupts per controller in AON GPIO.

Signed-off-by: pshete <pshete@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 49 +++++++++++++++++++++++-
 drivers/gpio/gpio-tegra186.c             | 25 ++++++++++--
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index b7d532841390..c681a79c44ec 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -34,11 +34,53 @@
 			reg = <0x2200000 0x10000>,
 			      <0x2210000 0x10000>;
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			#gpio-cells = <2>;
@@ -1273,7 +1315,10 @@
 			reg-names = "security", "gpio";
 			reg = <0xc2f0000 0x1000>,
 			      <0xc2f1000 0x1000>;
-			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index d38980b9923a..36bd8de6d401 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2016-2017 NVIDIA Corporation
+ * Copyright (c) 2016-2021 NVIDIA Corporation
  *
  * Author: Thierry Reding <treding@nvidia.com>
  */
@@ -68,6 +68,7 @@ struct tegra_gpio_soc {
 	unsigned int num_ports;
 	const char *name;
 	unsigned int instance;
+	bool multi_ints;
 
 	const struct tegra186_pin_range *pin_ranges;
 	unsigned int num_pin_ranges;
@@ -451,6 +452,7 @@ static void tegra186_gpio_irq(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int parent = irq_desc_get_irq(desc);
 	unsigned int i, offset = 0;
+	int j, flag;
 
 	chained_irq_enter(chip, desc);
 
@@ -462,9 +464,20 @@ static void tegra186_gpio_irq(struct irq_desc *desc)
 
 		base = gpio->base + port->bank * 0x1000 + port->port * 0x200;
 
-		/* skip ports that are not associated with this bank */
-		if (parent != gpio->irq[port->bank])
-			goto skip;
+		if (!gpio->soc->multi_ints) {
+			/* skip ports that are not associated with this bank */
+			if (parent != gpio->irq[port->bank])
+				goto skip;
+
+		} else {
+			flag = 0;
+			for (j = 0; j < 8; j++) {
+				if (parent != gpio->irq[(port->bank * 8) + j])
+					flag++;
+			}
+			if (!(flag & 0xF))
+				goto skip;
+		}
 
 		value = readl(base + TEGRA186_GPIO_INTERRUPT_STATUS(1));
 
@@ -772,6 +785,7 @@ static const struct tegra_gpio_soc tegra186_main_soc = {
 	.ports = tegra186_main_ports,
 	.name = "tegra186-gpio",
 	.instance = 0,
+	.multi_ints = false,
 };
 
 #define TEGRA186_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -798,6 +812,7 @@ static const struct tegra_gpio_soc tegra186_aon_soc = {
 	.ports = tegra186_aon_ports,
 	.name = "tegra186-gpio-aon",
 	.instance = 1,
+	.multi_ints = false,
 };
 
 #define TEGRA194_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -852,6 +867,7 @@ static const struct tegra_gpio_soc tegra194_main_soc = {
 	.num_pin_ranges = ARRAY_SIZE(tegra194_main_pin_ranges),
 	.pin_ranges = tegra194_main_pin_ranges,
 	.pinmux = "nvidia,tegra194-pinmux",
+	.multi_ints = true,
 };
 
 #define TEGRA194_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -875,6 +891,7 @@ static const struct tegra_gpio_soc tegra194_aon_soc = {
 	.ports = tegra194_aon_ports,
 	.name = "tegra194-gpio-aon",
 	.instance = 1,
+	.multi_ints = true,
 };
 
 static const struct of_device_id tegra186_gpio_of_match[] = {
-- 
2.17.1

