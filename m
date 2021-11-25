Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54C945D8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhKYLKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:10:49 -0500
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:29738
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231993AbhKYLJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:09:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2CAk4dfpxSzcHXWduS8iTTsDiiXCRyqgBF90zpMdSHsgsK3GOyLv8X7opgk6bJPwa75vvLCnAz5hNasCqIWh6dCzjETlMIWHic201iMCv0LI5xdUXb70mJtXM2KhUXFAdLRRBW4QjbbIV84k6rUkAIxMLr3RTOGyLga28U5O1/gmeZ1t+aJ3RxbI8QpBILF09qpG/tr6P3YPpNUGKR5HNp48C+etTOV5aK0Yu5CGZ2KpSouVfwzopaJrnG62hlEvcJXOFrVFKULgmgft8FOLt2gx18KvGQABLT3+kA0AoLSauI9ZAKWS1ts/Htbenl5hB+dkv5/5joHWLuzwzPFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KferKf1Lqs66Anbq7e7N4S+zUggpxG7lt0+s4KK9BUk=;
 b=LGAO0XNJfbvdprL/rQKzcEnZeJ3HKfVeU7GubtNQf/+khcmYKWMxspZ3YSdgz2C5dZNxiyO0cv63lh/YRSMoMh6/ISMf9x28QCoqkdiTSoKUe8t1maJOv8+xnjNZXEWTvaHSkEKbJSZiHEPYCRTPU/iuFDXTynkUR/617ROt6btBinve8e/lf0O5QBcd6JP9a2amybMSwuTfKv/Sq0k/0EAmRq0tLOwKtyahPKkO+oEHFbG2O6fTmbLInDynHkGkxnwxKDP9wVZI4QR5wRkmLz0YjAzjGTY1o8QcxRJvjIPGTEoaH8rXlKYyjfGBDhnI/qUqQKAxSeOOopx8f8iQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KferKf1Lqs66Anbq7e7N4S+zUggpxG7lt0+s4KK9BUk=;
 b=2uruylRvMcC4L2E8ZGobaUFjH8I3Ks7IjjEU1Ih8BOTNGY5b1ziPEocsSqlIJVF+mqJb5KjnuLhfYpLWLuNQ/5Ea9p7CweKs0A5ZfG1FAxGOBzi1geWZLQgyMwdc8QuoTAatOTRb1QQ6jOX7dFckUcFUmmxmcZvSWw4QsJ/kk6M=
Received: from DS7PR03CA0354.namprd03.prod.outlook.com (2603:10b6:8:55::12) by
 MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Thu, 25 Nov
 2021 11:06:21 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::fc) by DS7PR03CA0354.outlook.office365.com
 (2603:10b6:8:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19 via Frontend
 Transport; Thu, 25 Nov 2021 11:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 11:06:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 05:06:20 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 05:06:17 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/7] drivers: x86: clk-fch: Add 48MHz fixed clk support on Renoir platform
Date:   Thu, 25 Nov 2021 16:34:46 +0530
Message-ID: <20211125110447.1188073-7-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
References: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f64c7f-2659-40f8-d716-08d9b0039ccf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4406:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4406659447DD352FACF7D9D782629@MN2PR12MB4406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtUFqsVURL/94W3BSZM/0jD3LJKaRssshfPxS+b3QpIORDvt5/I5xtGPLEClW8QyrMUW2TUseFjRLZiH+y6YIjGDGzHvDbzILberij1c6DNr+em8PbLNlehOtaGlVNPI1rDDzAkSdWi4DnnUBQZqU1x0m4GU1Z2Tu+pz1hcXlXbN4bVhPtGhFoymGcR19jOKXBNJpOPl18qXl5PlzTnVeWwxJ9rVPCrEZ1JooQkov8UAl1asASk+tVmBj6xJ6tMWDtL5AN5reuXxE4Rv/vcReaIwrCvbQlLxIPuwnJi1sQHL6B4Ae8/TlkfNg+EgORwGgwpVzitaCshSxG7iF8DmkOBrwD/4TL63eLONmfQqc8rPel/h9+0t5K61dbxRDqDkCyUSFHszNPmb8/QBb4aFT8LrSyP5/SBdpMzCz1aWlVBHxumvzkaoCfj/welYIqJhLuqQ+LTQ/5JUZvqCn1XVpjscv7oBwim12A/hkD4pYdWR/WXAYtrEaFOGx2337jyxv11IkVUjn5dvAkoEN/h5lrr+C5D0aWlnmJeN9ubD+m/dthtQ0vITSV4MzgMNFhl4sqLzaHZdf+yk0hkJLUt7r+R/M+zhGjAgEPlVx9cfYpF+Ag23JvL5sNME19+8neqWzeIQw6PP4iiPi6QuIyyiSgxuEOF8cb3QD371774ELmwf7JDHRP2w9fvv5OaoaNXOD12eeKxTYpCZmXAg4buf0d8kmJdqaCyifVyUo3mL5A0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(4326008)(36860700001)(2616005)(83380400001)(1076003)(356005)(5660300002)(426003)(336012)(508600001)(8936002)(186003)(47076005)(8676002)(81166007)(26005)(82310400004)(4744005)(36756003)(54906003)(6666004)(7696005)(2906002)(70206006)(110136005)(316002)(70586007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 11:06:21.0833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f64c7f-2659-40f8-d716-08d9b0039ccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add renoir SOC pci root port id into pci_device_id table to enable 48
MHz fixed fch clock support on renoir platforms.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/clk/x86/clk-fch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 484fbb158e5b..8747212cd289 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -33,12 +33,14 @@
 
 /* List of supported CPU ids for fixed clk */
 #define AMD_CPU_ID_RV			0x15D0
+#define AMD_CPU_ID_RN			0x1630
 
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
 
 static const struct pci_device_id fch_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RN) },
 	{ }
 };
 
-- 
2.25.1

