Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB3339E1E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 14:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhCMNJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 08:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCMNJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 08:09:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427F8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 05:09:27 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 18so49737227lff.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMPkBnzdQOM60a/PfsFaO6+x3TlhRc/ju/+/xhkipuk=;
        b=avYx8PSetnVKRaidyWDyvQY5qQq9MKkNRnx3AnvB4FoHVexesY/afg6CeRn3TEahod
         dN6Q6dBLAQ4IlNs1uJQK3qa3wneNG0ftMsdHYnuq73gecURNGBhwYXQw/B1u23z27cAt
         2zLfRAPy1OU+eaXWKDnKkOIFufxjLXcs7QUfK+22/f3NlCqA4Yce5/B6XAOS/a0kH5NK
         M5YT4MG1oE1qhYdu1GosIgjL10BwObMVZ4h6dxHdxtb38fikbVs0Y0tUcz9AVX5UuNSX
         NxiPNQv0WSBSTpmKL+e0HnQDt90D3Y+MopiT4aGy+SmgxtdILpQfg/MrblBgkIvyQ4ot
         /YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMPkBnzdQOM60a/PfsFaO6+x3TlhRc/ju/+/xhkipuk=;
        b=kEfT98+32juwsEjWuNPUxq82YubzIk0fWgHUtOf499SufNwO8b+PRVCa66D1Rn1dly
         pwYTuLR6/WsxxkIFq9f1Zamfyd7gmfIXTOSctwpu8MLdYKwTOG0eYN1zDUywNJ+yjhbE
         Iw0vnePzHExaoNVpZWvfQsIrObmQoqKjK4seAgNC7wrZxoVbus2W60GutojHsbM9n1CB
         jdQESZu4XVd8Zl/no35hGiUNHP25EFH7byMTOD15t3my8JXJJ7k/P/DGwEELw4q3hvae
         8nORattLt0mQqVSOYEfPXSQwr1k7IPP/oabGFiMVEkgN+Mx0FcBKUPTqmaWLBVPGlYNY
         0Qcg==
X-Gm-Message-State: AOAM530PyK1GFj6Pqf1X+7YSbePfUN/FVoE9AQR8m7UsNAxSUbGeiVQ8
        T17hP+2OcWVFb22UEd5yHcj1WCtvlJEm5R0QK4Q=
X-Google-Smtp-Source: ABdhPJyr5mZzSXn+kVx931bHpr9ZST9ysgoiamlfNwYiUDUBl4EGngNcmqUYM+SeCFrgRS+tQ2Z7jvBpvwkqmT3PP4s=
X-Received: by 2002:a19:4881:: with SMTP id v123mr2552082lfa.276.1615640964285;
 Sat, 13 Mar 2021 05:09:24 -0800 (PST)
MIME-Version: 1.0
References: <1615519478-178620-1-git-send-email-zhaoqianligood@gmail.com> <m1ft10i640.fsf@fess.ebiederm.org>
In-Reply-To: <m1ft10i640.fsf@fess.ebiederm.org>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Sat, 13 Mar 2021 21:12:35 +0800
Message-ID: <CAPx_LQGkDE5vqwB4h7-k=AfJ5TJKHae_=B47OnfDXZSuUxjkbQ@mail.gmail.com>
Subject: Re: [PATCH V2] exit: trigger panic when global init has exited
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     christian@brauner.io, axboe@kernel.dk,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,Oleg

> As Oleg pointer out we need to do something like the code below.
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 04029e35e69a..bc676c06ef9a 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -785,15 +785,16 @@ void __noreturn do_exit(long code)
>                 sync_mm_rss(tsk->mm);
>         acct_update_integrals(tsk);
>         group_dead = atomic_dec_and_test(&tsk->signal->live);
> +       /*
> +        * If the global init has exited, panic immediately to get a
> +        * useable coredump.
> +        */
> +       if (unlikely(is_global_init(tsk) &&
> +                    (group_dead || (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
> +               panic("Attempted to kill init! exitcode=0x%08x\n",
> +                     tsk->signal->group_exit_code ?: (int)code);
> +       }
>         if (group_dead) {
> -               /*
> -                * If the last thread of global init has exited, panic
> -                * immediately to get a useable coredump.
> -                */
> -               if (unlikely(is_global_init(tsk)))
> -                       panic("Attempted to kill init! exitcode=0x%08x\n",
> -                               tsk->signal->group_exit_code ?: (int)code);
> -
>  #ifdef CONFIG_POSIX_TIMERS
>                 hrtimer_cancel(&tsk->signal->real_timer);
>                 exit_itimers(tsk->signal);
>

Sorry,i missed this discussion,we needs use group_dead to replace
thread_group_empty().

> There is still a race that could lead to the BUG in zap_pid_ns_processes.
> We still have a case where the last two threads of a process call
> pthread_exit (aka do_exit not do_group_exit in the kernel).
>
> Thread A                            Thread B
> do_exit()                           do_exit()
>
>  exit_signals()
>    tsk->flags |= PF_EXITING;
>  group_dead = false;
>                                     exit_signals()
>                                       tsk->flags |= PF_EXITING;
>  exit_notify()
>   forget_original_parent
>     find_child_reaper
>       reaper = find_alive_thread()
>       zap_pid_ns_processes()
>          BUG()
>                                     group_dead = true;
>                                     if (is_global_init())
>                                         panic("Attemted to kill init");
>

My patch moves panic to before setting PF_EXITING,it can avoid this case.
What if we move atomic_dec_and_test() to before exit_signals()?
Such as:
        validate_creds_for_do_exit(tsk);

+      group_dead = atomic_dec_and_test(&tsk->signal->live);
+       /*
+        * If global init has exited,
+        * panic immediately to get a useable coredump.
+        */
+       if (unlikely(is_global_init(tsk) &&
+           (group_dead || (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
+                       panic("Attempted to kill init! exitcode=0x%08x\n",
+                               tsk->signal->group_exit_code ?: (int)code);
+       }
...
       exit_signals(tsk);  /* sets PF_EXITING */
...
        acct_update_integrals(tsk);
-       group_dead = atomic_dec_and_test(&tsk->signal->live);
        if (group_dead) {
-               /*
-                * If the last thread of global init has exited, panic
-                * immediately to get a useable coredump.
-                */
-               if (unlikely(is_global_init(tsk)))
-                       panic("Attempted to kill init! exitcode=0x%08x\n",
-                               tsk->signal->group_exit_code ?: (int)code);

Thanks
