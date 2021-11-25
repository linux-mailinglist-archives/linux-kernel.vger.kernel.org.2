Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347DE45D4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348275AbhKYG1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:27:16 -0500
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:9697
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347364AbhKYGZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:25:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvUqbvRndd1FWnn0R1EIO6tKN2ZIYVryHpTjXQIRz1nkqY8WLRuKRVkaT6sxi+i5tvwcB2kiqs8+AkSYzoyu5JGIvF+gn2Yqd3htE4u5ck7/wZuKRTKJ6aqrqYKRTzDPuia6nM8b45mz1IHcCITNfsKjzlyB6bLHw1gGhkvmXXF/lJmUgakY9ewUtCcnZDfLKDk1MTDPth9U0yo+L14Sk4JJLQsuPkHMua/NBmuLOI+PwRYmCvj8ydaUFH1p35QyfK5IbRK7L9ypdCUe18qWfkDF6z7cA7MC7VoEJhedfZX+AC2LJ+F5UoFFCIw+L1aVk9MJfE14vixTrRtF3H6N6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/+GybTVL4O6JHThG3flxM88YhmghZZF/FJncu089fI=;
 b=Ns0jlWOmTX7VN1fXgo5HfSCtvMWkyRfT6Uk4Im+ZzqZU9HySdvdN5TvjXJAmNdDfyxmrIDNDkuC+v1d8xR9Cs4qVsbPLjiNdCfp9kEgG+MTpww8/Un9c1AtbJ7Hf0kXpwxDdsRE3grWcD5Gi8MQkithzC09Qj7VmgX4t4IpCVCIAQYB6cY71ijxf9l5ZRhAaE8EKQq2KFTU8RGQ88Mhp8FpyaYDic77IlH7xb+lkl20ajvbinrKnLaOOC7UANT/3S7OUscrdsjQ3MSu6h8570O5G/PD0JX3plrZqpZxIByGujuImZ7vFgFaAIbP1Lf3c685ZxrLoNyqpeWXbqBjrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/+GybTVL4O6JHThG3flxM88YhmghZZF/FJncu089fI=;
 b=Yxp63UpeUcURpUkENORw31F7/MW95oiv1SYP+nJ1Z798rqLKoVMJrDvmU/lD/6iRLYCHeBinUagKeluqB48a2PUVGHtq9LyIvFE6sfkxYh2h3SGcFlt8yqbaGGZyHtNDmoxixy+RQGjxi5nzkzFbMLFIvVzCdyBceuP/U6/EZag=
Received: from DM5PR18CA0060.namprd18.prod.outlook.com (2603:10b6:3:22::22) by
 CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 06:22:01 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::79) by DM5PR18CA0060.outlook.office365.com
 (2603:10b6:3:22::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend
 Transport; Thu, 25 Nov 2021 06:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 06:22:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:22:01 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:22:00 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 00:21:57 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/7] clk: x86: Use dynamic con_id string during clk registration
Date:   Thu, 25 Nov 2021 11:50:33 +0530
Message-ID: <20211125062036.1185994-5-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
References: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60198354-f91f-476a-8887-08d9afdbe48e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0119:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB011968DD67638FB3A8E49CF582629@CY4PR1201MB0119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AS+WgJlJBcdKu3og9tjRyhdEyVeWDjYIX3rdx14KgCWwh6CShmjHb/hheYdOL5Ky6E7ihrlD/O30GY033aXPgZ56Mz+UAshhOM6EHRzdOkyb635bnKqVTxWEWYpJ6atHox2rR8yPI2WFh/+uukUlzR1qULAYG6wxd0vhs4ph4+e5DnTpbd5jh/AR+UlUT+OydRwMOVljGvtY3AlxGPt4iXnQwQ9rVk8nFsCI7TzoWWQHjfceHWwjdiQgcpSDTBMSGUwboEF8rBV8fahR0+V5UqidolFXbA6jauJB7/3KnShczdCAkrdc+dRMBdV2t4hWJQJi5nPNN2Okve4DodJTnfHUeU/j6M6RzF060cq9OIkpkwSfxn+o9WzmHdLLKAxkmCJuwj8XSUhOEE8ZDeQLkpG8xNZwR9B68ZviPOgcNJRSe8PUIz/IZ4WVf4wDoAVX5zteyyw0UlfhQz2lsz4VHcNd2FMdG3C7DXk+0b+HoKFxLO9Px8p9ammJWrUcrkfdviNJZmSFHfyant0n30cmYZ6xhZmyfCw72pd3T+6qumsQwIDTNVCNh2RZX2dvMxYhv6SEBx1lWtYhoLuR1REaYAgQ40T4xf/GC0AWXMYDM+BYcg3xiwGFp85U51PBgSHGR7aLTubIPmYIl4JQ5GIzoQnrKD3qoI5czPJ3YrezVGE0nGCpvrVRC7r+yGRa5FRbsvnDcOt8mE/hc3+t73vHN/i/Zp/wsA7yG4uUGSTpKGc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(2616005)(426003)(36756003)(8936002)(4744005)(86362001)(26005)(83380400001)(7696005)(54906003)(110136005)(4326008)(8676002)(6666004)(5660300002)(81166007)(82310400004)(1076003)(316002)(356005)(336012)(186003)(47076005)(508600001)(70586007)(70206006)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 06:22:01.6141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60198354-f91f-476a-8887-08d9afdbe48e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hard coded con_id string with fch_data->name. We have clk
consumers looking up with different clock names, hence use dynamic
con_id string during clk lookup registration. fch_data->name will
be initialized in acpi driver based on fmw property value.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/clk/x86/clk-fch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index df59fa8ac0a4..4ff2e1b3b3e9 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -85,7 +85,7 @@ static int fch_clk_probe(struct platform_device *pdev)
 			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
 		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
-			"oscout1", NULL);
+					    fch_data->name, NULL);
 	}
 
 	return 0;
-- 
2.25.1

