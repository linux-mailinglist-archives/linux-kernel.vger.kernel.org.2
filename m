Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E083886EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbhESFrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347549AbhESFpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:45:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1EC06121B
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:39:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d78so8252020pfd.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PSJa7y6/DnltqxhMb5vziZablAP4Q7ASHGJlJsYN1PY=;
        b=hXhLmSuH7h9O3m2yudJEZ+lfS4g/HGeJJrychNJyxajN4zVtA2d4KUndMlnTEt4N+K
         5KFAaiMjgajCFAm995f445zRJT2Fx2OFmW4Wn985Avn2t9tUVdVgBf0bb/Dy5I+1LsjQ
         ZmGMk1TtJmiLGlcnG10zZF0WkyRcO+Hau+8nyNVZnlfQGCG7oIgP6I68vPhP4b0RF/dl
         pVQfyb36YXneB+DJ4HCk57rkGldjEXX8zklTXjpZHv141A6qJV1RI1hn05txx8lIyy0/
         l8LcyhHBf0PspD9iwKzKGlbsxXGSXEvmcFzKcn4Xsd2Asi9aLDTtTkbbJnzgcNNm2jvV
         nXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PSJa7y6/DnltqxhMb5vziZablAP4Q7ASHGJlJsYN1PY=;
        b=l/tNZN77tBzvjCJFPx5HplCf/4cU4ZLpzan8iq4+XrXSUdqQ80qOrB9iE7FKF0qGOB
         VG0ksaNYhoVR2oeI4TK4ZIxWgzPj9eV5OMYza7seIS22pFcsyLDwT8dBKqibHqRRvb9C
         ZvJ0YwvwqRG1gV1M4b4Kl6vxqqrl4I6Wi7ERsu3qRSqaJxfav4mhkZXiz+DSLstngoP5
         Kqua3GtnZioLdwWTjYcnaKjWL1nB8oVdzYXZK5C8BoWnuRfOjhw5SapjzcDYYzUY/wMI
         vNiQ6U/mXroW1hc2+Eg0g27rT1Bt4NfoxBvzgCVJmY0WRonT08JaNaS7um8YxZcwoSkB
         090g==
X-Gm-Message-State: AOAM531/OUKlNsIaVTuGEF3+n7xJFSKH+vI81ucs6hrDKu1jv4zBhRXk
        XPP7327yInVxqqsUA8WBsEk=
X-Google-Smtp-Source: ABdhPJxaVi9FeLni1NeL/OhX11g89JNV04iyRkurrNaJHfitRkTc/VUa/a0Sj+sltAkBMVmkM5N4uw==
X-Received: by 2002:a63:b206:: with SMTP id x6mr9103975pge.341.1621402787286;
        Tue, 18 May 2021 22:39:47 -0700 (PDT)
Received: from devbox.home ([50.39.96.2])
        by smtp.gmail.com with ESMTPSA id 126sm6861077pfv.82.2021.05.18.22.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 22:39:46 -0700 (PDT)
Date:   Tue, 18 May 2021 22:38:48 -0700
From:   Pawan Gupta <writetopawan@gmail.com>
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
 Forwarding
Message-ID: <20210519053848.bsn5x5dzz5jjqu25@devbox.home>
References: <20210517220059.6452-1-rsaripal@amd.com>
 <20210517220059.6452-2-rsaripal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20210517220059.6452-2-rsaripal@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2021 17:00, Ramakrishna Saripalli wrote:
>From: Ramakrishna Saripalli <rk.saripalli@amd.com>
>
>Certain AMD processors feature a new technology called Predictive Store
>Forwarding (PSF).
>
>PSF is a micro-architectural optimization designed to improve the
>performance of code execution by predicting dependencies between
>loads and stores.
>
>Incorrect PSF predictions can occur due to two reasons.
>
>- It is possible that the load/store pair may have had dependency for
>  a while but the dependency has stopped because the address in the
>  load/store pair has changed.
>
>- Second source of incorrect PSF prediction can occur because of an alias
>  in the PSF predictor structure stored in the microarchitectural state.
>  PSF predictor tracks load/store pair based on portions of instruction
>  pointer. It is possible that a load/store pair which does have a
>  dependency may be aliased by another load/store pair which does not have
>  the same dependency. This can result in incorrect speculation.
>
>  Software may be able to detect this aliasing and perform side-channel
>  attacks.
>
>All CPUs that implement PSF provide one bit to disable this feature.
>If the bit to disable this feature is available, it means that the CPU
>implements PSF feature and is therefore vulnerable to PSF risks.
>
>The bits that are introduced
>
>X86_FEATURE_PSFD: CPUID_Fn80000008_EBX[28] ("PSF disable")
>	If this bit is 1, CPU implements PSF and PSF control
>	via SPEC_CTRL_MSR is supported in the CPU.
>
>All AMD processors that support PSF implement a bit in
>SPEC_CTRL MSR (0x48) to disable or enable Predictive Store
>Forwarding.
>
>PSF control introduces a new kernel parameter called
>	predictive_store_fwd_disable.
>
>Kernel parameter predictive_store_fwd_disable has the following values
>
>- on. Disable PSF on all CPUs.
>
>- off. Enable PSF on all CPUs.
>       This is also the default setting.
>
>Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>---
> .../admin-guide/kernel-parameters.txt         |  5 +
> arch/x86/include/asm/cpufeatures.h            |  1 +
> arch/x86/include/asm/msr-index.h              |  2 +
> arch/x86/include/asm/nospec-branch.h          |  6 ++
> arch/x86/kernel/cpu/bugs.c                    | 94 +++++++++++++++++++
> 5 files changed, 108 insertions(+)
>
>diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>index 04545725f187..a5f694dccb24 100644
>--- a/Documentation/admin-guide/kernel-parameters.txt
>+++ b/Documentation/admin-guide/kernel-parameters.txt
>@@ -3940,6 +3940,11 @@
> 			Format: {"off"}
> 			Disable Hardware Transactional Memory
>
>+	predictive_store_fwd_disable=	[X86] This option controls PSF.
>+			off - Turns on PSF.
>+			on  - Turns off PSF.
>+			default : off.
>+
> 	preempt=	[KNL]
> 			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
> 			none - Limited to cond_resched() calls
>diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>index cc96e26d69f7..078f46022293 100644
>--- a/arch/x86/include/asm/cpufeatures.h
>+++ b/arch/x86/include/asm/cpufeatures.h
>@@ -309,6 +309,7 @@
> #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
> #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
> #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
>+#define X86_FEATURE_PSFD		(13*32+28) /* Predictive Store Forward Disable */
>
> /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
> #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
>diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>index 546d6ecf0a35..f569918c8754 100644
>--- a/arch/x86/include/asm/msr-index.h
>+++ b/arch/x86/include/asm/msr-index.h
>@@ -51,6 +51,8 @@
> #define SPEC_CTRL_STIBP			BIT(SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
> #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
> #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
>+#define SPEC_CTRL_PSFD_SHIFT		7
>+#define SPEC_CTRL_PSFD			BIT(SPEC_CTRL_PSFD_SHIFT)	/* Predictive Store Forwarding Disable */
>
> #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
> #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
>diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>index cb9ad6b73973..1231099e5c07 100644
>--- a/arch/x86/include/asm/nospec-branch.h
>+++ b/arch/x86/include/asm/nospec-branch.h
>@@ -198,6 +198,12 @@ enum ssb_mitigation {
> 	SPEC_STORE_BYPASS_SECCOMP,
> };
>
>+/* The Predictive Store forward control variant */
>+enum psf_mitigation {
>+	PREDICTIVE_STORE_FORWARD_NONE,
>+	PREDICTIVE_STORE_FORWARD_DISABLE,
>+};
>+
> extern char __indirect_thunk_start[];
> extern char __indirect_thunk_end[];
>
>diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>index d41b70fe4918..c80ef4d86b72 100644
>--- a/arch/x86/kernel/cpu/bugs.c
>+++ b/arch/x86/kernel/cpu/bugs.c
>@@ -38,6 +38,7 @@
> static void __init spectre_v1_select_mitigation(void);
> static void __init spectre_v2_select_mitigation(void);
> static void __init ssb_select_mitigation(void);
>+static void __init psf_select_mitigation(void);
> static void __init l1tf_select_mitigation(void);
> static void __init mds_select_mitigation(void);
> static void __init mds_print_mitigation(void);
>@@ -107,6 +108,7 @@ void __init check_bugs(void)
> 	spectre_v1_select_mitigation();
> 	spectre_v2_select_mitigation();
> 	ssb_select_mitigation();
>+	psf_select_mitigation();
> 	l1tf_select_mitigation();
> 	mds_select_mitigation();
> 	taa_select_mitigation();
>@@ -1195,6 +1197,98 @@ static void ssb_select_mitigation(void)
> 		pr_info("%s\n", ssb_strings[ssb_mode]);
> }
>
>+#undef pr_fmt
>+#define pr_fmt(fmt)	"Predictive Store Forward: " fmt
>+
>+static enum psf_mitigation psf_mode __ro_after_init = PREDICTIVE_STORE_FORWARD_NONE;
>+
>+/* The kernel command line selection */
>+enum psf_mitigation_cmd {
>+	PREDICTIVE_STORE_FORWARD_CMD_NONE,
>+	PREDICTIVE_STORE_FORWARD_CMD_ON,
>+};
>+
>+static const char * const psf_strings[] = {
>+	[PREDICTIVE_STORE_FORWARD_NONE]		= "Vulnerable",
>+	[PREDICTIVE_STORE_FORWARD_DISABLE]	= "Mitigation: Predictive Store Forward disabled",
>+};
>+
>+static const struct {
>+	const char *option;
>+	enum psf_mitigation_cmd cmd;
>+} psf_mitigation_options[]  __initconst = {
>+	{ "on",		PREDICTIVE_STORE_FORWARD_CMD_ON },      /* Disable Speculative Store Bypass */
>+	{ "off",	PREDICTIVE_STORE_FORWARD_CMD_NONE },    /* Don't touch Speculative Store Bypass */
>+};
>+
>+static enum psf_mitigation_cmd __init psf_parse_cmdline(void)
>+{
>+	enum psf_mitigation_cmd cmd = PREDICTIVE_STORE_FORWARD_CMD_NONE;
>+	char arg[20];
>+	int ret, i;
>+
>+	ret = cmdline_find_option(boot_command_line, "predictive_store_fwd_disable",
>+				  arg, sizeof(arg));
>+	if (ret < 0)
>+		return PREDICTIVE_STORE_FORWARD_CMD_NONE;
>+
>+	for (i = 0; i < ARRAY_SIZE(psf_mitigation_options); i++) {
>+		if (!match_option(arg, ret, psf_mitigation_options[i].option))
>+			continue;
>+
>+		cmd = psf_mitigation_options[i].cmd;
>+		break;
>+	}
>+
>+	if (i >= ARRAY_SIZE(psf_mitigation_options)) {
>+		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
>+		return PREDICTIVE_STORE_FORWARD_CMD_NONE;
>+	}
>+
>+	return cmd;
>+}
>+
>+static enum psf_mitigation __init __psf_select_mitigation(void)
>+{
>+	enum psf_mitigation mode = PREDICTIVE_STORE_FORWARD_NONE;
>+	enum psf_mitigation_cmd cmd;
>+
>+	if (!boot_cpu_has(X86_FEATURE_PSFD))
>+		return mode;
>+
>+	cmd = psf_parse_cmdline();
>+
>+	switch (cmd) {
>+	case PREDICTIVE_STORE_FORWARD_CMD_ON:
>+		mode = PREDICTIVE_STORE_FORWARD_DISABLE;
>+		break;
>+	default:
>+		mode = PREDICTIVE_STORE_FORWARD_NONE;
>+		break;
>+	}
>+
>+	x86_spec_ctrl_mask |= SPEC_CTRL_PSFD;
>+
>+	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
>+		mode = PREDICTIVE_STORE_FORWARD_DISABLE;
>+
>+	if (mode == PREDICTIVE_STORE_FORWARD_DISABLE) {
>+		setup_force_cpu_cap(X86_FEATURE_PSFD);

Why do we need to force set X86_FEATURE_PSFD here? Control will not
reach here if this is not already set (because of boot_cpu_has() check
at function entry).

>+		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
>+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>+	}
>+
>+	return mode;
>+}
>+
>+static void psf_select_mitigation(void)
>+{
>+	psf_mode = __psf_select_mitigation();
>+
>+	if (boot_cpu_has(X86_FEATURE_PSFD))
>+		pr_info("%s\n", psf_strings[psf_mode]);
>+}

For an on/off control this patch looks like an overkill. I think we can
simplify it as below:

static void psf_select_mitigation(void)
{
	if (!boot_cpu_has(X86_FEATURE_PSFD))
		return;

	x86_spec_ctrl_mask |= SPEC_CTRL_PSFD;

	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
		psf_mode = PREDICTIVE_STORE_FORWARD_DISABLE;

	if (psf_mode == PREDICTIVE_STORE_FORWARD_DISABLE) {
		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
	}

	pr_info("%s\n", psf_strings[psf_mode]);
}

static int __init psfd_cmdline(char *str)
{
	if (!boot_cpu_has(X86_FEATURE_PSFD))
		return;

	if (!str)
		return -EINVAL;

	if (!strcmp(str, "on"))
		psf_mode = PREDICTIVE_STORE_FORWARD_DISABLE;

	return 0;
}
early_param("predictive_store_fwd_disable", psfd_cmdline);

---
Thanks,
Pawan
