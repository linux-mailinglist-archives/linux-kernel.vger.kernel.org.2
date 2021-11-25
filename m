Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC07B45D4B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347719AbhKYG0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:26:53 -0500
Received: from mail-bn8nam08on2062.outbound.protection.outlook.com ([40.107.100.62]:41473
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237478AbhKYGYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:24:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtRWnoJ5CqcSgKai4k7DJVxgccp3iMI9u+aKwVe1JZsyC1xQWKOK7BiBtoak6CeQzwn+geBdG3MGHD+rn+0alcGtQX7x8mD8ZWqdnu8yNANkWSGcG6NGjBrxFgxYZuYuZwEbvruwSA0KiLynlmhL5uoZ5+cpmzCIliJsSGvj3wC00xiLdBVAGV+3MdXhMxMHlsOPhE5EXpgHypGdIF4oquwWZnRpXSg8zDB/dhMltDOJqYkmhfYfuyv+g71gvC9QzgieQAM3FKinwDsg7e3EA/sR/eq08RBXFCn8jjFJ2FrMP1LExtZo82+ZE6U27HX036xL/BzwRfu4TtHYJS7big==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rteLx6CLsJxoduLjqV1pKBvheGJGuZVTFasjR6p2yIg=;
 b=KK77NMbP8XHEEmQCvdCMMoMOmKxKHF1GbhNv6i26h26Ex8I7kKH+8hp9ZOR0PQ9Squm8Uf2yiR6uHtC8XbJn2Hd+tYeK0b86aG6q7BnByB7hPsshEtYKnDKOpcV72QI0bdSqnzj/RtdlXlp5E/uGxwmJ38y4KI6nYP10IyFtD9xZxCRA/Vtolr5DR7IgDCynuCfxJsm9BK/GHS5ML9O2DqMhBY2OLoru5ckakFVvF+FbY2qR3RTo/WenEwzYrwid86nlMB104HPfqejznyhj3Ujons74vPrZtjS0hghKTK9aY0AevdCZ0BSXFWOLsEluiSIoX+JiiHyxoUTY+FsY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rteLx6CLsJxoduLjqV1pKBvheGJGuZVTFasjR6p2yIg=;
 b=RrNG9nUFeik2RF5bIojPqgX/fSSIYC5oVu9jfmg7zcU7LvpGTJrmohwTCmHl3nZyBIZpo+aIEKFFZwcFRXM39FOJZU6zmkMHUoT15iFD+BtCC4JsyXqPdTHC5Atl0f8Y7HHuJcQFKGRNEXHDtLEDBqG5wyK5VhqeZjUupvuKlAE=
Received: from MWHPR21CA0065.namprd21.prod.outlook.com (2603:10b6:300:db::27)
 by SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 06:21:38 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::b8) by MWHPR21CA0065.outlook.office365.com
 (2603:10b6:300:db::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend
 Transport; Thu, 25 Nov 2021 06:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 06:21:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:21:36 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 00:21:33 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/7] x86: clk: Add check for PCI root port for fch fixed clk support
Date:   Thu, 25 Nov 2021 11:50:30 +0530
Message-ID: <20211125062036.1185994-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
References: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: affb258d-0fd9-444a-e104-08d9afdbd655
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4621D4E88F9D34E6D5C9744E82629@SN6PR12MB4621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LLFKQuXqe9f9P7VOV/cB9SaINKX4A2jAUeutMXBjbscS6Q1wbfojezQBs8uhWkIUUcRyDu/OGMK6/niggvck7CKNYd7T8p06QBmKKbmzUxxEGO4DmzYpwdV2v4V6tbybEXUK0CzOpEnfF8YixcpJdt7iLoZXq9g5eO/S2u8SeHZm6VAabfWd4EgrB7CwHUMVRkeLkHepu/y0f0LGZ7QrYvjr918aSBpD3TMBQKRZhNaeIq/ngEP+vy8EHPki3U9jKHw6Ev0qV/VlnDXbPBGlWKYLp+SIK4mGixL50CsJPO1v5prGvMvBmi8CYIvb2E1v+ipY/ViP4WGi0qvQ9fc0v8NtuWTeibYuZ2hb+/49STrSGaxqfXJ+jD3o8u03hErYLTEhnkvJTDEfYf6CtT6U4ZDEw9nphSDpaMavfVmcKRjmxNQb/PjOzNmsstVxKMyT9fxjeGYIVXSf0XUAM66ehEl06E7GH7yH1esIBBM+tTOclN6B01ay3GlFfcwctDW+LyNLPxbTMcsRB1RGfYRG87r+KDES+HSCrLDcF6gmpPAeHe0e/tAaVjO4mTDlvpPLHeQ+ihtBSVvFC8WqjZmkAARpQKzXjMKLw0eMAc9EyC1g8VxrPDYktXvXoqZBi9sCkaVw+/5CAoF4x8Yk3VIZEfMfZrG77G6Q3fCVdMMqClN5CzxSNl1vmSeFlQTaXrSyQNBU9Gvm7VG+DWdJxJ7hOr+4/9rODvMx8i8Y7QWlRo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(81166007)(70586007)(86362001)(8676002)(4326008)(82310400004)(7696005)(426003)(316002)(336012)(70206006)(2616005)(2906002)(36860700001)(47076005)(8936002)(186003)(356005)(26005)(1076003)(5660300002)(83380400001)(36756003)(508600001)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 06:21:37.6337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: affb258d-0fd9-444a-e104-08d9afdbd655
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4621
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
 drivers/clk/x86/clk-fch.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 8f7c5142b0f0..df59fa8ac0a4 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
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
 
+static const struct pci_device_id fch_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
+	{ }
+};
+
 static int fch_clk_probe(struct platform_device *pdev)
 {
 	struct fch_clk_data *fch_data;
+	struct pci_dev *fch_dev;
 
 	fch_data = dev_get_platdata(&pdev->dev);
 	if (!fch_data || !fch_data->base)
 		return -EINVAL;
 
-	if (!fch_data->is_rv) {
+	fch_dev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (!fch_dev) {
+		dev_err(&pdev->dev, "FCH device not found\n");
+		return -ENODEV;
+	}
+
+	if (!pci_match_id(fch_pci_ids, fch_dev)) {
 		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
 			NULL, 0, 48000000);
 		hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
@@ -61,14 +77,14 @@ static int fch_clk_probe(struct platform_device *pdev)
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
 
@@ -79,10 +95,15 @@ static int fch_clk_remove(struct platform_device *pdev)
 {
 	int i, clks;
 	struct fch_clk_data *fch_data;
+	struct pci_dev *fch_dev;
 
 	fch_data = dev_get_platdata(&pdev->dev);
 
-	clks = fch_data->is_rv ? RV_MAX_CLKS : ST_MAX_CLKS;
+	fch_dev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (!fch_dev)
+		return -ENODEV;
+
+	clks = pci_match_id(fch_pci_ids, fch_dev) ? CLK_MAX_FIXED : ST_MAX_CLKS;
 
 	for (i = 0; i < clks; i++)
 		clk_hw_unregister(hws[i]);
-- 
2.25.1

