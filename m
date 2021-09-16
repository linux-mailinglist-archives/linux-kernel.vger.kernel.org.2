Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CA540DA31
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbhIPMmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:42:07 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:6560
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239891AbhIPMlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKqRbzKn31T29rn5es7XkIpWbVoKvVopbZy3CJ4H799tOTMxHiLN0SwzTsh2RTo4rhpdjr2wpqr3CwFuhtFgXICHGwCKGQSGTX1AZz5jKtFXV7stdb/UMFeKqQuIyzytfencm/iDU/ENffAWix1ueT9g1rar9uvkPyWZ0xszI7kfyu2rdF1NBbRVx2K/TsiWGyE/9+nFyWfzcNrbUhG2nHXe+f6qdWtJDQqynGgM3I9OkIRRKEfggI2aeYTlN4O0zX6yFY7q/TC2zdE1RVNAG4zp0gM0yBSSAhggDgtdMQLRitYS4K5AozqxwUzu5nJFWRmTtul0UU5y8cWELreXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=94EJLJBwBHep0r0sfnpPqUMizNc6oS1Bcm/foOul2Tc=;
 b=FzfSyDen5jiYxOlpiGV7ZKkLNDbmxk/xubpkWffxDa9ZyzUGgojlNEVZr9PqbECWOtYsjn6hkusHU/E4LghNaKsZLEcrJiRIFYUQYnQDttPOTSs0PrcyBBVG2pEBaaoA0OuRIU2IbkCM/hbeeEXY8wjvNNGyrP9aCHm+3aNAwbQXa8haZjLxQXKf1Qot4hZroMrdTPwCd0Hy/cYP22xaurJOch1LqyB/bN8xfbIycRC7yhLJzSy6h5FxTa0o+EGB9pDv0GhXuaBEDYx8KqDwjtz1BW93r5xvc1LOzccTQQ3ZfMAIhJ0f9/yPRshSKgW37sW/KM2dJhO9WsFmJ4PWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94EJLJBwBHep0r0sfnpPqUMizNc6oS1Bcm/foOul2Tc=;
 b=qdLDN0Tp5M6nUvxXxOBRN9aKLnSakuOIC7FmY7y/frwayR8Q3oC2qaTr202b5lg96XRX2XoyxVZgdSWEkW5CbgSPGUb0FajKBNfPVxX2essKAkHSps/mOQ+c1X3wJtvlI4P4M2SZ2ks8TBfEOi3cuvqLGy34054fmwa/AES0TcQ=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by BN6PR12MB1843.namprd12.prod.outlook.com (2603:10b6:404:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 12:40:22 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::21) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 12:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 12:40:22 +0000
Received: from Mayan-RMB.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 07:40:19 -0500
From:   Sanket Goswami <Sanket.Goswami@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Subject: [PATCH v2] platform/x86: amd-pmc: Export Idlemask values based on the APU
Date:   Thu, 16 Sep 2021 18:10:02 +0530
Message-ID: <20210916124002.2529-1-Sanket.Goswami@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a41c587f-81b4-47e5-6f2d-08d9790f265d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1843:
X-Microsoft-Antispam-PRVS: <BN6PR12MB18433C7ABF67A079C949B25E9CDC9@BN6PR12MB1843.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ju3czA0sghC7wgpwxY8zHqp9kA3VL3ZbGMVvMWCdj7e+iXt0PBazoQz/kmziaImzvxbgwDJZZDyU4j//XMGndJGlfzAxxaU6ALbPrtQNYKjmEgz10w49z7JJLogn3vSG4PuugYudTCxi08/I+p/Wf88hrw7l+h8e99UGnPmdb6MAvXpBWDjLFtnZAhPEwuOcyk7ttTAPtONMq4HSg3N+1qbIcWKGfpmZUWxkPRtX5xp5/IlPTrse/hdBPn75j08rPZ51V/O/Y9xQvmsZTzTQgAH5Il30prxabT1wWuiOUo0ujIAEswbf8n1CACm79WpG7NOmorjQbyC5DzHOxMJZ5ulJfDDPoGOFRAnHlfsHlap3cdSoXzfEr6my+T8LcHjz+rTz8xxxJ2AFsLPZBES1HWHpLV1vHp/7nxgJI2klZaKQue5JACkvoGLXEpRCOkyx2uP07OYr5lPi8TsK7aS2ht4+VBxb5eA7NLze7ognqdWK/55XI+xm7BM46zJec3gek51T6laEHItLqwVVUvZZCWPvWqlm8eX3pPehZsb/yYGKK9bN5vneeqyhL8Eyda9GzmLG9ONW/oVZTEnyE02OixB9n+rsMrW1F8n92lFYH+vLd4sjto++zT9ImOa4sAy0I+J4bpJytEmBCiiZsn/3MVjDM1MWDGcwLV41jkISpEY57PvnSCn6EuQZQWc8RQYgJP3cc5hTqZEaBxUUDWl9Cdy5VVXQPJ+oACnfhTaRfBk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(316002)(83380400001)(7696005)(82310400003)(2906002)(110136005)(54906003)(4326008)(70206006)(70586007)(336012)(356005)(26005)(186003)(5660300002)(81166007)(82740400003)(16526019)(6666004)(86362001)(1076003)(2616005)(8936002)(36860700001)(36756003)(47076005)(8676002)(426003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 12:40:22.4343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41c587f-81b4-47e5-6f2d-08d9790f265d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1843
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IdleMask is the metric used by the PM firmware to know the status of each
of the Hardware IP blocks monitored by the PM firmware.

Knowing this value is key to get the information of s2idle suspend/resume
status. This value is mapped to PMC scratch registers, retrieve them
accordingly based on the CPU family and the underlying firmware support.

Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
---
Changes in v2:
- Add separate routine amd_pmc_idlemask_read to get the value.
- Address review comments from Mario.

 drivers/platform/x86/amd-pmc.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 3481479a2942..0c970f613e09 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -29,6 +29,10 @@
 #define AMD_PMC_REGISTER_RESPONSE	0x980
 #define AMD_PMC_REGISTER_ARGUMENT	0x9BC
 
+/* PMC Scratch Registers */
+#define AMD_PMC_SCRATCH_REG_CZN		0x94
+#define AMD_PMC_SCRATCH_REG_YC		0xD14
+
 /* Base address of SMU for mapping physical address to virtual address */
 #define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
 #define AMD_PMC_SMU_INDEX_DATA		0xBC
@@ -110,6 +114,10 @@ struct amd_pmc_dev {
 	u32 base_addr;
 	u32 cpu_id;
 	u32 active_ips;
+/* SMU version information */
+	u16 major;
+	u16 minor;
+	u16 rev;
 	struct device *dev;
 	struct mutex lock; /* generic mutex lock */
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -201,6 +209,66 @@ static int s0ix_stats_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
 
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
+static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
+{
+	struct amd_pmc_dev *dev = s->private;
+	int rc;
+
+	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
+		rc = amd_pmc_idlemask_read(dev, NULL, s);
+		if (rc)
+			return rc;
+	} else {
+		seq_puts(s, "Unsupported SMU version for Idlemask\n");
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(amd_pmc_idlemask);
+
 static void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
 {
 	debugfs_remove_recursive(dev->dbgfs_dir);
@@ -213,6 +281,8 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
 			    &smu_fw_info_fops);
 	debugfs_create_file("s0ix_stats", 0644, dev->dbgfs_dir, dev,
 			    &s0ix_stats_fops);
+	debugfs_create_file("amd_pmc_idlemask", 0644, dev->dbgfs_dir, dev,
+			    &amd_pmc_idlemask_fops);
 }
 #else
 static inline void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
@@ -349,6 +419,8 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
 	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_RESET, 0);
 	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_START, 0);
 
+	/* Dump the IdleMask before we send hint to SMU */
+	amd_pmc_idlemask_read(pdev, dev, NULL);
 	msg = amd_pmc_get_os_hint(pdev);
 	rc = amd_pmc_send_cmd(pdev, 1, NULL, msg, 0);
 	if (rc)
@@ -371,6 +443,9 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
 	if (rc)
 		dev_err(pdev->dev, "resume failed\n");
 
+	/* Dump the IdleMask to see the blockers */
+	amd_pmc_idlemask_read(pdev, dev, NULL);
+
 	return 0;
 }
 
@@ -457,6 +532,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	if (err)
 		dev_err(dev->dev, "SMU debugging info not supported on this platform\n");
 
+	amd_pmc_get_smu_version(dev);
 	platform_set_drvdata(pdev, dev);
 	amd_pmc_dbgfs_register(dev);
 	return 0;
-- 
2.25.1

