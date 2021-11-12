Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD2944E1E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhKLGaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:30:06 -0500
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:48355
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231802AbhKLGaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:30:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6+VoqgpnnXv7FApJoHR5aA259TgiCZIr7g+GO9dAkTfeLoJJLsKCSFQNz4zUfXp/klB+rNayKsscbUobKab0kCsiNT6cOIaQ/YamCtPulfTlV0KL9/BUMq74lupJIhi65FyPPr4g6UvPKeC1nk5ldBx6ktZLDJBNRDZy9yn55+NiwfRLY4rx8MEjsNLbj5yFLC9fnFdW7X1jH7jpc3U9ZyAURioQAnDhh4/DUiiMNygWIbivD7o8Wn/0orriZTnY6yWmRnHb0WrOfbLekm/aw4o22iQxFtyPBJQURO1cap8C3U9g86PdeBM26ZTU7DWabCxC+4zCJ3NVKfmc33CZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13Ijpu8/2bVCDgYwQr++5EAYI8P+9ecjz2+p//mkHB8=;
 b=F8j6twQsG9Qyye67I4Oka3MtZwNIuJajWw7lQ/FjU/QbQQjzHAV9+QERq1Isov59ECvsc6Dpzn8sjsp+zzveQYnhdZ9g5L9gDLj2gad04iw1CiL774zx/YrC56DtaHrZOy9EW4XBSQqdZw3S1Xn2s5cvCsKbds35SbnIwDzmHFInfaidH8b5bQvApuR6PeLe93m/gpM9W8LgSKlPRjJN9mSzdeVBB0StiPgnwh3y3sSzfXcPctf31yiotl2IdH7c2DIRK1vVERsFP0yhhjY4a/y68HibuGuazB5NtDn5seQf5SqzPl/HNxjs7VQ+IQT2seaArh5QfTOavfB9lAXt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13Ijpu8/2bVCDgYwQr++5EAYI8P+9ecjz2+p//mkHB8=;
 b=L1X5yvompAfG7CbepNGt9G78nYFxbxTatsNzPooQQ9H91pGPVzjiv8eTi5zif4K8uJcz+WahHHCUpvpL6GWP2YxkNFAj3qS0TdYmkUJtM7hvlaqPf41ok6ULjsPTM0YXC9AXNCzuQfilGnLTMYwOH7XettsA3denaaJ5Tn2vkPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9473.eurprd04.prod.outlook.com (2603:10a6:10:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 12 Nov
 2021 06:27:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 06:27:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] arm64: dts: imx8qm: add cache info
Date:   Fri, 12 Nov 2021 14:26:03 +0800
Message-Id: <20211112062604.3485365-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112062604.3485365-1-peng.fan@oss.nxp.com>
References: <20211112062604.3485365-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 12 Nov 2021 06:27:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce22dd55-4b6f-4e98-c3c0-08d9a5a57644
X-MS-TrafficTypeDiagnostic: DB9PR04MB9473:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB9473D366187A624B8C727696C9959@DB9PR04MB9473.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKho5NL4OsISjOfTOXH4BMp21CqGgiLS+tgcM7+6gvz2qeNsqVDnZ2APYeT8L+pfeF5si5GfORCRAuJyrNmQ05z1nAdHmiahwGI+pTkUP0KN5b8psDo/p+N7Ky9YQX3457iXlM8pi4RrwGH14PKb4Z+rQ/4dy2aXxZRs6M02EvYQ/hG/csZrKNrDgup412jtAtOxHCzWWDCjwSLxyyMkqb7iybhTfJPuLDvQY7ojApoeKi9ZqAXKkw9RSECh7ir67UCf5hO5BzTevMXTmF967+JqFuhsca8AE1VXMjndKlB0mbmfADp3YKFLAE0XSa83dQ8CNeHpzRYgbnsgu4YH1ZemQAERCGj1l7TJZExw/FRQkXjQWUTh4FUlGN0YsEKJ05+35CzgnyPhFU3SctIpLSmCurJWREeOaU0hx5znSX9cDxv6EUDDwTP2OR1nbVRqNUJEZwmlk5GiX3feBrhaeqDRhV7/sKUF9+7kAC6s2c2lE2VfjW/KoACHw0HudQLb4N5fINQ/gxGuDFccUQZrw8w7jbKS/74Xlr5XxSoQtR1HVl9EejQxRoPNiROSdPi7bSj6hLYVr7Eqgll/NQeYtPfglVe5yaJqEzV2Hs0NugeFkYBvQ1ut/pK2XDQ978aPvrAL7BZNhlcRJ6e41OFXTPcL28IBRKLRn/bPMDYECan52HPNBf5GdmNE0GmoMNUjFh9rWBrenJWEd7LLW6xyPvvZsDJwItgsTsmIPlhie9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(956004)(508600001)(316002)(86362001)(6506007)(66946007)(38100700002)(5660300002)(4326008)(6486002)(1076003)(38350700002)(186003)(6512007)(7416002)(2906002)(66556008)(52116002)(66476007)(26005)(2616005)(8676002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oF7RFc1+syWX0FfIvSEDy+0NJlNKJWGBCAetr9ND1FyUFwWqJMO+Wr9P717V?=
 =?us-ascii?Q?zFFX37OMqhcq7X3mPqvS8rGadG/pNUN6BnW+pf2XgZV2/GGPA5zK17BsIsoM?=
 =?us-ascii?Q?H6PK4Ex0iBDPCIOtatYlA3ZXo4ppLAPBv9R9lstGCMLcw681UeXrmQmiqsj0?=
 =?us-ascii?Q?vugfvsiUotSIhVomkO5K8ogZoDegOr4wjFuC617sLKUnjNwXvk5y4tbLOGjW?=
 =?us-ascii?Q?EqAsycvIKtivadu4gTOSBBF4BsRl+oZO//2dTFZSX6IxRt+Qs+qY9h50Ik9B?=
 =?us-ascii?Q?JiiauEJSllnqE7put6ar8wqcgcrNhpGwMzwlfw8Cw/3axEkARlQCIJPQMYEU?=
 =?us-ascii?Q?2DM7YhEw02kWwSyjAf8a16FTMxIGo+meWokkD7vfFhtxbHADZhSFwnSmdTlX?=
 =?us-ascii?Q?6NIJF0ntKCQdqA+Wc3glEUTJkj6P28pSAkIzc5zddpvBRxEyjewymUuMxJnN?=
 =?us-ascii?Q?+1bE+Y3yI49yjjPZUA5+bio937gi2a7UIQRCDpeE9EWW3YVrIAiRk+uepm/N?=
 =?us-ascii?Q?cKKm5u6ttPfPM/oRapIoZuSzw2tYVZNBLG0x0bzKFFOZ2BFMuKrfqpKOQv8f?=
 =?us-ascii?Q?nhbII3x/m5ZEeLsHLsDzYGVs5iWZyOZysQEws+5HDzelZ6Du/8D+VIzmuKmq?=
 =?us-ascii?Q?vBtCV1fB5oAEYwxfBxYLUTIrxyN6dbo4vRbM95CYqQSAuVxHckngOH3ZMB4Y?=
 =?us-ascii?Q?fGVWfLPgb4JSwwOm6fy9ghPfiJumPbsa9cd9crSK8Qa3ZUU5eIyk3cTXN6IB?=
 =?us-ascii?Q?TRY+SRmdgpfwjbafZgtOMPW/0c65Qdi/mxDlOJHA1tTAkeIRPl8UMjtvRcX6?=
 =?us-ascii?Q?j0ZnM4XX7zbKSRaZmITwOSciFq+BDxxm2/JQK8PLq/ngpggq8PMc/SA7RZDx?=
 =?us-ascii?Q?rBnCa7swxZ6bfIf3Fzk7DQf+BpVm0QhVl8pR0DknRs3o8N4/jU2iUKqnEzAG?=
 =?us-ascii?Q?yrDAV5OcQMLH+7moyQAx2czU2WqS+kenfpZxgZdH7Aw/SncbIPS2KbzJkUA9?=
 =?us-ascii?Q?zeiIYdV6sNCn6NiJl3gEzADJFIK6Yq+0Pf9EtfQdbdYP9StgaDAAwC2cyYR3?=
 =?us-ascii?Q?Tz0ZU9gCm2HEYaIbile4XUG41H2rFZ+yYd5i04pwmfKmpqp+2952NjNssl2U?=
 =?us-ascii?Q?RdvgBsfxd0PW4yCGek0rtZghm2Nb/6sDXMwe2+A1DjcXDS7WM3xEXg7VoIr2?=
 =?us-ascii?Q?hPowmvpfNrLRngqR/LvY/P1GdE0DC6lDsOwS3T0WejT1dIlJNp0jjb5D/H8t?=
 =?us-ascii?Q?0p9FYzCy65C3pFomwOaY253eoCsk04rZZ7ZnKpQv+8lzts/MoE50IiUJZ75u?=
 =?us-ascii?Q?CoWPRhQIqqSp6OKkp/d4RQt2xNdNENH/eV2GHRRp3Jrb3jk8D8i5URN7utHk?=
 =?us-ascii?Q?+y3iCVaG78ixm/eHp8L4//aYmbLIYcdOI8R7SN9iaj1bmVZL4l1W+4Ljkexc?=
 =?us-ascii?Q?Ai7md7p7gBmERekpkRil16wTV/0Xn60avDCoTniJOI3OzcY6PhR5K4PJQDfk?=
 =?us-ascii?Q?Jlk7pxf5z+hWh4Id3TXdn88aPbOon421QroLnE4588wmWbOe0xWK73M2A0W5?=
 =?us-ascii?Q?k7XAhPwKCXRaHSbrPtJ35mFxECq22tR43kshU5Y87y5Gz29zukpWaKwdqF38?=
 =?us-ascii?Q?MDBrC9lq1y1ErslPB8HSh7c=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce22dd55-4b6f-4e98-c3c0-08d9a5a57644
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 06:27:12.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jT7xHzR915Fmg8PMzc2wMkWethApAXN3tEaUBl26JCHvXiedju7FLQQ0tT21Wv5VlsTd6R++jgcFceQ+Ac+gYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9473
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8QM A53 Cluster has 32KB Icache, 32KB Dcache and 1MB L2 Cache
  - Icache is 2-way set associative
  - Dcache is 4-way set associative
  - L2cache is 16-way set associative
  - Line size are 64bytes

A72 Cluster has 48KB Icache, 32KB Dcache and 1MB L2 Cache
 - ICache is 3-way set-associative
 - Dcache is 2-way set-associative
 - L2Cache is 16-way set-associative
 - Line size are 64bytes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index aebbe2b84aa1..4a7c017b5f31 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -57,6 +57,12 @@ A53_0: cpu@0 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 		};
 
@@ -65,6 +71,12 @@ A53_1: cpu@1 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 		};
 
@@ -73,6 +85,12 @@ A53_2: cpu@2 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 		};
 
@@ -81,6 +99,12 @@ A53_3: cpu@3 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 		};
 
@@ -89,6 +113,12 @@ A72_0: cpu@100 {
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&A72_L2>;
 		};
 
@@ -102,10 +132,18 @@ A72_1: cpu@101 {
 
 		A53_L2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
 		};
 
 		A72_L2: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
 		};
 	};
 
-- 
2.25.1

