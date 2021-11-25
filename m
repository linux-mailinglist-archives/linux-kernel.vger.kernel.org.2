Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2145D8D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhKYLKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:10:45 -0500
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:57981
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231130AbhKYLJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:09:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQRHCoUZDvuh31uthVcPH3yTQmrhD/AZZ2GhtkVKewPo1a8hqKp20EEyNEUz0ACggpofdgNvH00xP+Fp5PK/n2cSmeaTolKm0Vy0GGVJfwys0/CPjiItTW5YD1lL3wXeGe2rJP8isy2U+qJEoAYZGVPpPvMldDkwOpfOpP8edSCw8J4kWlFoYAQo8UIKdn1F4nD1PJunTaxL09ru1Jhmwf5JLfvVqJ6DdeAwMGO1X3o24AtCS8DKt+Q+dkTCaEo4GmGSpXgyf0GdVSjmGUxYqiW5xEVi6x9vYkK4l4kDgNiyYaxMbPykKQJdoo8e+eA82ndjlRYQVFCmVLe+QCVipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDl2uiXHykOSUbrQ5uaVp/AnsdLqpx0SIvUNn0l7cpo=;
 b=E2/UZG8WRfOLXLg1+U1PRkdTlKJLtC0cSayTD0jjMWpDqdn29cCZoy5rTEgPKYCzKYG4BcAF7NDfIJcqRRr50+pEGu3v8pY7V7lkA34Ll2/3jOrbnXffPlV66SIjX8eT9s+NlulgOT/a1BfzMDkrfGwV4gd7xQtub3NkNoH2GKfySInj3gDXvom+0q/qrRtALd9l6v3URnfk+q7a2F0ENfAp31QsLufhFFZI6ruZEShcz8krSzHT0J9OB0IKPsrfAVDLtZL/qwt3wILGffENpxqorYgiF77fslF1/60Xc5NKGE/qVhE59yJ7CrLxrwS9cn2DlRxuAqG/09XbLMAVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDl2uiXHykOSUbrQ5uaVp/AnsdLqpx0SIvUNn0l7cpo=;
 b=EpJp8oL0NTGC5iH5ugeDyJUPZ3Ea+pn8O+dNv5bJfefQTaWlrDSuH17ulnA/wUWJteE04AkWy+o9Ul9b/KxPpitiDXArDULb9IY2YbthSso8WXedSdxZusPJTsP+vk/KShkDI7b5z/6CjrJpJJ0FdOW578NfHZxoCIIVcp4hFLo=
Received: from MW2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:907::44) by
 MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Thu, 25 Nov 2021 11:06:08 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::34) by MW2PR16CA0031.outlook.office365.com
 (2603:10b6:907::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 11:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 25 Nov 2021 11:06:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 05:06:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 03:06:07 -0800
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 05:06:03 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/7] clk: x86: Use dynamic con_id string during clk registration
Date:   Thu, 25 Nov 2021 16:34:44 +0530
Message-ID: <20211125110447.1188073-5-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
References: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c297382-879c-40d7-3a7e-08d9b003952e
X-MS-TrafficTypeDiagnostic: MW3PR12MB4441:
X-Microsoft-Antispam-PRVS: <MW3PR12MB444136BEE4DA89DAD6432E2282629@MW3PR12MB4441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKJmCnL/k0bLgWO1vxAYf+S1I3IAimv/M3xt6o+p8i+nBGPLWIZI/rGJZM4V/nGbvUl+vdhytLOWrGZ54wZ7xZOUOxyTwWpBcf3IHLqRqz7TZjuMcyAkEvpu9LdwIfynSlQkN5AZ1DdRqElS7M4QC6n8EFug1Hve2aYI3hlKn8bnyW5xysgEbR/UWA2mNrBB54aII3MLwKyg+8ViwJ8MFo/frzc8HECZpb6DzPdMHHtYRp0esDJcKBtCRfh81gzugmjYRk5fOqJsDKG52quhMTlihpvVT3/f47oPXCIJjCCu5tOZh1/jWQm/IB3+Zuqm+PYImLwh6MbtAAvwVVJriIFqEofM4+Uajh4EWHjJCnJZoHdQzbGMwd6QmYkq5TfOfloprm2WTRdgGtxZRwmcTn4o5WAWE5oHSuKe9jlUaSRhZ4Kh6PLgL32pOn9huvwv1WDxiR6Zuq1yfW3kVa6IM9dX91JLSlPTlwSLKb2ZhCSem6aB3SicGA6wezqlNWnIjLUdhc1gGZRpcuEem/0/UhCgKZgfKhV8m9/CG0x3g7xxTDLYL6ZTziJ7Ce4EJGGFwFdL2hSUoh9SeGVZpRzNVsf7Sny2rDq0KML4lSjSvcMSUYMOa3arQBdlRBCPqh/RsxbeQl9UTyXyV01Bsm20/l3yZJQmJDmGhPp7YsfUJNLbsUMC8u8gvAItYwGbhaXarNNEGaCr6+MtQtA7KUO3kv4aqbd5+G3MBSPYd83dHv4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(6666004)(1076003)(86362001)(70206006)(4744005)(4326008)(316002)(83380400001)(8936002)(336012)(186003)(26005)(36756003)(5660300002)(82310400004)(70586007)(426003)(508600001)(36860700001)(2906002)(356005)(54906003)(110136005)(8676002)(2616005)(7696005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 11:06:08.2291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c297382-879c-40d7-3a7e-08d9b003952e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
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
index de556b03e184..7c55e129779a 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -85,7 +85,7 @@ static int fch_clk_probe(struct platform_device *pdev)
 			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
 		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
-			"oscout1", NULL);
+					    fch_data->name, NULL);
 	}
 
 	pci_dev_put(rdev);
-- 
2.25.1

