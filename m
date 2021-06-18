Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1943ACC18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhFRN12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:27:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34270 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhFRN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:27:25 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A27121B36;
        Fri, 18 Jun 2021 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624022715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKcEqakY2APuC/HXPjonGcR1/LOv2rueIscfwlKN9S4=;
        b=G7gw7nL/J+DJTHtKnR6gFOulX4ze74GwoxqQg2Jy6lOPC348kpfvCnUCRT/VpxxBuU/XNw
        DzwEip5mlt+zznp0eA/udjfyjF8/+hHzNikmPzUqI+NgTfqkQoh6dLlJp3bCVCQKbPLkQJ
        RhkEf4yPU96i4dZsO+eltx+z7oZ9wSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624022715;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKcEqakY2APuC/HXPjonGcR1/LOv2rueIscfwlKN9S4=;
        b=L7kOOlABBvSw6yNwRQhoAEa1BijdZeW1fqHoY/c9rwL18WjVKWLcm1tvpEwg9KmF4wScoR
        Lu6AT2XPwcrXErDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0795F118DD;
        Fri, 18 Jun 2021 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624022715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKcEqakY2APuC/HXPjonGcR1/LOv2rueIscfwlKN9S4=;
        b=G7gw7nL/J+DJTHtKnR6gFOulX4ze74GwoxqQg2Jy6lOPC348kpfvCnUCRT/VpxxBuU/XNw
        DzwEip5mlt+zznp0eA/udjfyjF8/+hHzNikmPzUqI+NgTfqkQoh6dLlJp3bCVCQKbPLkQJ
        RhkEf4yPU96i4dZsO+eltx+z7oZ9wSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624022715;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKcEqakY2APuC/HXPjonGcR1/LOv2rueIscfwlKN9S4=;
        b=L7kOOlABBvSw6yNwRQhoAEa1BijdZeW1fqHoY/c9rwL18WjVKWLcm1tvpEwg9KmF4wScoR
        Lu6AT2XPwcrXErDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id EAjjALuezGA8MwAALh3uQQ
        (envelope-from <bp@suse.de>); Fri, 18 Jun 2021 13:25:15 +0000
Date:   Fri, 18 Jun 2021 15:25:04 +0200
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
Subject: [PATCH] selftests/x86/ptrace_syscall: Add a PTRACE_GETFPREGS test
Message-ID: <YMyesDZPd3pJqYXu@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.241932488@linutronix.de>
 <YMsPCyL8YkT9W+9o@zn.tnic>
 <YMyBJRxZ6tTKgd+d@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YMyBJRxZ6tTKgd+d@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>
Date: Fri, 18 Jun 2021 15:17:28 +0200

... instead of fumbling with gdb trying to cause it to use this old way
to get FPU regs.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 tools/testing/selftests/x86/ptrace_syscall.c | 65 +++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 12aaa063196e..09abeb445db0 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -407,7 +407,68 @@ static void test_restart_under_ptrace(void)
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
+	if (regs.cwd != 0xffff037fu || regs.swd != 0xffff0000u ||
+	    regs.twd != 0xffffffffu) {
+		printf("[FAIL]\t32-bit args after PTRACE_GETFPREGS are wrong: ");
+		printf("cwd: 0x%lx, swd: 0x%lx ",  regs.cwd, regs.swd);
+		printf("twd: 0x%lx\n", regs.twd);
+		goto out;
+	}
+#else
+	if (regs.cwd != 0x37f || regs.mxcsr != 0x1f80 || regs.mxcr_mask != 0x2ffff) {
+		printf("[FAIL]\t64-bit args after PTRACE_GETFPREGS are wrong: ");
+		printf("cwd: 0x%x, ", regs.cwd);
+		/* Yeah, it is mxcr_mask - sys/user.h has a typo :-) */
+		printf("mxcsr: 0x%x, mxcsr_mask: 0x%x\n", regs.mxcsr, regs.mxcr_mask);
+		goto out;
+	}
+#endif
+
+	printf("[OK]\tptrace(PTRACE_GETFPREGS)\n");
+
+out:
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
@@ -426,5 +487,7 @@ int main()
 
 	test_restart_under_ptrace();
 
+	test_ptrace_a_bit();
+
 	return 0;
 }
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
