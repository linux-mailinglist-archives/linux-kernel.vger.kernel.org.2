Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003B4374C74
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhEFAeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:34:50 -0400
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:52963
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230393AbhEFAeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:34:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTy8d+ri+g8KtOR9TSGcWsBavpP98lCZlBpicVipRMaxs0vVHd7f+LXMBEKOyRddf3D8AZ5/CSBbvUWK1f0vM9CsikaOIGFe+GdqP90tFeL6QH7BXgnfyS1FOQ0rWV0GbWrbCDs5OmpFvts68OI45FuUduImSWmF/4vkBnRfSBnZTU5VIELXa+Z+qnXTtOrc31BYcNs/SnCriU8TjewZsgo0nu5A2oGKX2EG/8ux4xrbsmVVwlO/Lijj+4Rd2LWuBTEoJ/hAwheryWyZy4QCqJrCmO4CcClTHnXTkMMOYUx2aD2R8h7OzF/Gu0G83jsjH4FHyucrq1KYcbSRBb//SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6QVYSOpg6OI1/lGSqpz04ydUyaxyFOFKNDWb1So/pQ=;
 b=APoWUDAm//vX0OHrMZO+j57TR97g0aIu9XU+wSUJQ6TVQjuDYkcFL9ZDCPKKkUXUDtBkOVnsHrOj9KyTT6D1RNn2FZ+fQqId+VYE+cwTYSToih4efLcAzc4o1zuKZMBCX27hscGL/Rye8CM8zexd3/g7n4WADkvh5LPTxtzz54v8qOFJu2cNty8W791p+BcpgCb0QPiCID0unkUMSdoZC6juq65+bn9PmXA/GzaIsDSKg+JdvG811M+hI1FXw19pSEdS6IsKuWTLp80uBwBBZhFmmXJr7ZBT9evwBRAxwTaMD1nqbRCefnSd9PhL5RxjHO/mp7OfCdzVJcDg8xbcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6QVYSOpg6OI1/lGSqpz04ydUyaxyFOFKNDWb1So/pQ=;
 b=H6TVB0V06c+VYLqainKwsCWYsBG8/RHC3H0r3gUPPYs1V26w5LIP0Zp3+j2I0vGDS7dU3Fu1d2Ux8awcHLLL3IMaVGb8wM8w2yGAMTG/SEbgKo1G7dZaaRljiLNmX95HJgV5y3xNwLekUiav7nGzgOURePpyAhOgFyjenUvDyPw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Thu, 6 May
 2021 00:33:43 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:33:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 13/13] soc: imx: gpcv2: move reset assert after requesting domain power up
Date:   Thu,  6 May 2021 09:04:40 +0800
Message-Id: <20210506010440.7016-14-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506010440.7016-1-peng.fan@oss.nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:33:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7b7ea42-8fcf-4f5a-c3e7-08d910269a1a
X-MS-TrafficTypeDiagnostic: DBBPR04MB7884:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7884BF9639890929546168A3C9589@DBBPR04MB7884.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ll1AA/PQqs0bIx/rHNwxAP1TkIW1uQgzdK7zy69RawoQaxgD+2uB60vce3ol8OeB2+fpZ1ZhWGEwPT/SAAu7A7nsVZ2UCLCotUtX4EtPCT6LOXJLFned0ptBL4EBBqSw4pj0/QBsCdfhhCykEVDDsQ9ABONcV6286PyxIO8p5MaFboY4CKbmft4fZx6AD1p3ztGNO1+cS8ZoNlMJZGqg75VQHLXPfBIkHblBoHZJ6wrAAjIhgRwjCyrbIv8t/KQuJhMBHMsEVP3LOh1U81Fg20MaYZdSemVkEvRn2J/6Ee4+0CLV/1NXChBJas1RR5tkveHNLbCUPDcriLmrxPJ237GsN84tVTzzQlVk3O3szmCHNOjx0Rqrn2/XMF9SK6rTUTVSZa9byJUhUQSNVXGuewPtaDVE7CqyOLrf/ci+OWUuIoP2HYsiseko998UwD8lYcpdKt5DPz9Yyd3AXFbnvADfomNuNQXqONeyEfy258zcyjrhK0Pul59578nYQIs6zNdh0lS0zI44iKJqCkr5mNt6/siD9LrxmYxtJ+AyhSUWgSjh1O6/pcje/9sb5dLBJgZJPBFjeCUBDF4EfUnGmiqDYxebHRhV6J8hYRecpHEfwqA3rHvXegoE/lojR+1Ipfv4jmGdj3H3iF9WlVT8gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(52116002)(186003)(6666004)(5660300002)(6512007)(478600001)(2906002)(1076003)(26005)(6506007)(16526019)(6486002)(83380400001)(956004)(8936002)(86362001)(8676002)(38350700002)(316002)(38100700002)(66946007)(66476007)(2616005)(66556008)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3ueNzCKQDATkcM5cgDMx56GgmzrJufEddYLBRBbn3h83zG8jj9yHFpz2p01/?=
 =?us-ascii?Q?LmT9xKRaTjUhw7Ef4w9GsBPr9/ZwWyv5r33wLChZHpZGAEekNZS09DAoqcVe?=
 =?us-ascii?Q?zq1B6mpJTv+RcNXOZ6itSlPRh3rCPFvoFzxGjD1Kn8Zhq1w6FjyvAoqFTYDp?=
 =?us-ascii?Q?qZReBLt8E7OcwalVkkLZGsYjU4Q4l5F9+OYkLwSPj4gaf2b7d+/RT3Ij8WiF?=
 =?us-ascii?Q?oz1GkMfJVD4XB3vA+bucjZvC1zScdSFQU9nAMp3u4t3Vw8KRlYDMDgxQTuOP?=
 =?us-ascii?Q?RWVUQL2az0Ji50UNK9PnQpGKcbijd9Gr91zON6PgflREhjcaCvIpQQX6z0Hp?=
 =?us-ascii?Q?T5lziT1vCubGfLfbFBaH8PhBEg/8p4bl/lvTTcUdwNK5n4AVS8e9wGH1vO68?=
 =?us-ascii?Q?mnpQofNSOU3A5wV/Kxqx+mXMo9jv8oYy1Z50k/roHkEblucRxRQJwrsKHOGk?=
 =?us-ascii?Q?mNmm62bhcKwKY2tb4D+NQDk4wEMP/ZCZkJlT529rj/6e6+vFelHsYVX/a1ZS?=
 =?us-ascii?Q?Ap5LevZWXAS/V6lkxuiRgPZ5FPQNAkGTH3zIRULIT8GABzArb5k0H+BBOokW?=
 =?us-ascii?Q?efuqmZX5wmVPqEaRqs4/6AHcTvt3wF0yEOwjbQqG2+urCdBP6Qrz9+fKZnF8?=
 =?us-ascii?Q?OR/L0HfI0QIkaSqZE2seYZR/zqW+e9YLnlYGF+H2vuVifs4Xjznh8DFS8jOh?=
 =?us-ascii?Q?DiicFsys9msxwhtquY9ELhEYvXA0XnOj3zTJR515snXclMU3ZIDwUspmbKEs?=
 =?us-ascii?Q?fJJH4Q0fvFsgP+472Oz/rVycTKpXRUutvn5ZLcL3wCS0aUcFBULQew20dFY2?=
 =?us-ascii?Q?x4z3f+7zlE2QRdd5RLgPXI/bGBDCol43n5C5kV52KXAF0mmePgsJHJ/MO6ci?=
 =?us-ascii?Q?oPi8wwnHC6hK6YXhpz+PbcH/dRNAZFtJiIZTKZnV4YXGtkb0n+S9u6KXVm9w?=
 =?us-ascii?Q?Nu34D6ag2GbsBcGWzwUXFpGJwnkn6bJIDlE6bhXS7IXrRrgiozA97dy3RuFz?=
 =?us-ascii?Q?2J/mdNNqczg9ECOCMqTS0V83WzlXlGeKIltap9slArF2Q46OjFcB7h0uBTOD?=
 =?us-ascii?Q?/vVyYJRvoXPo8Ns7Y6j4MepxcoU5nLYH785ZWr0/QzlmW7JszQPL2N1CuuBe?=
 =?us-ascii?Q?QaBstsvmmAomkoWjAQFVjGgohwsZ8+tOetbpzpGyXAVz8GZ0KeAM8p7R6DJA?=
 =?us-ascii?Q?QGTpM/ZG+Bfjz8z9IwD03GMqor5K/FczfC0hiIQDHcA/Wyzo7qFKl4vyEP5H?=
 =?us-ascii?Q?tcqMDtBBW6ijUVTe+XgFaPp1gxagna23yjFZrwRDtxiAxa1o3hxbKZJoyOZn?=
 =?us-ascii?Q?nJ9vOUnEprcUCavOgTfsAlvT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b7ea42-8fcf-4f5a-c3e7-08d910269a1a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:33:43.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5iysvq/Y3rx7FyuaFopXWoZGZMV3O7psWAeBC8GjFaleWApUH5h4/oyrZ/7VC7tMXM6U98gAiTomQ1ANxDt9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8MM VPU power up sequence is a bit special, it must follow:
1. request power up
2. reset assert
3. reset deassert

This change in this patch will not affect other domains, because
the power domain default is in asserted state, unless bootloader
deassert the reset. It also applies to GPU power domain.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 65b562cbcc6d..325a34833ffa 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -217,8 +217,6 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		goto out_regulator_disable;
 	}
 
-	reset_control_assert(domain->reset);
-
 	if (domain->bits.pxx) {
 		/* request the domain to power up */
 		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
@@ -241,6 +239,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 				  GPC_PGC_CTRL_PCR);
 	}
 
+	reset_control_assert(domain->reset);
+
 	/* delay for reset to propagate */
 	udelay(5);
 
-- 
2.30.0

