Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B06345D8CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhKYLKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:10:39 -0500
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:39456
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231395AbhKYLI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:08:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXJnJvDbI1Qu/F1MCg2Z/DPkssqrjHfrPg+Iarn1dn6QdE4eDiaAAx6nVRxkOvg1iO9iKFJChIQY5TzvDoZH7bttGSdSH4+PRT9dvfo10PMhpqSwY5fUIgZo3d4OGBOJqBtGClnqTzKzgtW92cBws163/FBOAuJncgA7NDYhq3DAiQgpVc3ezqIFSOvd+sfRnaeQaEJqgPaSnFFKajp568wmb0eF80cTPS2SPdeMYxnXXAJrr0O+OmBIGTj9S0vUDCkVtyoB3csZOnGt1ygQmxVXyZRsKRYr1gfoW8Pmtq5+5+WGXIqVVjQWNtQnbQJF25zsYY5R7C3nyAw90Wl45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpwchxyZKhYZJ2daXHNA2qjsVocG08YlYHSX+Fjb9rE=;
 b=e7kRcuUXUkj1nVAfBNoa5Xc6D1FOYZjxRkTTWpzBVTCX42KduoAezzDeSbmqq9FtsLn8/4LhL833nR7BSExP8adCpUU4/sWbW4Bo2CTp2pBl7kkzLuiuh0Wb0SWXKn8962IFb1q/mzJ0kOFElwaGKjfLPTaA0q9eaYlTGeHsuyV74hyclsjlxw/JjohQwQZMXMs1OFPdt6v78OqnNsCJQbHjYwLb7Byb45VO8VyndQCzmfRRomv9UP9qammc2SX+8EAO1k1jSElWiJ/ajsa4Unl7IA0duvXEitK5L48dFKg8sDJHYC5bJ6tNompvkn7JUaX6T6bUuba0dhyXtl4Cfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpwchxyZKhYZJ2daXHNA2qjsVocG08YlYHSX+Fjb9rE=;
 b=pujvrOQqQdluhnfXuYMyH3fNRDZ4loknqei/ATOhjW2TdT4jLuBuV2wRikcGEOF/JjYQgKYiK+4gp6igN5KR6QLM05OlPFitiaw7k201YEo9XKasGPeApnbj6qMZTK7LdV3PHA/yuV57FpD5cljMZ3JocF0wYSfvaMkp55U9FAc=
Received: from DM6PR05CA0049.namprd05.prod.outlook.com (2603:10b6:5:335::18)
 by DM6PR12MB3036.namprd12.prod.outlook.com (2603:10b6:5:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 11:05:43 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::74) by DM6PR05CA0049.outlook.office365.com
 (2603:10b6:5:335::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.6 via Frontend
 Transport; Thu, 25 Nov 2021 11:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 11:05:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 05:05:42 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 05:05:39 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/7] x86: clk: clk-fch: Add support for newer family of AMD's SOC
Date:   Thu, 25 Nov 2021 16:34:41 +0530
Message-ID: <20211125110447.1188073-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
References: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bafbb8f-3fae-482c-65d6-08d9b0038694
X-MS-TrafficTypeDiagnostic: DM6PR12MB3036:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3036F46E9320E35BCB1DE5AC82629@DM6PR12MB3036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SyzA6TgO9610Z7nDIf1l11iyJuFBPyChxvEkQ1zUA4pkggeaqrNxts11IMOc+g2Vd9RsZfmO5jnhOT9F3qDVccZ6wHI/kZqQk/eCu+tpzPIxjvHDg0+rWgGzNKODnoNqX4WacC6xBQWIFREfCCXPb/H3lqZx3EEkhvib/TnlkXOwpM/QrnZShdc66/NtVVWj55XmCPIXDr3hfwypGi1XicpJUMBHGeFPtKbta3Vyzc9YjxQ/fzzzWN8q7IdD5MIu8rSxqDhfXCjjoDWTDFRC3vYnwDiSHrP/jETP8y7U6atXtHh9YDNoJSbDQaY8Lt86qUh+t1STMiznB60NntvOYMUF8WKCTy83wAwi0DfWvwm3EyfDSaY3tYrgwC73OkXA7xXqexgr9GRa5kEiVXvEe6+iHlPS8l+zxb2ZayYkk0Lw63i7AUsYsrZErj/7ESok1lHvy5pur8Eav03Op/0VlakyRwf6OzJ0fV4zVWSZ93S3hYotk/mgCnXs88ibXn9QjZaDKD5dT09Q+jD1qPmwyG65a0TCvBPKyx55LGrGm3pjbCsbWFq1SEPbAL6DfpUF6/0nZaDM2gJPv6f+vYjbv71Bow8VRpNjw7Sx/ZHOSyKs6Xh5ha5rmw1ySC8cdrRMyBGJrlar1V1tUZfmE1KUC0PJ3zJicMXMMFIDhJcNv1vXTNuRrolZ2r8qRPosDkkP8j2Q1btPCFpCVcS8a1JOT+3cYRJr/VFTlJkvxXKj5es=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7696005)(82310400004)(508600001)(426003)(186003)(86362001)(4326008)(8676002)(2906002)(47076005)(8936002)(36860700001)(110136005)(2616005)(356005)(81166007)(70206006)(70586007)(316002)(26005)(6666004)(336012)(1076003)(36756003)(54906003)(5660300002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 11:05:43.8059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bafbb8f-3fae-482c-65d6-08d9b0038694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FCH controller clock configuration slightly differs across AMD's
SOC architectures. Newer family of SOC only support a 48MHz fixed
clock while older family has a clk_mux to choose 48MHz and 25MHz.
At present fixed clk support is only enabled for RV architecture
using "is-rv" device property initialized from boot loader. This
limit 48MHz fixed clock gate support to RV platform unless we add
similar device property in boot loader for other architecture.

Add pci_device_id table with Raven platform id and replace "is-rv"
device property check with pci id match to support 48MHz fixed clk
support. This enhanced flexibility to enable fixed 48MHz fch clock
framework on other architectures by simply adding new entries into
pci_device_id table. Also replace RV with FIXED as generic naming
convention across all platforms.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/clk/x86/clk-fch.c | 41 ++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 8f7c5142b0f0..de556b03e184 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: MIT
 /*
- * clock framework for AMD Stoney based clocks
+ * clock framework for AMD FCH controller block
  *
  * Copyright 2018 Advanced Micro Devices, Inc.
  */
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <linux/pci.h>
 #include <linux/platform_data/clk-fch.h>
 #include <linux/platform_device.h>
 
@@ -26,22 +27,37 @@
 #define ST_CLK_GATE	3
 #define ST_MAX_CLKS	4
 
-#define RV_CLK_48M	0
-#define RV_CLK_GATE	1
-#define RV_MAX_CLKS	2
+#define CLK_48M_FIXED	0
+#define CLK_GATE_FIXED	1
+#define CLK_MAX_FIXED	2
+
+/* List of supported CPU ids for fixed clk */
+#define AMD_CPU_ID_RV			0x15D0
 
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
 
+static const struct pci_device_id soc_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
+	{ }
+};
+
 static int fch_clk_probe(struct platform_device *pdev)
 {
 	struct fch_clk_data *fch_data;
+	struct pci_dev *rdev;
 
 	fch_data = dev_get_platdata(&pdev->dev);
 	if (!fch_data || !fch_data->base)
 		return -EINVAL;
 
-	if (!fch_data->is_rv) {
+	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (!rdev) {
+		dev_err(&pdev->dev, "FCH device not found\n");
+		return -ENODEV;
+	}
+
+	if (!pci_match_id(soc_pci_ids, rdev)) {
 		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
 			NULL, 0, 48000000);
 		hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
@@ -61,17 +77,18 @@ static int fch_clk_probe(struct platform_device *pdev)
 		devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
 			"oscout1", NULL);
 	} else {
-		hws[RV_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
+		hws[CLK_48M_FIXED] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
 			NULL, 0, 48000000);
 
-		hws[RV_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
+		hws[CLK_GATE_FIXED] = clk_hw_register_gate(NULL, "oscout1",
 			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
 			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
-		devm_clk_hw_register_clkdev(&pdev->dev, hws[RV_CLK_GATE],
+		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
 			"oscout1", NULL);
 	}
 
+	pci_dev_put(rdev);
 	return 0;
 }
 
@@ -79,14 +96,20 @@ static int fch_clk_remove(struct platform_device *pdev)
 {
 	int i, clks;
 	struct fch_clk_data *fch_data;
+	struct pci_dev *rdev;
 
 	fch_data = dev_get_platdata(&pdev->dev);
 
-	clks = fch_data->is_rv ? RV_MAX_CLKS : ST_MAX_CLKS;
+	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (!rdev)
+		return -ENODEV;
+
+	clks = pci_match_id(soc_pci_ids, rdev) ? CLK_MAX_FIXED : ST_MAX_CLKS;
 
 	for (i = 0; i < clks; i++)
 		clk_hw_unregister(hws[i]);
 
+	pci_dev_put(rdev);
 	return 0;
 }
 
-- 
2.25.1

