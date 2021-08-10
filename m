Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369713E545D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhHJHf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:35:57 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:49280
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234433AbhHJHfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:35:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTAWuuVcUX1YTlyGIh7HCBeAqRu0Jvq0syHjRQmf7hgEK8f8A+jys2c/O5SG7KUXxnXWeeJ3JeQ5c8WP8x/K6rhCYMK49w8nlpQMKjAPJCI3+LIib0+uYGfaqcWkSdrBx22ee2RXLN6wV9m+sm2hv+Oo4z2p8jVScZ3uk8gUpjvKL8RYxl2GGTJRa7V05Ydecwkv2NSmPtw7Upbj4eAjPHjp1ED7nGBPGyJwQbQ/zcqqVrY0zb/CVzjk+OCOdjhKGYe9v+Q+b98TlokSU8lARvyPgpFZux9fGawbk1nxy7I9b/H+lxvlU/twdFU9tc4DuXQTsrPWneE2pcXU5g9Xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJf3X2tNIJSKjyi6+JbNto2hH0bVQA9K0uzfkKOeZG4=;
 b=B63U8l89qm/NupLvU2AXr80apv6tgZxA8hpkg3Jsb6i/uRORMkXg1ITcGAPUdop6j/KoSe/CFxzj0jlOK1hEoIRgQY0EYv4GlJfabsfWjSp33T0j2xFBSERR5vLu5XVwEVv1L6GVa8TsUM/Y/5Mp6QNVGdiOuumLfRTeEIoz0ofxPs6dTKZfiZXR7pc1UZ8cGwzg5+kQpryoxXD7eZaWb/NZsJVyXF8IkwrGlJuxaxW+mzmEpw0FU/fro+g70V1hROlWC7zrH1HYJFbhH4LURNUFa4aPmBtyHpf5fxQZ1J+kB9iNl6T+AJGacPsOZyzSy4ijhaWL+FmgNe3toFwoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJf3X2tNIJSKjyi6+JbNto2hH0bVQA9K0uzfkKOeZG4=;
 b=FVPCP3ckGQfdfBzTByjT8oO6Pl4TsuZ4HCihDhxo3RIAcLL3LfNVzdAzs4zeWyZiHjy/B6uDJU9kSafqtiAyxM6QrODQpz45Yuck+9aHN4hoQKvp1ovEgYTHv3xTFoeRC1xfoQgvXCIIYUuufvAanezpmOIsTWHRN1Xz/cvICOw=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6793.eurprd04.prod.outlook.com (2603:10a6:10:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 07:35:30 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d%6]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 07:35:30 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 3/4] arm64: dts: imx8m: add "reverse-data" property for MAC ocopt
Date:   Tue, 10 Aug 2021 15:35:09 +0800
Message-Id: <20210810073510.18218-4-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR03CA0098.apcprd03.prod.outlook.com (2603:1096:4:7c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Tue, 10 Aug 2021 07:35:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 564cb71b-13e0-40ed-1e42-08d95bd16e0d
X-MS-TrafficTypeDiagnostic: DB8PR04MB6793:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6793162072B538A75269FEE8E6F79@DB8PR04MB6793.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLIlhs88gZXBpZO4onVfdY4jrbwL9lyZfMyTmiptbpbzy2TX/UYRInKe1avBkh9vMiN2lgvmJYl2A+BBK8jRnOKRgA6AS2ZcGIDlkoPVtOeCMyjIuy7yWQvdlBdUoMya3zm+/Sbcy7v8lqp7wW8ybJvVQYhTTLDHHZ/DBKC883Fm2Y/uC4/bs/onmouaM1pmi4VyaVrCHy9rh8KbH5CakQ/cQOfFVVXnr10PyS83KadgPdWXJoA0CgmuKnfIJvxB7LvuFmYqUdiJGEaIMwSIYTRvlD5C+dshaFHPLm/hLUlg4tOBnGdMpnAFxHHLKD2CJreTwrRLpROWLct+UgjZdDTnC6DxYzC51zg99p1RIyPUc4PTZBf/g6ix5zsPWgEGbXjybzSEeKIH8sqcUjb9vNg4FPvkAK3w5uKSRVOWiu1QVGepoaG3ozDU8S4nLbTP13kWrUgM2g1l2VIwVTULsjaa1MZCTSokwsdJMBxamzcshJFIUlFdYR/+Wf9xfc02k6Prd1V9hNpe9mAMI7INyXZk07ZNvKZVocV+vS/MQlqcu/2GgmnzNQjEiUhp3kGJw1b96oiGJVrhJ+IKAbQ1ckl+POAoBSf3cGN2hf1Ipc5dbXcrhfe481YxwPe1t4H2DZ3K3803rG/I+EjXylLGgGtBMl//beyDjrHDBxHN2/PNwBhXBklF2NWM1EwFPGrdhQkyxgb8ivVbT/izYMKarAVl3/1/yp+DXbz8Vbj12rU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39850400004)(376002)(346002)(2906002)(26005)(66556008)(8936002)(86362001)(66946007)(38350700002)(38100700002)(66476007)(8676002)(6666004)(6506007)(1076003)(186003)(316002)(5660300002)(36756003)(2616005)(956004)(52116002)(4326008)(6512007)(478600001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yDpCQ+Pqu81EI/yqFTmHOJOf0jzXUgQvhC0t+71BW98l1u8I2aD+NU8ZB15N?=
 =?us-ascii?Q?OuUpb6gFPXQ+Rufda9veAbu8iVXMgESwquyoK/h9aNNewEtbSArtKXZCD6ry?=
 =?us-ascii?Q?cj7/a/4wXKUjlxe9o6z/1C71qyGReYbxFB79S6WDSFYCkbMmz4R7X/EQdfMI?=
 =?us-ascii?Q?X5tXqQpd5PLhoI8OprNDiT8ZlBEuEJ+rRy13at96rLJeGDyGP1MsPnUDDsUA?=
 =?us-ascii?Q?QjtE1NDwAr1uO+9Wa0oEJCAbdthbl0YJ3Tgab5z+fj8/FC5HuIb827ZuQDX1?=
 =?us-ascii?Q?qGX5q+eexwWLLy2Z3QsO2cMGVgwV0TPipmA14DR21QIIoBtWj4Nhu0VifJtg?=
 =?us-ascii?Q?V4VVPbpB8SfQDyScz8ReWwlIM2ZJ/MXwfLmHq1VEK/cuyjH5LkVtw2Dx5b7I?=
 =?us-ascii?Q?b2qZrnzso2a+0+/1n2992RANSzxwZwkU6f2StrNMn151JeJyEHZAkQU9B5nC?=
 =?us-ascii?Q?hg8PpBMmPrJyDZVrnMHmPkV+bVMAoagUQnHj5cuGB1ctxGvbpVTL1JfjhnHT?=
 =?us-ascii?Q?9jZXP7f5tt0mkunlgvn32uopqVrGm7MaYlDhVZ/kSRYF49NuokMHT83T8xTK?=
 =?us-ascii?Q?Ukkk2nI/l//hQtImb5QfLjSaYYGGarnQLY0Wt4bcad1FDJkVxBHt+/X3ABup?=
 =?us-ascii?Q?TOIpsdeFBol7eAZTes0QZ5C8OTQIpvQzrLugrGq3hNhO7BxIoSqonUeiyQHU?=
 =?us-ascii?Q?DQKHX0thTPwb4i4FxehDcIP7QHOKY12vJp4pZAZByvY/oCml14UokbVam6jP?=
 =?us-ascii?Q?svnNvH5lAxq72jukgRA9WpjuQ78cpBoBcVZ/deT0oyoFdGN5V516vgv2p8RX?=
 =?us-ascii?Q?81iiHwzI4u/BNRY4xTCT4u0tgTZvFySd55CVFHjJ31BceI42pK+rhDoqPwl9?=
 =?us-ascii?Q?5gXHh4BqRJbJogc6rfnqlu4LTT0Bak7r0m5AB2eitVrqnDRf5k53qM3ApyWB?=
 =?us-ascii?Q?XCxBsBsl5/JL99264TFNl1rUjAgglOFnVXCTM3lim41MAKtTA9RCRvEdqwBG?=
 =?us-ascii?Q?Qs2zB/+IwO69coqR76UbIirRIzgVp0x89kM/fr8EK3aPRG3nPeQboCeopkTa?=
 =?us-ascii?Q?OrPCWQt4PE977VpfS1ZXBwkMfQQQ/VTzuT7xiOtCyyaq4fBeMIVpw2/wiODw?=
 =?us-ascii?Q?yTk+Hg1QyY15W3CCrQIitsDjW3Cw0lmAZ1kmSpk9Fy2RR0s7Gl5UAUfiHAnK?=
 =?us-ascii?Q?7tcBsERQOdvbQ8yJ0lsLrlXmGcgWqmN4tGEDUOacd4hQXmFyMlbhxXllOCYE?=
 =?us-ascii?Q?iMsqzYqUvrojF7LR/T4Ic6Ah5onsBce5eIT4wuHp4F2Zvr1RFpC/RzWZkHYR?=
 =?us-ascii?Q?LFdAuOsPEivH4cwXDgVDuYnd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564cb71b-13e0-40ed-1e42-08d95bd16e0d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 07:35:30.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZsZHrkLP1BpBscO8vCGfwwvm/2rQweYjZ8ogTowyd7vb2Z61X6Azwcc7ycnGOFj1EKIiNYY/pZdRZOxBtaqhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6793
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "reverse-data" property for MAC ocopt device node to reverse MAC address.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index e7648c3b8390..d4645fb87565 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -539,6 +539,7 @@
 
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
+					reverse-data;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index d4231e061403..4bc250682dc5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -544,6 +544,7 @@
 
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
+					reverse-data;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9f7c7f587d38..e4d879d82c28 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -358,6 +358,7 @@
 
 				eth_mac1: mac-address@90 {
 					reg = <0x90 6>;
+					reverse-data;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 91df9c5350ae..e1eb8fa0d348 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -570,6 +570,7 @@
 
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
+					reverse-data;
 				};
 			};
 
-- 
2.17.1

