Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8993E3439
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhHGJLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:11:33 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:21775
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229765AbhHGJLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:11:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSTcJ7e34Y6L8e1kD7Jes49+Z+6u2TXQXuHCQgFTjuJhTPVZgY/FHxI5wvmMJRBcQnG7YxBjvpuXq1RDMyAM4+PrR+FZjHlsU5hlgd74VrxS/xb6c4QE/yCGwOmzPTDAU2/OJbm7hS4594e74TZ/vC/3yNVyxvXdvViCLASBlUexlOfDt5+z2diJzXpW62n5kWqgbRZqc24HNG/hlfGbcOlE2XoxH7N0CB5vbX1kPKVW7Ff8IfkpjnW1NAniCeCN4KDenxR1O+d4HaiVYAg2G7aoBfT+GhKT9li2zNcklKM+2Y+7MPCbtgkD2lh5WJLq6A4uwQmVziQB9LdEk3U/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knhg/WXPZsN1AYx45YUEYQ6LEKZ9gk/O+TMTEQO2jYQ=;
 b=Vd+FH+mCKVuAv3I2/kgOkGDB2+Uqjmng35wGSE8WHFNCAtLgCiH1Y7zQ+7oY4vHbTgOta3DnfiiJs+Mm1Hbo7qrWlGZ5sVVtKby2X4gdx0tu5jKBrVz3Y+orRHKynZcNkew/lwU2OSQNY0OwMaHJmVQIvscfFyhbi+nZtdcDLOqrxyThq8kTgEoDIETkQFy2eAqKM92O+sR79n3nbGwQugwdaIuPc1MhIXDb45mhhFElr2kx9Q+3Zap+54iheIBxGp9bl6Hom7wM/2aXAzy+XPdZFHNT8F+YoliLr1z1KrFtSlu8cJ9UOg5J3BS+7g4UqAsUKy+MQy6y24g3E7mQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knhg/WXPZsN1AYx45YUEYQ6LEKZ9gk/O+TMTEQO2jYQ=;
 b=J4I8Tf0U1QupllAsT7lIYStxFqGbLEdtm+zHpI9Nh1G0mKIifDbpdMy4gjh6ym3wpNhezhHpIm0ic8O5YNAZl03UJqPObc720qzAH6sTcuXd0RUGD+CeVQxfPgm1d39+JnEnnhde058j4pp7BINimqFW7JhPcxlPcHfTzrTIlOQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.18; Sat, 7 Aug
 2021 09:11:13 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4394.019; Sat, 7 Aug 2021
 09:11:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] arm64: dts: imx8mm: update pmu compatible
Date:   Sat,  7 Aug 2021 17:45:35 +0800
Message-Id: <20210807094537.20290-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210807094537.20290-1-peng.fan@oss.nxp.com>
References: <20210807094537.20290-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0019.apcprd02.prod.outlook.com (2603:1096:3:17::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Sat, 7 Aug 2021 09:11:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10d45a3d-e1f0-4c79-a267-08d959834db5
X-MS-TrafficTypeDiagnostic: DB8PR04MB7177:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7177F38DBD2A795FF502AFBAC9F49@DB8PR04MB7177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvDrBqxBZf3RBYV4GYl52IxPB5sFAEdqNBShi0yo+bnTLe7yP98wFVnoikKBwH/20cYoVaKCvukrRPpnpLHIIqggRepnw38K1JtjxKr7MNnzh5ajqVB0F+wIYK17uVnyMzDxuT5Rolkr0IftOkYse5ALghj4s+VJ9FlaJtqqc5Hxkb1DgnfArtV4LNwtzNezVgpjEHrnOE2AGZB/LZuc89290P4t4Euth0JarBGpYw5bgYNO9OwtrRPb7tyOb209RTZOZE/FPJ6gnSesldlwrLyJcktmIgSRSzz97a84zRjnOpWfaYrkiqdoMYBs5gAzWUGW8j+q9XXlECDaad/pG/5BE80nhjRCYUo9FWCwQWcdfj7/1LVuUt9wd2AishxA6YD7HyR21yIDKKWUp+mP+xoM+8MHFVx/2qeXgtdngnGEWIWi+NSQ3oasDbY9Rnatv/cWUdIaVpLQl2YBQbArEg9d91HEp6aL4tQO1h0p5gwb1scQ0w0Oyud7TbMfm2MmeTmehQgrM04nBxo8wH5m0OZN645gYVe0msF7i/3kF8ZcUUAVgPELvvwoiyNswN87d2xCGp5TGnmiHRCzZfT/k+koJfoGtUSM92C/kjnhL+mIDepFz3Ij4wcVFq9G8zSPKrTiq9ZSffXuBWQi/VuK15+mNA4MOyHzEaa+rPC6yQC4C55ml4AQiIdWuDdJJg3HKtfe8KoMZid4x5haeflTa4XF9ROTbQcXLZPJ4+oxC9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(956004)(508600001)(66556008)(66476007)(5660300002)(2616005)(8676002)(6486002)(86362001)(52116002)(6506007)(83380400001)(1076003)(4326008)(2906002)(6666004)(38100700002)(8936002)(26005)(15650500001)(186003)(6512007)(316002)(7416002)(4744005)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y2QL7gNzC2WOb/C3w0JP/KoP2ufSJyh4lE2QvEmhrzb4E4XlV8hG0xItF8uc?=
 =?us-ascii?Q?bU6IG2pSR5BOyw5zVdxjnwC9GbGz8o34JLbHbiF+/19oRl21w0u2I+qU6z43?=
 =?us-ascii?Q?pmQuHht2XN1wPX+HMLrS9msEwMu+Ktf+Ayv0OgEHB/+7cFUgZudWzuqDnRYG?=
 =?us-ascii?Q?bn2wevppLK7Q/H7ro/h2GONta80DX/VzY8nxMdT/c+Jw3F7no/CFo3svqBZe?=
 =?us-ascii?Q?7mqBeS7R1jOiFjdVaxlhJ+dkceVKz1wWzM+e28kdfZbJjceFWxATn8fLQgQq?=
 =?us-ascii?Q?fW6OOYRpgA20/W528gdHyJBEA23B8NjavGCfGZWHnT1xHKHLeZ35nHEBt9PM?=
 =?us-ascii?Q?Mt6gM965aYvm8+cu8zbhFM0DkTQGbCM4APAhFuvSR7KRIB5gMOQjftkHzKxP?=
 =?us-ascii?Q?v+rqxRYwSeaw7lRaSdqF4M/HKUpWLz0SCHCOfjDpIHd9x/4FH5jxfZgxRoTh?=
 =?us-ascii?Q?xbiQp4xTxAv7ZJHRYUqNKmbmqu49UeLKweAuL+B2cRQFJIwfdHeGY8NQjK/2?=
 =?us-ascii?Q?e/CEAhi9AN4xl0XZgKEO1O20fhSFv6JR8i27WwFbaD96vIGM5fGa+KSMf/Gn?=
 =?us-ascii?Q?mmn+qkqeLMGo+vfIf522SP7OZPwpsztrTK8X2b8aQUFV5vObI8xsX98V7B4k?=
 =?us-ascii?Q?q+rXGq9xP2g9zKC/ccI2/f24Ma7MPgRlqMid1qdkD7zAvj00CSOJyYtlvCaQ?=
 =?us-ascii?Q?viYrIynJ5TkoRwGlmcd6UBioQ9qs0OvEsB0K/Mx4B9qtxqaObfNHLPE/5wOP?=
 =?us-ascii?Q?ufj9BpijS4XhvAKRODBoT9IEpGHLLgr+r5dWrINB5Hw78+7RHkdgqQkj/FvY?=
 =?us-ascii?Q?AgBmveFrJQJHCGdk5d0krJlC35crYHzB6TKIawzbUvHG82bGyrWLZ4TG7Osi?=
 =?us-ascii?Q?fponGFX96A5+U0x5vLH/jx2D/kqP+RMxryfcS3o2ROz5yRxERjOFIHRLPrHu?=
 =?us-ascii?Q?zTcInOVlLUZo7OHAt3WKnXojPKQ1C4yREjz8hBkcqmD9epIHNW3Dt2pw8Etq?=
 =?us-ascii?Q?GJdkrRCf9IlT2RDvhjkeoz0CNHqw6zHvkFEzSaGHhjE0dAJtHTABpRIi+QxK?=
 =?us-ascii?Q?qLCXRn0kACrMQKNM5FfTBfBEZDnYJK66t1Z9gyaW2PpeEBaOUd/0vPOvrY+d?=
 =?us-ascii?Q?gFd04b62NM7t8fCb3XL/mzIq4cd19jvt99WNTDwiShmddqMYPjKZd+9gklu5?=
 =?us-ascii?Q?dkszlmJx0zBrSow5gGmYWae1zZ945eMmJgYKWJN0PiJ8sdl8kmobJcfTUID7?=
 =?us-ascii?Q?CDPma4EiNtAsoY5rmwwO9ufsjglyvoAN4atSwtDCqeDOZ1S9mA81N+dTrd8Y?=
 =?us-ascii?Q?195YsVkM3rYjlO0WrbL/URX9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d45a3d-e1f0-4c79-a267-08d959834db5
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2021 09:11:13.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puaUCZMHVkoZB69MKFD/EUhJJQhIUqEFO8S8048aRwk8iFjdTyzLhqwLDaXGJmFWyoruFA89IMgyYmXxTN+sFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MM features four Cortex-A53 cores, update the compatible
to use more accurate "arm,cortex-a53-pmu"

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 49c46bbf8d9c..e878eefd8f78 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -192,7 +192,7 @@ psci {
 	};
 
 	pmu {
-		compatible = "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7
 			     (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		interrupt-affinity = <&A53_0>, <&A53_1>, <&A53_2>, <&A53_3>;
-- 
2.30.0

