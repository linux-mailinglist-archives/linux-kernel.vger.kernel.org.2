Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89628435E04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhJUJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:33:44 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:11393
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231342AbhJUJdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdZj0v4GWtzylrFpfJuyCr4fJNfVw6eqDC6n3u+JgBGI1AbuA+utXcRCnsS9DKANFyiV1UWfE7MNC2cLQnCe4K6cS5GSrATOiqgWkvXc8BZfIdv5xAd+O0uGKLYQsENIl5PcKMk4iHmYfLXW+075bLnWMgoGD38h1O0pCUsdtbZsOY5TNA5cO7sQYoVNlmJR/O3gc2PIZywtgyB5BdJOOwEWkSV0UX3rD1aUpRdS5dSM3Yi3mSRcs+OHgX44RSTYsFB8tdolzNeUR9IAwoqh+MvAMp4GGHQd7gO11R5cepcByF428vHkRcgta3iBKVL/8wvtzuKAQvJ5TDC4RXB2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgY1rTVfofKL4VEFJ6Zwwwno4VcD+z2RMYUPRU1deVw=;
 b=fSQGTfMiv7z0oL3WLMmPQBe/NjmafGdEpqWRLSrkaKq0Ir304dSLaZ/dLPVNg0v1QvRNCON0n86DBPupjgVJjZzHf8z5OkzfB974ChBzglGXbnTXL0MwnCMmCGhj8sAPLJnnXsoF2GAZo58Io1kNDRogTe8si6VLfTbX+8Y95+3iMrEDZ9YMP0eX2+xWnAZEhUIJIu0txbuGZdlEri0b9Y92mteL9UFJa2cULeAynNcvIxDbwY4zdpl/QAR8/5L/LSitegmwpvOPaD3QrELtYXOt+KpiXGtXp+2MDQeodo4C+yXvAP4jXPOgGFRlxzwmJYKbqVgDwz4NHdk/56j8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgY1rTVfofKL4VEFJ6Zwwwno4VcD+z2RMYUPRU1deVw=;
 b=WSzbBkzG++nSzjg2L0fDRy4oy4cS/PbWloJjSyyScp0w5XlETITfOltFlftYT/y1DDqe0dkKCY1VcTqNr72yHfwJUWIVu8l/bNGMUl7Vw15TjG1iqE/gk+wP0JmzvVOwILjrX0nn5V2ZDxeremCgsJ/4QByc5XKtce7rgg8OcnE=
Received: from BN9PR03CA0873.namprd03.prod.outlook.com (2603:10b6:408:13c::8)
 by DM6PR12MB4601.namprd12.prod.outlook.com (2603:10b6:5:163::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 09:31:25 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::eb) by BN9PR03CA0873.outlook.office365.com
 (2603:10b6:408:13c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend
 Transport; Thu, 21 Oct 2021 09:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 09:31:24 +0000
Received: from amd-Mandolin-PCO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 04:31:21 -0500
From:   Sanket Goswami <Sanket.Goswami@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Subject: [PATCH v2 2/2] platform/x86: amd-pmc: Add support for AMD Smart Trace Buffer
Date:   Thu, 21 Oct 2021 15:01:06 +0530
Message-ID: <20211021093106.196989-1-Sanket.Goswami@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d1805c0-57cd-4b71-bf62-08d994758cdf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4601:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4601DE9C5B7B8382B62214059CBF9@DM6PR12MB4601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ooWdypWkUNUFUzM/qkb1end6N81uO6c9oW/qeaWpIS9Pa08zoQp51oJG84gT6kTvtcTfTIj+U5kcop+SXXPddE/bZL1ZbT2QjWg41s8Fa1rogkiVZc7S1vgRam8slCQQ/6CZ2BrLj3kkl8sjfN53eRtHR/CY6nkIaQhnCyJ0MrUJOqjPdeRcDOrAleOR05jIf2P4rVKuVIz/ZqlqJwCj3QC3EMYe+obPphRzRwy71qzGlPplguChgnjDaAFRlGN4Sdrh00dBt3DqPdK95dYo4ZpviWZBuKts87tIvf1gj2kAmpMBo2a3QlDfcmp8U3hocvQBrI9h2u1Fe2FLpQQ1RcnntavnM9oODvV2ioY3s3AroPNISyjSRuzaUu4131YxdoN8igcsU8eIY0QaFrk/IgrXwVPP4jbFS9cWs4nFqN802NpvPOnnQ8Wfsn5IeX87FI9/AmL8r739FlIV1QA1LUfym5abpUIS1QEbQQfSFU9ADHJZb/9zrR/TKL9yioVEbyFRliAIDc0cwOXHT5XxdgZr6EPKXqIUsmU5X3rxNnmgZig1YrYJ6sqJgff7VAARV8wwm8tm3zIs0raqJVQqs2SZs47wPgRO+KZT+a9danLMz+yebZD3MxBrJs2ymaNwYGxo1u+ue+SmWvU1uyFxXcB9gtcz4+KPdCcQNBNGrYiakE9Yr8kd2rVpWDqfOoJElyKuctlJrBnz3nhMX9/EzWSSMU0AYp9qRVCeTDvba7M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(86362001)(336012)(47076005)(5660300002)(2906002)(82310400003)(81166007)(36756003)(8936002)(7696005)(6666004)(356005)(2616005)(426003)(54906003)(36860700001)(8676002)(16526019)(186003)(110136005)(70206006)(4326008)(83380400001)(26005)(316002)(508600001)(70586007)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 09:31:24.4754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1805c0-57cd-4b71-bf62-08d994758cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4601
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STB (Smart Trace Buffer), is a debug trace buffer which is used to help
isolate failures by analyzing the last feature that a system was running
before hitting a failure. This nonintrusive way is always running in the
background and trace is stored into the SoC.

This patch provides mechanism to access the STB buffer using the read
and write routines.

Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
---
Changes in v2:
- Create amd_pmc_stb_debugfs_fops structure to get STB data.
- Address review comments from Hans.

 drivers/platform/x86/amd-pmc.c | 120 +++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 502f37eaba1f..df53c5996e2c 100644
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
@@ -126,8 +133,14 @@ struct amd_pmc_dev {
 #endif /* CONFIG_DEBUG_FS */
 };
 
+static bool enable_stb;
+module_param(enable_stb, bool, 0644);
+MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
+
 static struct amd_pmc_dev pmc;
 static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, bool set, u32 *data, u8 msg, bool ret);
+static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
+static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
 
 static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
 {
@@ -156,6 +169,51 @@ struct smu_metrics {
 	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
 } __packed;
 
+static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
+{
+	struct amd_pmc_dev *dev = filp->f_inode->i_private;
+	u32 *buf;
+	int rc;
+
+	buf = devm_kmalloc(dev->dev, FIFO_SIZE * 4, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	rc = amd_pmc_read_stb(dev, buf);
+	if (rc)
+		goto out;
+
+	filp->private_data = buf;
+
+out:
+	return rc;
+}
+
+static ssize_t amd_pmc_stb_debugfs_read(struct file *filp, char __user *buf, size_t size,
+					loff_t *pos)
+{
+	if (!filp->private_data)
+		return -EINVAL;
+
+	return simple_read_from_buffer(buf, size, pos, filp->private_data,
+				       FIFO_SIZE * 4);
+}
+
+static int amd_pmc_stb_debugfs_release(struct inode *inode, struct file *filp)
+{
+	kfree(filp->private_data);
+	filp->private_data = NULL;
+
+	return 0;
+}
+
+const struct file_operations amd_pmc_stb_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.open = amd_pmc_stb_debugfs_open,
+	.read = amd_pmc_stb_debugfs_read,
+	.release = amd_pmc_stb_debugfs_release,
+};
+
 static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
 				 struct seq_file *s)
 {
@@ -269,6 +327,10 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
 			    &s0ix_stats_fops);
 	debugfs_create_file("amd_pmc_idlemask", 0644, dev->dbgfs_dir, dev,
 			    &amd_pmc_idlemask_fops);
+	/* Enable STB only when the module_param is set */
+	if (enable_stb)
+		debugfs_create_file("stb_read", 0644, dev->dbgfs_dir, dev,
+				    &amd_pmc_stb_debugfs_fops);
 }
 #else
 static inline void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
@@ -430,6 +492,9 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
 	if (rc)
 		dev_err(pdev->dev, "suspend failed\n");
 
+	if (enable_stb)
+		amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
+
 	return rc;
 }
 
@@ -450,6 +515,10 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
 	/* Dump the IdleMask to see the blockers */
 	amd_pmc_idlemask_read(pdev, dev, NULL);
 
+	/* Write data incremented by 1 to distinguish in stb_read */
+	if (enable_stb)
+		amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF + 1);
+
 	return 0;
 }
 
@@ -466,6 +535,57 @@ static const struct pci_device_id pmc_pci_ids[] = {
 	{ }
 };
 
+static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
+{
+	int rc;
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
+static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf)
+{
+	int i, err;
+	u32 value;
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
+		*buf++ = value;
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

