Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD53F431720
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhJRLZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:25:20 -0400
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com ([40.107.236.86]:51424
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229657AbhJRLZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:25:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1VMT23x3fjqjithgmaB5mKRjoT4W781Blpdww5edBD7CW0A/8q3nwS0Lv13F/6kyagl24F6sYPQW4eTtZ4yLTDTGDL4O9lySfPPupWcsflDMzX1HlkxQgA74J/T5JNs+z9xY54GijCT0ExxfaCnkPq65kasNXY5OTP4gZJd9FVRr7B8P+R+bfu10T2jfSzB+YoHKX+lKe/8keRCSuap110R+22O3vaI3U/GT8GvK4yZF7AMPMahCPvIXvd64pYsaesxip0Yt+K9LS2kah9Paqa+b+JWLNxmr1808N6238LaHDq5Wczkcd2gETtlKEozLCqDkWhJDgUU0RHwdM6NRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqLekTLE2zjOa+RoPB8us9PJEa1TWO79JHWGKa6VGDk=;
 b=FfqLiG2x4xO9r9GcRd5lJByRFntjQ1ue7JeDuxzJoFXxw7ARbBMjHv23hcxUQwRfBcbRl+2MmyNbnIk+qqhBj2Fxjfmwf2pmp6Q9XBcitqE1kp/reXKLtIWcmwXMlSLurWxiWDSXRJdnz3U+ZgZo33JQ5YlS/OBJ4fFgW9+/N4pBCDoSLvJWCeRg6jZP8t4bxa8nKFYbqDw0h58BOYqzpHBkkodJw3NgctuwnckFp2X0Kl2NyyG3GAf65OOHhYLDhUxmZtD/5PjXV+LDZqKMZut4RFomie3uHws9Mb1TCyIC2rl7AMiWwHSd4LN7GQFHiUnUrkb3egkKNpMIsedTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqLekTLE2zjOa+RoPB8us9PJEa1TWO79JHWGKa6VGDk=;
 b=FZhmP7SOFGxua76JAMXufGNWiBMD31EkIMw78Ec3EdUbUdLhxotMYGtpoEZxAsRrUULbSCUamh47ITKX3wS5TVaUCmjHKpLjywzvwN/ztQ4VYUJInxZTwUofJN8MuQ2zvix5gSGk8TAEavX+dp3xolcKaplEF1LGTAcriEFUas4=
Received: from DS7PR03CA0342.namprd03.prod.outlook.com (2603:10b6:8:55::14) by
 MWHPR12MB1358.namprd12.prod.outlook.com (2603:10b6:300:d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Mon, 18 Oct 2021 11:23:04 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::4a) by DS7PR03CA0342.outlook.office365.com
 (2603:10b6:8:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Mon, 18 Oct 2021 11:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 11:23:03 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 06:23:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 04:23:00 -0700
Received: from vijendar-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.15
 via Frontend Transport; Mon, 18 Oct 2021 06:22:56 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <richgong@amd.com>, <mlimonci@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 11/13] ASoC: amd: create platform device for acp6x machine driver
Date:   Mon, 18 Oct 2021 16:50:42 +0530
Message-ID: <20211018112044.1705805-12-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211018112044.1705805-1-Vijendar.Mukunda@amd.com>
References: <20211018112044.1705805-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e95e4c3-75db-4518-76bb-08d99229a6ab
X-MS-TrafficTypeDiagnostic: MWHPR12MB1358:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1358C6A76122D22FE79AC99097BC9@MWHPR12MB1358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZY9TbmSWN9EgKojCECHpZYzjdE08juzTSVuOu9joM6gPPBbVmVrW23XmbNq/vpfuE8kmbfD9EZtA1YkLNeIIlvmqhULJZambN+9MWLdXOXUL8VYsGrgdg+EDYqr7qZSezoGIHEV8kuFRAA1ykLYUlGgxqo06Q9VrDwMuojULL4tP4COYiiLpRlam+PavGc40z//i6ThxQKU69j46nZS6sCIJgvcXMcDB6t6rZJoLiTe6EEaQq/ogF8S46bWKq1Go3Iy107XbTQK3Gp1ZerYwjvqYIhIYJAhN1b2hpzleCAG3feFznf8cnFfKJyJBoUqbDG5AwkltzrNSDoZ3VJY54O97vcm+V9DrpLE3i8lV/4dDQMDesRUv0tw4Z1D+eR64k18mxhhJqgTpSzhtK0lSOWbuhv4RqGDRQm4fIZwPnQyQC+9c3gQEjEgqg00fBPvOvP7YdwGlTCT3UnV5oldtuEYhEGrtqdfMf7yGgoYJ5Ffp1Mavd8yBg13+Q1VThfdtch0kLfdmywSxda+quPln4aIQhoRCxf5O1NQajAeIpUEWKQ3z3z0F2NMlWDql/4/DhvxT7r/axlz5DCR2hXs3VNV3nB92yIEN8ifUBtW3RmW8DgCka3J3dLHH2NQILmgteDeBr+b7Pfaw4TUIfIe1lKe5fbzfZHjaAEyM3EIuCC8v+BdoKMnUTH92Tr8fdQDVvp8g2bRKO8FFwz0SYkwTEkTCkC3EhEXdxN2wYSjtcJ2lQt3xYfmnHvy9GVnXtKzdN/kMMdeDGmqRrlAbUFx7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(186003)(336012)(26005)(426003)(7696005)(81166007)(8936002)(4326008)(83380400001)(6666004)(5660300002)(508600001)(70206006)(36756003)(82310400003)(8676002)(2616005)(110136005)(2906002)(54906003)(316002)(70586007)(1076003)(86362001)(47076005)(36860700001)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 11:23:03.6475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e95e4c3-75db-4518-76bb-08d99229a6ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1358
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create platform device for acp6x machine driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/yc/acp6x.h     | 2 +-
 sound/soc/amd/yc/pci-acp6x.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x.h b/sound/soc/amd/yc/acp6x.h
index b0d3f6a9d0ce..74b596e6807a 100644
--- a/sound/soc/amd/yc/acp6x.h
+++ b/sound/soc/amd/yc/acp6x.h
@@ -11,7 +11,7 @@
 #define ACP6x_PHY_BASE_ADDRESS 0x1240000
 #define ACP6x_REG_START		0x1240000
 #define ACP6x_REG_END		0x1250200
-#define ACP6x_DEVS		2
+#define ACP6x_DEVS		3
 #define ACP6x_PDM_MODE		1
 
 #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index cf02c542cf88..957eeb6fb8e3 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -223,6 +223,10 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 		pdevinfo[1].id = 0;
 		pdevinfo[1].parent = &pci->dev;
 
+		pdevinfo[2].name = "acp_yc_mach";
+		pdevinfo[2].id = 0;
+		pdevinfo[2].parent = &pci->dev;
+
 		for (index = 0; index < ACP6x_DEVS; index++) {
 			adata->pdev[index] =
 				platform_device_register_full(&pdevinfo[index]);
-- 
2.25.1

