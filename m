Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFF840AEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhINNPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 09:15:50 -0400
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com ([40.107.243.88]:56192
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233105AbhINNPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:15:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGS4nxKVCoyGAX5m6/sYvCpdVoryYRii1pHeJaL3EffJB1ViLGm36mcV5pbb1MlUE8ZBVy8BHibRXvvobok7GUFW6HrlsiYox2EJTTvDYCoYC+olujct43WSCR/d4wNXLUTKNCanQDyXnCay/M9numURaV2fP1erL0/9hYjUbfKJA4pLMbl/6+RtKaAeX2jumb8Gl4OS61nQZwdhaw5eMcTa5ngn0urdb45STorji1k6kPdRvSEqfCEtDBzROmjHqkiR6fz+iG8liz1fgfIphNwv8ZBuBuSlSW8cUb6NN9WUkX4lK/dnPkKI594uIREjZJut3pBm+wcTH5sPr3xsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=n1wJBvxd1S/9c+gyTVGH2C4M8lL32p8a2wBRcP8sE50=;
 b=kCcPKQZhm6mrxLtmdGnb9+EgcbgqiMTTSs6Uy3+32g8oS8krDl3VUzEOye7xqlbUcp/L1/hdJGGnGDL4HJhicUj3ydWdz64kYt+8yQZkacmhD4aOi/m13ACcXoRbc+EQMm4PvX8w8pKuNjlQJTPy45rTMM22AkfZeXxmoluMqJGHqCGc6p5edk6ABV+vT8yOyenMQhsI7rDg0YqNyHpzxNOFMCNn0/zWNyQyDkqpwSp1DXwMAU1JUQ+iIN4eWJrbEzFxE7d05mKAQX0J9AZiq1UrOto4LrVcJIbFE5b/qmSIYa9IhdmIO0bkSw/QA01chs69HoV58ooljrSMcoqryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1wJBvxd1S/9c+gyTVGH2C4M8lL32p8a2wBRcP8sE50=;
 b=EPYNM6ux4TvNp+D5dmB+LMWVakEklgT4SaFbRhl+Cs0aAWP9CTdqT+M+AX49/aM10ghK1FGhUorWF2F6f6aLU1BnaScBtH/mBXfQgCXJaf6ZXhP9d60/MsiSdN/llW88M1MQf+ACeBxh1bZXhwb6o3BwehMOl6sHg/xSR3O202w=
Received: from MWHPR2201CA0051.namprd22.prod.outlook.com
 (2603:10b6:301:16::25) by MN2PR12MB3968.namprd12.prod.outlook.com
 (2603:10b6:208:16f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Tue, 14 Sep
 2021 13:14:28 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::3b) by MWHPR2201CA0051.outlook.office365.com
 (2603:10b6:301:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 14 Sep 2021 13:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 13:14:27 +0000
Received: from Mayan-RMB.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 14 Sep
 2021 08:14:24 -0500
From:   Sanket Goswami <Sanket.Goswami@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Subject: [PATCH] Export Idlemask values based on the APU
Date:   Tue, 14 Sep 2021 18:44:06 +0530
Message-ID: <20210914131406.1892-1-Sanket.Goswami@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8bb0189-3176-4a4d-f138-08d9778194aa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3968:
X-Microsoft-Antispam-PRVS: <MN2PR12MB396848D3643C187DB27CEB689CDA9@MN2PR12MB3968.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0wd8bbXLF9ZxdZvDur6Q8UY/jbsQ1TDURIxCZFzLBtlLvK6D2NWk+MMIx4XwsjA/T9NoIp1Md9F/xz2rrFz5cqTY0K0WxAGKl5MODh1QVCh00G0/IMw7Dlj8JMhAjYg+maD4L+aQgprwSm2bFgGNmYuxA6eEJYeUbpfliVlDeHT5bLMIoplFUAvjeOOyNSaggQFZMscCey1ujuMOiSfD6oCde+yTzPQGkh78GUbI7xqGjNB7RVKSptZB/sOB4x1/Zm/8HgIs5vxBsS5t9zt50/8jR3qdAahB/cv7xgG3IjJ0gYL+BZ4l/Bon+kkyw+rdubGblMBXrR2uokYf+hc3gOUUYLwBTraxf3r45SXBnX03Lzvb48tFr1tdPuXeqvxeK30Z7Fhm86xq+e+RpudcX/S33AqbsmnekIsxQCdfQbqyFx3szFNcXYK2WS1Wwa2F3E8P8hLsL4LUUd3ki2ioVSF97hhgdwSNgX4ffrto8R1arE/hznqCAReExbOtbgROH0/++/0oPeGzdNNM4pTczO0gsc+an2rXSinOtfC0LKVVD96OliFmfHv8q4WGj2hIVwf2ImVeI0n/O0qKB5gARpGP+7H9y9ddbKNvG/YaINaDLKA1ppCv9RW/0YwlEbRoX2dve55+0AJICWaDKT69Y7aWzQDlA2cSRMghJUcxxbwQ2D/uNGzBM2xzr6TYPJItC4CxX4kqf61ZtHe1SQ1eGQwCqB7XY3w4+CInFIChIE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966006)(36840700001)(316002)(54906003)(356005)(6666004)(110136005)(426003)(47076005)(86362001)(478600001)(2906002)(4326008)(82310400003)(83380400001)(1076003)(336012)(82740400003)(36756003)(2616005)(8676002)(70206006)(8936002)(7696005)(26005)(5660300002)(16526019)(186003)(36860700001)(81166007)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 13:14:27.6614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bb0189-3176-4a4d-f138-08d9778194aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3968
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
 drivers/platform/x86/amd-pmc.c | 57 ++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 3481479a2942..e2e55e5bea22 100644
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
@@ -201,6 +209,53 @@ static int s0ix_stats_show(struct seq_file *s, void *unused)
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
+static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
+{
+	struct amd_pmc_dev *dev = s->private;
+	u32 val;
+
+	amd_pmc_get_smu_version(dev);
+
+	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
+		switch (dev->cpu_id) {
+		case AMD_CPU_ID_CZN:
+			val = amd_pmc_reg_read(dev, AMD_PMC_SCRATCH_REG_CZN);
+			seq_printf(s, "SMU idlemask: 0x%x\n", val);
+			break;
+		case AMD_CPU_ID_YC:
+			val = amd_pmc_reg_read(dev, AMD_PMC_SCRATCH_REG_YC);
+			seq_printf(s, "SMU idlemask: 0x%x\n", val);
+			break;
+		default:
+			seq_puts(s, "SMU idlemask: Unsupported CPU ID\n");
+			break;
+		}
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
@@ -213,6 +268,8 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
 			    &smu_fw_info_fops);
 	debugfs_create_file("s0ix_stats", 0644, dev->dbgfs_dir, dev,
 			    &s0ix_stats_fops);
+	debugfs_create_file("amd_pmc_idlemask", 0644, dev->dbgfs_dir, dev,
+			    &amd_pmc_idlemask_fops);
 }
 #else
 static inline void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
-- 
2.25.1

