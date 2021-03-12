Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23A3389DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhCLKS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhCLKSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:18:08 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4271CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:18:08 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id x78so26344057oix.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9nT1kdDzpw5kqt3CYTv0XonbOcWSwDlZvC3/pVxkrE=;
        b=Ou5hyZQabcpnNaGK3I/5gnreXdlUyiPyrYxc3dGlWeE4d6myY2/7AW654JABnTlaPK
         ylcLkbGCsys8JiOUZvxnU+puXAbnyjbNsxwwetVXWfgtj7vpG3J20T2xmLEXXwfUloDF
         hjWMPMyp91FEcLT9FV+mp+SRXXS2tYLchFgccHJ+ylJiieLQqkMIeVFe8XHu8sAQ1qBj
         Fb/H2s1zZuRwO/850qetDjCna9p0h+I+FYk1pcqUgKtWj0coLIUibu6X9l/Xs+zfU4dE
         Gz7hIRBbgxLRJgJmRMquKGlYfGW6gJ5nsDn+nhom/uvHk7U9ZhDNoo/9nDNtyWVzN2wO
         ithA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9nT1kdDzpw5kqt3CYTv0XonbOcWSwDlZvC3/pVxkrE=;
        b=mLt6Eo6uEg8Eq1pkMl9OBXX6LBq0RsQ7Ef8LXGTic++yON0Dab1vhJiTQbiyWy7Ks6
         GC8GX/hJ3iFNcyfyl64RLMVDrKBHHZJFYgyn5CEDbEYHNvE6RBATeWqu6szTAubF+2dx
         gPhXl9zcxP3FACaetH132fMlzS+rHYT9Fool+iZS1yohFqDvc9ZMv72ak9AeZwMETYcm
         j/sXqT7Q/rXTO6cFpigxydkBN2WlqXqGKWcrwWb7OfwjDrwI40Jx5831zNb1s7RcLddp
         NNhMkFH8ZjhdWfKPb72a+VWXXEVOD9MzdC2IFdqMO7mB0ycuDUrWfrdI69GU9TwQ3OSE
         6TjA==
X-Gm-Message-State: AOAM530/u1hZIk5B01eTPj/YqlRtn9ahGSjDxcKfTKDJPPyCaPN8eiI0
        8k8g4VlIUXuLj+nQPpocJMU0eTegRcNRFQq/hD0eZQ==
X-Google-Smtp-Source: ABdhPJzUmoUUMNbtNKdSb3Vv2aOKvF3v1305PFWx09SdvYCFak+6E0UnjjdlWbYnB2o9kyQ1lrZSaCi4QP6eEhKpouw=
X-Received: by 2002:aca:530c:: with SMTP id h12mr9374370oib.172.1615544286829;
 Fri, 12 Mar 2021 02:18:06 -0800 (PST)
MIME-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
 <da296c4fe645f724922b691019e9e578e1834557.1615498565.git.andreyknvl@google.com>
In-Reply-To: <da296c4fe645f724922b691019e9e578e1834557.1615498565.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 12 Mar 2021 11:17:54 +0100
Message-ID: <CANpmjNP3bHe2h1=-W7r-64Vg9vr9vREzY0M97uh_QRDr3tVEYQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] kasan: docs: update overview section
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 at 22:37, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Update the "Overview" section in KASAN documentation:
>
> - Outline main use cases for each mode.
> - Mention that HW_TAGS mode need compiler support too.
> - Move the part about SLUB/SLAB support from "Usage" to "Overview".
> - Punctuation, readability, and other minor clean-ups.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  Documentation/dev-tools/kasan.rst | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index c9484f34da2a..343a683d0520 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -11,17 +11,31 @@ designed to find out-of-bound and use-after-free bugs. KASAN has three modes:
>  2. software tag-based KASAN (similar to userspace HWASan),
>  3. hardware tag-based KASAN (based on hardware memory tagging).
>
> -Software KASAN modes (1 and 2) use compile-time instrumentation to insert
> -validity checks before every memory access, and therefore require a compiler
> +Generic KASAN is mainly used for debugging due to a large memory overhead.
> +Software tag-based KASAN can be used for dogfood testing as it has a lower
> +memory overhead that allows using it with real workloads. Hardware tag-based
> +KASAN comes with low memory and performance overheads and, therefore, can be
> +used in production. Either as an in-field memory bug detector or as a security
> +mitigation.
> +
> +Software KASAN modes (#1 and #2) use compile-time instrumentation to insert
> +validity checks before every memory access and, therefore, require a compiler
>  version that supports that.
>
> -Generic KASAN is supported in both GCC and Clang. With GCC it requires version
> +Generic KASAN is supported in GCC and Clang. With GCC, it requires version
>  8.3.0 or later. Any supported Clang version is compatible, but detection of
>  out-of-bounds accesses for global variables is only supported since Clang 11.
>
> -Tag-based KASAN is only supported in Clang.
> +Software tag-based KASAN mode is only supported in Clang.
>
> -Currently generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390
> +The hardware KASAN mode (#3) relies on hardware to perform the checks but
> +still requires a compiler version that supports memory tagging instructions.
> +This mode is supported in Clang 11+.

Doesn't HW_TAGS mode work with GCC as well? While the sentence doesn't
say "exclusively", the mention of Clang 11+ makes me think it's only
Clang.

> +Both software KASAN modes work with SLUB and SLAB memory allocators,
> +while the hardware tag-based KASAN currently only supports SLUB.
> +
> +Currently, generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390,
>  and riscv architectures, and tag-based KASAN modes are supported only for arm64.
>
>  Usage
> @@ -39,9 +53,6 @@ For software modes, you also need to choose between CONFIG_KASAN_OUTLINE and
>  CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
>  The former produces smaller binary while the latter is 1.1 - 2 times faster.
>
> -Both software KASAN modes work with both SLUB and SLAB memory allocators,
> -while the hardware tag-based KASAN currently only support SLUB.
> -
>  For better error reports that include stack traces, enable CONFIG_STACKTRACE.
>
>  To augment reports with last allocation and freeing stack of the physical page,
> --
> 2.31.0.rc2.261.g7f71774620-goog
>
