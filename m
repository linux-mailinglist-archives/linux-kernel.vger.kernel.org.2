Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7544DBB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 19:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhKKSqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 13:46:53 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:55896 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhKKSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 13:46:52 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:38582)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mlF3F-002y2K-Rk; Thu, 11 Nov 2021 11:43:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:56522 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mlF3D-0039VC-8O; Thu, 11 Nov 2021 11:43:57 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, thuth@redhat.com,
        frankja@linux.ibm.com, borntraeger@de.ibm.com,
        Ulrich.Weigand@de.ibm.com, heiko.carstens@de.ibm.com,
        david@redhat.com, ultrachin@163.com, akpm@linux-foundation.org,
        vbabka@suse.cz, brookxu.cn@gmail.com, xiaoggchen@tencent.com,
        linuszeng@tencent.com, yihuilu@tencent.com, mhocko@suse.com,
        daniel.m.jordan@oracle.com, axboe@kernel.dk, legion@kernel.org,
        peterz@infradead.org, aarcange@redhat.com, christian@brauner.io,
        tglx@linutronix.de
In-Reply-To: <20211111095008.264412-3-imbrenda@linux.ibm.com> (Claudio
        Imbrenda's message of "Thu, 11 Nov 2021 10:50:05 +0100")
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
        <20211111095008.264412-3-imbrenda@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 11 Nov 2021 12:43:47 -0600
Message-ID: <87y25uzg64.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mlF3D-0039VC-8O;;;mid=<87y25uzg64.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+rQcRsdkx3ZlQpYyR+3bkWgYGU8S7mru8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4190]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Claudio Imbrenda <imbrenda@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1688 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (0.8%), b_tie_ro: 11 (0.7%), parse: 1.05
        (0.1%), extract_message_metadata: 4.3 (0.3%), get_uri_detail_list:
        1.83 (0.1%), tests_pri_-1000: 4.3 (0.3%), tests_pri_-950: 1.64 (0.1%),
        tests_pri_-900: 1.43 (0.1%), tests_pri_-90: 103 (6.1%), check_bayes:
        100 (6.0%), b_tokenize: 7 (0.4%), b_tok_get_all: 10 (0.6%),
        b_comp_prob: 3.7 (0.2%), b_tok_touch_all: 73 (4.3%), b_finish: 1.27
        (0.1%), tests_pri_0: 1535 (91.0%), check_dkim_signature: 0.49 (0.0%),
        check_dkim_adsp: 3.3 (0.2%), poll_dns_idle: 1.53 (0.1%), tests_pri_10:
        4.0 (0.2%), tests_pri_500: 11 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC v1 1/4] exit: add arch mmput hook in exit_mm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Imbrenda <imbrenda@linux.ibm.com> writes:

> This simple patch adds a hook for the mmput in exit_mm. This allows
> archs to perform the mmput in custom ways if desired (e.g.
> asynchronously)
>
> No functional change intended.

Ouch! No.

You changes don't include an architecture taking advantage of this
so there is not way to see how this is used in practice and maintain
the code.

Further you are making the generic code much harder to read and
follow replacing generic code with something random that some buggy
architecture implements that no one understands.

Saying "some buggy architecture implements and no one understands"
is a bit hyperbole but that is how these hooks feel when digging in
to changing the code.  It takes weeks to months to read through
ask questions etc to clean hooks like this up and change the
code in an appropriate way.

As things are ill specified like this really do need change eventually.

So please use much more targeted routines for architecture code to call.
Especially when dealing with something as fundamental as the lifetime of
a core kernel object.

If you want an example of how silly some of these kinds of things
can get just look at arch_ptrace_stop and sigkill_pending.  Linus has
just merged my fixes for these things.  There are worse examples, I just
remember them off the top of my head.

If this is merged as is, this feels like code that will be subtly wrong
for a decade before someone figures it out and fixes it.

Eric


> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  include/asm-generic/mmu_context.h | 4 ++++
>  kernel/exit.c                     | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
> index 91727065bacb..900931a6a105 100644
> --- a/include/asm-generic/mmu_context.h
> +++ b/include/asm-generic/mmu_context.h
> @@ -73,4 +73,8 @@ static inline void deactivate_mm(struct task_struct *tsk,
>  }
>  #endif
>  
> +#ifndef arch_exit_mm_mmput
> +#define arch_exit_mm_mmput mmput
> +#endif
> +
>  #endif /* __ASM_GENERIC_MMU_CONTEXT_H */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f702a6a63686..6eb1fdcc434e 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -504,7 +504,7 @@ static void exit_mm(void)
>  	task_unlock(current);
>  	mmap_read_unlock(mm);
>  	mm_update_next_owner(mm);
> -	mmput(mm);
> +	arch_exit_mm_mmput(mm);
>  	if (test_thread_flag(TIF_MEMDIE))
>  		exit_oom_victim();
>  }
