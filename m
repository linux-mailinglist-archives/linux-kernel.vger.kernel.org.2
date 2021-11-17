Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41E4543DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhKQJlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:41:22 -0500
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:35585
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235361AbhKQJlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:41:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buy2PEMKtpjCdCwzoFpDuUG7+Px8GyRkkLprT73RyxpLtHQ2C4fk6gM6fOBaBNpy3CUw1Z6fLbVP7wNGLSMKYYw6PafSKlQRD5E7NKtYbzvhTEnctfVQX0+aJLKkYo1al2bwzSV2xRL7tWUICQJj1rrNij7jkRc/hd/fN1gMKS/AVHyDnWIcgtXCxJFZqmzGUMXvYc6glwo3XpHdTN0BW0+NTshbFpNFQF9QD4uGffdXrVvw+ic9oW9VAUcTiT53vKvYP/CDARFdjmPb1KpUGYPVPVVi6Ln8YGNjR7VC/+AHA7RcqyLUmZvOEdpEF6O9LFOD2RADfabm3jmvXdpuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE2DuIgSwafx0IAlBrYGbF4rgLWbl+ebjRJgRANfPik=;
 b=fAOjuEvTwq1xItrSg04YrmMcCQ4CVJEoZqoHwusUPIYuFYnTtp4oY0IUECAY/eksdsd2mQZ3bHusN2IA/vdlQVD4e1Snr4H5z9jrtLUR5Lv+mC8A8UfCWeba3VKgya2OaTYzxFQGnZYqnD3k05cgVhDsRVMnRpW078yMSQziX60s6jQBwCh6YCU6LQcknPDk7rxzYfFqU/GWazp+onQt7q9P0x14fYsAHD6WG5eq74OpIDg25C+zXTSLeQztzpELfqHIE8ep+DEmn8vnoiSOKG++iPYuv2qGAn3py3+qCQDMr2riJmWWEgKIf22GkFCTTg28zuTkW2G9nhhzJ/T/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE2DuIgSwafx0IAlBrYGbF4rgLWbl+ebjRJgRANfPik=;
 b=ATKNykq9tsyOR8PnQeLlAZO2d6RDNHS+S+DQtoCbrGYKrH8zkAJJvSbzzIpjAnNx0bpmBtBkZrMn2vRXQKTi/i4PijvEvMKfAVQ/Vtz2UKYXj4jZtzrURot8hDuXEdm8k56Dq0bj2/ukKN2OJ0erVEiP/hg23YfVgNrXX7Bn++I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 09:38:13 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 09:38:13 +0000
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
Subject: [PATCH 05/21] ASoC: SOF: amd: Add dai driver dsp ops callback for Renoir
Date:   Wed, 17 Nov 2021 11:37:18 +0200
Message-Id: <20211117093734.17407-6-daniel.baluta@oss.nxp.com>
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
Received: from localhost.localdomain (2a02:2f08:5706:b700:22bb:b216:ffff:73e1) by AM3PR03CA0060.eurprd03.prod.outlook.com (2603:10a6:207:5::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 09:38:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cecbaa9d-6ee4-4130-c28d-08d9a9adf94f
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB58078533EB27B1614884BD5BB89A9@VI1PR04MB5807.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2J2CoGVWRcSoc07vWp9IN+1kzMn3jdXuGoXuvaO1VoPijl7o6xEMcPwrhDrVW/ue4GA6aBR17T6XftR8Z+9iQK/zqwyTijgMrBnpXEieo4l6fgIldaFEpnKaivqrI+nlXWnaz0/AM2liST3hGlzw95mj3tIUbvJmz80PCX3Omnxc5bUgz66GO4dIbUEHZvKNfD1jsVLY5GDyglyeYtLLM2RK/yeavLadibNZI5Y+z5moqaJt9RvbyAAg47rG68bRcccomRkqPSOVO86aDN1tdzw//NC+M8bydW6M2kx0Tmvkm2o8/v8fDXft4zEaD8P+7YXIssV5jC0gFUe/DBI/ucpnhyuZNR9+EsCgD0R1Shnw4uC5ibtF43SE+P8wBhrdOTUUdgzSTGEXcmHMipVmqZK4tw/85uwCZTzYP2tH1lctgbVp9QgWZ6vC4V9MA6Jd3pJGxb1paTqUiRHK3YcBDxGmO59nb+bsiQ4SDdv3vEbJXrvgMJ4/IBMLdz43KmATISWBiaANEf3TSR1AAcMPgDNOVzpBEIOvQl/smdW/xkGX9kbAbpTfmQGaXgGUgNjjCNE+9BVk+GNw6pGcJ/IXDtg8G9QLGeE9Iqz3f3AP8bd0+VzpFzS2Zwglar8uSR2wMkM2PEnYYQin2kDhOd0FZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(5660300002)(508600001)(52116002)(86362001)(8676002)(54906003)(8936002)(66946007)(186003)(6512007)(2906002)(6486002)(7416002)(6506007)(1076003)(2616005)(66556008)(66476007)(44832011)(83380400001)(38100700002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mk+4TpztP4jRpq3rdK1jzO9B1WRK0B+oS1ozYDNgCJQr058YQtTfWjiSJTKz?=
 =?us-ascii?Q?iWO8WLK4EwdJf4XHx2D6IUUyCH9MxEZEXfO3EH1j5a8vTw2ZuSXCUNecJAlI?=
 =?us-ascii?Q?gybdCWqqLHXEpKwr7Ch/tbkPAomo61/IVGkbO68a+dpPoKtRujz20OfjurYr?=
 =?us-ascii?Q?/LUaHljx+y7njhxjEp39PhjBnJwLHmBAu5dpt3dbwzGMSZwQBeJqig0rgcLi?=
 =?us-ascii?Q?t7hWtIb1NV/ij/0wECeUzWYaRMKZLIDrp3uan/wqF81UkUwTmUG9BCMDxJnT?=
 =?us-ascii?Q?WOSn6ZouLS3SExmKZJ5+MhFmgGIaZ6xfnw9U/58/T+xcrdk3ijU8O7YFYhxR?=
 =?us-ascii?Q?i5/8ZeT5+AthS91hzv42oCZWUywU5b2f2hYlhKXNjuP3EpEel8iVhUU1j1BA?=
 =?us-ascii?Q?HUjVtQvOgNMcGMXu/yer+lXo67OVIHrWDht/HVtSntsCqwzaOLFuVpSoc8hl?=
 =?us-ascii?Q?PEJ2+U2HhZIUmNN7XGfzsVdF1i3PDfOwnOLHRmTcuBJKmrA1ytRHAIL5C+F4?=
 =?us-ascii?Q?i9H1T0JUnWlgEHXgGmqcZumgYP0rgieIuvC6uHd1V+OY1f1sOtrSt1LgOGSt?=
 =?us-ascii?Q?+TRtgykWbfSncXe8D7nYIgPRU5RfRhaAqBfQKmMukhp9KqSHZVKCpTTtWrqw?=
 =?us-ascii?Q?uTbtRT/CC3udVahdNr+TQDVGDaPvE2cLvrtaRsVGKyXY9754BAosmAaM2tut?=
 =?us-ascii?Q?nakNFZUdpfFW23ysLAD/LbFYV3lVrHBcIGO0eF2IQZiQQ9Yt+xdEsc8+6vav?=
 =?us-ascii?Q?fdzYmPj7Z9SbPxP5m1ljQfoEUKoxET1AHLhx/R/TLxMYtTLYbxE0+hDDQ03H?=
 =?us-ascii?Q?yy32ahH0+oHEoG8gP8j0uMdK2am1tlApSzPfep46cqKyqSOVndguOS9Lw0A1?=
 =?us-ascii?Q?yqaZhgDfULoKvNSnutmFBRa2zKGW9o+sO1canlq+ABnhn7p1LL8z5/gUI3pS?=
 =?us-ascii?Q?eBfaSB+MQe2rz1TyYzWPwnxExcwFYQnZUfOCtmlBM+76+G4672CpFpXMmWbJ?=
 =?us-ascii?Q?3XzGkSziAbvNrnRttD/3gyJ1Vfs56eG7cqqJKT9ITtrYBFksETKRE0SY/wAc?=
 =?us-ascii?Q?wjMye2V7MCSUoCZKoNyvIgKQGhcuYvwOTuVB4ER3sCQsXtQno5wR1KzCg2Tz?=
 =?us-ascii?Q?u9QQxjo0NLOKuVK0d7r9pFsLowoVtB/Xbd8oj1AIRwQen3l03i8Ay+ikmODE?=
 =?us-ascii?Q?AwTVFw0NoO4u0wkQNWHY5tkEEIs3OqHIThIvMnvqpmIxBk3JXmJrH8pmavIB?=
 =?us-ascii?Q?yae0B8DnZdkEl+hgNhhmoZsQ7XvC5RuG0yeaMnD15eCGDBvByva1w3M/n8Gx?=
 =?us-ascii?Q?jPc2ic62kdJw6lOw+9JnaVH1IJuUyn4t87VFW9PdDX4vIG0NH8Cxz1BwIjh5?=
 =?us-ascii?Q?o24GhXQZ/+56NCLH7ckrVL1T49XC4YksojsZ2djBdviYUNnQvJI9LIedLrBU?=
 =?us-ascii?Q?SSO7eL5KhhiSDbOkzmTqlF/p1zR3oexzQ84yXJZqN5MXCRRB1sS8nyDNTYqW?=
 =?us-ascii?Q?xtlfvVgCEHMdlyP86hBq06m28HMXqz4246fe8V2RpeCsj2TxF9LYmMcJ+gsT?=
 =?us-ascii?Q?a+STtogBCjk4WFpg7Id5/DQofqjtqbEwBWGVeD8o92vR612afQZqlMin/pZ+?=
 =?us-ascii?Q?xAl06accz3god6jPeRfdCU4Jd0HMl9LPeR3JLHA4lzRpBe8WKPgqnJEofXYH?=
 =?us-ascii?Q?TWT2i6GIH+d5iVm3A3k7KHoQH62t/WVZSv5TtTizyC+HRvDG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecbaa9d-6ee4-4130-c28d-08d9a9adf94f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:38:12.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roKnawi7Gd2JH2mxdS7IX75WDvZjrx8Sf8bWVEdZ1VVY78mvM5qHzsZwJ0Nf6y2fLUICG7JhViatDUiLwaw5Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5807
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>

Add dsp ops callback to register I2S and DMIC sof dai's with ALSA

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h |  2 +
 sound/soc/sof/amd/renoir.c         | 91 ++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index 3a1c848020ca..1d11e9d69dce 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -47,6 +47,8 @@
 #define ACPAXI2AXI_ATU_CTRL			0xC40
 #define ACP_SOFT_RESET				0x1000
 
+#define ACP_I2S_PIN_CONFIG			0x1400
+
 /* Registers from ACP_PGFSM block */
 #define ACP_PGFSM_CONTROL			0x141C
 #define ACP_PGFSM_STATUS			0x1420
diff --git a/sound/soc/sof/amd/renoir.c b/sound/soc/sof/amd/renoir.c
index 9d95ea66f867..ca5582b3f82d 100644
--- a/sound/soc/sof/amd/renoir.c
+++ b/sound/soc/sof/amd/renoir.c
@@ -15,7 +15,94 @@
 #include <linux/module.h>
 
 #include "../ops.h"
+#include "../sof-audio.h"
 #include "acp.h"
+#include "acp-dsp-offset.h"
+
+#define I2S_BT_INSTANCE		0
+#define I2S_SP_INSTANCE		1
+#define PDM_DMIC_INSTANCE	2
+
+#define I2S_MODE		0x04
+
+static int renoir_dai_probe(struct snd_soc_dai *dai)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(dai->component);
+	unsigned int val;
+
+	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_I2S_PIN_CONFIG);
+	if (val != I2S_MODE) {
+		dev_err(sdev->dev, "I2S Mode is not supported (I2S_PIN_CONFIG: %#x)\n", val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver renoir_sof_dai[] = {
+	[I2S_BT_INSTANCE] = {
+		.id = I2S_BT_INSTANCE,
+		.name = "acp-sof-bt",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S BT controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+		.probe = &renoir_dai_probe,
+	},
+
+	[I2S_SP_INSTANCE] = {
+		.id = I2S_SP_INSTANCE,
+		.name = "acp-sof-sp",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S SP controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+		.probe = &renoir_dai_probe,
+	},
+
+	[PDM_DMIC_INSTANCE] = {
+		.id = PDM_DMIC_INSTANCE,
+		.name = "acp-sof-dmic",
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 4,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+};
 
 /* AMD Renoir DSP ops */
 const struct snd_sof_dsp_ops sof_renoir_ops = {
@@ -49,6 +136,10 @@ const struct snd_sof_dsp_ops sof_renoir_ops = {
 	.get_mailbox_offset	= acp_sof_ipc_get_mailbox_offset,
 	.irq_thread		= acp_sof_ipc_irq_thread,
 	.fw_ready		= sof_fw_ready,
+
+	/* DAI drivers */
+	.drv			= renoir_sof_dai,
+	.num_drv		= ARRAY_SIZE(renoir_sof_dai),
 };
 EXPORT_SYMBOL(sof_renoir_ops);
 
-- 
2.27.0

