Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664E2422D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhJEP7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:59:01 -0400
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:44704
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231513AbhJEP7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:59:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7ZZbVLiviJ08f5JGPyl5tanCfL8oqzarFcp4pD7ooneQBJaROsYbYxUqRiNoCoAgvqGeKxiLLawJ+FNelxvpZJOTobJnPeOaBQBqd/BHetDoM+batAUvYYcZfcL8l1i8xC+lWck4rIWLaYG2bVY1ZeXXMr/+4/MpsbMGu3LPYCqytaaRujdk70cEDlE3lyfH7o7HJDSHcuDjcGcAEjD7e9DHu2qBtkhAxVd8xl6JP9xGZdga/qpN1+bmljbV010j/53/bw2zeaCt7MgpY122NxQU7Tptaeus2eKBy4E54gcUwMy4U8OZHFIBXMwQy15MNEGtIUO8CntsrzdQEmjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30iHlsis5640VTLyW81v5zEeWdZjkJAFYDg6a135Sw4=;
 b=GlVZPajRfBaiZcGe0Bpo4TOi/5IY+o4d+H54W6zrx1p7jqxuqgUKu8/jwgCxHEaQ5QMXs1lcl04XXqmDerrQs5t/kjo6FC5jSjPs7Ceqpz5O1jkta94UgZFz05KR2W+fy7iR05sdGoOrokPhGF3T06NgnUrvRZAO0e2hKB2N6YApHsnH6teSPDYG5TkTIuAcCIPVDbAKQY9sp1bRuVDTgI5EStyDKJjbwpqs2C+MvxsLmdWt9YvrOQ5r/Vs+1XcRkgbQRlSy5GSkWy2BVqvdDw08U12v5EkKGiHCggiHUhHUdHptzaspZ5he0HKdRvwecVRtuas8A8FK27b/JF4tSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30iHlsis5640VTLyW81v5zEeWdZjkJAFYDg6a135Sw4=;
 b=J05SW+ePAgaW+bVVKEjaq3dH4Ngw9izIX0w/cUPMVOKlwzitXlDyO/xlYR8HC4QwTvImiJggtF1qLWYUQvX0xrYmDZiQXsffCrmXIxvGPxweTpi8ESnyT9wXo4x3f8kXcBWA36NjoYjiZ+LPxFpdSBPeCiQkp2NVoxVFmQV0nHE=
Received: from BN9PR03CA0860.namprd03.prod.outlook.com (2603:10b6:408:13d::25)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 15:57:07 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::75) by BN9PR03CA0860.outlook.office365.com
 (2603:10b6:408:13d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 15:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 15:57:06 +0000
Received: from amd-Mandolin-PCO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 10:57:04 -0500
From:   Sanket Goswami <Sanket.Goswami@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Subject: [PATCH] platform/x86: amd-pmc: Add support for AMD Smart Trace Buffer
Date:   Tue, 5 Oct 2021 21:26:41 +0530
Message-ID: <20211005155641.2308-1-Sanket.Goswami@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18f89310-90f9-4cfb-5fd2-08d98818c830
X-MS-TrafficTypeDiagnostic: BY5PR12MB4920:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49209783BC3965A6305C434F9CAF9@BY5PR12MB4920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pn8W9lW9MzlK2xu3PW6x/OxOxXGH16IkjNtW3Wx65129bFvfmUgwYEbQoGOWI+toSajezaM2imV2Y3eo0V7aNiqvlxImch4XcGDuQJcsPSx34nuHMWZAAgo4/5qEkqAlPYo/JZvtrXdMaDYoSNQGwQXOsVsi98JCRJDxII4fdn1MZ9FRnEepwrNgmYbrXrRQY+80ClRReEHSD4UotuAHNxPk1JlBkmtmM7JBFIPVRQ5JhHNtpSDBWfgfbrMnR7+cijId9Y0oPg78o32+jxO72ppqn25IMJNzouhBuMNARNKFia0mSZzFLQv6r1I/iBEkP9Jl+UgxRnT4VqouiYYlGW4/zbB/956PtNN6MfgqZi6d8RYpC53pB4FIt9P5ZqHZ/KUsqnqxztWuyXo9fRr0Z4mXUX777Y2bJq5CkPSx1THdp0QNfRULSOMzPacglDxjKIjCIA6lySCNDCc6w3uDzpbZsztQz1XuymzaDul0IYdwfJcDjjJiFvoOFrnytkqZXP/V0TIKKKLnAfPnF210Sa/xm8m4TaiLunTKv1uqDAC0jIYzPEI7nJKQRZ1TgO5zanE2Kr4756gKfME2aJkF7etH3sP0//dXoJfDlOBH+KUnKG/otrnKvj3XrOtBWlI5N0GFWFilndSTEGEPciwiSQ1sWsAHsjQ8AWDqFvmg23jZLyc4x6AIau93S7b4HwHv7U2p1PoehbdlWJLiW0scW/xUgIDbAlccAkVayjKgwhs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(8936002)(5660300002)(54906003)(316002)(508600001)(110136005)(7696005)(1076003)(336012)(70586007)(81166007)(4326008)(356005)(83380400001)(36756003)(26005)(8676002)(70206006)(186003)(2616005)(6666004)(82310400003)(36860700001)(426003)(16526019)(86362001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 15:57:06.8412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f89310-90f9-4cfb-5fd2-08d98818c830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STB (Smart Trace Buffer), is a debug trace buffer which is used to help
isolate failures by analyzing the last feature that a system was running
before hitting a failure. This nonintrusive way is always running in the
background and trace is stored into the SoC.

This patch provides mechanism to access the STB buffer using the read and
write routines.

Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
---
 drivers/platform/x86/amd-pmc.c | 110 +++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 7b44833290df..c853b22cad6a 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -33,6 +33,12 @@
 #define AMD_PMC_SCRATCH_REG_CZN		0x94
 #define AMD_PMC_SCRATCH_REG_YC		0xD14
 
+/* STB Registers */
+#define AMD_PMC_STB_INDEX_ADDRESS	0xF8
+#define AMD_PMC_STB_INDEX_DATA		0xFC
+#define AMD_PMC_STB_PMI_0		0x03E30600
+#define AMD_PMC_STB_PREDEF		0xC6000001
+
 /* Base address of SMU for mapping physical address to virtual address */
 #define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
 #define AMD_PMC_SMU_INDEX_DATA		0xBC
@@ -80,6 +86,7 @@
 #define SOC_SUBSYSTEM_IP_MAX	12
 #define DELAY_MIN_US		2000
 #define DELAY_MAX_US		3000
+#define FIFO_SIZE		4096
 enum amd_pmc_def {
 	MSG_TEST = 0x01,
 	MSG_OS_HINT_PCO,
@@ -119,13 +126,21 @@ struct amd_pmc_dev {
 	u16 minor;
 	u16 rev;
 	struct device *dev;
+	struct pci_dev *rdev;
 	struct mutex lock; /* generic mutex lock */
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
 };
 
+static u32 stb_data[FIFO_SIZE];
+static bool enable_stb;
+module_param(enable_stb, bool, 0644);
+MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
+
 static struct amd_pmc_dev pmc;
+static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
+static int amd_pmc_read_stb(struct amd_pmc_dev *dev);
 static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, bool set, u32 *data, u8 msg, bool ret);
 
 static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
@@ -254,6 +269,20 @@ static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(amd_pmc_idlemask);
 
+static int stb_read_show(struct seq_file *seq, void *unused)
+{
+	struct amd_pmc_dev *pdev = seq->private;
+	int i;
+
+	amd_pmc_read_stb(pdev);
+
+	for (i = 0; i < FIFO_SIZE; i += 4)
+		seq_hex_dump(seq, "", DUMP_PREFIX_NONE, 16, 1, &stb_data[i], 16, true);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(stb_read);
+
 static void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
 {
 	debugfs_remove_recursive(dev->dbgfs_dir);
@@ -268,6 +297,10 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
 			    &s0ix_stats_fops);
 	debugfs_create_file("amd_pmc_idlemask", 0644, dev->dbgfs_dir, dev,
 			    &amd_pmc_idlemask_fops);
+	/* Enable STB only when the module_param is set */
+	if (enable_stb)
+		debugfs_create_file("stb_read", 0644, dev->dbgfs_dir, dev,
+				    &stb_read_fops);
 }
 #else
 static inline void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
@@ -429,6 +462,9 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
 	if (rc)
 		dev_err(pdev->dev, "suspend failed\n");
 
+	if (enable_stb)
+		amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
+
 	return rc;
 }
 
@@ -449,6 +485,10 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
 	/* Dump the IdleMask to see the blockers */
 	amd_pmc_idlemask_read(pdev, dev, NULL);
 
+	/* Write data incremented by 1 to distinguish in stb_read */
+	if (enable_stb)
+		amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF + 1);
+
 	return 0;
 }
 
@@ -465,6 +505,76 @@ static const struct pci_device_id pmc_pci_ids[] = {
 	{ }
 };
 
+static int amd_pmc_get_root_port(struct amd_pmc_dev *dev)
+{
+	dev->rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (!dev->rdev || !pci_match_id(pmc_pci_ids, dev->rdev)) {
+		pci_dev_put(dev->rdev);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
+{
+	int rc;
+
+	rc = amd_pmc_get_root_port(dev);
+	if (rc)
+		return rc;
+
+	rc = pci_write_config_dword(dev->rdev, AMD_PMC_STB_INDEX_ADDRESS, AMD_PMC_STB_PMI_0);
+	if (rc) {
+		dev_err(dev->dev, "failed to write addr in stb: 0x%X\n",
+			AMD_PMC_STB_INDEX_ADDRESS);
+		pci_dev_put(dev->rdev);
+		return pcibios_err_to_errno(rc);
+	}
+
+	rc = pci_write_config_dword(dev->rdev, AMD_PMC_STB_INDEX_DATA, data);
+	if (rc) {
+		dev_err(dev->dev, "failed to write data in stb: 0x%X\n",
+			AMD_PMC_STB_INDEX_DATA);
+		pci_dev_put(dev->rdev);
+		return pcibios_err_to_errno(rc);
+	}
+
+	return 0;
+}
+
+static int amd_pmc_read_stb(struct amd_pmc_dev *dev)
+{
+	u32 cnt = 0, value;
+	int i, err;
+
+	err = amd_pmc_get_root_port(dev);
+	if (err)
+		return err;
+
+	err = pci_write_config_dword(dev->rdev, AMD_PMC_STB_INDEX_ADDRESS, AMD_PMC_STB_PMI_0);
+	if (err) {
+		dev_err(dev->dev, "error writing addr to stb: 0x%X\n",
+			AMD_PMC_STB_INDEX_ADDRESS);
+		pci_dev_put(dev->rdev);
+		return pcibios_err_to_errno(err);
+	}
+
+	for (i = 0; i < FIFO_SIZE; i++) {
+		err = pci_read_config_dword(dev->rdev, AMD_PMC_STB_INDEX_DATA, &value);
+		if (err) {
+			dev_err(dev->dev, "error reading data from stb: 0x%X\n",
+				AMD_PMC_STB_INDEX_DATA);
+			pci_dev_put(dev->rdev);
+			return pcibios_err_to_errno(err);
+		}
+
+		stb_data[cnt++] = value;
+	}
+
+	return 0;
+}
+
 static int amd_pmc_probe(struct platform_device *pdev)
 {
 	struct amd_pmc_dev *dev = &pmc;
-- 
2.25.1

