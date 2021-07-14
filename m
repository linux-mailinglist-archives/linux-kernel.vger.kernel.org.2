Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC53C85BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhGNOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:05:06 -0400
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:4066
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231543AbhGNOFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:05:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxq3YPyk/T9iHTvHkzevnAx1U8jGAEj+hU2fisuxR8lFOP1PgaTg09cUqukitMYUYFW9BYMNdX/VBhhhJyWYxzIUB10hepc0CPiuvrrMzb2pyI+TdPx+vyD/qVuwLlwXKQqBPSoUe+LkqNnJcvcSOvvsORGa/c95VfpsRiolKujIe6uP0djY4GRD7kqEvSCy6bXVSFWs3buw0WZ0eKXQ/rioncxU9QybpzBzmV4//VZMn6BujDaOqZ/SD2GksZ8KEu33Uhpmi3yrynmknd4sLOI8o1TpBaGgmumX0Gq91as7OCId0dlIq4c7vkrgpxEK7IW0px1ouvvSREMnQ38auA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCTpiCwdvqSHD0PHcthuntyvqkJAb5/rlMeMvqqtbNQ=;
 b=esqcSbbW7AY31Nr4yncGBKQ7RKgqbcbyUy1yTpm4AA0zKHfUymuDLAD/arv7nuwU2Bd9bvPk4Vu8IOXMHyZ0YbUDWzcBMBZXE9rRyQwnHJkzLQq4yW9aFgy89QHnCNc70nJ3wNzqR0Mjb+q3cHntCH2cYoBq/F0yMOt4Mb4M6XAl5OKMorETp+c90/SPFldfYWdyoHT1Y5QG6rm14BGhA+HGqqZpvf+xNvC3KvLWjK1zp+iE0Z/35l9/+8AW9x82P/M05U+RsfigQA6C3ewgzH1ybeiRbbBm/2lJ5WsiKnsRgbbShNNWFLS4kOfMT5GuwRmloP9gilZMlqjdrMRTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCTpiCwdvqSHD0PHcthuntyvqkJAb5/rlMeMvqqtbNQ=;
 b=cyd6PZz4T0eQhBwAmSG/g2YqPVWK9auO+FSl2PGMzs4sU/3giWRp4yQgfsr7RechWDUX/DQCLvKk5YGy4sHqseEdio4CaeGuugDJucvFAy1JIIPmpfeIKuWb+QgME5NtQoeYkbJMNg4GeqJx3CyY6G7uGt0wFLv34Nrp6CaVUsw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by AM0PR09MB2404.eurprd09.prod.outlook.com (2603:10a6:208:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.24; Wed, 14 Jul
 2021 14:02:10 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5%6]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 14:02:10 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, aisheng.dong@nxp.com,
        oliver.graute@gmail.com, festevam@gmail.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: add lpsi1 and lpspi_lpcg to imx8-ss-dma.dtsi
Date:   Wed, 14 Jul 2021 15:59:35 +0200
Message-Id: <20210714135939.20403-1-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0902CA0011.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::21) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM4PR0902CA0011.eurprd09.prod.outlook.com (2603:10a6:200:9b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 14:02:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eb687b8-42c9-4731-634b-08d946cff93f
X-MS-TrafficTypeDiagnostic: AM0PR09MB2404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR09MB240490C014CAA7A2FFD6F85DEB139@AM0PR09MB2404.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMOgu8NhiZef6bB4yaosp0ug9/uc80S20SdWk5MzRA/m538DDGoB8+vjh3RcxPawpnHx8lcaCk0SCunTI2xTr0zpO72J/yew4QjNL2aztBn+O6fw8i8fpNz+eYxkW3Y+hzQx09EIUTXtagb8D5DCsGLpZJDjr2TtE2lQG71J7iiLBc3L86VPzjDGRkZoy71gjPixKHwQf1J8fDuQd1Pkg7S+ydSCZDQgJ8KykBotCSmg9MGEXNRRelkBhaqI9Wa5KILemb6dry5wtIknKi8Tk3HP3KnwurC9OuYeQ3bK3qwZwfDK+T6dsOFGa5rgPQ5/THd/4hoTf8g96x4NsjUCeUKA+vIpi1YRv4cZuvv46rXX8Umdq2179tP92WwjkuPcB2GbwH3zASTnbKEVwFzuM2V8FVhj37psNlu9dVyfhD11tTZM1PccC1SO5EVRM/PbHGahZG1EEMkPlTrJ6WiUOU6oxi1yl4GfW3EK7JQ6hBA5zkXsA/QnE2wyCbi680dg6hOJ6h0jtV5EArvbmCKmgD8mVAPFwlPX1D8KdQe5leoKoqWPLqm7f3x4f/9HdUpzLheyhzPlmGyAPdDwl86Pm/sL9clPDFR9VyxH6QWhA+3+AU1njj0y1OUO5b4l9loveZEsNQb7IbacZtqvXbt2J1bIFwmVPCDd9Gw46Dy+hbBrNaFtLG5YSkwyNsKdpk74aerFRJ6AcQkYJMQAhjdA+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(39830400003)(366004)(186003)(316002)(6916009)(52116002)(5660300002)(7416002)(4326008)(26005)(36756003)(66476007)(478600001)(8676002)(2906002)(66556008)(6666004)(66946007)(8936002)(38350700002)(1076003)(86362001)(44832011)(6486002)(83380400001)(2616005)(956004)(54906003)(6496006)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4hDcLMYO+MdkaNO2rNtY1U7zcs2yaOwdH+kSwgxjagNa7Phlu7JgnGQWoR7?=
 =?us-ascii?Q?2fAR3pYuWMYEfp0SF6hg3uOo5i3dC6dar7CxmAYszQxKiMQJdPyF1iG684Wo?=
 =?us-ascii?Q?pcY/+q1DVkA1Qt/d2ehyvFevH74AkbBPrqNA4kXuQQEOLsMmnJAvindqacOY?=
 =?us-ascii?Q?NT1OcCYI8VUw93B5CjA0Z2+QZeQYQsKZWCsFYOeyr48m7af7vohO4k1oSPjI?=
 =?us-ascii?Q?72p2NSOwryRF1bmWl6hVl3xfWkAXb6KW0DYcgzk+nMBtORiMl3S+2WVlfPPS?=
 =?us-ascii?Q?SyMCPKlZZO42RKJSSTlfAcBhbYUZQA6aC8GTdJu977LBXjuRmmqdBVADfFTA?=
 =?us-ascii?Q?pGruh6IH01+cq5KbCpkcZ7C89oVtm5QxyIN55Nbr6c6RBp9aC1YItNlyGTvC?=
 =?us-ascii?Q?TAgZiC5kaASwbdxAxeTI7IwWOzLhdk3KrK+K1rxkHGKBzyuMS4yurVA3H/OH?=
 =?us-ascii?Q?ZOzjf9DK6UqXH5JEyi21orVIDuDlFbn4qh9AN9mGTiIBFueNaaK68ZNEugUD?=
 =?us-ascii?Q?in0Guu0fGO0tS1m5iuPF3bkwInDKdGeJzPMPv/XGqHzMj32jzzGnW2kKg7dX?=
 =?us-ascii?Q?pZArGMpeeVeJCraquhAk7DO+La08r1qbjLYK/kGZdkl7TSQSySTKq8xeE8hV?=
 =?us-ascii?Q?spBvsdINlHmc6iKHQUYbGi+JAZL5icWD0FZr49nrRYXWKJ1pncYrYZHF2n+D?=
 =?us-ascii?Q?8RLe+7WPid22ImV2LyIFK/xCapIBa5UKNcRH3rsI1k+gGHtbQhtQpno7TkAE?=
 =?us-ascii?Q?8a47F1djSDgtlqAp9fTT3IkJKaTJ/CZevd3K7TRLsqBO2xCQiPmS75IITLJ2?=
 =?us-ascii?Q?XTvzNXDDOmjKtuiAiiIfn3l2bisSiSMwobFpYZbXBTkZXfHPSMG7qA7ihkff?=
 =?us-ascii?Q?Dr29c9JtHiWbwbp9qT9a2T2x9eVXzwPkngSfYcUFXuQYEFR+ziGtxwYVF7+H?=
 =?us-ascii?Q?RX8au7GnnGa16dqZYKlmy05kqv0aTTnh5f0qqZzl8hyHrRAdkedL2qyDF7yb?=
 =?us-ascii?Q?scSq90OD0e+gfe9DgMYgslaGgQXl1qPNZsuv0Kkxb3vOkcwzpzFAhrmCclI0?=
 =?us-ascii?Q?7VVa+jYbR6VxHXLAT9efuJeDYPUk7TJhQSbI4/SnaSfvwseIQ366wr6buPvU?=
 =?us-ascii?Q?qL0Um5H6HyQNbnknmxFDYkp1qqyIFqFe0jSRyWg9Hteme/kgtggBruXC1fhU?=
 =?us-ascii?Q?pQ2jLugBlf9n+BVeQBFMwu8FIj1i6iAGXjL561Ic9NvVV9FQkdndjurll9M2?=
 =?us-ascii?Q?jO/8U0Rggr4m+v0qRA5RCS6UuMzgwmkBQOSsZN3ZzfTvg8CaDM+MUbowi4g2?=
 =?us-ascii?Q?qg/CHxhxj7LzhHYsz4miax6g?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb687b8-42c9-4731-634b-08d946cff93f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 14:02:10.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4LpHNp9UCdxDnBYVgwt5eOCJ8eejZhnE0e93zkpTBC4Qx9m5iusdul42/LlvLo4wYcusO2T2frb2WUgcH3jo8Jyt7rZlRlQfaEMm5RidbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2404
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add lpsi1 and lpspi_lpcg to imx8-ss-dma.dtsi

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 960a802b8b6e..98911e7a5d25 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -60,6 +60,32 @@ dma_subsys: bus@5a000000 {
 		status = "disabled";
 	};
 
+	lpspi1: lpspi@5a010000 {
+		compatible = "fsl,imx7ulp-spi";
+		reg = <0x5a010000 0x10000>;
+		interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&lpspi1_lpcg IMX_LPCG_CLK_0>,
+			 <&lpspi1_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_SPI_1 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <60000000>;
+		power-domains = <&pd IMX_SC_R_SPI_1>;
+		status = "disabled";
+	};
+
+	lpspi1_lpcg: clock-controller@5a410000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a410000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_SPI_1 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spi1_lpcg_clk",
+					 "spi1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SPI_1>;
+	};
+
 	uart0_lpcg: clock-controller@5a460000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a460000 0x10000>;
-- 
2.17.1

