Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA464543F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhKQJnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:43:52 -0500
Received: from mail-vi1eur05on2052.outbound.protection.outlook.com ([40.107.21.52]:28352
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235496AbhKQJnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:43:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IATM/a3SxjyiPOC4YS0ydwfPxklZmvXxEq8I5Ww3oZlFOtF9XjFI2p+FK4fsunF+gILp7/phAaEeKAeVQe3QWMghDok9A7p9aGScRq9O9VvygK6GCPzkeKMboh69mBtimlF6cnQrf1ffl6C65ESrfT/Lt0HURpIXf/AmPN7ILViJc6TXfsxYjLOyvxyObPhynjANWxvyAavNKd1RwD6FFS5zCsE56d090bVWi07IinIy9csIxwZMLrnHL92MX/3OTvPgxPMPLgdkJDkk2ZjXjeej2+2mi6LJZFuoXvd8AmcnZ7VRgMwlatsdWyFIXGqRtP7ynMMsdSIl3aiohKJjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AVYMsqdqT5aML5ASjU1X5aJtq7rcirF8wH6DONBBzQ=;
 b=JmDNoEryvPFZAs5wXjT5Febf9C9B4kUgm16h+nEdP8RY3H3nJZ1QJmQxqP28Vxa2RrYUBSPORujZx4C4qyAWdq9YkAA7U2h2nriS/uESgXBedi+lbOYEYdQMsWsSRXLZF1/tPRp3EnPD9pO+cC0G2K2FRlaUnBd0dQoecrd5nsEvzs3uznvwN5PaOacOIzFm/J+C3apvFXIx1ELJ61qKNt70+OBVL0AKMZuEa1iM+xNJNDZNtIgg5QObUnpMEdhNIAZESMDfXns+rZPUAvwKzzvdfEAGWijJ4dRQWLEB+1WQMNBhvEzybF9bz8e+xhMVUKm5l06eSv3pVtx9ttOCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AVYMsqdqT5aML5ASjU1X5aJtq7rcirF8wH6DONBBzQ=;
 b=IYgNiZdjv6oxwKwjKQXV+xWQqPvUi4d5wW6zT90abbI3QN+iTnGOeJQDvxO4zO1kXo4VrnC9RQPI9ulzgS4p+vhMYUzwa/fSxQDBtYuwViqAjoIyJkKAiNu64BbqC1xHHxnTfYecEZ/sR6fH4ex6byL6WCiHAAGdYVM0mNReNO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VE1PR04MB6623.eurprd04.prod.outlook.com (2603:10a6:803:125::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 09:38:36 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 09:38:36 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        AjitKumar.Pandey@amd.com, Balakishore.pati@amd.com,
        vsreddy@amd.com, Julian.Schroeder@amd.com,
        vishnuvardhanrao.ravulapati@amd.com, linux-kernel@vger.kernel.org,
        yc.hung@mediatek.com, linux-mediatek@lists.infradead.org,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH 17/21] ASoC: SOF: mediatek: Add fw loader and mt8195 dsp ops to load firmware
Date:   Wed, 17 Nov 2021 11:37:30 +0200
Message-Id: <20211117093734.17407-18-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR03CA0060.eurprd03.prod.outlook.com
 (2603:10a6:207:5::18) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5706:b700:22bb:b216:ffff:73e1) by AM3PR03CA0060.eurprd03.prod.outlook.com (2603:10a6:207:5::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 09:38:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49bc8cf6-098a-4eb1-f4e8-08d9a9ae0775
X-MS-TrafficTypeDiagnostic: VE1PR04MB6623:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB66232F469A3B34847B84B5CEB89A9@VE1PR04MB6623.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Zssx2x38gZVAe6zZj6cLZ+a9zFTMRQlInkH3mvO049NZhrK7RgwKE+R7sKIs3NeoxX70TzlupTk6+slgYAVSh3fwYb0Jm2rpm4zOc+RpLR+faj1PPzeU+tFCERPe5t3QISylWZD2IzqiHk/JTbrhIx//DvLo3sMNEtwQhPoafoFgCLAAnIEkRJ0uiKkJc9D9Lj6wRU7bMn1NpBVliOMhI3YPUMaLQkIokrm9iEEp4aT8P+RXvE631FauponxAcxlO2Y+riplRCiJo2FdecMShc29VjNQQ0EQQ4YnDct5L628sFinYOqg7+lMaOPrnIgZWLuFN8AQqzpJF//lVI6WA4rFaurZGEdcehb7ACfEO3WaDPUCkWe1HqH82wKJQSsAWYVGJaT316IEGgnFp+X/DY+xBTXa4DDE5911xEtsdMFIVi+rHjpyYnSC+mixsUYQQPP5K1Lnfa0B/RB/UTsX4g1cs+psgwuiy/FtrEf8aoZf7Tg/3w09mRdgX+IMP5OsctU1HOR5TYS7/OFdOcwJn/2ttzjnLe3wx4stBU9qos8ac3OqdP6OAHpaP8Y8nkrqxatGGPO82pP2N3T8vdRRrE2LekkOv+XITfMNIYhXCFpyo5ITIvuFNM8f9H3aUI2diZBGN81LKcPKsjEc0GRjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(1076003)(52116002)(6506007)(5660300002)(54906003)(8676002)(508600001)(186003)(86362001)(6666004)(2616005)(6512007)(7416002)(83380400001)(66574015)(44832011)(66556008)(66476007)(4326008)(66946007)(316002)(38100700002)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5GajFvV3dEZGp1M2xYaGt6ZGVFaE0weHM3ejhpVTJmYkxHQW0yY2t6cmtS?=
 =?utf-8?B?OXJ3SjBPVEtGWjQwTmhrVEt3bXB3RjlFUlVWWVo2RzE5WlhCczd3WG1DZ2Fj?=
 =?utf-8?B?dFFWWWFFekZkQ3FZeURRQlU2ZUQvNytESkRwZ3V0MUVDWlIyT1RnRkVZQWZM?=
 =?utf-8?B?S2pkUGlUOU1BQWVsbVZYL0xqSkhiSFBYOGNKLzZLWG9VbHNpaGtER2Z6V0ph?=
 =?utf-8?B?UVBFeEFOZVhEbnpTelNKeDFTM2NDb2hnZG5YK1lsZkpCaVE0eGw5c241d1BE?=
 =?utf-8?B?OUIxNjk4RENHeFBhclJpeW14RWdIckJWSW9oZlo2S2svRkxPbTZNZ255YUNW?=
 =?utf-8?B?SkdRM1pQdVl4ejFlUlFMNkdlaVlwUEN4bDJXcFZNU0dqRW5PNU9nUTZDd1Vn?=
 =?utf-8?B?MFlsU0toMVFjV0I0Y0pheDUwQTJURmRPMzVEcUJxRzhkaDZoa3lDVWwvUGs1?=
 =?utf-8?B?OHF4b2dGenJNaXNFdjI4RHB0S3M0ejV3K2gyUFNjbWd2dVU1eHljdVpTSE85?=
 =?utf-8?B?aFJIOVBMdFNqcnRhTGpBZjlyTDdCdEwwcU1xT3ppRG0yNEdFUk1SQ3ozSktt?=
 =?utf-8?B?WndBRHdaM2ZiQ2NHWmdPNm8relFNVEM0cVUvWnc0cWhPekpYYXRZTkdacld5?=
 =?utf-8?B?cWtMcHBDcENSVlV1d3piWi9nRDBabG02S2NHY1BpSFFMRmhwT005dk9iVzhF?=
 =?utf-8?B?Qm9jZzZUTUJueml5aE5vY0c2VWtQRWFmU3pFbHVoNFlIbXM5akMyVThQcjh4?=
 =?utf-8?B?WjVlbU5Cakt6WGZSb2tFR2duTnVXQ1I2a1FneTBkYlFyOXlEcURhRll1NnBi?=
 =?utf-8?B?NXJNaUJSSmVwWEFpdzdPZndLK09EcCtpZ0FMN3l2MFNSZC9KWHlXUUJEZFA5?=
 =?utf-8?B?REVFWWZWVkRFTXFNYlBmbzBDNW1XcFI4ZUtJTjVTRjhFQWFMdlllL3NuQWQ0?=
 =?utf-8?B?U3RwNFpZYUJ6K1RYSE9lenk5QUZZVG1YNWxZSkFCdTZPU0JoWjZnWitCc1BY?=
 =?utf-8?B?VEFmcmMySk0rbGwyeGFZZDZ2bDJ6V3R6TFd1WnpmV3RSdFpucGZ3NkJjdmdh?=
 =?utf-8?B?Q1NEWlEvNjIwVFJOTzZJUU54VFRLWEYzRmJUWnQ2WTUyNzV1RTlKamlqZFE4?=
 =?utf-8?B?ODR6R05uVW9Wc3B0TmpvQ2NuVmFFTkV5dGpxSlA5Skt2NGk2Y3Y2akhrYUk0?=
 =?utf-8?B?eGJ4SXV4L3FLYWxLYUt2YjhxV2FHczNrZ0p0U1A0NE52d2ZLckxlc1NxRklB?=
 =?utf-8?B?cU1PMHBzZHVlWlFYa1gzSmtkOXVyUTJjUFZaVG9pKytDcXAvemhiQnZoVWE4?=
 =?utf-8?B?ZzhMUHNFS1BGWE9sem5pVlJnVTAxdDNhdkpoUEJpZkVTSmJBa2ZXOFVsT1pU?=
 =?utf-8?B?akg1dEpRSGphOGZ2ZFUwbHhJeEw1d042cSttRVlVWDcwT3QrSm1IaEhSb1BC?=
 =?utf-8?B?NVdtTDZjdmFackNXN2p2b1BvREJWZWRDZUlraE84N0hXSXVFQXpyTkh4S1JW?=
 =?utf-8?B?dlNTdTJ4K0FrTkZJdzhkR1JZakVuTUZBUlpNd1VJZnpwamE3VXI4MFRsWlNT?=
 =?utf-8?B?K1ZoZGp6U1JTUCtJU0lXeEZaWmdPOWo4RDhPbUpza2hlZ0s4OVBKcmY2NVBj?=
 =?utf-8?B?WXZST1NWbDRGbjkyRndxaHhFRWpKdGhoV2pwcExZOGJZWEZrbHBCcTFuM294?=
 =?utf-8?B?ZGhtRHNTdWp1Y29Yc3hDazd1OTFCUDFWZXdtVWtLYmxQY1BPUVB2a3lkMVJo?=
 =?utf-8?B?RjF3ZUxGYXU4TnFqQkxFZ2hOdy9KNWxwUVQxQVhvelF3aWxoeS9SNm9FN3lO?=
 =?utf-8?B?OVh5V3NJR0RtOEVJV1U1UHJaTHRwZlI5ellDbGY0cjZMNnRDd3JKN2lEeEQr?=
 =?utf-8?B?bDBIQUZQS29yTWRGWitsWTVNcHJSR3BKVWF6YWVYYTZNOFM2SGFRNUhOeEYy?=
 =?utf-8?B?dkVXeXR3VkhqenFsMzdDYzNQUGVXMWU3akRTUkVJblZIcy9sMlBXQldkOTFG?=
 =?utf-8?B?K2x3MVlsSHNkYi9VUDNtbkNNVEsvcFJDOXJJVGtjWGNuckNyaXFNalFlSkUr?=
 =?utf-8?B?clUwOWovRDF6RTMwaGNlbzl6V0dJUlcrK1ZoR2NJTTFPMmNNS01yaDhMNjZH?=
 =?utf-8?B?Y2hnL1BzOXp0bzhoZWtpckcwOUg4ZEJIOWxoNkNQeVdBdGVMQ1ZPTkYyRTMz?=
 =?utf-8?B?VVpzUitLUDFhRDVHWkZnRUNEMzVtSGh3Tmx6ME9XV3RKd2pMckI2OFVjcGNE?=
 =?utf-8?Q?V+T/iFTHuA3undb5kXd7XX6d3Ka4X0ba/ArpVYEyHc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bc8cf6-098a-4eb1-f4e8-08d9a9ae0775
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:38:36.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP9tkuGD0GuMz45ibjLTmWQEoLuRtSN+bp4e8jSdsfEvGtTQBGppIlZ4IehNr+fDEo41S37jZu/i1GR84gijMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6623
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YC Hung <yc.hung@mediatek.com>

Add mt8195-loader module with ops callback to load and run firmware
on mt8195 platform.

Signed-off-by: YC Hung <yc.hung@mediatek.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/mediatek/mt8195/Makefile        |  2 +-
 sound/soc/sof/mediatek/mt8195/mt8195-loader.c | 56 +++++++++++++++++++
 sound/soc/sof/mediatek/mt8195/mt8195.c        |  8 +++
 sound/soc/sof/mediatek/mt8195/mt8195.h        |  3 +
 4 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-loader.c

diff --git a/sound/soc/sof/mediatek/mt8195/Makefile b/sound/soc/sof/mediatek/mt8195/Makefile
index dd2b6e4affc9..66cdc0e7bf3c 100644
--- a/sound/soc/sof/mediatek/mt8195/Makefile
+++ b/sound/soc/sof/mediatek/mt8195/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
-snd-sof-mt8195-objs := mt8195.o
+snd-sof-mt8195-objs := mt8195.o mt8195-loader.o
 obj-$(CONFIG_SND_SOC_SOF_MT8195) += snd-sof-mt8195.o
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195-loader.c b/sound/soc/sof/mediatek/mt8195/mt8195-loader.c
new file mode 100644
index 000000000000..ed18d6379e92
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8195/mt8195-loader.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// Copyright (c) 2021 Mediatek Corporation. All rights reserved.
+//
+// Author: YC Hung <yc.hung@mediatek.com>
+//
+// Hardware interface for mt8195 DSP code loader
+
+#include <sound/sof.h>
+#include "mt8195.h"
+#include "../../ops.h"
+
+void sof_hifixdsp_boot_sequence(struct snd_sof_dev *sdev, u32 boot_addr)
+{
+	/* ADSP bootup base */
+	snd_sof_dsp_write(sdev, DSP_REG_BAR, DSP_ALTRESETVEC, boot_addr);
+
+	/* pull high RunStall (set bit3 to 1) */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, DSP_RESET_SW,
+				ADSP_RUNSTALL, ADSP_RUNSTALL);
+
+	/* pull high StatVectorSel to use AltResetVec (set bit4 to 1) */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, DSP_RESET_SW,
+				DSP_RESET_SW, DSP_RESET_SW);
+
+	/* toggle  DReset & BReset */
+	/* pull high DReset & BReset */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, DSP_RESET_SW,
+				ADSP_BRESET_SW | ADSP_DRESET_SW,
+				ADSP_BRESET_SW | ADSP_DRESET_SW);
+
+	/* pull low DReset & BReset */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, DSP_RESET_SW,
+				ADSP_BRESET_SW | ADSP_DRESET_SW,
+				0);
+
+	/* Enable PDebug */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, DSP_PDEBUGBUS0,
+				PDEBUG_ENABLE,
+				PDEBUG_ENABLE);
+
+	/* release RunStall (set bit3 to 0) */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, DSP_RESET_SW,
+				ADSP_RUNSTALL, 0);
+}
+
+void sof_hifixdsp_shutdown(struct snd_sof_dev *sdev)
+{
+	/* Clear to 0 firstly */
+	snd_sof_dsp_write(sdev, DSP_REG_BAR, DSP_RESET_SW, 0x0);
+
+	/* RUN_STALL pull high again to reset */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, DSP_RESET_SW,
+				ADSP_RUNSTALL, ADSP_RUNSTALL);
+}
+
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 945601a0dc37..88da6c2de070 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -305,6 +305,9 @@ const struct snd_sof_dsp_ops sof_mt8195_ops = {
 	.probe		= mt8195_dsp_probe,
 	.remove		= mt8195_dsp_remove,
 
+	/* DSP core boot */
+	.run		= mt8195_run,
+
 	/* Block IO */
 	.block_read	= sof_block_read,
 	.block_write	= sof_block_write,
@@ -318,6 +321,11 @@ const struct snd_sof_dsp_ops sof_mt8195_ops = {
 	/* misc */
 	.get_bar_index	= mt8195_get_bar_index,
 
+	/* module loading */
+	.load_module	= snd_sof_parse_module_memcpy,
+	/* firmware loading */
+	.load_firmware	= snd_sof_load_firmware_memcpy,
+
 	/* Firmware ops */
 	.dsp_arch_ops = &sof_xtensa_arch_ops,
 
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.h b/sound/soc/sof/mediatek/mt8195/mt8195.h
index 48cbbb5aacb5..929424182357 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.h
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.h
@@ -10,6 +10,7 @@
 #define __MT8195_H
 
 struct mtk_adsp_chip_info;
+struct snd_sof_dev;
 
 #define DSP_REG_BASE			0x10803000
 #define SCP_CFGREG_BASE			0x10724000
@@ -152,4 +153,6 @@ struct mtk_adsp_chip_info;
 #define DRAM_REMAP_SHIFT	12
 #define DRAM_REMAP_MASK		(BIT(DRAM_REMAP_SHIFT) - 1)
 
+void sof_hifixdsp_boot_sequence(struct snd_sof_dev *sdev, u32 boot_addr);
+void sof_hifixdsp_shutdown(struct snd_sof_dev *sdev);
 #endif
-- 
2.27.0

