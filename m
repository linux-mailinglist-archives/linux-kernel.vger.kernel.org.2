Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5960B3A60BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhFNKhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:37:19 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:45855 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhFNKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:34:41 -0400
Received: by mail-oo1-f43.google.com with SMTP id q20-20020a4a6c140000b029024915d1bd7cso2523327ooc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3zVS6nyi7LiL4xn1RNS2VQkLq9gRbTSKDhN/ZJSarM=;
        b=FAyM5z53qVuI7g5skOJEti9RDZqIbJt0/3K/mjKqfLf0ipT1HoDrm0xpsDboofxzlA
         mwuTZHM9E8FuZa4rhdTkkeqwLYDf/Nv90nU8z0wEPH/RjywIvYrVnJmFMZq1nWy/3ksY
         byvogLI1Na5YRXurst+e6TFQNSwnEAefuQbQ2oN3JB/yeF4hjW3jAxptQS02OXcJgk43
         5zj4cm18eGPOWdatgkAFfDTUgx34PUD+s4RNYcP7XmzC6UrAitd/JEghOKbVbhNN5E3i
         CDDN9t6Oa+XSBaDEuDqLL+XXVhHa1ZZbXAYP4pqM87vnFETCcQjIxYtuTcCOBtBvqhqR
         xveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3zVS6nyi7LiL4xn1RNS2VQkLq9gRbTSKDhN/ZJSarM=;
        b=MRzXzsM+JSJKhHDPtg2103HRQDYgk8UL7EpwssMCOJAaFF4R35VFTI3UHx+pgNTjdR
         eZ+OnCxcVMRzZey4LX14bCLl/U+2MGm1mR9oxrvtd+84nAXAH03AhrWiCvCrIyTcdaaP
         mEMhahJtF/j5crzK90/nhaJsZUe64r8F4VOPnvSSYvgMJ7DtAQC1Uj+Hab/+4SneAer9
         AKy2HOW6yMMnlyeDrqvkZu4KnvKgPXWZrkvRP8oMMo9fp0UPi46XnKabH9diZqScfKd4
         G7fzTN0Lb4Bt86bpdUsM/2/6sbU9r/mATJMzJbu9GRW9ar6KuAwxJzw25xUtc5Bnrdw/
         Dl/Q==
X-Gm-Message-State: AOAM533M6DLT2pQVt7FyOKbg4hWolexCaasLw1ydF0OlHykvVgSWGDvN
        lCWBzbhsX3ZbZxgRHWZ4wG4Pt6ZMiNOPpBVDa/PgrA==
X-Google-Smtp-Source: ABdhPJxQU9aS5c7LhdzMGD9O5VDN8lHkLArVFi8SlZOhS7/4OwgF7vi2WhiUmkc1b51ySGandx+KwIHmKaBN6Y5Fuv0=
X-Received: by 2002:a4a:c101:: with SMTP id s1mr12588790oop.54.1623666698514;
 Mon, 14 Jun 2021 03:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
In-Reply-To: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Jun 2021 12:31:27 +0200
Message-ID: <CANpmjNN2Jv=2AqH0ZbwrVwSG9XMzkyHGdhM6tYhoK5DokYbnig@mail.gmail.com>
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, johannes.berg@intel.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 at 12:17, Peter Zijlstra <peterz@infradead.org> wrote:
> As recently discovered, there is no function attribute to disable the
> -fprofile-generate instrumentation. As such, GCOV is fundamentally
> incompatible with architectures that rely on 'noinstr' for correctness.

GCOV today uses only -fprofile-arcs -ftest-coverage. But the problem
is the same: https://godbolt.org/z/fr9cs4sar

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
