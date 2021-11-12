Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CBA44E1E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhKLGaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:30:13 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:43067
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232791AbhKLGaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:30:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLAEjkxW8mjVmEYpyKV8RJcSzeedr9U+L/KEpJi6oYoS1thkPnoRl7nm7YlEBJhcrxGTbRc9Y0jZ9+0H/r8fVwn+tbwA0nhvmy+VXQxA2WCbjvjlfYuXGTSywTQcYubL8Spi66aHxKEvdKi/nxkvtY7FaZ+TGg1LJD4lWr1ctpJXXsbu2wnZ+FAFJFxAzwL52G9fHw06LkN+YR5nkFQ9n7B8eh0GiyvhmYyNu42eaTIISvrkY8gJxlQGLXX4KbUlzUtVuSc+LRiB9Q1AXUST2jdhZNgicekwG93qUtdkRDMRhuvKRjY4S6Fkjw2kCO4CgZ4aTN3f6Gh4b6XkWSWsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gax1ApVKc2x+9Tu9gWVtW+F8A58jkoD1mm9Wos1CAGo=;
 b=Qa0vy7/Ej8uPmenCav/Ou1kYpYMHs23NAyp3PAs6E5cY95VV3LDHD7Fk+Azs0Z6/2qVCbk7yIeIH4tP5tllV99cGOOeQWZOYA0zlKheLaqPQyo+xE3y27phEg2pjdys302MoPQjyIjpwA2R6JQOoHdDcjAFZbq4bb6d7/5gmmaceykn6X8l08skw1yM/wVNV9NAVvj0Oap5SKgAAYbB8QsZh1nhxrHhdAnL5UyKoOjXHFoV6PSY/Da1JVQc5jdeDveT9ooh/XnD6pBzI5l+nEJf0IZvwFj4oUnYs1zGdoWgCeyff9yMnf1Z35wiE4rhY+BCUPB0NCNdxHLUt1IIkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gax1ApVKc2x+9Tu9gWVtW+F8A58jkoD1mm9Wos1CAGo=;
 b=Jh45xzDjILr7nNL/qjHhJA72oQ/DGTYZO5ascGFxJSvM/vdxxVmiLs0PXFxJu3+gieWkeJF25MY46+0N30OH3C1xPbnqQrC5D4VkG1m7jVqHM3tnFasjv4CPN9NC+LUWVnu5w0ow2d5AJku4Yc/nFHJ7tihZDGC0inmMvbrTQJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9473.eurprd04.prod.outlook.com (2603:10a6:10:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 12 Nov
 2021 06:27:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 06:27:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] arm64: dts: imx8qxp: add cache info
Date:   Fri, 12 Nov 2021 14:26:04 +0800
Message-Id: <20211112062604.3485365-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112062604.3485365-1-peng.fan@oss.nxp.com>
References: <20211112062604.3485365-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 12 Nov 2021 06:27:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 234989f9-e868-49fb-245e-08d9a5a578a4
X-MS-TrafficTypeDiagnostic: DB9PR04MB9473:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB9473CE75B8993C13F5C05DDDC9959@DB9PR04MB9473.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXnuZHxw3glSyQm0EC2qsI0mRH8A2MdtRXwtBAZxPejYxM1xNXz/qFvOK4Xgz5mCFW031c8UJV1kwgrw+b9FkINCe65sg+dCZBLXBGBzoNCP2bJtU2pwrHBx7pQJ+iwVLEPLgbtynwocddmfuOsWYHsOGjdYum5moE3MpGZkTFMgTiHVg5H/oSsxXrTGU6UqKYSmd95VwGWPHlD+ZifuhhBmQMfDYck8/+CWWJugQOkBv9i1CX5+mMdPvONK2vN+/mKbHNsbioCgW82phOQRZQDwRn5+ClXiMDKe+rG2cs6Eq+29jE2LNd6lz3vodNppEBFXArWi2VwZ7J61VO1cHqvdSVjvnra3LvzlTFLod7F/cmujUKNjqtYmbktOqDni99kXDijVGapgTUzGws0uX+GCvKIbVKAW3U4lAXpPYZ8UWtu4RhHLyWcxkKobNsfl4Hq8EitdeFMIHA041zphYopDiGZvkq/j8EvbbyhFVJDGWfBLglwAP16vnoPWUEhhgBOMpitUZzFU9Npk0C3tCEAakkfqIf/EClXqeMn5T9LMFEn+DzyLlrAGZ3GUmx2k316uB8hM+T1Cvr/KN+iLiPhoApIKeHr3y//YCZxd6WjHZfziMYFFKombfDvE3wXlkGo3NJCg2csRI+kgu2w+G3XMQL7g5IqJuD4x8/UxwQqccxq0PX+2BSGTYLL/X/PkAAcajV0RQ1IJxbLtx1MRWY1gyNM7V3I6y8cOu+kuyaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(956004)(508600001)(316002)(86362001)(6506007)(66946007)(38100700002)(5660300002)(4326008)(6486002)(1076003)(38350700002)(186003)(6512007)(7416002)(2906002)(83380400001)(66556008)(52116002)(66476007)(26005)(2616005)(8676002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QSlGkGYtGz1oGJlou2vfIu3C/Ws5jona1ebFao8DzF8ZmK4nE58aoO2npUNK?=
 =?us-ascii?Q?EcicgfLuSoXx86m4xQ37WhWphCaGb0z+8ZvW7QwdoS526qeRuPK2FtopnTQ4?=
 =?us-ascii?Q?5Fb7PrznLgZj1QizvCQ+7CnnkDpi2tlmSDR6Hz+eH1EUbuzm6qDzQeoKqRfD?=
 =?us-ascii?Q?6TbjwbRZxEIu7vKDaOg185LfMu8h37fqVgd7fQJ758pZkui+S5kONQxO1/9f?=
 =?us-ascii?Q?+OiWxFfshXGkbV9Nr909J4H/iYAmqd60Jsd0+yWee3fCwIVgU3tEo6MCrD81?=
 =?us-ascii?Q?ZYg/mPZmsioR2Q8ODD2eHoUSb2cqlXUUDWKCKNp4Gn16FQN3tCyL47aFJrza?=
 =?us-ascii?Q?9Z37bG8OirJJiX3BO39Hk8afLk/4cVyaPeygjM5sWj2TdJ+igzNcVCQr4uEh?=
 =?us-ascii?Q?71j3NPQJSQ36AcPwPtZZAJkJ9OPjspuXgBLLT0NCaF3x1635jAYC4LH2/5sv?=
 =?us-ascii?Q?1XY58On88oHiLquBkYqsC1d9bYSGtsgO5zyF3Ttq9GvC4YsAGpJiDXEUs2e8?=
 =?us-ascii?Q?EJ0o9BNB0tvfkeXCd9n5DPteiXSskJrVYo4C6rcVs7NodxulbntUgtsatBQ6?=
 =?us-ascii?Q?Vx7nMH4xfCIFi0r0xeClJr87RCP1z9Svy7fOo97ToCA7Cx4ytza5Ay8/Goxg?=
 =?us-ascii?Q?Y8XBzjJLHhe9QjuTlawV542flNDYEUc1JYhQv40X3TLWSpRaEMrvEB80kRkL?=
 =?us-ascii?Q?9Ky8PRYJrY9FkTma45UuK8IX3HYg2y7UBEF1SankRoDuooP9vI4dzNkagqFo?=
 =?us-ascii?Q?bJuHbZBev6FXZVfXmf+318U1LABv+DbGVkGX3L0LjzproM50K496+SX/4JXc?=
 =?us-ascii?Q?60o40Cjc1oNLKpbw3+hu2o5ilG/i6akVMAUHzQMwATA9pfE7XyJmTMBbnsxs?=
 =?us-ascii?Q?2ULpmMgxLF03m8fDLwBVgKPqeAnCWaSo43yLTEdJgJwASyZQLNp4eeo+nfqP?=
 =?us-ascii?Q?DGQzy1pMH5yd+PAA/3Dm4ujKpouv8zZmR9pzfgFdLM8KXFpFM1VE7sXqU+5m?=
 =?us-ascii?Q?2k1FSeCSHj+dm0WVStn8wezMlosfXKl4dvjk7HrCDE7ivyYZC4CC9Y65vlOl?=
 =?us-ascii?Q?l16R2f7ND3zvC91DfLBRXvGxGSBupYYML8/0av8CLSdw+See6wN+tnIuNT0/?=
 =?us-ascii?Q?muBrVmJg9xnkNzYMQVPYd/rDcbmzsQF5zbg0NhjBb2htVkr2fzp25Hudj/vg?=
 =?us-ascii?Q?WUU1gYVK3A/hlHgC1tLg/CFpfPsRJfCu5Dt+F/a/+gLIEJ3UeZXt9Vlv3p6U?=
 =?us-ascii?Q?SjxXDTJq9tQTxZ+c2hKfEhn7UcbIX8Xg1TMKbqE1bRcRoj/ZKLZe5TyH+wS8?=
 =?us-ascii?Q?m4oQV8DqhZsxCLGKmNOS+1wbHlXxuy6g8MSnL03wQHB7skXTQ3WB4Vnqt2sL?=
 =?us-ascii?Q?gZfj3OzyF/q3iqG/jjoX6FG2kbf8CgOLsea8BIPgbXSFSYS0tpzWjcZualMo?=
 =?us-ascii?Q?gcfXajjJdrQFEzVRpg1TS1WG11pxMagx4x/mOdiLT+fo0WO8U88RYbGBdalC?=
 =?us-ascii?Q?q8ZNJ4mAtHFsyMRsdehHV59TgDltNo4Rkw8mPYD4WfIWEmlM8iZLkRj9gWOk?=
 =?us-ascii?Q?+NKY6L9rLKKFzIh9JhdYwMD3EWnBHh8DVsZdGGgOoxCHLLylBDbFji2BWjOx?=
 =?us-ascii?Q?xyohWHssOQdGChLBsEiUCOk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234989f9-e868-49fb-245e-08d9a5a578a4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 06:27:16.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYe/XutUlDjU0GTXTcXzSGi5K93zU2XAZOtHgTDqh9o/B5CZ5oDf2QoLcNYmKt1bmqchVxlSg28MJI1Ex+J0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9473
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8QXP A35 Cluster has 32KB Icache, 32KB Dcache and 512KB L2 Cache
 - Icache is 2-way set associative
 - Dcache is 4-way set associative
 - L2cache is 8-way set associative
 - Line size are 64bytes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 617618edf77e..dbec7c106e0b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -58,6 +58,12 @@ A35_0: cpu@0 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A35_L2>;
 			clocks = <&clk IMX_SC_R_A35 IMX_SC_PM_CLK_CPU>;
 			operating-points-v2 = <&a35_opp_table>;
@@ -69,6 +75,12 @@ A35_1: cpu@1 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A35_L2>;
 			clocks = <&clk IMX_SC_R_A35 IMX_SC_PM_CLK_CPU>;
 			operating-points-v2 = <&a35_opp_table>;
@@ -80,6 +92,12 @@ A35_2: cpu@2 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A35_L2>;
 			clocks = <&clk IMX_SC_R_A35 IMX_SC_PM_CLK_CPU>;
 			operating-points-v2 = <&a35_opp_table>;
@@ -91,6 +109,12 @@ A35_3: cpu@3 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A35_L2>;
 			clocks = <&clk IMX_SC_R_A35 IMX_SC_PM_CLK_CPU>;
 			operating-points-v2 = <&a35_opp_table>;
@@ -99,6 +123,10 @@ A35_3: cpu@3 {
 
 		A35_L2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
 		};
 	};
 
-- 
2.25.1

