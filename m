Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CCB4037E6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348849AbhIHKdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:33:49 -0400
Received: from mail-am6eur05hn2220.outbound.protection.outlook.com ([52.100.174.220]:37888
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234958AbhIHKdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:33:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+AD1OR8xJTvoCytiAzfuUucPYqPrk7WfSyjv2T9f36ohSegtf1JfkyTI3AC/pw895DNpH78Ra5+76QmyUhKs9QBF1SkBXqbBCmsb0cXW8WaEfW0xFarfVaVMB0WKkGDG0U1rcKM9TZjBLgVbT+ub2AtX0km3Ba46fsKtOC1uau7R/5kvHE8sUvtlcfcPS84/7E2KKbcH5TMOh3Ffhzb11OaXJgzwt+H73IzSxqzhF18OfU5MIifQ4K1IssEaGcaKc7GJrbuZpxSYV4nzKovLBkgtr+vnPhTg7fQaPp3zodHeumv8uLQARLeDDDZmaAw/18KYJiO/L4tIwOeJk18sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WK8dBKzeWHwfz/VtibROA0WkNHdq0eM48e+EPp8Yvqo=;
 b=W4UAqR/kY+BSkyq+HX2cG9WifM5p1sobilnYRSkJxL8y2y2+V9+tvfoj6I0Ol5AcQlPDjzl41lF0zx3yFrTsMJdTU40wkhQtLmH0n20U8s2oOT7Ki+VtoyV4RmXkNxR1kMT+TSQa2mrl3peq7LPsSvjt0iYScLWl856Ia3omozyY4CJahLsZVI3B9FwDaGhiailR/u12XbJFR6vss5W6MT50GZ+/StVKV2H8ZICbIZMOxxf0gckcSWrMQyINdCkbnSq03dYVQqmSNRMbI5O4doqooLPWzS/Jjda3tp9RhF3+kmN2efF8HnVtx44yYdjqF313h45jWwz4EqDCLDJFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=f-secure.com; dmarc=pass action=none header.from=f-secure.com;
 dkim=pass header.d=f-secure.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=f-secure.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK8dBKzeWHwfz/VtibROA0WkNHdq0eM48e+EPp8Yvqo=;
 b=AyCT4uuKB5bWRWiwLtjPOwxgWiroi2u75A0ArGHq+en3U3UzPoXe+ewXgqAYvHVLQspw0OGF2vaW1AzaLXQpAa827z+rey32C0v2q5ivA5Fwc1H6ZUeGoP7kT1rZzKKisZOCfyR2i8UhgQLjMab2ytC7BFY1DzenTCVhzSTHhrE=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=f-secure.com;
Received: from DBBPR08MB4507.eurprd08.prod.outlook.com (2603:10a6:10:d1::10)
 by DBBPR08MB6201.eurprd08.prod.outlook.com (2603:10a6:10:20a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 10:32:36 +0000
Received: from DBBPR08MB4507.eurprd08.prod.outlook.com
 ([fe80::154c:39a8:916c:dcb0]) by DBBPR08MB4507.eurprd08.prod.outlook.com
 ([fe80::154c:39a8:916c:dcb0%7]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 10:32:36 +0000
From:   andrej.rosano@f-secure.com
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6ulz: add support for USB armory Mk II
Date:   Wed,  8 Sep 2021 12:32:32 +0200
Message-Id: <20210908103232.204763-1-andrej.rosano@f-secure.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::11) To DBBPR08MB4507.eurprd08.prod.outlook.com
 (2603:10a6:10:d1::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (193.110.108.35) by ZR0P278CA0078.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 10:32:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2286a8e-b537-4afa-45a4-08d972b3f9b8
X-MS-TrafficTypeDiagnostic: DBBPR08MB6201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB62018F051786F3FE9B92BC23DFD49@DBBPR08MB6201.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QjgEj/KFuQA6fEXxPRqKpqBc3n5fF7eGqSjPHol+DHYY2uSIrCmpv872Pdlf?=
 =?us-ascii?Q?xgx6BxsqyFVd8tInABDQmm4hb1XpCCofFY9YNT0cA0hOysAw57Nl9OA668PN?=
 =?us-ascii?Q?6ezUu4f7ai8hLJYzzo+HgZmvmOEFxUm/v9Yv84K79FqCh2TytwO7C3fHAFdb?=
 =?us-ascii?Q?h67vl11F3HD6Y+xYI6R050Mr3yuRsUpo4fxRus9gBcsZuOcWZQGil8XAaebc?=
 =?us-ascii?Q?3QRWam6wne/9PjrSTnjySy0jeQepZ2h1l8KM0guXvnuIblNXoJZ732s3NRV3?=
 =?us-ascii?Q?ml2blVTOV9aCyTRhGN9mHCy+tcpRcpgYrQnR0/gxPnbvixRo8elc5io5SxUz?=
 =?us-ascii?Q?uc1ZPhGGPIbonvzdoRRC+w14qm74034DE69CxxMvevWbm39/BcKmYePBJ4PO?=
 =?us-ascii?Q?Gai+4EgsEqpCj0fyy7apmFOXIgO+9Lik0ZQCXDHAwRoQv/FWaLA3bSZzTKvH?=
 =?us-ascii?Q?E7RL5+64YXYJL2Fji+o6z3dxY55UZZE70fnVPcl6sfc8YkaQ2z3qBTh+8zuW?=
 =?us-ascii?Q?mKB294oaL07Gx/pEzkS1Wvtu+RZGuGIhRgjb0kByMisq2OM/K0n7POWii+XW?=
 =?us-ascii?Q?OvZRfEqCTyYitEsIC25kFVI5gMN8Ne2ddmogA4yAE87f9XwGQfkI+ywy8VTH?=
 =?us-ascii?Q?Yi14WV23JqvFINKGRu3RMRatj8FlGTPfrQ5J/duIEjfkLk8hTQJG8rWAXJUC?=
 =?us-ascii?Q?4F7fK9h3yj974MLK+FiR6/KvfQdTG+oP1ik2qpG9vdLpcQtfjVvl84goLn2w?=
 =?us-ascii?Q?B1pbjbX8iLaexV+Qa8dfCx1zwQp+6Vj4Syty5Y9bEjKriv+WKm9sMGPNqWU3?=
 =?us-ascii?Q?bTmQ9Svg4KsqdMJ6RG12DFWyWLH4uFvm/ermELFBAdaUK+2KcqPVURigAZjl?=
 =?us-ascii?Q?AtTBT9bdtgYgba4IgzuYO7oaDJ/3t0ytfGL5CD7eDTGvqHYJDY4x99NGzrtE?=
 =?us-ascii?Q?zalHAv4sHTkkEZhNHdTRnuVOVK8i9fvPaMfzjuRlGHr0MVnjrHp9AG43QUeC?=
 =?us-ascii?Q?l1LUccxJt2QvA7wX8auXQrviaVOK/87fZdGRsCJ5XvyrqyDIYvo2LO3Bka+1?=
 =?us-ascii?Q?H/H46MteVqzOpYjJC0HTJi++HlPlWVBfbdHetarK0mjLakBXE2mgWEQ+LdGB?=
 =?us-ascii?Q?2ygmT/cYyPWu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DBBPR08MB4507.eurprd08.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(136003)(346002)(396003)(376002)(39850400004)(366004)(478600001)(5660300002)(1076003)(66556008)(66476007)(66946007)(38100700002)(38350700002)(6666004)(52116002)(2906002)(8676002)(6486002)(6916009)(186003)(26005)(83380400001)(6496006)(36756003)(8936002)(2616005)(316002)(956004)(86362001)(966005)(9686003)(4326008)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rUVmzv4R8D9IpvmraIi8FQXn82r+/tcdQmztycMEa4vw4ZDEZVKI9SDdxU0E?=
 =?us-ascii?Q?0IFdCoJ7KaNPT8H+kD/DTorfjKHMDq+0bsIAIMKqsQehUxPAxcdV5svMoaOP?=
 =?us-ascii?Q?tIzt+bjCk0Iz/7TfvyrBf6R1HD4nYVcSKzIbB6dSu7hlyiRQD+twJ0ZQ2sbB?=
 =?us-ascii?Q?O5+yRRACnLVDOVPAtXI/sPVLHk/ZKI/x3jctDI23Unk0UMzw4TEUGwzjTSdy?=
 =?us-ascii?Q?W5mcj3TR6KpbX1l13VSB9QgJT5bO7GOx/HapnEd5Q6CzSTYDSw2J8BhpdZq2?=
 =?us-ascii?Q?D/NU0ZznKjoGpL4FIcVVjArU3NSfkg+SmQz1x/feXgHsFC7sKdxRAp9iLeHZ?=
 =?us-ascii?Q?rvqjVWl6Ns3ipPag+kn9sgHgilWYFOqmnGVWqwaZnVly6Tlsq3m2wpx6rI0e?=
 =?us-ascii?Q?r/VP7kwMclk08wUyvWiwQZJOBf4Ke1eKLBWFMJFbkY6dJ4UB0ZN7hC1wH2gd?=
 =?us-ascii?Q?HMpxg0eNPpwygdiZOQW4wY/st3pptkJ/UtHmXwVh7DL8JxBuxWzh/UYW65aQ?=
 =?us-ascii?Q?XqVTsa3TBlHgqShQXtp6oA/VYdcXq6EtM+eDlQOLQtRWi0yJYp5pfC46HZ7b?=
 =?us-ascii?Q?pSMWkgfTjYFgR31EF3RY8FmJyC+OGuoWB8ykmMpzeYerAljk/g2bBmEUjfB1?=
 =?us-ascii?Q?tBQfZ22vDAkA6G1B5ykkER0y7YWF7Ytevssj+1ogQYsAJpHumaXq+zxXs5mw?=
 =?us-ascii?Q?lDLdnwMkzwar37UUtIc5J+H6ARHiTnuKSIX7nGe3PA7PQXOv4th7q3wlDdmJ?=
 =?us-ascii?Q?tNWMnN7SyRiS7yneH1GvRxDr4AkFxW14uYvYw46r5IVN4inXu1XGr4PJVI4r?=
 =?us-ascii?Q?6B/ybtake17QCBYZ7cumCm/b1uEjr3vBvxiIefBXS8aWni1iXrwVM1YEqHM6?=
 =?us-ascii?Q?lhjHaw40vE7hlmSSjNI3y0OUAVSUx/lcKYQkQFIk0TMBfuNd8PfJdsuS2RNO?=
 =?us-ascii?Q?l8Z6+r8zlXpJip+u0IuMw/rxHPhbJICs8rybpSu/Dp2sR6rd1VjdYhPKIEgv?=
 =?us-ascii?Q?5hcSWiU+eu4U0PeQrmYLuO+1rE9TNcfLmjevpSF/iKEdqCYXmbN204FXEYHZ?=
 =?us-ascii?Q?JV5u+nyf0CytzTY/2sIWT7vQtEjj/jDh0HU+XRVXzVvPEmd8ko/728pxAky0?=
 =?us-ascii?Q?06ZUU1K4YYaGiVSUnAbzzCd6OpqbJtWxoQPYMWd6dlSXEuPTOSjiT0HvDeNO?=
 =?us-ascii?Q?2OSRrcYg387ErndA7gJXFOG3DdmkBbO45Og0G1nVO70uPhFRrwqTqWB3xbxy?=
 =?us-ascii?Q?/Xd8zSsIbqqqg6T7ZNTlGHr+brPZHXRtVHRxP43CMhFAeTEdsC3q6AK9Qefo?=
 =?us-ascii?Q?S4fL1k32dtUpEMmPKAg6fxg7?=
X-OriginatorOrg: f-secure.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2286a8e-b537-4afa-45a4-08d972b3f9b8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4507.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 10:32:36.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d5bc339e-b691-425e-9d05-4181afc9e065
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQQ/1L49Z+SZOGZEiaUD4GcVWhuj4rYWXDsWs6y6GE5t58mxsVcbMJzy0miohKlWas0KrMn8+ofaxZOMUkBgSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrej Rosano <andrej.rosano@f-secure.com>

Add support for F-Secure USB armory Mk II board, an open source
flash-drive sized computer based on NXP i.MX6ULZ SoC.

https://github.com/f-secure-foundry/usbarmory

Signed-off-by: Andrej Rosano <andrej.rosano@f-secure.com>
---
 .../devicetree/bindings/arm/fsl.yaml          |   3 +-
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/imx6ulz-usbarmory.dts       | 238 ++++++++++++++++++
 3 files changed, 242 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-usbarmory.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1c827c1954dc..a11d10a22b64 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -595,7 +595,8 @@ properties:
       - description: i.MX6ULZ based Boards
         items:
           - enum:
-              - fsl,imx6ulz-14x14-evk     # i.MX6 ULZ 14x14 EVK Board
+              - fsl,imx6ulz-14x14-evk         # i.MX6 ULZ 14x14 EVK Board
+              - inversepath,imx6ulz-usbarmory # F-Secure USB armory Mk II
           - const: fsl,imx6ull # This seems odd. Should be last?
           - const: fsl,imx6ulz
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 863347b6b65e..6fd2b8f55255 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -655,7 +655,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-phytec-segin-ff-rdk-nand.dtb \
 	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
 	imx6ull-phytec-segin-lc-rdk-nand.dtb \
-	imx6ulz-14x14-evk.dtb
+	imx6ulz-14x14-evk.dtb \
+	imx6ulz-usbarmory.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-aster.dtb \
diff --git a/arch/arm/boot/dts/imx6ulz-usbarmory.dts b/arch/arm/boot/dts/imx6ulz-usbarmory.dts
new file mode 100644
index 000000000000..6262d30bcb9c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ulz-usbarmory.dts
@@ -0,0 +1,238 @@
+/*
+ * USB armory Mk II device tree file
+ * https://github.com/f-secure-foundry/usbarmory
+ *
+ * Copyright (C) 2020, F-Secure Corporation
+ * Andrej Rosano <andrej.rosano@f-secure.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "imx6ulz.dtsi"
+
+/ {
+	model = "F-Secure USB armory Mk II";
+	compatible = "inversepath,imx6ulz-usbarmory-mkII", "fsl,imx6ull", "fsl,imx6ulz";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led>;
+
+		led-white {
+			label = "LED_WHITE";
+			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-blue {
+			label = "LED_BLUE";
+			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_sd1_vmmc: sd1_regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "VSD_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_bluetooth>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	wakeup-source;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_bluetooth: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b0 /* BT_UART_TX  */
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b0 /* BT_UART_RX  */
+			MX6UL_PAD_UART1_CTS_B__UART1_DCE_CTS	0x1b0b0 /* BT_UART_CTS */
+			MX6UL_PAD_GPIO1_IO07__UART1_DCE_RTS	0x130b0 /* BT_UART_RTS */
+			MX6UL_PAD_UART3_TX_DATA__GPIO1_IO24	0x1f020 /* BT_UART_DSR */
+			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x10020 /* BT_UART_DTR */
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0x1f020 /* BT_SWDCLK   */
+			MX6UL_PAD_GPIO1_IO06__GPIO1_IO06	0x1f020 /* BT_SWDIO    */
+			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09	0x1f020 /* BT_RESET    */
+			MX6UL_PAD_UART3_RTS_B__GPIO1_IO27	0x1f020 /* BT_SWITCH_1 */
+			MX6UL_PAD_UART3_CTS_B__GPIO1_IO26	0x1f020 /* BT_SWITCH_2 */
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO02__I2C1_SCL	0x4001b8b0
+			MX6UL_PAD_GPIO1_IO03__I2C1_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_led: ledgrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x1f020
+			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x1f020
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x1f019
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x1f019
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x1f019
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x1f019
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x1f019
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x1f019
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x17059
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x17059
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x17059
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170b9
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170b9
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170b9
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
+		>;
+	};
+};
+
+&usbotg1 {
+	dr_mode = "peripheral";
+	disable-over-current;
+	tpl-support;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	tpl-support;
+	status = "okay";
+};
-- 
2.33.0

