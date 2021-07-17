Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E6D3CBCE7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhGPTrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:47:03 -0400
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:49376
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233730AbhGPTrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:47:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh3RdgEFSPmQMVtv4x+19z8jkNdRBUhfhIjFw/N0gO9DA3vFL74fL/JspBEksshxar9SWe4Jx6Y8o+ikLP55ODCQ6yOeTfzhimMDqAQXLm9cxFpojFjfaIAd2sxbuOMs9/5HUYvIof8VL3348ifi7zgVnB1t39SlIbPUalGAUG34kMCSURMbN4gUMFCJLi0AbskIPujot2SW6zqxba9q+nUwelSs71mtzvYgCk+Khh/1y5oxjYs93BLjxIiWTHKz5W81zrs46AGLJfZWU/Er0wD2HIy+5bhHvupC/gG6JtsI9sgiy3eVPjdMa4YnjbY60uOkb8/F18TmNNUbVBlx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAMz845RPFNf1Mj1bWBbPO49CP5LpoMA+t4YxdA5lRs=;
 b=L8O2z7amUtYT+/4gRRt+DErLgAlvCyzUmqednYiBcTkC7wfH8NWUAhoaIKDnyar6CE6E1qxUdqr8cI5/qkw52lyB4nTbMHMZ53so6wwdUIdnAB3F5zBu//mpUs1Ucbs+sfPRghIhd84Xeqd6yw8+UYxlcjiczDayL0oM3J+PAktsb4oIA/LeyASnYox0Qz6Th2YhZaIHGG4IS/KIoedDxHc6tO7uS3eIQ0J/GAotSwfGKs9uyEzups59M3DH8+/CZSNA3dzJ1dTEyKHYea3L6kSq14aB4D7e2xXYETAmwuU04niUOB3rpsjrPdsC2BZcTDWzGEiId35nxEj/FLfL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAMz845RPFNf1Mj1bWBbPO49CP5LpoMA+t4YxdA5lRs=;
 b=WN5dQBZf6xKBcjj0SeXpnS6DG+P5KFTqoMXTFKi9qboNqhj8efdBf5GDNEV7zgNC7NqYVYT9mZ5fFJXOjECcfA14V0eKvM1vxrSN4eSB2fVQvojdW4dTKqVloHi1Qzq1Y3U26eJAadz3Kq+eMy8oVuIZkJl+JZZSyfCoPBxKIKE=
Received: from MWHPR20CA0042.namprd20.prod.outlook.com (2603:10b6:300:ed::28)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 19:44:02 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::a2) by MWHPR20CA0042.outlook.office365.com
 (2603:10b6:300:ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 19:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 19:44:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 14:44:00 -0500
Received: from vijendar-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 16 Jul 2021 14:43:52 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND V2 10/12] ASoC: amd: add vangogh pci driver pm ops
Date:   Sat, 17 Jul 2021 09:30:57 +0530
Message-ID: <20210717040059.310410-11-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210717040059.310410-1-Vijendar.Mukunda@amd.com>
References: <20210717040059.310410-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c85ae85d-ed1c-4535-a70c-08d948920fe6
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459FC7EB39D2DBBD4B08F4197119@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vniroEtWzdFHfZm0KV9hoNCf3RmprcM6KtnSw//S/78i+N2dnBIQJIBt2DQDhLcUVqRNg1onihwVapeEbjvqzMyyRHP02H++YG/XQH9I3OhjVgXKAPddXcjyyYon1YHCz/psLNBSLmJCRVwFqEpFP/6Kb7FXD2kn7twVM0JaHoq9V+RzqhLmQ68J4dPGBcGJVXXJaSQErBLgHvi4SnpPycg/LWCfNaUyEPCCmrZPsu30Wb2SI/yooga8oItVU5Ugf9CmjRM64MDjKzqbMY9fDl4wU8Nlc8EzPHU301Xr+jWyaBJ+qdBzGCi5MMc3ccqUkyhmaiDZal2ZvJbe3QGiiUaOtTt1oicN9D155zpVXh9PUq4MtKXrGzYTOYKnVikzZMinYdnSBq7/uLHHPZ7inQQU4TTu+8+aLmP7XA9GIZe4XK4187QR5b+oDyTpZXmwefClCnfn3Z2I0XlpzrwgCZHH5RNJ9mS0w4ZDAOr0EW3W7n2fWibKrG01xghf6OYp/qZhYMEm1XGGjCdN3NUw2LAkjbwmTIHtbQSOB6EAkyLxJ08MmgLbu9NYVTkvjo4pC0SCwwwfqDAuBkmivoYv4jKSVKWkMTPk94t0296P6bH2nypP/5YzKtjLqmIYvUZUz5cieOnBiAPp5nqV/+nH84IO+vFNRNrNEGFHK4KOuq+t7l0IMPuo5sgRy6lp7pAXLcP1xev/1etY7FUxZ/jjYfu04M0EuTb7WSg6y8DmgQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(26005)(81166007)(82310400003)(478600001)(82740400003)(47076005)(1076003)(356005)(8676002)(36756003)(7696005)(2616005)(336012)(86362001)(8936002)(316002)(2906002)(70586007)(186003)(4326008)(70206006)(426003)(83380400001)(54906003)(36860700001)(110136005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 19:44:01.7176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c85ae85d-ed1c-4535-a70c-08d948920fe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijendar Mukunda <vijendar.mukunda@amd.com>

Add Vangogh acp pci driver pm ops.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
v1 -> v2: use PM related Macros
---
 sound/soc/amd/vangogh/pci-acp5x.c | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
index 3cc15a15b745..844614c758d9 100644
--- a/sound/soc/amd/vangogh/pci-acp5x.c
+++ b/sound/soc/amd/vangogh/pci-acp5x.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
 
 #include "acp5x.h"
 
@@ -226,6 +227,10 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 	default:
 		dev_info(&pci->dev, "ACP audio mode : %d\n", val);
 	}
+	pm_runtime_set_autosuspend_delay(&pci->dev, 2000);
+	pm_runtime_use_autosuspend(&pci->dev);
+	pm_runtime_put_noidle(&pci->dev);
+	pm_runtime_allow(&pci->dev);
 	return 0;
 
 unregister_devs:
@@ -243,6 +248,41 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 	return ret;
 }
 
+static int snd_acp5x_suspend(struct device *dev)
+{
+	int ret;
+	struct acp5x_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	ret = acp5x_deinit(adata->acp5x_base);
+	if (ret)
+		dev_err(dev, "ACP de-init failed\n");
+	else
+		dev_dbg(dev, "ACP de-initialized\n");
+
+	return ret;
+}
+
+static int snd_acp5x_resume(struct device *dev)
+{
+	int ret;
+	struct acp5x_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	ret = acp5x_init(adata->acp5x_base);
+	if (ret) {
+		dev_err(dev, "ACP init failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static const struct dev_pm_ops acp5x_pm = {
+	SET_RUNTIME_PM_OPS(snd_acp5x_suspend,
+			   snd_acp5x_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(snd_acp5x_suspend, snd_acp5x_resume)
+};
+
 static void snd_acp5x_remove(struct pci_dev *pci)
 {
 	struct acp5x_dev_data *adata;
@@ -256,6 +296,8 @@ static void snd_acp5x_remove(struct pci_dev *pci)
 	ret = acp5x_deinit(adata->acp5x_base);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
+	pm_runtime_forbid(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
 	pci_release_regions(pci);
 	pci_disable_device(pci);
 }
@@ -273,6 +315,9 @@ static struct pci_driver acp5x_driver  = {
 	.id_table = snd_acp5x_ids,
 	.probe = snd_acp5x_probe,
 	.remove = snd_acp5x_remove,
+	.driver = {
+		.pm = &acp5x_pm,
+	}
 };
 
 module_pci_driver(acp5x_driver);
-- 
2.25.1

