Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE14542865B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 07:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhJKFmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 01:42:17 -0400
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com ([40.107.236.69]:28321
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234040AbhJKFmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 01:42:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMbMtG8NDsbm6ekXoTf9HME4rru/du8udhyDn4zDA3atJH2Dku3lwSCB6irYqWReOwihWVyBkKUf6atYBA1ohpXTaMj035xW6gtSTd/Vm6FOugInMEoMExmmPPcuohtlwQ2Fm4JSgoRHb1dDz980urkG8ql5QlyipmFe5rjwKagm6r6kxqrSCrs12LEw+uDqVi+1Pjea9HdcFlEtNAIACvkeLEkdBPSKrwbXNa1b6ZjdTGEd9vCeWf9hjCn5sm4Ozeis/gbw/iWjtTlZtWiiNmftAqaX4k3PFSLipXN8xeNvUzMfrDcPT7P4SPWmdM9ZSGOBbF9d7Pc2jKwQk6p23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUpL4eafriwOTNpGLtKv7Begs7h9B8kBkqyaMCmbU60=;
 b=j0/FNUX9Sv89GzzYoyRk+HOqgsEENjbhFt9ySL9yYJ5uDBZRp0Vs7tjyzZL1zrX8+DsRcQ1S7juA38XYykeBtQUrBg+cOsHRh7pcJ1Id+bV/PBdb1fcu6dBsjJieJFfOz1t3q6fiGThRY6U8RrkqoRT5GvKFs+KKjteC0kYQaTbqKuR9/7HLZSdD+Y3Z/RBNEG93Htdag+D/qZUGpU0NHSm0HsM/MQRdaGIxRmZfhAvTVvqi6tJHvfy8EuYVNqWByIb0OJVZc3MJG4tr5n2+mgabwVFliTdIGScrd/FHor+6tZOLiU0+ig82LIIClpZJ6hxEv5MJ4Y3S+Kk1Bxilnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUpL4eafriwOTNpGLtKv7Begs7h9B8kBkqyaMCmbU60=;
 b=U+i7ImM+gyW1dKfJupz2Aqn/R5fvId5v9ZkTHfvf+25Y1T3vGQANvX/eJhZbudeRtB2eN3Ph83eYYuGqE0BRCabqQiJOtApqMs/yBL2yqIqG4ybBAj16mJxcR2JuCkMHVi61+hAuy//unpJisCCU7NXXxlATSTOUhLmjBhvdpJo=
Received: from MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::7) by
 MN2PR12MB3758.namprd12.prod.outlook.com (2603:10b6:208:169::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 05:40:14 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::b3) by MW4P223CA0002.outlook.office365.com
 (2603:10b6:303:80::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Mon, 11 Oct 2021 05:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 05:40:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 00:40:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 00:40:12 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Mon, 11 Oct 2021 00:40:08 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mario.Limonciello@amd.com>,
        <Richard.Gong@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/13] ASoC: amd: enable yc machine driver build
Date:   Mon, 11 Oct 2021 11:26:21 +0530
Message-ID: <20211011055621.13240-14-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
References: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250c23e3-c6c6-434f-2fa0-08d98c7998fa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3758:
X-Microsoft-Antispam-PRVS: <MN2PR12MB37584A37608272168C4B0DAE97B59@MN2PR12MB3758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/alo1HmBoQBkQsw6/4gQ9yxgRhJzwonwQgsQYcBJ0z2BCn/cer/Xv1SAAC0+Ymcze9lbRo6AIuLnsBtX25a6jBFpf6HK44tALY0dF5icUEseK9aaOaWI/LW2Ef9laEH9+f2NTLteDnFqo3XXM8J8M+7grhJ++GU1wCOGhsk62r6tavtRq3GmngiKtCsJ7DzPbgEJIEx+SqWiEcemVdGuvF8Fb/JqtS6vMkA5dTI70OCCI+41yz8HR0+KlyPVZ1dwnC2ABZ8FwV/p3ENmp3icIsYQ04v1EP01ieKy+YNV8NMEdZi3EJQHdX0xkBCR+NE23Dlflx8dtXHEaGkPIsECJkorBaApIy//8yBpmK9Yy5DQr9CI+pHUjSuMg06nYINHcyb869YDWmBfbk3w9kVOPYW7oGLoVgWRNqI8U09gTsLjpOSgYgx4cUoDE7Kxjw+REy18rEJ4+oewNfP9Uvx36QSDa0C1vzO4RRlQoNNM3ixd6RnOfbgepTYYo50JN8Kzmy/tES4cAxhP/F2p1nzoN8PLDt8Lo/GNedtC7w20ZzuwjH34tH8BIIucMr6vxYFPAyssWNWDtcDOFxMRwfQEj8WMoWaamJaHOLG2ULjBfIcmm9dV8pWg5wtNyDlzkD5RmnmvRz6LzbwggStTuqq6+S690DbIeJoZlGAwGN3WuzTRQHxzz455xo54DdRIw5O/GDVXeou18AA6DTLwJ26Tsodhe6XhAe/yV9CsP5Dv6M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(5660300002)(36756003)(426003)(6666004)(508600001)(7696005)(36860700001)(336012)(316002)(2906002)(8676002)(356005)(26005)(82310400003)(186003)(70586007)(86362001)(70206006)(8936002)(1076003)(47076005)(4326008)(2616005)(54906003)(110136005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 05:40:13.3651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 250c23e3-c6c6-434f-2fa0-08d98c7998fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3758
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable YC platform dmic machine driver build.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig     | 7 +++++++
 sound/soc/amd/yc/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 42825e8ad2ad..864d80f14421 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -67,3 +67,10 @@ config SND_SOC_AMD_ACP6x
 	depends on X86 && PCI
 	help
 	 This option enables ACP v6.x DMIC support on AMD platform
+
+config SND_SOC_AMD_YC_MACH
+        tristate "AMD YC support for DMIC"
+        select SND_SOC_DMIC
+        depends on SND_SOC_AMD_ACP6x
+        help
+         This option enables machine driver for DMIC endpoint
diff --git a/sound/soc/amd/yc/Makefile b/sound/soc/amd/yc/Makefile
index 20f8dfe6abb4..dc2974440388 100644
--- a/sound/soc/amd/yc/Makefile
+++ b/sound/soc/amd/yc/Makefile
@@ -2,6 +2,8 @@
 # Yellow Carp platform Support
 snd-pci-acp6x-objs	:= pci-acp6x.o
 snd-acp6x-pdm-dma-objs	:= acp6x-pdm-dma.o
+snd-soc-acp6x-mach-objs := acp6x-mach.o
 
 obj-$(CONFIG_SND_SOC_AMD_ACP6x) += snd-pci-acp6x.o
 obj-$(CONFIG_SND_SOC_AMD_ACP6x) += snd-acp6x-pdm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_YC_MACH)   += snd-soc-acp6x-mach.o
-- 
2.25.1

