Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6603D157D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbhGURJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:09:10 -0400
Received: from mail-dm6nam08on2052.outbound.protection.outlook.com ([40.107.102.52]:58464
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237823AbhGURJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:09:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0XreG9fBDYtfH7tydyn4NC8YlMJczfVdMBz5TtPh3MNo7qnxkF8sKKjL3JGG/jwHMKZixpxSm6wGZwjt4ImDRoCwiCuRK6opjhET6JAHBhi4aOJa+3h3ekjbUMhpuOPI+W03pDiJMHrF5p/Xez1xGBr+Dsc8/lyvN2JqnB52wLOWio0lL/u+OfuqvXhNPTLV+AMcCN2Dr808n14H0OMkcITRsrqwR3glG5i5pnDxTcLDjkUxwudRk7Q3kdVegRWT6iKjJgxih10AD3As8a6sdL3Co880TGmoYUPuWX6feBf5n7QZC5yUZKv0b62Y4UEjEBuOXotbBfoHeubYDCUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z/QKZ6yCdg3W0Ocf+80OCy/X6g3dOAUC30XNg6w35A=;
 b=mSrHj8+D+ukhgGL4ZmGzKfpF8Z1Igu1GKCvxB5jTIblPUs33eVM5EvliQKD+UYZGSLIadxBR4gtSK177FMIw94/n8teuhBQT08LsuQNuTT+EdOIDfNPHLtxwfG5uCBQZNxui7cZ6Oo6m3TiRkQcGvZ6kOgTkMGZ0pcD3kLdGqa+PWVR3hXviYaWodtQbRmOrnjOLphApF/lGijYfpPt9OsHUYArGY2pyd4nG6NE8/0iOn9iIGKPj3elaBLEi6IkjiwB0Z1I0OOhi6Du6RAefiOte5BtgKGl5qS4i5UGjP0zca6oYXzMDgC11zILhCRDu4GfC7oJZ8O5Xu5T9BlNOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z/QKZ6yCdg3W0Ocf+80OCy/X6g3dOAUC30XNg6w35A=;
 b=KFpz4qNdTnSosO2pEtVOnpkJ3WDa+CyKm54VSPd6A6SegOcDUgK5hYZ0sV6hksPpdDABrNk52UFJ4v8rU3iLlvFbT2RUnEB7zJ7jVzRaywWufFiBI1AnHWHRAP2fDP0zYstGR8nWpeayv0vzVbpOdwR86/PDbMtR/d557t8gbBY=
Received: from DM5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:3:13f::22)
 by MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Wed, 21 Jul
 2021 17:49:43 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::90) by DM5PR17CA0060.outlook.office365.com
 (2603:10b6:3:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Wed, 21 Jul 2021 17:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 17:49:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Jul
 2021 12:49:42 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 21 Jul 2021 12:49:32 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 12/12] ASoC: amd: enable vangogh acp5x driver build
Date:   Wed, 21 Jul 2021 23:34:28 +0530
Message-ID: <20210721180430.11571-13-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210721180430.11571-1-Vijendar.Mukunda@amd.com>
References: <20210721180430.11571-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f5905f9-d742-4f1e-bd51-08d94c6feba6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3117:
X-Microsoft-Antispam-PRVS: <MN2PR12MB31178CA77DA35B9147E8147397E39@MN2PR12MB3117.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OA+otcw923BxgRKpH/0tuG68ZDo52lmSRiFoYdXTXrf4ubnGBNTHEBBUdsMPCvFzdjiP/QFRXCH0WVHJl0LBV2Dhzg4pwSjW6lj7FP0T/e/GBSeoSsZMQSay6Bj74o3XNCLVnqS9Wdy7djQmYb9lD8ZaTem6ACOwgau9PCMRFfOApOw24ktasdrroMRzmyM4b7QxpBVg27qhUK7KdsCuZQs4HjiasA6/lP2oCJX0Rn6jXQisT5PmXVerW5EU8PWLSMSd6BqT3/a0SbxPT1F6i+syQ6k8sW2N4r3bqTvj5Pyjrv3GLMlpBqGW12/V5mzvwvJ7uK7G0iI8aNmQMpXCdmm/ZzPntRPdFXU2TYZqLJu39VYIHnmzClPtajPRLloX2q0CwTWIWHXD4xtJhKvjN/IymfYG7HpJtk1/7QyrJ54rYXv/5DOCnBuIMxg5uItajR0rnrG6jR70dvuZQ9yNgX8uiv7+lJtjlRAr5BJo5wYSZjdeje2cnxDfFR2mOdpCaxF+P8prXgqzPZeNm5dwPSj8ofPXsb9sYHBbB+onw/c/Z87DMga/jhGppJOrj2ZED44Z0NneoYmrmT8mwNxrw4mATSnsIVqF0lFftcZdlE7mZoNQ0399RbTIWGucqvSEgDGcmQl9JRX4t7CU3XlYWiu96ND8MPqxnuVyNwm2lFINhjbtSmNlqvqrSLfA8u9VaGUeadt87Q4YLKPunlZtJF7Wzu9468QgKkydy0dCDTNkzivNLLkp2Osz1NQ31jlDIiUCygUbIyJ2T6lNlztWuZkhUULiuz03dhhtYYNn+L8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(5660300002)(70206006)(70586007)(426003)(36860700001)(7696005)(186003)(508600001)(110136005)(316002)(54906003)(8676002)(81166007)(2616005)(2906002)(356005)(36756003)(1076003)(6666004)(336012)(47076005)(4326008)(82310400003)(8936002)(86362001)(42413003)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 17:49:42.7260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5905f9-d742-4f1e-bd51-08d94c6feba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijendar Mukunda <vijendar.mukunda@amd.com>

Vangogh ACP5x drivers can be built by selecting necessary
kernel config option.
The patch enables build support of the same.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig          | 9 +++++++++
 sound/soc/amd/Makefile         | 1 +
 sound/soc/amd/vangogh/Makefile | 9 +++++++++
 3 files changed, 19 insertions(+)
 create mode 100644 sound/soc/amd/vangogh/Makefile

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index ba5a85bf7412..49ff5e73e9ba 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -52,3 +52,12 @@ config SND_SOC_AMD_RENOIR_MACH
 	depends on SND_SOC_AMD_RENOIR
 	help
 	 This option enables machine driver for DMIC
+
+config SND_SOC_AMD_ACP5x
+	tristate "AMD Audio Coprocessor-v5.x I2S support"
+	depends on X86 && PCI
+	help
+	 This option enables ACP v5.x support on AMD platform
+
+	 By enabling this flag build will trigger for ACP PCI driver,
+	 ACP DMA driver, CPU DAI driver.
diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
index e6df2f72a2a1..07150d26f315 100644
--- a/sound/soc/amd/Makefile
+++ b/sound/soc/amd/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_SND_SOC_AMD_CZ_RT5645_MACH) += snd-soc-acp-rt5645-mach.o
 obj-$(CONFIG_SND_SOC_AMD_ACP3x) += raven/
 obj-$(CONFIG_SND_SOC_AMD_RV_RT5682_MACH) += snd-soc-acp-rt5682-mach.o
 obj-$(CONFIG_SND_SOC_AMD_RENOIR) += renoir/
+obj-$(CONFIG_SND_SOC_AMD_ACP5x) += vangogh/
diff --git a/sound/soc/amd/vangogh/Makefile b/sound/soc/amd/vangogh/Makefile
new file mode 100644
index 000000000000..3353f93dc610
--- /dev/null
+++ b/sound/soc/amd/vangogh/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Vangogh platform Support
+snd-pci-acp5x-objs	:= pci-acp5x.o
+snd-acp5x-i2s-objs	:= acp5x-i2s.o
+snd-acp5x-pcm-dma-objs	:= acp5x-pcm-dma.o
+
+obj-$(CONFIG_SND_SOC_AMD_ACP5x) += snd-pci-acp5x.o
+obj-$(CONFIG_SND_SOC_AMD_ACP5x)	+= snd-acp5x-i2s.o
+obj-$(CONFIG_SND_SOC_AMD_ACP5x) += snd-acp5x-pcm-dma.o
-- 
2.17.1

