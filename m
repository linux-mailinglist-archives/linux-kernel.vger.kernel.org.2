Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CFE35587C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346005AbhDFPug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:50:36 -0400
Received: from mail-mw2nam08on2075.outbound.protection.outlook.com ([40.107.101.75]:42145
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243860AbhDFPuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:50:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NC9BJWUwq7mBD6kFWRn7u329QFGaEHin+VcMEHSApW/uqSsYfvouV+nfdtG/pNaAdSUoPNNBz4JvqWkiK886riuS6Q8+rcojqkFHGYT9cf5++TtV9lWiciDH2DxMNuJ1vUnsG9cOAej05vaIIoyK2anFbkyNmOZbv1VUo1iVmgagNOCf8WaZCtyC05jP885YUIOwc+R3zZV3+gPUs4YqFHP4N2q5WqZyEGU6MVxzCUOOLZa74wNSA8FUHLk4Fba7UdWjqwwO90l7ghmFxJbNDVcm1GtbVRs/Ssamqh1uf3c9hug/nEO8CV5zO/2dawxKkBAwJTFzbYOvFXbAfaBwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9mRExYaYEF/WFCDwwyEd5kszxxyikTsf/8lkPGlg+k=;
 b=dmifRYivmQrDME5ydtjoXwbzWcTJ6/xAYXAIBTzsVDHl96pKTYHQhKUb9dF7EHx0+a5lD/uLXeeiD+0hGfLn+P50+lR4+hN44HY1qtEYoDOoKTyQQPU4jFL/S26yKJpXj8Pa+NICd5zPeXHY4M52eIT0ePJSMTOb9fuzpn6D0Wh/DgoGmTjVMVwnPGCZnY+DqCqYVDf8BlToqx0rtDrAQY2clr75vmVMhau5gbOCAK6j6WsBPciLhV6gnDuTFXyn89pADYOKPj6LOQGQZ2kjN+/1gpEPC2saHAyrJ37QOE/Z9pnfViQDaL/pI4AiZDTOM2aXlKf5g37/2eDePteylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9mRExYaYEF/WFCDwwyEd5kszxxyikTsf/8lkPGlg+k=;
 b=zuP/JOJxzUbJooHK9qkYwjMCacgQvQor/srdDnJpZMqAw8avM2puYQfPKzqQ2IcD52t+S2wYiYXSpRbpD15JTLDOqJxNa+eopSlPgRKPplSGMm9MHK6GmN4Pqux7RLh8vY8jAg0Qye8T4YvN4/uYA88TO2Mtbw9UryALnPjIb6k=
Received: from MWHPR12CA0046.namprd12.prod.outlook.com (2603:10b6:301:2::32)
 by DM6PR12MB3258.namprd12.prod.outlook.com (2603:10b6:5:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 15:50:25 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::57) by MWHPR12CA0046.outlook.office365.com
 (2603:10b6:301:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 15:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 15:50:25 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:50:23 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     <rsaripal@amd.com>
Subject: [PATCH 1/5] x86/cpufeatures: Define feature bits to support mitigation of PSF
Date:   Tue, 6 Apr 2021 10:50:00 -0500
Message-ID: <20210406155004.230790-2-rsaripal@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: af227774-5024-4d60-5555-08d8f913b1c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3258:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3258059B632748575BA819459B769@DM6PR12MB3258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uqcj/DXbw4uz+yts9ZPXv0zuvVuzk3NlOZ0jQg9StPbYmBlu+k/cAQCVGsbJtyUOPijB84n8W8r+eyETLSB4qznk2XgOXLv8D6Tr84Du3/8tIhoiYAIO8Xk3WXPLGT5F6Jo1MJj+ChG6Z1USGlWApzQhpwbkizc/HVc6KmCt1Q2slJQTmAMqiYUpmifXy/wIj3acUADMZTYtbLp28KipnyOHp/SbL+b36sOj2pJ5vQFN48MFs+YInBJjcP3FVk4SD/zlymdlpr6bDXUQODGQXZuLMlczcC/A24xQt9wFPd1RnOiLxdKK8q52RZ6sLnaOJ4XSaS5H504SkQamHP0m+XAIwiS3iPeqIsiuPgwzfa4Hn9vDgTAn8Rq3ZeZiqbLeZAg/mjfOqxz7s0+KbHjcxvGtYFcMqyR1w7AIa2CVZ32iPWofI4NM+hN1jI6oPmXt8hltBHaXhnhXYzKcjWYIedu7KrIeT9jZFXA1Ge5WuKu9FXOa/ACmg++zM5Dg+7ZNHaPUGBvCIawweWJxEW1Xlu/h4aS+kcjQK2D6ASrGV2oiw8prI/8MAgxjaQ4651jvrTK2dIOGh+Pi+wmG1o2/udKE+vYK6/i9b6RiviHw75nErh2VBtRoJK7tVmf01Mk05gElalKQxoxVhohp1Zw20Bs1LsDrv/oFY3NnREDuQNE0XPeKo1nzobxDyC3s+6A2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(2616005)(16526019)(478600001)(8936002)(7696005)(70586007)(36756003)(356005)(186003)(1076003)(6666004)(2906002)(36860700001)(26005)(47076005)(5660300002)(426003)(4326008)(336012)(83380400001)(110136005)(82310400003)(8676002)(82740400003)(316002)(81166007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:50:25.3661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af227774-5024-4d60-5555-08d8f913b1c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3258
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

Certain AMD processors feature a new technology called Predictive Store
Forwarding (PSF).

PSF is a micro-architectural optimization designed to improve the
performance of code execution by predicting dependencies between
loads and stores.

Incorrect PSF predictions can occur due to two reasons.

- It is possible that the load/store pair may have had dependency for
  a while but the dependency has stopped because the address in the
  load/store pair has changed.

- Second source of incorrect PSF prediction can occur because of an alias
  in the PSF predictor structure stored in the microarchitectural state.
  PSF predictor tracks load/store pair based on portions of instruction
  pointer. It is possible that a load/store pair which does have a
  dependency may be aliased by another load/store pair which does not have
  the same dependency. This can result in incorrect speculation.

  Software may be able to detect this aliasing and perform side-channel
  attacks.

These features are being introduced to support mitigation from these attacks.

All CPUs that implement PSF provide one bit to disable this feature.
If the bit to disable this feature is available, it means that the CPU
implements PSF feature and is therefore vulnerable to PSF risks.

The bits that are introduced

X86_FEATURE_AMD_PSFD: CPUID_Fn80000008_EBX[28] ("PSF disable")
	If this bit is 1, CPU implements PSF and PSF mitigation is
	supported.

X86_FEATURE_PSFD: Generic Linux feature to indicate the CPU supports
	controls to mitigate PSF.

 	X86_FEATURE_PSFD is set if and only if X86_FEATURE_AMD_PSFD
	is set

X86_BUG_PSF: Generic Linux feature to indicate that the CPU is affected
	by the PSF feature.

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26d69f7..21e7f8d0d7d9 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -201,7 +201,7 @@
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
-/* FREE!                                ( 7*32+10) */
+#define X86_FEATURE_PSFD		( 7*32+10) /* Predictive Store Forward Disable */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
@@ -309,6 +309,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_AMD_PSFD		(13*32+28) /* "" Predictive Store Forward Disable */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
@@ -428,5 +429,6 @@
 #define X86_BUG_TAA			X86_BUG(22) /* CPU is affected by TSX Async Abort(TAA) */
 #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
 #define X86_BUG_SRBDS			X86_BUG(24) /* CPU may leak RNG bits if not mitigated */
+#define X86_BUG_PSF			X86_BUG(25) /* CPU is affected by Predictive Store Forwarding attack */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.25.1

