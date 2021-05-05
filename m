Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06437476D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhEER4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhEERzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:55:53 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF34C08EB0B
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 10:26:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m13so2846940oiw.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGF+UlpouxsTqR+y6ELaKPFA13FXOGSdqkaJj7UR80I=;
        b=ICjc38Q5vMYxLGDACzauuK7cg7VsjfsdhD2SaPjAE/EZm8/EyN8bnkhE9tb5t9xVID
         y3F0D4MMyRxHK6K3ZrmoHpgb9xtK4gPLNpVg4E//OEBuDGZWgE3FEdHgjVqqrVxhlREV
         jOdCqqjHAvfYFOkzSTxEWcrVNPIjI3L5IL9DhBXozQNibOtl6w+MKi5ChgJLtLNW5K8d
         5bQXTr3Ven9rcq5KUirl3o8mFzj0glsfECibnUycVnqM+yB87jSakNJtL1puA9KMBPQB
         dJeEuoDIj+zKb3avBF24a96msGfmcoudlX6oGNFC+NR5LZKQKvkmqWqhQIuHkKSCjf3j
         wm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGF+UlpouxsTqR+y6ELaKPFA13FXOGSdqkaJj7UR80I=;
        b=tc32MEbvcFi/XUyU/wKJQCUE2MR+0vuEXCYyo3JSwFK37am2KvMlVFcjOXMFbhhcpl
         c8rsSJzc6bHvWL9zQ7DE1sNuwnFebEZrVhV6Ym5y62+DwLGhUFWvIzdmX+uNL4dp2Ocg
         fcZZomeKotK4kR6b7ovLn661qxlvVFc1VYRoL1yvzOhA1mO9x7PDO24KgML4PCsDPBzT
         1sgkPZkcWAJW6tV/apBZsOe3DoPdIap4LYbgFrFOBrVAFOQS0zomTWqmArjtO8f/XB1I
         nOqT/QJ9FflA401EkaHpVS7wpbkg8HEq35fP3OJZJJ1Rltiry0p1pxwnLhnEo+VZedZ5
         EHIw==
X-Gm-Message-State: AOAM532g1MhHiNJbY0Vj4ue/kp7r3zI0riszOP9RAFDCNEDZWakz8UG3
        zP2dbJmQcOpIvgJCAZPOJpx97bkbuKmJgNbwU0r8Fg==
X-Google-Smtp-Source: ABdhPJxaSwKdEEmsDgoX/yL07YR0wuV5Gp+bwHQpGd1a+3ehQZ95REX14mhXZ/8yUnUWmYYfFutMk1JA/bczynfW07o=
X-Received: by 2002:aca:44d6:: with SMTP id r205mr11265oia.172.1620235617658;
 Wed, 05 May 2021 10:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org> <20210505141101.11519-1-ebiederm@xmission.com>
 <20210505141101.11519-6-ebiederm@xmission.com>
In-Reply-To: <20210505141101.11519-6-ebiederm@xmission.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 19:25:00 +0200
Message-ID: <CANpmjNOVC1ExjUaGkN1xFKZSeJSweN7tJmapc5QLUXemYnQbaQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] signal: Implement SIL_FAULT_TRAPNO
To:     "Eric W. Beiderman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2021 at 16:11, Eric W. Beiderman <ebiederm@xmission.com> wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Now that si_trapno is part of the union in _si_fault and available on
> all architectures, add SIL_FAULT_TRAPNO and update siginfo_layout to
> return SIL_FAULT_TRAPNO when si_trapno is actually used.
>
> Update the code that uses siginfo_layout to deal with SIL_FAULT_TRAPNO
> and have the same code ignore si_trapno in in all other cases.
>
> v1: https://lkml.kernel.org/r/m1o8dvs7s7.fsf_-_@fess.ebiederm.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  fs/signalfd.c          |  8 +++-----
>  include/linux/signal.h |  1 +
>  kernel/signal.c        | 37 +++++++++++++++----------------------
>  3 files changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index 040a1142915f..e87e59581653 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -123,15 +123,13 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>                  */
>         case SIL_FAULT:
>                 new.ssi_addr = (long) kinfo->si_addr;
> -#ifdef __ARCH_SI_TRAPNO
> +               break;
> +       case SIL_FAULT_TRAPNO:
> +               new.ssi_addr = (long) kinfo->si_addr;
>                 new.ssi_trapno = kinfo->si_trapno;
> -#endif
>                 break;
>         case SIL_FAULT_MCEERR:
>                 new.ssi_addr = (long) kinfo->si_addr;
> -#ifdef __ARCH_SI_TRAPNO
> -               new.ssi_trapno = kinfo->si_trapno;
> -#endif
>                 new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
>                 break;
>         case SIL_PERF_EVENT:
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 1e98548d7cf6..5160fd45e5ca 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -40,6 +40,7 @@ enum siginfo_layout {
>         SIL_TIMER,
>         SIL_POLL,
>         SIL_FAULT,
> +       SIL_FAULT_TRAPNO,
>         SIL_FAULT_MCEERR,
>         SIL_FAULT_BNDERR,
>         SIL_FAULT_PKUERR,
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 65888aec65a0..3d3ba7949788 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1194,6 +1194,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>         case SIL_TIMER:
>         case SIL_POLL:
>         case SIL_FAULT:
> +       case SIL_FAULT_TRAPNO:
>         case SIL_FAULT_MCEERR:
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> @@ -2527,6 +2528,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
>  {
>         switch (siginfo_layout(ksig->sig, ksig->info.si_code)) {
>         case SIL_FAULT:
> +       case SIL_FAULT_TRAPNO:
>         case SIL_FAULT_MCEERR:
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> @@ -3206,6 +3208,13 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
>                         if ((sig == SIGBUS) &&
>                             (si_code >= BUS_MCEERR_AR) && (si_code <= BUS_MCEERR_AO))
>                                 layout = SIL_FAULT_MCEERR;
> +                       else if (IS_ENABLED(CONFIG_ALPHA) &&
> +                                ((sig == SIGFPE) ||
> +                                 ((sig == SIGTRAP) && (si_code == TRAP_UNK))))
> +                               layout = SIL_FAULT_TRAPNO;
> +                       else if (IS_ENABLED(CONFIG_SPARC) &&
> +                                (sig == SIGILL) && (si_code == ILL_ILLTRP))
> +                               layout = SIL_FAULT_TRAPNO;
>                         else if ((sig == SIGSEGV) && (si_code == SEGV_BNDERR))
>                                 layout = SIL_FAULT_BNDERR;
>  #ifdef SEGV_PKUERR
> @@ -3317,30 +3326,22 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>                 break;
>         case SIL_FAULT:
>                 to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> +               break;
> +       case SIL_FAULT_TRAPNO:
> +               to->si_addr = ptr_to_compat(from->si_addr);
>                 to->si_trapno = from->si_trapno;
> -#endif
>                 break;
>         case SIL_FAULT_MCEERR:
>                 to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_addr_lsb = from->si_addr_lsb;
>                 break;
>         case SIL_FAULT_BNDERR:
>                 to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_lower = ptr_to_compat(from->si_lower);
>                 to->si_upper = ptr_to_compat(from->si_upper);
>                 break;
>         case SIL_FAULT_PKUERR:
>                 to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_pkey = from->si_pkey;
>                 break;
>         case SIL_PERF_EVENT:
> @@ -3401,30 +3402,22 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>                 break;
>         case SIL_FAULT:
>                 to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> +               break;
> +       case SIL_FAULT_TRAPNO:
> +               to->si_addr = compat_ptr(from->si_addr);
>                 to->si_trapno = from->si_trapno;
> -#endif
>                 break;
>         case SIL_FAULT_MCEERR:
>                 to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_addr_lsb = from->si_addr_lsb;
>                 break;
>         case SIL_FAULT_BNDERR:
>                 to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_lower = compat_ptr(from->si_lower);
>                 to->si_upper = compat_ptr(from->si_upper);
>                 break;
>         case SIL_FAULT_PKUERR:
>                 to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -               to->si_trapno = from->si_trapno;
> -#endif
>                 to->si_pkey = from->si_pkey;
>                 break;
>         case SIL_PERF_EVENT:
> --
> 2.30.1
