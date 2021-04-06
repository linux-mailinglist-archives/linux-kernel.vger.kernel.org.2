Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6623335587D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbhDFPup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:50:45 -0400
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com ([40.107.237.52]:57121
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345997AbhDFPug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3TnuYsilRenDNNdDJrgieDdepJWkdQdMk8ojesIOpz2YtuCJ5S4CRogBlpGshC6EHIArPBFvrqJS7dAJxdRZTM7Bwj1AuuRCuytQfSUk9ayZL6C9PRQbxgew3gJASkvXTVSaDNUWjq4+ks/hXmMJVyIdvso7mQ8dl4r7N646bnGe4GpUkOG/kOaaE230didPncUx6euFGXFyiRHDswARioDwklw0mhPOz1IGol8tsosguVTJL3dZ1BiGBjl25qt1Nbrh8z1A2H5mA3Z6/8vMnUojrzDKrK3TNnI5hEq3+y5VFFG02oS4w7HTdxAJq/HhYABONgQmB3NOA11FPYE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pb1fBEgORWoDqDU+a07bNHp8PSrfTZeqt8cX8rI9BI=;
 b=YwFemFQGPzfnSIYM3cbLy80IMBXcVJT6M14TDIX5JaN2zEMkXkA9+Gk+tCQRTj1fndnNN6ZgphAevv0qCnev6Yd/NFmMHw8saVw6eEOHHYRDAtUDsqAgR2EWFZ3HM8ilz+aD0ynKFW1TcC3Qf1qRFYl9IzCNxYFy8A+XBc6VOg6SPsatYpFB4FX1IID3pRetFPrsrqkL9nJo+h0w7iEc9h/sL9MwQYW2l5DqgThS5zQ7GvW7LfswB3gnPD9e58TX8wvHCd81mYWcgajeMQYnUHwRXkYZpzvhY2/BiatIKfo5Vk52GaFrbIznF3zPcIBY3NJ2lHsCdYTe6ji+pC4exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pb1fBEgORWoDqDU+a07bNHp8PSrfTZeqt8cX8rI9BI=;
 b=3z3PCSGclefQ4LpvYcbkHgmE17VTAIxn7p88sDPSgDAyJlp8ftvFgYbvY935aECFzKURwzN9rrorPLr7OUP4qjGF00EUG+LCQKXyZ8sPczt8hgnjmBFa4RBshYPLZib81Nwdjmy4MdyGhJTte+17ZVog0hgMi1bgWtv8rpq5lHU=
Received: from MWHPR12CA0037.namprd12.prod.outlook.com (2603:10b6:301:2::23)
 by MWHPR12MB1630.namprd12.prod.outlook.com (2603:10b6:301:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 15:50:26 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::62) by MWHPR12CA0037.outlook.office365.com
 (2603:10b6:301:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend
 Transport; Tue, 6 Apr 2021 15:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 15:50:26 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:50:24 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     <rsaripal@amd.com>
Subject: [PATCH 2/5] x86/speculation: Implement support for PSFD detection and reporting
Date:   Tue, 6 Apr 2021 10:50:01 -0500
Message-ID: <20210406155004.230790-3-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406155004.230790-1-rsaripal@amd.com>
References: <20210406155004.230790-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65d8dbb5-1bec-4992-2711-08d8f913b233
X-MS-TrafficTypeDiagnostic: MWHPR12MB1630:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1630283C6B0F90C4525F3C279B769@MWHPR12MB1630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwHV9oJd4qyQvaGPgc8ss2CzZbZan1FhyBspcw/vTOkBwLfX8/jJpDcNQarnGg4r0yjM21QV9KABQv6YKZgxW7hqzPN1TSavAdKFnYYmFbf+SKINjkiEaTl+iI9GpHFewGecYRm61dLCO8hAeWW6QzSyosZ+v90YeZa9xRd8+H3hjpbA1HPuOfTgvLZnufqohVM78hNHz3ixdOtG+7L+T4LdBMPp5ddkGPbZT0ibOCzPAmiFb++BRu3nFF15L++m5zwOTDlxeto+2/DM+OQHS4B8/V9+0ypS0jjkg1izKKdiLWxMLli+3Ufwylgsq6NZ2GpJ4p4YpeQVZPUFMtgWinjnvmTeDrqW+hRXmITvd/02h/11676HPWvpPkKYtYnIZX2mbBgimTd4TAYBsqUoBg8BLClG70GHnr6jnVR/2SIWN4oYhg+c3dRMcgHiZYkNOFdOFU+ArVCGO9t0/tKsyDjN8zc52/p7ESuuwP+9NL443PAXzgOLsAcrrbJVajKpQPTUj6WhNb/hAq52WwVADuOIgOPiTNWKxJhO6bCs2k9Irl1uq1K5MYXJ4cA3Wcg3qdVTSZdeANLYh40IKk8UinUAXYP6MCblEH8D8v6hbg6T/kY2CSD2+ZHJblDXq1kHTRO59/h8tTGNwXVs2JvXQ1M/0fBbNA2Q+RiiZvtLE2v0fbSKKZrH/2OOVvZUoNnD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966006)(36840700001)(82310400003)(356005)(82740400003)(110136005)(36860700001)(1076003)(336012)(426003)(2906002)(2616005)(70586007)(7696005)(36756003)(47076005)(8936002)(4326008)(478600001)(5660300002)(26005)(83380400001)(16526019)(6666004)(70206006)(316002)(81166007)(8676002)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:50:26.0727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d8dbb5-1bec-4992-2711-08d8f913b233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1630
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

All AMD processors that support Predictive Store Forwarding (PSF)
provide a CPUID bit to detect support for mitigation of this
feature. This bit is referred to as PSFD (Predictive Store Forwarding
Disable)

If CPU advertises PSFD:
- Advertise a generic feature (X86_FEATURE_PSFD) in Linux capability
flags to indicate PSF mitigation is available.

- Advertise X86_BUG_PSF in Linux bug bits to indicate that CPU is
affected by PSF security risks.

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 arch/x86/kernel/cpu/common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ab640abe26b6..4e604d58f3b3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -893,6 +893,9 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
 		clear_cpu_cap(c, X86_FEATURE_VIRT_SSBD);
 	}
+
+	if (cpu_has(c, X86_FEATURE_AMD_PSFD))
+		set_cpu_cap(c, X86_FEATURE_PSFD);
 }
 
 void get_cpu_cap(struct cpuinfo_x86 *c)
@@ -1154,6 +1157,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
+	if (cpu_has(c, X86_FEATURE_AMD_PSFD))
+		setup_force_cpu_bug(X86_BUG_PSF);
+
 	if (ia32_cap & ARCH_CAP_IBRS_ALL)
 		setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
 
-- 
2.25.1

