Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F012429E82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhJLHYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:24:22 -0400
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:63841
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233507AbhJLHYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:24:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXckeYYPSjpZdsMb226DptL5/aSDXwtfLBFBVjQlJrBGh8N6n0cGTFzOsjxoo7MoLb0e2FbdyVHcAME9wt3u/9L5LnW1A/eDNX3WO2/YuayjK+D6XB5bJ7EKp39fG2BlhqFrOiaIfJjwQmr6Vxyyq0rvRCHh+x4FBx/cE/Ht8BaygkQwY+WzFBp33G0SwtFSGdZ7gCQ3gUBlBcLA+jwzpIPLPClhL+IL1ysJSExjQy/Y1UHSL/H10Q/zz/lgOyyGIFezMm7jR07IWlJCSwdxv2KPd22GOkCwPRmfy5WXGaSpsFzMTOUlAXkizs4J1UvuvXetxCa2pWuN3hWi1AfWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr7H4HVEE2ArKZraMY7FjqWU5X3+5bGa82+8DYdAfEs=;
 b=O1+UTR7LaD2KaNRLw9p2KDc87ZSS/exKqgfCte02d/faLNm1o3L6rr+2YvPPBR+35myy7j2kE/Rb27+X7W87edg4PIm8P386fM2FwIP8F24Gnl76vwQime8eMwxdcw8YDQAbcATKsYGT98+E/LLPWxhdoP3kHLX/4/wdBd8irSBpIzdwUuvcXLe0O76CtaGmpfU09KZ4lYf+tSOqUHbme1pSuMB+Z8Fzkj6wucNuOOI/X7OPKfPENb4Quw7A+d8jZpP4f5D0n54UmSUE0vzIEdMlqAITTQT1IQv0EFqIGBxFoD7enycKmd0B0jxEsmUhBHQGUZpg/yUk58Za4powtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr7H4HVEE2ArKZraMY7FjqWU5X3+5bGa82+8DYdAfEs=;
 b=Hi3bFH7XcPCAmYFLpVbpnpRVtjYfWWRRXbXfwq0klDp3lPwZ3VtHjG/MqTaA3fYjLcUX1VSDcKIGMQ5YboDmEMILMiypyzYGTUp8gqEj3ocrd9fEHmgBdWhyTcJst84QG//nNq46CgWimyWj+khjXYZOFQMC8myB637IsiRiMHA=
Received: from BN9PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:fb::26)
 by MWHPR1201MB0192.namprd12.prod.outlook.com (2603:10b6:301:5a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 07:22:18 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::f4) by BN9PR03CA0051.outlook.office365.com
 (2603:10b6:408:fb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Tue, 12 Oct 2021 07:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 07:22:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 02:22:16 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 12 Oct 2021 02:22:12 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/8] ASoC: amd: acp: Add legacy sound card support for Chrome audio
Date:   Tue, 12 Oct 2021 12:49:36 +0530
Message-ID: <20211012071939.97002-6-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012071939.97002-1-AjitKumar.Pandey@amd.com>
References: <20211012071939.97002-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc9ddf8-f47b-4181-5e2f-08d98d510594
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0192:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01927F3CA009C13BF4A107EF82B69@MWHPR1201MB0192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0nFKiHkFqobtjITMjmv1LSoT1/t7HYYhzxgdRnR5tm7sPb2QtT3c8WWIQ23OjesvO4fGhkVmHbdVMjSj9w176OyoBwdPWHuqeCxvnGvXsy/F7eBFIggPLyT8dGilCbs3DJ+5BeglYDfk1N7hrxofcYg7+KQeQ9KzsvbI2GKqilxCO0204Qt1/4h6e6Ez6D6r7rAkvf1cCQeOE2D1ojnCdfgFr/tQ6H9mTs+F6K2ddPa2sdbTZOihfYRd8CkC2pPKayDjXLXACSlDaTZF+OTfKX+iMD3rdUvmCV9qA0YMDss+QtKEtJ9nKCtBUtLee/ft7Fzu0HHqnB1Yl2vzxBi9Y/SUTAVvDbA9Rc+Bn0BYlLOFNPRKZtj/QRa5HIVkwdzDkNBkUehhdEv4S6JUo6JFwooNcnrrnHExupK/QA1s/SWahxqQpgqiudiR1YeXaqQM1rvA27JofpWoiqQ0fGEm05clxkXIxn5oSvVJyg+t4XTBSF08fr6r3q6zcXA5L2zMuIZQGR7OtF0fw4+W5FP7s0ZNXwot3Dy1O1Uv5X+SR7N3jfk1A+e1fAMuvH6OK0fROu5s/8n5knfAwEV6wcpsi6Y0G2CJYVNzPIvV9FdEl3dEhQFBEqds8KMGXmwpCtiU+tAAROo963FsxKj9sBFyN9E1HKiequ3JQl0/i3y/bUrM4/f90b0HY8BembV1qyGsx72fjeoFSB5B9jGkF1VK3zhUcn8lIQwr5eaNhhLou8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(82310400003)(426003)(5660300002)(1076003)(4326008)(110136005)(7696005)(36756003)(2906002)(8676002)(2616005)(54906003)(70206006)(6666004)(8936002)(83380400001)(336012)(316002)(356005)(508600001)(70586007)(26005)(81166007)(47076005)(36860700001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 07:22:17.4673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc9ddf8-f47b-4181-5e2f-08d98d510594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renoir based Chrome board has RT5682 as primary headset codec and
RT1019 amp device connected to I2SSP ACP i2s controller. Add driver
to register legacy sound card devices on Chrome board.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/Kconfig           |   6 ++
 sound/soc/amd/acp/Makefile          |   2 +
 sound/soc/amd/acp/acp-legacy-mach.c | 104 ++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 sound/soc/amd/acp/acp-legacy-mach.c

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 7ce43e393643..d8d49d04fe41 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -35,3 +35,9 @@ config SND_SOC_AMD_MACH_COMMON
 	depends on X86 && PCI && I2C
 	help
 	  This option enables common Machine driver module for ACP.
+
+config SND_SOC_AMD_LEGACY_MACH
+	tristate "AMD Legacy Machine Driver Support"
+	select SND_SOC_AMD_MACH_COMMON
+	help
+	  This option enables legacy sound card support for ACP audio.
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index a477a18272bf..aef6f981c770 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -13,6 +13,7 @@ snd-acp-renoir-objs     := acp-renoir.o
 
 #machine specific driver
 snd-acp-mach-objs     := acp-mach-common.o
+snd-acp-legacy-mach-objs     := acp-legacy-mach.o
 
 obj-$(CONFIG_SND_SOC_AMD_ACP_PCM) += snd-acp-pcm.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_I2S) += snd-acp-i2s.o
@@ -20,3 +21,4 @@ obj-$(CONFIG_SND_SOC_AMD_ACP_I2S) += snd-acp-i2s.o
 obj-$(CONFIG_SND_AMD_ASOC_RENOIR) += snd-acp-renoir.o
 
 obj-$(CONFIG_SND_SOC_AMD_MACH_COMMON) += snd-acp-mach.o
+obj-$(CONFIG_SND_SOC_AMD_LEGACY_MACH) += snd-acp-legacy-mach.o
diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
new file mode 100644
index 000000000000..de0f8024e2fb
--- /dev/null
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -0,0 +1,104 @@
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
+ * Machine Driver Legacy Support for ACP HW block
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
+static struct acp_card_drvdata rt5682_rt1019_data = {
+	.hs_cpu_id = I2S_SP,
+	.amp_cpu_id = I2S_SP,
+	.dmic_cpu_id = NONE,
+	.hs_codec_id = RT5682,
+	.amp_codec_id = RT1019,
+	.dmic_codec_id = NONE,
+};
+
+static const struct snd_kcontrol_new acp_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Spk"),
+	SOC_DAPM_PIN_SWITCH("Left Spk"),
+	SOC_DAPM_PIN_SWITCH("Right Spk"),
+
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
+static int acp_asoc_probe(struct platform_device *pdev)
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
+	acp_legacy_dai_links_create(card);
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
+		.name = "rn_rt5682_rt1019",
+		.driver_data = (kernel_ulong_t)&rt5682_rt1019_data,
+	},
+	{ }
+};
+static struct platform_driver acp_asoc_audio = {
+	.driver = {
+		.name = "acp_mach",
+	},
+	.probe = acp_asoc_probe,
+	.id_table = board_ids,
+};
+
+module_platform_driver(acp_asoc_audio);
+
+MODULE_IMPORT_NS(SND_SOC_AMD_MACH);
+MODULE_DESCRIPTION("ACP chrome audio support");
+MODULE_ALIAS("platform:rn_rt5682_rt1019");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

