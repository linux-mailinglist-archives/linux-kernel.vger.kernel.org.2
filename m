Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5813BE2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhGGFot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:44:49 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:32576
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229717AbhGGFos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:44:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6fdI34wS+skOXWRTPTzQkLLXZaTwD/1FisXkBTJCh3GrYVp3Pd+ilGwheCspS8/Yvlh+aB5Smk3pNRkV5zpGHHmlAxxLriRtV3ClM0zhsCUGlqMXZjuXL5+Xi0gjR7exCPJOHWt28K/Ex8jc/1QRJq3GCiGU+vxppFpVh0utgSkfS1JViMmOPVOVUNQrPfAtSY0cnYuhzK6XaV5EonNVmVHkfdjaqs6z6MmZ51LJ/mZ0NpqL4qM6WyKXqFgzFZg65j3DvR647NEMPqPGDNCQvBCCEDqlNU9bIuFKbj5zrhev5F5fb1RdpIdGvugpLDL2UDclGok5CSsHSikrBuJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIHDb7yxbluUb/XBBEHp+nT6t7eLr5moh8zoApIpqTs=;
 b=bVxdx9J8UW6xMnOvPuNRqRAWYJbIw3Ry0U+lmhrl6qRMVM4QZg5gWld5AuCVnvKyI72IwxUDcpFWJ7Am3Cyh/SzsnsopVAsAj3pN1Qq8yUL4z6DJ2iBpG9W85KuXqpWsVfIjEUSwYRuBt3AYqBAWaidzDHMXmWK1h6TSB4Lu92EioMkCsfMr6NXmsbiOQLI4PO5SY/fpjcGP4foTLI5GMKRX+6n46j7ggqzA6smUG6A+qSdRQs3a9FgTNBlwD9l8LtjM2TwpFLkWxsjrJkQ7sbVL3eFEVUOb38HqD2AOjlWC+g44iEI1nOw0nN+SM58lrKomkQ4xgV6Ilgg6rxPfJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIHDb7yxbluUb/XBBEHp+nT6t7eLr5moh8zoApIpqTs=;
 b=s34t0uSj2YvgzKtLZBZbsqwQIQNHH5qTSha2sc5GUBHAXtdZ9MISGl93bPPuOyb+iFicLKALua7B2yDETqqsqjttJskBipfk2KShpCzBPMeA7KkRrBgu6tG7uW8qjAElWTm1HcWyhfgLAoR8DVYFrtqpSEBgpNnuXaalS456uA4=
Received: from CO2PR04CA0158.namprd04.prod.outlook.com (2603:10b6:104:4::12)
 by BYAPR12MB4983.namprd12.prod.outlook.com (2603:10b6:a03:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 05:42:05 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::2b) by CO2PR04CA0158.outlook.office365.com
 (2603:10b6:104:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Wed, 7 Jul 2021 05:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 05:42:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 00:42:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 00:42:03 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 7 Jul 2021 00:41:53 -0500
From:   Vijendar Mukunda <vijendar.mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Vijendar Mukunda" <vijendar.mukunda@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/12] ASoC: amd: add vangogh pci driver pm ops
Date:   Wed, 7 Jul 2021 11:26:21 +0530
Message-ID: <20210707055623.27371-11-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707055623.27371-1-vijendar.mukunda@amd.com>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6c92501-42ab-4bbc-b7b3-08d94109f3dd
X-MS-TrafficTypeDiagnostic: BYAPR12MB4983:
X-Microsoft-Antispam-PRVS: <BYAPR12MB498348343BF6E0331609BBCA971A9@BYAPR12MB4983.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0Q/qJZsZQz1tTFTaQv3NgwZpf7RpB4UKiq/q7GrnQLflXlLd+JQ9wpgNDPqsgY8NhIRBT4dlav60g35g/NPdBQ4kMHATjCbycuzw8Vdx8GLtmC5HWK5WJkoyMe4DCM80Recy6sPE+EYpgPf8oYieWDHMpeZD14yOX3Yb8CL9nJPmunR1TA2x4Exekf0fl2qCVIqU00ozUYoTnh8v2qvNSm4RCeqgFYjiqg7X3kJm6JuEAs2SgNiQ0BPjWSZRES9OrM7pCZJha5K8PNZNrp14mR5sO+2LHA5lWowavxJ2iJrQCv9+qjslZumnAkPZwekH0CYzMxU6XMP4fZxNPGTJNaWDv50qCYh/hfyARohMchd16VK34w6U1EN7Ufw5WfwVy2C42WPbGXMMYs529w8uyAtOsFCJfCkznRB+aeWM29tTZ0pgg2QwG6hKD8oYHChoozS2c3K0omslLVWAflSYvXHfSaS16PgAztCdefOfMvAoUAZ8BsuGPQeOntTNO7Xq5t/5LRJCUaU1LYWHlbgjOKqv6sqHvPtVReIC1Uf2UYgYrFCYON9NWQOGWmRvaPeaNSfupgMkOo/ZqTx7e9Lp7z4oq14oQ5HTzLp34Kv7bCJYHJYIg3GkeGjF9oekVWOUekuV9L30RYgEFwsKdqriIVN4v6CETbE5puu4uN4h/8cgST0qLUVpLzGSQojzvQenpQ1upSV3VcpJUTLbnkZF/uutIfpGP8WBs9ZSvLm/U0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966006)(36840700001)(1076003)(478600001)(83380400001)(426003)(47076005)(82740400003)(6666004)(5660300002)(54906003)(44832011)(81166007)(336012)(2906002)(26005)(110136005)(36756003)(82310400003)(70586007)(86362001)(70206006)(4326008)(186003)(36860700001)(316002)(7696005)(356005)(8676002)(8936002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 05:42:04.9871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c92501-42ab-4bbc-b7b3-08d94109f3dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4983
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vangogh acp pci driver pm ops.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/pci-acp5x.c | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
index 2779423f7cd3..c95e2212188f 100644
--- a/sound/soc/amd/vangogh/pci-acp5x.c
+++ b/sound/soc/amd/vangogh/pci-acp5x.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
 
 #include "acp5x.h"
 
@@ -255,6 +256,10 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 	default:
 		dev_info(&pci->dev, "ACP audio mode : %d\n", val);
 	}
+	pm_runtime_set_autosuspend_delay(&pci->dev, 2000);
+	pm_runtime_use_autosuspend(&pci->dev);
+	pm_runtime_put_noidle(&pci->dev);
+	pm_runtime_allow(&pci->dev);
 	return 0;
 
 unregister_devs:
@@ -272,6 +277,41 @@ static int snd_acp5x_probe(struct pci_dev *pci,
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
+	.runtime_suspend = snd_acp5x_suspend,
+	.runtime_resume =  snd_acp5x_resume,
+	.resume =	snd_acp5x_resume,
+};
+
 static void snd_acp5x_remove(struct pci_dev *pci)
 {
 	struct acp5x_dev_data *adata;
@@ -285,6 +325,8 @@ static void snd_acp5x_remove(struct pci_dev *pci)
 	ret = acp5x_deinit(adata->acp5x_base);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
+	pm_runtime_forbid(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
 	pci_release_regions(pci);
 	pci_disable_device(pci);
 }
@@ -302,6 +344,9 @@ static struct pci_driver acp5x_driver  = {
 	.id_table = snd_acp5x_ids,
 	.probe = snd_acp5x_probe,
 	.remove = snd_acp5x_remove,
+	.driver = {
+		.pm = &acp5x_pm,
+	}
 };
 
 module_pci_driver(acp5x_driver);
-- 
2.17.1

