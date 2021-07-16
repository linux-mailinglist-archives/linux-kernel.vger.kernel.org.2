Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093AD3CB910
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbhGPOyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:54:23 -0400
Received: from mail-sn1anam02on2068.outbound.protection.outlook.com ([40.107.96.68]:5887
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232988AbhGPOyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:54:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5MfCpFFGohOclChBF73OT+MGCCok6P628p7IaZ3HXT6jujwwDRi2yPYkgX2xSHy+E6prvCqJAlJPKRXYNGoH83H3peW0Tf/9WHw/yHVP0N02ZBgk5LXgq7nsqbekU0WHqztrclaCiXDy8PNuAW1YM0o7jymuf0JNsZ7jixyXgAyeFcBtW5ky/rq1gcDvcYGoZ8DRl1jrn9KGUvWVtUFXZNKR/Xrt9FMLJj1vusMb2S7x/5Yl/pvH5pCVXTkSTgc1lW1b+F2RBsbMw3BgLM9c4zOeZY1eS6NTALjKtMGri/Oand+x71qAmDyh8bBQTnubh2vl54ekJzfr25MGRoAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjzbSQu24bP1oKN/wIZa8tPlwrEN0LDdRzRDvReOjK8=;
 b=XpfmTnl3A2tQ1w2xupN4XGORkFekbkbi9f9wWS77cU1K5OrVW11bJdQRGyLH4otxJCmhA07gB25AuLTxgIdcxdMrDzedo4coAuOecb0XOLHQ165PjQPMmMtP/ozAxUDpuSyUXvGyxDiFCUfCXChAde8+4CiOPJpTYm5oAL+tdKkCu74szHjP4EqbalRddiboNUHMeBDr8HG9TD9LHFVqBxFd2En74+G4oLTVpOIcib8vKAnIeTWRoBgVTJDtF6tvbF2dtmzuu7ijwQLYjEu8TPPZK91YHKWfvPPJvo01f+u6e72y7PbJ0JbNUqS6M2qaRhCRHudnauY+SrBtTppJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjzbSQu24bP1oKN/wIZa8tPlwrEN0LDdRzRDvReOjK8=;
 b=z+qjhZ9C8CumEQsF1ZKyp6tFF4TY2j1sI2y6H0AC3mwrlBpFWEQURW5JVX91SuN6KtvBs7ho5LlcLQlWbInVFZnWh0gVfMJITqcRfK43wR7CnPBj4OLrFwutpZPUM5So3s1ubXX5smxyKuRleOwlzB11ofuC8ksytPZfhyTl9o8=
Received: from MWHPR14CA0036.namprd14.prod.outlook.com (2603:10b6:300:12b::22)
 by DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Fri, 16 Jul
 2021 14:51:25 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::3f) by MWHPR14CA0036.outlook.office365.com
 (2603:10b6:300:12b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 14:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 14:51:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 09:51:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 09:51:24 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 16 Jul 2021 09:51:15 -0500
From:   Vijendar Mukunda <vijendar.mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Vijendar Mukunda" <vijendar.mukunda@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 02/12] ASoC: amd: add Vangogh ACP PCI driver
Date:   Fri, 16 Jul 2021 20:37:59 +0530
Message-ID: <20210716150809.21450-3-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210716150809.21450-1-vijendar.mukunda@amd.com>
References: <20210716150809.21450-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87ca9dee-b6f2-4295-08bb-08d948692f99
X-MS-TrafficTypeDiagnostic: DM5PR12MB2471:
X-Microsoft-Antispam-PRVS: <DM5PR12MB247133C1B4B54A821E377F7497119@DM5PR12MB2471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ei/enjsv7QBRFt7zML5u14f1voeFkCzQkzsUoCgsY+ZkDwX0IiEUW+ml6m4JlZlYabVvj2m/i9FlEqGVaFXIp3CbhUEhVLFAcYNKz4FIEWO9edrFpo7EDB7QZfFR+ugQL2WTsIE53pXYFPsYlanzMG9QscvYaPowAGAcdg9+0NjrxzpTNXo9/Q3iGR0yGSyjQjR3z8/9Bp4aeZv6x/omkOENvY2xH242r/d2rI5GR2PtymlHbBpPW3zMV0LhK+QhJmJX+U3p1WDSZbBhvmYcAKW7ZbZMjWpAug0lxlyM+l8WCBzIMrNeFSrOEE/he1zY9WnfQlBFgssH0PzVuuSntTcs1grVzvuIh8IKlEvZWKxa0yw8lGaK8nDvz+KcbDA4slvKnrx2v2patOl9WNrTVlOzrA5hK0lxMrzDNZCLdUN5nK2t9WA7YtHVImS9lnF1aaq4257RIjnYpAOqq9dL1npC5eGSWguF935c+GwmuRyPLm3ejZX5MUlhRoquVAHjqlDjrQtsOR0VlNftNDmrT2I7tURRoTxV0WlE6TkrYuiQr4mZflpR1DKEtCQGe8kj7ZHFcUc1BbMvlhxUqe5PXG3aNCvSqoW3M6pkzTR3cVQmpfCUmwzc61BS3cMWmFgouNNcNYBDRn4CZZkR2HcwL/4iuWzgtBZv7oMLvDmOCJC1vhiVZdp7teBZqiZCNravzZoMOFAqzeNFvlDln2+/wcou45u9V5d7GMATMtYD5HI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(36840700001)(44832011)(2906002)(316002)(478600001)(4326008)(82740400003)(36860700001)(36756003)(54906003)(426003)(110136005)(86362001)(336012)(82310400003)(8676002)(8936002)(186003)(26005)(5660300002)(70206006)(7696005)(6666004)(2616005)(70586007)(356005)(81166007)(47076005)(83380400001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 14:51:25.5251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ca9dee-b6f2-4295-08bb-08d948692f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

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
2.17.1

