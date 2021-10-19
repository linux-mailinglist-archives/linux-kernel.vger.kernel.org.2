Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58286432F00
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhJSHNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:13:23 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:17440
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234369AbhJSHNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKg/kEmiSd0sF64osz37SnnEOP3Fvaczj1zK1oz2ww9JnM7Skt/63AwhWjjZzOItOgym6cpCZD0bRo3qWPf/cTexCx4PPwbA7Jg85ouHo4UZqw4/HXzdrhAEZD2wdFln+IgUh5CsfdMjjSndNHcCoVfI0NKe64QeqasWDVZhKfQ6WoaPNIonrwALjoak7brLMoFF8tlXLpC5zKTiaOL4+/YWMJ1hT+2BEyjnCiBh9Q4CUHtWJ66n3WtCzwutEPmMnhj2yaLIuv7f3NXi+3DkBCfYvLVKmUykGSREi1DVohxR+QNfp/sV42jg3tfTM+ScvcJqWdFt5qH14FZNRTitLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2aNKp2xP70Tb4j+3sSlPPtluLKfcAqPl5661JQYpwA=;
 b=LyevA7xTb3ib0Li9y0VnnZbxaWJhBebINHzaW/DgcPMSZMkQ41gSjqQT6+sCsm5u2uc4sELErclQJUqpx9zVXQnna+d+956OcEeXs3W3rPqPBdh6CnA7dgqPPbyEiUj0DAx0010G1VWH0xA7m4Z/pzpRVI17o4phROl2qayp+vkC4BeXANB2scQgkDruDxMXF//TLHOQIeoen3byvlAEMNiDEJ0RNTACIqFvgH9JyVe5ei2f8JJ1BfQuGOxizV/uSWyrlINp6g4x7AQHE3JnARxZ6rRN3/PNSkqR6T5L/DtNJw/3tQTG+l2+Qz4vvdwRav1d7uxzxtEuAK2zdpapJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2aNKp2xP70Tb4j+3sSlPPtluLKfcAqPl5661JQYpwA=;
 b=XjqelCb6P5g5yIJA3gVf5ABx93LxMw5HE09knTXP/pvqa6cmTyXvdRUFEo8BCqmMGmMd3NET8kofsIHtI2EoYNGVf7e3cPVF575WissO0g3JlsG/ZDTskZH9PZNRrF3+Nn7z2JUXgZmFxgRXuiZkbouk3pWpMK0kXgIMscmJSJs=
Received: from MWHPR21CA0070.namprd21.prod.outlook.com (2603:10b6:300:db::32)
 by CH2PR12MB5531.namprd12.prod.outlook.com (2603:10b6:610:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 07:10:56 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::6) by MWHPR21CA0070.outlook.office365.com
 (2603:10b6:300:db::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.1 via Frontend
 Transport; Tue, 19 Oct 2021 07:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 07:10:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 02:10:54 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Tue, 19 Oct 2021 02:10:51 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/8] ASoC: amd: acp: Add callback for machine driver on ACP
Date:   Tue, 19 Oct 2021 12:39:33 +0530
Message-ID: <20211019070938.5076-4-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019070938.5076-1-AjitKumar.Pandey@amd.com>
References: <20211019070938.5076-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7210d573-3a95-4d20-a450-08d992cf9897
X-MS-TrafficTypeDiagnostic: CH2PR12MB5531:
X-Microsoft-Antispam-PRVS: <CH2PR12MB55316EA43A36F3D6A8A97F1B82BD9@CH2PR12MB5531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mh4DlAS45WBAJoLr8D224UZYWAeZ55ZPXHLpIJGbx4XvjrzBoHT4Q4fpJARIxVDKNt3EPWu07aN/m/CQoaqFzSlhkXwg8xXB7KXhVNbgWL24r/6sTKggxMGmRxpXTiAyDqHdEBOabYchJ3nLwI5iwTOCGBM3tnLBMIeRgrlhqKryhhbYoX3QAFF1N2aSlrDI948XhnDfvYwFsn6J0jvM9/QY8l+iWTiqZdyJTiaLYA6XVmZY3rRBh98ZAJw7jLljbU2vYtAlH/3RoeKm66NYvm7+ALgSk/5jWO6p9jgXCGqF8lgZOlrb3c0ViefsbooHaWYGlS2JkN5s2zapT/Mc+czaOCp0z489DmZN5OoUpE9mTUgnz6sqa9K9s5Qc8O/D1tsHPUJ//Pq4kdmDdqH8eNcMV5Iz/jF49DR34WbptxPGDfK5rfgCBAJE5FZuvHkE8QQUQ1XqS79g7pZi+gXrjw1ZwZiYE6u11ik95ElYRXmgHnGtvaFs0gvFr8X5ox0uRz1ZiHGh9VRz4fSn8mREPOOvsiEMZ116JkrwnrAdWZ0gJkuTN38DzcCrC7hB1nQL1ab2bIJ10Wzjjku07TmjvJIm7sHwszS3dAdHZE6XfXY2S67NK9/TJqr4svn8MwsrIF+xJntNGx/GthJOJpYO43d7hdb/h7Xv20Do5Xqd8wvibpXhV145YTRKgLAFzHolHwAb0tKQTUZNvkAjLOBfLM3qJQuEQVavPVs/M/42vJg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7696005)(86362001)(110136005)(36860700001)(356005)(508600001)(81166007)(8936002)(186003)(6666004)(26005)(2906002)(82310400003)(70586007)(70206006)(2616005)(36756003)(1076003)(54906003)(8676002)(336012)(5660300002)(47076005)(426003)(83380400001)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 07:10:56.4137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7210d573-3a95-4d20-a450-08d992cf9897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5531
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add method to select and register machine driver for acp platform
based on ACPI ID.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-platform.c | 23 +++++++++++++++++++++++
 sound/soc/amd/acp/acp-renoir.c   |  3 +++
 sound/soc/amd/acp/amd.h          |  6 ++++++
 3 files changed, 32 insertions(+)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index e79c05276d5f..75003d0a41e3 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -67,6 +67,27 @@ static const struct snd_pcm_hardware acp_pcm_hardware_capture = {
 	.periods_max = CAPTURE_MAX_NUM_PERIODS,
 };
 
+int acp_machine_select(struct acp_dev_data *adata)
+{
+	struct snd_soc_acpi_mach *mach;
+	int size;
+
+	size = sizeof(*adata->machines);
+	mach = snd_soc_acpi_find_machine(adata->machines);
+	if (!mach) {
+		dev_err(adata->dev, "warning: No matching ASoC machine driver found\n");
+		return -EINVAL;
+	}
+
+	adata->mach_dev = platform_device_register_data(adata->dev, mach->drv_name,
+							PLATFORM_DEVID_NONE, mach, size);
+	if (!adata->mach_dev)
+		dev_warn(adata->dev, "Unable to register Machine device\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(acp_machine_select, SND_SOC_ACP_COMMON);
+
 static irqreturn_t i2s_irq_handler(int irq, void *data)
 {
 	struct acp_dev_data *adata = data;
@@ -283,6 +304,8 @@ int acp_platform_unregister(struct device *dev)
 {
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
 
+	if (adata->mach_dev)
+		platform_device_unregister(adata->mach_dev);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(acp_platform_unregister, SND_SOC_ACP_COMMON);
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index c7fbf71e4669..82faae1b110b 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -111,6 +111,9 @@ static int renoir_audio_probe(struct platform_device *pdev)
 	adata->dai_driver = acp_renoir_dai;
 	adata->num_dai = ARRAY_SIZE(acp_renoir_dai);
 
+	adata->machines = snd_soc_acpi_amd_acp_machines;
+	acp_machine_select(adata);
+
 	dev_set_drvdata(dev, adata);
 	acp_platform_register(dev);
 
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index ecb53285526c..3532f4d3ccff 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -90,6 +90,9 @@ struct acp_dev_data {
 	int num_dai;
 
 	struct acp_stream *stream[ACP_MAX_STREAM];
+
+	struct snd_soc_acpi_mach *machines;
+	struct platform_device *mach_dev;
 };
 
 extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
@@ -98,6 +101,9 @@ int asoc_acp_i2s_probe(struct snd_soc_dai *dai);
 int acp_platform_register(struct device *dev);
 int acp_platform_unregister(struct device *dev);
 
+int acp_machine_select(struct acp_dev_data *adata);
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[];
+
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
 	u64 byte_count, low = 0, high = 0;
-- 
2.25.1

