Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB964543EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhKQJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:42:55 -0500
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:35585
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235491AbhKQJl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:41:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqidAvOO8nyiinpv+cnIskB3DBCr8OS8JWKvR4SkLwZBiAepu1yshPSMURJN81/n7KQpfjyf3Gcl8OJ82h+nRJuulOP/Vqe3kVO00U7WLdb9iazKwSkEX6sZxOGcuuBUt4DP6C8ko7ZChOy2Z6UVSRcbtYk/E0yTqK7jX9PDn2OdhLP0jqd3z0/qUIT60HlVdmD+Xep0hRKg+/9k7r+3cOSQBj/XS7nOkCNsRtd+FMT5OMwlF99X/KalzaE/opfra7P5PAjoSoK8eVys4zFyPBEXnl6awjd0NEzVDfJ+gHJJbcEU1P1MulrlTso8MneNfiarAR02jia2KmVnuDl2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qETs5pmNyjuaBLj+49Mq3BcTs04Xkehh/3KstmMEV3k=;
 b=BigAi9lyvm/hBVdz7IR2SSbmEXqy7J9ji2Jfd+QYWOa1C0ndbJY4qS+mHXF6agO5SWEhcqHjlDpLn8SSMe1qjpDA6o3i0E3/xk3QepCClg1dZVItYGlYmZXCX3pwpgrUiXI5B3DtzPwFtWdzn2IrPPC4QyTgmxKI7P6/hQx+SjV4URnZ50hiyiQsGHnJEDPGIacq2ucKuVeFDAfaIn9nreYaaOJV9e0tQjZmUr2vnuZNFYFac36VfoQjJkGyd+Q3y3yS+xH2G7Q1mDjpUmmjtyydd/e0XslXlkqSfdNuZMjsPdDJNAIopB21QpJ2RZrVV7W0FQLVQ0mVJz1QtUhMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qETs5pmNyjuaBLj+49Mq3BcTs04Xkehh/3KstmMEV3k=;
 b=FVW/b9oNh+Ysnz+RVl1NkcoIR2E2iR+0EPxymLedWUOeM7/EtaEuRNpKFyZ5Vp87xL0tN1DpBS4cr8fQ9XOFlWGYatkylMHy33pPvoLEWqCWcjKohpC94E+NFIi15VOrDwTZnmX+74jXdgQk/GtGltKSV34bTqkfCFvr0FIlrU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 09:38:18 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 09:38:18 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        AjitKumar.Pandey@amd.com, Balakishore.pati@amd.com,
        vsreddy@amd.com, Julian.Schroeder@amd.com,
        vishnuvardhanrao.ravulapati@amd.com, linux-kernel@vger.kernel.org,
        yc.hung@mediatek.com, linux-mediatek@lists.infradead.org,
        Bard Liao <bard.liao@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [PATCH 08/21] ASoC: SOF: amd: Add machine driver dsp ops for Renoir platform
Date:   Wed, 17 Nov 2021 11:37:21 +0200
Message-Id: <20211117093734.17407-9-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0060.eurprd03.prod.outlook.com
 (2603:10a6:207:5::18) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5706:b700:22bb:b216:ffff:73e1) by AM3PR03CA0060.eurprd03.prod.outlook.com (2603:10a6:207:5::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 09:38:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6beb1744-f0e0-4322-305c-08d9a9adfca1
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB58079B76AE2CE7DFB26FB193B89A9@VI1PR04MB5807.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zu+hQ9iK5kM3HEeQ4xUH5MHF2nsZvfLS9fL5lVv5uSpHNkEChuPTUsJEODInuDxH5zhfJtDowacc/XzGXRtGWTXYtsrUC1f0fqTZ1hWhhoOwwhJcAm90SvlSgTaSFFNmtxv24oITacR+zp1Gn5mPI/O8KAJD19YOkDUQIsrjXoo+oaoYO2YCGbhJpxZpyUArrG+lPp+cQROGJJ2d4TYpmywxrAoxYq58298Av01DSbVpA3j5kxouo+I8W1UgIRDdI11u3GaqPybpNWaER5TrofaVRfaoLE4MFm8Ft6QnBkjR43z4i1L+CE5me8Qd1HGn6xZYgbzqaN//3wdVNwKtEmtvInFXNLlyjGYsVdIkpnpznCzvK4Q2zH3rDFnFLFfQTFbY2/l4hhfluSx8D2HKqBvJWQVoPeY/jkjQX1PKO616Ebb85v+dur1fpbWvaxkG9s1IE6ao1qSvbLdDMv/kggLg+z19frNsdkZhON2e9cpWRJoXunALxZJ1clNfzQ/f47bNGZYdFQUMZrSCAy72TLKQsCuC8cczXCwNjoZUPPulUN85RJILxz1Ckuw5QDe7edFvrHA7Fsu0ogo1Da+VltJMX/D3ZavjLimMb2pUQ7RJrZCFkNqndmiAzMX4DZ9Bcn307pPThwncYYsxVG+sIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(5660300002)(508600001)(52116002)(86362001)(8676002)(54906003)(8936002)(66946007)(186003)(6512007)(2906002)(6666004)(6486002)(7416002)(6506007)(1076003)(2616005)(66556008)(66476007)(44832011)(38100700002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7rFmaVKnQjnqBbzyMo+JPAps9nd+lDz0TY/HfRM9k9KZ+ZDxrppP3SEYBzr?=
 =?us-ascii?Q?SsIu6m7v5YNNF41Qyi+V3w6Sd1/OYapdMbms70ENcJhZxqZYfhsqQnrzkhBS?=
 =?us-ascii?Q?ryosJKZT7vtnO4aEjPEyLWzvRYwLLc4porvp6QREuLhQ6s0vnBkYOsm7rhsz?=
 =?us-ascii?Q?t2ZIyfOU9VPb7MVIYjv5ABZiAmib6p/bSUjP00Kfs5S6TdoCTnimCeYA+urn?=
 =?us-ascii?Q?6Pa61wMqqwHCljLz+jnozU6HCUX+ub1LsaIIkcphU9699+PPfTG4AJK/iNt7?=
 =?us-ascii?Q?g8ttPgMf96FU2UrY6pQZinXEkUiW1Ff3e8HkzIU4a6W5GAxUJscKl1plsOND?=
 =?us-ascii?Q?y06wLkZQQ07x57fZunSgn4zo5TtKPiEvTCng8eqGRil4kgcSBDZBkKM2X/JD?=
 =?us-ascii?Q?lABPRvNyfVpdhkRFt9WyVaOJQ1yEl6QnlNkMax76aYWW1QlyD9UNUNTH9UZ1?=
 =?us-ascii?Q?7xlHYoKz2BT4WNKn0x9riDTfnedJ3CNL/Wa60c6dY+yWhlvAm6wgg+Z2HkSj?=
 =?us-ascii?Q?altW1Mw34K6LP8g8fIxstnjHtv3/UWtNMDaESjLKaffSvDn0zS6Xdjx+ltGy?=
 =?us-ascii?Q?oi3Rn4XfwKhAcNLzwP55I+iPzcxDSRNkz1xm/Qds4vXWwbP1+tBTgoq6cf7u?=
 =?us-ascii?Q?d/JJwzYjABfn732789XYjAXigXSPWxQ8HKx0mEvTjKCViAzr1KzYHDjOJrs+?=
 =?us-ascii?Q?n2d0L6YN2XwpbZ/lTi9+BNZha/7AYSgO2XrtGCNePbhWH2mejnP4q0OWrXyR?=
 =?us-ascii?Q?nmfDzgPUicH0GOVT6Wo4HWpOQWhH3L+TzXuyadLA8yqEEa1qRXUfLrVflGmd?=
 =?us-ascii?Q?lgwhwtIpKsVQRDTLBa5PXONFG5e2jPx6ItEiakBXI4dVdSlLqE/ZY1fBJZSE?=
 =?us-ascii?Q?sHizpoM4QX1AYvpfByBRJHxXvMloYo1vkR9w4HC8QhObgXDsuFW8eI4OWL1F?=
 =?us-ascii?Q?48RvYgC9/tbXl69wNCdZBxKK0oNlQCy1c31vnGvcs0o0Gi7WgV3uunAo1ieR?=
 =?us-ascii?Q?am8llupzbxD0jd6O6dpTBqjKR8Tg9tV6QpiiXcytADAfcCL8RRABUfwJ6TY9?=
 =?us-ascii?Q?5X0DPtOn2bCapuQDkktRKL+1DtV3BDK6zxx+Zb9xGtqXLcrBy7t7j1holI9C?=
 =?us-ascii?Q?AH0AzPLnJS9HfeS1c70xdxHkVwbWn8v13ccfBPRDbjjZ+8P9tpsD2INpgK0O?=
 =?us-ascii?Q?xTdrtE4hRnGHjP30pc336UPDnH8mtDlvWEr48aebKuEHjNEP9eRYIs0baYgm?=
 =?us-ascii?Q?Aqj9HjacnkWjxd8uSFppUkk9as1ZEUykaRhyFcbmu2jqIn0N5sQeBTgtmHWj?=
 =?us-ascii?Q?Rk0qlfIApE8dYm9kDQx5vDbWrkzEEXpxsukONm6X4s0BCqcfrBxKIuC51d0g?=
 =?us-ascii?Q?T4Bi6tzDbaEPL0FReoXM6z4Cq5qfh8OORBpQKKu1AwaT4MmOChl6zmaNxys6?=
 =?us-ascii?Q?GUGWf5lPeL1RMYlvw7UZQ3QRVeRWXPAtBTfjv6TSeULvIyzb17/vLxsQxEU5?=
 =?us-ascii?Q?M621qg2ZIk89XhR4seHA92Chd6z7a5cSLDRhOYLyM5YEDfaqD888eVf4Tk+W?=
 =?us-ascii?Q?mKGBekqV60sl1q0sGsbNFwRKuB4QioRoX9wp/utL4cb4uI9DSkTA2fk0YNI5?=
 =?us-ascii?Q?1dnWZnT1qttdzXSSIFb9bv0ERhjwR9o39uP70y5M4/Gm2fPn5O2/YcnUYvft?=
 =?us-ascii?Q?Ls/q6pbXBuAl/kz915Fy1IqNDFZbL48xgpI/OzhFYPhkrWze?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6beb1744-f0e0-4322-305c-08d9a9adfca1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:38:18.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WdFty6i87FY55yJnLaZu9i2DRvYUg10Q48dWcX8GI/kjjxa0pNDj6NSEfmLDyD8uBvckYP7zZGyA94JZflzkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5807
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>

Add dsp ops callback to select and register machine driver.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/amd/renoir.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/sof/amd/renoir.c b/sound/soc/sof/amd/renoir.c
index 0241c5dce156..3cd269bfe75d 100644
--- a/sound/soc/sof/amd/renoir.c
+++ b/sound/soc/sof/amd/renoir.c
@@ -104,6 +104,23 @@ static struct snd_soc_dai_driver renoir_sof_dai[] = {
 	},
 };
 
+static void amd_sof_machine_select(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pdata *sof_pdata = sdev->pdata;
+	const struct sof_dev_desc *desc = sof_pdata->desc;
+	struct snd_soc_acpi_mach *mach;
+
+	mach = snd_soc_acpi_find_machine(desc->machines);
+	if (!mach) {
+		dev_warn(sdev->dev, "No matching ASoC machine driver found\n");
+		return;
+	}
+
+	sof_pdata->tplg_filename = mach->sof_tplg_filename;
+	sof_pdata->fw_filename = mach->fw_filename;
+	sof_pdata->machine = mach;
+}
+
 /* AMD Renoir DSP ops */
 const struct snd_sof_dsp_ops sof_renoir_ops = {
 	/* probe and remove */
@@ -151,6 +168,11 @@ const struct snd_sof_dsp_ops sof_renoir_ops = {
 				  SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_PAUSE |
 				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+
+	/* Machine driver callbacks */
+	.machine_select		= amd_sof_machine_select,
+	.machine_register	= sof_machine_register,
+	.machine_unregister	= sof_machine_unregister,
 };
 EXPORT_SYMBOL(sof_renoir_ops);
 
-- 
2.27.0

