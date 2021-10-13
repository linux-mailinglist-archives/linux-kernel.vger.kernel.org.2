Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65C42C10F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhJMNNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235293AbhJMNNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:13:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E26C561100;
        Wed, 13 Oct 2021 13:11:05 +0000 (UTC)
Date:   Wed, 13 Oct 2021 09:11:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     keescook@chromium.org, peterz@infradead.org, pmladek@suse.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 1/5] elfcore: use TASK_COMM_LEN instead of 16 in
 prpsinfo
Message-ID: <20211013091104.4ea0e05b@gandalf.local.home>
In-Reply-To: <20211013102346.179642-2-laoar.shao@gmail.com>
References: <20211013102346.179642-1-laoar.shao@gmail.com>
        <20211013102346.179642-2-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 10:23:42 +0000
Yafang Shao <laoar.shao@gmail.com> wrote:

> kernel test robot reported a -Wstringop-truncation warning after I
> extend task comm from 16 to 24. Below is the detailed warning:
> 
>    fs/binfmt_elf.c: In function 'fill_psinfo.isra':
> >> fs/binfmt_elf.c:1575:9: warning: 'strncpy' output may be truncated copying 16 bytes from a string of length 23 [-Wstringop-truncation]  
>     1575 |         strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This patch can fix this warning.
> 
> struct elf_prpsinfo was moved from include/uapi/linux/elfcore.h into
> include/linux/elfcore.h in commit
> 1e6b57d6421f ("unexport linux/elfcore.h")
> 
> As it is not UAPI code, we can replace 16 with TASK_COMM_LEN without
> worrying about breaking userspace things.
> 
> struct elf_prpsinfo is used to dump the task information in userspace
> coredump or kernel vmcore. So I verified what will happen to vmcore if
> I extend the size of TASK_COMM_LEN to 24. The result is that the vmcore
> still work fine as expected, for example:
> 
> crash> ps  
>    PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
> >     0      0   0  ffffffff8501a940  RU   0.0       0      0  [swapper/0]
> >     0      0   1  ffff996e00f81f80  RU   0.0       0      0  [swapper/1]
> >     0      0   2  ffff996e00f80000  RU   0.0       0      0  [swapper/2]
> >     0      0   3  ffff996e00f85e80  RU   0.0       0      0  [swapper/3]
> >     0      0   4  ffff996e00f83f00  RU   0.0       0      0  [swapper/4]  
>       0      0   5  ffff996e00f8de80  RU   0.0       0      0  [swapper/5]
> >     0      0   6  ffff996e00f8bf00  RU   0.0       0      0  [swapper/6]
> >     0      0   7  ffff996e00f89f80  RU   0.0       0      0  [swapper/7]
> >     0      0   8  ffff996e00f88000  RU   0.0       0      0  [swapper/8]
> >     0      0   9  ffff996e00f93f00  RU   0.0       0      0  [swapper/9]
> >     0      0  10  ffff996e00f91f80  RU   0.0       0      0  [swapper/10]
> >     0      0  11  ffff996e00f90000  RU   0.0       0      0  [swapper/11]
> >     0      0  12  ffff996e00f95e80  RU   0.0       0      0  [swapper/12]
> >     0      0  13  ffff996e00f98000  RU   0.0       0      0  [swapper/13]
> >     0      0  14  ffff996e00f9de80  RU   0.0       0      0  [swapper/14]
> >     0      0  15  ffff996e00f9bf00  RU   0.0       0      0  [swapper/15]  
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/elfcore-compat.h | 2 +-
>  include/linux/elfcore.h        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/elfcore-compat.h b/include/linux/elfcore-compat.h
> index e272c3d452ce..8a52a782161d 100644
> --- a/include/linux/elfcore-compat.h
> +++ b/include/linux/elfcore-compat.h
> @@ -43,7 +43,7 @@ struct compat_elf_prpsinfo
>  	__compat_uid_t			pr_uid;
>  	__compat_gid_t			pr_gid;
>  	compat_pid_t			pr_pid, pr_ppid, pr_pgrp, pr_sid;
> -	char				pr_fname[16];
> +	char				pr_fname[TASK_COMM_LEN];
>  	char				pr_psargs[ELF_PRARGSZ];
>  };

Nice clean up, but should we add "#include <linux/sched.h>" to this header,
to make sure that it pulls in TASK_COMM_LEN define and not just hope it
gets pulled in beforehand by chance?

>  
> diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
> index 2aaa15779d50..ff4e4e455160 100644
> --- a/include/linux/elfcore.h
> +++ b/include/linux/elfcore.h
> @@ -65,8 +65,8 @@ struct elf_prpsinfo
>  	__kernel_gid_t	pr_gid;
>  	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
>  	/* Lots missing */
> -	char	pr_fname[16];	/* filename of executable */
> -	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
> +	char	pr_fname[TASK_COMM_LEN]; /* filename of executable */
> +	char	pr_psargs[ELF_PRARGSZ];	 /* initial part of arg list */

This header is fine, as it pulls in sched/task_stack.h which includes
sched.h.

-- Steve

>  };
>  
>  static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)

