Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D3E4558BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 11:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbhKRKOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 05:14:38 -0500
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:63027
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244451AbhKRKMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 05:12:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1sDWguXVcB7Fa3Ojonzqw5sl6WDYcB/xmoDz9vCslq6XkHVxCsHQxHMd0QPMzFOgZUZoJMi54DmSkvhwtyau+vXBAmBFENpIaamvYspp3cf8eVFCRSh1s9f++vL2/jQtg2TsOjNWJt2a95HCwSbrN2fm2y351i4JA1T7qYFh6cTNf6v5vauZTJHvFm9mdrzeP5g09jteELvRtT2wnkdoOZz3td6axQ0UKJzkzhO0ug2KVoQDto7Ggj0HRergVRRbxTKceUbZH8mN+zWCbY5igoXXa5HztleuXoA9gc/aM9Fq+WF3tIS3i2Veh90z1swndQhpzBWnK1m16rSTNCaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOwDMy3pCYOj2cKXYjxWmjMT9TIZXKzxthvh9HezVq4=;
 b=XpWT2jdqrjbFW8QM1F+ug3SwYerRMcp6Dlky1qgtNZnWJWTvoQSikeb91fdt+cDmf3pwlRTw+sJZgZ8ttJG8BaOPWggB+fmETdhCFCFt8rjnp0LTTcr4akxJNsvj5HQ5GagYPimzUO7zEwd5/flpuepHLIjml1TeWJvx14vn1dOaIM/9J9aRRZgQZreighVGccM3Wm1LAWxvB3DrMw6rMqOTDC6ZxwmKodlb1etxcDXmUzME0MqrgAMe2kSaZjHABEVoNxerfglbEoW6vcs8hvypBqQU8ZUYVfgcL4XxgmY+CAvtwEp5Xkjud6GLKYpya73VFyYXXBkgrxpyG3b+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOwDMy3pCYOj2cKXYjxWmjMT9TIZXKzxthvh9HezVq4=;
 b=XBNmYbat1SSNqAVhHgdEGOPiobLyfYlW95LFZw/wKnTR+gbMBfOG62XvTYW9y9uAQaB1BE25PCskVId4NWAmcsxKUL6le//ZwxkfgjdQICQWCeOJV2FaiNylrSQemZo3liVBdsfFnTFXwrNkdWuT0KTumJ4rYyuR32X9WAJu9uQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB4285.eurprd04.prod.outlook.com (2603:10a6:803:4a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 10:08:16 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f%3]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 10:08:16 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        linux-kernel@vger.kernel.org, yc.hung@mediatek.com,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH v2 4/8] ASoC: SOF: mediatek: Add fw loader and mt8195 dsp ops to load firmware
Date:   Thu, 18 Nov 2021 12:07:45 +0200
Message-Id: <20211118100749.54628-5-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211118100749.54628-1-daniel.baluta@oss.nxp.com>
References: <20211118100749.54628-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0902CA0008.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::18) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5706:b700:863d:d4f3:969f:6fa) by AM4PR0902CA0008.eurprd09.prod.outlook.com (2603:10a6:200:9b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 10:08:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bb75a4a-b757-4e0b-f970-08d9aa7b55f1
X-MS-TrafficTypeDiagnostic: VI1PR04MB4285:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB42857044E54E12245B2023A1B89B9@VI1PR04MB4285.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+H3P4LzcZ0fASYmPQgjpzCOqo7gtx6LCzEHBL4jVoE4vN/W7r0pFN0ArWgugT9KXXfBBzuROAMtR8uAFd5ywODzwP+GDfEaDnfMoAljYOq3eFLXOH04o9NM5wcBC/EQ0Hf9H4t+xSsBhn0TQsJJqTf5cP05yJhKMrvngYpjGTaQdcW9Lrv6CoMHkO603xKGJsOfgj26OiHDh5575vPG3popYkVTveNxflWt1trqrxAgp/ayovfxXFUGfFdevZ1jVNVrDiZsD7EtFIyybiwuWkmdCZ6fqrRzwiymWYvVdAOD4MI0tingTXipArCW8ka2RRM7x4GSlbEfoEc3whT+055MgZNf5cG4WYTbKW2oT1NlMZC7JPT+Wb2913IW5y5rdknf9+/LZacH7o4MgKwFH4LWIEacFqagfHkD3JnJrCnRnaIC+CEvVNn+lW5J+5TSqtRl+3FjgHSJUsibzE50bDn+uLIqD8c5zYQHvYILZez+I6+o0NspnVTpPB2BlKVRcOmhzD4OSrtJgdCGE4LyYeln/6nIGItYyJ1SRgeofkrC/RHaP92hCnKYS56SmrjK4yQRUdg0v3y4EyPVoBv5NwLahatLbSUQL17rY77cghq9yMXZepRJlXgKcTR2bFz8qSJ5XjQf/ghTEhjkHQ5vNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(54906003)(8676002)(2616005)(4326008)(44832011)(86362001)(7416002)(38100700002)(316002)(508600001)(2906002)(52116002)(6506007)(6486002)(1076003)(6666004)(66556008)(8936002)(83380400001)(66946007)(66574015)(66476007)(5660300002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RURqTGdOdHptMC9KL2pmQ3JqczRQL2tpcEh1TTl1VVFOWWM5SG5sQkt4YVZ2?=
 =?utf-8?B?RUdwVnBjeFVQaDhVQ25nS1ZTN2w1YmNvSGFiQVY5emd2eVhpQitWK1NuRFFs?=
 =?utf-8?B?TjY4eklMTHgzaDIrVDVvNHVncU5SWXo3QS9HaUxmNkU5RS9sMFlYK0hCT3Y2?=
 =?utf-8?B?RG9Nc0xUZnlRenBRR2pGeVlMUXU1RTNUdCs4YXRVTzlQUG4zRFFRdUpmOTFB?=
 =?utf-8?B?dVh5Q3VBYTdqRkpwMWpIWXEyZGliTmcxaXFWTDB3cWxSWk9EeW9IVVU2ankr?=
 =?utf-8?B?YUo1YjB3R3NDdTVuK2o3TnpSdk85SlRxSFRHUUNWcVhjak52b1ZxQ2xBd2FL?=
 =?utf-8?B?YWN4MWk4a3o3eTQ1ZEJ2ci85Nk9uQWFDcGF0V2h6VVcxY3pEMFRLTFQ3VHVR?=
 =?utf-8?B?OC9WbkkrQ1hEQUV0dkhPSU1qemVEYTJrYTJVakhLM0NZc1pQWHcwbzNVV05T?=
 =?utf-8?B?VlJpZWcvWkZvQ2NWNXhLaFdWZjFrUjdwbnNGVUhadWthQmpOOEI2Z09PMXVR?=
 =?utf-8?B?WU5MaEM4QWptbkp2RWdSVUJUOW1YOU5DT3ZnbFdQRnhKU0d3eFZ4VjhQb2Ni?=
 =?utf-8?B?WTQ5VGxUWDJpMWZ0aUhMdzNCWGFvVlVFVFJoQ05hbnZoK2VLdVZmdDNSREc5?=
 =?utf-8?B?RnVZYWlDYUtkd0VPRUQ2Ky9wSGlMcmk3QVErUlZWZ2NDeGZqQVpsRHB0RHd6?=
 =?utf-8?B?cDk1ZFpxalpUUXovWVEzc3hGUWVtT0orckdIUG5pZ2VYZnI3ajhmczVzTWhl?=
 =?utf-8?B?VkJORldoV0Z1M213K293bkpWTGFiaW1oMEJ4Vkt0bi9vQWUvUzlIRG5lS0Yy?=
 =?utf-8?B?V1MrdUlLYTluZFl2cTVBbHRhYzdoRjd2UjNxeXFaeHBuRFJCR2U2UGY5NVRD?=
 =?utf-8?B?NmFQaUJ3Y1NTSnZpWUhLMzMzMkphOFRUMmNhUklIODdWZS9rYkh0V3hGZ1hQ?=
 =?utf-8?B?NmtLaWgrbkRlbEpsbUx0LzB4cGFnUis5SG1BOWJpNlhlQ2tnckRKU0ptZWZw?=
 =?utf-8?B?SEpPcmxFeVVML3dxZnNNY2RVWnUvL2htRWR1b1ZmcU1INFpDUXMxdG43dURq?=
 =?utf-8?B?WDEyK0tyOGlHT1llOVJZR3N2NUFuSUEyalRrQi9ZeVZaSm41Sm14YkcxcWhR?=
 =?utf-8?B?U0hVcHZoSm5mWmU1UVhQdkpDNHBSQTVqRzUwU3hIYnozMFN2WUU2cGt5TnRx?=
 =?utf-8?B?dGRTMWl6dWVhMUJhTVlhMkdWczF0Zk5RUlZVMWlOa0g0anlaWTd5dld2U1Br?=
 =?utf-8?B?MURDbmIvcWdEY1FaeWE1aXEwaGpySFdKYjJGZ1VURmdYZUFNNlRWK1NIU2RK?=
 =?utf-8?B?UEE2U2g0bWZ5a0NVa3RhNEVyVTc4Mm9PY1FqaFFabmJCTWFmeSs1cW5xdHc4?=
 =?utf-8?B?QThXbFJWNDJVRFVvQUFQTFl0RW8xclNrTlZiZjR3ckVFQm1SeTRYRGFVQ01R?=
 =?utf-8?B?V0JaWFpSRy9tT3hEM2tDME1RbkV5R1g4YlJZdWlzRzRiSzRJOHcva3VHR3Nz?=
 =?utf-8?B?aHRXNUxWb3g5S0NKZGhpVUlBWTN4TW9DNklDSU9FQ2pSSmQ1SHFkaFk0L2Rj?=
 =?utf-8?B?d21XUEhhNk9XYnBxaUtoZ3lVaXl0U3krS0Q4L0VxOXZTUlZURWN4S3VsQzNm?=
 =?utf-8?B?QktxS0pJRWNzSi9EeFJYT3lVRXZZVjd6Tk9BNWNCdnJ2cTAzQ1gvbVd2V2tP?=
 =?utf-8?B?ZlF1SW5DU3pwek1nMDE5ZE82WkEyTjFmQk10d1h1eDdvYnEvcEtCSWVIR0cx?=
 =?utf-8?B?RktqUDdHMnFBNTBES0FjaVVhUVVqUS9xeEF4T0R6TGpNT1U0Wkx3cDdWU2Vq?=
 =?utf-8?B?bnZuVzM1Q3NabU03TktCZHVISGFjTE56L0J4YThlTWtHcTZvSzFTNUlUbUVl?=
 =?utf-8?B?SzFLMGJwb2RmcmZiUVhWVEJVRDRBQU4xK1pPRld1NDQ2SUJMRWthSGhaT0FQ?=
 =?utf-8?B?Uit6dVU3T3J6T0w0TkdWSXp3S0swbkJrbmo1SDVmR0F2eU1weElTdHpabVg4?=
 =?utf-8?B?ZW1ueGt3cE05NjdiSE9ESkxIRTFKMzk0WU1JVWF2VWVZL0Yxa1NXSHNwTU96?=
 =?utf-8?B?UXNQckxvcUt0S0Zha29nNUQrRnB1cUFZM2pqZjFhdzZsUTloT1E4M1ZtdHNt?=
 =?utf-8?B?VGFTdUpMbTZ0bXJzUld3dkxZaTJ6M2FEQmFxckVuN3JjMUtjejhZYWJiYjF5?=
 =?utf-8?B?UTQ5Z3VOU0Y2TG1HMW5iNks3blcrd2hWZHp6RjFoRWxZUklXQnlpVGhMN2g2?=
 =?utf-8?Q?jlSYPiG1YrOg6PpgukDmpqlLDRa7fzfNDxfvqjhm0Y=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb75a4a-b757-4e0b-f970-08d9aa7b55f1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 10:08:15.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1qCdBtU+0R9i/UufcCsvyE4Eg9KsYVfZ5OMCat0Mgm5cFdwQ9ydToLt5mEzIupE4Y4yUKukFhTogBPEG7sung==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4285
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
 sound/soc/sof/mediatek/mt8195/mt8195.c        | 19 +++++++
 sound/soc/sof/mediatek/mt8195/mt8195.h        |  3 +
 4 files changed, 79 insertions(+), 1 deletion(-)
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
index 966b8660e21c..88da6c2de070 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -198,6 +198,17 @@ static int adsp_shared_base_ioremap(struct platform_device *pdev, void *data)
 	return 0;
 }
 
+static int mt8195_run(struct snd_sof_dev *sdev)
+{
+	u32 adsp_bootup_addr;
+
+	adsp_bootup_addr = SRAM_PHYS_BASE_FROM_DSP_VIEW;
+	dev_dbg(sdev->dev, "HIFIxDSP boot from base : 0x%08X\n", adsp_bootup_addr);
+	sof_hifixdsp_boot_sequence(sdev, adsp_bootup_addr);
+
+	return 0;
+}
+
 static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
 {
 	struct platform_device *pdev = container_of(sdev->dev, struct platform_device, dev);
@@ -294,6 +305,9 @@ const struct snd_sof_dsp_ops sof_mt8195_ops = {
 	.probe		= mt8195_dsp_probe,
 	.remove		= mt8195_dsp_remove,
 
+	/* DSP core boot */
+	.run		= mt8195_run,
+
 	/* Block IO */
 	.block_read	= sof_block_read,
 	.block_write	= sof_block_write,
@@ -307,6 +321,11 @@ const struct snd_sof_dsp_ops sof_mt8195_ops = {
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

