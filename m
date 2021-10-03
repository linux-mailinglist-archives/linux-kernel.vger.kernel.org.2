Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3559442030D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 19:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJCROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 13:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhJCROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:14:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF7DC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 10:13:07 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d18so17579732iof.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQT2grhgRy79c0bM2yRcD+hXmQawHfrm6730jdCtlH0=;
        b=lnXzawzdEW3De3XUarh16RdC4uuffLc0Hz82LoerlPlQJiIF0Zk7ZPP1qRD0Hyra/5
         I00FysoGtyBoC8FWSqn+c6kg9yAoBLLr6WkYvdBGJnJ73pdRk9F4fnvQzSjd50MlqjsF
         hTYM0rmH5g7b0n7b4hGZn1e86D/mio0WazQxnFwxcOPA71M3aY8c+u3tM2AiQPjcNjuw
         QMmL3OdfD65XZSGlelJY0VQTy6/r7ZOZMF1Pa3Gom+Lbty2J5OqiyZO5oTt9VwoBA13Y
         hLAOFYB5JNzYp34hObGtFSRw1fNRaPBpaW5EhQecvDaZLFRSmEjzmhCueki8CaHtRgxn
         XBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQT2grhgRy79c0bM2yRcD+hXmQawHfrm6730jdCtlH0=;
        b=Lw6hT/s7gx5llLeD7KPGeqIJitna59UZTz+wjb5jINv6ybgJrv/rjpemXcuryViZRs
         z2rejVqKjq6Ac7RNiY78/4SiDXIk7wv+TFkNPbDxj5CmHcOmpELW2YTl2wU9ZpmKbCtz
         SXHpHg40hFK/zSxzA/N9B/5V/impEph54Q+Vq81/oc3ejxI7c8ILQmLvnVAUELMa+3su
         dPnZYRGu3Wh9qE9XFDSrSVX+OpmSJkY62DSz+7U9zJVdt0SYfNpUYL7MAZHBTrkK/7ay
         Ls0Lm/f1D5roiEdgwmh/SBYIrgxy7nJL/RWybEL1qtRPrdxfOWazi2xDxXr6d1A6kzj+
         4oWA==
X-Gm-Message-State: AOAM531TSyYxrELMFnpTD3kOcg1cb9t9oMjdMuUBvToenCXCwUSRa2js
        kDYdGgv7wYGuAEF/FoItfgjWI5He8J/o/+bcup4=
X-Google-Smtp-Source: ABdhPJw3clZFlewPSfCGgEqMv6ZYxzC+3RevzunhH4ELlGOQN6aPDdjUH0Z34ePVfUtVqMUei6/Pbzr5rvhXUT7RubE=
X-Received: by 2002:a5e:db44:: with SMTP id r4mr6382777iop.56.1633281186706;
 Sun, 03 Oct 2021 10:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210913081424.48613-1-vincenzo.frascino@arm.com> <20210913081424.48613-2-vincenzo.frascino@arm.com>
In-Reply-To: <20210913081424.48613-2-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 3 Oct 2021 19:12:56 +0200
Message-ID: <CA+fCnZffxd+nGngMQ+u6kJtJyGAScGocPwrU9yAPYKHRsU1Yjg@mail.gmail.com>
Subject: Re: [PATCH 1/5] kasan: Remove duplicate of kasan_flag_async
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 10:14 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> After merging async mode for KASAN_HW_TAGS a duplicate of the
> kasan_flag_async flag was left erroneously inside the code.
>
> Remove the duplicate.
>
> Note: This change does not bring functional changes to the code
> base.
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Evgenii Stepanov <eugenis@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  mm/kasan/kasan.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8bf568a80eb8..3639e7c8bb98 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -38,8 +38,6 @@ static inline bool kasan_async_mode_enabled(void)
>
>  #endif
>
> -extern bool kasan_flag_async __ro_after_init;
> -
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_GRANULE_SIZE     (1UL << KASAN_SHADOW_SCALE_SHIFT)
>  #else
> --
> 2.33.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
