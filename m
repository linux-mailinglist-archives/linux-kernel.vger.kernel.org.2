Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A322C4285FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 06:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhJKErx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 00:47:53 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:29984
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230102AbhJKErv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 00:47:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ney3m4+Voxw7ufQ5aopK9bCbgZ+aqfPL6NTlUI8YBuGwJw3gClBzrSV3ucWtoReVzbONcZLuNq0bjkYLuBcdeCPADQfaKId1NiG8kIa698nNQRhnjlHPKdSzpwTsLHJ6ipObDDhmXZclXdPiIPgVNwzntwB6MnJ4hIJrpC3SWsboYXQJRwVn0uSTMPeN6e2oNQMeT+KvPlMkZywxvvFpwYD9cM6w+xtiZ0MTq4Wx65yluEFogLxCTzptQoe3MND/Uz+7ezqpIluGAnS4sOTHwzFRZ9moDah/oPRHqTrfThhw8aC2mFEGGUqcOO/bZHa4Qk8Gkdo9m2DKVQhqTuOd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zovr1uuHB6TQecvEqFEDyfxn4IfECvyIahJ68V+kASk=;
 b=IvHvcTwEOmXWngx1e4Z41W3qnWUI4GznMfMSHzk7w+hkqOb8SFv5Fmqe+u5CSZVY0t+aGR5tF6Pc4I9kEw0veJcEcwI/0tXQwsp4sTLne2wpEBPflHSvbRYbslIiw4qm7s4sbo+rB8GntO7kOlFQKLje086Epty4uIhr3sVeVrY52PJTVfWsOIFbdaTaqsABbkLMayPWj0CbJWo5aQeVOr44XkiQ5xnrtS97356Mov1OoFghoMcdoVf0pcgLn9ZxJs4O9h7h3+LWJLngWBrPsV/T4oT8d4T84SS49YCDP/4uEQICcc+ZiMZTog/XOfuk0uIMzloeUm9Zkh+fg8txuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=codeaurora.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zovr1uuHB6TQecvEqFEDyfxn4IfECvyIahJ68V+kASk=;
 b=SRWSnhzKhlASH47tqvNe8QuWDMvDBOEP/2JI9mULr2DRzAIu3mJKxHBgMMyIOge488bpV4PulKxlzKYliQyeIJ2aHDmKYc4tzRo35x8sOIt3VQ8jFrI0UkDr+m18RMCT5sTQzME0xiinGRSqB2AtRNVvP+Wg0A+1yfMtRxRpUjQ=
Received: from BN6PR14CA0002.namprd14.prod.outlook.com (2603:10b6:404:79::12)
 by DM6PR12MB3883.namprd12.prod.outlook.com (2603:10b6:5:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 04:45:47 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::46) by BN6PR14CA0002.outlook.office365.com
 (2603:10b6:404:79::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend
 Transport; Mon, 11 Oct 2021 04:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 04:45:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 23:45:46 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Sun, 10 Oct 2021 23:45:42 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@codeaurora.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] x86: clk: Add config option to enable 48MHz fixed fch clk
Date:   Mon, 11 Oct 2021 10:15:22 +0530
Message-ID: <20211011044528.66109-1-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97c5cf35-7cf1-48cb-f763-08d98c71fdc5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3883:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38830C320685CF8D97FE257782B59@DM6PR12MB3883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDWaGe7NtS74VP957AEm/pfdzJIhv7buimISqyQk+QZsMQPyiD7vDcQH4oePtOUhfOcvRro73RmeH2l3y5fqHs2W3UPjgxJBDAXOB/HkCCvGZ3dYQOtpLvF1SqXQE68VIYYMP1eKmJNM0U6uJnAE8FgdhsVnVUtzay8tZIkIvOn7f1p8pI/FjCCav07c+KHxe/iQ/FbW8FT+z9NqqqR33Bb8DaAh9gs1bffpexAOw1W4H1QEtGRJLnJN+24gCJv20hdJ/ZQyZdXq6eR2UbTPe9DM1A0y3EXY+RNaRFdSCD5LO+AY8n7U2cHJeiGyw8LqZqSdv4X6SY1tLIKv5re5MXtLS9gx5Wn7y8kvv1LSsxVG5JrAwgW60zaWouxVd1UshPbESJ2Gxtp+1a9AF1N4yLWE8lZvNx0ZnT4L5foM7bc42fcWCrwH+odmIVnRcGYIvey5fwN9cCCRbJRYC9tUnrF7eLFxpUQgiprwtvKvbWutdTOihUsqyIru3fgPfH6K3l58mTSBxG1E5O2U4AGZQqXiz52se+occruKhYao7Tua8TNTswOXIaAQ+ra/O8lT6ue70dvF4OcQ5sKlIEWQB6tEXNTnkOziQGDyupi0/ReUvV8lADcErEpC3zhCsyo2F/SUdlfSs2PDOFJAaCvAegj34/0GdNq5zKWzdLjshNiCb+iE1CB2xf+G6GUdtnbAU3iBVyvQ7P2cPdw6C5yA2XTLjeemii82JbOzLd+0zZM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(83380400001)(36860700001)(54906003)(110136005)(8936002)(2906002)(316002)(82310400003)(8676002)(70586007)(70206006)(86362001)(186003)(426003)(6666004)(2616005)(1076003)(508600001)(5660300002)(26005)(4326008)(47076005)(7696005)(336012)(36756003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 04:45:46.6008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c5cf35-7cf1-48cb-f763-08d98c71fdc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3883
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
 drivers/clk/x86/clk-fch.c | 19 +++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

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
index 8f7c5142b0f0..a95c3ffa79da 100644
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
 
@@ -82,7 +82,10 @@ static int fch_clk_remove(struct platform_device *pdev)
 
 	fch_data = dev_get_platdata(&pdev->dev);
 
-	clks = fch_data->is_rv ? RV_MAX_CLKS : ST_MAX_CLKS;
+	clks = ST_MAX_CLKS;
+
+	if (IS_ENABLED(CONFIG_CLK_FIXED_FCH))
+		clks = CLK_MAX_FIXED;
 
 	for (i = 0; i < clks; i++)
 		clk_hw_unregister(hws[i]);
-- 
2.25.1

