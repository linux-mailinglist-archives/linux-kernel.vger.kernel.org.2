Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E99A322170
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhBVVb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:31:56 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:43926 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhBVVbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:31:52 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lEInN-007196-V3; Mon, 22 Feb 2021 14:31:10 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lEIms-002aVG-Pz; Mon, 22 Feb 2021 14:30:44 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210217080000.GA25861@altlinux.org>
        <m1tuq9nsnf.fsf@fess.ebiederm.org>
        <20210219225030.GA23520@altlinux.org>
Date:   Mon, 22 Feb 2021 15:30:22 -0600
In-Reply-To: <20210219225030.GA23520@altlinux.org> (Dmitry V. Levin's message
        of "Sat, 20 Feb 2021 01:50:30 +0300")
Message-ID: <m1r1l7n635.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lEIms-002aVG-Pz;;;mid=<m1r1l7n635.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Ez1vVV4mpsDez1nJEd58yYeZls3EPhUk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Dmitry V. Levin" <ldv@altlinux.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 437 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.8%), b_tie_ro: 2.4 (0.6%), parse: 0.71
        (0.2%), extract_message_metadata: 11 (2.6%), get_uri_detail_list: 1.77
        (0.4%), tests_pri_-1000: 11 (2.6%), tests_pri_-950: 0.98 (0.2%),
        tests_pri_-900: 0.79 (0.2%), tests_pri_-90: 91 (20.7%), check_bayes:
        89 (20.4%), b_tokenize: 7 (1.7%), b_tok_get_all: 8 (1.7%),
        b_comp_prob: 1.76 (0.4%), b_tok_touch_all: 69 (15.9%), b_finish: 0.68
        (0.2%), tests_pri_0: 308 (70.4%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.84 (0.2%), tests_pri_10:
        1.67 (0.4%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] sparc: make copy_thread honor pid namespaces
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
> Fortunately, most users of these syscalls are not affected by this bug
> because they use another register to distinguish the parent process
> from its child, and the pid of the parent process is often discarded.
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
>   static void test_fork(void)
>   {
>   	int pid = syscall(__NR_fork);
>   	if (pid < 0)
>   		err(1, "fork");
>   	fprintf(stderr, "current: %d, parent: %d, fork returned: %d\n",
>   		getpid(), getppid(), pid);
>   	int status;
>   	if (wait(&status) < 0) {
>   		if (errno == ECHILD)
>   			_exit(0);
>   		err(1, "wait");
>   	}
>   	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
>   		errx(1, "wait: %#x", status);
>   }
>   int main(void)
>   {
>   	test_fork();
>   	if (unshare(CLONE_NEWPID | CLONE_NEWUSER) < 0)
>   		err(1, "unshare");
>   	test_fork();
>   	return 0;
>   }
>   EOF
>   $ sh -c ./a.out
>   current: 10001, parent: 10000, fork returned: 10002
>   current: 10002, parent: 10001, fork returned: 10001
>   current: 10001, parent: 10000, fork returned: 10003
>   current: 1, parent: 0, fork returned: 10001
>
> This bug was found by strace test suite.
>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> v2: Replaced task_active_pid_ns(p) with current->nsproxy->pid_ns_for_children
>     as suggested by Eric.

I can't test this either.  But from just reading through the code earlier.
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>  arch/sparc/kernel/process_32.c | 3 ++-
>  arch/sparc/kernel/process_64.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
> index a02363735915..3be653e40204 100644
> --- a/arch/sparc/kernel/process_32.c
> +++ b/arch/sparc/kernel/process_32.c
> @@ -368,7 +368,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  #endif
>  
>  	/* Set the return value for the child. */
> -	childregs->u_regs[UREG_I0] = current->pid;
> +	childregs->u_regs[UREG_I0] =
> +		task_pid_nr_ns(current, current->nsproxy->pid_ns_for_children);
>  	childregs->u_regs[UREG_I1] = 1;
>  
>  	/* Set the return value for the parent. */
> diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
> index 6f8c7822fc06..f53ef5cff46a 100644
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -629,7 +629,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  		t->utraps[0]++;
>  
>  	/* Set the return value for the child. */
> -	t->kregs->u_regs[UREG_I0] = current->pid;
> +	t->kregs->u_regs[UREG_I0] =
> +		task_pid_nr_ns(current, current->nsproxy->pid_ns_for_children);
>  	t->kregs->u_regs[UREG_I1] = 1;
>  
>  	/* Set the second return value for the parent. */
