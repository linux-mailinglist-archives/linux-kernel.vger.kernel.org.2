Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE26644E1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhKLGaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:30:02 -0500
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:28355
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231802AbhKLGaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:30:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms0jmAMDD3Yv9Wguwqi0xCwfUE6XhEwqlYthRKyTKh2QqJABbUY3Q/vxYI3sIHB2p8aRv5J6jMBvUe3P/oxSfGhEqWmWLmmY7zH/1QnRrJW6X5kELV8MSd3YyuxXKZ3CrzO1NwX9S5ZKUpNkOZwXWsxhRnCLoTMySVTxFWmPP5+h7v3dG7S5aZb58huU1I6zQ5R7pomxL76JAzCF/Quu5BeHPh7v0gqyamURw6PQ7hYiu1Ju7YwDzwEYG+5KbchMk2yfHxlkBQVu0hjnuXUdTRrHjA5T3JVbCcw0v7bMuiQDl63k/Ht4vrp0m1P1MYKSPtLnZbrW+a4CiROFUGTRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVfQjcNmHcb7VtFhqnfnqmrJNMcTGo11/j5Giz/OVMA=;
 b=VyMFrFwgLXhaOfHM0D23crWG231QyZhEVi71HO+8yyrRGosleEQX57HDCQBMYqkTpoal4iBFTxbkAIHPDjqXtFvki2+2EHKMJeubs1KBDc7SyliGZ/fCD3UNcObDzxThpvrnJLduAPGEFchtbTOFNiCbujcWT+z7UpaUIjvoWCe5RmN1DBCODGDA46OoWPiLumzvG55xczNG8B6nWzxD4x49wgbbgrm3wF5mCHxZL+aIuPwu69oIDrGWj/CX3z4YbECa015tIq450bwwva0AWm+uz6kcR3kV1Klq0X+HV3k0kQuXvQh7lAXuAv0FFQeq5VRv7j5DBFr3ep1Cr858YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVfQjcNmHcb7VtFhqnfnqmrJNMcTGo11/j5Giz/OVMA=;
 b=eZM38FkZm2NLDZmJH5QJQiX2xTrEo5ptTHQfo3cG54RNio/owg9l0eDr3MXff6QoH1fGDSs0KQatFRExlRqFnhGVyRybViqfR/zE2gsUkyliTZubJggmS+5CdCoFPjQeKqSDl7vHNC1BLnscbE6NhDE3bAqkUt2QJb+rKEkcgL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9473.eurprd04.prod.outlook.com (2603:10a6:10:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 12 Nov
 2021 06:27:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 06:27:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] arm64: dts: imx8m: add cache info
Date:   Fri, 12 Nov 2021 14:26:02 +0800
Message-Id: <20211112062604.3485365-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112062604.3485365-1-peng.fan@oss.nxp.com>
References: <20211112062604.3485365-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 12 Nov 2021 06:27:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25060465-7fe5-49a2-5f51-08d9a5a573d4
X-MS-TrafficTypeDiagnostic: DB9PR04MB9473:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB9473F57288CD5D061F111C1DC9959@DB9PR04MB9473.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XudKg7oB6CKAbeN2Mjounr8SjMTzmnOt1JRGRH85JdskhtHwSH4ypvSIgR76gj26uEHJap5flCWXwY75s0Ke4prPS5OYFF0eo4tX+uFLhYW39cUagTiynn9gXf/LboAR4l7GKcUUw3oWexLZ6cgKIAdwZPXtQBNE6ttWPzYRZMDQ8iLXoLvsXVZaXvu6DJueeslLbyTPqm3UDGf1YX7+RbJISdbk4QuL4Mgatl8hhgT4H3Og7LECHGdjMkdUw2TtbRm/R1S+a5RIX1dsDH4tj9I+c8M08m6jyumFaPGlflrn2oLsUFuZvo9a7q+9gcX7AK/NtLUcH/1nGZGbXmdSYbKRcCvvjpUYu0s4xunsE3Ms3BDIrT1RAvwFMC1V1DJ/ZwIS2H9ajr12Zbuk6IYpWZl2MECvBYKK+i39N4/M6nmLjKewxuynXg2fgjEnRT3cHBO6kYe9mGwdu9AvoSbNPxYkpXTx2HghoA/lN6XnAqxyYm17L8XEftC4PQyzCPVFEJJo2QIR8iFbeMtxAGbQItw+HJSCDMd1IB2CbFjPjtx75YzALbRYzIH4CzXdiJxTlXd+NnB+W+eTgLpCyf7JFViGMWL10b4u4ZM54LPzCgKpM+lkS49s8vnIz2AIQMzIoQxnuiy4J4F7ULrNbnKVxSVxqybEyH15O7srG3SDXuPTKyS1IEWWCM0t1EhlUT5TgJW8cCHypRnF7ZZBdUgJVqDo/swuVgpj8xK5S903kt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(956004)(508600001)(316002)(86362001)(6506007)(66946007)(38100700002)(5660300002)(4326008)(6486002)(1076003)(38350700002)(186003)(6512007)(7416002)(2906002)(83380400001)(66556008)(52116002)(66476007)(26005)(2616005)(8676002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6n30h7O3fQEVwKbsjuwmpXfePAj8uulT1zQV2VARA4TTY/ZvTAjEaffUvRzD?=
 =?us-ascii?Q?Rhy9oyOey+24aG23FG3M1u80n8WzYwojRVP6yCClnae36F2iGsFcEsBDsgWe?=
 =?us-ascii?Q?mO2jnVBLYf1t5YnOovxcuE4vojp/qIUlDak1bRf2ufn3e0dfUuCXdMKacg2f?=
 =?us-ascii?Q?YsJtk40cX0T1Ts4l5JbojtM79aWy3YqUy9FI5h35ZNHz1bp+jFsfmrcWAZGN?=
 =?us-ascii?Q?QHxFrhST9ZaRakTNpsviCf9JIM5/ZEIBO1jnkt5n1hyh1S1Ow6pPn1JRwcj4?=
 =?us-ascii?Q?D4P90wzwmkPzZgMaWZwX5FFZpXFse4ck2fvxaR82zBcqZy50r4k70ScGY38n?=
 =?us-ascii?Q?yrX16p0wP2ZFGAdnkj8PPYVl8Kyf1Ccfni6QD2VV7S5ns4azQt3yFPhxtKhf?=
 =?us-ascii?Q?7BpHXrLmLPxdArGwrM6MguUrMoRNzDoZe6MHHDXn5hjH3BiSFGOYR2o+f1pw?=
 =?us-ascii?Q?NwJ8VHTbt/4px2q61HMAVqKb2gyAn1lLOaMRVMYJ1o/vB77P2HqXrDA7nVN7?=
 =?us-ascii?Q?bMJjJOUBYV7k4+EQAGjxgu28uYUNzKtHRChZ10yqSc9aPIGmuuHijLMcrJHA?=
 =?us-ascii?Q?rSLqiMAqgzR30+bsYTSOGGxEhWrwYGWmxPlao7OKzoi3hSGh+6PNW36+wEGG?=
 =?us-ascii?Q?QzU/bCBqBUONN2doY33U9eh6sroAxB0YJMHRDMJk9CSNENSm55mrPNgJ7+0m?=
 =?us-ascii?Q?fkAfRdwIf53ffn1gI6xeW6xrMAZ41IpFGh+/NO5Jlf4diALFIk+BcbbwmYwy?=
 =?us-ascii?Q?5fLVfvpBM/4f+yvFp5D7E3YBZOYOhrqQfn2k/UwRs7yq8ztR7OIlS2x5KKIG?=
 =?us-ascii?Q?ZMrmzuqjbyvtoduSZlpaVGEUh90zn913z1de2QdAAQwThMe4cS4mRlrRUOs2?=
 =?us-ascii?Q?7cbQp9cHqZUC0tni1gGHccE2Gp/pOjFf0LSiW/jJfFwFvWgREc9b45jB2zyj?=
 =?us-ascii?Q?fpaEARRuewQGx3faJEnFkzC+rVyoRYoD7bEWxuA0tiO1i4a0qrFYUlvOMbmk?=
 =?us-ascii?Q?cd/HaeBv2zswnxcAxrW8zqB1okfhsUP9OG97IMjWI987O9u3ncwSaZ3GDX/n?=
 =?us-ascii?Q?RDtUIs3i70ZjuJbV5W0P72QDqwQNwfPe4GJChzeg9xFqKC/1/yimA1rYAzFW?=
 =?us-ascii?Q?bdRDg0gidu+lJ/9vtsMjocqlkb5oTNW2mR+iFo60DRbkiVXhBlgfQaWS72fJ?=
 =?us-ascii?Q?rDMLVUCEnHoutx8cVw1Ahe0Z6Hi5oCJ6XRAbJhFJPOiA8PHzpfsYXMitjldC?=
 =?us-ascii?Q?v+qHjRS0+IIGAQgS/VBjzNy18EzKfkXOCgojVB93fpjgjgZUvwXkEz/T2Rwa?=
 =?us-ascii?Q?++riCsY16OTErXov9T7sSmEzaHWQjXfGa6OKhrUQX3VA3x+aC+aExes61tcP?=
 =?us-ascii?Q?d3kVEROIHillPBQYoWpvhWxXjQTf1bdueWbxZFXcdOQZvt/3M3luFZZWdInD?=
 =?us-ascii?Q?NkVd7/VfrlzB9FsYYNq8qfhWP+zW4yfXRENthCukJ6p5VHTa9JE9SdvmbsUd?=
 =?us-ascii?Q?naQt/O+TgFH/C2Jheozgri5vVx/nXXvOY2xWFFMSABIK+ixogFPBF0w/zj1D?=
 =?us-ascii?Q?z9u1xeB1ny+Ena7F1BLmd8llWHe1QJE7GTgrnSpQfQj+P+B0kyu9RlBOa4l5?=
 =?us-ascii?Q?SRK9O1Mc+5dXZGxHzKqexyQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25060465-7fe5-49a2-5f51-08d9a5a573d4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 06:27:08.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzN/pdUW9oDzbI2wi91zLz06YFu87QN8WsQjPQIgDfhWfIoAsX4R8c9pMzs5qUBIAl/hyBoNcb7ljZf3o4SrQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9473
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8M Family use A53 Cores and has 32KB ICache with 32KB DCache.
 - Icache is 2-way set associative
 - Dcache is 4-way set associative
 - L2cache is 16-way set associative
 - Line size are 64bytes

Except i.MX8MQ has 1MB L2 Cache, others has 512KB L2 Cache.

So add the cache info in device tree and let use could see that
from /sys/devices/system/cpu/cpu[x]/cache/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 28 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 28 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 28 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 28 +++++++++++++++++++++++
 4 files changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c2f3f118f82e..5b9c2cca9ac4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -65,6 +65,12 @@ A53_0: cpu@0 {
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MM_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			nvmem-cells = <&cpu_speed_grade>;
@@ -80,6 +86,12 @@ A53_1: cpu@1 {
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MM_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			cpu-idle-states = <&cpu_pd_wait>;
@@ -93,6 +105,12 @@ A53_2: cpu@2 {
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MM_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			cpu-idle-states = <&cpu_pd_wait>;
@@ -106,6 +124,12 @@ A53_3: cpu@3 {
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MM_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			cpu-idle-states = <&cpu_pd_wait>;
@@ -114,6 +138,10 @@ A53_3: cpu@3 {
 
 		A53_L2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index da6c942fb7f9..ba23b416b5e6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -63,6 +63,12 @@ A53_0: cpu@0 {
 			clock-latency = <61036>;
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			nvmem-cells = <&cpu_speed_grade>;
@@ -78,6 +84,12 @@ A53_1: cpu@1 {
 			clock-latency = <61036>;
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			cpu-idle-states = <&cpu_pd_wait>;
@@ -91,6 +103,12 @@ A53_2: cpu@2 {
 			clock-latency = <61036>;
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			cpu-idle-states = <&cpu_pd_wait>;
@@ -104,6 +122,12 @@ A53_3: cpu@3 {
 			clock-latency = <61036>;
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			cpu-idle-states = <&cpu_pd_wait>;
@@ -112,6 +136,10 @@ A53_3: cpu@3 {
 
 		A53_L2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 04d259de5667..977783784342 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -51,6 +51,12 @@ A53_0: cpu@0 {
 			clock-latency = <61036>;
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			#cooling-cells = <2>;
 		};
@@ -62,6 +68,12 @@ A53_1: cpu@1 {
 			clock-latency = <61036>;
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			#cooling-cells = <2>;
 		};
@@ -73,6 +85,12 @@ A53_2: cpu@2 {
 			clock-latency = <61036>;
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			#cooling-cells = <2>;
 		};
@@ -84,12 +102,22 @@ A53_3: cpu@3 {
 			clock-latency = <61036>;
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			#cooling-cells = <2>;
 		};
 
 		A53_L2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 972766b67a15..95d8b95d6120 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -102,6 +102,12 @@ A53_0: cpu@0 {
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MQ_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
@@ -116,6 +122,12 @@ A53_1: cpu@1 {
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MQ_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
@@ -128,6 +140,12 @@ A53_2: cpu@2 {
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MQ_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
@@ -140,6 +158,12 @@ A53_3: cpu@3 {
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MQ_CLK_ARM>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
@@ -147,6 +171,10 @@ A53_3: cpu@3 {
 
 		A53_L2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
 		};
 	};
 
-- 
2.25.1

