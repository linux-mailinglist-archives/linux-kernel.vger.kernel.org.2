Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13424439094
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhJYHuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:50:46 -0400
Received: from mail-dm6nam08on2086.outbound.protection.outlook.com ([40.107.102.86]:55361
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231802AbhJYHuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:50:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+G7G+Gg4Pap8wKb0F5tqYJ9QHKa6E5c9vs6IiPlsBnjxxdrXyE5zs0d0H0w6nLTCM4igoJO6tN8GMpZokbvNzwnQkuIcC6j1ixgTFYrZ9mMbBwSwGbqkR0jRiTOqbUvcO+inRw6pCLsRlMcLbjMjr508N7s6wbFOADn+m3GPIHNRNo0DuPSHyh1w2/TbSqijPWt9jkvJ9Zap5RkNrjw9fi4iKT+Qpv3Nhj58n58Qsk87dzXK64UAENYcf0eLBdG5VoMfheHdiHBpQks9YyHTOV8uOEpmFyV3WJ0hfMVN0GggkFkBEik9WGxo3dScPpSFPBvq3BNUJDWaTJ8UmznwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HcZMDEJ1gIEY+U6R1n4XrwXKYBUUsZLKJpW1P7oEz4=;
 b=YRRPscKy6vJTFbdV1AG5vJ7p4x9pXpSBXA9wyl0ADgAVVJUIXCmnc/LjUU4BPsUET33bU/c8q56z34yeRkiKmafDy2YMTGJUGd42K/7aYIJOdVrCPeeZEHF2GDtVfaq4g+CbwvIcVSM6sccjzk295NG1fR7A3umGkMEFj7OsVxyN0DGWmiwIFBX2ODSJdWTV2H9q2vsltPXxjj9Ten0i5pcOVvlHq196JlR0/gm8kjg6VIvay66aN+4w1yqintXFJv3C75VWRaaDGdu5NWBYgziTFBY9yXWn8w+RDHsEeOfMhmRseQa0EXpcj/NhnCt0kDehyEawJE0TXGQzVSBSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HcZMDEJ1gIEY+U6R1n4XrwXKYBUUsZLKJpW1P7oEz4=;
 b=PkqZ8OlVS6EWG25pmDtScppI9Ydjzajh7so6TB7AqeQ7/HFmBBsgGmACc7hAYUdonrhxbvfMzZGT/xMqbfse9+Kufh+VPYgqFb2jFcEOvmDpz3lRGxE6NIqEZJbwok0lESb5wLUg9zf9Y1z6UEIxu+M3Fb76hxdyGfKQ0CbitbM=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 07:48:20 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::d) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20 via Frontend
 Transport; Mon, 25 Oct 2021 07:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 07:48:20 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 02:48:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 00:48:18 -0700
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Mon, 25 Oct 2021 02:48:16 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: Add acp_machine struct for renoir platform.
Date:   Mon, 25 Oct 2021 13:18:00 +0530
Message-ID: <20211025074808.471333-1-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fe2a4b9-99da-421d-9e65-08d9978bd077
X-MS-TrafficTypeDiagnostic: BN7PR12MB2836:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2836C6D3EFEE81B6E48D409482839@BN7PR12MB2836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dmdnpzq5Tx0W1rf0RfJg04xL8ZJeS6MSLtoGyRQ358BdH0XXNr8xTh3tnqMltp2ZilpZh1g+wdynY82u0UekQPFAO3M7J1N5pzvBxryYbvCndODFJ0uAlcLUR9c5h7acfQZ4hrnCE1cMGmy+QKBJ2BJWIrxEQ2BJTqJ/X2hbVVi8Z45i7m0UpisdKzAkWPa8Wq8RvjuDDNS/oGcZafbOC6Kt9xgIPJaXdiDQmVrgaoFyCmAgj+mW5qpc4jKJpx8ghhClY7FTqTcAuz4db+vTwEyUl7u30GtjDNh4yIrB+3SUtnO8stKHxu5UEXynUw+gfRam4RP7HLWaE2T6fE1ZmngqF1/9QuIea5tTWWnIBWGechXYeGhREdwzMRmg4GV+jmAIRzKoitc8frkZomsiWHyujJqfyJQt4TBUeH+zpOfaKHt4BPhTyqZGqLIsz3LJr767m3cNSAKcbpl+R7Smpt8IAnRi6/C1mykSJ3xAfVu71iAZprTvT+FPKMo4LFsRzZ/M4P2x1oK3eg/3Azw/sZY2D55LIK++SybuThh3EU78pvxsKQBDFLOU1Yaym6E7wNx0wKmqjU7cb4LrrTuxKZXPoIpSF624gLiJSnVdc73rk3zpPCZaZemuzLWKveVLFUiFthn2P6plHR6REkXzfXE9sQqO0/PNfg+MxFlBSt1bcXWh2Yp24/dXQDwFsyzSSXFxg/AYPR8n1c3dXaXGOtJHZglMdd0JuhuA3byCcWI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2616005)(426003)(336012)(47076005)(86362001)(186003)(6666004)(83380400001)(82310400003)(356005)(70586007)(508600001)(26005)(36756003)(8936002)(36860700001)(5660300002)(316002)(2906002)(8676002)(1076003)(81166007)(110136005)(4326008)(70206006)(54906003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 07:48:20.1755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe2a4b9-99da-421d-9e65-08d9978bd077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2836
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add acpi_mach struct for renoir platform to select machine driver
based on codec and amp ACPI id.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-renoir.c | 19 +++++++++++++++++++
 sound/soc/amd/acp/amd.h        |  1 -
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 82faae1b110b..9b321a055b52 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -25,6 +25,25 @@
 
 #define DRV_NAME "acp_asoc_renoir"
 
+static struct snd_soc_acpi_codecs amp_rt1019 = {
+	.num_codecs = 1,
+	.codecs = {"10EC1019"}
+};
+
+static struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[] = {
+	{
+		.id = "10EC5682",
+		.drv_name = "rn_rt5682_rt1019",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &amp_rt1019,
+	},
+	{
+		.id = "AMDI1019",
+		.drv_name = "renoir-acp",
+	},
+	{},
+};
+
 static struct snd_soc_dai_driver acp_renoir_dai[] = {
 {
 	.name = "acp-i2s-sp",
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 3532f4d3ccff..8eee3d34774b 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -102,7 +102,6 @@ int acp_platform_register(struct device *dev);
 int acp_platform_unregister(struct device *dev);
 
 int acp_machine_select(struct acp_dev_data *adata);
-extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[];
 
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
-- 
2.25.1

