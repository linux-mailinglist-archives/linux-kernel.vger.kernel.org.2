Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334B03CFF65
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhGTPqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:46:43 -0400
Received: from mail-dm3nam07on2076.outbound.protection.outlook.com ([40.107.95.76]:65121
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236715AbhGTPkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:40:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad5e0bPoG3eQG8M9qCowzAEv/SoqDTYFknQNCVD0W9W7+5TaYBq9tIN/qLtn3eHqOaYjcNu/RuJloqr2YsE1Ja0SDF3J7AtX/iloqvqEn2dY4Uie6Yxp2zuA4bRiLR/Xh5BwjvBUcsCrcs/c0WDfPLF1hxAShDvv3nzz0e96pXp2qKBfX0YtKBU7ZwPpZ0+U3tGgBD3qP7DAwj12sWPUZ8qZh6DJeSlRl/9ByirVKqiXu77rBHjtWgr+Qf2d0KN2D9jGpuv0OnoUNuxnmYw7fZX45EX1d1kuHFV1/cuh+qPczjoL6lU5NbjIYqQQlsLGEjJA5LoUJUclGFmW1C9qng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KRmzAei832uTQMC9R5tSHHDMf+pFeJ/+KMFs0ahr8s=;
 b=HDg5r98FUlFWPqwxJCQqn5iOvRdP4BU9k4uHxH4pYpzothoP0Cw+7n0IrUEZTCevs0Rr8BtWphS+pPZbrhzSIXUFcL9hwZI2s5iADIDXymNfZaULaKrbemdzMxdrjMTJSh26isQBD4K9y1cxcKxhB50r2AJbbER3guL/6/HqT4tB+iK4OMqNH17gSNaBpoLb96MeR2huGvDBb9b8tB87P4e+G1oE/DEdf5Ei+jScY1jotx2ZiiTgeeuRoDVCGdnYFIU1E89Q5bPxMesUjd1NbRe+NYLLeleRCvLl8er7xBpYle4JOwsoyXloexewkU8wa1WSOv+kxLJfDfn927iSQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KRmzAei832uTQMC9R5tSHHDMf+pFeJ/+KMFs0ahr8s=;
 b=prk/acLb5wAj6DkivD6FUXssBcsLr8LLPFGc4t1gAnVDeYgq3hLZqQXS7KCvBoayHBaTOuF+oI5r2aUZU+9yJ0gmO8/5NsTsEXZxbtk/1UTLVeO9B8+L9+bZsVOabWt+ojTD1vzuHzlWJhDtAEJfash/6RZBuvI29/oUAqm8QuE=
Received: from MW4PR04CA0190.namprd04.prod.outlook.com (2603:10b6:303:86::15)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Tue, 20 Jul
 2021 16:20:38 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::33) by MW4PR04CA0190.outlook.office365.com
 (2603:10b6:303:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Tue, 20 Jul 2021 16:20:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 16:20:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 11:20:37 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 11:20:33 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 04/12] ASoC: amd: create acp5x platform devices
Date:   Tue, 20 Jul 2021 22:07:24 +0530
Message-ID: <20210720163732.23003-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0f5a375-bdb3-461f-dea8-08d94b9a4f89
X-MS-TrafficTypeDiagnostic: MN2PR12MB4125:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4125EC86D1B75001F74DAF5D97E29@MN2PR12MB4125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMJUj2BPi27vNWfv9sIV+G9lGomT3hOHyB2kH5gLyk9Z4NIzlfrckiBcalMFf/uij4rn66/niEQNlAFy2N5BZl1n6ju2MUXLdnh1hCOpul9XJQm6ciLcFFDq2MBgpDhUnsjPUnJ+cWYiZJxUyEXLqJoOD3Nj0QxI/TRPrk25xQpoCiIQa7yukB0aOXSqcSIlvEjG9DVnmApK6z1v0F8h0nHd7tXd/hcmN/sH2PGHi7DrKNU+238rBWa8PW1abw/O4Ft97Xr6rry+1jf5Y0QePeieyNo9VqcYbEd7JFQU/O58JLU1c7FNOk+jsLtiaWqLOsIuaqAu23J1smhirGx3SMIvNZoI+7R4jFLeiG5FUmwvJ6x+Edfn9+Z7dgnkQRpgfoxZeRqIxGmAPOyeqTK0/9Who9h8PGjkmxAkDcsUkAw3oXgpcWss0VTs7u9YsjJ6ZhBX3D2g0kbMla/i8Iom6UO4+Tp6ezhy3lGv2Ha2g3nifOwcPZoazhd9XZJnR19xYTF6waeSkTlPVvM68bG5In9K/xmP4TPidajU++Vy6C/xumOG58TjHxGfwfBh/IaNmUiC1iikYfJtR2FHJTAElGBJnTNKW9aFWI7k941KiYmyHY06eTGrIjN3f2yfwdmn6kGkjV7vbCuCNL0oI4pOcc8zOldy2Wp96rvaiDkVVLu2NOaUReGYd2T6+jxsTen1pjJ2iMo5ccMnR7bjl89bhVJgNQUuRc9+yTwvHDEZf9KydFPM1GPRWoGEv1eoIrOG2tc37MRjJXlTFSvRIiOat3exFn01oGlsZNHrwsH7Vf8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966006)(36840700001)(81166007)(82740400003)(478600001)(26005)(83380400001)(426003)(7696005)(82310400003)(2616005)(110136005)(70206006)(4326008)(54906003)(316002)(36860700001)(356005)(70586007)(1076003)(2906002)(5660300002)(336012)(36756003)(47076005)(8936002)(86362001)(8676002)(6666004)(186003)(42413003)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 16:20:37.9389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f5a375-bdb3-461f-dea8-08d94b9a4f89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP5.x IP has multiple I2S controllers and DMA controller.
Create platform devices for I2S HS controller instance, I2S SP controller
instance and DMA controller.
Pass PCI resources like MMIO, irq to these platform devices.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x.h     | 11 ++++
 sound/soc/amd/vangogh/pci-acp5x.c | 94 ++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index db23fffce9a0..32e5db10c1c8 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -22,6 +22,17 @@
 #define ACP_ERR_INTR_MASK	0x20000000
 #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
 
+#define ACP5x_DEVS 3
+#define	ACP5x_REG_START	0x1240000
+#define	ACP5x_REG_END	0x1250200
+#define ACP5x_I2STDM_REG_START	0x1242400
+#define ACP5x_I2STDM_REG_END	0x1242410
+#define ACP5x_HS_TDM_REG_START	0x1242814
+#define ACP5x_HS_TDM_REG_END	0x1242824
+#define I2S_MODE 0
+#define ACP5x_I2S_MODE 1
+#define ACP5x_RES 4
+
 /* common header file uses exact offset rather than relative
  * offset which requires subtraction logic from base_addr
  * for accessing ACP5x MMIO space registers
diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
index 523b962fe35e..25b42a37ad3a 100644
--- a/sound/soc/amd/vangogh/pci-acp5x.c
+++ b/sound/soc/amd/vangogh/pci-acp5x.c
@@ -8,11 +8,16 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
 
 #include "acp5x.h"
 
 struct acp5x_dev_data {
 	void __iomem *acp5x_base;
+	bool acp5x_audio_mode;
+	struct resource *res;
+	struct platform_device *pdev[ACP5x_DEVS];
 };
 
 static int acp5x_power_on(void __iomem *acp5x_base)
@@ -114,9 +119,12 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
 	struct acp5x_dev_data *adata;
-	int ret;
-	u32 addr;
+	struct platform_device_info pdevinfo[ACP5x_DEVS];
+	unsigned int irqflags;
+	int ret, i;
+	u32 addr, val;
 
+	irqflags = IRQF_SHARED;
 	if (pci->revision != 0x50)
 		return -ENODEV;
 
@@ -150,6 +158,82 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 	if (ret)
 		goto release_regions;
 
+	val = acp_readl(adata->acp5x_base + ACP_PIN_CONFIG);
+	switch (val) {
+	case I2S_MODE:
+		adata->res = devm_kzalloc(&pci->dev,
+					  sizeof(struct resource) * ACP5x_RES,
+					  GFP_KERNEL);
+		if (!adata->res) {
+			ret = -ENOMEM;
+			goto de_init;
+		}
+
+		adata->res[0].name = "acp5x_i2s_iomem";
+		adata->res[0].flags = IORESOURCE_MEM;
+		adata->res[0].start = addr;
+		adata->res[0].end = addr + (ACP5x_REG_END - ACP5x_REG_START);
+
+		adata->res[1].name = "acp5x_i2s_sp";
+		adata->res[1].flags = IORESOURCE_MEM;
+		adata->res[1].start = addr + ACP5x_I2STDM_REG_START;
+		adata->res[1].end = addr + ACP5x_I2STDM_REG_END;
+
+		adata->res[2].name = "acp5x_i2s_hs";
+		adata->res[2].flags = IORESOURCE_MEM;
+		adata->res[2].start = addr + ACP5x_HS_TDM_REG_START;
+		adata->res[2].end = addr + ACP5x_HS_TDM_REG_END;
+
+		adata->res[3].name = "acp5x_i2s_irq";
+		adata->res[3].flags = IORESOURCE_IRQ;
+		adata->res[3].start = pci->irq;
+		adata->res[3].end = adata->res[3].start;
+
+		adata->acp5x_audio_mode = ACP5x_I2S_MODE;
+
+		memset(&pdevinfo, 0, sizeof(pdevinfo));
+		pdevinfo[0].name = "acp5x_i2s_dma";
+		pdevinfo[0].id = 0;
+		pdevinfo[0].parent = &pci->dev;
+		pdevinfo[0].num_res = 4;
+		pdevinfo[0].res = &adata->res[0];
+		pdevinfo[0].data = &irqflags;
+		pdevinfo[0].size_data = sizeof(irqflags);
+
+		pdevinfo[1].name = "acp5x_i2s_playcap";
+		pdevinfo[1].id = 0;
+		pdevinfo[1].parent = &pci->dev;
+		pdevinfo[1].num_res = 1;
+		pdevinfo[1].res = &adata->res[1];
+
+		pdevinfo[2].name = "acp5x_i2s_playcap";
+		pdevinfo[2].id = 1;
+		pdevinfo[2].parent = &pci->dev;
+		pdevinfo[2].num_res = 1;
+		pdevinfo[2].res = &adata->res[2];
+
+		for (i = 0; i < ACP5x_DEVS; i++) {
+			adata->pdev[i] =
+				platform_device_register_full(&pdevinfo[i]);
+			if (IS_ERR(adata->pdev[i])) {
+				dev_err(&pci->dev, "cannot register %s device\n",
+					pdevinfo[i].name);
+				ret = PTR_ERR(adata->pdev[i]);
+				goto unregister_devs;
+			}
+		}
+		break;
+	default:
+		dev_info(&pci->dev, "ACP audio mode : %d\n", val);
+	}
+	return 0;
+
+unregister_devs:
+	for (--i; i >= 0; i--)
+		platform_device_unregister(adata->pdev[i]);
+de_init:
+	if (acp5x_deinit(adata->acp5x_base))
+		dev_err(&pci->dev, "ACP de-init failed\n");
 release_regions:
 	pci_release_regions(pci);
 disable_pci:
@@ -161,9 +245,13 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 static void snd_acp5x_remove(struct pci_dev *pci)
 {
 	struct acp5x_dev_data *adata;
-	int ret;
+	int i, ret;
 
 	adata = pci_get_drvdata(pci);
+	if (adata->acp5x_audio_mode == ACP5x_I2S_MODE) {
+		for (i = 0; i < ACP5x_DEVS; i++)
+			platform_device_unregister(adata->pdev[i]);
+	}
 	ret = acp5x_deinit(adata->acp5x_base);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
-- 
2.17.1

