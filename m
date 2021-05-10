Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D89377A97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhEJDbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:31:24 -0400
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:52654
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230425AbhEJDbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:31:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajfw8LRv1DgzG8HL5XfSfUFLfPkC9T4zw6R4OM0cQlkTTEc7nMzLh1BhV4db1we7ou8thsLe+zsfo15k+ILjQOGgt58zSdcMOtGChTdzSgvbV/TXUOdIlwA39iD4xr+D0xiAPvXeAmVkKyJ1UN3D7HVFKeYhmjqziHyMAkil6l15qrOrqQ1auMF7GSvhJ+U/dkh/FiutnfYqzPXqYCSHgsg+O62vtRrJPwDooARnS380rJWEBY5XRv4j+GeTNTCuMxjRQhlrBwhQ+3AmE/1dG6Yc++YfQRrhMtFRGUtd/q+lg/PUNcV7n2sFz9vs719ubjtOUnyhdMjnaARzhjZVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq+LJJeqZCNia778mjaNfmB17XwG8aX6tv846PU3g5Y=;
 b=THm9TWGXY9JNu9D2BYj2cuSA2JvjfDRDXa1blbxv6s1gorwOVQiqAy1DMUZ32rBZI3IA9/1KP7hTfjajof7XR994/W/9HbTKa6451JYay2bsgyDCSr/Nrda8zKRnm48Ry3GugBjoj20OHsICSAvEq3I3sWnf4oM2XMB8rb18x0caeniKimuc3nspT63okBBTZdmMNZD/Es+RuEX7U422REW1YFeLXhJCc81rTZcb39IzAovNoipeUHIOScKMMiKQP43aypXY93pa+eJ5Z2VpEcbNG/SB0lrDUaYot/bruyZxRVn55HekO/4XbeiLe1a74xUGiURJTACJWqohRJfqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq+LJJeqZCNia778mjaNfmB17XwG8aX6tv846PU3g5Y=;
 b=KJpU0P9i3ObbrHbvGnA6IShC6UpHgEsposLLWB6D/yRgW7392XFC8qvNAJvWm99iL05IKMarMlcb/OCCeqyBX49ZQ7aJocyj1RdKVHsWm6es9uAJ+IoGAOWW/aNLKZKA0hk6jPjilGpf2U1Rx/1bzL65jUI73itT6eEcb+9V8Zo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:30:10 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:30:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 12/13] soc: imx: gpcv2: Add support for missing i.MX8MM VPU/DISPMIX power domains
Date:   Mon, 10 May 2021 12:00:44 +0800
Message-Id: <20210510040045.13225-13-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040045.13225-1-peng.fan@oss.nxp.com>
References: <20210510040045.13225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:30:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b453e98d-94ec-48aa-db20-08d91363e9f7
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4091B2D2E9D1CEE096DF4DB9C9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ju/WA30F45KgGu+L3fKVqcOy0VkSCFDyKuV7U4PXaHg9Rh39hclDtzpe5cKaqGG5jrJrl9xBjyGMuVFvBNR8/CZUa+4qHhfK5oX9fs/ni6glMHq7eaC7ZamhxHe9ucJnOltbIGlMtRVMZgkPrbqTOQTJZY5Q44UjdgCrey6yUGAiQedW5HsbV5HyflFm2gYrFQBYV3ie44kyEiKw2kSCd0OW4wGktuRpbyRXL5jd75sxXvqijgCUIhqxfgxMUh/Acscb8Sl032M+QCMfc2Px6hCUTFCFSqu4HEQUSMkuqvogqk7d8G1pAWd1RknuKlG6TCIzmbjHnlbsfnGptRQpnZqwnfEyxOGcMrGwnI6Phw2VnqUCkqtOWTWP5TLaQSIXKAPZiQ7pNYkCjEtouO/nky60c4LUTuBymwf8Htfptz1nDDEuZ46Mhp2HjNyHloMZmjMM00i6js4CCFihM5dDgBmZG8F46f9ptNmDsaZS62N2IDI2801HnGXoAcEClzzZMqoETG8/NttZ1yUtx7pFzffdW+Sc5CQjkBVQ9vev0gQRirfqAmChhfcCnnKTNksjlUV0grUdRri7sKWBdyuXsvGLqB6SDWFemZn4x3o2j+2iajQYtWP/ptKVucKFLRKqywH83n/ycMD45dAUZVwUkxPD9JCdZ2C4hGFqG3PGRBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wHbOXDlvJkFwL3S664SAKI4QPx38mhpXFhHWQgnZp3MMcUCPgZ/qrYll2S5m?=
 =?us-ascii?Q?DkLhqXNzspkAOoc3vkWyXr8L/9TXnWGI//LKhNS74PZIP++Ul0F28PEbNYyk?=
 =?us-ascii?Q?f1aKUs3ua0e70y8Kxd7yTPlRsoWSgVFNTnnF7S5kGKT2IC4CooOpT6rzVNoE?=
 =?us-ascii?Q?6LVHJGGi5Mz9unj+rizjFrbJg+U4h/utwt9fwfwxa3XJIompZH3s0+ql0YOc?=
 =?us-ascii?Q?PnD2w2j8IEmeMGL0+RUCm3AhkSAl5qZOv/+vl8VpJgAbrqP3iatbkLTRvNb5?=
 =?us-ascii?Q?3T8Mqw1zEuwn9fGQg4m1eu/DzqKtFFH9WAjXWWF0qUBjXqR8DmyUShlgwEeO?=
 =?us-ascii?Q?JZQOrfXcI/og4NA+t/miFTdH0miaXDcKh+VSc1IAvrbfQYVmTETM9rTi71v2?=
 =?us-ascii?Q?jiWjEduZL2tcm3sRSaRaTvpAkWGCqD3VOXfUWpqC8QvUs0B+3XvSFqkV1Agu?=
 =?us-ascii?Q?QTdQGwf8rCeHee6CCdSbxWMXSm9gqqNY4R2zM/N7i8DZDI1Vl3X/Ggk8rk4C?=
 =?us-ascii?Q?2wgTpP7pUF8JnsBcQrJsgCef2rPKRM+yfxcFnhpAaYVm1sL92OVwqqBwS+lo?=
 =?us-ascii?Q?na0PYKFG3hTVw2K6ZsfKgPyMqDnYmxSy0tpf1O8XoR9KNWPNa3t+uDpPJysf?=
 =?us-ascii?Q?utkaugmqa/5+YzWv++WYt9ir/vHMNuYBXBKrw6fmfsO6YgrTFPqLsTItHIJ2?=
 =?us-ascii?Q?h6MrUZLoIs/2qdSlGtLVFsYZbBqcbbf19x8YPrjhbeJ5HFN2voX06dkL6Jt2?=
 =?us-ascii?Q?JQZXzVBkDVsAOSdPm+iIjqjSi3MUk0DojxqcLKe6OyYmmLRQpby3AQIMzcnw?=
 =?us-ascii?Q?+n+KABlz6MEwvLxQpdpiyoZEq95OLfDiu2yivVcdV3YgNcpgcghdHc6dCxtd?=
 =?us-ascii?Q?+bXU4vvumAztE5AmhORRzXXhdcK1/ZiX7H8sp/+zIBj9BXNoFkDWInfwg4vu?=
 =?us-ascii?Q?fvdYNPVuxHSJYnHUhmyYS/dj45GXGS3R+g1yCy42Fq9vLQJh0SqyNRn1pfEj?=
 =?us-ascii?Q?7s+xHCVhZODNgIUO4hyriyBDM4W6JGxabcI6ecnzVxiomsv7Wqz1LdBQT3Ke?=
 =?us-ascii?Q?W8sqtltiAtlCZ2R4awezWqqlEG5RgjMSlEy1LYLLvK4M4CvV1weTO4dfoGqZ?=
 =?us-ascii?Q?c+MYpejhHRLgrMs2mYVNRrwRYgNx4YvyeymZ8NtyPVtBkB4FTJLh4YpJxY+Y?=
 =?us-ascii?Q?Q+fWnZGcOoj2XJGkUIR4+aZY9v6+stjgdoG0JfNpCLlUyYSILBqT+soYZhzW?=
 =?us-ascii?Q?IAu67mtFfeUdqokItwBZr7/ilYUfDlDdWmLPKfPEGhJgafr75ssEHqRcTP8E?=
 =?us-ascii?Q?+hy/NYpvOrPRbb9XUI4dJjLD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b453e98d-94ec-48aa-db20-08d91363e9f7
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:30:09.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kw+pbaFDQ9742VJlVaxjoR8xn4oogyfhKO5KsIlz4EzGHSA+p6W9boii+T56vFikN0XsGfDLuDJ2u8a+7kInpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

With the BLK-CTL driver now in place, let's add the missing domains.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index d676e65e8c16..2490757f759d 100644
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

