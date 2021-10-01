Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5341E6D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 06:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351296AbhJAEmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 00:42:53 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:62305
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230477AbhJAEmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 00:42:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTx451bUiip2NRLCJstLxAEoUnlGPk+YtxvjXdVTYXvgLnrd0PnNyVMI2YTE1/9BhfjK+3FGwTEPq5hXuewaDQYY0BATh3jYWYfxFSUq7OQFdX7H2lakLGo+3gS8UnA4h8IRzoPbVRy89XYGPfOiH54Q3JiLv99MlPJ9E4RmxiLcjZL/DrBHbY+Td9/9+7sHKCRW52w+Cz2wlZzLEa8/GN70eIvzLkCfqz/1BPDuoiasXWvR26pp8nhZDcK0zdTU79Gk+UCK5s9gXmE7w/4gVsv8XJ7kTzT82DAkay/odH978H9FsL77Q8TnRsvk3B9z0C2KjRArFPdOMFo4noAjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXv4e/1d9yM0SCEztrbqOFfhRffzwWUsIInx2UNd5HE=;
 b=UtQV+eBzYhPvZofYa9dO0PJBv4y3h5wH8UtgQzrSDx3sphR8AbT1wx7zokRChGBwO1V9rAVu7N7nNYRfjV1d8cHqoRwNUsGs8nIAhhrJ/shK8aHnHJgU+NoaZseBdk6VlLRpftNZEIBm6So6XLLS2P9LLV8TXkxhBBv+RXq4u5ZNw1yytjefFC0osrpI2TqPmnzH7ZIFTvKRUwcNWLaAZqOwBUCYPsvBuWwr8eVb6+GJ5iEzuBu89FMVeIxJXeaykuwo7zwcT8zdavCuRauL8ZFTjqjWcSgK6X2sKygvkfpGfsXroLR47emF5zDnB1APswX5+rydxXqYqmWuikcxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXv4e/1d9yM0SCEztrbqOFfhRffzwWUsIInx2UNd5HE=;
 b=tK/aUgImM2EHiXGQAKYPGx1ji12M4uqasGzb30rXd4xYEogSjm72jdIn9q//Znnh7h03SqblYPCbHx1U+xid7QDfSWNzXSiTvERN0a2O4PDnsJNTP9/iEdMJihX41Sg+CD2pe42okq1eMxhuMxgGfistkN/IbpPrzJ3s/+caD6s=
Received: from BN6PR17CA0003.namprd17.prod.outlook.com (2603:10b6:404:65::13)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 04:41:03 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::1f) by BN6PR17CA0003.outlook.office365.com
 (2603:10b6:404:65::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Fri, 1 Oct 2021 04:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 04:41:02 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 30 Sep
 2021 23:41:00 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel" <jroedel@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH] x86/sev: Fully map the #VC exception stacks
Date:   Thu, 30 Sep 2021 23:40:50 -0500
Message-ID: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d5f5618-cfe8-4e8c-292b-08d98495ac87
X-MS-TrafficTypeDiagnostic: MN2PR12MB4095:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4095E168DE2DBB8E89E9445CECAB9@MN2PR12MB4095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SONTJTrh+g0RwE0NLV5rOCPuQNGa+UWCiF3ReQuCwmCBQZthWzVxKfAQ8KyaW1HbrBl7poVEKyWRGhdiJSvTg9em6OyqELrE8dXlJ6ugDAdC8eR8sJCJCPdtsk/fp0l10rxZOgl5Vc8pGZ39h8UaTfuJWa8pCjSiEawbCqyDz88D24Q92ZLO9b6bo7AeEH835IPf/v7U4CSAFfpi3o0kLj5sWP/4CWJ/tIKTFN8ALNXNxnfIxX7K1Q7TIkKSPy4yaaVsF+EpKYyiIBZ/L/I6bbMyeemR+BUBg8c3IEXj4mvW99/GS633fZVxgoSv2KDaaoecD3b6pWQWs+Yxhh+Kfcd731pLpgFl1CPegd/9QUk935ARLjTkrinQO4d0t7c1Uehi6lPzolv8L89ZRkUAKL609Bq1AhohdEuvj+F22U1zQB5sBFSPHP8qn11rwKyfy+DKGYW1BENX24qnhbksRoe/oPsKZtdfZQtj2jZgHuYA/iBGFgAZtrmESeeqSIJBZnCHmXePh2pdGZin/HkhyPp+sIxs+4gpXDjylIvsopr1ATM6UCcdtqGDbmHFQ1PklN8cHZMILjFtZWTzroLEKeH0hEr3fvP/A1BxOzYnNvkuZdY9HIzRBA+nEdJrMbeWOBo5pVUU59BVY80XjzTdTMCY97R2BNDVorYu5QMOCf1hnSfZB19ztm4z6KDTRVK+71j1cQG+qEe/bK/HSUTxEcSdp5I10gTZFY0dQQQ454Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(26005)(508600001)(186003)(2616005)(86362001)(36860700001)(2906002)(16526019)(336012)(110136005)(54906003)(82310400003)(426003)(70586007)(70206006)(6666004)(356005)(4326008)(8676002)(316002)(47076005)(81166007)(36756003)(83380400001)(8936002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 04:41:02.8744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5f5618-cfe8-4e8c-292b-08d98495ac87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of the exception stacks was recently increased, resulting in
stack sizes greater than a page in size. The #VC exception handling was
only mapping the first (bottom) page, resulting in an SEV-ES guest failing
to boot.

Update setup_vc_stacks() to map all the pages of both the IST stack area
and the fallback stack area.

Fixes: 7fae4c24a2b8 ("x86: Increase exception stack sizes")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..33e4704164cc 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -99,25 +99,33 @@ DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
+static void __init map_vc_stack(unsigned long bot, unsigned long top,
+				phys_addr_t pa)
+{
+	while (bot < top) {
+		cea_set_pte((void *)bot, pa, PAGE_KERNEL);
+		bot += PAGE_SIZE;
+		pa += PAGE_SIZE;
+	}
+}
+
 static void __init setup_vc_stacks(int cpu)
 {
 	struct sev_es_runtime_data *data;
 	struct cpu_entry_area *cea;
-	unsigned long vaddr;
-	phys_addr_t pa;
 
 	data = per_cpu(runtime_data, cpu);
 	cea  = get_cpu_entry_area(cpu);
 
 	/* Map #VC IST stack */
-	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC);
-	pa    = __pa(data->ist_stack);
-	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
+	map_vc_stack(CEA_ESTACK_BOT(&cea->estacks, VC),
+		     CEA_ESTACK_TOP(&cea->estacks, VC),
+		     __pa(data->ist_stack));
 
 	/* Map VC fall-back stack */
-	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC2);
-	pa    = __pa(data->fallback_stack);
-	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
+	map_vc_stack(CEA_ESTACK_BOT(&cea->estacks, VC2),
+		     CEA_ESTACK_TOP(&cea->estacks, VC2),
+		     __pa(data->fallback_stack));
 }
 
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
-- 
2.33.0

