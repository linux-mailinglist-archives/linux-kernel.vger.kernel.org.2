Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB145D8D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhKYLKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:10:52 -0500
Received: from mail-dm3nam07on2071.outbound.protection.outlook.com ([40.107.95.71]:19939
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231983AbhKYLJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:09:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJl9C4T2+XSHOjKQC8wib2SlKb0umLut1+b6q8EB+heG5t0KAby6CQuVCYnQwJRPA5fSZJ6vRrXJtFnLgKS5Gb+carSoEUREmKNUOozcbLhSGKdGoWWU9uu5m5zERFSDHQ4AuSfp4vkQtm4L/39uiGIlGxVMSZNcpuGURQ+3jKSqQ8cJJ/Incijbp9jF5p/FtL9Ull/ODXoMiGm5AnoAXMWAGMb5PHmTxNshOGmP87rUJ6HOO6r48xHPzdwBKJKF1+xXtpX8KWHRvCEUELP7+y51orRDVYR1H1QWKbas2XKY69/5Qn/7mGEdMHJLfoucT3j1dKGpMNbSuRFNkKlVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE55wLPjcsS7yaFq1RTMpX4ZA5NQYTX/Y1baD2ds2MA=;
 b=Bm7C7vQlYBFykDuOUhS1scmAQN6Ssd9HERLLERRZTsfg/qgo9gUOqGlOlg7n/gGFNWHWnSalLAPW+4n7gi9m6jnedZBZocrg/Jvo99LhkRr/IyFgeTvXN2M2LeOXdxxom7l60021hWFlYLhjpb2GhCiZb6AusP8LVKR6+4zotvIV7Dn5c/T9Z4V6uffjFDIIZtqZGtWAawD2P1YDngTTLqv0pWuwr7rfo76eZHtMC4a+2eE+plZJZXs5/iwhc5rXgorgBZv7BWWdWZgwZNeKUQgAlkvjBNeLKQBtl8O9tq8xYZCBWUR+RKlpc5P3qrb4z3CILrO1oWTmnNF5v8sZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE55wLPjcsS7yaFq1RTMpX4ZA5NQYTX/Y1baD2ds2MA=;
 b=NvODdCZvhJ4Fh0A9VJ8hufd+1JfaZNyh25EF/dciDU9FOauEqCFav9eHXeSEX++UGtJdXtcHL5q5TK17hCXPiE9Vznv/X3f5zYYllwSzAX6sF9gkTWNE/FRLUnOhBQ6/gYaVA6fNHD6pUgxpkqY3E6K2+V9tZggdCqkW/GQD77s=
Received: from DM3PR08CA0001.namprd08.prod.outlook.com (2603:10b6:0:52::11) by
 BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 11:06:14 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::6d) by DM3PR08CA0001.outlook.office365.com
 (2603:10b6:0:52::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 11:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 11:06:14 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 05:06:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 03:06:13 -0800
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 05:06:10 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/7] clk: x86: Fix clk_gate_flags for RV_CLK_GATE
Date:   Thu, 25 Nov 2021 16:34:45 +0530
Message-ID: <20211125110447.1188073-6-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
References: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07113cb2-550d-44bb-85db-08d9b00398e6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5158EC18031264049ED0B91582629@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OPNLoKo4scYMBE0dXAsYO/msfBWKgA+gOh+0GcMi5HHITEd2vClZUv7RAnMN4e2q0ChNZddsS8tV6sffpWX38iR5WNPP3ukb8PYaKUpFXAQMHehwduXhbURORb6nswhLajFSTH+1nwMaPMkqCzB4xn9k/H2k6/2Yf9CgmzzsBglZ1X7yeK/sy4IS6wL4aelBwpvHOkNHbjw7AtYBtXJmPpUNygdsj1bkgdcRo0gKd3AxVcD26o0/G+x4HkDzaoouj+35rH5+2SYxmlIQhUN5UOEnkAoMAhtwG1FzxEApN8YMdhUX+Pw/CVtN2hmWU90E4Un8tc6MlwqxY05Mo3Huu78u08kZq7gx0bB7f1pQUFULOVHk+HNE3C3gdngtSPigl8GpWj5IsqzPQd5CO5Wr4s04HUX6Tcz0TwhjEKe0HhjZaBa0jKKaf+dYr8eMP+nmMNrTCceALAKkEfJ+p+YuQnYJjCL/WcFoovTFD5+YoIdjHLF06zdsChSJTI2E8IN/6VRxvQed5ZTQ/dLa3cqeoG3LbI5K52Ht2RbYuvAwo8FkASDJ267IOImUW8FjdILd2f97lFPvXhUjAVA8C73CyX89H4CAQC5eyP6au52kfZwNlbxkcHSw6vUMcX/eAurNrjz93C2kUhpV+GnqAPSl0Z1HiHnUcsie3dFNB7VpyNR76MFcxDuOI905cndEAwjMRmCLrsPo6Qcd+1u0O5BYO4oGtlWVdXoqg5wHFsRwEI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(316002)(4744005)(36860700001)(70206006)(5660300002)(36756003)(336012)(8936002)(186003)(1076003)(54906003)(86362001)(4326008)(8676002)(6666004)(26005)(82310400004)(356005)(47076005)(426003)(508600001)(83380400001)(81166007)(70586007)(7696005)(110136005)(2906002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 11:06:14.5221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07113cb2-550d-44bb-85db-08d9b00398e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newer SoC we have to clear bit for disabling 48MHz oscillator
clock gate. Remove CLK_GATE_SET_TO_DISABLE flag for proper enable
and disable of 48MHz clock.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/clk/x86/clk-fch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 7c55e129779a..484fbb158e5b 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -82,7 +82,7 @@ static int fch_clk_probe(struct platform_device *pdev)
 
 		hws[CLK_GATE_FIXED] = clk_hw_register_gate(NULL, "oscout1",
 			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
-			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
+			OSCCLKENB, 0, NULL);
 
 		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
 					    fch_data->name, NULL);
-- 
2.25.1

