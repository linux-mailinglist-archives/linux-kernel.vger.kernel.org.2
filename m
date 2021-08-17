Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF943EF1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhHQSWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:22:14 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52768 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhHQSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:22:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:53596)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mG3iT-00BChz-Gh; Tue, 17 Aug 2021 12:21:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55358 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mG3iN-009Bti-1e; Tue, 17 Aug 2021 12:21:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
References: <YRrdvKEu2JQxLI5n@zeniv-ca.linux.org.uk>
Date:   Tue, 17 Aug 2021 13:21:03 -0500
In-Reply-To: <YRrdvKEu2JQxLI5n@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Mon, 16 Aug 2021 21:50:52 +0000")
Message-ID: <877dgkvsog.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mG3iN-009Bti-1e;;;mid=<877dgkvsog.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ObD3cJEIZ6Nc/X3TceBIxOY/d0fLtUhk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 5596 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.1%), b_tie_ro: 2.7 (0.0%), parse: 0.69
        (0.0%), extract_message_metadata: 9 (0.2%), get_uri_detail_list: 1.82
        (0.0%), tests_pri_-1000: 6 (0.1%), tests_pri_-950: 0.96 (0.0%),
        tests_pri_-900: 0.79 (0.0%), tests_pri_-90: 90 (1.6%), check_bayes: 89
        (1.6%), b_tokenize: 6 (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob:
        1.94 (0.0%), b_tok_touch_all: 70 (1.3%), b_finish: 0.65 (0.0%),
        tests_pri_0: 5474 (97.8%), check_dkim_signature: 0.39 (0.0%),
        check_dkim_adsp: 2.3 (0.0%), poll_dns_idle: 1.07 (0.0%), tests_pri_10:
        1.84 (0.0%), tests_pri_500: 6 (0.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH][RFC] fix PTRACE_KILL
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> [Cc'd to security@k.o, *NOT* because I consider it a serious security hole;
> it's just that the odds of catching relevant reviewers there are higher
> than on l-k and there doesn't seem to be any lists where that would be
> on-topic.  My apologies for misuse of security@k.o ;-/]

Hmm.  I don't see security@kernel.org Cc'd.

> Current implementation is racy in quite a few ways - we check that
> the child is traced by us and use ptrace_resume() to feed it
> SIGKILL, provided that it's still alive.
>
> What we do not do is making sure that the victim is in ptrace stop;
> as the result, it can go and violate all kinds of assumptions,
> starting with "child->sighand won't change under ptrace_resume()",
> "child->ptrace won't get changed under user_disable_single_step()",
> etc.
>
> Note that ptrace(2) manpage has this to say:
>     
> PTRACE_KILL
>       Send  the  tracee a SIGKILL to terminate it.  (addr and data are
>       ignored.)
>     
>       This operation is deprecated; do not use it!   Instead,  send  a
>       SIGKILL  directly  using kill(2) or tgkill(2).  The problem with
>       PTRACE_KILL is that it requires the  tracee  to  be  in  signal-
>       delivery-stop,  otherwise  it  may  not work (i.e., may complete
>       successfully but won't kill the tracee).  By contrast, sending a
>       SIGKILL directly has no such limitation.
>     
> So let it check (under tasklist_lock) that the victim is traced by us
> and call sig_send_info() to feed it SIGKILL.  It's easier that trying
> to force ptrace_resume() into handling that mess and it's less brittle
> that way.

I took a quick look and despite being deprecated PTRACE_KILL appears
to still have some active users (like gcc-10).  So that seems to rule
out just removing PTRACE_KILL.

I looked at the bug that PTRACE_KILL only kills a process when it is
stopped and it is present in Linux 1.0.  Given that I expect userspace
applications are ok with the current semantics rather than the intended
semantics.

The current semantics also include the weirdness that PTRACE_KILL only
kills a process when it is stopped in ptrace_signal, and not at other
ptrace stops.

So rather than fix the code to do what was intended 27 years ago,
why don't we accept the fact that PTRACE_KILL is equivalent
to PTRACE_CONT with data = SIGKILL.

If there are regressions or we really care we can tweak the return value
to return 0 instead of -ESRCH when the process is not stopped.

Something like this:

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index f8589bf8d7dc..f40f0a0ff70a 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1221,8 +1221,6 @@ int ptrace_request(struct task_struct *child, long request,
 		return ptrace_resume(child, request, data);
 
 	case PTRACE_KILL:
-		if (child->exit_state)	/* already dead */
-			return 0;
 		return ptrace_resume(child, request, SIGKILL);
 
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
@@ -1304,8 +1302,7 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 		goto out_put_task_struct;
 	}
 
-	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
-				  request == PTRACE_INTERRUPT);
+	ret = ptrace_check_attach(child, request == PTRACE_INTERRUPT);
 	if (ret < 0)
 		goto out_put_task_struct;
 
@@ -1449,8 +1446,7 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_long_t, request, compat_long_t, pid,
 		goto out_put_task_struct;
 	}
 
-	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
-				  request == PTRACE_INTERRUPT);
+	ret = ptrace_check_attach(child, request == PTRACE_INTERRUPT);
 	if (!ret) {
 		ret = compat_arch_ptrace(child, request, addr, data);
 		if (ret || request != PTRACE_DETACH)

Eric
