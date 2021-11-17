Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69883453EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 04:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhKQDbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 22:31:45 -0500
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:62084
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232859AbhKQDbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 22:31:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbF+34ZNkYOD2BRxg0lzzp1STlhDE8B6tHNscMeNAPFcS4IBwEmp7Qsmcsiq6WlYof6QvCfkQlh+eHcDDvbNzJHO9SgObCLFtgS6Jm/Dpbi97USgvn0KsCLx5MY0hSCj3DGOhocOPmSzrR8xaUcfoqwPecrjamAKp2RDJWBD4SkQsK5qZ9PTHEIi48n2/iK82fsNiCRD0M0wEuwLcviTMnn4su/UVDYa89NAsM+WrmYybVctQy25Rge23JgvH4OjoAwS8IbyeLO338a2z9BiJfmRvCZWKQXYAoX4lFV98yic3fcA1NnXyV3DkXM9S34AHsRJGdMkloWpzMVu5xeH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8RbdbTrWonDviV2KLw7Alr4Xjf0MrBJc5lzctaoMbo=;
 b=VdR+Fg6JABBXH8kt/YAA27Giz6WCQN5sS422sFRNQFHOiMzWJiL0jkEc09yQ/6BWJN+ltwVT87SmwXtK1CvQ9///brIcEheGaEtSKvOWgPxy37jF+1RL18CeH5TBSERkVnCEXriJP+Q48UP5WBosnnUYeWXO+4/ElOv4VPUcB5EgA7GvNPftTt4P6skPJpj2ekfG/CV8kfyPyhBp9JRCw/ozsopcxFvULW1wDxY/j84PoWNfqlZWnognQp8wtr87ceqATxdoaZYE5FxF0EvMQZ/CAak7bdQC5IfKPGUPmGPDfiMtp41x3EoJ41bppdPLOPzeeVoy21Yv/zZkOxfPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8RbdbTrWonDviV2KLw7Alr4Xjf0MrBJc5lzctaoMbo=;
 b=ViwQCLtBNPCI6ZykaJK7qoaR0Jj2PKiZSh70Sapb1tGiTKN+wY634U/mv1SzXweZExSCQrtJAobJO7T5Wz2JbCPBiuWVGx1GMNou8pUuw1kVpuvzUklBcfA2cI5H9/cDFSWGOOAaXF4dBaiTU7PHcirkKajDwimHsyWB5egeXvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8518.eurprd04.prod.outlook.com (2603:10a6:10:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 03:28:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Wed, 17 Nov 2021
 03:28:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] arm64: dts: imx8ulp: add power domain entry for usdhc
Date:   Wed, 17 Nov 2021 11:27:40 +0800
Message-Id: <20211117032740.2518926-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
References: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 03:28:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 880cb0c7-ba8f-4b6a-e6a6-08d9a97a5c3a
X-MS-TrafficTypeDiagnostic: DU2PR04MB8518:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8518A5303F6B53B033536F8BC99A9@DU2PR04MB8518.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epVqdQyqybRYoTbwgTMw92f/MXDUXDMGUnOfNvYKOTIhOMSkn+QpQQGTCFiaqcd0dgqhVXeJfg8jz75nKcq3a4ProoOe6ojJTWP7yAm152RCOlVw5YIzdDBBG9h5MUJiO1duoOnibZ3EdH2yoxTjyxRB7vEWHwZ25i5O84x3VSr2DCWjzR/6V+IZEM+xucFPR9p9/+eBKT7Us1/oan3YU173eUT8B3+/9GyB0Ofbs33HwA2uKXFSYJVXJOtusYmlx7f0fAPEXnk5CitPixpyE/CSU23QvNIx6TGhmnDV+aOrkuwel0kOMqcJ+rt0ClK070PjYn1qApYnfbg5fdUGVexDaD1lHkI22UGT0Y20jk525GntDw7N6LRQ6SE/ob98pUOwJc0jhRByFV278eyAsBgSNZxXfdi/bS9yoyo/9sxilGF5ZOvgPbWPRtpGLB8HlZwkCQcsqp5JcHlhESuE0o9y54+meTtirvoTeByWSoUqoHyGGz/456ZK+TWXU9qjGrQHEVNd2FnT085WzwEokeyMD5QsD5apppOMRNvWWStr/cwgrPnC0S+j1fZvOrsv4NkInVsyy17fAKQINa5Onxg/PwRm4CAzNYfk89RD4u7fSl1OP6/CossQDqgwn9ckF2X/LlH05khv8puYtFwnWqiEuwi1MUqbVAACxHf4qgWwIsxoYuk/nAPXLaecxGB+cizG+5TldokdOgWJJxyOhQmRoYSokaRPEWkG5dAkxOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66556008)(66946007)(6486002)(26005)(66476007)(38350700002)(508600001)(956004)(2906002)(316002)(38100700002)(6512007)(83380400001)(8676002)(1076003)(186003)(4326008)(52116002)(8936002)(86362001)(5660300002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0hQoxeLJmJLUbPOGp19MC48y0SW3p0g+08iHJy4F2khNbeEqt6M9192iGG+G?=
 =?us-ascii?Q?4RqiiMfBVc10pXW9OTJPz8ztNxZK5i75jN1l14XnA3z9HfWEREKnsOgt+l4M?=
 =?us-ascii?Q?+/YSB/5sirsO/7R+z10wbd8p6KiJ/tXNhDBVwfqibkGlIddw3G/E6MnwGgNK?=
 =?us-ascii?Q?KwxZ9602kNZNbC53zaeaQi1U/5ESc68neq8Qp+BHn/I+L5hiTyuD+TkH5HfJ?=
 =?us-ascii?Q?E1MnrHOD4ddyig45LExqxefJ7xSPz4tdGh60VUgTW6239f7SEVhTS+pbJuY8?=
 =?us-ascii?Q?qx1mOtXydI2q93g1RAxPLVzfNEVWExMQJm59ERr29Sex/xOPktRYvNNOm82+?=
 =?us-ascii?Q?2O1p4SbhwW8boYGBORMSDF/Owjib26Zf+1092qurS7RBldykzxr21SFcOSH4?=
 =?us-ascii?Q?XMe4wIOyU0yCtemq4Eo4HOcgOFr+zezwZGIQy9pYyIGPI75FLbh3jaNPsP5C?=
 =?us-ascii?Q?+GBZ6d+0fLDWTTiBsBpJBbT4AAmqdxJ8bLaXLZlO3mjqwDMO/MlE/XQxAVrj?=
 =?us-ascii?Q?hHT/qk7wGWWE2xx3d6qIkXFVy+14ho1CGeFunKbSVrOOcnOcPlvDi/YLz0z3?=
 =?us-ascii?Q?ZEosNB41m2m7hvxbqUE9T95st0pxhd6EVNPjsbk75Dc9N1/q+LwZ4p7R3fMM?=
 =?us-ascii?Q?hYbEw5PEIm/zBpKMlEI09nOK1R+Ru+OwODlfnzoc03mTfixUa7m4RpLgcIda?=
 =?us-ascii?Q?gKZzbV/22pNDAKg1tXY2sX9zB4LVq/wBnQf2TXd638EtgXKHvcdv7/s9lD0v?=
 =?us-ascii?Q?PWnHXlmqBKeliHfDptUeWqmXum5jszY4qsNFYFgnAuKvwhngI2mWNo+Uc5rx?=
 =?us-ascii?Q?uLji7KSUqZl59JgtrimmSUKBHzzHePbQUlSJAuoWrvBe399kTfyigq745Q60?=
 =?us-ascii?Q?kKWlHVCpZJaXCZ1zXOmTVntU/bSEr4VsYtr8KG2thbyKhtXhIArjoFJ9gSPT?=
 =?us-ascii?Q?IdmomwFtxgjG1HhlXx9cGxnJb5kY4ERNSw9sUuj5vRv5eH9ZSsdg0/ku6bBh?=
 =?us-ascii?Q?UKcXfc5EJrXaja/FgWNd5AdZQAnu9NHNFol7heaWTljxdbWUqEbylgKQKxsv?=
 =?us-ascii?Q?rceScydxFk4R1AF6rgDogy7BhxcAA+QhOAveGI9vGnXM1B4SXK1x7z9XD873?=
 =?us-ascii?Q?ECMtAd892J21N1OOY0qWZzs6JZwbRjDL/TSL/UeWcc/bo6qV6UPvEcCjJf0v?=
 =?us-ascii?Q?nJ6Ls/INfYdvSJc9YgURBkVq+NNBCL/w8hio+jJsgLwSVux4RdgurZVRjbmV?=
 =?us-ascii?Q?ueoczwLApM4zvSNpNGxIlhYPOq8dpVfGDgnoRK4ShsoE+ucYSD/2/EpvRGS6?=
 =?us-ascii?Q?H37OiFifOOvYoyn8THHbzlCEMbqwtjrrgxNbuqRrptzFPlOv2l9pRasitqjG?=
 =?us-ascii?Q?IuyaOx17m/PZrNkWBkADi4CT2Tj3hfGbwGsepJjeUTCOo2rWQiQHjgKgyY3M?=
 =?us-ascii?Q?JDnL2mi/84gtbxgrvb2RTSmIB/jqZsP85mqWVr2kjmbuePOQV+IUreNnwXx/?=
 =?us-ascii?Q?GwGP9dXAk8f/PVRPCb366COMVq4tfGtuqNYJ0cxfmVfTs8+4oN3mDo9lKHZR?=
 =?us-ascii?Q?COstlF5eki3KYHhJI1fo5qcNbI4uNe3m6dq0Ip9ZzO2izBgZ3VhM7n3euxka?=
 =?us-ascii?Q?VhP2LWVC4gxS7Vjoiz+5w6Q=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880cb0c7-ba8f-4b6a-e6a6-08d9a97a5c3a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 03:28:45.0981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTShMchsXKnPqVNVp/HXpTzVuUQjNCzkutijgLZ4HplxTx/iLqQfdkk2Fu1Q/fJqOwQg3MNVNvscJjWTsmF91A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8518
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add power domain for USDHC node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index d567ef93f8d8..edac63cf3668 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -329,6 +329,7 @@ usdhc0: mmc@298d0000 {
 					 <&cgc1 IMX8ULP_CLK_XBAR_AD_DIVPLAT>,
 					 <&pcc4 IMX8ULP_CLK_USDHC0>;
 				clock-names = "ipg", "ahb", "per";
+				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC0>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
 				bus-width = <4>;
@@ -343,6 +344,7 @@ usdhc1: mmc@298e0000 {
 					 <&cgc1 IMX8ULP_CLK_NIC_PER_DIVPLAT>,
 					 <&pcc4 IMX8ULP_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
+				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC1>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
 				bus-width = <4>;
@@ -357,6 +359,7 @@ usdhc2: mmc@298f0000 {
 					 <&cgc1 IMX8ULP_CLK_NIC_PER_DIVPLAT>,
 					 <&pcc4 IMX8ULP_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
+				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
 				bus-width = <4>;
-- 
2.25.1

