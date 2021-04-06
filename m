Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B203035587E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346035AbhDFPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:50:47 -0400
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:52769
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346007AbhDFPuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfNHlfhA3cYAYmffze5YBX8aQoZ185SfrTuXFLoikDiUmxm5/GlxkgTqlhWJ6lvdAOzSNIbSIgYJZDhM2xp3NBBpdtAZusQJfEHSAsINObXtDkxIJf6B/71I/LUhcoocKl/g6B6jwP4Qly7u3dNeBkOQLwTfhCuz9GptGDIrAIHxyaKuUSWfAqDS/cRoiNMGJ4UvWTOOM3fq+w7ulgAhxV71moCt4SNoB1QJJKDX+G7oooENEbgRwpLicf7QHMcWYw4K5sNCiZwJdZKoG8/zX6I3OBqTc7y7NXrSHt2yy+E+hqW2uYlGyRzwBFBBzBZLLfLcZiy0YLoMR8yrWff1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lED4KbfFlAAJGEk9ayVCzURAIRezfup+lEuc8ochtmQ=;
 b=J1uejDtjNptAUg6GUVz5ycyfze/MQaKkC6ol1iX24xy9OMHRLbWzpMykZNq/E2KUYFBJ4/KcJO+N/0SBeoTeVbHfTYRtYeZJZn6eU2wMRUiddXQI4NJ8iUdTZay910tNU55rOtQRPUtW0UtAVYuMSmc0F7FOHy9RlobelL3X/80w/BJGz/Wo0oAQGBXraDGVdE++va2+VdLjNflDDKeY8K6w3wGhP3RHzNMi0fMlrb477AksBQ/g6j8tvoCSMEZ/kRAmQvbPQlMnYCH8Gd6S6WY/C+Xl3eR0SW6jiqk5AvuqoY5055lkVyUF2gbsuUlkEX0YI64seBe3huKTMGkleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lED4KbfFlAAJGEk9ayVCzURAIRezfup+lEuc8ochtmQ=;
 b=18L/GSuzP+fEiwaX2ZzeZ27vGCKAJqs9gyiFwdW1rnEOogHcc2y/UWlbfow1Q/snX00kHL2u3aO+t4FMr334/2xz/KwyRTmUBblwA0M6uiFNzjHD77/DOP4jabMgmIgIZIon+3NQBpQakSwduViBrQXJzPjxI7DhwWf6vQPdyAA=
Received: from MWHPR12CA0041.namprd12.prod.outlook.com (2603:10b6:301:2::27)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 15:50:27 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::1a) by MWHPR12CA0041.outlook.office365.com
 (2603:10b6:301:2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 15:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 15:50:27 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:50:25 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     <rsaripal@amd.com>
Subject: [PATCH 4/5] x86/speculation: Implement PSF mitigation support
Date:   Tue, 6 Apr 2021 10:50:03 -0500
Message-ID: <20210406155004.230790-5-rsaripal@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1074288f-55d1-4308-d0eb-08d8f913b2ed
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28929CA8B38986ED29F24B7B9B769@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ca2sCvSCo5F0LogcblLQ/0XdpoISTfzF7/X4MBjVzFhJcbCVUPa409xSJzIA7xobCEh5eWAJiPAdrzDjD0eu4U0yW+Jcz9CMOMVP6yj5o8DzUTu5TP14OJOnpmPcwccY0Ar9h73hlCcJdup8Csi7QkLq1a3XEq8yGIGK7iec1lMiokPvfejI6TLrW2/KOeJAQcZGTN0oAiG/UlvdZm3u6eZIe0Qkao9PWaBIk236sVlsQM2/TPwmIMwid9Em18c677Y/lxCco1sOxxqKstNNYKOvF2lcCtCBIMClKsKFVDAZdEHllhbbYDL2JMtAyMnAvqx1kYddl8X7z3U3VLXc/sCoCEnWv9QYMhgFlCyom5gFbvmX6av6pgiKtfwd4w/YhFwobf+vZ0Ph1cdVMDodjjiFaV9tUSNXnlWtALJa6LRrcV3z4hDR/71nW8URdwpSlZcdoDYyHKnP2jOVnMJ3Qm3dZqldTHGP/kPd0BGk3QDplSn6vXBhxlb15dUvTYYbtH1H2Jvf2MDAcgZ+0rEmpbw77Uani4v5TJN/mkaMsaAnvA+z4WevwBJlIRGt7TgkWPorWRGMPLpcP8F5R5TIC9Hel4ZjiTOLADUU7x3gEidaLJB4qwkorbwfDrMmKhsvSnUn92y0uH8Z0YmzJzBh06Qqjhr0BO5SDx96dVNoZvwsLaHAxQ9qIk9/jgYzLnTB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(426003)(2616005)(336012)(8676002)(6666004)(356005)(81166007)(36756003)(47076005)(2906002)(26005)(82740400003)(16526019)(82310400003)(110136005)(8936002)(4326008)(70206006)(70586007)(83380400001)(36860700001)(478600001)(7696005)(1076003)(316002)(186003)(5660300002)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:50:27.2940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1074288f-55d1-4308-d0eb-08d8f913b2ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

Implement support for PSF mitigation via kernel parameters.

On AMD processors that support Predictive Store Forwarding(PSF),
the disabling of Speculative Store Bypass(SSB) will also disable PSF.

Two kernel parameters are being introduced to enable PSF
mitigation.

Behavior and implementation of these parameters is similar to
spec_control_bypass_disable kernel parameter.

nopsfd: Disable all mitigations for Predictive Store
		Forwarding.

	This parameter has no values.

psfd: This parameter has five possible values.
	on
		Unconditionally disable Predictive Store Forwarding.

	off
		Unconditionally enable Predictive Store Forwarding.

	auto
		Kernel detects whether CPU is vulnerable
		If CPU is not vulnerable, off is selected
		If CPU is vulnerable, default mitigation is
			KConfig dependent.

	prctl
		Control Predictive Store Forwarding per thread
		via prctl.

	seccomp
		Same as prctl above but all seccomp threads will
		disable PSF unless they opt out

	Default mitigation:
	If CONFIG_SECCOMP=y "seccomp" else "prctl"

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 arch/x86/include/asm/nospec-branch.h |   8 ++
 arch/x86/include/asm/spec-ctrl.h     |  12 ++
 arch/x86/include/asm/thread_info.h   |   2 +
 arch/x86/kernel/cpu/bugs.c           | 191 +++++++++++++++++++++++++++
 arch/x86/kernel/process.c            |  23 ++++
 include/linux/sched.h                |  15 +++
 include/uapi/linux/prctl.h           |   2 +
 7 files changed, 253 insertions(+)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index cb9ad6b73973..7ac27aaef110 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -198,6 +198,14 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_SECCOMP,
 };
 
+/* The Predictive Store Forwarding disable variants */
+enum psf_mitigation {
+	PREDICTIVE_STORE_FORWARD_NONE,
+	PREDICTIVE_STORE_FORWARD_DISABLE,
+	PREDICTIVE_STORE_FORWARD_PRCTL,
+	PREDICTIVE_STORE_FORWARD_SECCOMP,
+};
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index 5393babc0598..eefab0707931 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -76,6 +76,18 @@ static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
 }
 
+static inline u64 psfd_tif_to_spec_ctrl(u64 tifn)
+{
+	BUILD_BUG_ON(TIF_PSFD < SPEC_CTRL_PSFD_SHIFT);
+	return (tifn & _TIF_PSFD) >> (TIF_PSFD - SPEC_CTRL_PSFD_SHIFT);
+}
+
+static inline unsigned long psfd_spec_ctrl_to_tif(u64 spec_ctrl)
+{
+	BUILD_BUG_ON(TIF_PSFD < SPEC_CTRL_PSFD_SHIFT);
+	return (spec_ctrl & SPEC_CTRL_PSFD) << (TIF_PSFD - SPEC_CTRL_PSFD_SHIFT);
+}
+
 #ifdef CONFIG_SMP
 extern void speculative_store_bypass_ht_init(void);
 #else
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 0d751d5da702..d65bf27956f3 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -80,6 +80,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_PSFD		8	/* Predictive Store Forward disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -103,6 +104,7 @@ struct thread_info {
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
+#define _TIF_PSFD		(1 << TIF_PSFD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..1e0eca761759 100644
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
@@ -1195,6 +1197,129 @@ static void ssb_select_mitigation(void)
 		pr_info("%s\n", ssb_strings[ssb_mode]);
 }
 
+#undef pr_fmt
+#define pr_fmt(fmt)     "Predictive Store Forwarding: " fmt
+
+static enum psf_mitigation psf_mode __ro_after_init = PREDICTIVE_STORE_FORWARD_NONE;
+
+enum psf_mitigation_cmd {
+	PREDICTIVE_STORE_FORWARD_CMD_NONE,
+	PREDICTIVE_STORE_FORWARD_CMD_AUTO,
+	PREDICTIVE_STORE_FORWARD_CMD_ON,
+	PREDICTIVE_STORE_FORWARD_CMD_PRCTL,
+	PREDICTIVE_STORE_FORWARD_CMD_SECCOMP,
+};
+
+static const char * const psf_strings[] = {
+	[PREDICTIVE_STORE_FORWARD_NONE]		= "Vulnerable",
+	[PREDICTIVE_STORE_FORWARD_DISABLE]	= "Mitigation: Predictive Store Forwarding disabled",
+	[PREDICTIVE_STORE_FORWARD_PRCTL]	= "Mitigation: Predictive Store Forwarding disabled via prctl",
+	[PREDICTIVE_STORE_FORWARD_SECCOMP]	= "Mitigation: Predictive Store Forwarding disabled via prctl and seccomp",
+};
+
+static const struct {
+	const char *option;
+	enum psf_mitigation_cmd cmd;
+} psf_mitigation_options[]  __initconst = {
+	{ "auto",	PREDICTIVE_STORE_FORWARD_CMD_AUTO },    /* Platform decides */
+	{ "on",		PREDICTIVE_STORE_FORWARD_CMD_ON },      /* Disable Predictive Store Forwarding*/
+	{ "off",	PREDICTIVE_STORE_FORWARD_CMD_NONE },    /* Don't touch Predictive Store Forwarding */
+	{ "prctl",	PREDICTIVE_STORE_FORWARD_CMD_PRCTL },   /* Disable Predictive Store Forwarding via prctl */
+	{ "seccomp",	PREDICTIVE_STORE_FORWARD_CMD_SECCOMP }, /* Disable Predictive Store Forwarding via prctl and seccomp */
+};
+
+static enum psf_mitigation_cmd __init psf_parse_cmdline(void)
+{
+	enum psf_mitigation_cmd cmd = PREDICTIVE_STORE_FORWARD_CMD_AUTO;
+	char arg[20];
+	int ret, i;
+
+	if (cmdline_find_option_bool(boot_command_line, "nopsfd") ||
+	    cpu_mitigations_off()) {
+		return PREDICTIVE_STORE_FORWARD_CMD_NONE;
+	} else {
+		ret = cmdline_find_option(boot_command_line, "psfd",
+					  arg, sizeof(arg));
+		if (ret < 0)
+			return PREDICTIVE_STORE_FORWARD_CMD_AUTO;
+
+		for (i = 0; i < ARRAY_SIZE(psf_mitigation_options); i++) {
+			if (!match_option(arg, ret, psf_mitigation_options[i].option))
+				continue;
+
+			cmd = psf_mitigation_options[i].cmd;
+			break;
+		}
+
+		if (i >= ARRAY_SIZE(psf_mitigation_options)) {
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
+			return PREDICTIVE_STORE_FORWARD_CMD_AUTO;
+		}
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
+	if (!boot_cpu_has_bug(X86_BUG_PSF) &&
+	    (cmd == PREDICTIVE_STORE_FORWARD_CMD_NONE ||
+	     cmd == PREDICTIVE_STORE_FORWARD_CMD_AUTO))
+		return mode;
+
+	switch (cmd) {
+	case PREDICTIVE_STORE_FORWARD_CMD_AUTO:
+	case PREDICTIVE_STORE_FORWARD_CMD_SECCOMP:
+		/*
+		 * Choose prctl+seccomp as the default mode if seccomp is
+		 * enabled.
+		 */
+		if (IS_ENABLED(CONFIG_SECCOMP))
+			mode = PREDICTIVE_STORE_FORWARD_SECCOMP;
+		else
+			mode = PREDICTIVE_STORE_FORWARD_PRCTL;
+		break;
+	case PREDICTIVE_STORE_FORWARD_CMD_ON:
+		mode = PREDICTIVE_STORE_FORWARD_DISABLE;
+		break;
+	case PREDICTIVE_STORE_FORWARD_CMD_PRCTL:
+		mode = PREDICTIVE_STORE_FORWARD_PRCTL;
+		break;
+	case PREDICTIVE_STORE_FORWARD_CMD_NONE:
+		break;
+	}
+
+	x86_spec_ctrl_mask |= SPEC_CTRL_PSFD;
+
+	/*
+	 * Disabling SSB automatically disables PSF on AMD processors.
+	 */
+	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE &&
+	    boot_cpu_has(X86_FEATURE_AMD_PSFD))
+		mode = PREDICTIVE_STORE_FORWARD_DISABLE;
+
+	if (mode == PREDICTIVE_STORE_FORWARD_DISABLE) {
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
+	if (boot_cpu_has_bug(X86_BUG_PSF))
+		pr_info("%s\n", psf_strings[psf_mode]);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Speculation prctl: " fmt
 
@@ -1215,6 +1340,45 @@ static void task_update_spec_tif(struct task_struct *tsk)
 		speculation_ctrl_update_current();
 }
 
+static int psf_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+	if (psf_mode != PREDICTIVE_STORE_FORWARD_PRCTL &&
+	    psf_mode != PREDICTIVE_STORE_FORWARD_SECCOMP)
+		return -ENXIO;
+
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		/* If speculation is force disabled, enable is not allowed */
+		if (task_spec_psf_force_disable(task))
+			return -EPERM;
+		task_clear_spec_psf_disable(task);
+		task_clear_spec_psf_noexec(task);
+		task_update_spec_tif(task);
+		break;
+	case PR_SPEC_DISABLE:
+		task_set_spec_psf_disable(task);
+		task_clear_spec_psf_noexec(task);
+		task_update_spec_tif(task);
+		break;
+	case PR_SPEC_FORCE_DISABLE:
+		task_set_spec_psf_disable(task);
+		task_set_spec_psf_force_disable(task);
+		task_clear_spec_psf_noexec(task);
+		task_update_spec_tif(task);
+		break;
+	case PR_SPEC_DISABLE_NOEXEC:
+		if (task_spec_psf_force_disable(task))
+			return -EPERM;
+		task_set_spec_psf_disable(task);
+		task_set_spec_psf_noexec(task);
+		task_update_spec_tif(task);
+		break;
+	default:
+		return -ERANGE;
+	}
+	return 0;
+}
+
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
@@ -1324,6 +1488,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 		return ssb_prctl_set(task, ctrl);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_set(task, ctrl);
+	case PR_SPEC_PSF:
+		return psf_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -1334,12 +1500,35 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
 	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
 		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+	if (psf_mode == PREDICTIVE_STORE_FORWARD_SECCOMP)
+		psf_prctl_set(task, PR_SPEC_FORCE_DISABLE);
 	if (spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
 	    spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP)
 		ib_prctl_set(task, PR_SPEC_FORCE_DISABLE);
 }
 #endif
 
+static int psf_prctl_get(struct task_struct *task)
+{
+	switch (psf_mode) {
+	case PREDICTIVE_STORE_FORWARD_DISABLE:
+		return PR_SPEC_DISABLE;
+	case PREDICTIVE_STORE_FORWARD_SECCOMP:
+	case PREDICTIVE_STORE_FORWARD_PRCTL:
+		if (task_spec_psf_force_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (task_spec_psf_noexec(task))
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE_NOEXEC;
+		if (task_spec_psf_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	default:
+		if (boot_cpu_has_bug(X86_BUG_PSF))
+			return PR_SPEC_ENABLE;
+		return PR_SPEC_NOT_AFFECTED;
+	}
+}
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -1390,6 +1579,8 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 		return ssb_prctl_get(task);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_get(task);
+	case PR_SPEC_PSF:
+		return psf_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9c214d7085a4..5916b02e57f7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -322,6 +322,18 @@ void arch_setup_new_exec(void)
 		task_clear_spec_ssb_noexec(current);
 		speculation_ctrl_update(task_thread_info(current)->flags);
 	}
+
+	/*
+	 * Don't inherit TIF_PSFD across exec boundary when
+	 * PR_SPEC_DISABLE_NOEXEC is used.
+	 */
+	if (test_thread_flag(TIF_PSFD) &&
+	    task_spec_psf_noexec(current)) {
+		clear_thread_flag(TIF_PSFD);
+		task_clear_spec_psf_disable(current);
+		task_clear_spec_psf_noexec(current);
+		speculation_ctrl_update(task_thread_info(current)->flags);
+	}
 }
 
 #ifdef CONFIG_X86_IOPL_IOPERM
@@ -547,6 +559,12 @@ static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 		msr |= ssbd_tif_to_spec_ctrl(tifn);
 	}
 
+	/* Handle change of TIF_PSFD if CPU supports PSFD */
+	if (static_cpu_has(X86_FEATURE_PSFD)) {
+		updmsr |= !!(tif_diff & _TIF_PSFD);
+		msr |= psfd_tif_to_spec_ctrl(tifn);
+	}
+
 	/* Only evaluate TIF_SPEC_IB if conditional STIBP is enabled. */
 	if (IS_ENABLED(CONFIG_SMP) &&
 	    static_branch_unlikely(&switch_to_cond_stibp)) {
@@ -570,6 +588,11 @@ static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
 			set_tsk_thread_flag(tsk, TIF_SPEC_IB);
 		else
 			clear_tsk_thread_flag(tsk, TIF_SPEC_IB);
+
+		if (task_spec_psf_disable(tsk))
+			set_tsk_thread_flag(tsk, TIF_PSFD);
+		else
+			clear_tsk_thread_flag(tsk, TIF_PSFD);
 	}
 	/* Return the updated threadinfo flags*/
 	return task_thread_info(tsk)->flags;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef00bb22164c..54ac4cfb1086 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1622,6 +1622,10 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
 #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
 #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
+#define PFA_SPEC_PSF_DISABLE		8	/* Predictive Store Forwarding disabled */
+#define PFA_SPEC_PSF_FORCE_DISABLE	9	/* Predictive Store Forwarding force disabled */
+#define PFA_SPEC_PSF_NOEXEC		10	/* Predictive Store Forwarding clear on execve */
+
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1664,6 +1668,17 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
 TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
 TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
 
+TASK_PFA_TEST(SPEC_PSF_DISABLE, spec_psf_disable)
+TASK_PFA_SET(SPEC_PSF_DISABLE, spec_psf_disable)
+TASK_PFA_CLEAR(SPEC_PSF_DISABLE, spec_psf_disable)
+
+TASK_PFA_TEST(SPEC_PSF_NOEXEC, spec_psf_noexec)
+TASK_PFA_SET(SPEC_PSF_NOEXEC, spec_psf_noexec)
+TASK_PFA_CLEAR(SPEC_PSF_NOEXEC, spec_psf_noexec)
+
+TASK_PFA_TEST(SPEC_PSF_FORCE_DISABLE, spec_psf_force_disable)
+TASK_PFA_SET(SPEC_PSF_FORCE_DISABLE, spec_psf_force_disable)
+
 static inline void
 current_restore_flags(unsigned long orig_flags, unsigned long flags)
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 667f1aed091c..eb8378ccf580 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -213,6 +213,8 @@ struct prctl_mm_map {
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
 # define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_PSF			2 /* Predictive Store Forwarding */
+
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
-- 
2.25.1

