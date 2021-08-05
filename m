Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD893E1457
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbhHEMB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:01:59 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:52366
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241219AbhHEMBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:01:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZKaMkx8fRv9EPolLirTyY51DeMTotdIAiV5cZ/Rz5eohj4tRr1cGuB7G3BcK1ElEO9mYkz0QJ/gHPWn/74qCRWbHtGwd/8hiVxU5yfqmzGQ4zGNy2dTeCNZGKq5gbwvk/ATuj72rfCbGQTSvfNoAchseaYMo8Y30L7HAY0Zf8jdfLVXmG2H4qCcC1GQkZDIBawZQFMlGI8yCVR2kaBIAPrKK/HorTXtvYDOrzhpPZfYGgmZuEcdndBE6EQ7aQaVx89IPoiATMlBT0jg9oNSLSUwxQ3odNy/c8vK71YJGLGObA9F2mhz4Rj6nQOa+MbVy6U/9qmh+WctijMEmYLi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zakYE1Ce6YbIpqANrDgpgwKBLQMbF5jqqIZHPDQoqj0=;
 b=fOmE237inPcCmRvhfi3ijEhqRjckO070WG1sMUJD69TKw6MuMiR/497X0JI9TlavvJgnGyYBT4myXfrCkJEMV2kWIFytcXxTMNR8z57ao8q1qF7w8vj8CH7UBgpFa1VxnyyKtvitMM1Cn6fhMvlsV3z/GF690CCvEi1x7RTYNjtVW1vPTSugA8ztcZWpvsfSm6yQtIM1mQRTMEnRIjlbHZoOuXvoBpOg1b3uDzyeMT6ZK5VK6uEkpaT8d/HVI9fWr6UQxgUSpRUMmbYS1BzPJQKCO0Wg2bibGzvpzDCwbVIdsYScOZgW7KkCMjkRUny401SImrnG6niDBlnE9TAJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zakYE1Ce6YbIpqANrDgpgwKBLQMbF5jqqIZHPDQoqj0=;
 b=V+SbBY5mT3BO8uqmKqqRwilAP7dT1OWBin+ob4wSLJBA8lmwALav4R604sHju3G5dzUdGaMdPVIkcqqeawbCAEwsPFbdnqcqU0SrlqSRn67W6j3cKHCEsFW7ifPwWfyk1ns+xtCUtv4T5NFXP97n9hPC+1xirGwlqnIwpk87R7A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB7PR08MB3865.eurprd08.prod.outlook.com (2603:10a6:10:74::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Thu, 5 Aug
 2021 12:01:30 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 12:01:30 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 5/7] arm64: dts: rockchip: rk3568-evb1-v10: add regulators of rk809 pmic
Date:   Thu,  5 Aug 2021 14:01:05 +0200
Message-Id: <20210805120107.27007-6-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805120107.27007-1-michael.riesch@wolfvision.net>
References: <20210805120107.27007-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0099.eurprd04.prod.outlook.com
 (2603:10a6:803:64::34) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by VI1PR04CA0099.eurprd04.prod.outlook.com (2603:10a6:803:64::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 12:01:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29dc803a-d0c5-4a40-2862-08d95808c257
X-MS-TrafficTypeDiagnostic: DB7PR08MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3865417D896CC9A5B8FBEF34F2F29@DB7PR08MB3865.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNeTOE9vO4oWNvpajzqB6Yh8dSvK1RmKfOa8ep5Nx+El9Tyw+XlIbSH3i5LAoe7mdW8iTOwqOTVvYwYWWWWoI2c5pZAgUW7fo7Sh0itAR0qgNGZc0qxdJ5/XfhHa0vE90gZ/hANn+FjVwxkH9WwkvIZmI9nhivaYmFzmxOPEAWzAE3TnV3iU4bj+VLMBsYsQp8JDxnP10wY+SosN2aDGq5lGK+wB1rDDwfCODt+yPsCG5e1YOXJTD7uina/TsaO4lnnruOHLTxYC1e3jQhJIcA4X7mH+6g0YxTRBJEt0q7Of6/2iz4sa+7dSjMDDLiGAsgQ4u2iTCatQRQVlO4I47ftHztbUfkWvndMLZopx+v4S7I3vCnZlYzxR4G0tCvbeh23AY05iKlcBNVY0/D4Y4j5hzSmDE9sMFEI2GPVKdZMcAZryjaMF5e3aMqzTzww1yYUWKINm+aNnWlJjGQHWOUVq0ZKqyO67hjlCFmpV+83tCi79H5QKIfrK6kR/ud3zegOiVwYe8oneBT4baojwOR4oa8DDG/u/6hRDhQnF7Mr2UGI7hFapn9p55TqmDiAypLw59zqGk/cTGJWDg9FYN0mv3zWiWgwQRTcHNHrWuvAN6yjQ7qllr3kuNfZFU4qsV/O2PWc2uakOYriQeKGHxYD9DwFTjyTC79JeUEVuD6syx7FzDJLVijGiovUAFNSvijU8iZcjPMm9YoGOuZtxpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(26005)(38100700002)(36756003)(2906002)(6506007)(4326008)(66946007)(508600001)(66556008)(7416002)(66476007)(1076003)(38350700002)(956004)(44832011)(2616005)(54906003)(83380400001)(52116002)(186003)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0HCJ+r7tecU32da+jeHzEayYENmcoA5HkqGZX54fpRSwqjMeaXCv2Q3jsdj?=
 =?us-ascii?Q?oxXrHvHKHF/Ld/z2Z9PS2kemsg+UsX3b4UiCyjDCXLc/aSMnLuxxLw2zN3ss?=
 =?us-ascii?Q?Q5SZAgzkWWUhu5iJS72q3FHdMuziFl9+P4Cl1MMyh491zvGaqQZl0JEMW45B?=
 =?us-ascii?Q?xvL1AqFJ6NVPpPkG+Zev7MqpEyIIfozAC9M3aTu96NFd1IJyASh/sM+R+wPq?=
 =?us-ascii?Q?CetuNCru0Y6SJ0YANaMwLt0vgX09HJ+FdOWiqQDGdBQXvjBzKAtlJO8P9n5p?=
 =?us-ascii?Q?xcX7mB4lKt5HOBvjgbJ66/cc+lRRxIaTDbTIWO+U8Xch6Umtotu/GxmKa6aP?=
 =?us-ascii?Q?AYo2eVZQqSqN84cXSwxLMrhezjZgCosyRxyea6T8gS6velZkYYdIUTt5p/7j?=
 =?us-ascii?Q?e+goCUX7ozkO/5abksOZeGnIUUyekRsNO/pdpNwFNGpZTZo8nmfdQdYzmapk?=
 =?us-ascii?Q?v3TgIrceZ3N/l8Qy9kdG2WsB0B02+27ObgBq4rlxPDR58NwErhwnuASK2da3?=
 =?us-ascii?Q?iZiFHng3uYZpJTNHEndjMlhB31uL1zUH5Jt7QCZdkfp1UYIyBHYGkGKUA+iV?=
 =?us-ascii?Q?S1sPE5nJ8z75gi6rpXpED+N6F+smQoXzIGxnbxzvWX1sWkFT6C5PZe54o1qY?=
 =?us-ascii?Q?GMFbrpEF0eEX/acp1+38ARJ7MdqMIWHVPiirPzAbfpFns72AfM7ePz9mRgDR?=
 =?us-ascii?Q?oo0hVySesRCR8TJF/rXBZI/pSAZpypss086/JmhfB4V2GQ8TKAbfB9xsRFqV?=
 =?us-ascii?Q?ugIYJa1PHp1yKS9rU/klbhtO3okEIrxveIhvZ/UKr/VTPy192QjYasOfoF6u?=
 =?us-ascii?Q?4nlE9SBJLLdPLCfunbmsO7eUyIJFzk9vJsj/QIRKmPdlwrabkURrCeXl/Q7+?=
 =?us-ascii?Q?07QrL9Gq6NvZC3X8bM3Ekhj6TSyWJixuVvF3ZOJqfv7oFERXc23Q02hr/zOv?=
 =?us-ascii?Q?KYVPo3cAeA7V58u9JLr3g4b/yG2+uuqzxikWgtlWga9FWENrAgGhO/4f9z7v?=
 =?us-ascii?Q?oOr2Amlr3r7eY1GN91fMDRE2YZ8gX2f6VHecn/9N05JBazx3bSGyc0HrDXlF?=
 =?us-ascii?Q?PY+YjQ+8Be9gJUSwglJaX5+Qv6mSf+KKzAJWe3k8otphz7aKB3OiAGNLDD2G?=
 =?us-ascii?Q?VjTiOEw4OLs6VIzcDSPt9cH24uJ2rhWizBTRSbUxbo59+EVJm4ribWD2rPh7?=
 =?us-ascii?Q?sODDGTzP/vMyWoQ5Vk3To2FaMMomV5OBRlkzS5jwBqNERBSnp4BaEosGFEm1?=
 =?us-ascii?Q?6SUUMyirzvNYHuk6gA2ILsuKIXD0q4CtBQoMkaqHFW9ZVihFfU02x7NeXlXh?=
 =?us-ascii?Q?Hg/ulIkt/XZie2siRZC4iQPs?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dc803a-d0c5-4a40-2862-08d95808c257
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 12:01:29.4789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRvS8qNI0DJGfGamrPwfbr8u6Me2X1njNiJPMKjxfVrSYggAYRzFqnzbhIJVxwm5qhAu/m/rUYylB4TNcyqhSp/tztIKB/69l7UGOUieZXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3865
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the regulators of the RK809 PMIC to the device tree of the
RK3568 EVB1.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
v3:
- sort device tree properties alphabetically

 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 221 ++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 287b58aa6a77..92af4ce89b70 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -104,6 +104,218 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+		rockchip,system-power-controller;
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+		wakeup-source;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-name = "vdd_logic";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-init-microvolt = <900000>;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-name = "vdd_gpu";
+				regulator-init-microvolt = <900000>;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_npu: DCDC_REG4 {
+				regulator-name = "vdd_npu";
+				regulator-init-microvolt = <900000>;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG5 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_image: LDO_REG1 {
+				regulator-name = "vdda0v9_image";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-name = "vdda_0v9";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-name = "vdda0v9_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-name = "vccio_acodec";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-name = "vcc3v3_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG7 {
+				regulator-name = "vcca_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pmu: LDO_REG8 {
+				regulator-name = "vcca1v8_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca1v8_image: LDO_REG9 {
+				regulator-name = "vcca1v8_image";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3: SWITCH_REG1 {
+				regulator-name = "vcc_3v3";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: SWITCH_REG2 {
+				regulator-name = "vcc3v3_sd";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
 &mdio0 {
 	rgmii_phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -124,6 +336,15 @@
 	};
 };
 
+&pinctrl {
+	pmic {
+		pmic_int: pmic_int {
+			rockchip,pins =
+				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
 &pmu_io_domains {
 	pmuio1-supply = <&vcc3v3_pmu>;
 	pmuio2-supply = <&vcc3v3_pmu>;
-- 
2.17.1

