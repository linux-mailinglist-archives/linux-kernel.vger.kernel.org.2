Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5793CFF41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbhGTPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:44:13 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:54839
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236453AbhGTPjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:39:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owg4nNienDlioKawguJJEya4ZGPYqGY7Cg0hRUs0s8+HyMlNw7KCoZNkXLCkt5pFCR9oqI3EvKgSrEteg5ONGM+VJt0ahWqEh0I9/YuYURVlMbqcgzX3QO0k2NpDaSUQum72zKBa68IyBwyb4SPFS0BUxJ2xHi2m23FD4Iy56Xx9XZX9Mj1YUXgomzaLxYoF96WfVTjPwJeLfcc/yVATxAuGNhZAfW97PBckCYEuED0Yywz9KjSOx5SbzKESXpHdk3Bz8Mu0PInY8lqRcL9w0HNSM/HngZwar9HA8JS21q3GdSJtb4LYf8E2qWj+Nc31bWrbl5IwH3G8MqWQJa2WPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldSx7TxnTyTITdnoV5FskE6ccJLenCAQaOCy8czRk5w=;
 b=F291sLEtzl6QHgYM1VVqSpIz/x0Dct+wITE+/TW6/ZPRUUr+7f6Wiy6zdPHvLA+gZ4IGdhdXBWSgWtLQVZCeNBiGkCm+HJMZ67WjHWbzjudPFWM1THJkotTR3fcpaGHjvqvKfFL/O9Gqtl///GU8JSLIv08DmXGltHs+sfEdTZUnqzuChbSEPErepHPNlEkwVOaFX3eyh05VGX9czQ6K25k9rNYEkXswtCU4xsY6LG/SSh8U6kdmitbZOH2IWepKuDe3YsksjQiTMgC/YRcgp8mf+xQ0TManOPEPPwt4uNYC/5iFUE4doPnIBuhyfWTCXkqmiihTDaSB/SFDfNab4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldSx7TxnTyTITdnoV5FskE6ccJLenCAQaOCy8czRk5w=;
 b=o/ePqSfZwBmmRuRT7zxRP7IPTPC5yEa3MTYCMpg3LchB8xtKI2abrimVE8ZVrpZszjOIRAgpGzjBOj/Zir4GFHZD6ruBlxpE2LocTEltjv90R0rZjj75ZlUWljlhfT6j0LiJe98FUqpnArn5LrU14igm1XRLOvMIuB4whSkZ4Ic=
Received: from MWHPR10CA0021.namprd10.prod.outlook.com (2603:10b6:301::31) by
 CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Tue, 20 Jul 2021 16:20:16 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::ea) by MWHPR10CA0021.outlook.office365.com
 (2603:10b6:301::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 16:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 16:20:16 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 11:20:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 09:20:14 -0700
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 11:20:11 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 02/12] ASoC: amd: add Vangogh ACP PCI driver
Date:   Tue, 20 Jul 2021 22:07:22 +0530
Message-ID: <20210720163732.23003-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 747d5240-7d29-4545-089d-08d94b9a4288
X-MS-TrafficTypeDiagnostic: CH0PR12MB5060:
X-Microsoft-Antispam-PRVS: <CH0PR12MB50609D877E65890C651106F397E29@CH0PR12MB5060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuN+snAXQ2yHH+Fj34hnIJWw94OQgDZpV7x9wjCOV9PsOhMJX0GFMzCClH2UvOWJ17UsQBzFChBbQ1pYg0RNgLm+IDpyVXrU9MBoTWKZHrIn8qEgv1XHu1/5NGVzQy1j5FILk9DA4iQVpuGgL8JdwUaYFWVbnSwW8tBhtLL1Vn85j9pCBbgM3FGttUtdPKWeYrWQSPn4D2JyoU7Xl222O/ZPtbUJS+l1GMqpgoCPZOE8ywn+r7y4QprALNdmof5xAxQnW0vdWPGoyxj/O7Jf9BoUIkLHdtgg/eSTKSsLGNFR/egvIo5GdpDmBZFLfF/I4AjWmAE7uxQ4I19nfqQyCtOf9LHuydJtLRqigjPB68VA5ayR672Hh9v+VmSluhwZVEJm3hVrceJFmCH3BYW8LN3wNnPsXtl/jlVXwvNB7GjFUiQxBnoXfPJpkqQ9tGtx0AcLt6Cg/w2tEe/zwxBc9JxJs30ReDb5BR81NK5x1zyUmUdaJDa3Bac5qtZmIcK3G3nNVK8BOxqc8UdZPidnrywm4eWk6Vh9ZS4+YdOV5ZnSjWrPdHT1QSKUnXjxjNox0L7+sZIQPYVJC8qvbEIs5XFnmipRZHzeYp6B2EHgXDyY972lgobKfpTX9WeMfhYgVV37rfNJWN829Gbh9XoUc/076MeDh5qHNYPMS+BOR7apUzv8/NeoKhpFLrWnCH8hFWzBOPY9sFLSII8ZlhneCqmY/YdDTk7rzdOZ0NuZBUY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(336012)(4326008)(7696005)(82310400003)(70586007)(2616005)(83380400001)(6666004)(54906003)(316002)(47076005)(508600001)(426003)(70206006)(110136005)(186003)(5660300002)(36756003)(26005)(356005)(86362001)(2906002)(1076003)(8676002)(81166007)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 16:20:16.1164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747d5240-7d29-4545-089d-08d94b9a4288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP is a PCI audio device.
This patch adds PCI driver to bind to this device and get
PCI resources.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x.h     | 25 +++++++++
 sound/soc/amd/vangogh/pci-acp5x.c | 87 +++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 sound/soc/amd/vangogh/acp5x.h
 create mode 100644 sound/soc/amd/vangogh/pci-acp5x.c

diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
new file mode 100644
index 000000000000..251a7e0347a7
--- /dev/null
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AMD ALSA SoC PCM Driver
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include "vg_chip_offset_byte.h"
+
+#define ACP5x_PHY_BASE_ADDRESS 0x1240000
+#define ACP_DEVICE_ID 0x15E2
+
+/* common header file uses exact offset rather than relative
+ * offset which requires subtraction logic from base_addr
+ * for accessing ACP5x MMIO space registers
+ */
+static inline u32 acp_readl(void __iomem *base_addr)
+{
+	return readl(base_addr - ACP5x_PHY_BASE_ADDRESS);
+}
+
+static inline void acp_writel(u32 val, void __iomem *base_addr)
+{
+	writel(val, base_addr - ACP5x_PHY_BASE_ADDRESS);
+}
diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
new file mode 100644
index 000000000000..e56d060a5cb9
--- /dev/null
+++ b/sound/soc/amd/vangogh/pci-acp5x.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// AMD Vangogh ACP PCI Driver
+//
+// Copyright (C) 2021 Advanced Micro Devices, Inc. All rights reserved.
+
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include "acp5x.h"
+
+struct acp5x_dev_data {
+	void __iomem *acp5x_base;
+};
+
+static int snd_acp5x_probe(struct pci_dev *pci,
+			   const struct pci_device_id *pci_id)
+{
+	struct acp5x_dev_data *adata;
+	int ret;
+	u32 addr;
+
+	if (pci->revision != 0x50)
+		return -ENODEV;
+
+	if (pci_enable_device(pci)) {
+		dev_err(&pci->dev, "pci_enable_device failed\n");
+		return -ENODEV;
+	}
+
+	ret = pci_request_regions(pci, "AMD ACP5x audio");
+	if (ret < 0) {
+		dev_err(&pci->dev, "pci_request_regions failed\n");
+		goto disable_pci;
+	}
+
+	adata = devm_kzalloc(&pci->dev, sizeof(struct acp5x_dev_data),
+			     GFP_KERNEL);
+	if (!adata) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+	addr = pci_resource_start(pci, 0);
+	adata->acp5x_base = devm_ioremap(&pci->dev, addr,
+					 pci_resource_len(pci, 0));
+	if (!adata->acp5x_base) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+	pci_set_master(pci);
+	pci_set_drvdata(pci, adata);
+
+release_regions:
+	pci_release_regions(pci);
+disable_pci:
+	pci_disable_device(pci);
+
+	return ret;
+}
+
+static void snd_acp5x_remove(struct pci_dev *pci)
+{
+	pci_release_regions(pci);
+	pci_disable_device(pci);
+}
+
+static const struct pci_device_id snd_acp5x_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_DEVICE_ID),
+	.class = PCI_CLASS_MULTIMEDIA_OTHER << 8,
+	.class_mask = 0xffffff },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, snd_acp5x_ids);
+
+static struct pci_driver acp5x_driver  = {
+	.name = KBUILD_MODNAME,
+	.id_table = snd_acp5x_ids,
+	.probe = snd_acp5x_probe,
+	.remove = snd_acp5x_remove,
+};
+
+module_pci_driver(acp5x_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD Vangogh ACP PCI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

