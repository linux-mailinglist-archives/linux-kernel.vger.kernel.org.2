Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54347311464
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhBEWFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhBEO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:57:43 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B619C061793
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:25:56 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g3so3832695plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAV6woYg0kfqY+8ibsodS4//9eDsxI9wZiwPSoFnDsw=;
        b=YWfA2TQ5ApvZiaB/IqgvOHh0zr5cPm+JHUeKZ3MWatPWqRn+mvCJRLw/TwPHlOjRX3
         xSzjR3V9y59pebgurUiBcvvHg+NeXKpZNzzyfxxhKXfVgRx86huXB3XiDaEup1uA3iZu
         58WHlIewB/n6yqYVlpdN2029/6Xn3wg2TRyryIQtMn0Jsn+i+ZMW8jyL6K71IhSHNL33
         E1X/C2e96YJz8ZE451WxgNnwUhqWRee0PR7JOK+kUsqhvgZTq/Mh4RPW3a+Ch+rZ9rYJ
         ykElq77xB8X64yHy+M0EZZCevdU23gKPsL+WVLfFgJKRcLus7h61IuWtG43Pf0p+Tksc
         1+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAV6woYg0kfqY+8ibsodS4//9eDsxI9wZiwPSoFnDsw=;
        b=FiGDNH0lTgC970kyjDOvk6x3hFR7jE+m/GVWGkcpQGuuhrvwiQK8m+JOSaOGnoYxgp
         54vegcOZ7Q3N4bU96YZ9+oIjvG09I33CHI42ZlOJSm+x77/eUFyIj9den37SzPdd92VF
         TeJ9TsOssIxb84Ctmm3lQSLi0LokxuGexYaRtIkAFu40Q+0o2N+MZ0Xk9bLpuec9HZjC
         2Fl//4bMtWTumBP4DEhQeF6HF2ogpZ6lNRN8b3QZOAfu+PlXkrXj9ERw0/XQi//q+k7A
         AZo0+022nNLN/b0zddYdlPD4fZ3w4Y5zGo2rs2gT9Q6/QnAL8G0bcuER4k23oPs1dCyZ
         ocAw==
X-Gm-Message-State: AOAM531WuDJbK86Y1uIJkb95s7rYLe+pDR5bktsBr6UYRRHAPz3am/XX
        aDfVcaonfsNwl2+MDS5TPlzjDCsUKiwi2seobSNNMA==
X-Google-Smtp-Source: ABdhPJz7hg3W9UVrqwUtxXCMXQuIfjDWNNH7DXXlqilvLV51Hybl4F2VuwOFjYZCYn1biMA69T6PJSx+PVqU/vuc6IU=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr4812469pjb.166.1612542355340;
 Fri, 05 Feb 2021 08:25:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 5 Feb 2021 17:25:44 +0100
Message-ID: <CAAeHK+zv7U_oN1WVqQNhorL4Gf9G-hFb120o3XFO9RDtY7TEpQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] kasan: optimizations and fixes for HW_TAGS
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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

On Fri, Feb 5, 2021 at 4:39 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patchset goes on top of:
>
> 1. Vincenzo's async support patches [1], and
> 2. "kasan: untag addresses for KFENCE" fix [2] (already in mm).
>
> [1] https://lore.kernel.org/linux-arm-kernel/20210130165225.54047-1-vincenzo.frascino@arm.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=akpm&id=dec4728fab910da0c86cf9a97e980f4244ebae9f
>
> This patchset makes the HW_TAGS mode more efficient, mostly by reworking
> poisoning approaches and simplifying/inlining some internal helpers.
>
> With this change, the overhead of HW_TAGS annotations excluding setting
> and checking memory tags is ~3%. The performance impact caused by tags
> will be unknown until we have hardware that supports MTE.
>
> As a side-effect, this patchset speeds up generic KASAN by ~15%.

Forgot to include changes v1->v2:

- Use EXPORT_SYMBOL_GPL() for arm64 symbols.
- Rename kmalloc bool flag argument to is_kmalloc.
- Make empty mte_set_mem_tag_range() return void.
- Fix build warning in 32-bit systems by using unsigned long instead
of u64 in WARN_ON() checks.
- Minor changes in comments and commit descriptions.
- Use kfence_ksize() before __ksize() to avoid crashes with KFENCE.
- Use inline instead of __always_inline.

>
> Andrey Konovalov (12):
>   kasan, mm: don't save alloc stacks twice
>   kasan, mm: optimize kmalloc poisoning
>   kasan: optimize large kmalloc poisoning
>   kasan: clean up setting free info in kasan_slab_free
>   kasan: unify large kfree checks
>   kasan: rework krealloc tests
>   kasan, mm: fail krealloc on freed objects
>   kasan, mm: optimize krealloc poisoning
>   kasan: ensure poisoning size alignment
>   arm64: kasan: simplify and inline MTE functions
>   kasan: inline HW_TAGS helper functions
>   arm64: kasan: export MTE symbols for KASAN tests
>
>  arch/arm64/include/asm/cache.h     |   1 -
>  arch/arm64/include/asm/kasan.h     |   1 +
>  arch/arm64/include/asm/mte-def.h   |   2 +
>  arch/arm64/include/asm/mte-kasan.h |  65 ++++++++--
>  arch/arm64/include/asm/mte.h       |   2 -
>  arch/arm64/kernel/mte.c            |  48 +-------
>  arch/arm64/lib/mte.S               |  16 ---
>  include/linux/kasan.h              |  25 ++--
>  lib/test_kasan.c                   | 111 +++++++++++++++--
>  mm/kasan/common.c                  | 187 ++++++++++++++++++++---------
>  mm/kasan/kasan.h                   |  72 +++++++++--
>  mm/kasan/shadow.c                  |  53 ++++----
>  mm/slab_common.c                   |  18 ++-
>  mm/slub.c                          |   3 +-
>  14 files changed, 418 insertions(+), 186 deletions(-)
>
> --
> 2.30.0.365.g02bc693789-goog
>
