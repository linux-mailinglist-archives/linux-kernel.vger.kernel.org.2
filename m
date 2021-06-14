Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788C93A6B40
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhFNQHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhFNQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:07:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B713C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:05:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x14so20867512ljp.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ow7a+sii5rGTLkrzdJ8CF/zyjgA3Ko7ArHu5WM0zFOY=;
        b=pcVFWS9j3xz3+z2SwG8vfG4mk0s2B60pXXIzfrX/S8ZaMJsmtVpLKynNRkTRIuBVYT
         XTsotc0T5WjESI4i+vbJdShTnSaWXoDjGMqiI91qZwB3P7+i05VPnRtEzBdBk6cJXyId
         AJFqrBAntEVTuEyoBUWZUse1WPHGYACF2Nm9yPpGOnOMLB1tmcwVAVeDledwRl4TVO3x
         jeMusJkb6DQFvKDuSt1SaZj5vOrOgeK5W5frjuVZv6ESbHJAlvNDQ+J4v4A36IUNMTc7
         7qJxgntaT3mSB8xKYSPyCtxdfsKekCwtee9DWr/H0NBek+OkJ03yTBCMgDC5eWKuiycg
         7Fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ow7a+sii5rGTLkrzdJ8CF/zyjgA3Ko7ArHu5WM0zFOY=;
        b=hSDdpQilcg/gNUocFcw+4QuKKpNLmW1tWfDhIHwY3WPG9RxxI0JBRE6pQSQ91TNkX7
         wLwpi6gbqj+vjw6+1k0/qijH3gE/ZpjQaTm1X5Vidppb7POXUmfXjCwkWsHEcRBKftCX
         zkXVtZ3FNfIFah0Q6aOUCiKyODQw77HQPe4Foli2mSU/6xPpkc6AyKribgrsuC6kFK7c
         Pu1bqrixL0Ek+wrZCgsYFglL0Aj/q/TFIOuZbf5lWJHMxQXDZtYjwYoj2ZM73IJAG163
         H7ZOKPtw/5FTiSdgrANbVupa7LDNRXITvxdOfm06HzE7ITjyhxaBWjVb8++u5GNitqv4
         6Wag==
X-Gm-Message-State: AOAM530Qw492HHkTbB3PpHeJHjt5Y+xmc4K/k7f+LLLc0Ave21BOwiwt
        ztz3kRnQHaTbz9kU5gFSwhC1JNNblTxj/IvKdlmg2Q==
X-Google-Smtp-Source: ABdhPJwZ9MQ5vsdMZvePpTLaQdMArN0PHh9W12ZVCrWjYO1IRTPO7nsFC8QAjZn4SeuaVcLsFvar8/xGYBTEmK/TM9A=
X-Received: by 2002:a2e:b5b5:: with SMTP id f21mr14340185ljn.479.1623686715439;
 Mon, 14 Jun 2021 09:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
In-Reply-To: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Jun 2021 09:05:04 -0700
Message-ID: <CAKwvOd=PYrMnNOu060T3Z26RJriNXqu3iM85Daink4-BN__2sQ@mail.gmail.com>
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 3:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> As recently discovered, there is no function attribute to disable the
> -fprofile-generate instrumentation. As such, GCOV is fundamentally
> incompatible with architectures that rely on 'noinstr' for correctness.

Is there context for comment, or is this patch meant as a joke?

>
> Until such time as that compilers have added a function attribute to
> disable this instrumentation, mark GCOV as broken.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/Kconfig    | 2 +-
>  kernel/gcov/Kconfig | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 86dae426798b..c0f8c9d4c31a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -75,7 +75,7 @@ config X86
>         select ARCH_HAS_FAST_MULTIPLIER
>         select ARCH_HAS_FILTER_PGPROT
>         select ARCH_HAS_FORTIFY_SOURCE
> -       select ARCH_HAS_GCOV_PROFILE_ALL
> +       select ARCH_HAS_GCOV_BROKEN
>         select ARCH_HAS_KCOV                    if X86_64 && STACK_VALIDATION
>         select ARCH_HAS_MEM_ENCRYPT
>         select ARCH_HAS_MEMBARRIER_SYNC_CORE
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index 58f87a3092f3..74b028a66ebe 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -1,10 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menu "GCOV-based kernel profiling"
>
> +config ARCH_HAS_GCOV_BROKEN
> +       def_bool n
> +
>  config GCOV_KERNEL
>         bool "Enable gcov-based kernel profiling"
>         depends on DEBUG_FS
>         depends on !CC_IS_CLANG || CLANG_VERSION >= 110000
> +       depends on !ARCH_HAS_GCOV_BROKEN
>         select CONSTRUCTORS
>         default n
>         help



-- 
Thanks,
~Nick Desaulniers
