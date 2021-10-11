Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B886428609
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 06:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhJKEs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 00:48:27 -0400
Received: from mail-bn1nam07on2066.outbound.protection.outlook.com ([40.107.212.66]:23998
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230102AbhJKEsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 00:48:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZcxBpEsf3XsHLowibp1nJ30pt1pzt3v2QLW/aUKzjGXQLkmowUDwoK2e+7hULkb6oj+SwFUuGAoNt48dPEn5wKxlWkPheoG1yq4s/g+tGrl6nBQ8I+jd3UXSCMyRnI8aQjigIVsHPCiOFc9HrQPKBDvo6u3TVwniqjQORUP9iT8RkRY6/RtfgP2mr3SKGUpGuxFvN2rgZ2RDX6A+u6nGuAMWPR/G9olosHNr+Vy1iSNhNwihSuQAW1hLfT29RRqbZAruy8gTtybYJW79RosQC1bmV3T8gnjUGVOsZYsE0AEIjef1HW1jHKh6q1Ivu50GU08ux4YGlDlYb87BczyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L1pmAgtOiwYt4mfZvxxfYcr2JJy/ZJB5p7onacXzD8=;
 b=m/y9j/txBQWzJAAvcqgm+SPz7ZMWGwc1dLDPJRYCyUsW/RNI7YMZ3HX/+k8Q7wCHf7ATjkQXNhfMuspUPF2UrHyQin6QDmFsGNfqOnuqoXRbBKhhbs+Nf15O11tAjtLm8MIXvlDoCsgHfge8LNlueo4EQulZP02+0JRRKiAc9qfp30UgRV0WH/fFl5kKlhH2DfuA/LMJas2Du3T6fS6SJ5yaXIEMdhvBuKtCbqbkgZyw9tsBRkbuqg5cH55bVtvhq+5LrHNUMO0ki/bR2xqhgIDUgdlgp8jEv8uoVffw4eOxsHO+d7G8WIB3tCBzVPsW4MW7xzctX5o5Yg52WFGheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=codeaurora.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L1pmAgtOiwYt4mfZvxxfYcr2JJy/ZJB5p7onacXzD8=;
 b=q3SCDLkg8Ro+HHBqIVHEmhH5VUz+ueiDGX03nz7ZvhNdDRf5kgnaVvKpYGmf97QuXLCkt5/AtaXvC+iwdpenuWpCbizRbwPHjsPgVec/GsXQ5FuDb3cNtFlVuAvkWpYhMNQZu4EAaxcubDFFARQR0CKvPOBU++wqu2M8TuB4wjM=
Received: from BN9P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::22)
 by CH2PR12MB3703.namprd12.prod.outlook.com (2603:10b6:610:2d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 04:46:22 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::8) by BN9P223CA0017.outlook.office365.com
 (2603:10b6:408:10b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Mon, 11 Oct 2021 04:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 04:46:22 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 23:46:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 21:46:21 -0700
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Sun, 10 Oct 2021 23:46:18 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@codeaurora.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] clk: x86: Fix clk_gate_flags for RV_CLK_GATE
Date:   Mon, 11 Oct 2021 10:15:26 +0530
Message-ID: <20211011044528.66109-5-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011044528.66109-1-AjitKumar.Pandey@amd.com>
References: <20211011044528.66109-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e01336e0-b19f-4fa0-a742-08d98c721307
X-MS-TrafficTypeDiagnostic: CH2PR12MB3703:
X-Microsoft-Antispam-PRVS: <CH2PR12MB370307ED8D304A4FBAF7557782B59@CH2PR12MB3703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+Rtfzq69HBDYuI0zQC32UMB0I4W7ni2ZFDxAlb1aCV0SOcfx3ep6x9CgaezPJu6oFCMjV5CMPZmcOvGi7ax73H8RnAC5t0ynK7PB2xQ8oRhzzIvhsVMvHBLlHmPf0wFHZxbXH4MCjBdTfrX+sVOUzBF1ku8CTgeIKJAoogaSal0SQM4DHuwUCi8QUU96JOMPhEb2fP8r78TSCgzJvV4303jKu1+0vnvooBXcuzt7NaOdeZ7872Gzkmyiy2axfjA2TrxeiUIUPH+3QTWlv0B8JRW6jqwnhRHgXVyrw9oxA897Tz2g4Extgt+DEsFEEC9QW3YIeCnmK8DIGQUFD5qFykwXafLzSIgarJ6q0IlbK0yRuNOaW5OYXHpcpDuieT/P4voMs5NgP+0jeYKkTI2bq4nxVeuBfg2WDhF8N7l3PBGZxhRJkIXVDjib501HpIT1HrcaevrtbsSN8JrIuOAF+3nUudyh5VdnU+Z9x3rkXWsgHWj6jVGAIoYC08m4y5juZ8VKnjODNXXz5LwOgpZ7FiQw1RjCbxvGTppvZVw3eId9CLzDmUH5M5349mEXLP3vdl7426Q/8ZRgivSsXjKrHZp1fW14R+FAB6MrRaGygz0i9SR3FKkcZ1ykZ7BX41FiMhVNfcau9XiQ9z473QbY199ZlGwh11yAoAAdOun6lqq/vCoDkGCUAYiIDfxldDnbJCk3HHfJo+1eunOv3w//EB/AUclUa2dH3hU4H9i7Lw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(356005)(47076005)(1076003)(2616005)(6666004)(83380400001)(86362001)(336012)(316002)(110136005)(5660300002)(4326008)(54906003)(81166007)(70206006)(508600001)(8936002)(8676002)(36756003)(7696005)(4744005)(186003)(26005)(2906002)(36860700001)(426003)(82310400003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 04:46:22.2615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e01336e0-b19f-4fa0-a742-08d98c721307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3703
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
index 9fcf452e28d6..7279f592012e 100644
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

