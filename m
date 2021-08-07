Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13563E34A3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhHGKLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:11:07 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:43842
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231738AbhHGKLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClsmaxStC8UW4gMNXD//Jf60qB6XG2Ss+XtEoKRgJimnZh4gXufAT1Su4PG1sJQ3fmaPSNgmJ7kjQZQIBoP7UxrYChgHMH22E/4BI4fX6g3dgZ/wBgvBDxJXVqUcri80NwrKUuWYsC3JvPcQQNzqMzdakogkYpM5OgVZTTUSdIInGM9nh4RAOuZmcljUTYGOSnp+/tXNcCr7y7ET9JtjVCAo40POX/I5GD/PDsnVCRl+KGQteYjm8a2RbQTaWTZhBi8F6ADpHs+4vmKNdYim9Oz6dDtBZdBjOP3zmuqme+Drp5trHKhPUG84RPjoDaLusB0wuYCWwyT25NuOg81qFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOJtcwSAfhSUfpaKIw1B3ekhCD+HQS7mdnm1lzerNZ8=;
 b=c62ETsQBpsVN+25wFLuvZM4SlbL+RWBbtAoOs9kwXwX+IxpQCt0WgALcpnYYO/TgPBuiQUP2J+u+FkNxFIfbq8buoe1FKmmrz/4UXYCdfuMexCVqAI3nOevWwv595x3b/v+PUCbbHqrsdnVtG4ZhTn6XbSBSnZayqRJqJS97YlSBD2y+oKbqTVMaFFnGAmRWP9LHJJzbWg5A+I6jGReHB/ou7E12YLyKxAjF2S2Zqhwnr3CfdWOkcZ7zUaca5mLPRxOARBJy+0rYrjaZmT0RFPlqbJ9Bb6/BTbHq/BiI7PYt6SM3KGubMTr7IQ9izwiOE6livtfcMIt0lvgI+rusJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOJtcwSAfhSUfpaKIw1B3ekhCD+HQS7mdnm1lzerNZ8=;
 b=bOZMv087Kf9r7sVng/yqq6Kb6OsPVwy5bUVNIAGZIPXo7xW92SjY8B5pcq8PLSfD7g1lxA1dCKWJGTLwqRMA4ZeecVCYZMZxqGnTak438NVIPfWPlZAhYwQjY2we9wnwtRhJoIqfIMGjIksuUUW1PsFZEUVQeWjieyFbz3vd348=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5082.eurprd04.prod.outlook.com (2603:10a6:10:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Sat, 7 Aug
 2021 10:10:46 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4394.019; Sat, 7 Aug 2021
 10:10:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8qm: add smmu node
Date:   Sat,  7 Aug 2021 18:45:17 +0800
Message-Id: <20210807104517.24066-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0103.apcprd06.prod.outlook.com
 (2603:1096:3:14::29) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0103.apcprd06.prod.outlook.com (2603:1096:3:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Sat, 7 Aug 2021 10:10:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a58e9d81-726a-4bba-8109-08d9598b9f67
X-MS-TrafficTypeDiagnostic: DB7PR04MB5082:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5082CFCF02446A4A1680C2A9C9F49@DB7PR04MB5082.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2ityxE52pVkccq3Lv0AIw7z7t7SKfhRa1s+AiIwHei8c/Jv/Ks8atjwRZVUh2JagzxQgwxTVQVh+cRXt7Ic0YJ3xKZ7CbDOO40GYv+VvjJCM3zbFyjUnr+oiruoWAut/qcNxdFw0uEJmQ/3TEkobzl5VLlp0XmhCgJKlk4aAVcsrHrm0b0ZOicVJg10Q/h8+mYum8bGhamECO680LdFwqLBIancNlFMmHMG+qop4cI7SYxhS2ujDFnOhPmFirxBcaeJzHBKV2McTT5fmHNhoe2tipjkcGjwKndkyyIgtkB2HVX3UFoyp4opNJtYLf8x7QZzKP2puH8Cf01Oi7IsfOCM8rIoOF6j0UXDWXlo19QF56MLMMSNj//3Qc/NKc+3FC2NOeY4P9p/3iBpFWPExKH/DKdRp/3VIzH8Yu4P1RI824TL4yh5nDxePT0S6R36DqJambPpReKqx+CPS/xhzCB0cv4jMJkZF4FBNoiVAzgJqKW3SShc+cEjudOF2VgXo2GUurddMBXoHm8cUImEAxjfbiZ15eLm39jCLR6frLfSHIygP1HEmg9tVjWUc9A3OXepMKUP9fg6BJpijMsXAYBpRbKZJr/bo5cbFHN9UoBmc20h9YlXwZOqDeD7Taw57tYev6EY3YnmUoBQw4YNiUQ0b15J1tkZAU6R41OFoZuka4ZCyn6A7PxtBi6FuvsPLEAk6KIS5AtfjkOhPNRyparnVbVPzGtVBCywDIFcNxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39850400004)(396003)(52116002)(38350700002)(66946007)(66556008)(7416002)(8936002)(6486002)(86362001)(2906002)(38100700002)(8676002)(66476007)(6506007)(26005)(4326008)(6666004)(5660300002)(186003)(316002)(1076003)(478600001)(2616005)(956004)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NMTVHW92MEM73X2bNq4q0/1X6LqNWcR8c3rabC2kuW7qJsc3e9WX1YGm4c25?=
 =?us-ascii?Q?ZU8rsHAMaUSZxNdIO8kkfPGHzjkCbOCyVm+Z6sbafv7a6DmIQv1bcHtSWvp6?=
 =?us-ascii?Q?KQNPuNa8J6PXduLLnXiGuiE2UBxH6sqqKLlMcFYW/VqNcoS/QwcBopRYDheH?=
 =?us-ascii?Q?HsDntbhqRngNnqNjRqIx0UDnqGirlbvZ4wDoXxGhvEn7YvBpGD/2CSOwkN7I?=
 =?us-ascii?Q?2Mxm5odhy0oBwEXdb/16Pww5IyV2qz7Ul1zATlzMWSUv/NxykUUzwt7Oq2M8?=
 =?us-ascii?Q?lTeSZ/ixFE3zkJOtncOdnbfm0foyfsTQ9JYpAPo3i5k+SIK2cHl0zLB8uBPV?=
 =?us-ascii?Q?VgGU2yRT5tqEryhG1AYyrLvhWiY5AUbNcSafxBEo/xGF2l0uDuNx7/BrNvh5?=
 =?us-ascii?Q?JZSEiRy9Dkz/e81DWNHMXej3twQR4G8Zof2rtbDkNI5CrlS+WiG349KmPsS4?=
 =?us-ascii?Q?uXLDVB8qDzU31+08mDJ/Gp9whvMYrABo/WJHOIVX291MOHk1H4kdrZNEA4KX?=
 =?us-ascii?Q?Yn+WZfpY+KLqkjsMMm1YwSC26xYw8pHc2qCMW0QE8PNWISi2GeyicFnPlFG/?=
 =?us-ascii?Q?SY92tFztWU+IPiShjkobOuTEDjI9yUOFFaqB+Y9woiO/rj9Qnij2uBL6Bcc9?=
 =?us-ascii?Q?afnCeNHgCJgFB4mXcH7yRZw/Lsgp2S0lWXZYDhxbEuJAkY+kz/w8SkAl4lXO?=
 =?us-ascii?Q?bGHAD3jyo2itj81biV6y8HIzTK565dwMqUao8mTA9IMdId7veFKqxrU95Irx?=
 =?us-ascii?Q?5FKufyUohVQO8oalQ8AWqrACIbvoKbEa4uXNzVXoL7WBRUXi/vAZIZdEwubT?=
 =?us-ascii?Q?5IEBPW+dMLP3nK+14j1A0dsv9syAvhdfw0Jybb1IM1V90XE6pxGiolkOs7H3?=
 =?us-ascii?Q?nR8l/nUnNMfDN2CKip9OS8OADn02+Qq3roBAN2h5N9oq8zDWzzk/MP3ddZd8?=
 =?us-ascii?Q?q7f/kwP1+GpXZLHLNaPSydEik1KZuNdDTInCudzjrjVeYrZLaHP/bOTYdVQe?=
 =?us-ascii?Q?iGrkLP11Or/sVCm+EA9IQ55Droh1eCPopgPNWqKumEC6xM67SF66JJcyZk+L?=
 =?us-ascii?Q?BJFcuDIHIHhpbdIz1v/jJlUvVufR4b39KaFY/XmS+dLI37nTsX5ZS++Ti6FS?=
 =?us-ascii?Q?O742Big4Zopk/NRYC1H5OD5Z2/HOY+aTjj/0Y8Xbc+tCcYRPFxonP1GW/LpJ?=
 =?us-ascii?Q?JJPtXujlu8O+arRcRIB968YRe+9rMx16QgQXoLauF0Re3IvC86nbpznH3Pnn?=
 =?us-ascii?Q?J927OAW/jooFMpC/qKbGYdCl1PJKZObT0drPagGKIU38r30cYqGMCeWfhRS9?=
 =?us-ascii?Q?dPKuzUncRkxCAqtXYBxnP2VqTuZQ9LrPyJzgb94grPXPIA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58e9d81-726a-4bba-8109-08d9598b9f67
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2021 10:10:46.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjygKEX8DTARk1rp/P888LZQayxVFc5wSAZGUFl2w1pr48MGy6xIxd4TkQdKbmkPG49+pNcgcWq1xd2YA/3SKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8QM has an iommu unit: SMMU-V2(mmu-500), add it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index aebbe2b84aa1..b8ffd5be6a3e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -165,6 +165,22 @@ iomuxc: pinctrl {
 
 	};
 
+	smmu: iommu@51400000 {
+		compatible = "arm,mmu-500";
+		reg = <0 0x51400000 0 0x40000>;
+		#iommu-cells = <2>;
+		#global-interrupts = <1>;
+		interrupts = <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>;
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
-- 
2.30.0

