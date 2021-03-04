Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0732D8A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbhCDRfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbhCDRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:35:23 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87637C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:34:42 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id r25so33378676ljk.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nhQUkZdRR30HOXaJaC3+WVNEIt/nPm3693Z/MPSB2r4=;
        b=ov8/nFemh04xcClicqEhm2CKTF68mlWX4fbewlfrQquTos5Q3Ij2wtZf85pZbZW1jd
         K5Nc7FrFtHnACQD3XKUTKNqs4qPoGqb12V1kY8Aav4pewPbBGXGfuHnxA4cE9iQWj1qB
         YWv2zzHp/EOdGU0Qi/j1nfAaa4EzOQJPswyJBQFg19pWHOfg7oUuzUFKo2NZHAmROGTy
         H321ypSLL9GY51oNtfR9mlJIATi/5mfNyHxwHWxGmP5F20YiIx0Tgqmp5tMmwRy/FdFa
         I2Lp39d2u79X3VRMKtgE2KMkl6wRjRfEEuUW6iOva0Krwo4wnh5e8Tu4TW3sqlmMIrF7
         Nacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nhQUkZdRR30HOXaJaC3+WVNEIt/nPm3693Z/MPSB2r4=;
        b=Nuzo5X+wTUvVrhOWGoCfzBFBB5KUxMrSQYacfiyf2EesPfulwFXozK/Bg1OGE2E9Pc
         fnjiLuicn4g6mf11Asrp/f8nIq9BMAYXayaga5WRoZry+Rx0HoQThlVrSdOi1Aqj+Zoh
         ZAp3HUJu4MyLXQmSq+Dhv3HmsWNKRXNV8Nh11kfQHPFJuaaJLjV0noXJJdS+9AsmaZpg
         O3Q1/w9lIGEjQw+8TLzucdHyGwhQm9LXIF2drDz4OGshzE9fMNyK8InPlA1CRP7neEBV
         nFRRLVeY/GLn0REMaV4RmyqBxHp2WMJqfe/BK+ZQlIPphRa/tGudJ3cwgtNrXDK1g18x
         A3IA==
X-Gm-Message-State: AOAM533eqAQAINmExu0zapDI++x0YAOEK2certeTiKDXl6taIyWUcEJ3
        32ffPS/9sRKsbcXFSQoEqmjSw1yN9dXnEghYb93EiQ==
X-Google-Smtp-Source: ABdhPJwwlh2BXoxhEWn2erlfVDtxlWvjhy6xEvcLNTwh3PCC5vbRdY6trf7MTSf6jtRahgK3qJ/J3cLgeJXY+4ptY3U=
X-Received: by 2002:a2e:868e:: with SMTP id l14mr2906875lji.479.1614879280871;
 Thu, 04 Mar 2021 09:34:40 -0800 (PST)
MIME-Version: 1.0
References: <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net> <20210303224653.2579656-1-joshdon@google.com>
In-Reply-To: <20210303224653.2579656-1-joshdon@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Mar 2021 09:34:29 -0800
Message-ID: <CAKwvOdmijctJfM3gNfwEVjaQyp3LZkhnAwgsT7EBhsSBJyfLAA@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Optimize __calc_delta.
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 2:48 PM Josh Don <joshdon@google.com> wrote:
>
> From: Clement Courbet <courbet@google.com>
>
> A significant portion of __calc_delta time is spent in the loop
> shifting a u64 by 32 bits. Use `fls` instead of iterating.
>
> This is ~7x faster on benchmarks.
>
> The generic `fls` implementation (`generic_fls`) is still ~4x faster
> than the loop.
> Architectures that have a better implementation will make use of it. For
> example, on X86 we get an additional factor 2 in speed without dedicated
> implementation.
>
> On gcc, the asm versions of `fls` are about the same speed as the
> builtin. On clang, the versions that use fls are more than twice as
> slow as the builtin. This is because the way the `fls` function is
> written, clang puts the value in memory:
> https://godbolt.org/z/EfMbYe. This bug is filed at
> https://bugs.llvm.org/show_bug.cgi?id=3D49406.

Hi Josh, Thanks for helping get this patch across the finish line.
Would you mind updating the commit message to point to
https://bugs.llvm.org/show_bug.cgi?id=3D20197?

>
> ```
> name                                   cpu/op
> BM_Calc<__calc_delta_loop>             9.57ms =C2=B112%
> BM_Calc<__calc_delta_generic_fls>      2.36ms =C2=B113%
> BM_Calc<__calc_delta_asm_fls>          2.45ms =C2=B113%
> BM_Calc<__calc_delta_asm_fls_nomem>    1.66ms =C2=B112%
> BM_Calc<__calc_delta_asm_fls64>        2.46ms =C2=B113%
> BM_Calc<__calc_delta_asm_fls64_nomem>  1.34ms =C2=B115%
> BM_Calc<__calc_delta_builtin>          1.32ms =C2=B111%
> ```
>
> Signed-off-by: Clement Courbet <courbet@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/fair.c  | 19 +++++++++++--------
>  kernel/sched/sched.h |  1 +
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a8bd7b13634..a691371960ae 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -229,22 +229,25 @@ static void __update_inv_weight(struct load_weight =
*lw)
>  static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct loa=
d_weight *lw)
>  {
>         u64 fact =3D scale_load_down(weight);
> +       u32 fact_hi =3D (u32)(fact >> 32);
>         int shift =3D WMULT_SHIFT;
> +       int fs;
>
>         __update_inv_weight(lw);
>
> -       if (unlikely(fact >> 32)) {
> -               while (fact >> 32) {
> -                       fact >>=3D 1;
> -                       shift--;
> -               }
> +       if (unlikely(fact_hi)) {
> +               fs =3D fls(fact_hi);
> +               shift -=3D fs;
> +               fact >>=3D fs;
>         }
>
>         fact =3D mul_u32_u32(fact, lw->inv_weight);
>
> -       while (fact >> 32) {
> -               fact >>=3D 1;
> -               shift--;
> +       fact_hi =3D (u32)(fact >> 32);
> +       if (fact_hi) {
> +               fs =3D fls(fact_hi);
> +               shift -=3D fs;
> +               fact >>=3D fs;
>         }
>
>         return mul_u64_u32_shr(delta_exec, fact, shift);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 10a1522b1e30..714af71cf983 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -36,6 +36,7 @@
>  #include <uapi/linux/sched/types.h>
>
>  #include <linux/binfmts.h>
> +#include <linux/bitops.h>

This hunk of the patch is curious.  I assume that bitops.h is needed
for fls(); if so, why not #include it in kernel/sched/fair.c?
Otherwise this potentially hurts compile time for all TUs that include
kernel/sched/sched.h.

>  #include <linux/blkdev.h>
>  #include <linux/compat.h>
>  #include <linux/context_tracking.h>
> --
> 2.30.1.766.gb4fecdf3b7-goog
>


--=20
Thanks,
~Nick Desaulniers
