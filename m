Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA743F73B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhJ2GgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:36:05 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:57793
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232050AbhJ2GgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:36:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHF69VZ34dSOj4wuAZRKqzCCd1ikf6IfCpsleb1/mp1A/KRizKUB6hhannuCNFD/8sn5gwN81NvgiPaE70D87CKk3lNL2f6aQQK3TzMRayl9Ne6DT1hHNHGPjfGmpc8g55N5c98/1TrjZHXgFR5w+H79qddJxlBjI0Otr3Rd/98SlEIyYGiEjumh/38gSxVJsHxvknmvMjZKbus18OwYgZC0/q1WIttZGCqqRD6BwcMq0SHOYBK92tC1zx5LXjAy21GBDZyHg7/+jy1bLCSFQGW0Ws4vavm8w9S/hp3oDhgmIcxiuJMY/U9lXmdo1zMjtvljvxaD1z83DpyNddGH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVEhHpye6VptfXAnX5rQdH9F8vEucmga6tDJF/mbR+Y=;
 b=lpRHqshUCVAo5jDsF/8YH8TNTR++Vvek18LyWsDp3SI77qTrOzaBTtngLH08tQnCH4OlPyAUdq5wHdvwkkvYHHpM3cH8HWCzG1lzcbE88At/W4j7xAT7TU98uTwTb7FxdCJ/qa6K3MzgrhrmRw3+xzftoAUmnJip9uH1uxc9tKpz4yeRXD1NhoY6CV27ycXF+wRytcjhoQpcYuw4U4gWNpolp1CKvLjcB/zjGrqx90PiK/59b+GA3MfcsteUwf3rf8sNgYm+bq9NC9BJqE+V+IQ+8zTjre8xxcEfuishaI3rK3Q+4dhb8aTJgCyij2y+gVeqUbOsW6AjoDVJJZz0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVEhHpye6VptfXAnX5rQdH9F8vEucmga6tDJF/mbR+Y=;
 b=jc8W67cCC9KdBJauyXQTFf2jEaMtv1vau0qBc/PnjX8HFKlusT3g8ie+9bT9eqn70j3lsCouAsGE5LGhAipDfaQGivrQbecUcjVEkOQDFh1+60Q92eREBmpJ0Cc4MzFPH1B0Qp8c4T8zzzssSNiJx3G0sCI9fFa6DW375jZd8iU=
Received: from BN9PR03CA0732.namprd03.prod.outlook.com (2603:10b6:408:110::17)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 06:33:32 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::5c) by BN9PR03CA0732.outlook.office365.com
 (2603:10b6:408:110::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 06:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 06:33:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 01:33:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 23:33:31 -0700
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 01:33:28 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 RESEND 4/5] clk: x86: Use dynamic con_id string during clk registration
Date:   Fri, 29 Oct 2021 12:02:27 +0530
Message-ID: <20211029063228.578909-5-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
References: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff215d5f-e935-44af-0cbc-08d99aa606d8
X-MS-TrafficTypeDiagnostic: MW3PR12MB4410:
X-Microsoft-Antispam-PRVS: <MW3PR12MB44107514A2A1ED023F1CAAFA82879@MW3PR12MB4410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thSkRcaDNwFZ/9/XCFDIi30uj0gDXIKpVe9euHiHtlI4SGWkZjfEvWYzUDgNSTH/cs1IFpDiW2xnKRRlg7FkXRHCL/4vi8FmaclSdMDju6t8zyVDKE+/c/WTz2+ofv/hoh5uOd/hWihf8Q6JIK7vJbjjHxZO2ws9twV9pdTmE9LKcElwSlNS0juwU/ycqRZ/n84UPIF2KHriBhaVRgiRl7mQ3wgbHOmkM2tJ/8LrrTD9csbkjXCvKdUoEPAMnH2O7tf3gGrfsVpyFCq+YkleDT6DqwLrPp81naFAlAsyPMvQK6Ah+xm/ACAeksbI5TwSiroxyU24eFZ5QWMD5LAGSCOboREowHRvI8H+2F0bM2yLCt/WtSO3437Hfxjlx2HeiR2LpG2M8JVOZ5nRUdxEGaFoM9E7Sly/vOx7KFdscjNjJWKSZRlJh1SDdhsM4riS7IZ6rUGN85ArBoP4fyjFV+xksCoN1dj2yv4nz5qrFkf1SSW+jeoN9BTEDw4rk4S8Tl4OjiXA5m4qX94jTXfNJbRKfSOnpmTX+qdoRZqZY0hGNtJYTvn2LLaElDOzxRmwP2yUhoTlZKMw6QxCYNsyqDka5bOK6yX8sPjp3+EJN7hiIwcA0iKX3Zr3+8xCriLdybg/Oe3K6HKE3qLYI7a929NQa21JhCmVT34hMEJHiWyhPotIv2NwpkIUlGYpr2rxUGU/O5rTwqcKiKIPIhvnKljV8Sf870xoj5eeEGENtds=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(81166007)(2906002)(508600001)(336012)(356005)(316002)(5660300002)(4326008)(47076005)(110136005)(82310400003)(186003)(426003)(54906003)(70586007)(2616005)(7696005)(4744005)(1076003)(70206006)(36756003)(36860700001)(8676002)(86362001)(8936002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 06:33:31.9267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff215d5f-e935-44af-0cbc-08d99aa606d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

