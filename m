Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD082314028
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhBHURG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhBHSrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:47:23 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0A9C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 10:46:43 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id f1so817995oou.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiy4+L1TKc0lecuM77Q8fHlOhBTJ6Asny2DXxHTJcDo=;
        b=sCxbX8R2f2bvawMHT3qjLo0h0zjmMVkbthbZc/FGNTuQlti07fDdGZt78TBsutbnQI
         oCY8HQ3wAvVEQ/T6y7QOVvt9XsrFxDi+cORohR5IvXM3swUFWfH3phMxyt5+CbiaUvsI
         LkuDmSHFecb/k/x2VI2Rr67mElyyCB5aXzgHmXNJP9OtdxIfTYYz5joOSs3l2FPRuq0T
         WTwVwprmUQAm8MXf0VOshOtXu1zPaQxD9xAGWlw9P3KPrHroqJ8XfHmCRnvxa71ezi4D
         vRlTwa/QJDt0uzrC4S0S0HDQkT9SmEO+4kT2ANyC46ddq6KLtrj3VIna4XwyLenGInz8
         w+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiy4+L1TKc0lecuM77Q8fHlOhBTJ6Asny2DXxHTJcDo=;
        b=LawboLBQ3z6c1uU47kmgpBQ2xJ9ltLQfgDbni4IVEqF96HnoO5gXQF0rxRWvba2TDn
         zRjtpw+K/TYqxi8OGFOGnHDR3yJg+iI00O/LeEc85Dr9p78AvZUFK+k2fnGdQmVkwW+m
         lxx7nFIuwE00dAyp9OpKRv0ELt0xhumLaF6kLhuvirGu2jvamy5CxkpId/NSetHbB/Yk
         M9NCCVu4dycfnTZh082+bg1papiaC3gDVLE1TfqMESmid5S6E1Y/SM1K2tXX6lxrXAwK
         yGm373WrriLTEEKrN3LwKq/cfyjDDY9/2ZU5rmWvvG43oA9HL3Zw36unvB+np05vxSbT
         utiw==
X-Gm-Message-State: AOAM530clFBTf5i7CxSvDQAif50evaWCtUBcCsLb5sEToM0xSV3HBEcK
        +zxCMg35l911+HPOELrRHin5b9qK5x5fTGnI7pGJfw==
X-Google-Smtp-Source: ABdhPJzKG3qMZs4qHobju9rjHTgVd7yAMQ7y0XNCIsRGy6N0KqdU8kcdVfEX5R+R8I47cBrzDrUM+oTLxEp2nmYQ1K8=
X-Received: by 2002:a4a:aa8b:: with SMTP id d11mr10012285oon.36.1612810002329;
 Mon, 08 Feb 2021 10:46:42 -0800 (PST)
MIME-Version: 1.0
References: <6678d77ceffb71f1cff2cf61560e2ffe7bb6bfe9.1612808820.git.andreyknvl@google.com>
In-Reply-To: <6678d77ceffb71f1cff2cf61560e2ffe7bb6bfe9.1612808820.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 8 Feb 2021 19:46:30 +0100
Message-ID: <CANpmjNOkWozE5q2f-w0xTKxi1nDoPy+pMuZ7T78WBMmQ=XpgJg@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix stack traces dependency for HW_TAGS
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 at 19:40, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Currently, whether the alloc/free stack traces collection is enabled by
> default for hardware tag-based KASAN depends on CONFIG_DEBUG_KERNEL.
> The intention for this dependency was to only enable collection on slow
> debug kernels due to a significant perf and memory impact.
>
> As it turns out, CONFIG_DEBUG_KERNEL is not considered a debug option
> and is enabled on many productions kernels including Android and Ubuntu.
> As the result, this dependency is pointless and only complicates the code
> and documentation.
>
> Having stack traces collection disabled by default would make the hardware
> mode work differently to to the software ones, which is confusing.
>
> This change removes the dependency and enables stack traces collection
> by default.
>
> Looking into the future, this default might makes sense for production
> kernels, assuming we implement a fast stack trace collection approach.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

I'm in favor of this simplification.

The fact that CONFIG_DEBUG_KERNEL cannot be relied upon to determine
if we're running a debug kernel or not is a bit unfortunate though.

Thanks!

> ---
>  Documentation/dev-tools/kasan.rst | 3 +--
>  mm/kasan/hw_tags.c                | 8 ++------
>  2 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 1651d961f06a..a248ac3941be 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -163,8 +163,7 @@ particular KASAN features.
>  - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>
>  - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
> -  traces collection (default: ``on`` for ``CONFIG_DEBUG_KERNEL=y``, otherwise
> -  ``off``).
> +  traces collection (default: ``on``).
>
>  - ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
>    report or also panic the kernel (default: ``report``).
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index e529428e7a11..d558799b25b3 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -134,12 +134,8 @@ void __init kasan_init_hw_tags(void)
>
>         switch (kasan_arg_stacktrace) {
>         case KASAN_ARG_STACKTRACE_DEFAULT:
> -               /*
> -                * Default to enabling stack trace collection for
> -                * debug kernels.
> -                */
> -               if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> -                       static_branch_enable(&kasan_flag_stacktrace);
> +               /* Default to enabling stack trace collection. */
> +               static_branch_enable(&kasan_flag_stacktrace);
>                 break;
>         case KASAN_ARG_STACKTRACE_OFF:
>                 /* Do nothing, kasan_flag_stacktrace keeps its default value. */
> --
> 2.30.0.478.g8a0d178c01-goog
>
