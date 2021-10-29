Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6356743F734
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhJ2Gfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:35:40 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:4744
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231964AbhJ2Gfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:35:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2kGAnJNJsHJ7gocPXefuT0SFkPl6QI01s0egDVVVRoy97AMC9xt56VDZ3Grv+vGgGIe1jxg7sOQb8RkmiIFrj7ZqpgZHbVjN0Mj3QZWh65HjsvdTAaml9G6iHM75tkcJaLStgLBzd+L0iKnar3mMW/5R1wLWZWqIKk7fu+VX1/iq/cIxs1uHs96gUfLOaskHkb782vVPeH2G249D04quILvNPEdtr+4mP+8jARp8ZUC7skK4QKEuYgl4VsmDJrho4EBfcoscPMbjVofFQHKUsYqn+Lse83IuDX/0G2MHv0aWeweYu3yGwIMJD/naOdNGpd5XPPPRKer3inxJqek5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/1QIBhBeFeUz3assXx4YNB3UJFrb4LzlVOEAMnc1fU=;
 b=fB39NdfZVzOmUpnFbJn6ZImlh2xhiBjxIb5x7xikMOF6BNMg69iBO7Bk3PtbWTrIn1fFqtndJk1h7mdNAXKh+EWMgd0PYK7yh45YJKbN/kbkOF/hKqV40aeoXxhmKe3NDxRBlGAA0mUe68N8i/seDgV/E1+mBXgH+Ea8amRtiaRJ0Wyx7w5MfByWoNMsPA9ogS9kbmNHiqiL73p0wqmEJrm/a2GcoO71VkEjD3gMg0HiDAj8VatKxmVOSFMJn0UKDXD3Dl0UdsJsBahoS6NkZuyfEeFX/qIUh74Hiz5KFSdW/kIL3jt6c4uRBmo596hfuk+MwT/GwROsUOWCntANCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/1QIBhBeFeUz3assXx4YNB3UJFrb4LzlVOEAMnc1fU=;
 b=FLEE7Y2nUay+17UA07mzGkGiFnXwgFxnScTdrXjl67w0ZVX1d5lpp3o6RIe7ujiCeBj96tZhfTBzbg3lSIH91i7BTgkJIJRwRo7hJ4bzVzz09+BH+iN+WYBujekbK1OxVezZeQcmQhuldMmMaMmZmbaDT1gp/zq2xKZ68PIg56U=
Received: from MW4PR04CA0274.namprd04.prod.outlook.com (2603:10b6:303:89::9)
 by DM5PR12MB1900.namprd12.prod.outlook.com (2603:10b6:3:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 06:33:06 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::83) by MW4PR04CA0274.outlook.office365.com
 (2603:10b6:303:89::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 06:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 06:33:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 01:33:05 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 01:33:02 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 RESEND 1/5] x86: clk: Add config option to enable 48MHz fixed fch clk
Date:   Fri, 29 Oct 2021 12:02:24 +0530
Message-ID: <20211029063228.578909-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
References: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b518be8-66dc-4c90-39c9-08d99aa5f7d5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1900:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1900DF1E83FE37FBA810CE1382879@DM5PR12MB1900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7S8lH8c+XtKHlNjhO2PSYKs3mIOGs+x15KIrxICSEPoLTvb5jkgc0AwTLDh0Ww8o+PNnysLs3Dwxoe7nEp6W9JwoyBW4SlKDQzGpybSU8cyMUyF7V98S00HoCY0p8+aGl6ZDNqOZiVAlHagq/gBahg/vA8YWC0APpt41bwGX8ULcf68VeD8CbyjToM1KQLpqOCuhGd+ha2qhty8ysbfFYp3OEMnSxZFSOXvzw0IOI8qGHa6KChMASlPwqUaYU81BTggtFew1vRg5yVIAMETZT0owgDUzbYdJhlEldCdRlFu/h+PIzUo0FmMIWfHAqiUYdkpPI77qKYlhn2Lbo74+TQZuQ9cnQ+plr/d0FvjQQCR9Yi5LVbLbQQhxokyjScac5h9MdzTxs7HpYoKK11S82m6zium7wsG3VyZFVY/weE2CazxrAlu6uhygwkXxJk7vdyEUB8KezTYSye4gP54F6ObP16dnGDyC2gmUzd2sjzOTODF+JpyriPSBk3mr8sm5lliAZ7foA+vpoqHCzQhohpq5fBEks+x+G1xVz52XE3PBr0GxjmgB0ejzfaoZOd7ZYYbDYnSbcqyKAYoKawq1k7OQPNKMlSIdYbLZYnlhdezuzxsNeJmWvPs4daPZcK0o8LVY0OaDQZgBXmBw4FItSv5ZnRi4sgU46p8edxMIqO0dfdyXvfBprAgop7mzXbazWEAZxkgCf5E4lKDt9DeODk5Y3ck0TAU072ezOlKmosU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(86362001)(83380400001)(186003)(70206006)(47076005)(26005)(82310400003)(36756003)(426003)(8676002)(8936002)(336012)(70586007)(316002)(81166007)(2616005)(5660300002)(4326008)(2906002)(7696005)(36860700001)(54906003)(110136005)(1076003)(508600001)(6666004)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 06:33:06.6264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b518be8-66dc-4c90-39c9-08d99aa5f7d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present 48MHz clk support is only enabled for RV architecture
using "is-rv" device property initialized from boot loader. This
limit 48MHz fixed clock gate support to RV platform unless we add
similar device property in boot loader for other architecture.

Add Kernel config option to enable 48MHz fixed clk gate registration
with clock framework. This enahanced flexibility to enable 48MHz fch
clock support on any platforms by simply enabling kernel config. Also
replace RV with FIXED as generic naming convention across platforms.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/clk/x86/Kconfig   |  5 +++++
 drivers/clk/x86/clk-fch.c | 22 +++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/x86/Kconfig b/drivers/clk/x86/Kconfig
index 69642e15fcc1..c10081774cd6 100644
--- a/drivers/clk/x86/Kconfig
+++ b/drivers/clk/x86/Kconfig
@@ -6,3 +6,8 @@ config CLK_LGM_CGU
 	help
 	  Clock Generation Unit(CGU) driver for Intel Lightning Mountain(LGM)
 	  network processor SoC.
+
+config CLK_FIXED_FCH
+	bool "AMD FCH controller fixed 48MHz CLK support"
+	help
+	  Enable this option for 48MHz fixed mclk support on AMD platforms.
diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 8f7c5142b0f0..72d2c7497234 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -26,9 +26,9 @@
 #define ST_CLK_GATE	3
 #define ST_MAX_CLKS	4
 
-#define RV_CLK_48M	0
-#define RV_CLK_GATE	1
-#define RV_MAX_CLKS	2
+#define CLK_48M_FIXED	0
+#define CLK_GATE_FIXED	1
+#define CLK_MAX_FIXED	2
 
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
@@ -41,7 +41,7 @@ static int fch_clk_probe(struct platform_device *pdev)
 	if (!fch_data || !fch_data->base)
 		return -EINVAL;
 
-	if (!fch_data->is_rv) {
+	if (!IS_ENABLED(CONFIG_CLK_FIXED_FCH)) {
 		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
 			NULL, 0, 48000000);
 		hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
@@ -61,14 +61,14 @@ static int fch_clk_probe(struct platform_device *pdev)
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
 
@@ -78,11 +78,11 @@ static int fch_clk_probe(struct platform_device *pdev)
 static int fch_clk_remove(struct platform_device *pdev)
 {
 	int i, clks;
-	struct fch_clk_data *fch_data;
-
-	fch_data = dev_get_platdata(&pdev->dev);
 
-	clks = fch_data->is_rv ? RV_MAX_CLKS : ST_MAX_CLKS;
+	if (IS_ENABLED(CONFIG_CLK_FIXED_FCH))
+		clks = CLK_MAX_FIXED;
+	else
+		clks = ST_MAX_CLKS;
 
 	for (i = 0; i < clks; i++)
 		clk_hw_unregister(hws[i]);
-- 
2.25.1

