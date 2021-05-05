Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0244374877
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 21:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhEETKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 15:10:36 -0400
Received: from mail-dm6nam10on2074.outbound.protection.outlook.com ([40.107.93.74]:23934
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231422AbhEETKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 15:10:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6tcqhztKmW2NbBLj178XrLiNF34uHXhdy1Jlf+NOLk5vuPiLKPo02isl8p/WUqaF2Momu76xX/lYYN3H7obL9RH9D35vCHQLfrSCGbO3WQrc4pYo1HfgGK6rHPu8NZ8ER6IQBSnvhBzyv1Tb1E3V6Unlv1/2Nuk7mXKPdLJ+hzC8WNBd1hBwv/npRYw0gviw5AucPPIu3yuN3U6QqzMoP0ubL5cMMeb49VIwzB1tyf8ETljqrVJnyhX3i/HtixRiuABANcwJFBUR2EB7P6QOkiU2iFbkFeG2txbOtzDEBtYCS64Zw9Zivh9qdV4GhtSAd3Zxi0LcZ2wv1Aom7RCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlr9rgtczr3YKjozbr900Ub4+a/dffl1HAuCmlL+O6U=;
 b=mNk6SxaelUt0zJpHihLX3cBrxAZZA6nyp/Z1wVe5dDfxyhpLcrf82ke3j3V1s05pagvio7YSLP7QsF+mZ4kJyS7POeLpa0sQZZHkix/K0gXdL75SzrrGU7k7iChxXdWgQItCFXDa00jR8XkJk6AM+lKIjTCFz8+6jemsGmU9ewYQxDqMobnhAiYsfYnF+2ZLMI9WqI+yckKrg9t2JpzYg1O73OsPreLVzMaNng6Z3Oqt4JcILosK6vCwm2WB7ewtzRKY10S8liW8+BclbNVJ3uR/EYuqI61zSGRtKrIso/+skyG/dSRJkBaeDyLDhKZkhH5ZW2uu7z1DAWQfnsGuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlr9rgtczr3YKjozbr900Ub4+a/dffl1HAuCmlL+O6U=;
 b=cAyk9Zr4P3R+yYF5vR5dV3382en3FrAT+GQSi3pLIy2WQRe2XHvbYBCINysrN2VHDqdPXXlBZsnC5KZ48Wj5RauIqkvziizmJDe3C7Nwn4xq5rx0DKZaLjul8xoboWd0TE2751UFUunsjwGpRmy3zZ1Qd4S/7988HyXDQFM6Bjo=
Received: from BN9PR03CA0336.namprd03.prod.outlook.com (2603:10b6:408:f6::11)
 by BYAPR12MB2776.namprd12.prod.outlook.com (2603:10b6:a03:67::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 19:09:36 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::99) by BN9PR03CA0336.outlook.office365.com
 (2603:10b6:408:f6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 5 May 2021 19:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 19:09:36 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 5 May 2021 14:09:35 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [PATCH v5 1/1] x86/cpufeatures: Implement Predictive Store Forwarding control.
Date:   Wed, 5 May 2021 14:09:23 -0500
Message-ID: <20210505190923.276051-2-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505190923.276051-1-rsaripal@amd.com>
References: <20210505190923.276051-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9b5423c-1574-4feb-4bb0-08d90ff95347
X-MS-TrafficTypeDiagnostic: BYAPR12MB2776:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27761F160C2219C49C94ACC59B599@BYAPR12MB2776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvf6rfWShsLGJWXPbTyKnWRbyqJLw3m0DuwZ69pjKP1J0mY1Qxx7zSdytkCjF/jg/ycTGIeGMvfn1+3VJMH5B6vJYEwnV1GVwMAl10K/9R5NXDSfrNb7qcewmWsmWZmhEOL16sOc5uoi3GvK4oXvJKdcj+dgELp+ZZoKxX17vy6i+D/82c25F7scSjwV/MU5+lVnDbxjgXNgY+TV/Tgp6EW0WndzTcFtVEvQyhPLz/t6L/rtiXWMgOLfnEbyQ0oz3bLzk6S/zJ3wIZy7wlKHZVozevZz7OXt6giB0oONT7BUiliWw1oRjjrNvMtX74Lgz/SW7t7PwDJ22i7jE6nbg6YL1fPZrwxyKwp4QRxm0BhvAnmdNWpyPsh3MsfMU3q12MKP+N2OsQYF9ZvVKHu/UwtUDn34EVYjOHaSpZFsYHGk8UA3LIy6Gkio+6uwZtDnxO5i2k5N9JJE9vYK94/1ouuDRQy5aPv6CPMnjWSQmFH6PsGDC2Y6gzam+QnBhWNfkTyIjQNmfdr80pw7Z2IGnPqM4AalbVtWl4jrcjEn9NSzB679+jqzPchMaaNTteESozdaeHGXHMRPjFsQDmcpsJbfZNlWMNpegXaYz0GW1XFghWSv00Z4BeoSdfX9sroLyP5Y5TnHxEUHJ8tu7hCZJxaLpwJS9z6BQG+pCkguZsnTLKGDBpdd0k3pf/9Wlyyl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(8936002)(1076003)(478600001)(82740400003)(2616005)(81166007)(2906002)(426003)(5660300002)(83380400001)(4326008)(82310400003)(356005)(7696005)(70206006)(70586007)(54906003)(47076005)(186003)(16526019)(6666004)(36756003)(110136005)(8676002)(36860700001)(26005)(316002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 19:09:36.7660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b5423c-1574-4feb-4bb0-08d90ff95347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2776
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

All CPUs that implement PSF provide one bit to disable this feature.
If the bit to disable this feature is available, it means that the CPU
implements PSF feature and is therefore vulnerable to PSF risks.

The bits that are introduced

X86_FEATURE_PSFD: CPUID_Fn80000008_EBX[28] ("PSF disable")
	If this bit is 1, CPU implements PSF and PSF control
	via SPEC_CTRL_MSR is supported in the CPU.

All AMD processors that support PSF implement a bit in
SPEC_CTRL MSR (0x48) to disable or enable Predictive Store
Forwarding.

PSF control introduces a new kernel parameter called
	predict_store_fwd.

Kernel parameter predict_store_fwd has the following values

- off. This value is used to disable PSF on all CPUs.

- on. This value is used to enable PSF on all CPUs.
        This is also the default setting.

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  2 ++
 arch/x86/kernel/cpu/amd.c                     | 19 +++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c                    |  6 +++++-
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..a4dd08bb0d3a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3940,6 +3940,11 @@
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
+	predict_store_fwd=	[X86] This option controls PSF.
+			off - Turns off PSF.
+			on  - Turns on PSF.
+			default : on.
+
 	preempt=	[KNL]
 			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
 			none - Limited to cond_resched() calls
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26d69f7..078f46022293 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -309,6 +309,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_PSFD		(13*32+28) /* Predictive Store Forward Disable */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ecf0a35..f569918c8754 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -51,6 +51,8 @@
 #define SPEC_CTRL_STIBP			BIT(SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
 #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
 #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
+#define SPEC_CTRL_PSFD_SHIFT		7
+#define SPEC_CTRL_PSFD			BIT(SPEC_CTRL_PSFD_SHIFT)	/* Predictive Store Forwarding Disable */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 347a956f71ca..2ae74b68c6d3 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1170,3 +1170,22 @@ void set_dr_addr_mask(unsigned long mask, int dr)
 		break;
 	}
 }
+
+static int __init psf_cmdline(char *str)
+{
+	if (!boot_cpu_has(X86_FEATURE_PSFD))
+		return 0;
+
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off")) {
+		set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
+		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
+		msr_set_bit(MSR_IA32_SPEC_CTRL, SPEC_CTRL_PSFD_SHIFT);
+	}
+
+	return 0;
+}
+
+early_param("predict_store_fwd", psf_cmdline);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..536136e0daa3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -78,6 +78,8 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
 
 void __init check_bugs(void)
 {
+	u64 tmp = 0;
+
 	identify_boot_cpu();
 
 	/*
@@ -97,7 +99,9 @@ void __init check_bugs(void)
 	 * init code as it is not enumerated and depends on the family.
 	 */
 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
+
+	x86_spec_ctrl_base |= tmp;
 
 	/* Allow STIBP in MSR_SPEC_CTRL if supported */
 	if (boot_cpu_has(X86_FEATURE_STIBP))
-- 
2.25.1

