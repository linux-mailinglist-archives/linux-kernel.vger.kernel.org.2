Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195743CECD2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381405AbhGSRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:38:06 -0400
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:15201
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349027AbhGSP5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:57:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYyTiSk3RUBkhQVXS5iT8AnWoFVdoojV5MrTQ74tFclluuC5QaBLtx1T1/v5HrGDhSYEBsgZ4sG+Sm/uDFsAt2NNAT5SYH7bJX4ZXSMAB1G5z+haRhsvr+MmUQZwCbtjsR3L5Unm99EC/gMBNS1TuiUhVwGaISaeIRmuJzi0G9TiG0hmn+7Z14Blji6IQi2/7gtGd1PIXnqhgAz0rvttEznPjrw8QqFedI1pEQH5l/Tc7NhciahA5Tyk6iqmFnN0+N2VuqD00HeczjeSNbEnJgphvC2i7b9qUAUgrJpDROotOp3PF5eY5fkeCeCuWqO33FQoSZS5/oL3x8kh93C/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzweO5aHJ6u0lcRGN9/URZ7qHzpwtiDPqwAmbkVNQks=;
 b=N9hcB8/D5YJxXNa8aDPurrkjzczpu+c/wVK0Y0SrZfUtcyTRZk+TuJRA8XMQvX+MOa+nxlmB7Rd1mjJPlyiFaV6MLhz3s/3jpmLuAYI79z1Frec34fwVIjAlPgLlay6m/RP0UZr791d9009NY7hOoYXIzx+ILzw8dVaLKOVuXGc2F2OaiuCCZyfSwVNAPQuwIIEzuo/SQ/23/+/94G3CbCEbs9U7wRXsKKX1oOhJ+oaJbjiQE39TwJG4nghOcu/Iq7VfOTPqJtNNkKO+CDjb2IOz5++kieinje3Oi7DzeGU8un5eOCZVzuTNwc0r6Zb0NVvDoqXcqcRqphq9Tq4l+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzweO5aHJ6u0lcRGN9/URZ7qHzpwtiDPqwAmbkVNQks=;
 b=PS/q4SURsblYucmkH3OSHkwJ+eUmG6/79qDzRRqm5eYY3OeuoRQ+E4Q8aQrImvzmqxP2P1D8lmNNVZTAHz66QBn4MZhcIv/zLVmzW4KLPr6pVuNWAXe9/kUaQboY49ISPnQU5K32FdyGcCwcjrN5r+Sm8QUT7KvxQ7/HS00dRuQ=
Received: from DM3PR11CA0010.namprd11.prod.outlook.com (2603:10b6:0:54::20) by
 SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Mon, 19 Jul 2021 16:36:54 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::77) by DM3PR11CA0010.outlook.office365.com
 (2603:10b6:0:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Mon, 19 Jul 2021 16:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 16:36:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 11:36:53 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 11:36:44 -0500
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
Subject: [PATCH V3 10/12] ASoC: amd: add vangogh pci driver pm ops
Date:   Mon, 19 Jul 2021 22:21:38 +0530
Message-ID: <20210719165140.16143-11-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719165140.16143-1-vijendar.mukunda@amd.com>
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 565c333b-14e4-48ce-2d8a-08d94ad36b1c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4591:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45917BF3F1A3A1CAFE1F3D7297E19@SA0PR12MB4591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pz/0YOeqBnMUaC1GNU9r7h539wNwvfAobSL5sTw+3cJLN8lboR4NMdzIrUFiGHTX+hqeP7EAyVfppON/fKNVdqJGiQo98tAkqOMX5KlzhopsekjGnSYAwfXAXqqeSZJd0DKAKy+jtGcqGMmhpqyhM1qMnb6/1wHo9Jb4QSrUPkLB+ZXBSNe3szde01DXb1pyxZ/ltiNCTgHCuOjk1lyKKOEcaLZkFnMqAOqBhek3BR6VdPqKJFp97uVYwZdnMMAFGxJNBg3EuturL0DlrSeAMVwESuPDLOc/ik0AlvNL2slBQJwKM18xS8Ko6vqQi6K77Jbty9y60XwFft2NurYxehpxbnkMiGsnYwvIIzWRtmOTnMFVZZU1ZQop3c4OktmBmF4YQmt/AhxpR075LW636z1I3kjw12wxfD3JvIr4SNL00ui5wPDx1ttiFMcIhOi5d6R4GtgQL0QDu9RNVPUFAmTzV9jsAl3QvlwP52j0kabP73LxxVj2KmAKb0ZfTGj4scjueiKeAOsHewkoKp4MBvoszp2c+dgfnyDIxPYKiu/PDMegUAVe3nTURKUfyQy5wbrS9OhLTIJzHIEzZMZWWO0FxsP433loMl5pLlViCtOs1crhroasIGxfW/Rmd+b4QcN1oVTzj8qmVZ2/+UeM9ipDI2plgCDgh2QQ7TphitDo9U1kpEoR4/KMFxU2xb+Q8qcbIBlP0tgwBW2bYyh5hccsshcT8otHbTg1yYZHSts=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(478600001)(82310400003)(54906003)(83380400001)(1076003)(26005)(70206006)(70586007)(36756003)(36860700001)(186003)(6666004)(7696005)(81166007)(44832011)(2616005)(8676002)(47076005)(336012)(356005)(4326008)(8936002)(426003)(316002)(110136005)(5660300002)(2906002)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 16:36:54.4050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 565c333b-14e4-48ce-2d8a-08d94ad36b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vangogh acp pci driver pm ops.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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
2.17.1

