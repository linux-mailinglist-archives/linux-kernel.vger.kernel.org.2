Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F611374C72
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhEFAer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:34:47 -0400
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:52963
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230246AbhEFAeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:34:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAenk7iNxGQtiDPmCfP0toLq9c6u14osiUXEbFdwTAXiOp0Lo8O2POWV+7Wed66+RoqBmbKtVZ5tSIBvzROOvuz18Ezd0pW/ixOc7aXVYdCFv2B65Af/HLmApqm8UCA9STrL/Gs6Znr+qwNn6snefo7F3VdQ0n3vAZpQf1MCbl/9WLwA3ynalE/M2v5/Yh8Q/B4vfDkha6ibdHHqQxrM7BZWv7ca2sL7PDP6zy+KAhzmjQBYwK2RAiB51BYczGwTxXikodyQejz8ugom8RngVrNxwsKnZzhpphrJ74JMH3sgO9cNxXJMmN0MjDXe2TwljqYVXuY3ZfgEZttUnub+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL/asDHNmpVzOan3dx6XGuq6dIgJP6YAMNLDtHh4+Mg=;
 b=oOChd55zxgxmjDWA3QDMVIAA75k9NFzyKHGDhObaux+bKYpF3SyAZwDNMIUblHIMKvliMNd9x7fQCy3c5Azs8/8ZUSng1M0Oa7w1vfqCB4PuzmdfeQhCZLO3yh6W2rXKEUWT+bMdZElmSTlavQZhe9/7dS77jYaKq+IsEs97y8Ikke9RcyFtYfvkgrzsHpW3gny8SHwM4J7i0M7Hc7h5eJ7ny7Lw6SsQD2tGQ1atYKj4qx23vc9vJOL56CgNH1VjaVar+foV33PEFXTB+rY1gpVQ2Ry2IdXVLvG+bqqS549UvLypc1HWCd2W8WxcswPptWf2rlqs4STh5oO8XsYsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL/asDHNmpVzOan3dx6XGuq6dIgJP6YAMNLDtHh4+Mg=;
 b=Ey7/ZFa389045fewt5nEWwmbcoxVKaicf166rJQ3BsQDlfTbxh9HoEIBe56wBPiY1oPBnib2RgLUUqoADaOiVqxBvgeoNGLnWR5JxcvaiCgdFAmTI3YjfHa7UsghOjEZUIvZfALBq7stCcGVyM4Jh1ecKakpjBjqROJ0MFMFQRk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Thu, 6 May
 2021 00:33:37 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:33:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 12/13] soc: imx: gpcv2: Add support for missing i.MX8MM VPU/DISPMIX power domains
Date:   Thu,  6 May 2021 09:04:39 +0800
Message-Id: <20210506010440.7016-13-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:33:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c44ea74c-23b4-4bc2-e89a-08d910269684
X-MS-TrafficTypeDiagnostic: DBBPR04MB7884:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB78842F4064E2124BABE0F440C9589@DBBPR04MB7884.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03ywReONRs8f8+vwzutPFRUaTk1W9SsxXF3wyWz/vR6fi89zn7deaNRnKevbWJn60F4jZuXFB1p2eiOsX4572d1vqocxYtIVcBW32PtaAKaRZQfYGXQJbsLdLIejnXVEZam+xMlxrzQ4D22ZrG+LgMlyNheKBE9w9d1hu38Fqojlb73H+DC4DqYQLZdr97s7n6y4A+B6+p3wgnfvwQoHJN6wrKQjJXsDRzFSSbhslz32+ksMBFjVVwh6/ZWi1uAZp9rxrsEn5v3gYQkTBcKU0lVllrdzrDumMIqkoNad9RmgvwTFqgUXQnF6OSMuvPRnxNGswnlBGipqymglOxzWZa+RGzvjHbN2bi0L1cU8crk57s6aC6VqY6Anzpd5/95/g5ZA71BPAtkhKMsr5yoMGU6TXv9q5wqoIE4gYUTYEuvAMcAgvSQ7GB0TUoxB94ztuVT1nsyMjypA23AQzY83js9yei04zl4kG30L9aGckc1PtXUEx+Pl63PJASBk7eXBeqqN09kLhfk0uVnxT95eeCX528dVNg8u47ILOEGETXcBPa9fqzVjgbI5oCLOUztkRiFO54zh98tv5E6UJfNTwnRwqlQrOEjlQB4ZhnCN7SeOfyki4Wlosx2w5+cnaRv+OUJkova3Nyk/yMWZ9EKSeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(52116002)(186003)(5660300002)(6512007)(478600001)(2906002)(1076003)(26005)(6506007)(16526019)(6486002)(956004)(8936002)(86362001)(8676002)(38350700002)(316002)(38100700002)(66946007)(66476007)(2616005)(66556008)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HoEXSTjtA2zycLZgVUdMRZHakq2TDrrWPHiq4zRBNwRbCj0Dt+KKV8PBC7w7?=
 =?us-ascii?Q?wZInfICrSa4XJi80wD5+L9tK7f9N5VJlrq6TJ99w10VLJokCd15J46cxv+lS?=
 =?us-ascii?Q?yJKpEzJsDE6cW295dguibGsDnxTz4b0pD2YSIcX5ys37r4glSWZ+K9GHpfem?=
 =?us-ascii?Q?jnfXwzwni0L73IJQn46RxYF1GvplLmiS8SBlezxdF1PNzP1gAe/sHJ+Im2GT?=
 =?us-ascii?Q?Lmj2T1X/CFcOdWJ5xys3CusJpNLOf0PY09d3jMmRfQX/9nZsFL/R4at58DpI?=
 =?us-ascii?Q?B6bTM5kIbpwkzYoEdswapjY6IwFCqPRxVMH/azDOyLQzbwVVseJqxDPP9Xd8?=
 =?us-ascii?Q?7hs4CRft6fUaAXkIpaqV70hdIjVGAE5JV7eiAykWYSoyQhgB4XYB9UDxpQXS?=
 =?us-ascii?Q?iKuYymYaQxk9ONeZ53sCImfGHJAGTERHRzdbj8uEiMzmiLhcezN7EodlNt6n?=
 =?us-ascii?Q?/qj2A/wrSDEud76sooq1KTVZI/RurGRfTK1lVhDGFdwmtZQsi9sWaa6gud92?=
 =?us-ascii?Q?ro2YWRA4V42Znk45TtjqC+H9nwQEVdUCJhxUmVqbBRsrsp7A/dxGQzS78E8Y?=
 =?us-ascii?Q?RFLr16mR8byyuDoSPHe3Px+mcPBKjzAJ8UAYWd5wYcEXVmuI0e3pJVpCfua1?=
 =?us-ascii?Q?rN1uYLwI2wHYPtfUf7Y+iPP/I5JZBbSMEN1eaYEAdPKPTSkxetA6PWySoZJ5?=
 =?us-ascii?Q?B73UpOlBnDrGdwVslBEjzqIXvdq03V2+wgkne5mdzrt6OjSqoaDJtSFA+S6R?=
 =?us-ascii?Q?QNrArQswg+aolA3cnnFDKP1MjHY/WYipeAN0GEpG6W965N5HklFDDP8wf9/0?=
 =?us-ascii?Q?60b7RP5VHYVQCARvZa3BC8KXjzzT1/QBFqkuMwq6dWMHHJYs/GokC4vUUVpO?=
 =?us-ascii?Q?RcFDXBA1KKMmvObz91ICACXZlzIc6/R63ET1+fjf5ubGe+nq7O+BGkCPW4/s?=
 =?us-ascii?Q?gWwjLxACkDdyg/mFZHBdncyPHjkAIktLFtTUoT2xQI8TY3G/vORIkkw0Gb+1?=
 =?us-ascii?Q?rVFWjBrnOKTin5Y4eTMHjDaENw4jKW53VmF78b5LdYeo13rTzZNSU60emX8r?=
 =?us-ascii?Q?jNciaLxIFZ87X2RZN+AuV8rVgphUJ3ueIcravf1tmnLIA715lp+JgsMbHcF8?=
 =?us-ascii?Q?bgvvfGvf7xUwJouj/zBhsRl50AW/hbzdsg83P3NzWLgpQ4nZWYpYCa7vfCdK?=
 =?us-ascii?Q?+33UvB/UzgblJbFESRiDVoX0LU9YNWhuSQEUBigUywgF183kJtpKhZPsZsiy?=
 =?us-ascii?Q?bSch8fjt9N9z0Tck6q8C3RRdwWBOa4LzmOJfQ2P7jIoRPOF+tRrmWcW/boY1?=
 =?us-ascii?Q?40GeavXdSYkzF64W641IQoGI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44ea74c-23b4-4bc2-e89a-08d910269684
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:33:37.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TeEmWnwlLnv8IQy3Dso0F/QdTML2HlfFKlsAIqNsZ91HbJOnxQ2eTDEYEGOjkCb7XmN5e+btULPW6GTj9BMTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

With the BLK-CTL driver now in place, let's add the missing domains.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index b9437d6d82a6..65b562cbcc6d 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -650,6 +650,76 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 		},
 		.pgc   = IMX8MM_PGC_GPU2D,
 	},
+
+	[IMX8MM_POWER_DOMAIN_VPUMIX] = {
+		.genpd = {
+			.name = "vpumix",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPUMIX_SW_Pxx_REQ,
+			.map = IMX8MM_VPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_VPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_VPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MM_PGC_VPUMIX,
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUG1] = {
+		.genpd = {
+			.name = "vpu-g1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPUG1_SW_Pxx_REQ,
+			.map = IMX8MM_VPUG1_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_VPUG1,
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUG2] = {
+		.genpd = {
+			.name = "vpu-g2",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPUG2_SW_Pxx_REQ,
+			.map = IMX8MM_VPUG2_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_VPUG2,
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUH1] = {
+		.genpd = {
+			.name = "vpu-h1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPUH1_SW_Pxx_REQ,
+			.map = IMX8MM_VPUH1_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_VPUH1,
+	},
+
+	[IMX8MM_POWER_DOMAIN_DISPMIX] = {
+		.genpd = {
+			.name = "dispmix",
+		},
+		.bits  = {
+			.pxx = IMX8MM_DISPMIX_SW_Pxx_REQ,
+			.map = IMX8MM_DISPMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_DISPMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_DISPMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MM_PGC_DISPMIX,
+	},
+
+	[IMX8MM_POWER_DOMAIN_MIPI] = {
+		.genpd = {
+			.name = "mipi",
+		},
+		.bits  = {
+			.pxx = IMX8MM_MIPI_SW_Pxx_REQ,
+			.map = IMX8MM_MIPI_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_MIPI,
+	},
 };
 
 static const struct regmap_range imx8mm_yes_ranges[] = {
-- 
2.30.0

