Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61CA45D4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348549AbhKYG1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:27:23 -0500
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:15649
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347371AbhKYGZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:25:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/Bn7cam6fBeJYTWvizlr+h4ofFj5h0+FzgJc91yHLPA5CZx7UqhVSFR9b6ua/MLz5G5KPwraFYQL9exdCpTld1IHjpog1cDH80RwbTNI4rRgX+cQOXlUYTyZLmIDTBZROu8i6zF6DW9imV+NdyVhFeLRCWpKps+Ss3+q9qnTDWb66wUXAWFwec7KMUgc4mPrPyrnSFLKL53Cnwfubih/gUL16FWNYZCv5GCsWPW2PscZF1nJm2De4WsfZYutc4kY4CFdgFx1chMlcv6+0eg9jqr/lNr2/L2bNL/iBngN/ZsW/ctKW7g3jBcHoT3ilOoyTeMkXadXHCmLnXCYXvdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh5M4px4rPXKbUX2yOWcEEP5nS9CxqZeF/wD8894v4o=;
 b=joukrAdKs6ebcCCVwvLDFs3qaYNc6mi/MUMFbHA3Ykc1oOpZ7MbOceHyMAg9b4laOqkzFuNhePGM22drlGC0MTnWwXrFmfDxBncU+Zf/bGh9WZ9pX4OtqaXYzsr+xC0rKdcKUKxTq+94xdSMitueeSQ6xwEsG458bIL3O/RTeUpv/+jVFhuZizM3zzSs3bNbqLIBVTR0swn/lvQUuENpCXiMmNGbHtdY6Eiyaj+pYIrA7+Qoge/td0FoZl434guqP8A8hiYvdI8b9x5ahmJZq2jecvROB2TzJ3eKsPipnJL8AKbhRxu3eLfyzwkfmOfQJyNB/ZOQbsb3ctOSMlad8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh5M4px4rPXKbUX2yOWcEEP5nS9CxqZeF/wD8894v4o=;
 b=GJgXDjLOLduS6LHlnzoj7ZWFibalUw428yAVGnx1htIXN2HdcsVH5WWB0RMGsRHTTWiBCizDctbixxynKo7WYfAK23oLICJoic/0oBDCm6X4NNAlFXEzzyWzq5M3qjOwgHrU9c9KeosjAp5AvMR2x0HL+JeSL0U7Nyl1vGjDncU=
Received: from MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::28)
 by BN6PR12MB1393.namprd12.prod.outlook.com (2603:10b6:404:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Thu, 25 Nov
 2021 06:22:09 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::4b) by MW4P222CA0023.outlook.office365.com
 (2603:10b6:303:114::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 06:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 06:22:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:22:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:22:07 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 00:22:04 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/7] clk: x86: Fix clk_gate_flags for RV_CLK_GATE
Date:   Thu, 25 Nov 2021 11:50:34 +0530
Message-ID: <20211125062036.1185994-6-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
References: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11f76864-e3eb-42ac-5075-08d9afdbe903
X-MS-TrafficTypeDiagnostic: BN6PR12MB1393:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13932E7D9CDC2544900570D082629@BN6PR12MB1393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKJmUGVQigKRz88nfKT7BgvI8iu1MdHg9uOM5KL372dJbNyY1lah9CJDs7VN836EA4dGhzXP2fGIpY3af1vTYDTKPjiB/hKLZK/bH/k09uvAvv48iEzWihuTWPB+fXEWqSsBu2hZcMH1GVM4QGGFlaLjSeX1iJy0iH7JmA0wc5Kxw7sTwkz5sIPNUklSHJQCMdCry29WZ/EqMgC/nh/6JhHDvObaKDzgSP9k32R9fiAES0A2+cF8m5ueW5H2ky0hXi19jEyOjnm/lNOC1pn2kL7YKWR+tGhMcwgdDb5iXLHNlmd6whgFWkM0LTN30CcYv47opWdmvxuGV0SDw4GfVLLPcTTbvRBy//q+z+WRACVj/mkgyG9pYA0RxaD81wBEygPTG5XM1rkdIyvHC3G0gb0MyGicbDc2s8A/mCTi1njwmd8RSYMHHP6qv/k+pBjdcuXyAmZ1vsZPkJzajFf8xCk5sxt3rn8xq9WYoPQp3cBH0IM9QIh5lonbbG1T0sIigv0v12F+StE6RQFTGx3GDN8qhA3xjfFIweZuQSOUTIEEkFrAbQt3k5hnp/JoWxYG72AmBUPqdX7NOwpTKnsDlNnOaXZUAHMywWCzuoCSQNQzesj9oBa0JMa9++a9R/PAEQUNL2KU83YpkD7ehrBG4/h+20EG9Zf/YPXZhvZGrIQilVd4q/LZs2XoHY9YuXwrW+gGutjquXoS37O6nddpMjv4uqx+RO7whInnH8hLM5Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(110136005)(4744005)(47076005)(186003)(82310400004)(70586007)(86362001)(426003)(81166007)(1076003)(336012)(8676002)(26005)(36756003)(8936002)(54906003)(4326008)(356005)(316002)(70206006)(2616005)(83380400001)(508600001)(7696005)(5660300002)(36860700001)(2906002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 06:22:09.0045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f76864-e3eb-42ac-5075-08d9afdbe903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1393
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
index 4ff2e1b3b3e9..0578297d8322 100644
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

