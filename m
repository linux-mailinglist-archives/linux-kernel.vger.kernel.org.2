Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC883E01AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbhHDNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:07:09 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:35169
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238339AbhHDNHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:07:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBFVfQZfIXKe5H5JtMal6LoA7muWDLFyE7SGfsguH134SsKOc9i909a/cF9/8hsUNL+esdCPeARZ0L52r+q0cFC3arx+qcuQ2q/Yeav8X3ZTqeaFG1SZtk8KJDF+Xr8gXDasggUTIhySE6U5ajlxZ4GYtuGbSavi9dbiNCXHFc1l2JeT+8CaKvxNvEt5azXL9jrP1iOKT2QCDEfCCglHZAmPR2jfB0CWiz/JkO5n7YkpsQXs8YZxxt1BRR9PVcv1oSgrxyalOOVL25FafZ4tKL+AQ+Yi0LYf8asmgIPEoULsfyV6mpmavBIm4hrzjSf6gHwQIcQzztHRs4Efe3wZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qgg4iqthx3UQHCwze6kFKISQ5mPVirG4LIbMrbFlmRI=;
 b=Tv0fzEBduS/8wekbMUonPRrQvcHyo8TtdbvNTKXxxVrAgvsjQThetXYS5gauYl5ElTDuma4yIj08EERP4z5HC28jsomjVTjiPX9RSmTvu+0yQjM85p6AZeoL/ilVoRHnhNWFIYj+AAH6ZftsS7rp6D/9dYS8127cLUBAoqZkEMnsG+SyHjYiwqQVOmHlSxw6HSkGPFbiourXaBerYEcQr1sbm/OUHu0BGcgkzCohtgh2aFcXPQJAIxKugeA0NaW92zZzryGMK9DJMH4knuTz+KXBId/EvYNaSHl7CKY5GaTagKH/CZX4zGnPhz++oyf2MJ7uPyVUyHa2Rne0T7GJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qgg4iqthx3UQHCwze6kFKISQ5mPVirG4LIbMrbFlmRI=;
 b=n8/C+6fx5+MIA9PlomDgNZbpNDWvcoZ0A5xAPM0rGw7oSnZUEejSfYVthtUYk8xPfGL6H5ssAk/7E0uXA7PXkS2JxdTzvHS8LhVt9yRSE3lBzlzmTY2J5iMhgqrGzU9g7zS3PK42+UF8vad0xpgF6uhk7D1IcxPxf7DmN0BP2Uk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5401.eurprd08.prod.outlook.com (2603:10a6:10:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 13:06:50 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 13:06:50 +0000
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
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 3/7] arm64: dts: rockchip: rk3568-evb1-v10: add regulators of rk809 pmic
Date:   Wed,  4 Aug 2021 15:06:21 +0200
Message-Id: <20210804130625.15449-4-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804130625.15449-1-michael.riesch@wolfvision.net>
References: <20210804130625.15449-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:200:89::22) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by AM4PR0202CA0012.eurprd02.prod.outlook.com (2603:10a6:200:89::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 13:06:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84a5c77f-00f9-41c0-32a3-08d95748b8b5
X-MS-TrafficTypeDiagnostic: DB8PR08MB5401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5401875F982DEEF8D36B48BBF2F19@DB8PR08MB5401.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxtVfeFswklP8PRC08wCVfgOW6A+AF4E95LZMz6Eg/DOXHUDrOPNS+jqM1wd4KdJ5OS6dwExyNgJfCk+iPbt4BDR8fi4bfk3P74XXd7+Y0mBx52cy9YSM/NeDjWxYQvEUym+1sYIZeFAI1As/07BrMW+YK2MLEJ4hfGBe1pCU0dhUpfdQDg0Jxn7s8HF3ZGLxuY2MeONOxEwDuj+RgR8CMZwr7vhluHy1220Csq69P/vzdHbHKGH5xaXVa//ooO2obLygdeVHnUtHW3LrFrw2DIiirfSe8ZXGZNBZqTF5bZYFtoCrSNUPRoRFa4Eoe23Lzb1oEz6NP0tr6tGDoA07hiWzy9O1k7SSw3wTl39KnX5kaeXFEyffG4Ik9IZyzXaj2Ph6NctUSHsFqIEktIBw76r2B0jBNNceFDH1XgHVQ3ubZWhr/Pm6eJmlnm2yFJBzDImRcHNJnKOm/0kFwfCTmuFeaZY8FmhDX6guDmRYVywEdeLe+R2GVdXdlyzNdH55SXJZqQiVwrtK3IobNcece8zZkrymegzZwKaNQ62TVpiMp1wLshc65xHycT6RMOH1YZwERaX8gTNZ5Pm4twioqlREa8SMjr3OgeYb0SI9KNH8ND1A+NLjhJZqQexmWqWLh8TAZq1nnuxBxV0ful81oKZ4kf6Fxd3GjitC6KT6esQ8+NXEtJ/5Hl/M11S4Q6+pwuE1g6UrCmDB1avgJ/4XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(396003)(366004)(346002)(136003)(8676002)(186003)(956004)(1076003)(7416002)(478600001)(2616005)(2906002)(66556008)(8936002)(66476007)(66946007)(52116002)(6666004)(83380400001)(54906003)(36756003)(38350700002)(5660300002)(44832011)(316002)(6512007)(38100700002)(26005)(86362001)(6486002)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0WjAyxxtpOziug/geh8GqvF8Yv2s2/4TsSpa8fCK4FHal9BQH61vx3Zup+K?=
 =?us-ascii?Q?pb8mpq1t21IXAOH9MwuK5ipFEF8fTlJw1Q+3Dij4igI+ZMZQO3XIudivkXY/?=
 =?us-ascii?Q?FhhhMFzC3ftEmLnRK7dUk5T6vaepITXT6IuEQvC7zOLwgRQBYX9QyupC8amm?=
 =?us-ascii?Q?WIJfX9N8V1A0HL2Ycy6MG2Tbzhn/xG+kxZNCMsdOYnNNCKgFB5tEIANS1xDD?=
 =?us-ascii?Q?j4/sHas3uqbo6RHDX49KZHza/TvioOYveLwuiMpuD6UJ9DdxFnxgieWXS4/g?=
 =?us-ascii?Q?m3Eot7HuNBDFUJ4UvItyPtfRrH2CYUcAF8P9rYrzbk3BLhKkwGd9Y5YOxklh?=
 =?us-ascii?Q?++txCLpkogd//71KclMEvTh17tnuhlCiabbtRoDMtgTXCVX4SJA6dlU0jxBs?=
 =?us-ascii?Q?2gjKrbgTZFLF0z1z2/9r5nux/VSV/qiQE+DuJj1KcKGEDORcAoTap5hiO3rF?=
 =?us-ascii?Q?+A1qURm5beFmXh2bXDHSsniKfgTVhdmbyRlxUcOjAQbbYkvK3k8WTjCcLheb?=
 =?us-ascii?Q?5ewFG6S2YkZPAjGn6Sup7vYQgauuFuIpgGI9PI8aUjauj0ffR7ABAdTihrVj?=
 =?us-ascii?Q?/zxkPc1klhV/I8SwHixI+nd6Sd5+5U2eRLVfJII5u7tFxxBaBeDNbsmHlbSD?=
 =?us-ascii?Q?TmyqMmwA9//YFMGnj8I/EfwobzZJyPE4S9SL/T4VH1cKLduIQDAumGhUoFYK?=
 =?us-ascii?Q?IsLkM1nmtRFiNFYIaW3Xh7VwBZSsfa+CYlL63I8mJuDr1toRIQ4u0hFBUC1c?=
 =?us-ascii?Q?qKKI8VEr3cDkWk6u7LZ3cfCUDC3ev3bAAnltzQDlY/nbLRknW9LwvEgLlmRL?=
 =?us-ascii?Q?jbS0PzrOLIBQa0d6k9/OjRDezoeqJ7yjtmWR6y+myJB4yl32PH0cXcNf0P06?=
 =?us-ascii?Q?+QizDGHMAvFNTF7z9yqEemFStt+4YRsITQY+h5KQU4r4Rurf7LoJuJNJdPCS?=
 =?us-ascii?Q?6/GW0CurKde2jDGgXVKXP23w2nQXXq6QHW/xweDUwTfKS8XYQznCd4WP/Bz6?=
 =?us-ascii?Q?uRyUbCn7b62HizAUN7czBln9v01o4QFgkRvNsHO08VTwJ45HRbUWJF44P3R3?=
 =?us-ascii?Q?MOIsRJsppclTqKFNnzrS0yoGxclWC9Ann6/gUlqtNZNvOxKONz5GyN+h1biY?=
 =?us-ascii?Q?GHtmrOzLJVcXC0kSWZy4mRQM3koWaT7pPngIGRumTvz4CbHkIKxc0mLEGiev?=
 =?us-ascii?Q?OJTuJs5WLzkYcstr3BaFw6BNaGRrJVQ9zXuw+xpTcZNMyzzowda3IcwtSAJ2?=
 =?us-ascii?Q?c5VEPNGJbVtFDLJ8oPrM+I584NfAUJHJfNcLJpmzq79BAlFomfHVQn4aqdyJ?=
 =?us-ascii?Q?AyOIPTQOMNglXlEBjsZCeMlq?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a5c77f-00f9-41c0-32a3-08d95748b8b5
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 13:06:49.9099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fF5Kv+6yFfMXSg4GYE4xOkj0eVxvs6ftcM7NvdG2Lzp59QPF/T4VuAI8RVBI5YEaau69K2UyAiwjWpV8fpeMrf9kI3bw5HfNQsKqPyAOH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 206 ++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 65e536c78d2e..f682144a1892 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -104,6 +104,203 @@
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
+		wakeup-source;
+
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vdd_logic";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vdd_gpu";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vcc_ddr";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_npu: DCDC_REG4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vdd_npu";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_image: LDO_REG1 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda0v9_image";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda_0v9";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda0v9_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_acodec";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca_1v8";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pmu: LDO_REG8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca1v8_image: LDO_REG9 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_image";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3: SWITCH_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc_3v3";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: SWITCH_REG2 {
+				regulator-name = "vcc3v3_sd";
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
@@ -124,6 +321,15 @@
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
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.20.1

