Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662703AC9B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhFRLV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:21:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58058 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhFRLVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:21:25 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D1701FDF0;
        Fri, 18 Jun 2021 11:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624015155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHLeGLCE2lXBjmBQAwVQQk+N3kDCj2hk2FyvsSKruCU=;
        b=Tv5ilOewAPOAr1pJNMnedVf4ff5qY9a/kh3hkwOWbJZTJvNTC3zBwVUF/rC4sQKZMtd+FJ
        wGcijoiGxLcvmgK8DDLmphiUMrzZ0emtaw/hO17Otqut7oklBlodzZfLkHEDF22A2wc8ih
        KlBKiQh0haCQe5g9WfSSvhtcS5ms1iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624015155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHLeGLCE2lXBjmBQAwVQQk+N3kDCj2hk2FyvsSKruCU=;
        b=KSy0VPoI7oEjaoSMXRBsgRHJ5H8Is5IE5KYCJ0C8pz+4ICU6ghA8OhImA2zNjWz+34hJJK
        ENnJxSiSMxZ22GBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0E07A118DD;
        Fri, 18 Jun 2021 11:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624015155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHLeGLCE2lXBjmBQAwVQQk+N3kDCj2hk2FyvsSKruCU=;
        b=Tv5ilOewAPOAr1pJNMnedVf4ff5qY9a/kh3hkwOWbJZTJvNTC3zBwVUF/rC4sQKZMtd+FJ
        wGcijoiGxLcvmgK8DDLmphiUMrzZ0emtaw/hO17Otqut7oklBlodzZfLkHEDF22A2wc8ih
        KlBKiQh0haCQe5g9WfSSvhtcS5ms1iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624015155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHLeGLCE2lXBjmBQAwVQQk+N3kDCj2hk2FyvsSKruCU=;
        b=KSy0VPoI7oEjaoSMXRBsgRHJ5H8Is5IE5KYCJ0C8pz+4ICU6ghA8OhImA2zNjWz+34hJJK
        ENnJxSiSMxZ22GBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id XMkxAzOBzGBhbgAALh3uQQ
        (envelope-from <bp@suse.de>); Fri, 18 Jun 2021 11:19:15 +0000
Date:   Fri, 18 Jun 2021 13:19:01 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V2 15/52] x86/fpu: Use copy_uabi_xstate_to_membuf() in
 xfpregs_get()
Message-ID: <YMyBJRxZ6tTKgd+d@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.241932488@linutronix.de>
 <YMsPCyL8YkT9W+9o@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YMsPCyL8YkT9W+9o@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:59:55AM +0200, Borislav Petkov wrote:
> manpage says "PTRACE_GETREGS and PTRACE_GETFPREGS are not present on all
> architectures." which could explain why. I wonder if we should add some
> stupid test cases so that we can at least exercise this...

How's this rough thing?

What I'd do in the final version is verify the values we preset in
fpstate_init_fstate() and in fpstate_init_fxstate() with what this test
reads and this way we'll catch any changes in that area.

diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 12aaa063196e..ac73cca7300f 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -407,7 +407,62 @@ static void test_restart_under_ptrace(void)
 		err(1, "waitpid");
 }
 
-int main()
+static void test_ptrace_a_bit(void)
+{
+	struct user_fpregs_struct regs;
+	int status;
+	pid_t chld;
+
+	printf("[RUN]\tTest some ptrace(2) requests\n");
+
+	chld = fork();
+	if (chld < 0)
+		err(1, "fork");
+
+	if (!chld) {
+		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
+			err(1, "PTRACE_TRACEME");
+
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
+		printf("\tChild will take a nap until signaled\n");
+		setsigign(SIGUSR1, SA_RESTART);
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
+
+		syscall(SYS_pause, 0, 0, 0, 0, 0, 0);
+		_exit(0);
+	}
+
+	/* Wait for SIGSTOP. */
+	if (waitpid(chld, &status, 0) != chld || !WIFSTOPPED(status))
+		err(1, "waitpid");
+
+	printf("[RUN]\tGETFPREGS\n");
+	if (ptrace(PTRACE_GETFPREGS, chld, 0, &regs) != 0)
+		err(1, "PTRACE_GETFPREGS");
+
+#ifdef __i386__
+	printf("__i386__\n");
+	printf("cwd: 0x%lx, swd: 0x%lx\n", regs.cwd, regs.swd);
+	printf("twd: 0x%lx, fip: 0x%lx\n", regs.twd, regs.fip);
+	printf("fcs: 0x%lx, foo: 0x%lx\n", regs.fcs, regs.foo);
+	printf("fos: 0x%lx, st_space[0]: 0x%lx\n", regs.fos, regs.st_space[0]);
+#else
+	printf("__x86_64__\n");
+	printf("cwd: 0x%x, swd: 0x%x\n", regs.cwd, regs.swd);
+	printf("ftw: 0x%x, fop: 0x%x\n", regs.ftw, regs.fop);
+	printf("rip: 0x%llx, rdp: 0x%llx\n", regs.rip, regs.rdp);
+	/* Yeah, it is mxcr_mask - sys/user.h has a typo :-) */
+	printf("mxcsr: 0x%x, mxcsr_mask: 0x%x\n", regs.mxcsr, regs.mxcr_mask);
+#endif
+
+	/* Kill it. */
+	kill(chld, SIGKILL);
+	if (waitpid(chld, &status, 0) != chld)
+		err(1, "waitpid");
+}
+
+int main(void)
 {
 	printf("[RUN]\tCheck int80 return regs\n");
 	test_sys32_regs(do_full_int80);
@@ -426,5 +481,7 @@ int main()
 
 	test_restart_under_ptrace();
 
+	test_ptrace_a_bit();
+
 	return 0;
 }

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
