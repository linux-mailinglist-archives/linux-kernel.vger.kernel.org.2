Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9164931EFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhBRTXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:23:37 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:58554 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhBRS0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:26:22 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lCnzd-00AhAQ-G9; Thu, 18 Feb 2021 11:25:37 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lCnzW-008PRY-LE; Thu, 18 Feb 2021 11:25:33 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210217080000.GA25861@altlinux.org>
Date:   Thu, 18 Feb 2021 12:21:40 -0600
In-Reply-To: <20210217080000.GA25861@altlinux.org> (Dmitry V. Levin's message
        of "Wed, 17 Feb 2021 08:00:00 +0000")
Message-ID: <m1tuq9nsnf.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lCnzW-008PRY-LE;;;mid=<m1tuq9nsnf.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0aLczMW3Vl2GWSnFg6d1KsNSFnL/apdU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Dmitry V. Levin" <ldv@altlinux.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 520 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (2.5%), b_tie_ro: 11 (2.1%), parse: 1.47
        (0.3%), extract_message_metadata: 23 (4.4%), get_uri_detail_list: 3.9
        (0.8%), tests_pri_-1000: 19 (3.7%), tests_pri_-950: 1.57 (0.3%),
        tests_pri_-900: 1.18 (0.2%), tests_pri_-90: 108 (20.7%), check_bayes:
        106 (20.3%), b_tokenize: 12 (2.2%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 78 (15.0%), b_finish: 1.14
        (0.2%), tests_pri_0: 338 (64.9%), check_dkim_signature: 0.77 (0.1%),
        check_dkim_adsp: 10 (1.9%), poll_dns_idle: 0.33 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 9 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] sparc: make copy_thread honor pid namespaces
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> On sparc, fork and clone syscalls have an unusual semantics of
> returning the pid of the parent process to the child process.
>
> Apparently, the implementation did not honor pid namespaces at all,
> so the child used to get the pid of its parent in the init namespace.
>
> This bug was found by strace test suite.
>
> Reproducer:
>
>   $ gcc -Wall -O2 -xc - <<'EOF'
>   #define _GNU_SOURCE
>   #include <err.h>
>   #include <errno.h>
>   #include <sched.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <sys/wait.h>
>   #include <unistd.h>
>   #include <asm/unistd.h>
>   #include <linux/sched.h>
>   int main(void)
>   {
>     if (unshare(CLONE_NEWPID | CLONE_NEWUSER) < 0)
>       err(1, "unshare");
>     int pid = syscall(__NR_fork);
>     if (pid < 0)
>       err(1, "fork");
>     fprintf(stderr, "current: %d, parent: %d, fork returned: %d\n",
>             getpid(), getppid(), pid);
>     int status;
>     if (wait(&status) < 0) {
>       if (errno == ECHILD)
>         _exit(0);
>       err(1, "wait");
>     }
>     return !WIFEXITED(status) || WEXITSTATUS(status) != 0;
>   }
>   EOF
>   $ sh -c ./a.out
>   current: 10001, parent: 10000, fork returned: 10002
>   current: 1, parent: 0, fork returned: 10001

From glibc's sysdeps/unix/sparc/fork.S:
> SYSCALL__ (fork, 0)
> 	/* %o1 is now 0 for the parent and 1 for the child.  Decrement it to
> 	   make it -1 (all bits set) for the parent, and 0 (no bits set)
> 	   for the child.  Then AND it with %o0, so the parent gets
> 	   %o0&-1==pid, and the child gets %o0&0==0.  */
> 	sub %o1, 1, %o1
> 	retl
> 	and %o0, %o1, %o0
> libc_hidden_def (__fork)
> 
> weak_alias (__fork, fork)

This needs to be shared to make the test case make sense.

The change below looks reasonable.  Unfortunately because copy_thread
comes before init_task_pid task_active_pid_ns(p) will not work
correctly.

The code below needs to use current->nsproxy->pid_ns_for_children
instead of task_active_pid_ns(p).

For sparc people.  Do we know of anyone who actually uses the parent pid
returned from fork to the child process?  If not the code can simply
return 0 and we don't have to do this.

Eric

> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Although the fix seems to be obvious, I have no means to test it myself,
> so any help with the testing is much appreciated.
>
>  arch/sparc/kernel/process_32.c | 2 +-
>  arch/sparc/kernel/process_64.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
> index a02363735915..7a89969befa8 100644
> --- a/arch/sparc/kernel/process_32.c
> +++ b/arch/sparc/kernel/process_32.c
> @@ -368,7 +368,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  #endif
>  
>  	/* Set the return value for the child. */
> -	childregs->u_regs[UREG_I0] = current->pid;
> +	childregs->u_regs[UREG_I0] = task_pid_nr_ns(current, task_active_pid_ns(p));
>  	childregs->u_regs[UREG_I1] = 1;
>  
>  	/* Set the return value for the parent. */
> diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
> index 6f8c7822fc06..ec97217ab970 100644
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -629,7 +629,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  		t->utraps[0]++;
>  
>  	/* Set the return value for the child. */
> -	t->kregs->u_regs[UREG_I0] = current->pid;
> +	t->kregs->u_regs[UREG_I0] = task_pid_nr_ns(current, task_active_pid_ns(p));
>  	t->kregs->u_regs[UREG_I1] = 1;
>  
>  	/* Set the second return value for the parent. */
