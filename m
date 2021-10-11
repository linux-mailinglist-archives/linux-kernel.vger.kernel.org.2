Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886D14293BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhJKPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:49:28 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:7168
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240007AbhJKPtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:49:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT9DsVk5mQrdCHUFuXzeKLpecC81w4kVYfywnVB3TGOkWpbndxogAqOi++Lf6yma/VnPe/2I0RHpjcFOhstXCfRubAy7i9FD8bWN+K49DA49C7THTli4ZBmgp60jeu1hXV/xXLSngsQ2yTtZmas3i6RZLTyVMpqPko/GHh1o7ZdFWoSumzmztpwegm93J0O3OqQNDaFiDRl4o7GaFp/C+jtaYsz6i4d/xcWixNUQNOrewgGOjqbzonDZKmkSXD8CfhcNzTKW42XhZ38mh3qPrgj5dfsDo62ebuLzHGbf9BWXMJ7w2Tk+xVjuO4vwzEigtKPRTncO0ryqj/YZ9Y2qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrHG6939DL2tSsvzSX0oE7FmmbdtYyW1w6zY9Qn7Pvs=;
 b=WTInZHVQUb1E5lp4rMMZs69NNNFcqnx3w3UM3lgFSRkAsj6QYteCTM0gDxl8YFBjqZ7vvUOUXynPKWD/nuRfE7mGYfEn1o0ph1+QHBsr3m53I9l245B550cv4OFWz3Ef8jjWeUZe/8I0T0x3JsZVoGVGV93ZYrI7d7q5gntb8ZiH0KU93g/thfqLkj3ApKTHOe0ATv2IuyrJFka1t6sZOxkGKBTkDp5jp2f9hA/pb06bThhzkv5r4GUkRa3AUTzLUkqFqBIaToVw/nTDiFuuvE2DpfafI61xi0tN3ivvNO/nU4/rRVAZhaxqyXbRhqmzniVH6VXsQdUg8rQAEhvjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrHG6939DL2tSsvzSX0oE7FmmbdtYyW1w6zY9Qn7Pvs=;
 b=nciT/v//9FwC/PgG9aKpVwJRAMrQZ0ILUax0tiXlzQC9aE/Dxi44fNcSGIfmWSEM4Hzz+ZQ9gmvQk/aauxzws9DZWWLBPYVx7luzXqkkSL5Xqyi2/GQN5iIYPtwQXfQe+rBLOyyZV12SiOyF9FZ9UyUNIAi/xspnHFn1zsscl5s=
Received: from BN9PR03CA0277.namprd03.prod.outlook.com (2603:10b6:408:f5::12)
 by BN8PR12MB3025.namprd12.prod.outlook.com (2603:10b6:408:66::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Mon, 11 Oct
 2021 15:47:10 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::6e) by BN9PR03CA0277.outlook.office365.com
 (2603:10b6:408:f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Mon, 11 Oct 2021 15:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 15:47:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 10:47:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 10:47:09 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Mon, 11 Oct 2021 10:47:05 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/8] ASoC: amd: acp: Add support for Maxim amplifier codec
Date:   Mon, 11 Oct 2021 21:14:51 +0530
Message-ID: <20211011154452.76849-8-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011154452.76849-1-AjitKumar.Pandey@amd.com>
References: <20211011154452.76849-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1972d47d-d8fd-4b42-40ff-08d98cce6303
X-MS-TrafficTypeDiagnostic: BN8PR12MB3025:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3025016150C7EF774FA9036082B59@BN8PR12MB3025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/k7ZelVK20hafrmLFTLFmfbCJ5zpnySPTIOxuJdyRBezT9Bv3CRG80s3AOs2cCqFY1Sp5niRoIiKVKUr+SAwC2rGoOry9J7M9ngIC86BDm/aESF+xHx91VuXsuAXlijQjaAAOxmzVxFfKMhnxLQgTTPkUXcGSHQ95Ecgst31kSUv9SYEQkphtdzhDtbgHrVtY5hJtf49l0PkkcuvBO+Qy3cSiiD65TxtAHa/wKhk8R6K3eYxpTP7JQMbiO3ZCw/GgHLe0GSyZj0T0cVfHE1fPGnHgORXbk2I5iFcV3rsjXF5Do1zi1Ey/RDAGOW1zxrdeWGZd6LeMgKUd8I+qScRSR5scTtBFVnBOU+sWoVsRfY4P9kl03xjoPPHIM7ERWNoTlNaN8sd9DRYOEYyBwFueSnmIWlYxwQ6JZrCfj6aYqAE/i5/VydZVKsrMXxTOjcHrIEtG0q3pONbYps7ul9oCKQ4iGKyg5jMOZB4EhH0KRmNkQjvq9yB+OwmPjxZ2sFhsOuefa1x+KCNlwD66A0Fvjhd0jhlnPKrUjOwObi82MOEB7D/o5E/Vqx6jc1wCP6H1NqhB7uFTbeyYhRECPpwf8Jtak+RVpRwF5Gh/912UWuitVpjSj0JIOwswGd6aP4bsqr4T1/IIWGXC9gEv5G1mWFNukOmNXg6o2xLmlA1H6HF8il39/ElmWMCWJso21/MvnirC34KGzVVMqVB1NBm5QT3w7UXDMdUqKYA1qaQYk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6666004)(82310400003)(316002)(36860700001)(2906002)(508600001)(2616005)(36756003)(8936002)(4326008)(70206006)(5660300002)(7696005)(26005)(70586007)(356005)(1076003)(8676002)(81166007)(186003)(336012)(426003)(47076005)(110136005)(54906003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 15:47:10.1135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1972d47d-d8fd-4b42-40ff-08d98cce6303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newer chrome boards we have max98360a as an amplifier codec.
Add support for max98360a in generic machine driver and configure
driver data to enable SOF sound card support on newer boards .

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/Kconfig           |  1 +
 sound/soc/amd/acp/acp-mach-common.c | 37 +++++++++++++++++++++++++++++
 sound/soc/amd/acp/acp-mach.h        |  1 +
 sound/soc/amd/acp/acp-sof-mach.c    | 14 +++++++++++
 4 files changed, 53 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index d170672927ef..04d8df7a6e11 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -31,6 +31,7 @@ config SND_SOC_AMD_MACH_COMMON
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_DMIC
 	select SND_SOC_RT1019
+	select SND_SOC_MAX98357A
 	depends on X86 && PCI && I2C
 	help
 	  This option enables common Machine driver module for ACP.
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 5dda2d92a5aa..b9d77d761cca 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -274,6 +274,31 @@ static const struct snd_soc_ops acp_card_rt1019_ops = {
 	.hw_params = acp_card_rt1019_hw_params,
 };
 
+/* Declare Maxim codec components */
+SND_SOC_DAILINK_DEF(max98360a,
+	DAILINK_COMP_ARRAY(COMP_CODEC("MX98360A:00", "HiFi")));
+
+static const struct snd_soc_dapm_route max98360a_map[] = {
+	{"Spk", NULL, "Speaker"},
+};
+
+static int acp_card_maxim_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct acp_card_drvdata *drvdata = card->drvdata;
+
+	if (drvdata->amp_codec_id != MAX98360A)
+		return -EINVAL;
+
+	return snd_soc_dapm_add_routes(&rtd->card->dapm, max98360a_map,
+				       ARRAY_SIZE(max98360a_map));
+}
+
+static const struct snd_soc_ops acp_card_maxim_ops = {
+	.startup = acp_card_amp_startup,
+	.shutdown = acp_card_shutdown,
+};
+
 /* Declare DMIC codec components */
 SND_SOC_DAILINK_DEF(dmic_codec,
 		DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec", "dmic-hifi")));
@@ -371,6 +396,12 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 			card->codec_conf = rt1019_conf;
 			card->num_configs = ARRAY_SIZE(rt1019_conf);
 		}
+		if (drv_data->amp_codec_id == MAX98360A) {
+			links[i].codecs = max98360a;
+			links[i].num_codecs = ARRAY_SIZE(max98360a);
+			links[i].ops = &acp_card_maxim_ops;
+			links[i].init = acp_card_maxim_init;
+		}
 		i++;
 	}
 
@@ -455,6 +486,12 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 			card->codec_conf = rt1019_conf;
 			card->num_configs = ARRAY_SIZE(rt1019_conf);
 		}
+		if (drv_data->amp_codec_id == MAX98360A) {
+			links[i].codecs = max98360a;
+			links[i].num_codecs = ARRAY_SIZE(max98360a);
+			links[i].ops = &acp_card_maxim_ops;
+			links[i].init = acp_card_maxim_init;
+		}
 	}
 
 	card->dai_link = links;
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 464fb7eb802d..b6a43d1b9ad4 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -35,6 +35,7 @@ enum codec_endpoints {
 	DUMMY = 0,
 	RT5682,
 	RT1019,
+	MAX98360A,
 };
 
 struct acp_card_drvdata {
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index e143aa24afb3..f7103beedf32 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -29,6 +29,15 @@ static struct acp_card_drvdata sof_rt5682_rt1019_data = {
 	.dmic_codec_id = DMIC,
 };
 
+static struct acp_card_drvdata sof_rt5682_max_data = {
+	.hs_cpu_id = I2S_SP,
+	.amp_cpu_id = I2S_SP,
+	.dmic_cpu_id = DMIC,
+	.hs_codec_id = RT5682,
+	.amp_codec_id = MAX98360A,
+	.dmic_codec_id = DMIC,
+};
+
 static const struct snd_kcontrol_new acp_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -85,6 +94,10 @@ static const struct platform_device_id board_ids[] = {
 		.name = "rt5682-rt1019",
 		.driver_data = (kernel_ulong_t)&sof_rt5682_rt1019_data
 	},
+	{
+		.name = "rt5682-max",
+		.driver_data = (kernel_ulong_t)&sof_rt5682_max_data
+	},
 	{ }
 };
 static struct platform_driver acp_asoc_audio = {
@@ -100,4 +113,5 @@ module_platform_driver(acp_asoc_audio);
 MODULE_IMPORT_NS(SND_SOC_AMD_MACH);
 MODULE_DESCRIPTION("ACP chrome SOF audio support");
 MODULE_ALIAS("platform:rt5682-rt1019");
+MODULE_ALIAS("platform:rt5682-max");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

