Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB84386CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbhEQWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:02:54 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:59264
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238885AbhEQWCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:02:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNv2YlVyup+X8wyRWNXY/ao6TZ+e/IiwfGcpx8KaOdx+fCkpZxQdGb1AMEYlJeKRGb3kZNi5k/19ifyzoJ1pG6Lf1i/elyaKbGGHqUTBAqeACy2e5CVr90858aVKDvqAqUdFNIKmaUbvuVMhjHzlNLvpLR+79WfHNC4kEMI4fvPof9CZdIEaqyrm5FkATsQ9NjQQH0WpZW2KK1gBVtFcTXvP9iioPSz1K2iqO/T8V5xiEzJvNdMsgCPDlgof0Mc8dbLRRI7Ixu3KLexOSOzps9O5NLGZ7r8+2K4LNJZy6rkB1eMJPjHQm/hDVaK58OwlFBmfFlf0NSILgK9fUOoTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWtYUhujm0H6uu7/HeyMyrFy3os2LDg5KaThvKxQ0G0=;
 b=bMXWy/LztG6+D6GDQeoMCbUkZvbRdrFt9ZS6euYoIiBOj3w3+zYnGgv5/U5EREtqVQdurpkt1eAHIZJ7qmDOCZEsNHjWk5gNgUL4EiBghGrFm/HyiYth3Q3MaDWd+hsgtl/sC4cezylJiMmZvsh+xulv/Rgu5z4FHpvQITfVBPmjDAaVpfxwdZpasoyj4xsP0xGOW/FlvLe4r89XyJAdLu2I9eOsR2RbcxZgCVHcZyk3CDJaWnEFjvX6a9EwP1bdpQqYGkhjio3KtlGx7Yh7elIRjh3AW7M392GFK1SsEPI3Zxf4hZRdDD/Z9er+Vh64AGdVF0J7KIFWf06BXDzE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWtYUhujm0H6uu7/HeyMyrFy3os2LDg5KaThvKxQ0G0=;
 b=h/qMIEoA3HsNp77R0n6a0h7Qz/cOnXLmWdSSCuyDUz9pnS6JltgFxytd1O6PgdGe79KAojgDuEJFWDg7P5PTxAqBa8F26ZV1MWo6Tkbl9wT78Lzz+0EyNdSYlegmbuRYzwKmk+DP6hr153RK3qU20jLoH+6/dtz7kh9HX2xqSFA=
Received: from DM5PR06CA0072.namprd06.prod.outlook.com (2603:10b6:3:37::34) by
 BYAPR12MB4600.namprd12.prod.outlook.com (2603:10b6:a03:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 22:01:25 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::8c) by DM5PR06CA0072.outlook.office365.com
 (2603:10b6:3:37::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 22:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 22:01:25 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 17:01:23 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store Forwarding
Date:   Mon, 17 May 2021 17:00:58 -0500
Message-ID: <20210517220059.6452-2-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517220059.6452-1-rsaripal@amd.com>
References: <20210517220059.6452-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d65129c-ebb6-4f2f-752f-08d9197f508e
X-MS-TrafficTypeDiagnostic: BYAPR12MB4600:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4600F853BF34FF7E20C1B7EF9B2D9@BYAPR12MB4600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEKzm09g1gScWYpTTmVjYzPOtRiGB4TlBzk8fytwJI0Fr4jXzrjU76v9Sq/0pvBF46MY1PDcvXjKZeeulKwCSciHfDP6JuGxPLh78f3Aa83RsA1NhtdNnI+ZoFz5wpL9cBpOSGEueE+u7FheyLrVchTHZiuC2ehTCq8kvm2Rr3oF0My6zIef4yQ3qTJ077WJSgE9+RRBHuTzMhs5PU/Ll0zSd+dTet+OdBjgInsOvdFN9TsacAxKTO093FH06X3rfRkHyBdfzNRYHJosxG+yKjK8IA0fc2K/40ZAzVs7Gqwlohcy1OaLBAEfAcvrCw7dCht/JoBIMIZx2/NNWrGplZFwsJSFmEJjjvjuhw4oQlQbaQdVdUk+uf/l/znfFjDDDF0RHLu/ZjPix81jyu95buy5ldrG/ZteWj3+PM0HXliWZdNRQ8YO4dZfir/8p9taTInDWIebG9ivkcntLtXDQ9gJoft8zPw1IlvnSzBiz8gziDmPanPCm/DFojSlYtrWKWCiTzg+a7BrK+TTBLIpmn41DKjOr1/ABgi0YxDilCb/ghAD83vq2b2oKcMa1P9mxI7YsSQNQ0jI2MxgSZWgMk/voq902WkSdVJQPAJls63d/VuEPtUxREF0noTmy6FLT9FBSEvDAGBiYHT+wjPFad6JXXtYHUJ21pvDYs/F/sp0DdC+r2yakU8qHs1TWCrg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(82740400003)(186003)(36860700001)(110136005)(16526019)(54906003)(2616005)(478600001)(47076005)(316002)(356005)(426003)(4326008)(5660300002)(36756003)(8936002)(70206006)(83380400001)(70586007)(8676002)(2906002)(81166007)(1076003)(336012)(6666004)(7696005)(26005)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 22:01:25.1670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d65129c-ebb6-4f2f-752f-08d9197f508e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4600
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
	predictive_store_fwd_disable.

Kernel parameter predictive_store_fwd_disable has the following values

- on. Disable PSF on all CPUs.

- off. Enable PSF on all CPUs.
       This is also the default setting.

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  2 +
 arch/x86/include/asm/nospec-branch.h          |  6 ++
 arch/x86/kernel/cpu/bugs.c                    | 94 +++++++++++++++++++
 5 files changed, 108 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..a5f694dccb24 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3940,6 +3940,11 @@
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
+	predictive_store_fwd_disable=	[X86] This option controls PSF.
+			off - Turns on PSF.
+			on  - Turns off PSF.
+			default : off.
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
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index cb9ad6b73973..1231099e5c07 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -198,6 +198,12 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_SECCOMP,
 };
 
+/* The Predictive Store forward control variant */
+enum psf_mitigation {
+	PREDICTIVE_STORE_FORWARD_NONE,
+	PREDICTIVE_STORE_FORWARD_DISABLE,
+};
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..c80ef4d86b72 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -38,6 +38,7 @@
 static void __init spectre_v1_select_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
+static void __init psf_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_print_mitigation(void);
@@ -107,6 +108,7 @@ void __init check_bugs(void)
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
 	ssb_select_mitigation();
+	psf_select_mitigation();
 	l1tf_select_mitigation();
 	mds_select_mitigation();
 	taa_select_mitigation();
@@ -1195,6 +1197,98 @@ static void ssb_select_mitigation(void)
 		pr_info("%s\n", ssb_strings[ssb_mode]);
 }
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"Predictive Store Forward: " fmt
+
+static enum psf_mitigation psf_mode __ro_after_init = PREDICTIVE_STORE_FORWARD_NONE;
+
+/* The kernel command line selection */
+enum psf_mitigation_cmd {
+	PREDICTIVE_STORE_FORWARD_CMD_NONE,
+	PREDICTIVE_STORE_FORWARD_CMD_ON,
+};
+
+static const char * const psf_strings[] = {
+	[PREDICTIVE_STORE_FORWARD_NONE]		= "Vulnerable",
+	[PREDICTIVE_STORE_FORWARD_DISABLE]	= "Mitigation: Predictive Store Forward disabled",
+};
+
+static const struct {
+	const char *option;
+	enum psf_mitigation_cmd cmd;
+} psf_mitigation_options[]  __initconst = {
+	{ "on",		PREDICTIVE_STORE_FORWARD_CMD_ON },      /* Disable Speculative Store Bypass */
+	{ "off",	PREDICTIVE_STORE_FORWARD_CMD_NONE },    /* Don't touch Speculative Store Bypass */
+};
+
+static enum psf_mitigation_cmd __init psf_parse_cmdline(void)
+{
+	enum psf_mitigation_cmd cmd = PREDICTIVE_STORE_FORWARD_CMD_NONE;
+	char arg[20];
+	int ret, i;
+
+	ret = cmdline_find_option(boot_command_line, "predictive_store_fwd_disable",
+				  arg, sizeof(arg));
+	if (ret < 0)
+		return PREDICTIVE_STORE_FORWARD_CMD_NONE;
+
+	for (i = 0; i < ARRAY_SIZE(psf_mitigation_options); i++) {
+		if (!match_option(arg, ret, psf_mitigation_options[i].option))
+			continue;
+
+		cmd = psf_mitigation_options[i].cmd;
+		break;
+	}
+
+	if (i >= ARRAY_SIZE(psf_mitigation_options)) {
+		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
+		return PREDICTIVE_STORE_FORWARD_CMD_NONE;
+	}
+
+	return cmd;
+}
+
+static enum psf_mitigation __init __psf_select_mitigation(void)
+{
+	enum psf_mitigation mode = PREDICTIVE_STORE_FORWARD_NONE;
+	enum psf_mitigation_cmd cmd;
+
+	if (!boot_cpu_has(X86_FEATURE_PSFD))
+		return mode;
+
+	cmd = psf_parse_cmdline();
+
+	switch (cmd) {
+	case PREDICTIVE_STORE_FORWARD_CMD_ON:
+		mode = PREDICTIVE_STORE_FORWARD_DISABLE;
+		break;
+	default:
+		mode = PREDICTIVE_STORE_FORWARD_NONE;
+		break;
+	}
+
+	x86_spec_ctrl_mask |= SPEC_CTRL_PSFD;
+
+	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
+		mode = PREDICTIVE_STORE_FORWARD_DISABLE;
+
+	if (mode == PREDICTIVE_STORE_FORWARD_DISABLE) {
+		setup_force_cpu_cap(X86_FEATURE_PSFD);
+		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+	}
+
+	return mode;
+}
+
+static void psf_select_mitigation(void)
+{
+	psf_mode = __psf_select_mitigation();
+
+	if (boot_cpu_has(X86_FEATURE_PSFD))
+		pr_info("%s\n", psf_strings[psf_mode]);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Speculation prctl: " fmt
 
-- 
2.25.1

