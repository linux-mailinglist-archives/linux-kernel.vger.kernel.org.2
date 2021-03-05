Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27032EF4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCEPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCEPq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:46:28 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA40AC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 07:46:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id p21so1641992pgl.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/UOJ2ouh3jCawvJJDBF9MwK+LARNE7PChR+Eq9d4AQ=;
        b=S5LjfiLSKYQc9wli5WdLPG7UnO4uz8ho5JaGL0zEOrrBBkr/6p95xugqZkpfkhKuem
         jqnwm4JkB28oVYhXnDY6GQsBItbTDGOTEeqtzua5N4FrMc3ZMxGnNZlkQ10JQfaNMlaS
         4fYA81RQP9+uqpFVfwGPC6TqQjWRTAA3Mhf5Fh9kKxd/6vu0dOFTjuV9jiW/hFs8kru9
         QykbmTgx7Awo9enlnhQnT8EAJhlik04Oq8+JYAj9N3/drT05icPaByhZx10IDltb4Ydp
         c1WY30SghrZlHPlWXRhQSKv5SRVyeDHmOgR6jQx0MxHGTjkIgfxL9JGdsMSUzY2W14vw
         u0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/UOJ2ouh3jCawvJJDBF9MwK+LARNE7PChR+Eq9d4AQ=;
        b=IWGcL/i79sLHNLUl27a7vuXk31WekDuEG3+rbInheblYK4s096kqJBWVdE4GVn4TsE
         xz3p1vN25Q0zWxiKIXA0n/R46W7CHqkwsTMW+2k2ri+Mxb68ImoEfRYqUxxLG0UtXJ3f
         gnfZO9IWofZ8Qo+0NGnYDApFXorR3zi2BQEiDQNl4ExMVzCjaeNuDr06mgwObbYJPEMn
         5EV3QodymbtiezQnqdYvy9B4mbAlV+hvZOnB+LWXQFshOrJFo795AnkxEj/A6imDLYvX
         o079IesIPerhzUjGESW9YIhspBbW3KV7+3i9NO2uFswZDeZEwg4Uhjl6nn6IJ+kbR73A
         6LmA==
X-Gm-Message-State: AOAM532Y35xe+SYyAIafXMjhWjzb1FXUMANCaCVR7rwYGmJYO74Sk3ij
        vBpLxPiIgldZmAnB0M+TWX7s+968vBGMfC/m/SVecQ==
X-Google-Smtp-Source: ABdhPJzD0IwSq/hfOwQNOKZVQtfXWou6YobAr/snMkCbwdnO2pajqgzJFqn1NKRMbXz24kvC5QKlTxfaMxooPJ0CJR8=
X-Received: by 2002:a63:455d:: with SMTP id u29mr8980133pgk.286.1614959186302;
 Fri, 05 Mar 2021 07:46:26 -0800 (PST)
MIME-Version: 1.0
References: <c8e93571c18b3528aac5eb33ade213bf133d10ad.1613692950.git.andreyknvl@google.com>
In-Reply-To: <c8e93571c18b3528aac5eb33ade213bf133d10ad.1613692950.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 5 Mar 2021 16:46:15 +0100
Message-ID: <CAAeHK+xaPBNB+VpXcj_Xdk0qg-FgDe9i1m4mEY1-ChxQND_8kA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kasan: initialize shadow to TAG_INVALID for SW_TAGS
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 1:22 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Currently, KASAN_SW_TAGS uses 0xFF as the default tag value for
> unallocated memory. The underlying idea is that since that memory
> hasn't been allocated yet, it's only supposed to be dereferenced
> through a pointer with the native 0xFF tag.
>
> While this is a good idea in terms on consistency, practically it
> doesn't bring any benefit. Since the 0xFF pointer tag is a match-all
> tag, it doesn't matter what tag the accessed memory has. No accesses
> through 0xFF-tagged pointers are considered buggy by KASAN.
>
> This patch changes the default tag value for unallocated memory to 0xFE,
> which is the tag KASAN uses for inaccessible memory. This doesn't affect
> accesses through 0xFF-tagged pointer to this memory, but this allows
> KASAN to detect wild and large out-of-bounds invalid memory accesses
> through otherwise-tagged pointers.
>
> This is a prepatory patch for the next one, which changes the tag-based
> KASAN modes to not poison the boot memory.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/kasan.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 14f72ec96492..44c147dae7e3 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -30,7 +30,8 @@ struct kunit_kasan_expectation {
>  /* Software KASAN implementations use shadow memory. */
>
>  #ifdef CONFIG_KASAN_SW_TAGS
> -#define KASAN_SHADOW_INIT 0xFF
> +/* This matches KASAN_TAG_INVALID. */
> +#define KASAN_SHADOW_INIT 0xFE
>  #else
>  #define KASAN_SHADOW_INIT 0
>  #endif
> --
> 2.30.0.617.g56c4b15f3c-goog
>

Hi Andrew,

Could you pick up this series into mm?

The discussion on v1 of this series was hijacked discussing an unrelated issue.

Thanks!
