Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1B542A24E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhJLKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:39:05 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:61792
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236056AbhJLKjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkUGe29sMTnCXGrd4opt89XthxBMyeD65pumwyEtkTs9uY6bmwS/zFXe5mL6uZNOtu3+sk6+kV6zwes9wNwEfRA8FsCeU4UhpB+qvOplNmaWhS+F8I/SIcsHR2XM3zwd4lhw2YGN7lUPbokReQIBn0MG/UAF/4RhRWWLuCj/xrBr9CMm8n8r/bnjSayXcGpLsQRa8a75Cp6Xb4XYAUZM3Xvdy7l+aLf+B/9MRANe8l2GvKhTKWE/+mERUJ3c1P3H2nrjLpR4GEmEntMzBRzNwGgIM0qtnlRGPK/GTR+GA4jtPGAcEYX+ip5iSBavyTs3L8AEWIpxmE+A7Q+rIwNbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVEhHpye6VptfXAnX5rQdH9F8vEucmga6tDJF/mbR+Y=;
 b=fVSs/SyN0mos48tXhSGmgl+nmZq0M3b6j86PIPPTxrB+o94Rg8o9NuPBCN6K2qjTRuImt1N1FXktQWAolWLx4FT2HNuAuLA7zepoi9Gi8OwoeZPouF8Eq4glOrsF+tv3UM0QBXV/1YCCU5+eKz5v943l+qN6KTXjcKJs8vuAP6RaO2aRKiHGlOmtxqK/V7BPsTWTAeQuUqOPxWZMZB397q4PdLpAHXaoiMUujxiHIFLUf/6ltc8sZ7Mb5maE8N6afkw+o6ITpturLZKibyOtZTNCcPF96fhbatJpdYeOwTy1BZc1GDrSpq4PPnTeCqVHFkSaIIZjQSDEDjDsuGmWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVEhHpye6VptfXAnX5rQdH9F8vEucmga6tDJF/mbR+Y=;
 b=Rc30VWBI5TB/7fIRGf4URjHc1OpUz5W1zsEtA0D0ERfX4uFhJNwU+Z17IRg94vZX/6efM5ry94NAnu0/WygmpWUsAKkWooGt1o6HMD4vAZZhL6jTvkD+Zb6+wx09S9JRMTUNW0o3Sq1LyDsG8ubaUKVh/TWODPBqKq7VFur4xxA=
Received: from BN9PR03CA0660.namprd03.prod.outlook.com (2603:10b6:408:13b::35)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 10:36:59 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::9d) by BN9PR03CA0660.outlook.office365.com
 (2603:10b6:408:13b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Tue, 12 Oct 2021 10:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 10:36:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 05:36:58 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 12 Oct 2021 05:36:55 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] clk: x86: Use dynamic con_id string during clk registration
Date:   Tue, 12 Oct 2021 16:06:11 +0530
Message-ID: <20211012103612.101859-5-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012103612.101859-1-AjitKumar.Pandey@amd.com>
References: <20211012103612.101859-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c0e21b1-d3cb-437b-67b7-08d98d6c387d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4542:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4542C31B5A89D3A5211DCAC982B69@SA0PR12MB4542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DD72B0xAW1rL5RnRbhhT4W0yIO1U/pTzrK4EnvU3ZnoF2Xq/tLPcDDP0k13prONJZ9P4aYpdn0KsDLSw0xcejdcfY5bPdge+Gg5HCYJmvpNfSO/BUI55liAQr97Q0mfif77ltPORCC4EUfA2rRjUOI8O9IT6bAdkrFS6vSXEz/gT/AY7EENAeKyqojDusGG1efuENbX46dhpCcVQE+zxh8/V52mSkh8S99epTwfTGoZSz6mr3JlVo4mKtiRRL95GWM1YqKkVK2PfmKxijsMlSEiIIRnm0UUHIgGKPG2ZfCz9dXOM+RV62WbR0syPBhEkYXg6sIRy536lIwIb5G8XChKPENSqRjq127O8Z3ltAPT5161JkFHvAbtqafWvE+wLBxBH2+VAQsB2aa271B+J0k6hzPuYwggrR5EgQ14NxHQJ6Fd+bAveQgFCqXNBwV15FG7H6RQQwhSetNpwMlgXPE2I2Cj1fj47DoRUTL4W2jfNIrsOn7uUF/OxCxOWe8ZGsPu/qRvuzfPNSIBIXjRSOWeQk/g2rdkx+JPmExtd1oLsz23ldmUhxCCW+eSG+15/VF6gjA/3OOb1m8y0PEYs+zhj2Tl2Ey7WmtcSpkBsIK85ugetjAQ8Wxb3jth56Bz4XDjRUQdwC1UUtXPRQKqChe1IHna5qyaeyLZ2MD3GhWrFTtebVJw3dppvDuXUe+Az9b9p7bdOnw9iyZugHvPAtKRxwjsaD4CGLBzB/jD2aw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(4744005)(110136005)(54906003)(316002)(2906002)(47076005)(1076003)(82310400003)(5660300002)(186003)(6666004)(36756003)(8676002)(7696005)(36860700001)(356005)(81166007)(4326008)(8936002)(70206006)(70586007)(2616005)(336012)(508600001)(26005)(426003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 10:36:59.2933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0e21b1-d3cb-437b-67b7-08d98d6c387d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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
index 72d2c7497234..19a5c8cf1b3f 100644
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

