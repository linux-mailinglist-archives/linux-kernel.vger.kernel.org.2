Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF013D237E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhGVMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 08:05:09 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:38272
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231738AbhGVMFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 08:05:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjtOCXNRbcUcp7HJxJ7GTO1hAurFJ1V0zGNP4FrJD1SOxGInC3YU9OMbvrcuthqLMDsF3evj+jMuExETqPUwH9eikBQ3dATnodqWlSUuHFbhR6YORvP5e+734001q2PMOgpyaeL7V6tVL57TwS2/5u9UajiyTy/FkfEO5DHuJfhTG0lhuZga6ILQ2AcMNUs6fI05ycT+hSWamm/DIcOFX79CEA3S5mlClSVJDnlsY/701rgUg6mC1USQ5QVwrVMl0NdHr6GHrZKIybmiDe+syKuT6ORVLbENxzscKgUFXGCqS0HTOfj+ooLZAyMDiwydxzoYSl7mD5fVQQqitb10rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2B+2gO+3FWIUbCHyNgS/idIzEyArfCTrPtelwIxok8=;
 b=ZKSNYupusF+kV7Oke4VAya206kWrsaaGIUVf3qfpukZ10AUObdkuTk3m0X6MKygRLHbyILBDyw69KbXQ0RKRDR6pERh9ZmkSN+/EdDcAVirEx69FAAcWqHAYFAXDLU6U3+4MXde6s6xOD4TF7XcGSnVRR4PG9BwWhhxoKyTLfI1WN+IesN17RwnAA6wU5DXXWyNuFpRCad7rXReFavtP1CeHrscnufFK9D2x90RyLcgm9F3BK2goGZr0lHexRW5FpY5uBBAmuHhquisIddf7l2sxg1S7JC/xm9Jdc+6O7BBKb8NOHt0Fe8jnKJ6hQ67F4JaQ8Ul89W6/yJZ8HvZiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2B+2gO+3FWIUbCHyNgS/idIzEyArfCTrPtelwIxok8=;
 b=IJzgoO1KfbkAbt78ywGmtX5lj4It7PcDXZibfHnBpIDmcYs2C1KwFo+RESrh7ceoxX6kowAsCO0knfiw1BYP86bp6h+qErYTCwk4rZUzj8+saoNYwOcOWCBqLjlMEJSuJc+M1o01euWCqLPfCbPUaAHXzN4xhUrTymNuK8BYADE=
Received: from MW4PR04CA0180.namprd04.prod.outlook.com (2603:10b6:303:85::35)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 22 Jul
 2021 12:45:41 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::b0) by MW4PR04CA0180.outlook.office365.com
 (2603:10b6:303:85::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Thu, 22 Jul 2021 12:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 12:45:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 07:45:40 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 07:45:35 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <amistry@google.com>,
        <nartemiev@google.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: enable stop_dma_first flag for cz_dai_7219_98357 dai link
Date:   Thu, 22 Jul 2021 18:33:15 +0530
Message-ID: <20210722130328.23796-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 899517cf-fec3-4b0d-303f-08d94d0e9d62
X-MS-TrafficTypeDiagnostic: DM6PR12MB4057:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40573EB580B04675B80C541597E49@DM6PR12MB4057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z05P7YnHEjtlofyUm8ksqsqpsAiuNv/936hoiCfjZ/OuQt32XOYDspzfxPWrV/jxoSEWidnR0wnsjJUxpgiRSCah1CKgBpzr5KmJQt2411her+/IwWlRure+L3w2+JK49ilyBLgfCds5LtF7GKk0joRTQLV9vqYslI9al1tsYjP9H+LVG3mHsxAo4MduplQvqSBziCYOyQ2MTs7tzYcFd/T8xoVV9ez9PvkecnTLkxgIeVxlEgi5d4o/T2Prd6GlSMDAONaD5bOtKIEvaaPNV0Ep1kJUC51R65VAIKqAPa4bKtzrpvMlJ92GpZxg3p4LAqv0FChGVtoEg/i0hmsIE5d0GylhjQJqD5mZxAFBY7WNhVer5Nc3ymJ1/XwFH1C3ctwcSy+WwGCiDnWB/SO0pEJLrQNXsV11sLYVgA8f4wwUcCvA0rYvzdO6beVDX4W6ph6re+ZWa/4I2xa8kOiPsBW7YXQvtqWwfb7Ek77IUWNVbM/JpX3N2vkAtKfM7Z5lLofnFRm8qdm4uCckTFAojA27kygw5ewG+ePG4rwLLlNGlrEkY673ANwi1KFT9dxQUHn3ak3yFFCK1U2ZT5J9F80ZtwcsuDu5iVk+hMqEuBy+iQOj/TCzKJ7ae6vwt9RyO8FL+GKYzNbTSoQ9KmQ55gdiBJBpbzvvKAyYxWe2cCAt4brkCUA5cF+JgkHcdCp4za5GxPlKqL3cxQtjZ1HKRHFUmb3cds3uYHgLEu+UIuM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(46966006)(82740400003)(7416002)(70206006)(70586007)(36756003)(336012)(36860700001)(426003)(81166007)(4326008)(6666004)(1076003)(186003)(7696005)(86362001)(5660300002)(2616005)(478600001)(356005)(8936002)(2906002)(47076005)(26005)(82310400003)(54906003)(8676002)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 12:45:41.3145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899517cf-fec3-4b0d-303f-08d94d0e9d62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA driver stop sequence should be invoked first before invoking I2S
controller driver stop sequence for Stoneyridge platform.

Enable stop_dma_first flag for cz_dai_7219_98357 dai link structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 9449fb40a956..3c60c5f96dcb 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -525,6 +525,7 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_da7219_init,
 		.dpcm_playback = 1,
+		.stop_dma_first = 1,
 		.ops = &cz_da7219_play_ops,
 		SND_SOC_DAILINK_REG(designware1, dlgs, platform),
 	},
@@ -534,6 +535,7 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
+		.stop_dma_first = 1,
 		.ops = &cz_da7219_cap_ops,
 		SND_SOC_DAILINK_REG(designware2, dlgs, platform),
 	},
@@ -543,6 +545,7 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_playback = 1,
+		.stop_dma_first = 1,
 		.ops = &cz_max_play_ops,
 		SND_SOC_DAILINK_REG(designware3, mx, platform),
 	},
@@ -553,6 +556,7 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
+		.stop_dma_first = 1,
 		.ops = &cz_dmic0_cap_ops,
 		SND_SOC_DAILINK_REG(designware3, adau, platform),
 	},
@@ -563,6 +567,7 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
+		.stop_dma_first = 1,
 		.ops = &cz_dmic1_cap_ops,
 		SND_SOC_DAILINK_REG(designware2, adau, platform),
 	},
-- 
2.17.1

