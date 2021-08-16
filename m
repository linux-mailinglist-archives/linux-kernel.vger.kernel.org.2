Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04FE3ED8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhHPOTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbhHPOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:19:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A74C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:19:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q21so5915077ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZZOk1SiZbn9YyhGZpAHZIA0x/wOHH0cbRglnjudfww=;
        b=GP9Zw3SAdDntpU9ZN0HJNnD6CH+s5mjZT23A73p7eD4nkfQQ85HiG4q90W9gODQrZB
         EuGdrE59ClZ0bMsJie4CQNY1Q71UK9RI4zGAKQtrlRcU96VF5+q4vCpKmpVEhaMtKCJB
         dgdbMCZix00RPjNlJF72UBT9ScZrpY65CXCb3t0Hg8h/UDOtxqbacDfoFfCZOzsbcAIx
         uIfDWr4T5fmH4VRM7WE6ad58BB5M2HtMQd1v51dZWd0z5VlzK2V55+D/fFLnBE8NnkJZ
         D+HcjOhuvJY9i8dHElBbVnPB5dJoZ1o2hG9+QDkf0h7XVoqXQeW79aB8cg31nLVfM0jX
         c6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZZOk1SiZbn9YyhGZpAHZIA0x/wOHH0cbRglnjudfww=;
        b=LNaqbspTHC84OhezkL750D4NRBMR9/toYvvDIaALXBQWpZhfYpyuUjjRmxoJNXHig0
         gcAa+Q+8Fd/Oc5VQu494M+anBuR4tTRQiBkZbS/kNLnCAwFISSnEyG6+cKRn/jlF2cCP
         vDq0wIrQgu6WB+3Ur+YmCFIVNJwgOu5pnXT/FJYfgR0Lkvy0Gy7G2cgvJzJy8UQNlUOg
         aIdLw2anKbMH4AfvCPszfi7VPxoQGIi1DcL5eU0X+DqfM/X5Xz6oqgE/3yB45Hjr1AgD
         0MLJ+BS2f7BZDv/VDxwMCr1lUUuWAkCqrE82NgwX8QCII88dZxROEO0T0idOC7vVi7Oa
         h3OA==
X-Gm-Message-State: AOAM533ufxn1InBYC8eXmd69lGPqFvcw0nN8X1hrKZvYN/U95RERjR5j
        6tlk+UCHhRZb9eN6P9HhoDMMlDopSa9B+DXQ0D/88Q==
X-Google-Smtp-Source: ABdhPJy/ZSnbU2N5sKh3G6paa9C98XOOn27oNC6c4S3O8A6Z6fR31SOGrIAuXHjWutBVgFBp8vphyBEEiIOwK1sbpB0=
X-Received: by 2002:a05:651c:906:: with SMTP id e6mr12224538ljq.160.1629123554361;
 Mon, 16 Aug 2021 07:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <1629106756-20874-1-git-send-email-charante@codeaurora.org>
In-Reply-To: <1629106756-20874-1-git-send-email-charante@codeaurora.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 16 Aug 2021 07:19:03 -0700
Message-ID: <CALvZod5C1zu=wm00x686bayt3RAowDUmK15-675DOeUMOe_SPA@mail.gmail.com>
Subject: Re: [PATCH] mm: oom_kill: add trace logs in process_mrelease() system call
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, vinmenon@codeaurora.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 2:39 AM Charan Teja Reddy
<charante@codeaurora.org> wrote:
>
> The process_mrelease() system call[1] is used to release the memory of
> a dying process from the context of the caller, which is similar to and
> uses the functions of the oom reaper logic. There exists trace logs for
> a process when reaped by the oom reaper. Just extend the same to when
> done by the process_mrelease() system call.
>
> [1] https://lore.kernel.org/linux-mm/20210809185259.405936-1-surenb@google.com/
>
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
>  mm/oom_kill.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 431d38c..8f4020a 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -941,7 +941,6 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>         mmdrop(mm);
>         put_task_struct(victim);
>  }
> -#undef K
>
>  /*
>   * Kill provided task unless it's secured by setting
> @@ -1199,8 +1198,18 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>                 ret = -EINTR;
>                 goto drop_mm;
>         }
> +       trace_start_task_reaping(task->pid);
>         if (!__oom_reap_task_mm(mm))
>                 ret = -EAGAIN;
> +       if (!ret) {
> +               pr_info("process_mrelease: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB oom_score_adj:%d\n",
> +                       task_pid_nr(task), task->comm,
> +                       K(get_mm_counter(mm, MM_ANONPAGES)),
> +                       K(get_mm_counter(mm, MM_FILEPAGES)),
> +                       K(get_mm_counter(mm, MM_SHMEMPAGES)),
> +                       task->signal->oom_score_adj);

Tracing is good but I don't think we want this line to be flooding the
kernel logs. I would recommend either simply removing it or adding
another trace for this, so only folks interested in this info can get
it.
