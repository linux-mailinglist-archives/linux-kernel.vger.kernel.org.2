Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A294245D4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349775AbhKYG1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:27:49 -0500
Received: from mail-sn1anam02on2064.outbound.protection.outlook.com ([40.107.96.64]:28441
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347627AbhKYGZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:25:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCnbZ/ZxylmFA3qpn+LHCM69L0EJ+1X/AFyWydfP5cLVgz7ic27zFyUgSwBad2sGFshyGF3D0ZaBVMW67y35Eg+dDMs3Pn4a4nPVrBsxj4CWmSOOuNwocc549ThFjt5B2z2Sass5CLXvhrfyz1W2efcaNneBlhQeA8rIgPCqQX/jvsuNC20F1rOZkkcOiwMXjU304GVliped24HfXbI8Zn5J1JJ1krJgwvsEREK23pTtxFUX+ZHxKCLjMtRLUOEF5GNgUdfq+E6vTbLhBAI0XtWuLDhnApJwjGaOYHtK3CtMi0MXoyDD+oap7irHU1RxMAwxH0c6z5RfpuWdZzNcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPVnQlMQALahPjoEI41U7ookBfk5vIBJ6tNSfZCUeqM=;
 b=GpwUBMe0YJCeAx/pGAYb0sy/mTsNusby0/65A4+CSfXNfpcGvoSIfN7JOK6IfuRk7v444IjUDTiXFX/KZuPYLKY3gdUtZGEpWano+9L3H+qIPRDXUxDpR5+9Ha0a9ozAJyBl+CZwUXLjov2HKc3oxnAE+6nn/ZGjJFxY4eRz+HlS36Gh5kBUTkE4ZlhiEaIMf9+Gjpj1r5F0F3FSzDQSAeAzWO4fJ9I1rZHKdD56RFR8M3ozZC4bK+W+Nugnxn857WKa3ZevJeZy9nVY0mZnjPiHX39/CU1ObsEpKWpMyppXYT7JADwSA3E+tMN3AbRj/GgRAaigxhcKQ8moOaQNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPVnQlMQALahPjoEI41U7ookBfk5vIBJ6tNSfZCUeqM=;
 b=nqnN7dUAvHzD8rTJkQFqHKynrDGPq9XxuNTkfbPY8Kq7LJJ0zDMb/3j9endwNTvdd1lxrbiLMJSkBWpk6nXz80HdRVj2a0GwhrqOgXzkQ9HvTtSDIcfDoM9O0uv4AY1gxqVBwZeRSHiZr/ACRES3l2mkt6WHIh1/Mg0B6NVRNQg=
Received: from MWHPR21CA0052.namprd21.prod.outlook.com (2603:10b6:300:db::14)
 by CH2PR12MB4923.namprd12.prod.outlook.com (2603:10b6:610:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 06:22:27 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::32) by MWHPR21CA0052.outlook.office365.com
 (2603:10b6:300:db::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend
 Transport; Thu, 25 Nov 2021 06:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 06:22:22 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:22:21 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 22:22:21 -0800
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 00:22:18 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/7] drivers: x86: clk-fch: Add 48MHz fixed clk support on Stoneyridge
Date:   Thu, 25 Nov 2021 11:50:36 +0530
Message-ID: <20211125062036.1185994-8-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
References: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 047938f9-a388-4962-b51d-08d9afdbf0f0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4923:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4923DD7AE5783F920581A59582629@CH2PR12MB4923.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZbhhZqYqN2hJZIi9ltUJRXDkILK6EInwxVacz2BWAEsbJUDGFQX/OJ5s0sEj1BGLG6/7pvCsoXWflMq28u3A7uWioj1YQA0jNEg8nc2Fql5H6PkTbxvDd8l60JkkyV3qe9WmFNVQyzIb7nRtciqHCTmQaXw41UEUsvPXKp309W46qsy8zldpUHT1DPZ+Op9rjJ/X7CbI9v6XvII30e36SUQR2g9B6YrlUbQBuTFyNBinngfW2Jl2Jzpj3FqvyV+1Z1X5cPdO0CIP25sADE27mt0YApeZ3Yp3jw6kkwjL8JCN+pKr5GjGX9J9/pv/igl+RsHwfRLhXufzkIbivIx49GEWML3OZmOcUsIHKBksbrfstpd15InzJtpPfkFL+f2SD9BwWOArZ4QdnthPfJndquOt5THA1K+9lgmzdcGnG27tmRic19ATwBi72HHzZzWAdJJ2xyvyJfi3KcFdyarLqU0+eDbn6FXg9c3e1rwQ5cLKPgvUjECAnYI839b0xO5JFl+YQB53E4CfhBnN/Ighve2u+FtBX3hNLtxjJ3UYAj9bOFQXJoNIZBULJt/9FejwWcmktXGiI382R0MErb22SOqq8KyOsaUH+z2OHDFZ06XPp1aJlrZgnqKgn7pIgn8aneWYX79ujrR/rPNRhRKMqv3Z+9pye4IP7mmkAUEqc1yfz/fB1mf6BhDu+6WpO5NAEQg6tcDsj0r4O570+dKCsb/pMvZ2+N5UZLiJLxQHwI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7696005)(47076005)(70206006)(86362001)(70586007)(426003)(336012)(186003)(83380400001)(2906002)(508600001)(8936002)(26005)(4744005)(36756003)(1076003)(36860700001)(8676002)(4326008)(356005)(81166007)(110136005)(54906003)(316002)(6666004)(82310400004)(5660300002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 06:22:22.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047938f9-a388-4962-b51d-08d9afdbf0f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4923
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stoney ridge SOC pci root port id into pci_device_id table to
enable 48 MHz fixed fch clock support on Stoneyridge platforms.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/clk/x86/clk-fch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 9683c0973e62..dbbf489aad84 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -34,6 +34,7 @@
 /* List of supported CPU ids for fixed clk */
 #define AMD_CPU_ID_RV			0x15D0
 #define AMD_CPU_ID_RN			0x1630
+#define AMD_CPU_ID_ST			0x1576
 
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
@@ -41,6 +42,7 @@ static struct clk_hw *hws[ST_MAX_CLKS];
 static const struct pci_device_id fch_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RN) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_ST) },
 	{ }
 };
 
-- 
2.25.1

