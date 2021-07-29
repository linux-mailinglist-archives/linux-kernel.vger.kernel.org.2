Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F333DA8E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhG2QYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG2QYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:24:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30304C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:24:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x90so8967246ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35AM3fqjux8sQjvxaMCs/fEwv+/6cy6TsxugeFlLehQ=;
        b=Y+ELfTY3na5Cw/M+5WJaqCUExNYBs7wsS+JqLBCiji30HG9DwkuC3jzIyuGdQ/xb22
         XfX/dbQN3ASr1IOUoSSzNRxcQQ03Y85oVi+dpXpaj3Cvunfg5Lg9LMz5dfv2+lPVfQzL
         myhpUzY+FDofTs5R2kmOMy0ydg3DhjoSdKJF/lbsw8mTbkYaIeBli1eGfxVQC22FSDCz
         ctl2dyNSYyqLcCwbmtFMPKzxpT1f0sRKejTw+cJjzE2w5SnglkdjnU6HDGh+wwo/XgM5
         pEthoS9YPk5A9XBeiu0b9IgOYblhypqsRIkyXLwVIcW+o7/Ij8ljQcGoLCfK4kNvNl2n
         hG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35AM3fqjux8sQjvxaMCs/fEwv+/6cy6TsxugeFlLehQ=;
        b=PaezQEoAsvZ/VzY/ZrDKyx2iw8RmgLTDliWYjeS64Fbq6jBqs1cPE8un4k8sd523eP
         LWRLVPdhpEqwKGd3F5KJooIMwcb98llciq6H5Uky1VXd1Gk2TV0yyGa9Tv9pYz+lURxj
         jOev1u53xBY1zuDvyOlAX9SAKZNbkj+FMuv5iR3wFcBRQOE36Mfs7gQTEDB4Ub3NOsKS
         a4tU8VcYHFWq6QW9AwFARDuLZ7WWJw1bGTXOTy5V1G4gyYx4tX6tSQa2JWraP1sAye8g
         9OxaHjF/T0FHarJ69mTdJmMwgB8SoINY778A3E+cuWZ9gt1IaBF15sXH6Rnd/GH6ciuT
         yCWA==
X-Gm-Message-State: AOAM5303VixkaEuMhYViFzFB8KZu3Uqw//vv/R808U2T0tAJNM1IvYsg
        M+TF1APYKU3uiNgAKbWQEoAtSVSfuYmMFiUqfR9M5g==
X-Google-Smtp-Source: ABdhPJwRpFcwbhLvLHl0mAfSs4Jojm6glDjVp1gyYkKz6zfpGsJb8/o+iXrl9CTyErsbW7q9scOrO3K5ykXWK7Gc68o=
X-Received: by 2002:a50:954c:: with SMTP id v12mr6911093eda.313.1627575865655;
 Thu, 29 Jul 2021 09:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <YQK9ziyogxTH0m9H@hirez.programming.kicks-ass.net>
In-Reply-To: <YQK9ziyogxTH0m9H@hirez.programming.kicks-ass.net>
From:   hev <r@hev.cc>
Date:   Fri, 30 Jul 2021 00:24:14 +0800
Message-ID: <CAHirt9hsN9cy16TKSn7Bb+HG5M52FR1Ct8=7xDiM14+5K_S8eg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/atomic_t: Document forward progress expectations
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        huacai chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, geert@linux-m68k.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        wangrui <wangrui@loongson.cn>, lixuefeng <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On Thu, Jul 29, 2021 at 10:40 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Add a few words on forward progress; there's been quite a bit of
> confusion on the subject.
>
> Specifically, more complex locking primitives (ticket/qspinlock) require
> forward progress from their consituent operations in order to provide
> better/more guarantees than TaS locks.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Will Deacon <will@kernel.org>
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -312,3 +312,56 @@ Both provide the same functionality, but
>
>  NB. try_cmpxchg() also generates better code on some platforms (notably x86)
>  where the function more closely matches the hardware instruction.
> +
> +
> +FORWARD PROGRESS
> +----------------
> +
> +In general strong forward progress is expected of all unconditional atomic
> +operations -- those in the Arithmetic and Bitwise classes and xchg(). However
> +a fair amount of code also requires forward progress from the conditional
> +atomic operations.
> +
> +Specifically 'simple' cmpxchg() loops are expected to not starve one another
> +indefinitely. However, this is not evident on LL/SC architectures, because
> +while an LL/SC architecure 'can/should/must' provide forward progress
> +guarantees between competing LL/SC sections, such a guarantee does not
> +transfer to cmpxchg() implemented using LL/SC. Consider:

Thanks for your explanation.

> +
> +  old = atomic_read(&v);
> +  do {
> +    new = func(old);
> +  } while (!atomic_try_cmpxchg(&v, &old, new));

We may need new APIs to help LL/SC to implement atomic operations, but
this is obviously incompatible with native CAS. and many and many
common functions are CAS friendly. Let's more functions that implement
atomic semantics can be overridden by architecture may be a way. ;-)

In the above example, the correct implementation on LL/SC may be like:

do {
    old = LL(&v);
    new = func(old, &skip);
    if (skip) {
        break;
    }
} while (!SC(&v, new);

However, the success of SC may be affected by the inconstant
complexity of func. :-(

Regards,
Rui

> +
> +which on LL/SC becomes something like:
> +
> +  old = atomic_read(&v);
> +  do {
> +    new = func(old);
> +  } while (!({
> +    volatile asm ("1: LL  %[oldval], %[v]\n"
> +                  "   CMP %[oldval], %[old]\n"
> +                  "   BNE 2f\n"
> +                  "   SC  %[new], %[v]\n"
> +                  "   BNE 1b\n"
> +                  "2:\n"
> +                  : [oldval] "=&r" (oldval), [v] "m" (v)
> +                 : [old] "r" (old), [new] "r" (new)
> +                  : "memory");
> +    success = (oldval == old);
> +    if (!success)
> +      old = oldval;
> +    success; }));
> +
> +However, even the forward branch from the failed compare can cause the LL/SC
> +to fail on some architectures, let alone whatever the compiler makes of the C
> +loop body. As a result there is no guarantee what so ever the cacheline
> +containing @v will stay on the local CPU and progress is made.
> +
> +Even native CAS architectures can fail to provide forward progress for their
> +primitive (See Sparc64 for an example).
> +
> +Such implementations are strongly encouraged to add exponential backoff loops
> +to a failed CAS in order to ensure some progress. Affected architectures are
> +also strongly encouraged to inspect/audit the atomic fallbacks, refcount_t and
> +their locking primitives.
