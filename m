Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9929E42A243
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhJLKic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:38:32 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:43328
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236011AbhJLKi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:38:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CucZQiWMwubPiEqcebCHqxMNKz/fWYu55VsWsLzqsb9zXei/ZD0fMfp1SFwp854yWVmBPoU9BrzX5phfOB3A9SMGt9xzI4+fqYCfoTmvZSqzUHnv/7lZsf8rn2eAiBBCHEwzViBiAq0yil9OThXzGbIc2zEGGNbf74yteooRUwNN/hXycQUveq3DSumlFbywXXM1ockSV7+m9kaQR39PJ3Jujj1nxWjLzMAqzTBKfq0XIXPGS9kAGkRiavQmqr2TU3s55+Nqw/TAzA7PIh+WBl7lW6pfqt892AgxOMVeiTROM4ekHBCz4enaHXzjmvXrirvHTqngT4/KMu7B/VEvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/1QIBhBeFeUz3assXx4YNB3UJFrb4LzlVOEAMnc1fU=;
 b=b+zKmtmktainxltYuqoa0KoLmAgS0/VN060DDacLmYD4nGhIl0S4+fi0479wIDXhd2oWB4UfbDWsVNA4yHii3Eq2vAnAZa70wOdMKLshbqG/9rK+ruNAL6dqNZ8A6ggPg6CGjAYNGKZVsDmlHwxF2lnte9VPW59I7MlvweEtVC7NpDYzC0RoSJN86+ARr9zd59V/LbcBJbkL8xuGsymIj5nKQK4pME9EQJmB2iGTLA1vIFfqyHk/2rIpQ8SSOdZiJscF303owPEPol16I1DjvaKAGvGVQFrTUY0x+kUiz+6rOiW6ONQZ//NC/OPfGQgpw6CMl3zVPHHs07TbY9FsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/1QIBhBeFeUz3assXx4YNB3UJFrb4LzlVOEAMnc1fU=;
 b=K//Yr++XCP+f14++yt8nEFiR+dU714FPRBCHPVS27XeHEu3rwYe+421Ym7OcP1RKmNV8Df8APy1SyTa8/++sFa1WiKj+fPiOPr6yj/R2APa5vtOVZCsHuUCaoJdeAp3LiMXYOpdaQs9N5sl5L3zmLuIMPTHSqoncXNAG7OS/aw8=
Received: from DM5PR1101CA0018.namprd11.prod.outlook.com (2603:10b6:4:4c::28)
 by MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Tue, 12 Oct
 2021 10:36:24 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::69) by DM5PR1101CA0018.outlook.office365.com
 (2603:10b6:4:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend
 Transport; Tue, 12 Oct 2021 10:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 10:36:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 05:36:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 03:36:22 -0700
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 12 Oct 2021 05:36:19 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] x86: clk: Add config option to enable 48MHz fixed fch clk
Date:   Tue, 12 Oct 2021 16:06:08 +0530
Message-ID: <20211012103612.101859-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012103612.101859-1-AjitKumar.Pandey@amd.com>
References: <20211012103612.101859-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6a0027-7bcd-4095-5bcf-08d98d6c2370
X-MS-TrafficTypeDiagnostic: MWHPR12MB1264:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1264AC3108E89B2CC1F9AA1082B69@MWHPR12MB1264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ADAZmsB3cttnoOFnLrX1+e9SBrubZ7S4eo4K/yStuSsNXpz7buiH0BPN1cXZhtS3IDt91BIli5bHfK+taZN82HbbWWKs9P4wn2K0S+/ZwK4k9yI6NoMYys80PLuEGon9/WlxNPXRKcERY4DOiqR0Wlwp8zlYXlLw+eH4r3CMJIWpGUKoHESutxm3wbxkdR2zF5QlXpu3vacxogLiam6O5A2NjXbm02wUvhESEV8vhgs5O/f/Qwwu4bLvlLzpW94/ZrL70vJOPyAyIs9wjpeCaR9YyqEp2NjFpFVwRxMlVcX041eTF7iaPKf9TBZ81IvnRnELW8PRM8PXRzmWz7A2zy3ePCAZvH0Cf8KxapnfLo96aCfWFg23NKu+Wf6WausnMQZRQ5/3sbYrXO2iwIWZ6gb2bRIORuDWNPVSWg2uAwIu8MSKN/u4VzF43WpWAhBjyQ63gm+fVWVLaU2FS/OYHlZHhmjGUhi3zqP1zdf+9LoxbWNwQkFG4kTuAB6n12LuFT+/b2shtoFWJjPrcw5mO73j5CNEj64UZzUujqG1G9vSdmXtTlTnKuBc0pTM0flYf/M1OFS7gTyJ+7pmpXHzSR+WnCDd1jk7xGrGJdTgFugq4pptYvDHH6Tfw8xdmVmNs4zTNj+W6drKqeI2dc92fkJOh79CvA1OJKN28T+XjTHBoq3MaMwN3YmMmzZZ+pRWQSeyS5zCEW7BM0xK5bFshpipOeruiKL2BRTWBGQG4w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(356005)(2906002)(70586007)(26005)(7696005)(2616005)(36756003)(70206006)(8936002)(4326008)(54906003)(47076005)(1076003)(6666004)(81166007)(8676002)(186003)(336012)(83380400001)(82310400003)(86362001)(508600001)(426003)(36860700001)(5660300002)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 10:36:23.9416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6a0027-7bcd-4095-5bcf-08d98d6c2370
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1264
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

