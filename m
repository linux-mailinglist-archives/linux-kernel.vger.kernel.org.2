Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC82F42A250
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhJLKjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:39:13 -0400
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:35425
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236056AbhJLKjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:39:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSczLJUgSnQ6HjFy/XzfNZid+5AbKBhSdrrngrcxiDLe0CK9pUPIMiPlS6aq1hwNfmNedlCM2JUOesVRgYgKqc/RM3k7PpO21cXPHLOOsfjQCz16qgv13aYNeARIEK5PmT9xCGH2O8NVzRSlMDT0BjY0ZxVUTFSE21OJrKnhipIlD14W/1bprSx4xuHssyp+aRK4+KVq0mZRPNn4jYnn5NEch/6AkwT0rkDl81SykZvTuHnNJLJeChi9vaKBtSsSq/HJW0mFhhbHOX6gscXp2Dyn06lRAeqe4S/UUp638lfZ1Dgb/jNGysgCa6RheS2ZFzqY2vgBOuYfI1cvzRx8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPMxurB2NI5SzJfr0gq8/11S3hLEoYL20o8ByRd5AU8=;
 b=AtTmvvMwwxUqaHGgvdTfXtyBPkWXrGWIuWTvkHvl/f4I19pJ8Y1fwJgp3R1+Hi/hk3af9Msasn/exQbt1VJ3NqtsbB+ADp8kEHRl9ECog84CphEpL7AYmsfwQqF+s5qzZ+joiG9ba0q5T4jqUIoyPfoPbZxVoTA7VlfwA2ybZZ311q4F3mGvdAUjznoBgQ/Vdv476RqqzKBmUSkUCzZRxzxaM4ekPDBPV2JS6EHgk5CJhoAP1EuACN0N4+qnnGW+29loEIXtQRSpwMX4TWQBtvzAG7uVr+BtwfHFnwGlRst7wIkkZLFK/RrE36nvYk2yhzNJQo21HAU0WmBsBCK81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPMxurB2NI5SzJfr0gq8/11S3hLEoYL20o8ByRd5AU8=;
 b=G7nWVyH/BRt1f1lqSQUGyAdFB0/w0/NPnYuA97yliGX2RznMhcByTF72nBUZat1wT0FcWj0sHdi6XPzs9ulFWhY1de+ERPjEeJ93RMvsOSu9Ddlil9pKCe1sLfbOCzjNgYz3PUnZu8QWoRaYRov15NfPPkx2zzzW33BCy5kzs8o=
Received: from DM5PR15CA0063.namprd15.prod.outlook.com (2603:10b6:3:ae::25) by
 BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Tue, 12 Oct
 2021 10:37:06 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::2c) by DM5PR15CA0063.outlook.office365.com
 (2603:10b6:3:ae::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Tue, 12 Oct 2021 10:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 10:37:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 05:37:05 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 12 Oct 2021 05:37:02 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] clk: x86: Fix clk_gate_flags for RV_CLK_GATE
Date:   Tue, 12 Oct 2021 16:06:12 +0530
Message-ID: <20211012103612.101859-6-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012103612.101859-1-AjitKumar.Pandey@amd.com>
References: <20211012103612.101859-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78de4af4-43d9-4221-5191-08d98d6c3cb9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4965:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4965BCFA2EEA916ECD95BA2B82B69@BY5PR12MB4965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /A66F+tYcwsoJ1pnMaPnyeOOa/Nl5FhYr5Wbe2+9tL+KNRavHcK1eL+T0r41kYFZhmW0QQmd7bSqDrd/XUL5vyqOo5IJQizC/i4+6pTYs5U7Sk+wpsuvfQNgfm+2TVg0r271dGStBt3hD0JFUWVKc1HfAVl4RruPtnY30t1S+AXnHshDk43+9Uo6Qnlgww3Fm7HcyBo3X+Slsgf6BMKJBMRSfUOb2JRpjbMdMlV5j4w+fS8VPeyBg002AJuXSlpGnqe64cKWypDr+7ul7iH3g0rXEoeIbu62JPSceYCcIEVowR2L0Grn02yVS0pr0m/1buzmwUZM9Ct9Fu109nKftdEIVxENIC8ldbPxAEUwBbXCwDCMLd9AszMxbQFhAWk72qnh2a0L0LsHcLBy/jyiiTcece7Duaa1wO/GPv+CqnxbgLum42r0NJY2D7i1eL6TbysRtF3l3Qg+mr/MCeZfXgozhhl3hjdO0qLOQlmJjoQvR36Zf0TvvcIaG+HpNhDaviLuUi4uDTiVGPXWCdcdxS6EdlxmjTIXdOg8IvLxGdZPhxafLoMbIEjnVJvfIp68GhoelgDvWANEUF5qdC8PpvTpjP0Rg66/LxTUr+eYZXinVJ2Bru9qVBsuvEifdkPOw3chTVdkV/WB1Ab7nd889G9/0+rbvPacmeo3Y54OI75ccmtPj3gEDt9WbyszsmUXRbnJClgu083B4jB/on5x/VxN43akUzcbcpwY4uBTnaM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(2616005)(83380400001)(36860700001)(186003)(8676002)(1076003)(7696005)(8936002)(26005)(86362001)(82310400003)(6666004)(4744005)(426003)(36756003)(5660300002)(336012)(508600001)(110136005)(54906003)(70586007)(70206006)(81166007)(356005)(4326008)(316002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 10:37:06.3588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78de4af4-43d9-4221-5191-08d98d6c3cb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In AMD's SoC we have to clear bit for disabling 48MHz oscillator
clock gate. Remove CLK_GATE_SET_TO_DISABLE flag for proper enable
and disable of 48MHz clock.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/clk/x86/clk-fch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 19a5c8cf1b3f..517061fc771c 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -66,7 +66,7 @@ static int fch_clk_probe(struct platform_device *pdev)
 
 		hws[CLK_GATE_FIXED] = clk_hw_register_gate(NULL, "oscout1",
 			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
-			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
+			OSCCLKENB, 0, NULL);
 
 		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
 					    fch_data->name, NULL);
-- 
2.25.1

