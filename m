Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9D374C70
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhEFAef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:34:35 -0400
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:12455
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230246AbhEFAed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:34:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrpNRnnK9HVvkQRNCWr6J2BUyteK2kz8QvKy4V3dOjmWuDXOmr3Pxe/ERUsJuXFkA1m6AdoLTpNjrRflOk7D7fsknqEmRlYZIEdiF6f5+A85RS6rnIxvGHgowqfwzNvR2JlLyQoQT83Fy5+VC/7NUK6fkZKcRmt4uWv4DbmoCxrxK89zz9bWaSJTsl1/EpdlOyVr4ZStplphUw9Sp5ONKCrMTBjCZGzitVWSAxypqcxSdjeVKs2yc5CXEwF5RVcamfxwm8GU7Pk0Q2LrZdaMqJ0bw5zmR/oEMUTJltPlI0s/r2JwGI9fU4MFE8HWSB4ees2tOFqqgiwqivPGbJnMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3VprvqBD9QxOKS2rHjd+ExdVQ6idh0VaqPtCNL/eC4=;
 b=iZwqwDVzu/Q8y9M8uf7xD28WAAl0RMs0UNVzKJoh6i1EzEVnFmQQds+4hxY2KybbwnBnn+XShJTD7fBMZudFF9nBndtM1DL8FyX1sy6+jgQKxT189GD0SoZfjuuojl13aCk9bU15RYG9ErhyW53cxUtye38YKQZ/ahi7qZDcItypOpT5AQRhv/DQtn5ruTXqcGqVz2DbSKsg6p8eUrPI5Nasa68fuYjuF5gBkEJcRKRq38UfMgb7JimHWFvGWn4zkTxSx9SVysgDnZP2w3KUwHlkoHAzvzAcK/JKVmbWQ5/D8E7OWMz8okkz+HSzgFE7/+48ekN+bzzv9EKWuAusfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3VprvqBD9QxOKS2rHjd+ExdVQ6idh0VaqPtCNL/eC4=;
 b=mmV4SLN359/DgEhRquG4VFAIZYgG6GVpkAYYOC7fNzgcRLG6D0F5cheMYH5ZFfxb+ENE1M9eFCj8cSAHxFAOQ/teUkCDOaST9l7X4hn+AZLumpL9jUgqPLItd7wF4KB0Ap/cc0DRPJnWfDgj2Ge7/S5HtX9xnmSrZYT2nIzaWcI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Thu, 6 May
 2021 00:33:31 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:33:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 11/13] soc: imx: gpcv2: add support for i.MX8MM power domains
Date:   Thu,  6 May 2021 09:04:38 +0800
Message-Id: <20210506010440.7016-12-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:33:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9af523be-845e-4737-d8ab-08d9102692fd
X-MS-TrafficTypeDiagnostic: DBBPR04MB7884:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB78846A50FA7B8FC6A945B8D7C9589@DBBPR04MB7884.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/MwgXWiR4K6Rpg2rcQKhNEUqE+WCvrI8h6pba09id07NVfBRFkxZX1ChSSIuOsj7369V67rxDaCTe47npgUyByEBOsiHOrVYV8kufrccVGlqb0IEjd3SYdwJu7KSkMW32fWBj699EqdT8gfA+9yCOOB6hfYwYf7AI/8F9nH19cDz6Z1IlDsLQVD9kgYRd7l1n5vXHXQm1yl5UD69GB79WCWqmUXoMqFJS2Ahp3ySRCZe2psrGFrKKzzqGKTBQP6+uIVNnD2R8kDGf2IEtR+B5jpSdjzp3OCZ2MK/IUm2734qXRsDSz1V6sXG67kugTce7Oz7qC/v+YINSvIXiiKO0od/Oz5thWUprm+LlLzc2KvdheC4UfYczApkjdFzOSKqBcvw0dm5hDlNT82K8dTXW1LcOkXPvbCuhXnx0OXkV+a6BGGoqLQkRur0QchdfFfJJc+YExhuygWPda15uYmXKSrB8UuZPf332rGrV7PTcvAxRj7KX8Fw179rL1y69loAAYPPfn9u2qGvJ6Ju8MtFkh+oRf7s2JnB6Deb+3cGaTe/CaIuanokUuUbB/WCsbH5tVbZzhUaOGEdqHZcramYU5jZEWYD+Ul4JbB0t6WOx/pIpTs2ncp9ySwAOIzboRDZJdLuQxDUJEou4AxE8dH5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(52116002)(186003)(6666004)(5660300002)(6512007)(478600001)(2906002)(1076003)(26005)(6506007)(16526019)(6486002)(83380400001)(956004)(8936002)(86362001)(8676002)(38350700002)(316002)(38100700002)(66946007)(66476007)(2616005)(66556008)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3i/omY/Pg0418+3xqdN8zkp0tiBzCWZUEfuvQCa4Y2hff6V14bn4vNcjb9VP?=
 =?us-ascii?Q?L4kdxJFGFWfKqCueufP3HVr+DEAFZ/AyAHcYAYR/f3vArosomKc3CuwwgFfC?=
 =?us-ascii?Q?jTP5ne+n1qKDwBB/iNiLNjMR4Y1pZb9MKo63wN0Iq0F9T0MVKD7iOd+lcZAF?=
 =?us-ascii?Q?4qyZ/MWT2MGOBfe8U6o52Zns8TIzXa7N5f+LLhJaciDNkmSAWbRqlSoSI6Ub?=
 =?us-ascii?Q?WMNnL/bCLZdE2xTzP4wD/b6aTwrtmkMxxTqSS17f/t3K18u7h52QdQo81Y5s?=
 =?us-ascii?Q?Cj2A5D4vubCdu+3/vc9EVP+cLzbtFT+D9pEOwe651GNtuboTO/yxCMjlAJSh?=
 =?us-ascii?Q?Dma/072b7Lzqak8RWjVUqkVwscm5+JcWG0Rty6rHUrCUxXfl5aBNHuMSspUm?=
 =?us-ascii?Q?0ptnRLE2numwhRxWZ/XZTZcsG3L+96BbPTCMhOY5l6czOArTjlE6FFj5BrUJ?=
 =?us-ascii?Q?I/vBnpO/5S6P6AAtSZRZPyzMV9qT0XJXltCGeFiv0ui/DSEd5R+spRrvr3Up?=
 =?us-ascii?Q?JsOw869tCB9JCK6VyyYvaXrW5GZwm0NVFOfzP9wMKq9LY3f18YAIL2ANGuwX?=
 =?us-ascii?Q?e0L1ATB9orQ6DWanXIEWhQBTRa7eFab3eP0b/8vhhNXpDAGPnFRqDrjImOk1?=
 =?us-ascii?Q?LwR0ElBgT2LGjtYN3gt+ZcwAbLzlQMReSR0Uu/p9Xjo9i6C+4T8Ta25ZJD3D?=
 =?us-ascii?Q?eD4aMvhOC6AciqurNs+KkQLovJ/lDFZZ56SYtt8ILKHbv6/4u4Gn0AzCagUy?=
 =?us-ascii?Q?IEG++HB1qaFBFv3pxg6NsiMk/FsGt2a2ae8yyhsifMmDS+V9f6Tc1jUORQuq?=
 =?us-ascii?Q?O7zISzQS3GSo3DTBDhymshA6OZaxG9p4Qhl2VSQW5MeBa+hatVgL8x/vf7oc?=
 =?us-ascii?Q?s6EFQUSgdK0uQ7N6I/Rc9Hgy0DrHjdsMI5n5G5EmPHDcpWiNEd0c02BIUDEP?=
 =?us-ascii?Q?gUXH0i8sdAGd85zNHyvMoaET8oSq6gJBrR3MPln/yAQKCdwZeWyB6+bBOvv8?=
 =?us-ascii?Q?Hm5JsRV6fTCKwrXRgfdGIt0OGozL0PIaDGvEz5jUhalnG2HsDywnGVPaokJZ?=
 =?us-ascii?Q?yUMaT2/88cp9MaqHqx0UGgGzuSo4/zW/wq6z3nsaIfLwN68cNQLqG5absPVf?=
 =?us-ascii?Q?Gjc0JfCBoA042VtVyCEQZzVv3kCAhOf6RdwoHtzLja1ynsBI6f4c5MG/y6na?=
 =?us-ascii?Q?/Fv7SXsSfgyGYFMqc38oqAGWjh28u+1kVTUrRe7PnzuE0QORUr3mpjlpHhZL?=
 =?us-ascii?Q?4rfnoQp093OZAeQDvhXhutH1sYpBFeywEb9L98aPP31f5rkEej0g5qhW7c5a?=
 =?us-ascii?Q?GyE2XD5Af5NPSZ8QBR6+Y+Yp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af523be-845e-4737-d8ab-08d9102692fd
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:33:31.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nutk7V6/n4KB7sAeuK6DMcXNuh1YNUXDkwFG2ClUaRw+8PqKFKMGvss+gDUKbstNjjfHljHV52GSceFgUKUPlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds support for the power domains found on i.MX8MM. The 2D and 3D
GPU domains are abstracted as a single domain in the driver, as they can't
be powered up/down individually due to a shared reset.

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 168 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 341c2352ca08..b9437d6d82a6 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -19,6 +19,7 @@
 #include <linux/sizes.h>
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
+#include <dt-bindings/power/imx8mm-power.h>
 
 #define GPC_LPCR_A_CORE_BSC			0x000
 
@@ -44,6 +45,19 @@
 #define IMX8M_PCIE1_A53_DOMAIN			BIT(3)
 #define IMX8M_MIPI_A53_DOMAIN			BIT(2)
 
+#define IMX8MM_VPUH1_A53_DOMAIN			BIT(15)
+#define IMX8MM_VPUG2_A53_DOMAIN			BIT(14)
+#define IMX8MM_VPUG1_A53_DOMAIN			BIT(13)
+#define IMX8MM_DISPMIX_A53_DOMAIN		BIT(12)
+#define IMX8MM_VPUMIX_A53_DOMAIN		BIT(10)
+#define IMX8MM_GPUMIX_A53_DOMAIN		BIT(9)
+#define IMX8MM_GPU_A53_DOMAIN			(BIT(8) | BIT(11))
+#define IMX8MM_DDR1_A53_DOMAIN			BIT(7)
+#define IMX8MM_OTG2_A53_DOMAIN			BIT(5)
+#define IMX8MM_OTG1_A53_DOMAIN			BIT(4)
+#define IMX8MM_PCIE_A53_DOMAIN			BIT(3)
+#define IMX8MM_MIPI_A53_DOMAIN			BIT(2)
+
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
 
@@ -67,6 +81,19 @@
 #define IMX8M_PCIE1_SW_Pxx_REQ			BIT(1)
 #define IMX8M_MIPI_SW_Pxx_REQ			BIT(0)
 
+#define IMX8MM_VPUH1_SW_Pxx_REQ			BIT(13)
+#define IMX8MM_VPUG2_SW_Pxx_REQ			BIT(12)
+#define IMX8MM_VPUG1_SW_Pxx_REQ			BIT(11)
+#define IMX8MM_DISPMIX_SW_Pxx_REQ		BIT(10)
+#define IMX8MM_VPUMIX_SW_Pxx_REQ		BIT(8)
+#define IMX8MM_GPUMIX_SW_Pxx_REQ		BIT(7)
+#define IMX8MM_GPU_SW_Pxx_REQ			(BIT(6) | BIT(9))
+#define IMX8MM_DDR1_SW_Pxx_REQ			BIT(5)
+#define IMX8MM_OTG2_SW_Pxx_REQ			BIT(3)
+#define IMX8MM_OTG1_SW_Pxx_REQ			BIT(2)
+#define IMX8MM_PCIE_SW_Pxx_REQ			BIT(1)
+#define IMX8MM_MIPI_SW_Pxx_REQ			BIT(0)
+
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
 #define GPC_PU_PWRHSK			0x1fc
@@ -78,6 +105,17 @@
 #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
 #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
 
+
+#define IMX8MM_GPUMIX_HSK_PWRDNACKN		BIT(29)
+#define IMX8MM_GPU_HSK_PWRDNACKN		(BIT(27) | BIT(28))
+#define IMX8MM_VPUMIX_HSK_PWRDNACKN		BIT(26)
+#define IMX8MM_DISPMIX_HSK_PWRDNACKN		BIT(25)
+#define IMX8MM_HSIO_HSK_PWRDNACKN		(BIT(23) | BIT(24))
+#define IMX8MM_GPUMIX_HSK_PWRDNREQN		BIT(11)
+#define IMX8MM_GPU_HSK_PWRDNREQN		(BIT(9) | BIT(10))
+#define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
+#define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
+#define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
 /*
  * The PGC offset values in Reference Manual
  * (Rev. 1, 01/2018 and the older ones) GPC chapter's
@@ -100,6 +138,20 @@
 #define IMX8M_PGC_MIPI_CSI2		28
 #define IMX8M_PGC_PCIE2			29
 
+#define IMX8MM_PGC_MIPI			16
+#define IMX8MM_PGC_PCIE			17
+#define IMX8MM_PGC_OTG1			18
+#define IMX8MM_PGC_OTG2			19
+#define IMX8MM_PGC_DDR1			21
+#define IMX8MM_PGC_GPU2D		22
+#define IMX8MM_PGC_GPUMIX		23
+#define IMX8MM_PGC_VPUMIX		24
+#define IMX8MM_PGC_GPU3D		25
+#define IMX8MM_PGC_DISPMIX		26
+#define IMX8MM_PGC_VPUG1		27
+#define IMX8MM_PGC_VPUG2		28
+#define IMX8MM_PGC_VPUH1		29
+
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
@@ -527,6 +579,121 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
 	.reg_access_table = &imx8m_access_table,
 };
 
+static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
+	[IMX8MM_POWER_DOMAIN_HSIOMIX] = {
+		.genpd = {
+			.name = "hsiomix",
+		},
+		.bits  = {
+			.pxx = 0, /* no power sequence control */
+			.map = 0, /* no power sequence control */
+			.hskreq = IMX8MM_HSIO_HSK_PWRDNREQN,
+			.hskack = IMX8MM_HSIO_HSK_PWRDNACKN,
+		},
+	},
+
+	[IMX8MM_POWER_DOMAIN_PCIE] = {
+		.genpd = {
+			.name = "pcie",
+		},
+		.bits  = {
+			.pxx = IMX8MM_PCIE_SW_Pxx_REQ,
+			.map = IMX8MM_PCIE_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_PCIE,
+	},
+
+	[IMX8MM_POWER_DOMAIN_OTG1] = {
+		.genpd = {
+			.name = "usb-otg1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_OTG1_SW_Pxx_REQ,
+			.map = IMX8MM_OTG1_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_OTG1,
+	},
+
+	[IMX8MM_POWER_DOMAIN_OTG2] = {
+		.genpd = {
+			.name = "usb-otg2",
+		},
+		.bits  = {
+			.pxx = IMX8MM_OTG2_SW_Pxx_REQ,
+			.map = IMX8MM_OTG2_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_OTG2,
+	},
+
+	[IMX8MM_POWER_DOMAIN_GPUMIX] = {
+		.genpd = {
+			.name = "gpumix",
+		},
+		.bits  = {
+			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
+			.map = IMX8MM_GPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MM_PGC_GPUMIX,
+	},
+
+	[IMX8MM_POWER_DOMAIN_GPU] = {
+		.genpd = {
+			.name = "gpu",
+		},
+		.bits  = {
+			.pxx = IMX8MM_GPU_SW_Pxx_REQ,
+			.map = IMX8MM_GPU_A53_DOMAIN,
+			.hskreq = IMX8MM_GPU_HSK_PWRDNREQN,
+			.hskack = IMX8MM_GPU_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MM_PGC_GPU2D,
+	},
+};
+
+static const struct regmap_range imx8mm_yes_ranges[] = {
+		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+				 GPC_PU_PWRHSK),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_MIPI),
+				 GPC_PGC_SR(IMX8MM_PGC_MIPI)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_PCIE),
+				 GPC_PGC_SR(IMX8MM_PGC_PCIE)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG1),
+				 GPC_PGC_SR(IMX8MM_PGC_OTG1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG2),
+				 GPC_PGC_SR(IMX8MM_PGC_OTG2)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_DDR1),
+				 GPC_PGC_SR(IMX8MM_PGC_DDR1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPU2D),
+				 GPC_PGC_SR(IMX8MM_PGC_GPU2D)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPUMIX),
+				 GPC_PGC_SR(IMX8MM_PGC_GPUMIX)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUMIX),
+				 GPC_PGC_SR(IMX8MM_PGC_VPUMIX)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPU3D),
+				 GPC_PGC_SR(IMX8MM_PGC_GPU3D)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_DISPMIX),
+				 GPC_PGC_SR(IMX8MM_PGC_DISPMIX)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUG1),
+				 GPC_PGC_SR(IMX8MM_PGC_VPUG1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUG2),
+				 GPC_PGC_SR(IMX8MM_PGC_VPUG2)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUH1),
+				 GPC_PGC_SR(IMX8MM_PGC_VPUH1)),
+};
+
+static const struct regmap_access_table imx8mm_access_table = {
+	.yes_ranges	= imx8mm_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(imx8mm_yes_ranges),
+};
+
+static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
+	.domains = imx8mm_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx8mm_pgc_domains),
+	.reg_access_table = &imx8mm_access_table,
+};
+
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
@@ -710,6 +877,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
 	{ }
 };
-- 
2.30.0

