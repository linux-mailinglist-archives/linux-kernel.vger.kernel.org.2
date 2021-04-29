Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A082D36E55A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbhD2HBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:01:46 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:60161
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237080AbhD2HBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:01:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrThyt+HR5mAkGfn1PA+V6ovjGeLmPv6kIHw1ekaJ+zBsDg3oqaT6Dn+6oF1DN4lUnUG6Le6TAb3ZWFcyqo8P8YL92vWQl4Ia+zBmdVIUDzppbyyKWJ7Ulf9F4z5bRo+whv/QF6ID+kNKO/UjuX1aqqg5qvUcxre60ruak/Pp3nNG/ipInUG1/my6R5/N2i+jPlkX30OhesBMrVooxFGgg5/pCxGWO1tsyHVwq7zFzVi1sUlxJUDR7fEZRWBbHZ0jQUxfT2GWhuQfSzh5D35382zjLw+9n3QCpKytX4QT36JnrHAuzZn1hWMC+82kzhUVjRmkQVUBWn3QZoKg1DxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaurbrjLB6nOPTOjFp0Uh8A/qK1LVe3tZ+BjaCuhpUM=;
 b=GWe2l7tUqhNOdM5UK9V6/kloLKQYbrb82qyfAh8tR7CYnwpL+G/b5CqdK9MxyFM+xiMEetw3SGWwNl6j76k1QyeN3Th+4aAf5qIBSNi9+k6xPwQXWvFi8Y/Lb/YItKX6FUNLS3VVcgqLluvQ6jn6MX4edtvdRf+I2sfcEvTDusU7RDVHMe9g+i2aoZRIq3sLxRCZzLa1StQcTivHJ3oMp0H2gOAGuVlqljgfzpyNs+vW4kNtlclQ+Z2Qz4cK4FQ0qGqNXTuKMcBamOAiFh6hsVCokKl1wB039tRqM6RQdHe7KPOn0SjoRJftxgc6CMGEdCDZ6SKc5Y7BVjKySqEftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaurbrjLB6nOPTOjFp0Uh8A/qK1LVe3tZ+BjaCuhpUM=;
 b=Q3hIz6dQVazRj+6+bQjJ6qc7jgXFpqSc7/Zm5EGLH2he7jURFjWpJDvftttRtIY0Sbx/2LRoDKlw2bIIKHFRvTVBFJ86MWBnpaRbha3TcjthK0ywXjd/h8+7HUfIwgA7rvsZj8tpp0Q73MvYEWjiOFrScLCIVPvwtztPct3RQ0s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 07:00:08 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:00:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 11/16] soc: imx: gpcv2: add support for i.MX8MM power domains
Date:   Thu, 29 Apr 2021 15:30:45 +0800
Message-Id: <20210429073050.21039-12-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429073050.21039-1-peng.fan@oss.nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 07:00:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ed00c51-d805-4a0e-86ef-08d90adc6c5e
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5468264330CAE27387DA7B72C95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: az0BQV4d/j99vXPHY8bOJMGJ5gAUOR2hphhpWX7LEmJee3NAukCH3A4rbNqluYyRcp3mZDi6DqvgO8BJVq5a2yhB30yorfQHlYnv9dCPKB9JRRGuGP5q6+/h6Q6E9tL+exWSlzAS5ei8L9zViDPR9rtJ8ZhN5zHTKZT4XrbIUQPVP4bKvS6om2+5yv4io913w09EsWhUBSZXTUAhLJOdBHKLNkI8dNlQvTAkcJKhB5qubQFW7/KVv3lMzCzOUbDGIaieP3cr2kOwJS3PiKIJZfr5ZvPk6tW/J/D+Yy4u6/L3/mGkTd1F8kyIsxXuBy9WLO1Fo3UFdZFB3SwJkk+LcPgHhRqlOlVuUwIGIpOhmZ2npVxzbo2+ycgIpWWrHOiPzH2Wb4oNU/12SxcweID1Ye2vxapwx0I/hnPXYqzWsFt2TDSr/r4vYmAIztu8YzUaEfK7xD/DQzVaZdI1/h76qiGCkKbuFbkgbv1IRvJFpJ2aRZGZpnybRaECU9SdU1VcW7OqyzEL8bhlt7LU5zhmLA73rR4Mdx1yadWb245s9xyDBM0d+TazTLOdTOJuv0qAhP9YCnbPxT8tS3s8qzItzik6YXRt714HdlVEFtvU7Wd/sUrnHDzNnl7qch3XwcvEGrtLJQnvX8LAAET2jtUYitk1JoE0O3/WAug9p9Lk5gk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?r8BWwzJvKq4QpkWPZ00DBP6YRoqSzbJ2YCKTvWdaJWr/0/WoEgUsLEuHWjDW?=
 =?us-ascii?Q?UM8tihL+C8+Zq4Lg4uD8pNWIz37EPpDsFcoyTgw0z+gJ7+icns38jcM4Kwm6?=
 =?us-ascii?Q?ojoc+07b6PO8A/he5IH861Ml6s8ba7simjV43SwYhMh782n7HCHC/aHRq7D7?=
 =?us-ascii?Q?6qPddQK5yrqOvMOCLMLKVr1q3etpXD5AF/+pLDJxWdi6UYoZ6tlx/S8Qf4OR?=
 =?us-ascii?Q?wd3Tx0UenZICeNgnJDgeWxtvVeWPhdpsoC8y5RXEG3sB5/kerKoG7K4dlXK3?=
 =?us-ascii?Q?iqOLEzxvQAQS1xZmZgGLfzCLGulGiEpwVRvZ/TPmN+0a0+XdAE5XLx9Itx9d?=
 =?us-ascii?Q?3QjOTfA1Kq8cRy0wUY2R4wfD/eUczu+XNc8o7AFihlQHuyhDwn1uA4B7RTfx?=
 =?us-ascii?Q?USOlqfFaACkqJu8GmeBflN0GLb76JkiUSUhFLNSIry65eVgKJM9WjqUao6+c?=
 =?us-ascii?Q?K52ZcJje46LE4SaIM+y1scT68BhOv/GQIuNNrWlG104pI58+APY7p9PxF/BT?=
 =?us-ascii?Q?RdymY4qWpDMATfZd9e/xEg/2JVnMSR76d+/bDZLD7mQ/rcS8n3NoRuPO076d?=
 =?us-ascii?Q?2mgeCvU3Y0G2uJa4Qwf25uxc4b+w1xat1tHMqR4a3gixIt54GLnUv/rMwblf?=
 =?us-ascii?Q?I2wlrEBwVToFhXM/Cy4bSJwQZsFGGCkSbqbzHoplKviznGJAjQ8CsQ+GjNRL?=
 =?us-ascii?Q?+mR3ERGvu8qbzmv7gk86BP/KsJ/kJ8us6NWPqG2Huetr+OiqB6+Tld2W5jQR?=
 =?us-ascii?Q?WmsIB2pIe9Q39xmX3fmLMoZwX9cJZwRiOs2EnKbO6S1vSsKEXwFoTnMAvwQF?=
 =?us-ascii?Q?Dap/t/GZBp3F7fCERfkh2Tc/i7doMSJcYgUodKJMHCn7miByE4iqTRGwZn5M?=
 =?us-ascii?Q?ap9oL3oqE/btC2HHRZ/7HCzwviVXsCtOswPVhItAvCrXxcTkKGhHpD2qzdgJ?=
 =?us-ascii?Q?BTMZ881Y3kbYdClH1l+lr9xEpkVj9j5S9f26FB4v17rnb7HLwZXeGNTR/+Gx?=
 =?us-ascii?Q?oNKJ7vlbGC8iG5d74AaKHAzoNQwbOWHqzjtF0SpY17ekj7j9Me2PzsKE+tna?=
 =?us-ascii?Q?1Cb+sbKhbmurpVI6I1qenZWOnnG8LMn5CwOico/Xeo4DfckhsGv4lKvBQM38?=
 =?us-ascii?Q?WDJmOrudeiYbkcDNXSliSkg2ME972kNG0FjTX9S3kn4CGtjU399DET1Fe8Bf?=
 =?us-ascii?Q?MJhS0Fd2k2oSVx+Ik1vK/ztlVcv6sgWA65RrWH7V+hkbo6BmTp1/fghBzwAx?=
 =?us-ascii?Q?yMBfgkaPk2t+qJwLxiqWNnNLheUsfmtzE+YCV4ql+Sa2z2r3CctgogQDJj50?=
 =?us-ascii?Q?xdwjrUo7wjaKx2Z0IebjcNl0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed00c51-d805-4a0e-86ef-08d90adc6c5e
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:00:08.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joQhISrIxJTwxCdPj35nUFE64mLaa30VXja4SR8jOB4IWB+PlQOaaDGvKpJQYOyhJ2kWGvglHUGd6yWbGD10eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds support for the power domains founds on i.MX8MM. The 2D and 3D
GPU domains are abstracted as a single domain in the driver, as they can't
be powered up/down individually due to a shared reset.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/gpcv2.c | 168 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 4a2c2a255d1a..5642dd236c10 100644
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
 
@@ -523,6 +575,121 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
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
@@ -707,6 +874,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
 	{ }
 };
-- 
2.30.0

