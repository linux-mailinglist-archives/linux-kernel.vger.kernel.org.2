Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A12E428607
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 06:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhJKEsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 00:48:18 -0400
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com ([40.107.244.41]:64225
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230102AbhJKEsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 00:48:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jro25EwuAeyxPkwYjGuQqYxynkjrkt+Rd8bWGqdzRbQG9W6x9S9JGqMS5y8dmO9NLsCfbOfS+wwQRR/kgDItM+qTfIOtZTrqPMwVQpaTv6HaTU7djRVpz9QhH5C+dYlpaZxRQHfpnWv+pqbwMCAjfVSrj5e8obeYlY7W6FsVh5fqZkufB5fZUaBG8XznjEafpQbM0NaqSSiTEretwV7hLYicd7YaAN8rbPE0PDS/jKCWYiGYsFqC+hehzg98oToPdJKQ40ip53VGanr0by1B7TTenDlgSRGNiOdD9uf/GAiRar9Y3F6t8Bjdng5AiHKu2e51L9UpWBHkwWFPDR9m+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgs8uIC4zPmEpgTd3oGtcruWI5LAIMNpR0mlESbqMYs=;
 b=dlvc/QpD24qQrywl2EzgOQOu0nKz8nI65pTndn6i340tsQE9yO1aQWdqNpZ6GRk3Jm4fl5a9J6OsSkpRpWZ/wZ5j+GiOwUC9GQpLv75y1Sej2+VIYImC4A8/QTbpgZ7GLXhZFmuD5gm2mWlaHvRyaK9eAJAeDkZIQUbnqlLb8ZijJUgTr2ugV8GosAqi7HDkQ6fspX8vl3DM5UDqA+KCXLXlmAztjb97yLN9Y+N6EVL8uSMopSMK9GuNRZpz1Y4qAA5AUyenyXec5M+hdOH/y3QBGQP389+PYn4cWTNwRGvvb3OIz4yn6QGi3ag4p/5f2N8BDHJDqNxit/BH7f/odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=codeaurora.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgs8uIC4zPmEpgTd3oGtcruWI5LAIMNpR0mlESbqMYs=;
 b=qu83XIpCu39zNA86Rq6AryVDh//XyMBCp5EEmbTzkHiP2qLQMVdElc98HyWE/BV/vW4yjcdcCeLHNvNOlsOGhqznC6iDg4paIdPKHz3x9SXHtM1EutixqcFH8DR8wNjyetTnlWmP2wtxKUsXOqoPxSlwHW53kuMBAeY71RM2Vf8=
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 04:46:15 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::6c) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Mon, 11 Oct 2021 04:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 04:46:15 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 23:46:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 21:46:14 -0700
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Sun, 10 Oct 2021 23:46:10 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@codeaurora.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] clk: x86: Use dynamic con_id string during clk registration
Date:   Mon, 11 Oct 2021 10:15:25 +0530
Message-ID: <20211011044528.66109-4-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011044528.66109-1-AjitKumar.Pandey@amd.com>
References: <20211011044528.66109-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7d8fbec-f916-4902-6584-08d98c720ecd
X-MS-TrafficTypeDiagnostic: CH2PR12MB5513:
X-Microsoft-Antispam-PRVS: <CH2PR12MB551353BD36881E01A5D2C39C82B59@CH2PR12MB5513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vajs1PM4tt7S+gEnsHhPkvE2RMAwzE9pUae4o0CgqxBCZqU3hsHPUZO2o5VjbY2IG+sezw9rVZWk9uraJuNsqv9dBBqZRIIS4kWbsD1dxcdDynyOX3VxP9e55q3rMS+M2BhevwjCSEaZLFSSogJwdl6JdYNC/q1uIwVsxiY62wk0MLyNcXaGlQpgYjeLd6yZCC45joQdKZQiG8TYZ4kBNlMra+EIOOiDS7Q0r8VaehWOUmmCm0b/+LJRUGGsJn44C7aKeIft5gxx+qXbcpYiRi3dskpJB4Mph6GUmoawfwwjVhBEOGu9Q9xjWmSn5BqWn3kaPeq3bt4hi64fPAoT35aZwZwr7r90VJ1mRVxYbL/Svw1R7x/I0NNuom2Qpds3QXVCTkLlv+qpzfx6eB9oCk5wMajOLrOUg5xXQYc7ZdVt+/ML7Rlj96ry0rIqu4Jw/g2Zrbclfxw9seAKO5sFWHDAzRglUGB5qilPkiinZJCxxYshc4u/kAwHV88se/OuA/CyhlVxbA30uIEZoewZM8QkcLs5p6XvEgFetFSIkCvEE2g38JBFQ9roaJRYymsT0gf1w9cT1M7/fIf4vwEPxke5LXFwAR2luFOkKej7TyELI6rp3eEk7HPgkiBPKqLN/6mLd6SmENaZUEKmRY55eGsV8P2sMoEMWuzkKu0AEPBtnWxBk1pnpNjm1ZSC71OFOT3w4TeugqRlMJwmgy3ltJr0J8oEzBgdBxKTV+xPEww=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(54906003)(110136005)(82310400003)(6666004)(316002)(8676002)(70586007)(4744005)(70206006)(4326008)(356005)(47076005)(8936002)(1076003)(36860700001)(81166007)(2906002)(508600001)(86362001)(5660300002)(36756003)(83380400001)(426003)(186003)(26005)(7696005)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 04:46:15.1718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d8fbec-f916-4902-6584-08d98c720ecd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
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
index a95c3ffa79da..9fcf452e28d6 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -69,7 +69,7 @@ static int fch_clk_probe(struct platform_device *pdev)
 			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
 		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
-			"oscout1", NULL);
+					    fch_data->name, NULL);
 	}
 
 	return 0;
-- 
2.25.1

