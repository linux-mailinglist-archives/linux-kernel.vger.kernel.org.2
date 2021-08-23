Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676533F447E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 06:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhHWE4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 00:56:23 -0400
Received: from cloud48395.mywhc.ca ([173.209.37.211]:52714 "EHLO
        cloud48395.mywhc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhHWE4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 00:56:21 -0400
Received: from modemcable064.203-130-66.mc.videotron.ca ([66.130.203.64]:60598 helo=[192.168.1.179])
        by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <olivier@trillion01.com>)
        id 1mI1zm-0007f0-2F; Mon, 23 Aug 2021 00:55:38 -0400
Message-ID: <ccaa583dcd283002e417723ae15769cf3636fe8e.camel@trillion01.com>
Subject: Re: [PATCH] kernel: make TIF_NOTIFY_SIGNAL and core dumps co-exist
From:   Olivier Langlois <olivier@trillion01.com>
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Tony Battersby <tonyb@cybernetics.com>
Date:   Mon, 23 Aug 2021 00:55:36 -0400
In-Reply-To: <76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk>
References: <76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk>
Organization: Trillion01 Inc
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-17 at 21:06 -0600, Jens Axboe wrote:
> task_work being added with notify == TWA_SIGNAL will utilize
> TIF_NOTIFY_SIGNAL for signaling the targeted task that work is
> available.
> If this happens while a task is going through a core dump, it'll
> potentially disturb and truncate the dump as a signal interruption.
> 
> Have task_work_add() with notify == TWA_SIGNAL check if a task has
> been
> signaled for a core dump, and refuse to add the work if that is the
> case.
> When a core dump is invoked, explicitly check for TIF_NOTIFY_SIGNAL
> and
> run any pending task_work if that is set. This is similar to how an
> exiting task will not get new task_work added, and we return the same
> error for the core dump case. As we return success or failure from
> task_work_add(), the caller has to be prepared to handle this case
> already.
> 
> Currently this manifests itself in that io_uring tasks that end up
> using
> task_work will experience truncated core dumps.
> 
> Reported-by: Tony Battersby <tonyb@cybernetics.com>
> Reported-by: Olivier Langlois <olivier@trillion01.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 07afb5ddb1c4..ca7c1ee44ada 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -602,6 +602,14 @@ void do_coredump(const kernel_siginfo_t
> *siginfo)
>                 .mm_flags = mm->flags,
>         };
>  
> +       /*
> +        * task_work_add() will refuse to add work after PF_SIGNALED
> has
> +        * been set, ensure that we flush any pending
> TIF_NOTIFY_SIGNAL work
> +        * if any was queued before that.
> +        */
> +       if (test_thread_flag(TIF_NOTIFY_SIGNAL))
> +               tracehook_notify_signal();
> +
>         audit_core_dumps(siginfo->si_signo);
>  
>         binfmt = mm->binfmt;
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 1698fbe6f0e1..1ab28904adc4 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -41,6 +41,12 @@ int task_work_add(struct task_struct *task, struct
> callback_head *work,
>                 head = READ_ONCE(task->task_works);
>                 if (unlikely(head == &work_exited))
>                         return -ESRCH;
> +               /*
> +                * TIF_NOTIFY_SIGNAL notifications will interfere
> with
> +                * a core dump in progress, reject them.
> +                */
> +               if (notify == TWA_SIGNAL && (task->flags &
> PF_SIGNALED))
> +                       return -ESRCH;
>                 work->next = head;
>         } while (cmpxchg(&task->task_works, head, work) != head);
> 

tested successfully on 5.12.19

Tested-by: Olivier Langlois <olivier@trillion01.com>


