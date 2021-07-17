Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18E93CBCD2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhGPTpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:45:19 -0400
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:18273
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232661AbhGPTpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:45:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/VJMGNqRrEZ4yTZSlzxDPlpTe6n+Oeuo+rRE2bFOkDx0nuW/1HC93TYK/UbQwO2wL6qPcezF5XmA7DtZOV+3toIjaZsC6Y7ZMB3zwuSy5gxv4aNpKqhJKyuiTdSaqsjwtPLiZ1ViYX9vQeoaasuIDOoEuY3U2Xy7cfPuXJkJHneLthX+XefyyY1lo5pq/0XkwG9fYTrXftdjUBy2cX3tetqmSD+jlVa7GeJDyBAXF//oAiSPfgFdJvtO47YZvNVG2PTNSVlUZ51UPBfcFfH2NyuIxy0AdFXT91xt2J7Fo4qOWIH1zHFPDo6ZRLBtMP23wW/X9v68BL5nTVJnHN+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0x/JRUhHPFt36uVt5jisPe1BE3nFtLDj72CFFME6kU=;
 b=ZRNn6eLYVRRMCcCzvcR7L6nu47NHcLwxqaLNfTj/QJUuIUmEVRBJFL6Zl8SrtsmrvreMJDGjAWfyaIB6/DtmlK7FQVfLrfPN4syFB7L/t4pY90a13n+Eg4Qr1lHx59UoDsY2mlYxvChgd9NqCYLF5MTput5NyzGaK8ddpTMxQc8pFmWBHQT52jxbjTcCMIEv4T/nQoX3cCDGrCbtZTIa7tmSmEr7K4PpbOMTLwX6atRHPwt42qIPmaVjYvSPTLM9MyaMncLo2TEv04kEtxeqdtDLnWLfAsQS7Gn+ASLIEYiJ+s+jHes3nvegO1nuEfgQiLJOYsA1oBnCYhcNl83tew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0x/JRUhHPFt36uVt5jisPe1BE3nFtLDj72CFFME6kU=;
 b=sMjI8KgggSOU3/CuT90GW+BqO/TFrsYt32Owe7UN/RMgz5NYSJEX8E9HW6I14W9CvnhpoYs/U3w/68msk4pKPvvs9ClWdSHeF7p8EV2hDfvN8lpn8SQoV6iN0M9xVnLojgNPQzLaPgdNwVgeg+ItdR5NRCvuhiQRVIap4xEOSZk=
Received: from BN9PR03CA0687.namprd03.prod.outlook.com (2603:10b6:408:10e::32)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 19:42:16 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::b4) by BN9PR03CA0687.outlook.office365.com
 (2603:10b6:408:10e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 19:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 19:42:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 14:42:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 14:42:15 -0500
Received: from vijendar-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 16 Jul 2021 14:42:07 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND V2 02/12] ASoC: amd: add Vangogh ACP PCI driver
Date:   Sat, 17 Jul 2021 09:30:49 +0530
Message-ID: <20210717040059.310410-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210717040059.310410-1-Vijendar.Mukunda@amd.com>
References: <20210717040059.310410-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc03932b-3884-4d87-6724-08d94891d132
X-MS-TrafficTypeDiagnostic: PH0PR12MB5403:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5403F2193B8DF5B4C44D5F4597119@PH0PR12MB5403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJDIH9IOSw973IWtrVuGTxQHwOPJoJARlya1xGSGL4k38M6vFedJBHb7wXBf8rzB7prpBxkMDpW992gAxd/KPPFAfYWLtBX7zDfNa4lX7o5hhI+XCry1ms15vlggWeOTWJA/n28jwt3WBQmUCxEhF9fA+GAxVj/dzkJnwN67qkYNkq2ToYl7d75GHa1YPiZfCiqHbnZ5p1Rq8Q5YFAgxausY42OZ7ajdMhMnO74JGi05YYviGduxtiGHpt0z0vVk8ewKYTGRi3wwY66jU1sdDIlNe2hM5sHOR2MhjxUS7QP5fikRabPBs4WicxEmIzPUGdNmSH3e7nHTz94N9Bi/KDQnrx3VnucCRD/q5zRcJiFue6I7yCH4bRjYIMOsymY544TvwO6/gCF+icW+xQv36kpqxAxlRYDN3mL42M+D5+gvFWa8/3VepJVzxDXn6JvM5DLYyMeZxtyWUMV5FoxsShjIX+F54yNDn+2AZJq34lATiXVEpufDSizfCFI9Gy2v1efMeNqG3Ao3CJLbvg6a+ja9y1RC9sWtBSMxiFwydfr6FuQX0lUPZJLjkPKtH7wrlW4+18oviSogTYfqcxgKoBcKwKKwzrBo5YAc5BT7vX7GPw/0cA6t5UKtMmR2hY18uw++Pf9QAGJ/WsVby/FuuE5Hm3Q0RanB4Qo6jwKRpRv9msgNuJkuf5RVoVma9wW26DYC+vdgra6SCvjatQtGKFP/Cy3a6MjTWekB3QJn2aQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(54906003)(70206006)(70586007)(2616005)(356005)(82310400003)(47076005)(7696005)(6666004)(426003)(2906002)(110136005)(1076003)(26005)(83380400001)(36860700001)(5660300002)(508600001)(4326008)(81166007)(86362001)(36756003)(8936002)(316002)(186003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 19:42:16.6305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc03932b-3884-4d87-6724-08d94891d132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP is a PCI audio device.
This patch adds PCI driver to bind to this device and get
PCI resources.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
v1 ->v2 : add comment for acp_readl() & acp_writel() API's
---
 sound/soc/amd/vangogh/acp5x.h     | 25 +++++++++
 sound/soc/amd/vangogh/pci-acp5x.c | 87 +++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 sound/soc/amd/vangogh/acp5x.h
 create mode 100644 sound/soc/amd/vangogh/pci-acp5x.c

diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
new file mode 100644
index 000000000000..8afa8144af4e
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
+ * offset which requires substraction logic from base_addr
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
2.25.1

