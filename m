Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB5432F08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhJSHOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:14:05 -0400
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:41777
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234421AbhJSHOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:14:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggNlj0JcFeFnrNqlSQX7pkMh26ssbZBbnhv6tOXbm4xXkot2kBV9VOa/fpRI0mT97cytnnUS3ZTjqGRFjQ/XaRPqWUi7bsOu5ELTBP9DAGWF8WNRD9e0T+hJZTW7i3PNi2EUe05ZtTDF6DByWqt8/7GKh9GC7FdL8BCNdXsQ9EP40hOV8Ho7yY/vAOrFHVHMdsQ6RnmBh7bckNU6WraakhM8SuvMlBi9+gpP75dVraccv0Wv/LI51yuZEsgLrD1i8YjIpK6UBb4zbnnwTyVaC5PSjqhlrj+QMARCsPpoN2iFhvOhbB0/0vk1YJCHOGDlUKGcGLsKFLEHef7izJfC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp9+/T60npn8MiDgW42oViHZIi2L3v0UHINUjZr/Gsk=;
 b=EBkViiO/iJiHNgHnSIcVmu6HVq0XHEeXPnDZiTtiBnrqm4iUhcjH1EGtlYTQTRelFUHGzKvt0mptZaZ/H8BJ1/ejpA24VcrvZWlt6lMkSZ6O8Q3cMGL7lula18Di9M5Idh8bX5B0s4p2z/ag4ekdvdPapKgTKXKvXmdS85FzeLbbcs7MwLu/yglkNje6XukgmAvFjMnZU6ZusxY1oxDxthAdAd4VC2vaKjxByD2Fd3TDGjN/G+tG8aLnEQvU8YaUeC5W4e3PWjRqST6cu/mudvWvYJX91XrO7xbLKCNf2BlPXiHvD40LG/2NgnfK7x49GpN0nRlczC1EE8kwMbIQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp9+/T60npn8MiDgW42oViHZIi2L3v0UHINUjZr/Gsk=;
 b=pyvuOljVjQalnfOyuP+TD+LeS9lv+xqwUF5VKIu0lnG3X/RhhiQViiNog11tQNio6/Oz6WuxqIRUQ7YWVVwTtQ7+eAbqj3K2taVsnIyyzlP09rsAmFmvg4jFSMd1ID6oy8eISF+JWVZ0sCGz752rN9UVAsEAuwoLF+DAlroY3WA=
Received: from DM6PR02CA0056.namprd02.prod.outlook.com (2603:10b6:5:177::33)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 07:11:47 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::f9) by DM6PR02CA0056.outlook.office365.com
 (2603:10b6:5:177::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Tue, 19 Oct 2021 07:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 07:11:47 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 02:11:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 00:11:45 -0700
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Tue, 19 Oct 2021 02:11:41 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/8] ASoC: amd: acp: Add SOF audio support on Chrome board
Date:   Tue, 19 Oct 2021 12:39:36 +0530
Message-ID: <20211019070938.5076-7-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019070938.5076-1-AjitKumar.Pandey@amd.com>
References: <20211019070938.5076-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ed3d68e-d7fb-4e6f-39ba-08d992cfb6db
X-MS-TrafficTypeDiagnostic: BY5PR12MB4999:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4999558DD79435A7B1F222CF82BD9@BY5PR12MB4999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+qj9/jUTcLjindZNfullKHOmlsPpbJNMx7pcqvWuIMFFnedR0vLJZvQZBRQO4/UG0ehj/+/U/zuTNqIeV4Pm+h05ndnfziAWZYgNMV+9ZKflK3D3oG8n8Lznu2v388/4PW05ikfJqdjGiChNmGK6rB35HISKmbn0HhVI2DEOA+wd2jSFlLmOZiA4ECklHPioaaes5vtnPRwLzuenIuDlbEjqBmr7BUhFbbk7xIRPEr4rvbhT0OdHlsLMZTNSw5/C/2+6fQB2LNbA/kLw2ibbn/19IDfJzpcaaqMsgYW6mpD+XnF2nnUNZneuIMJAJcWLAFs786nYQfqyM0DN3LjnBdm4lSQt3a8PCQ4MhXDeApmYYTornePCUPIQG5DlzjWQ7yiA1PKLOR0sjUoI2Bb/a6AT7Xd2IsvR8xbyKMZw6AaaEs4qMXBxTVhJwEoRj1YeVVfID9UwR+9ZYqhQpveycS0qn3afPonUCitJdQFReNUqCKgY62ie+NIqXU+4HQUse5GmRXTElgD0rYsasul4qpqNIxXxHQNjAdbRBFBoGQ38TzViPY0B7la1uWhKAlMUAztQqr4zCU4zuWiDjdC3F2yIpX3ECWbIjDpxjAlDXbEsUIOl/SoqKL/CORrdppt4yB9xzlvSbhtDHd3iL1Qs5xjeeTpTp2TxilSdevk6+CLN813phOHy3xY70c3gBIDHxXRj3ls5/cFrowJzGom2N0kfdiu9PNd2HDKuv5imdE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(110136005)(83380400001)(82310400003)(2616005)(70206006)(86362001)(36756003)(26005)(54906003)(1076003)(4326008)(70586007)(2906002)(356005)(336012)(36860700001)(81166007)(7696005)(47076005)(426003)(5660300002)(6666004)(508600001)(186003)(316002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 07:11:47.2532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed3d68e-d7fb-4e6f-39ba-08d992cfb6db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chrome board has RT5682 codec and RT1019 amp connected to I2S SP
controller on ACP hw. Also it support DMIC capture endpoints with
inbuilt pdm controller on ACP hw block. Add driver module to create
backend dai links for sof dsp core. We pass driver data with audio
end points configuration to register sound cards and create device
nodes for all audio endpoints.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/Kconfig        |   6 ++
 sound/soc/amd/acp/Makefile       |   2 +
 sound/soc/amd/acp/acp-sof-mach.c | 103 +++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 sound/soc/amd/acp/acp-sof-mach.c

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index d8d49d04fe41..f03af79de592 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -41,3 +41,9 @@ config SND_SOC_AMD_LEGACY_MACH
 	select SND_SOC_AMD_MACH_COMMON
 	help
 	  This option enables legacy sound card support for ACP audio.
+
+config SND_SOC_AMD_SOF_MACH
+	tristate "AMD SOF Machine Driver Support"
+	select SND_SOC_AMD_MACH_COMMON
+	help
+	  This option enables SOF sound card support for ACP audio.
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index aef6f981c770..16c144c2965c 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -14,6 +14,7 @@ snd-acp-renoir-objs     := acp-renoir.o
 #machine specific driver
 snd-acp-mach-objs     := acp-mach-common.o
 snd-acp-legacy-mach-objs     := acp-legacy-mach.o
+snd-acp-sof-mach-objs     := acp-sof-mach.o
 
 obj-$(CONFIG_SND_SOC_AMD_ACP_PCM) += snd-acp-pcm.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_I2S) += snd-acp-i2s.o
@@ -22,3 +23,4 @@ obj-$(CONFIG_SND_AMD_ASOC_RENOIR) += snd-acp-renoir.o
 
 obj-$(CONFIG_SND_SOC_AMD_MACH_COMMON) += snd-acp-mach.o
 obj-$(CONFIG_SND_SOC_AMD_LEGACY_MACH) += snd-acp-legacy-mach.o
+obj-$(CONFIG_SND_SOC_AMD_SOF_MACH) += snd-acp-sof-mach.o
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
new file mode 100644
index 000000000000..e143aa24afb3
--- /dev/null
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2021 Advanced Micro Devices, Inc.
+//
+// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
+//
+
+/*
+ * SOF Machine Driver Support for ACP HW block
+ */
+
+#include <sound/core.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-acpi.h>
+#include <sound/soc-dapm.h>
+#include <linux/module.h>
+
+#include "acp-mach.h"
+
+static struct acp_card_drvdata sof_rt5682_rt1019_data = {
+	.hs_cpu_id = I2S_SP,
+	.amp_cpu_id = I2S_SP,
+	.dmic_cpu_id = DMIC,
+	.hs_codec_id = RT5682,
+	.amp_codec_id = RT1019,
+	.dmic_codec_id = DMIC,
+};
+
+static const struct snd_kcontrol_new acp_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Spk"),
+	SOC_DAPM_PIN_SWITCH("Left Spk"),
+	SOC_DAPM_PIN_SWITCH("Right Spk"),
+};
+
+static const struct snd_soc_dapm_widget acp_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_SPK("Spk", NULL),
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
+};
+
+static int acp_sof_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = NULL;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	if (!pdev->id_entry)
+		return -EINVAL;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	card->dev = dev;
+	card->owner = THIS_MODULE;
+	card->name = pdev->id_entry->name;
+	card->dapm_widgets = acp_widgets;
+	card->num_dapm_widgets = ARRAY_SIZE(acp_widgets);
+	card->controls = acp_controls;
+	card->num_controls = ARRAY_SIZE(acp_controls);
+	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
+
+	acp_sofdsp_dai_links_create(card);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret) {
+		dev_err(&pdev->dev,
+				"devm_snd_soc_register_card(%s) failed: %d\n",
+				card->name, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id board_ids[] = {
+	{
+		.name = "rt5682-rt1019",
+		.driver_data = (kernel_ulong_t)&sof_rt5682_rt1019_data
+	},
+	{ }
+};
+static struct platform_driver acp_asoc_audio = {
+	.driver = {
+		.name = "sof_mach",
+	},
+	.probe = acp_sof_probe,
+	.id_table = board_ids,
+};
+
+module_platform_driver(acp_asoc_audio);
+
+MODULE_IMPORT_NS(SND_SOC_AMD_MACH);
+MODULE_DESCRIPTION("ACP chrome SOF audio support");
+MODULE_ALIAS("platform:rt5682-rt1019");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

