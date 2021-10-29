Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8867543F73E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhJ2GgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:36:22 -0400
Received: from mail-co1nam11on2067.outbound.protection.outlook.com ([40.107.220.67]:38272
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232098AbhJ2GgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:36:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNCDFjJozMy/owMshczNCoPUjqDIy9jtHu4PYrmCCaFJ8XRrvfgg7U0l1QIsQZVw6GOl8OT00cBw5wa+8TZueYuVcYJk9eLeNb4mXsJgtsi8PGBjAYfKBZuvdX9iVg1ml8parIOS42d8AfwgkY4jMY1w4DcpN9CJnG8EU8V3wJ8lPxS+1uH64bDUMQWNJ7+lW3TFKt1hhqp9eKRSkSHKgsUVDUWR4PBbUni3yH8a4/5O+4VFfIqb7m78/FwsqIW37ymYc1s59iu1KBx/JLFDZwqpBmDRi9hWUh0No8tTRJUM0MDAWSYXnSskXDy7f0SWYYb12K6g1XAryuOMpCP4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPMxurB2NI5SzJfr0gq8/11S3hLEoYL20o8ByRd5AU8=;
 b=S0uRBaahqzN89ntMinBkTcXxRWjyFrhnF7ZVzfAvu6mBEuHhwt6pRIYmZndC/wVBVBPIGXCeowl9Li8zEONVURbr99/1/uEXk/bj2zKgJh5tyYBaULOE6OHPf3Xj+ufPNoACobbPym0kkRoHZSmMDKs4fZm+zkUKfqZ7/vIjworaiA2zDVSm95ZPiNJOxcUn1/cFyr6qbNmzuIR18YkVFkMSYEer31QkhvjzhqBYamWBTY2nUxM3B6E99GzaGj6OGXNPbFGLK+p2dK/vQjrbRhT4o/9Ao9O22MrdGPzVq5ENbPLNGGymBGn96o0AjrtBOszwaVBYWThOs+5MTqr8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPMxurB2NI5SzJfr0gq8/11S3hLEoYL20o8ByRd5AU8=;
 b=QU0sg/vPD6KR9+l/hGHDNNzyf8XwbmivBqnWWpEaH+ZxE0PrgjZgg8ulz5Sd+OvxpB3lFhb5uLjd6+jPKDjoeANOeNhWLs+Y0TVHcGdwbKa3601VB892Pw1C8aF67bAjLJPThAbcWGLUfMSczqGlWYrsq0RQLs3RD/QezeDukCU=
Received: from BN9PR03CA0857.namprd03.prod.outlook.com (2603:10b6:408:13d::22)
 by DM6PR12MB4531.namprd12.prod.outlook.com (2603:10b6:5:2a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 06:33:39 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::bd) by BN9PR03CA0857.outlook.office365.com
 (2603:10b6:408:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 06:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 06:33:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 01:33:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 23:33:38 -0700
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 01:33:35 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 RESEND 5/5] clk: x86: Fix clk_gate_flags for RV_CLK_GATE
Date:   Fri, 29 Oct 2021 12:02:28 +0530
Message-ID: <20211029063228.578909-6-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
References: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d057c0f-e5a1-46a9-fcb8-08d99aa60aff
X-MS-TrafficTypeDiagnostic: DM6PR12MB4531:
X-Microsoft-Antispam-PRVS: <DM6PR12MB453161C225B3EFB1E3354D7E82879@DM6PR12MB4531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xMn05P9IAa+guW1/lC9qJkyN/2O8uquDYjddJrLmAvCyac37LzbP1bouYtVcQVYvUEPGg6L5byGItqWpP22lJoEsRbHTr7TABg0Z0KgXDdF0iiAG9rIeYWu0LEgQXYjS4r3OHdEEgoviAEnfCyt/Mv7/9uJwwMR07TA03cE0mMcAB37mSG9LtU8OmcSm1VjYUeHxCesVfiPwk0Z3AMAzxMGFJ5aXdJgg8Uh9DB77ZFGkDk10YxY0A5tQ08kQDedsJhTWVQtT12g0+X0VEgSFqX7oXXIz2+JNLuVf4yUVb7MW5JA8TeMtqW/Wj1zC/3SgoSg7Xi67Sk+S6u7zU313yejee3V89gtKGgcySwZlklVPdY219pWpWpvpKzE4kMfC3egZeuY2JfNczDzdW/p50U7RcLqktKF6LYqi6b7fOz2iKK/1EYqOivp/qr/U5GKWxMjF1xNvqKNbx+nnSit+bQUAjziQQuqiPUGRlR3vIoEO3j8AUERSitoDeDmZGJMkuuf7pUERTSixVCgLCtUm/zA3mya6sn28DW0G/Zx0G92RTAQ0OtClsV8JSPuSmZt0nevvd7DfU9r20slQAI39sAb+wnnw5zgJ1twtG4wNhV/F9ftGY+gsHg7L1ZSOzMLRuHpflPgrcVPOE/eEBL5MSBKpDiMv83uDoovftmhwK4D/WDEtYQVevajiJBHwnrNjImrQcBFWVEYoa+HKdDdM6RriqRfpBc4Ciwk8GLmLZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4744005)(81166007)(4326008)(336012)(186003)(110136005)(356005)(54906003)(86362001)(316002)(36860700001)(8936002)(2906002)(47076005)(2616005)(426003)(1076003)(70206006)(26005)(83380400001)(508600001)(7696005)(70586007)(5660300002)(6666004)(36756003)(82310400003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 06:33:38.8963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d057c0f-e5a1-46a9-fcb8-08d99aa60aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4531
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

