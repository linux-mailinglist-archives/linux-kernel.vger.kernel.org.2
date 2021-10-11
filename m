Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D2D42865A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 07:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhJKFmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 01:42:11 -0400
Received: from mail-sn1anam02on2070.outbound.protection.outlook.com ([40.107.96.70]:39604
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234038AbhJKFmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 01:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVFC+ji83tLagMvkrg4EZaJro6Y/GayCl0ubCkWejouMCJqL20Gkj53sjzLWZPQDdUVNzIsUZZReqnBX4u97UWmVARl2uZ9LFjfuBMgqCd3RoB3dx98EEvGzGG4XkWdyLyH6Cez2sVPdclPP1+W+YOdftEjH0/gStfSAQ3WG8eYKqx3CW/8wZg496Kl4hovrzYjWtflKtN1qPoucl+LCDIEZdexOmukZyp7xVLdtMBOZzBDQ3YM+1cr8CWStmBNA56XT4qryEpSLcqFKCKRz9U9+CAvJTr0I+mDrELbKyNnkkYA3uNSb/SI6bxj0ofba9wWtpobxn7mHS1NLbl5oxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwZOqvi0lCQek0PCXkSUmZpFhPnMS/07A4HUvqZLZA4=;
 b=ZL4nsjUEvhbQbrcFjGXbt/aSJUfFYS405CnjfI82iLjZhr/NdPanF940PojtAPsvGhXxmOlgPaR5eQAfhnimjNYi/wU3GSRS76Vbtbb0Pg9RNezaKa3q+3Uika5dSH5khfFIUkVoSUMN1ESqtEDkWGimPru4KuoTf6jkCn+JrlZl5fw7lUWbtnVgiodF4oPFCSZANoY9kaNIQbrdODwL/tWXMfnE4JjThnCugUJJU0AQiX0k120uLCewv2MX1mIPvFLdDtD0CHHwsBw+0bGx6+JrQPxKkHdj+YgSxn3IRBoNHcD0ktDb5tww7zsz5rZp4rwqJQb7NpTZNEc35LjPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwZOqvi0lCQek0PCXkSUmZpFhPnMS/07A4HUvqZLZA4=;
 b=C5v43OiOYFXgfjwhtNTVcKxBcUT9QutGPUa0PLa3EoQRfj8ZEqqucUCbE/A81KR/2GkHG10obYMEpalUF9M+OHwHvEW1JnODDNnctJR3DqgJUW4gwuvCMsiE5BDQZrnB8r2OZz+9aQHlUbUOOs1g4OpZQJ8aRv/w/9g5RR1Qd/Q=
Received: from MWHPR18CA0049.namprd18.prod.outlook.com (2603:10b6:300:39::11)
 by MWHPR12MB1150.namprd12.prod.outlook.com (2603:10b6:300:f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 05:40:06 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::bc) by MWHPR18CA0049.outlook.office365.com
 (2603:10b6:300:39::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Mon, 11 Oct 2021 05:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 05:40:05 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 00:40:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 22:40:03 -0700
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Mon, 11 Oct 2021 00:40:00 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mario.Limonciello@amd.com>,
        <Richard.Gong@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/13] ASoC: amd: add YC machine driver using dmic
Date:   Mon, 11 Oct 2021 11:26:20 +0530
Message-ID: <20211011055621.13240-13-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
References: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46d9944a-ee2d-4d84-5949-08d98c799484
X-MS-TrafficTypeDiagnostic: MWHPR12MB1150:
X-Microsoft-Antispam-PRVS: <MWHPR12MB11504407147A1E998D4865EA97B59@MWHPR12MB1150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t//tj7zgy8WBOCXWbe/DknuDkfhQyocSkv5cUd9bbzbYEWXSDhoyxbyQIgfQVUGhxWdF6cNpTl723uSeAf8NaEPvuRRY1Gjo1LzDASSpPRV1fRCfkXm8Uyh7khnJHhM/s1BXNQB7i+yv+5E96kjY4wmb2UNv+rm3gQRUY3W0GKrbRLbxZnlyH5+jZFxetjf0r+Kdda94di3nJvbUX/FHDoFxLTol2WP16niX7D2MfbhKhBpduBRkGq52MyPa7MahrgSTuDTboGwaEhlR58R3BSqx/inLtjsZnzehtCrzpijfCtrEZYHwHMt90Zhjt+oEma1sdZmkqdtML3OJ0980Tlzg8WJyv0wfKMPrv4GdDL8RYuLosSsSspdpwfbP05vs/0oovB2X3fmDnqm4PatAC/viF/o1zV647dh0ilunfUMgXC7LkA6OLVAImeEQc2Te0hDVPr9U+sZTMwIGE5WMs/s9tthWG7GBr1Ew/EG6t+jT8ANLJWjFlr4BEUlsUuUMg/8UgW1+Wny6ab/2ruwkd2jg+JY7nj6Y9PiY0HEi3r6rxLmTKy7Ek1hIX5wR0aKVz/D3IvDepq/R35eBbdnAyc63KVBPBpAHcOHWhtRW6dMqLH3nFSr/HCWux/fQqvDHdCw2nhU8YMZn6yCu/ftou9bo0m8RoywAueRuiPqlOtTR+CD0Lpxx4oM0nkHJ5K6/z2ttO4ttKbCeM+v3BjyXqfKE+VnAgufE91nZR4IsJGA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(2906002)(6666004)(70586007)(426003)(70206006)(356005)(47076005)(36860700001)(2616005)(81166007)(336012)(186003)(8936002)(8676002)(1076003)(110136005)(5660300002)(54906003)(82310400003)(7696005)(26005)(86362001)(4326008)(316002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 05:40:05.8829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d9944a-ee2d-4d84-5949-08d98c799484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Yellow Carp platform machine driver using dmic.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 76 +++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 sound/soc/amd/yc/acp6x-mach.c

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
new file mode 100644
index 000000000000..5804d17457d0
--- /dev/null
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Machine driver for AMD Yellow Carp platform using DMIC
+//
+//Copyright 2021 Advanced Micro Devices, Inc.
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <linux/module.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <linux/io.h>
+
+#include "acp6x.h"
+
+#define DRV_NAME "acp_yc_mach"
+
+SND_SOC_DAILINK_DEF(acp6x_pdm,
+		    DAILINK_COMP_ARRAY(COMP_CPU("acp_yc_pdm_dma.0")));
+
+SND_SOC_DAILINK_DEF(dmic_codec,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec.0",
+						  "dmic-hifi")));
+
+SND_SOC_DAILINK_DEF(pdm_platform,
+		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_yc_pdm_dma.0")));
+
+static struct snd_soc_dai_link acp6x_dai_pdm[] = {
+	{
+		.name = "acp6x-dmic-capture",
+		.stream_name = "DMIC capture",
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(acp6x_pdm, dmic_codec, pdm_platform),
+	},
+};
+
+static struct snd_soc_card acp6x_card = {
+	.name = "acp6x",
+	.owner = THIS_MODULE,
+	.dai_link = acp6x_dai_pdm,
+	.num_links = 1,
+};
+
+static int acp6x_probe(struct platform_device *pdev)
+{
+	struct acp6x_pdm *machine = NULL;
+	struct snd_soc_card *card;
+	int ret;
+
+	card = &acp6x_card;
+	acp6x_card.dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, machine);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret) {
+		return dev_err_probe(&pdev->dev, ret,
+				"snd_soc_register_card(%s) failed\n",
+				card->name);
+	}
+	return 0;
+}
+
+static struct platform_driver acp6x_mach_driver = {
+	.driver = {
+		.name = "acp_yc_mach",
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = acp6x_probe,
+};
+
+module_platform_driver(acp6x_mach_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.25.1

