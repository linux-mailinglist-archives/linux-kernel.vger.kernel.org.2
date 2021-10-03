Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25A8420322
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 19:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhJCRqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhJCRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:46:46 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255D7C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 10:44:59 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d11so15948296ilc.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mp4gE8Pdgp9F3QsQ+TI83mCss9lxb0cc4P5dIGC4QWc=;
        b=ljhVUGUphjqw2ccqU0U6PFKZug3bprMQDP+SixGvRjPWpgw79/RqkAMzpc0LUO1JAs
         ckg2SJpMvWyLIBYUCh1pyoFdvRnQ++d3V6SzizMHHvjCZA/oNeXXrg/+20YN3u2DBNyx
         2wuZ6k1pCf/ZLo2WN9GoQrxzlIykrDOdZdVVUsgXBdXPIM2hFuEDnppYZ9eVldddbZ7G
         Qx4vU3WyWn1QuPRwWK3//Jc06IBTWxBHhVLTllpalU2aHYYEBznd9ASEvJrXlkpzAvD4
         RZajkCzhgAo6bR049QZLG0jQG0z3BW2NRLlgtaTp4JWoaT32aRuyFUqP6ASRd8SEpxq1
         6QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mp4gE8Pdgp9F3QsQ+TI83mCss9lxb0cc4P5dIGC4QWc=;
        b=fUC5xT7meJLwYsvCfilMyYYgHvsWAZZpbjXQo80Yu3JIKV5DzZukWzhSPAStpVt7FA
         6z6x+l2tYhShJmFG95vcafxA0UX/JfCC99sb/s+OdoDMaJ4LvqVGReQOAlldsr6Pa5kP
         am77IQKhqqVaTmSpEfRJtotW64ft7iQUGbsiPmt5i1IIUXoqpbezCKDWeyLc25OW1Hgm
         BBNsfgW83u/nkjUQyTWIuxd213LHATbH+VSyv5cBP0xI5Jl31YTuqTzRdvA4+JRL9Nz9
         N7Vmi2RaolI9fBoo0cxM6pAjmWxM/RQxGgq1gHpjnWwxwSkxIAvbfJCqOSA68I0r6thw
         V2tA==
X-Gm-Message-State: AOAM530ywJNtWUjMASJfnk4kNQxh3hazidoCmtGW1jaJDusnhyiBmDxL
        xTRskLDZwRwEv2pvZFnMionx9tFqcdsLibqFDz4=
X-Google-Smtp-Source: ABdhPJzI8tEl/Ycn5s8tT1e+JU46FrhlHbKYTj8Kx1soPWcZTVESSA1KiLFaeltl+0eGkNHk1+/ppyHAEaK2AOsULXA=
X-Received: by 2002:a05:6e02:1d1e:: with SMTP id i30mr6971309ila.248.1633283098568;
 Sun, 03 Oct 2021 10:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210910084240.1215803-1-elver@google.com>
In-Reply-To: <20210910084240.1215803-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 3 Oct 2021 19:44:48 +0200
Message-ID: <CA+fCnZe=Wuj7bR77nUoWs6PSUJE4rFLpJabQbJKE=Wn24_Viow@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix Kconfig check of CC_HAS_WORKING_NOSANITIZE_ADDRESS
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:42 AM Marco Elver <elver@google.com> wrote:
>
> In the main KASAN config option CC_HAS_WORKING_NOSANITIZE_ADDRESS is
> checked for instrumentation-based modes. However, if
> HAVE_ARCH_KASAN_HW_TAGS is true all modes may still be selected.
>
> To fix, also make the software modes depend on
> CC_HAS_WORKING_NOSANITIZE_ADDRESS.
>
> Fixes: 6a63a63ff1ac ("kasan: introduce CONFIG_KASAN_HW_TAGS")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/Kconfig.kasan | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 1e2d10f86011..cdc842d090db 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -66,6 +66,7 @@ choice
>  config KASAN_GENERIC
>         bool "Generic mode"
>         depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
> +       depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
>         select SLUB_DEBUG if SLUB
>         select CONSTRUCTORS
>         help
> @@ -86,6 +87,7 @@ config KASAN_GENERIC
>  config KASAN_SW_TAGS
>         bool "Software tag-based mode"
>         depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
> +       depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
>         select SLUB_DEBUG if SLUB
>         select CONSTRUCTORS
>         help
> --
> 2.33.0.309.g3052b89438-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
