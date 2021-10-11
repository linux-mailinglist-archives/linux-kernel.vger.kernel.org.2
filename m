Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444C942864D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 07:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhJKFlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 01:41:19 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:50496
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233732AbhJKFlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 01:41:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CndeyrEdfvPcCmYjMbsSxcC5aayCabh2XPu9eID6HFZrFCrt75eGv91N8c0LUsFJIVcC91k2uyj3flw/G7aJl0RzeH/nGA1QdPtrTPxjq7IXr0WfKj5OpmYBIL60tg+bEp7oDKqMNY8xErZkhq90sxpBqOrHlsyhWlaM52214hzYnTq7S+UjVSD1gGVr3Ky14IdEKH2s3/9IFmRaJD7iaT59b003mhw2eMMT9W+cD/bKuzG2NtQi+0jmNh1KXAdWEebO6u3IecCKRudo7JEdEpF8KzfVjQ5JtiwxkHk63ST03UOdc5EuMEICQ+edeRVC0Og3QuvW3CKvnhOSVE3hxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwPQx5COo81YES06ebaC2WmNpLcU0Dcrq2Lp9un263Q=;
 b=TAWJaJOqpHUug4UlpwhT83pIXqk+olrnImymqjRGiJNDLE7aaHIPVrYdvbiwprFZh1t3j3RLMRMqKrY9pnm3SILlZqwLaKkjm9gKPynUD5sXAhFwgTh76pf2IAgFyOWyYsGoIeR2tDpr4RDz67aU0rNEpQtxX4F65EA1iQRRAgAtuBhOVGXbKJZXncFx9a+eWEHZ1dOhXv0hKFTn24mbX9gixW64OV8gMiuaRjwhn0yzz8DgOhDtGGe7YxNYOby55rN3dLufmd7WOiOcaAlNdGv8CZ3U5dCv5y28omREYaoJLS4L3TKJV+IN9XSIfJ+jogN9iXBB8eMLdXF1arOMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwPQx5COo81YES06ebaC2WmNpLcU0Dcrq2Lp9un263Q=;
 b=ADV5izI6v2yaabgwdi8waVyBDQUAS8ROE0ZboMFDnl8KZxxUnzVl0XJwkgx4RFJxE2y8+OjAAplo1b2XV9/JQfic7YcFl8H9QZlzKzXpng0jZrHZpnXXVNvUmkevk743ss238tt/U+rctpzYKfLN3jZMXx+7FmTds4fhffBiOJs=
Received: from MWHPR1701CA0003.namprd17.prod.outlook.com
 (2603:10b6:301:14::13) by BN8PR12MB3380.namprd12.prod.outlook.com
 (2603:10b6:408:43::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 05:39:13 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::43) by MWHPR1701CA0003.outlook.office365.com
 (2603:10b6:301:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Mon, 11 Oct 2021 05:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 05:39:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 00:39:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 00:39:10 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Mon, 11 Oct 2021 00:39:07 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mario.Limonciello@amd.com>,
        <Richard.Gong@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/13] ASoC: amd: add acp6x irq handler
Date:   Mon, 11 Oct 2021 11:26:14 +0530
Message-ID: <20211011055621.13240-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
References: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b91f3956-eedf-4963-ea47-08d98c797499
X-MS-TrafficTypeDiagnostic: BN8PR12MB3380:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33805E82129EC322CFA4946697B59@BN8PR12MB3380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9bhCvwjfd6yCfKfTV/r/SLxbb4VEYbzZFMgcGZo0IsB6aDH2jQeL7PdPjW1/OAzM1bu/0M6SjHgFOwnYydGjaXnT92GPmefzv33IwOBkhSHBlLGXuZuzOn78+ilgLMfOqiVboJHZrXrrzX0ygXCIHB/6Q8QCcVfHBY3GZpFW7ChgK5G9UAtIKw7l+gmKJvosrNf9pJXwd0XfhOyHVcdLolrIjkv1Zw1Nv03EpKzByflcqDNtDd3Eh9QFeRhEVKLt/VzjPB35oGACvaHNgCRb8nNREZhrC6KyGjSF7UdSbPpvAinXXaIBofZQtHifkj7nr9dNP8LdquQYA2Jw+/rcjVIJodB9V2I4gVAE11wmzoDsizWi262D6f1qeQW2ziQo5n1TeMvcc6lnxNbqMnmUjPYq7qLDnFLjavGDy/JxQLhz1wtD6j4BbyoVcOI2+dKnMcajUdY7lgenq1Ce37ydFlrIlNDLCXDL5nVnSf54WqoiHGHWopcaA4C0WkKAT4Lo1lp/dc89w4FbbnDaGy1t/b1+NMdxqBJgjHPOZ4iUY4Bwb7mH91hdlcD7Uq1RcCBOMRc9p99yqQV94zAVXg9gOSZhrEovmPBA/Z+gDOM6rvVc2w92nrbdh4MbItjQED9rUBwmJwWd6fscDT5RDt8SrK2ChpBfBNQE3ooj5zSrtoGj29/R44OGn83m/JQOKKtI1eXhAHWc6rUT7Kb2ZZfNUCoCG5wyDoMWkQD6olz3L7M7kQhrmTFdZMIswEPUUGjBYIrd9EOxokJQ6eJ1VeGwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(70586007)(2906002)(5660300002)(36756003)(4326008)(110136005)(2616005)(1076003)(8676002)(82310400003)(508600001)(316002)(47076005)(186003)(26005)(83380400001)(336012)(6666004)(8936002)(36860700001)(7696005)(356005)(81166007)(86362001)(54906003)(426003)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 05:39:12.3362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91f3956-eedf-4963-ea47-08d98c797499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3380
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACP6x irq handler for handling irq events for ACP IP.
Add pdm irq events handling.
Whenever audio data equal to the PDM watermark level are consumed,
interrupt is generated. Acknowledge the interrupt.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/yc/acp6x.h     |  2 ++
 sound/soc/amd/yc/pci-acp6x.c | 37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x.h b/sound/soc/amd/yc/acp6x.h
index d6b2c70ce9c8..4ea37794db84 100644
--- a/sound/soc/amd/yc/acp6x.h
+++ b/sound/soc/amd/yc/acp6x.h
@@ -25,6 +25,7 @@
 
 #define ACP_ERROR_MASK 0x20000000
 #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
+#define PDM_DMA_STAT 0x10
 
 enum acp_config {
 	ACP_CONFIG_0 = 0,
@@ -46,6 +47,7 @@ enum acp_config {
 };
 
 struct pdm_dev_data {
+	u32 pdm_irq;
 	void __iomem *acp6x_base;
 	struct snd_pcm_substream *capture_stream;
 };
diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index 26c8d652fd08..86b33f401e12 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -9,6 +9,8 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <sound/pcm_params.h>
 
 #include "acp6x.h"
 
@@ -116,6 +118,33 @@ static int acp6x_deinit(void __iomem *acp_base)
 	return 0;
 }
 
+static irqreturn_t acp6x_irq_handler(int irq, void *dev_id)
+{
+	struct acp6x_dev_data *adata;
+	struct pdm_dev_data *yc_pdm_data;
+	u16 irq_flag;
+	u32 val;
+
+	adata = dev_id;
+	if (!adata)
+		return IRQ_NONE;
+
+	irq_flag = 0;
+	val = acp6x_readl(adata->acp6x_base + ACP_EXTERNAL_INTR_STAT);
+	if (val & BIT(PDM_DMA_STAT)) {
+		yc_pdm_data = dev_get_drvdata(&adata->pdev[0]->dev);
+		acp6x_writel(BIT(PDM_DMA_STAT), adata->acp6x_base + ACP_EXTERNAL_INTR_STAT);
+		if (yc_pdm_data->capture_stream)
+			snd_pcm_period_elapsed(yc_pdm_data->capture_stream);
+		irq_flag = 1;
+	}
+
+	if (irq_flag)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
 static int snd_acp6x_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
@@ -124,7 +153,9 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 	int ret, index;
 	int val = 0x00;
 	u32 addr;
+	unsigned int irqflags;
 
+	irqflags = IRQF_SHARED;
 	/* Yellow Carp device check */
 	if (pci->revision != 0x60)
 		return -ENODEV;
@@ -208,6 +239,12 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 		}
 		break;
 	}
+	ret = devm_request_irq(&pci->dev, pci->irq, acp6x_irq_handler,
+			       irqflags, "ACP_PCI_IRQ", adata);
+	if (ret) {
+		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
+		goto unregister_devs;
+	}
 	return 0;
 unregister_devs:
 	for (--index; index >= 0; index--)
-- 
2.25.1

