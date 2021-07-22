Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78E73D21E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhGVJb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:31:29 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:23264
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230514AbhGVJb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:31:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8jqb5pU2/7xaFsmUcqDBrbuHrCxt73RfFl5Jb87mgPS9oEMyNr2LzedVtcN0M0LMxyikBFOMbq0nLr4wv8cKM1BspMphMBXVpJ8OQ5PSA//WSOVpyttdowjeSAUTeFg87m9N7c/SF1Huvn6wn3MbTTDZLuygHQhsyVVFXqx9O+IaksIKf5psKx/erO/H9MKpFk/QRqZQuoINaG4HI50rS3ZduUlCUWGAnRt9kE5B0purz6FyEkiT87pw5JKucdbHT4bZ2hSDlFOnW3jh7U4eCMxc4TVQRZyH1cRt2nxtFK4+0Mk2XxMlX1KTlF1qjy6XHQDSySWdeVRF0osLyWGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWY7Q/PZ3Lf9bu5T5h0FTQDfos+bqFK5pE3hQtimb0w=;
 b=kS7qXnc0ZCdQRciMaIaLhJ8VlD70r9zQCC/RdlIRDubXlnZGdBIcXWAEkukA+rLsoiMte8XaPwr60VHf7ZJoyiSC6XPXGKt1ry85WlpXsNZEyF0D54CpTzvWweVZnnjo/pLpAjWxBaWmgG8TCbCtXJGZHSIQW/tQduqwB2eucudJhfoAJgwcyBvU360897QJK4BliHjpfWwXHHEpG7hO6QXp70d2/2UjKaC9UxZAsySdJgXxF6SJEplmUL1XBGRenVsEyrheb8VNZx6nhQhcuDEWgraDo/w2SF9qP90Xd/ZfJ+XhmQ/Fr+myWFx6isSH/VYOcBjgM9lN9fMoiWTtwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWY7Q/PZ3Lf9bu5T5h0FTQDfos+bqFK5pE3hQtimb0w=;
 b=O1aQ2cASDpQbtt9tp++/LijmbMdlxpwhXnkDNXnq0a9SNzG+40eMONfzxWTa+J4qxREj4HMuIa/VYprCk6GE2osJbgG9LB5k1rWb/aPN5qaGBDbuDg2eOft77qJgy1OHiHz8Q9cJ0GD0GAvwsFRs0sa+WhuAEdAgrqQ6qj+a03s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB2862.eurprd04.prod.outlook.com (2603:10a6:800:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 22 Jul
 2021 10:12:01 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4352.026; Thu, 22 Jul 2021
 10:12:00 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] arm64: dts: armada-3720-turris-mox: fixed indices for the SDHC controllers
Date:   Thu, 22 Jul 2021 13:11:34 +0300
Message-Id: <20210722101134.2514089-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0107.eurprd02.prod.outlook.com
 (2603:10a6:208:154::48) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (82.76.66.29) by AM0PR02CA0107.eurprd02.prod.outlook.com (2603:10a6:208:154::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 10:11:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40195ce7-ed52-463e-3941-08d94cf92531
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2862:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB286296BF3837FCB313D6DAB7E0E49@VI1PR0402MB2862.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z804K+rhIhpkoO4zVfwK66uMrvSt3jxSA2JfuQNR/RAMxWPp4uc8RUZ+3ic3ecxdqVyjJ0c+NTFDx9XzKt0B4bcWvLwnhpHC2Iq48ov1BgDXtL9aOEOaRCKRD+5WhGO4kBuwbW7+Zf8Y8TJC5bMy+4qZXADcf60ab6z6HdRLD2ERGpA9ioLyMHWP3g6AYGhX8/wIJctffiQry9925o4P8x+TkZeVTPM8OvlyTp4SAxpTS1GsWDYCs6xOo0iidI9JoMxB+EJavXDJhXdgm9bYTpZWTzE8hesI1HrzR0OUweSTbd5zFkjmsdrVqKqa9B+k6N3KwJNROakn5p7AGpl939aHyLNfL6tUczfDWyUmqgFKiI7rDk3g75IjEk+UTXwYI0YVwdmBey5aqDiUrG2ctav6zpg+otDtULxf/PDVjTr/KLtT/IKRFDfE7khp6YCi3zkQwk2HlsfxVUMJ9ODOSQI6bHDgXHQ38veLTm5Q7bIyTnPDuNvn/m6ACSIq6UJFrAIbe4ztUWwj/8NG174YkMeTn23z5VLClL18fxeLNxXjp3U7adpnej/HXFBrfKXiUrNlqbKGH4Pirmn4GNHrhWEQTuU/inUvXE6HpPszpVrEgMzwZpv3iQUkR2BfbJCqvMYFy2m9GMMMN0ck7pY/YhscE+QpkYFZZSFvGMuZILGA7LhqsdjJb10Y68SAM3ANlNMmZ9RAd1rjjdLKo8ELLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(956004)(1076003)(86362001)(2616005)(7416002)(5660300002)(4744005)(54906003)(6506007)(6916009)(66556008)(66476007)(66946007)(36756003)(8936002)(52116002)(44832011)(316002)(8676002)(6486002)(4326008)(38100700002)(38350700002)(2906002)(6666004)(26005)(478600001)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O8jv/2ZTZp7zcWD7xTkqw6YvIWH1RSHQz2K6mrWkw9ojllIpL+rDa33wPMDx?=
 =?us-ascii?Q?cyqDi0YVmaBq2ctWnd/7mfKFboYC4c0YGo+Oc6+0/wLcAzF7Enc+o2a8I+y6?=
 =?us-ascii?Q?+dIreUVHPIfeZDcE/iZDOLU2GsjtrhAgUkNrFIlH9KM3PfW+z3rEd1InM8VY?=
 =?us-ascii?Q?uykD6wHoXUjbMoklGzc7tFwT5CfBTS15ToWZEpuNkcFm6sPz49Y+7mE54nCq?=
 =?us-ascii?Q?LBtlhkFRDUfCfxjIgxyoX/Fh8KaO1n67n+tvEmMOZRRzUj2mEwyFXHDjL2aX?=
 =?us-ascii?Q?bmZJ4PNw0E5WJ9H9+TrRqTxuRaw8XpocuXHHzgUkVOgzarbg9uA/bEa85oXL?=
 =?us-ascii?Q?RanJdPrh8oN7mDW+Yd5zKUfDofmxCOvJeStL6Gh4KntreCM2NfIKjOchK/hC?=
 =?us-ascii?Q?0zO6i+uPr7QMyQVBG2sPs0IRd06DOZyLM1Q7pB3UxHhq8WkpckaFaxZpWQdA?=
 =?us-ascii?Q?PPlxjh1BpprF1AkFmUL87u8SX7qKd3p+GeM2zCpVKmYNd3vN3O/2NBqjfN5N?=
 =?us-ascii?Q?UH8rs3GWtKO2L4bt4hN6+ruxOMCUOn/9dSwcFfzX+ma07tGH8zYvMCXJL0IU?=
 =?us-ascii?Q?OH2dRbWH8gzEMAJzmm2A2LSJ9eQHRIRZah7qN/7BlTG/QEsVYL/Fx8TYFjtO?=
 =?us-ascii?Q?J5WUkGxT/fogeQuGaNvijpcwxMnnMVepS7c6V7rjdeycoZaaGyS4TH3a6Cbq?=
 =?us-ascii?Q?Okb0rJTsjqWzJYpLP2hIX5b9xrYtVepFvJJBPTo7XjsIUtvAtzrUwsngT3oN?=
 =?us-ascii?Q?UF+h6qbMamHXIKa1LAn9jvLYMTH31q5mdI8f7Zxd0JRyjLIN6TngaBUKNrTr?=
 =?us-ascii?Q?J6NSLerI0w+xUzosC3Tg3a9EdhBKLQjc3GAgYPs6NWDjehtl0DUB9yrNHJ8G?=
 =?us-ascii?Q?+r8Va/mD9SeBD2uVAdlSOTaS/AuJP9F1WBXaRVUpAYLy+A2xaA8GZGu3Vkod?=
 =?us-ascii?Q?PGqjacQAxjuc+yWnHMm55nu5tzD1dSyqU8tGE2QLEvZN8NdzP7DpWUvUqG9+?=
 =?us-ascii?Q?lEibiAGCzj6hXE4wfcN1jRWXqJwnoxOTDpqZUTmuGIFJtF+dbjhU840CR5mW?=
 =?us-ascii?Q?OoduuYvgoy0j6bq9/sJA3U5C7kfyYDZ8r6zSDQ0EPHqJiuN+vICXRHCqKxpP?=
 =?us-ascii?Q?7uHgjouuZbbT6SX7H8m79Funbi+lsoVRWXkoGC/Ch2zVJgQp7UKzM3ElrFE+?=
 =?us-ascii?Q?g4vkBIUDZ4lNevvXx0KjS/t20Ks5kw5VIWoKbacSaUvipyjPvnh/B7APIxvW?=
 =?us-ascii?Q?4hVONU1jWnbbEY6VQGrJnzv1bc2k1elMAYgNyEEwuEk8T4VHm/yqd6Sq1t+3?=
 =?us-ascii?Q?BiPK/luMPMjncLTqsub5hu2y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40195ce7-ed52-463e-3941-08d94cf92531
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 10:12:00.6854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chD/sOQTgvnD0QgEC8Q0Z/EcDdhoz+/JWdwy4Hl07XRNHhkmjy53a/gEAOM3bsuhDrckxKi9uRcCzziYHkTqyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since drivers/mmc/host/sdhci-xenon.c declares the PROBE_PREFER_ASYNCHRONOUS
probe type, it is not guaranteed whether /dev/mmcblk0 will belong to
sdhci0 or sdhci1. In turn, this will break booting by:

root=/dev/mmcblk0p1

Fix the issue by adding aliases so that the old MMC controller indices
are preserved.

Fixes: 7320915c8861 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.14")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index ce2bcddf396f..f2d7d6f071bc 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -19,6 +19,8 @@ / {
 	aliases {
 		spi0 = &spi0;
 		ethernet1 = &eth1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
 	};
 
 	chosen {
-- 
2.25.1

