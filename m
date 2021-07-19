Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F983CECDC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381903AbhGSRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:38:53 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:53124
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350119AbhGSPyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:54:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nASOM9jzo/4g3osfpKRHwkGoc+QJgUj7WQ825+tR9SrL8yHqr/CD9/UhCwc5z2xaLyaGSqG1nXtwflSofiJYxE+JDcC5uXDbpppJ6qBDD5RR37FjNM6toHI3M0A0oWz4yKxyxbZ3nLUKWpibrovhyiZL6RDy5Cb3DLeQoWQ1cIoIv5YwdbJZF0DBwrsC+rzE650Nm3L8A3qVygMIPbs9c+bj1Hz752vbCvd+OpqzBWyXFz34h1F9nyocmcHulP8Q4y5abVM4IHsnPWDI1UfF9+Z7i9VZD6timO0H2CRpvYs1wzFHZbomVbk4a9OPwLyg8+L6HnpdQg2P65u1Q8+SFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/mRnln9nL4+VO/WHQSHKDyZI44RU76z0zND9SQL7gE=;
 b=UNrCjVUZkFD9XCzqn3V2qzRtb6jLy0ZfyigZIfvBHYar0UEzSsWC9GYHjnaPbeXKXQD6gxGqQeCStVpvynSU6eeQI9oy+LaRK43+t2xEM9bSs14OoBmtcXu12pzBbjoW9Xz31bKt4MyPjuF8XZ/0j9BLuaJVQ1OMiKZq6pp3Hjw7Td6JcLeGO6mOlmqr9zW04AHojpI3m7lIp4GUNxep+bPViVBYLNhjIwn407tiXlNf0YcwQIxPVJSRWo1jgZ04R4SSyPM4OQuCOqQYfdpMvV4MVsr1L4ZIB1Gqoj1a6UbWpK4UX/vtUI2xsABCxBR9U7r1IEwJWbtbPrtjK+xnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/mRnln9nL4+VO/WHQSHKDyZI44RU76z0zND9SQL7gE=;
 b=oW3syCb+tXooN7Wn7IGytD1niM6NaypNFAE9WnIDYqN6srUbffGZVZwSPIT+URWwLstfoCIIcim2hN0IT+RGZw72yNmOpWsIcaRBOo1O9xnC7V2MMLo18VsqNttHiT4sELa7L93P4Dc90o34fHrfT/bpVinmq0n7g/fR4NmllI4=
Received: from DM5PR20CA0030.namprd20.prod.outlook.com (2603:10b6:3:13d::16)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 16:34:46 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::89) by DM5PR20CA0030.outlook.office365.com
 (2603:10b6:3:13d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 16:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 16:34:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 11:34:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 09:34:44 -0700
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 11:34:35 -0500
From:   Vijendar Mukunda <vijendar.mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 02/12] ASoC: amd: add Vangogh ACP PCI driver
Date:   Mon, 19 Jul 2021 22:21:30 +0530
Message-ID: <20210719165140.16143-3-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719165140.16143-1-vijendar.mukunda@amd.com>
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ee59e9e-1737-4613-6106-08d94ad31e7e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4367:
X-Microsoft-Antispam-PRVS: <SA0PR12MB43676D0AC9973E5DBB487C7B97E19@SA0PR12MB4367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6kO9kHkPAvNp2qEMGgvqQE3FOBQeWh8CeN2vVu09cvwJFziLcxH442QK3C4knm7usJ4dO/s4DuaPTWM49oOTTr2jL7ozb5xNGnLEbi7uKDr2KC1PPy6vukTquqKnld+0DVBy+o644VxkV2IH9CuyNyVE3oe3nAYQ55Af0vdtKZPn4GYip05xd3nV0Unwqb0kQIejFstfg/yQV+KtFSJnkocZUwAvtMa8k3ZOEKxBsCIeE4vjFwxdUtbIs7p5YZIbgfGMqP8XAp6oy3HX6X+bi8TrWlFf1a8QEJN/sak78QOVV83OkFyB2obsBMCZ8iSLKuO37Bi3ayD9DK7RPlFfcj6cLBQ2ad2GA9dJqOPQ0wQ7wrkliwd+P7VnVDx8vem8a+n2GKi0r03ERAuZ3HvOwgnV1bxO7anW3FNvzJ1l52WRjGI7AaTTw/WowGvTDkom3944CsYTCPi8XWdGlEI12YiIBagH2j80mAe5vxpjO1/jbHxMxOVkmhsqov0lE2YabGqBNvhB/I6ncam+7S04IbAmAbasr6PTk77r0NO9tHBB42UlK/EqtODxkpQmcs6PuW5IDUG+dntbrOjJEFgf/Ev9UEQmm+QnpxyYWKpHxUrU30eFHGrenvQKZFVzG+HtPBEc4Kf240FNKWJO4jGQ1HR8MN9y0QHPE7W5R9TAM1rIH8wTGrYbyDQewoUVHUzStTBysmbo+fnbsRzO89rkUTlqIYHQrQFHC/KghgPAHM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(8676002)(478600001)(336012)(426003)(7696005)(2616005)(44832011)(36756003)(81166007)(356005)(47076005)(54906003)(316002)(70206006)(70586007)(26005)(186003)(2906002)(82310400003)(86362001)(82740400003)(110136005)(83380400001)(4326008)(6666004)(8936002)(5660300002)(1076003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 16:34:45.7620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee59e9e-1737-4613-6106-08d94ad31e7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

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

