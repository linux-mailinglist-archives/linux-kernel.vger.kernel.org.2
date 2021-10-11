Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44A428AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhJKK2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:28:14 -0400
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:50785
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235446AbhJKK2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:28:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S76EN/Ea/eej1IjKFJ0EZvU9j1KnKOyW7/MWo+9bp8NcmbdPLNPAvx7ceJU23Blub27gBMzs8y4PIdOQEV8fy0yWRTDHNSPqDa1RH1gGcg1T/DKibXJX0tOEa6W12dH6921+dyaBx0tWFOUzG3lOhpMzrm7nlo8Ld2TiPMS4pdpDA7YySFhdKsdxKvr0uBUq5CBWebEQYgQ9PXgJaOXdgtl9zyQwBy8S3q/MpaDVwls7p0MnpymBXK3J/XcY90Q0a/2KrBm99ykw3PmpYMRKB8RsHJzy9Q1r4wrAkrZLR5jWT/mebF0uoPBntd82PLl6cLUubtQm39GSYhjvO2fZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ohy788lN7PhcZpqlWk5mafws/xCTMncWlU3ga4rzue4=;
 b=ULiEGqvNdJZcziw6JxNi7nh8hcV8kG7pMi8+mOkxVwkkhEreNuLEDslcAmoHnzVWt0YS90caroDIvxcsaAAlLMZWoqIL//6qq/6dZ9sxULDuqy9zWRqGzlAWX17L7zr+NRJrYKUXsS/4h2OZzctyB2Q7//4jsG7QnFk5HqJDbZB2W46ZDMmJQkVfP329y/DeO+T5H9aFk9oc+BbM0VatGmd2+i6VFBX5hKGo1x3qmYv6vxOD2/SHFgOvSU7cEd/Zrjr0WhfqNAnbh6bISakadebSwK3YropxXQSKKCjU/lWgbZOjk7MCMWVqoaL9XTAHzaeX4r7OFPg5yejnXkMRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ohy788lN7PhcZpqlWk5mafws/xCTMncWlU3ga4rzue4=;
 b=JMCiA1umcoQW+ObpmHsQVLdz6cLQwirhY/p7RFOWCMzzjFxsS9hCOt2k9Tlv2v9drAbQg204QqF8dfO6Yxxv6PBH5pd83/Ry1R05nTklVnOcG5G2f4WwNwrVwC9X06bubOZyZ85k9m8tOKswSzia9nCQf7sOvbtXbiqfhaXyuxg=
Received: from MW4PR03CA0099.namprd03.prod.outlook.com (2603:10b6:303:b7::14)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 10:26:05 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::22) by MW4PR03CA0099.outlook.office365.com
 (2603:10b6:303:b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Mon, 11 Oct 2021 10:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 10:26:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 05:26:03 -0500
Received: from vijendar-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 11 Oct 2021 05:25:59 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <David.Rhodes@cirrus.com>, <wtli@nuvoton.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoc: amd: create platform device for VG machine driver
Date:   Tue, 12 Oct 2021 00:17:01 +0530
Message-ID: <20211011184715.61573-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06519952-4886-4426-9dde-08d98ca1883a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3708:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3708D0AADC5DD57A991C8E0597B59@DM6PR12MB3708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egSUCmnJLgoysc1JhlSlGVG62jV9noksXieZnZOvR4cIrYLSNvygRDwm01OncWIKQ4yAFcOCMTj7CmqNvu/vOFwpz5x8vhyxb2nDtSyckCZIoBl04h6LKDR/EOlNAdLlAuw2CXlMkk+/UHAcIkuH1pTW9TJ0i7x7HCQ/hUofGGx/K0REJpCSNEIjtnpr/X6eAeb38wFujZOlsGx1q924wM53k39kYB3p0aJ5o6QbOXaNpWUH9UVyprCFa3NMG2ssrQD1We6Xv3hZWWmjCqktT9A41/ducQw8U1+6KMax3hb8/4Dr0kkYdXSMV9TtgvCNqRuLyH5gfSruPbzyn0fRYp2PmjmpL559QEoFgQnD8fqpS/7zzF66tAz2cUuMELtNUXhOI/GDIxrg4aHoLad7LT8lfJTZL1cGZ5f1CEt88t4YvRs+k510MdS9kFwQkFN9ua5gSUWH91PSRbQRe1PZGZFEzXM7rT9U9pL2zMvCse/e+kUh4wFQ02Xxn/54Gn/LjkE9NWDZGiGYiQKhtchJ6xb/JvN//gUdWc8UWptNZKlpqrAJe3aA7zltkAxNoOECz9N0SqVZ2SToIZqaicjhBdjJw1s7nvyRc09GG9nUzl6AWGXIFfvhjGHPjTQG2JNfNtF4TAY644DaBc5Gu2U5sLxIoQUPSSbR438viqeEQ1C0LB6yHJwqBbeRHoEV6jpEA9HlH1i4IbobBgPPBaOezUC21U3E9L4VPRDHwm9D3OU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(83380400001)(70586007)(36860700001)(70206006)(86362001)(356005)(81166007)(47076005)(82310400003)(2616005)(36756003)(336012)(26005)(426003)(2906002)(186003)(4326008)(8676002)(508600001)(1076003)(5660300002)(8936002)(7696005)(316002)(54906003)(110136005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 10:26:05.1242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06519952-4886-4426-9dde-08d98ca1883a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create platform device for Vangogh machine driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x.h     | 2 +-
 sound/soc/amd/vangogh/pci-acp5x.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index a808635f9740..fe5e1fa98974 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -23,7 +23,7 @@
 #define ACP_ERR_INTR_MASK	0x20000000
 #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
 
-#define ACP5x_DEVS 3
+#define ACP5x_DEVS 4
 #define	ACP5x_REG_START	0x1240000
 #define	ACP5x_REG_END	0x1250200
 #define ACP5x_I2STDM_REG_START	0x1242400
diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
index a57b762d9f2e..137e64c47882 100644
--- a/sound/soc/amd/vangogh/pci-acp5x.c
+++ b/sound/soc/amd/vangogh/pci-acp5x.c
@@ -213,6 +213,9 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 		pdevinfo[2].num_res = 1;
 		pdevinfo[2].res = &adata->res[2];
 
+		pdevinfo[3].name = "acp5x_nu8821_cs35l41_mach";
+		pdevinfo[3].id = 0;
+		pdevinfo[3].parent = &pci->dev;
 		for (i = 0; i < ACP5x_DEVS; i++) {
 			adata->pdev[i] =
 				platform_device_register_full(&pdevinfo[i]);
-- 
2.25.1

