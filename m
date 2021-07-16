Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A003CB73B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhGPMPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:15:37 -0400
Received: from mail-mw2nam08on2055.outbound.protection.outlook.com ([40.107.101.55]:18657
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232223AbhGPMPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:15:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPuJ5Sh2Mi0zhekzaQd/4H45DZmVYQxY1AFLB+MGlaJmeS6jJO0yAwouzYxFr9KEy3i4jaeUAmajAyAexMAEVfb5gk27QqtEx3QZcO9dTx0oSjRJR4C7pdVNpnfrB4Guj+lVDQRO8KwrdelokiLVI9D/dvf2iCzhxD1eH5mfA+9WI6Ul9CtdBzV1/nsyr+fKOOuUc3SC4wa862ifdouyGRNt5A79q9jfDpKF9y3WQ7WwMRxL58HfgTomzlACha47l/0t7Qz4Srf8/rNqR96ab34FRMtAn6GoVUoxCoCA+fNzub4ALS08V+QYn0hz5llulTtmQWDx6Q/dTwdqxzkNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e45xSRnjwqdlPmwQN/T+aBqP+lPZCLkGt89nZwAhdp0=;
 b=OhRMRACJ+O7yuIOGFy77KOJkz7HPIa+AuN1xvJnplPE+7VjrMPrc2K/mhG9vG54fMImKCxtng9/F31QjAuY1CLjj2XkXnGdD4BkkgqqEKB1WQYaHpRLl9HJbjRzBHA9wyzTvWIxk69rEB3vxdYkP8CGBDUu+dL6oPQvXVbDqy87wdlpRIEY/Q9j0JQZB22D/GulTiVQfoHrZJljWBUSmd0PZEgHMemyBqwusvTZwfZ/vBdZAGjzeq0R6rKn23kjqRSzMO0vtDR9nFpb/UdWOvlpEzBZM/IGULdbbFYXeKh4uRfyHkqLMQdxGDn+BXUDT8ZVXj2TNaqTkaf1RNarMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e45xSRnjwqdlPmwQN/T+aBqP+lPZCLkGt89nZwAhdp0=;
 b=COv3AnqD4RW1QIM2ArEl3Fox2zne21gx6wLECp+0Mguqof9KyarNFs5XsC20lGgn7e7QTnEnzaiiFm+9lVIfD+t60xSIZ/yoFR2Ok5ZilYJBARnJBEZAADnJGxBOtla1sUbXfc+i60krSFd7TFEIYMHduDDBgXg/a35RaAZb8+M=
Received: from MWHPR11CA0025.namprd11.prod.outlook.com (2603:10b6:300:115::11)
 by BN8PR12MB3140.namprd12.prod.outlook.com (2603:10b6:408:67::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 12:12:39 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::82) by MWHPR11CA0025.outlook.office365.com
 (2603:10b6:300:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 12:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 12:12:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 07:12:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 07:12:36 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 16 Jul 2021 07:12:26 -0500
From:   Vijendar Mukunda <vijendar.mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <nartemiev@google.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <amistry@google.com>, Vijendar Mukunda <vijendar.mukunda@amd.com>,
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: soc-pcm: add a flag to reverse the stop sequence
Date:   Fri, 16 Jul 2021 18:00:12 +0530
Message-ID: <20210716123015.15697-1-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cac498e5-c32b-4b2b-1aa5-08d9485300ef
X-MS-TrafficTypeDiagnostic: BN8PR12MB3140:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3140176AC5EF77ED3E39ED9697119@BN8PR12MB3140.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExGm4RHfj6936NIWkHR9UXaFrHyx0hzz/mtJ+leC+Ya+b+qj2NwxfwT3ygSEDb23I1Jmw7vPzbXdsWB7W04O0sg8+u29rQ1SVUTlXY1rMER75oanHfDpKW1X6tezi/zgUimgSy6KLs5+RbZ5yqijl/ImzNdxz4DGqWYOJqJaCi8IP8iyovOBF0q4czjyWJiMR4iOrZjZv7SuECKu7fG5G6P3ajYugBDyrZK3HP3KKex92ib5F+AxiHtoYd0I1KIidNtIOgA5UqNps8GVDmrAESXSyau7cdN4YADoq2ZthamUOM4dp/CyvWyia4lXI0wZKMKcHO0i098H2CS3ge+92UNQ2ILMOmUzmsDQebg5d4iXTlS/VsOuF1Y0GeIMkSzkg5K8MXhlPp/gM1Jiwo55DPHNLcvlqGjkNetyGzGM+QWjsT9+VK1HHpjT5pkt5XpEW8ckzkZfXGnfWcaPr7Re4qC/NMb1BKMpr2kHV6zlBCpF/Bx4cqyb//pM6/PKxvFpg7AvWfMDW8gX6H3DzC2cB0ZHZdGcUMU+Feq6QQpJgcyhBHAMYma74SrAF2ZuVX/wJEzbaogvO5DDUS3NV5aZup9foRpKSOs858axIJBH6wg2bnXn4mgFyjVHUdzEbhH5345uVH8s7XwTwFgsP7rHG+2wt+TM3BF8leh1YWnpEqMp1TvjMaXHQdO1SVTMj6kJTNna2++7CH1cL8Zyc9Icr+DndntL9BGDaqZbNEGBnY4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(2906002)(356005)(86362001)(8676002)(316002)(6666004)(5660300002)(82740400003)(70586007)(70206006)(7416002)(110136005)(26005)(54906003)(1076003)(7696005)(426003)(478600001)(36860700001)(4326008)(81166007)(47076005)(186003)(336012)(2616005)(8936002)(36756003)(44832011)(83380400001)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 12:12:38.3112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac498e5-c32b-4b2b-1aa5-08d9485300ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On stream stop, currently CPU DAI stop sequence invoked first
followed by DMA. For Few platforms, it is required to stop the
DMA first before stopping CPU DAI.

Introduced new flag in dai_link structure for reordering stop sequence.
Based on flag check, ASoC core will re-order the stop sequence.

Fixes: 4378f1fbe92405 ("ASoC: soc-pcm: Use different sequence for start/stop trigger")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 include/sound/soc.h |  6 ++++++
 sound/soc/soc-pcm.c | 22 ++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 675849d07284..8e6dd8a257c5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -712,6 +712,12 @@ struct snd_soc_dai_link {
 	/* Do not create a PCM for this DAI link (Backend link) */
 	unsigned int ignore:1;
 
+	/* This flag will reorder stop sequence. By enabling this flag
+	 * DMA controller stop sequence will be invoked first followed by
+	 * CPU DAI driver stop sequence
+	 */
+	unsigned int stop_dma_first:1;
+
 #ifdef CONFIG_SND_SOC_TOPOLOGY
 	struct snd_soc_dobj dobj; /* For topology */
 #endif
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 46513bb97904..d1c570ca21ea 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1015,6 +1015,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	int ret = -EINVAL, _ret = 0;
 	int rollback = 0;
 
@@ -1055,14 +1056,23 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		ret = snd_soc_pcm_dai_trigger(substream, cmd, rollback);
-		if (ret < 0)
-			break;
+		if (rtd->dai_link->stop_dma_first) {
+			ret = snd_soc_pcm_component_trigger(substream, cmd, rollback);
+			if (ret < 0)
+				break;
 
-		ret = snd_soc_pcm_component_trigger(substream, cmd, rollback);
-		if (ret < 0)
-			break;
+			ret = snd_soc_pcm_dai_trigger(substream, cmd, rollback);
+			if (ret < 0)
+				break;
+		} else {
+			ret = snd_soc_pcm_dai_trigger(substream, cmd, rollback);
+			if (ret < 0)
+				break;
 
+			ret = snd_soc_pcm_component_trigger(substream, cmd, rollback);
+			if (ret < 0)
+				break;
+		}
 		ret = snd_soc_link_trigger(substream, cmd, rollback);
 		break;
 	}
-- 
2.17.1

