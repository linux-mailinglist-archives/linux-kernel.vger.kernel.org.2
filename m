Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338B43C8457
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbhGNMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:15:54 -0400
Received: from mail-am6eur05on2064.outbound.protection.outlook.com ([40.107.22.64]:62945
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239347AbhGNMPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:15:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrwQ6zLke9A1RJZJsu+KrkbpoZmgGlEdML4U0ybbEDD5XJ9r88Ny3WmYwDPBd3pHUdxX7cXWZXfcnFfqSdm402JIh4XfdJRKCC6Ch1aXS/Rb1l6szkxbcm1CNMJsbfoVW+/l1nTjOROTZlqYjv/5HnvLlDXM0CjJh5rpMPSOSr2+TovOC4WOyf0IECqtPvWLwMb376nJoU9zai0/hTGGtl+fRT8CK4hpqG5HL5G+wlWYemieqwqc/s+pjiiOxsjDCjVng5grmhn1lrG9FQrjUYfpdc55wXb5rwEik272lhhlvWntk0Cxneroady7wtYEY5YU1poLHShFbsrp4S+SxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKHyRIPXl02OaKtQ66Ll3DwhZBnnUspmPT3lzTyye8E=;
 b=i8+lApjdlSXGSQ8LEJRSGqxkoX7c/T+HlaFiHnZb3zoTn1+E0bvmcOCWNqXs4qyQ94dKG38hMmt+r8o/0hpzw/MsovgmhFpoEodCENaJdOWu1cqawXehtgLkVuSz2fEomgyky5CzVfhZ3m+DuYQi19O2kSQFPDPxlGTf+MHeEAVl/mD0ghQPJy46tmQowTIzM/jjEmfW0WbtTlCfL6b8s82+YjGuKaBrBiU3J9YjLK9ckh4FVNksuiC3X+dlZdmq/IhwYLIQk7kILVvyZDLpo6CsKrEKLI8lfkktLQLqVNbrq/2oP52AJIxx2tkP8tYyB1+GTF/Mo43K2y9O7+Sc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKHyRIPXl02OaKtQ66Ll3DwhZBnnUspmPT3lzTyye8E=;
 b=d5D5H3Fr7QRu8teR6zoa5R8JYMQ+6B74aVh1uglSrMjGoLK9mot6xgVEK8IQ7idJEOd1qbozj61Xp7s4NiZVe8PIFV8qi6/9RqZig3C0GuMBK0bdU0vDK/Iw8+tXnUwUn62ufXqGtT7V+AiB/fXG9mkUBPgynzHEi2zcfzqDbc0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by AM4PR0902MB1748.eurprd09.prod.outlook.com (2603:10a6:200:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 12:12:59 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5%6]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 12:12:59 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, aisheng.dong@nxp.com,
        fabio.estevam@nxp.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8: added usb nodes to imx8-ss-conn.dtsi
Date:   Wed, 14 Jul 2021 14:09:20 +0200
Message-Id: <20210714120925.23571-5-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714120925.23571-1-oliver.graute@kococonnector.com>
References: <20210714120925.23571-1-oliver.graute@kococonnector.com>
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0131.eurprd07.prod.outlook.com
 (2603:10a6:207:8::17) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM3PR07CA0131.eurprd07.prod.outlook.com (2603:10a6:207:8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.12 via Frontend Transport; Wed, 14 Jul 2021 12:12:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94a9c014-16e6-4012-419b-08d946c0b88d
X-MS-TrafficTypeDiagnostic: AM4PR0902MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0902MB1748FE5820732A169B1292E3EB139@AM4PR0902MB1748.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5YfN1BGgJHMaGwDqye70RFQ4YS+UemxVOwCeJypnugObrxvbii+DZKK+N6kc67e3StgRnf+qzvwtgdE/R35htPXnKa92i54FPCSq9um7S91wCfvkym0u+/8Luzr3d+kiq3nr05cVVOvWz34LooAFUzwUM2rQV0UdQn+CQeWeL8yLOK8YvuB5LY1nBco6zNbI3Yv/Cp7SN0bc6BJ46Vbeau4RtLGPORIcTUJqKmGFba5ts0jdNTVwL+Cid5Y7f367IirVj/65a010BGHua3aYRst9T/ry+Fuvu88eE+XgJ8dCfve3myhaGqMcGVA9UQi5aWnQfRQcSYK2desRbR3R87OdZ0MoDOsaTqOmGsywReo6MTsmsqZuhC6TeyHJckqoOa6ynlHHySHhcDnA4xXwgp5umaz7xeOnBwvTbFnvj6Zovx9MLhp5fxFBswmT15UqqRSzpBesKoxDEQ6Rv/uD+YDQG8+nhtTYTP57yyOGuHAu1Nw3D8ksFuhkxF0hmu9wIn4v/weCu0rOw9hVOnPlJrleRXTdIE8s359E946tfNNabv0RqYVzIh2RUa+XtgyWYU+u6uwr8vJOwk99G1lcRLUcqmHICOZS4OAdVRzKz24SgvntfGXLbpd2EYJyeQnkejua5bbqZ0YjntnzmKlcPm1adarcWgNSvlHHm/xEsqXcOeGY/9t+7aGm9pFgN0mK+LTyTG51rmg9Xe00FIaaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39830400003)(136003)(376002)(7416002)(1076003)(316002)(6486002)(8676002)(54906003)(86362001)(38100700002)(478600001)(6666004)(956004)(6916009)(36756003)(38350700002)(6496006)(83380400001)(26005)(52116002)(4326008)(8936002)(66476007)(186003)(5660300002)(66556008)(44832011)(66946007)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PsMaKkVWYNcca0+mQFEqq5RSztWz+sKlICywo3OZ8lkaVHCWlQokmwyZHVE4?=
 =?us-ascii?Q?mlf4IzphZMG5NvD+q5u9Yt02qOtef2Ksu9bdlTrBpY4Q37TYzKb5FXvaptOP?=
 =?us-ascii?Q?HgsJvBsXPbLoWi/RwNA214lc8gnMPRG5+Wvc6Pr8rpvZylAx7J4zwP7qHszs?=
 =?us-ascii?Q?kNN2KmjofYS1ewTk7nyPnGYh8rZznLLO8pScNRTK4Vw3jq3r5YW1ANMO0mgp?=
 =?us-ascii?Q?1TXct3K4ksRNf5qSF6feVUDA1//+V9Rc2LiWC9gXhkyG9IwEcTIkxTFgVFSU?=
 =?us-ascii?Q?68jTlOzjy/pqOqxi29KdSCn8a/5k9fcJnYTZ3p4r/2w9mezsvzLLEiYFvHk5?=
 =?us-ascii?Q?LvNVZEWPfqRBbpexZrdxw5mHNdlgkl4l9XQo36iNCMoKIKMheTkrVD7Xqf20?=
 =?us-ascii?Q?VmelqqK52xAD4XJYTqsKzx6JU1F8YpsdiqWQnw+uWeTRL6irnwSOlrmcdzdM?=
 =?us-ascii?Q?MNEsZ4MhoV1FfI8hY5TjqvP/iPjGAoBv7vse2APxSzLcAOQu5AhnHhD5NSEN?=
 =?us-ascii?Q?T97VYVe5hdDd5KAG2D0NXpFcYOnnTigq7WCKE/VucB1fZQjyGeaOk4DKkhsO?=
 =?us-ascii?Q?0M4DhwbW4fHyOaaHBBTGDwtz9iHbhPQBPUnn1zya87pmqbP60albq8h4DwbU?=
 =?us-ascii?Q?FfTGXZMaoiHjsKYEdYdhqIj0ho7yavNmP7e6jwLefB0WHxPh/zaaD7qPlHP+?=
 =?us-ascii?Q?elX65atmMwG3GaWxMLCq75mDv3ZVyS7RU8eAJFrfuMXe+HFXMq6ZsLC80XFl?=
 =?us-ascii?Q?Xokx7LbZtOYjP6i+/hCUDrkXChugd89P2uM9ornJJlAwMuUnb3nX9sppNvVZ?=
 =?us-ascii?Q?ny+6Kwssvw+RqLLX5v8dIQlmsyzP3gamL0rV01c3x5iOnMK24IDHVmTJOgB2?=
 =?us-ascii?Q?nbit18+1oRSeLyUi5t7X6vMKM/fKh+A/M/PY5CAM9blD/8HdIalgQbHZaf/i?=
 =?us-ascii?Q?QnAIYJjjgrqRX+q+vQbGCPoNWmDdq1BpH6f+piJO+NZsEmn/c+co5Dqq1L1g?=
 =?us-ascii?Q?wLibPTxU1+iqgEQuDc1WpW9eXHXV9HxAC5ECgJkOAuTMmV3I4ygL/vio+H3T?=
 =?us-ascii?Q?/weUpECyGAF7RFZmDTwtrrRLA4OJ6qq2T8UgK0KSJKWRMG4HIB/bsEduX+0D?=
 =?us-ascii?Q?nBxEdW0gExj7QBWR9PGGKXBEK368Z3nUE55T7nKxrfVunJU9SRzGBgSNsvqB?=
 =?us-ascii?Q?U5UdKunWCdHnmQCiz4HbcKectRQM7kXCL00GttXt7ZmtStu/6EEtJySHwFaR?=
 =?us-ascii?Q?fpK9FUicBw2pmxYjceTYBmDB/zdg7V81AZg5ezRZVvxc2nJF/0jW9gPR/aob?=
 =?us-ascii?Q?FxgDRCgdcSod/BLDW/Mx7bNr?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a9c014-16e6-4012-419b-08d946c0b88d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 12:12:59.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MZPYDQpIddm9TOwNw4VksHEiAJX8T8nMlJ/R/BziCwP+zfjBAsBWNZDWSRsaObGLA/YlgaCxy/GMekkYY2PvGc1JdzhGQJfMVdtSZLkEPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0902MB1748
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added usb nodes to imx8-ss-conn.dtsi

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 .../boot/dts/freescale/imx8-ss-conn.dtsi      | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 725349e297be..70778aeaacf0 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -34,6 +34,90 @@ conn_subsys: bus@5b000000 {
 		clock-output-names = "conn_ipg_clk";
 	};
 
+	usb3phy: usb3-phy@5b160000 {
+		compatible = "nxp,salvo-phy";
+		reg = <0x5b160000 0x40000>;
+		clocks = <&usb3_lpcg 4>;
+		clock-names = "salvo_phy_clk";
+		power-domains = <&pd IMX_SC_R_USB_2_PHY>;
+		#phy-cells = <0>;
+	};
+
+	usb2_lpcg: clock-controller@5b270000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5b270000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&conn_ahb_clk>, <&conn_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_6>, <IMX_LPCG_CLK_7>;
+		clock-output-names = "usboh3_ahb_clk",
+				     "usboh3_phy_ipg_clk";
+		clock-names = "ahb", "ipg";
+		power-domains = <&pd IMX_SC_R_USB_0_PHY>;
+	};
+
+	usb3_lpcg: clock-controller@5b280000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5b280000 0x10000>;
+		#clock-cells = <1>;
+		/* bit-offset = <0 4 16 20 24 28>; */
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>, <IMX_LPCG_CLK_7>;
+		clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>,
+			 <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
+			 <&conn_ipg_clk>,
+			 <&conn_ipg_clk>,
+			 <&conn_ipg_clk>,
+			<&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>;
+		clock-output-names = "usb3_bus_clk",
+				     "usb3_lpm_clk",
+				     "usb3_ipg_clk",
+				     "usb3_core_pclk",
+				     "usb3_phy_clk",
+				     "usb3_aclk";
+		power-domains = <&pd IMX_SC_R_USB_2_PHY>;
+	};
+
+	usbotg3: usb3@5b110000 {
+		compatible = "fsl,imx8qm-usb3";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		reg = <0x5B110000 0x10000>;
+
+		clocks = <&usb3_lpcg IMX_LPCG_CLK_1>,
+			 <&usb3_lpcg IMX_LPCG_CLK_0>,
+			 <&usb3_lpcg IMX_LPCG_CLK_7>,
+			 <&usb3_lpcg IMX_LPCG_CLK_4>,
+			 <&usb3_lpcg IMX_LPCG_CLK_5>;
+		clock-names = "usb3_lpm_clk", "usb3_bus_clk", "usb3_aclk",
+			"usb3_ipg_clk", "usb3_core_pclk";
+		assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
+			<&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
+			<&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
+		assigned-clock-rates = <125000000>, <12000000>, <250000000>;
+		power-domains = <&pd IMX_SC_R_USB_2>;
+		status = "disabled";
+
+		usbotg3_cdns3: cdns3 {
+			compatible = "cdns,usb3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host", "peripheral", "otg";
+			reg = <0x5B130000 0x10000>,     /* memory area for HOST registers */
+				<0x5B140000 0x10000>,   /* memory area for DEVICE registers */
+				<0x5B120000 0x10000>;   /* memory area for OTG/DRD registers */
+			reg-names = "xhci", "dev", "otg";
+			phys = <&usb3phy>;
+			phy-names = "cdns3,usb2-phy";
+			status = "disabled";
+		};
+	};
+
 	usdhc1: mmc@5b010000 {
 		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b010000 0x10000>;
-- 
2.17.1

