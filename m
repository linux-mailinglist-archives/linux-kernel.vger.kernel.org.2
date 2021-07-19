Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54853CECDA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381836AbhGSRiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:38:51 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:60384
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351309AbhGSPyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:54:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1GjHsAZ6SXUfnIXkQ37sioFHEQen7mLso6fGVPt/DWoT0hn876Us50DioSt5hSeAPiIfBRODLw0+hpUNb9vhZRRk5tSIqEsfvgHNClnf0962imnBEwJ5yxR0vNlgXvHbsL/0SqCdW+egR2Wzy6/I7jp89U59BriMf/nM3B9yQ1EaL2gDXrRhd3BmVNYDiCMWGU00rqqzNBKLxKjTnYczBEarGkwg6V0367OFeNDZX0nQXDlF0R0e9ycWqYGKEIPdBU28VhsCtWdFY/uG3BMypX5A6kDEcSjDTbCBM8jKlaP6PC3KCWPJCi6vBaK3rMXsI1MFvgPVdRc28KQSwBD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA4jKcOAxvuYyc8Wc43GPzHv7QEt6orLbIomXiUEZTE=;
 b=AjEffxUbDSLCMc6y/iacoIImz+kE+lCkaKah4k+HGIcX/jox8kBU01mbhMEXMBdXGRTHDptN7vxVBdLcCOKSqBVLkCgevrC6YDOYL3mbzT2GtejQAixfQD72wDE2niHDi1i7D60NxWBT1AXAOnEhjL3t/zb7QYnRIVAC+0TE8Vf+EmT9hA6MfOYyPNlibTPYMxC4UaWxOiKc/fFz3BodM2axBFT9PGovbrWQNsWWHSzq21VFUOLQeIfmzmWvcfIX6N6nro/RNNRHX8ybX0eYGfF7TXEqo/tqa5fQK2CvZdi+YMB36oDVFoR/pAimRhPKbbdwbVQa7x64DAWiclEAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA4jKcOAxvuYyc8Wc43GPzHv7QEt6orLbIomXiUEZTE=;
 b=CVQnj6k0WFUkFpP9hHHkQXb9VmcLG86t2GArbazarZn4HXJLDkGdBep/1OTE2Ip4p0z2XvoJ0e2WhA2ZQiyKTDVVK1tbAyFKMFkNJd7VYeJ3nn62ba2JhM+Jmrv82agyRhA0W3sX0c/MW5cPYiQQb0aP8OQeqQdVqhdEZzuqM7s=
Received: from DM5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:3:23::33) by
 CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Mon, 19 Jul
 2021 16:35:17 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::33) by DM5PR13CA0023.outlook.office365.com
 (2603:10b6:3:23::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend
 Transport; Mon, 19 Jul 2021 16:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 16:35:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 11:35:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 11:35:16 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 11:35:07 -0500
From:   Vijendar Mukunda <vijendar.mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 04/12] ASoC: amd: create acp5x platform devices
Date:   Mon, 19 Jul 2021 22:21:32 +0530
Message-ID: <20210719165140.16143-5-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719165140.16143-1-vijendar.mukunda@amd.com>
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faaa921a-ecbb-4604-bd13-08d94ad33160
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01202056B789AB06667AAD0197E19@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhV15x8PIOLNvpAakwgTkMeFJaKZkLAUXV0AQV0nSO9KkDzJ/jokG3UL+V3RnAntgoKpre2raVIUZxDz3hezX0H/J0JFSQ02VXhYw0Z/tIVSZVCdih5NEJRSY2l5ZfM6OOYkqwBI+9Anqr6+Y7xVpXo7E0YIg0RvApX36dHNw3ez357cJtbQKch/XnCRrJUteRgJbi8XFRoxCk3PJyGq/8wb/ljVCpvM3sAT1YmxmZKmCG8H0WFa2Dioc81siX4tKSR1YSpxKE41Y0TYhLT0koadkJdFH2IqK2STvMQLFUQjOhTejDGrkmTXDRyzG95dEnXJ5haLBMfZjd4rHFkm/yvg0KDo5o8hTxLgfsnF6pYbhmJNMIr3onwcGuDoMhGA/5LM3axr4hKCSt05aupFO2L33SUxYTWy7Lby2910NbXzXRWGIzeaznQp0FqMsQXCutzqBHMbteRFXJ8/YoD604cAsX7FntHI1IuTyqA8fJA5Pfi0MMBA8wzAbFXieFhfqfFKT6boQW511rHGcXpIZ9OJkIREOq7IiWNlIZa2d1ZZ69Yo58IpMD1KMGFBoTZ6c30E+S8gDPb5tLkrGRCsD4TiWmnbk6lZpPFmkYo+MUASyagFC5yPxo1/MCdj8xxNDmI5EvZspgZ7nF1DjqEsotX1Hz75u8sz55d0tmovC0pP1AKjP4C5jj+EXVP21mxSoqiMhdUbqUnMuNBLqgOao8jKzn8uOUSacRg6tGUwH36omtbQXpVbnf3DHN7uMdtP3gD9onCjfhjZGARY97H5mMb4xvXqujOd5TwVF2vjaxA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(46966006)(7696005)(6666004)(70206006)(47076005)(81166007)(44832011)(316002)(2616005)(82310400003)(70586007)(356005)(186003)(5660300002)(4326008)(1076003)(8936002)(82740400003)(110136005)(36860700001)(336012)(8676002)(54906003)(83380400001)(26005)(86362001)(478600001)(36756003)(426003)(2906002)(42413003)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 16:35:17.5544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faaa921a-ecbb-4604-bd13-08d94ad33160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP5.x IP has multiple I2S controllers and DMA controller.
Create platform devices for I2S HS controller instance, I2S SP controller
instance and DMA contrller.
Pass PCI resources like MMIO, irq to these platform devices.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x.h     | 10 ++++
 sound/soc/amd/vangogh/pci-acp5x.c | 95 ++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index 708586109315..bbf29fd2b12f 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -22,6 +22,16 @@
 #define ACP_ERR_INTR_MASK	0x20000000
 #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
 
+#define ACP5x_DEVS 0x03
+#define	ACP5x_REG_START	0x1240000
+#define	ACP5x_REG_END	0x1250200
+#define ACP5x_I2STDM_REG_START	0x1242400
+#define ACP5x_I2STDM_REG_END	0x1242410
+#define ACP5x_HS_TDM_REG_START	0x1242814
+#define ACP5x_HS_TDM_REG_END	0x1242824
+#define I2S_MODE 0x00
+#define ACP5x_I2S_MODE 0x00
+
 /* common header file uses exact offset rather than relative
  * offset which requires substraction logic from base_addr
  * for accessing ACP5x MMIO space registers
diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
index 523b962fe35e..3cc15a15b745 100644
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
+	struct platform_device *pdev[3];
 };
 
 static int acp5x_power_on(void __iomem *acp5x_base)
@@ -114,9 +119,12 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
 	struct acp5x_dev_data *adata;
-	int ret;
-	u32 addr;
+	struct platform_device_info pdevinfo[3];
+	unsigned int irqflags;
+	int ret, i;
+	u32 addr, val;
 
+	irqflags = IRQF_SHARED;
 	if (pci->revision != 0x50)
 		return -ENODEV;
 
@@ -150,6 +158,83 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 	if (ret)
 		goto release_regions;
 
+	val = acp_readl(adata->acp5x_base + ACP_PIN_CONFIG);
+	switch (val) {
+	case I2S_MODE:
+		adata->res = devm_kzalloc(&pci->dev,
+					  sizeof(struct resource) * 4,
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
+	if (val == I2S_MODE)
+		for (i = 0; i < ACP5x_DEVS; i++)
+			platform_device_unregister(adata->pdev[i]);
+de_init:
+	if (acp5x_deinit(adata->acp5x_base))
+		dev_err(&pci->dev, "ACP de-init failed\n");
 release_regions:
 	pci_release_regions(pci);
 disable_pci:
@@ -161,9 +246,13 @@ static int snd_acp5x_probe(struct pci_dev *pci,
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

