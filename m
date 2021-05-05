Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA2B374775
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhEER46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhEER4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:56:40 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A97CC026CD4
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 10:27:23 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso2422484ote.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M03sKOxWmfO4zIIvVJvRTj0HkcVDUTsP1sbeJa/EAZM=;
        b=EcCh/rMi5KmwfiXTgOVzyoVd8i5hjF3UHvLH4vJc8mPzzFhcP98szei1CE0cr+uBHk
         tOnj6ZEGDl8PKnDih4+zjCEEkGUN81/KH8KOEYAylIhzmV/k3AfJtBZ4VafnmGpRxjjK
         NQ9DFyme0g0Qonmj5S4uIBUoVOVdq7mo68xbItQuRZSmbSayf8jf6oDQapdeX1Z4nbQI
         ehxiyMgSb51cECe3YmG0xyZ4Re+lNR8tmtbLVPPAg4HRhLAFpVKklUYKhsoPX4wEbXKR
         bfEXh6gC4Sq3ILqJd1c6EVAq0VbUFrXHhNdPvbB868DHKkenWUrnj/RZ0oT2XugfN5yf
         fCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M03sKOxWmfO4zIIvVJvRTj0HkcVDUTsP1sbeJa/EAZM=;
        b=O+a5Ml9owncj0ngCdpmH02R7BVldtn/cNtLJe4QdkYlzQk6/uJlBUg93EWO6OB+KZR
         9wVrbg3uPcswuxRg/1cQ5Xplmz9Cp+HtHMLseD/ApGf84YKMd+6k1UjaTzCfY9o4ye4G
         DCShqn6aYjl0POF8aFYGObnb2IUNzgiZSF0tMRMrQGwoN7Cd5rDr4ns82UVKaRQNggJT
         9M1D7mNk8K68yxCJcaVqY2W87Cy/OaYk65cpmJI6/bizQmwNxEyw5PAn+jEAWy8dDVxe
         KciBdi+RBQSLIELlexbqfI4si9x77rR+1ZC3CBGwjHBCo4z4+Pe25pylgTWY0eCc4JA3
         6vdg==
X-Gm-Message-State: AOAM5337zmJ34nZVkCWSRFTCB5E46WId85RrhWmLqkxnwwy18+LFDCxt
        do74DaXr/lrCbhCS6t+5QE5QNAyKxTTodCJlxgxoDg==
X-Google-Smtp-Source: ABdhPJwnM0M9EJ6eW6nI6X71rFRhMc4rEfbYRTx7ndnQbKdg/JyLCc6Zt9WXMv5yti6eJtKneFxV80R7JjkXaKj5N6M=
X-Received: by 2002:a05:6830:410e:: with SMTP id w14mr23870964ott.251.1620235642416;
 Wed, 05 May 2021 10:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org> <20210505141101.11519-1-ebiederm@xmission.com>
 <20210505141101.11519-9-ebiederm@xmission.com>
In-Reply-To: <20210505141101.11519-9-ebiederm@xmission.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 19:26:00 +0200
Message-ID: <CANpmjNPmPWymJ9ZsQWys9wC3okt5M5fj7edp7ejk8RpTTMsxew@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] signal: Rename SIL_PERF_EVENT
 SIL_FAULT_PERF_EVENT for consistency
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
> It helps to know which part of the siginfo structure the siginfo_layout
> value is talking about.
>
> v1: https://lkml.kernel.org/r/m18s4zs7nu.fsf_-_@fess.ebiederm.org
> Acked-by: Marco Elver <elver@google.com>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Reviewed-by: Marco Elver <elver@google.com>



> ---
>  fs/signalfd.c          |  2 +-
>  include/linux/signal.h |  2 +-
>  kernel/signal.c        | 10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index e87e59581653..83130244f653 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -132,7 +132,7 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>                 new.ssi_addr = (long) kinfo->si_addr;
>                 new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
>                 break;
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 new.ssi_addr = (long) kinfo->si_addr;
>                 new.ssi_perf = kinfo->si_perf;
>                 break;
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 5160fd45e5ca..ed896d790e46 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -44,7 +44,7 @@ enum siginfo_layout {
>         SIL_FAULT_MCEERR,
>         SIL_FAULT_BNDERR,
>         SIL_FAULT_PKUERR,
> -       SIL_PERF_EVENT,
> +       SIL_FAULT_PERF_EVENT,
>         SIL_CHLD,
>         SIL_RT,
>         SIL_SYS,
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 7eaa8d84db4c..697c5fe58db8 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1198,7 +1198,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>         case SIL_FAULT_MCEERR:
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>         case SIL_SYS:
>                 ret = false;
>                 break;
> @@ -2553,7 +2553,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
>         case SIL_FAULT_MCEERR:
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 ksig->info.si_addr = arch_untagged_si_addr(
>                         ksig->info.si_addr, ksig->sig, ksig->info.si_code);
>                 break;
> @@ -3243,7 +3243,7 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
>                                 layout = SIL_FAULT_PKUERR;
>  #endif
>                         else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
> -                               layout = SIL_PERF_EVENT;
> +                               layout = SIL_FAULT_PERF_EVENT;
>                 }
>                 else if (si_code <= NSIGPOLL)
>                         layout = SIL_POLL;
> @@ -3365,7 +3365,7 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>                 to->si_addr = ptr_to_compat(from->si_addr);
>                 to->si_pkey = from->si_pkey;
>                 break;
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 to->si_addr = ptr_to_compat(from->si_addr);
>                 to->si_perf = from->si_perf;
>                 break;
> @@ -3441,7 +3441,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>                 to->si_addr = compat_ptr(from->si_addr);
>                 to->si_pkey = from->si_pkey;
>                 break;
> -       case SIL_PERF_EVENT:
> +       case SIL_FAULT_PERF_EVENT:
>                 to->si_addr = compat_ptr(from->si_addr);
>                 to->si_perf = from->si_perf;
>                 break;
> --
> 2.30.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210505141101.11519-9-ebiederm%40xmission.com.
