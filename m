Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AFA426602
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhJHIgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:36:31 -0400
Received: from mail-sn1anam02on2052.outbound.protection.outlook.com ([40.107.96.52]:16452
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229873AbhJHIg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:36:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOJ8r/2s7shvVteW4Ef9bDWfy7UJVarodcEF+5qfNUPbpcNr6D6Il+NNddPVeIJbWySl1GjruOm7BCrRDqr2n+lrWkqidW67NSejYsk2XWKBc60wWUeZECNwEjWLK+KizcEqgH7dtADtZanLTy63nAbZHYqtuRf+F3RvfMBsKcZE4IKBUcWweZhAmSi882/ZARgEAJmeA+Y7F2Mr8xjGwqWaIsntiqu6fvBYQON9Q6nqZnaQNXedTChJn/PdI39pQxnYmP7JoWqw2bjPcvVzFHPHCFrEFR/JByiSNTNb3Xgylz5m4ApQ1WH2IsBkG0w6nvFKbUz5RpSENm+dXH/KUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVgtFpRgbrSBIy2pBz4yQCQhjFZ5sI3qV7ogF809N7c=;
 b=JGiXxm2GLDEEqN7y/fGQt5H3TFtwUV+n2AMmILRck2P6aoOg1jphgBCuxw+KIVpk7doB0cRVaVFtQUZ0nidEzU2t6xpg0l9bLgHnOWyWH6o6J1JAZcnl0A/0Z5YIi/KmH08MAWisWJHRkFZ3RMRUy5XQLUDO99TnuyAHMpVmk5rNxfFLnYkAzBGbsRZICRA9xrjrgpCmtQeoPvceaSOxVt0iP8e5latrq3PAk0+FOKZl/rs3H+mRI/B1KwrwUeXHLUbJUiKd5tDfEgshwkMAVHQq75s+1sooycTSx143+Bej2RXw7aVjUUHoiCDOmayJCCHpYafhFV4jg62Sil7eaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVgtFpRgbrSBIy2pBz4yQCQhjFZ5sI3qV7ogF809N7c=;
 b=MCJfcu7asvTLOZepbJ48x0+TeqbBdkP/kwSskDjRbeyPsgu8tp8Zcehtb6Zom47+JxSBwl14AdkdCRU0t39erFP9CbHMhCOgyiGJ2iz1SbVhGnOtOLkybTXL1mhUeUzyBDNTh70/1QwwPRF+6WXFjc5sXXOoEFyehJIB3tH/tnc=
Received: from DM6PR02CA0061.namprd02.prod.outlook.com (2603:10b6:5:177::38)
 by SN6PR12MB4752.namprd12.prod.outlook.com (2603:10b6:805:e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 8 Oct
 2021 08:34:32 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::c) by DM6PR02CA0061.outlook.office365.com
 (2603:10b6:5:177::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 08:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 08:34:31 +0000
Received: from amd-Mandolin-PCO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 03:34:28 -0500
From:   Sanket Goswami <Sanket.Goswami@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] platform/x86: amd-pmc: Fix the build error when CONFIG_DEBUG_FS is disable
Date:   Fri, 8 Oct 2021 14:04:08 +0530
Message-ID: <20211008083408.8497-1-Sanket.Goswami@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8b203a1-2cc2-4c43-4c23-08d98a36736a
X-MS-TrafficTypeDiagnostic: SN6PR12MB4752:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4752F97AEC4970BE5549A2169CB29@SN6PR12MB4752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:338;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oncct717FrLbn++btY3q13TaOSk8uerCFiSOJQAxSUXTbqnOa5Q/yTrSntTAmKYVFG6DsXIKbZopu1b9SOcXZbWWUhqCeXUrQW3DBPH4r1K9Ht2WYV+alwiI4uC9+dKgIGzt909OcthFP2diyxrxdSjeXWwjaDwZ+3Mg/S12hpx0rBZEANDlLwQBe3+RAcY9iCZfpEKiVBcPtcw8WUFTt5QvfGdIao64C/HrcV4sGbmZhXap5RL0vwhBWIbiJXs3FgYioYNmkWuHPfxCyhGUZ4TFeOww9EcivBYmp1a7XCiS1E0FC+Y8Bi+4xFzzkBYE/yAzUdCJYuL5RGNL543uB7UPE6tlMESwgwJ/Uj6w2+NJEHEKNRR459W/nKMLVsf0TLNijngb2UuQqWcRgBhItdzXGg757TsHrabmQv1JPuLfbzGzOQkHZAxS3gp0ki5YBGIBeBJREDbLhVfc+Cl9WW98AIkFQGuiN+1BjO5mVT/kQDXvtU7GeCu/trfl1hCMSt0BEQmJVmuiVCbM6tYqMmlN2eDf+oQ4H5qg1lUkqqzC6jA0nP/jbAB5FjUx5bbAJ8jp6oe9NLyWlPPVP4aGu6IicKgEyDqYxl0FCRLEPkXyxHiIMdd7kTZaO3Ue4AHrkzMChkb+fg5VrJyQ1ADoH4Zu6+J1JWy/TppgKXqAxGKgW+7SPi1F2wvBM/TcnW5m5b0ZEFx+iTMACPk3vLVOjKpcL2fofcIMP7CuJfjS88o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(316002)(2906002)(86362001)(54906003)(1076003)(36756003)(356005)(36860700001)(7696005)(508600001)(110136005)(2616005)(83380400001)(70206006)(426003)(70586007)(6666004)(186003)(5660300002)(81166007)(82310400003)(8676002)(16526019)(336012)(4326008)(47076005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 08:34:31.7329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b203a1-2cc2-4c43-4c23-08d98a36736a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4752
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that when CONFIG_DEBUG_FS is disabled, amd-pmc driver
ended up in build failure.

Re-order the routine to solve the problem.

Fixes: b4a53d6f61eb ("platform/x86: amd-pmc: Export Idlemask values
based on the APU")

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
---
 drivers/platform/x86/amd-pmc.c | 86 +++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 91c1f1c6c929..88cded2fe680 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -155,6 +155,31 @@ struct smu_metrics {
 	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
 } __packed;
 
+static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
+				 struct seq_file *s)
+{
+	u32 val;
+
+	switch (pdev->cpu_id) {
+	case AMD_CPU_ID_CZN:
+		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_CZN);
+		break;
+	case AMD_CPU_ID_YC:
+		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_YC);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (dev)
+		dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
+
+	if (s)
+		seq_printf(s, "SMU idlemask : 0x%x\n", val);
+
+	return 0;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int smu_fw_info_show(struct seq_file *s, void *unused)
 {
@@ -210,49 +235,6 @@ static int s0ix_stats_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
 
-static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
-{
-	int rc;
-	u32 val;
-
-	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
-	if (rc)
-		return rc;
-
-	dev->major = (val >> 16) & GENMASK(15, 0);
-	dev->minor = (val >> 8) & GENMASK(7, 0);
-	dev->rev = (val >> 0) & GENMASK(7, 0);
-
-	dev_dbg(dev->dev, "SMU version is %u.%u.%u\n", dev->major, dev->minor, dev->rev);
-
-	return 0;
-}
-
-static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
-				 struct seq_file *s)
-{
-	u32 val;
-
-	switch (pdev->cpu_id) {
-	case AMD_CPU_ID_CZN:
-		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_CZN);
-		break;
-	case AMD_CPU_ID_YC:
-		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_YC);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (dev)
-		dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
-
-	if (s)
-		seq_printf(s, "SMU idlemask : 0x%x\n", val);
-
-	return 0;
-}
-
 static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
 {
 	struct amd_pmc_dev *dev = s->private;
@@ -295,6 +277,24 @@ static inline void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
 }
 #endif /* CONFIG_DEBUG_FS */
 
+static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
+{
+	int rc;
+	u32 val;
+
+	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
+	if (rc)
+		return rc;
+
+	dev->major = (val >> 16) & GENMASK(15, 0);
+	dev->minor = (val >> 8) & GENMASK(7, 0);
+	dev->rev = (val >> 0) & GENMASK(7, 0);
+
+	dev_dbg(dev->dev, "SMU version is %u.%u.%u\n", dev->major, dev->minor, dev->rev);
+
+	return 0;
+}
+
 static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev)
 {
 	u32 phys_addr_low, phys_addr_hi;
-- 
2.25.1

