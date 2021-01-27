Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809B930534F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhA0GhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbhA0DNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:13:49 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F6C061788
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 19:13:09 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id f18so444837ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 19:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3M1zQf19J5vQNnJvY7qqgq7o0AemNbv+khJIT1wB/QE=;
        b=IgAeFMvxPVf6VitI98plqk0WfuJtV2d7hnCerwwb9NTSW7TjlcGfJoi+7kATjlMXQl
         GtoigKULokzQBIvZBGTcPjX/bIZC7AkpLnyjaGBc1quidSPpmtXH5cjSlW3Fh1FWSDxl
         sXLEokobSfTLANbhRyTnH3/OwWXZXlmHXQBKj97pBZOqq0rEh33VOJlz2Fomr4enZL39
         D6aMyxc6zPVBeVhxiHX/zTdiUyEF4ypPUZvs8yKOhlqqHmDbL8BIKRTWUIRuMzDXiCRY
         bx27XGhIQJAviHmks2tKoMZ2reM9J3dDPA+j3ptzqDxGJT7cltYTAB8dI9riTFPYYZz4
         k+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3M1zQf19J5vQNnJvY7qqgq7o0AemNbv+khJIT1wB/QE=;
        b=tCUnWfZQUVvbdVCnET4HR0CI8qKXWp+t5undf4ucUEgry4Xyh3Z+VGvsBc/Ot0Af4A
         3+7qw2ljN0Ij2SHAMnMySUPtORTlkXxFMUsoVTxuLv+jmwsgxHZQguXrLs6hzdy0S+Yh
         wDYHK1N36rP6eaANjttHXlrn7vJ/ulrPCmQjD9GUQVPXUd6I9scqzJvYiodr+Zl3QPMC
         ABIQRz40LMp+2dHM3ex/p9M3qiV7Qd9m7+0FN5bz2Zo1ySPiIJdUFNdXtWe+pptFlkyK
         2rVgzRE8/uOKgW2yZUN3UtGZhEx8y+SoiXpX8j9Ci6yueuP8qQTQ/qfoH/JeYRHCakDr
         9lSw==
X-Gm-Message-State: AOAM532AFtg6pYq6ONyZVQ2S5eP6Dyns9ibRmr4xMENIlLegElVfHUjT
        X/aaheJEb+HlXArZZCe0tf8wcEiZl37Z5wys+G8=
X-Google-Smtp-Source: ABdhPJx/vjoLbEAK5NmSmJJQvszKdv7pvcwgLTkU9XL7NNH/BMn4NGlskm6C0sKQ8XTL8zT2OBAlj4E6aBm8/ozN30Y=
X-Received: by 2002:a05:6e02:cb:: with SMTP id r11mr7289042ilq.116.1611717189005;
 Tue, 26 Jan 2021 19:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20210126171141.122639-1-paul.gortmaker@windriver.com> <20210126171141.122639-5-paul.gortmaker@windriver.com>
In-Reply-To: <20210126171141.122639-5-paul.gortmaker@windriver.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 26 Jan 2021 19:12:58 -0800
Message-ID: <CAAH8bW_BCPTK4H4CFShbfEv-cV6tiqXNMh_xNRbJV+gkjyw+mg@mail.gmail.com>
Subject: Re: [PATCH 4/8] lib: bitmap: move ERANGE check from set_region to check_region
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lizefan@huawei.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, josh@joshtriplett.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, fweisbec@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 9:12 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> It makes sense to do all the checks in check_region() and not 1/2
> in check_region and 1/2 in set_region.
>
> Since set_region is called immediately after check_region, the net
> effect on runtime is zero, but it gets rid of an if (...) return...
>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  lib/bitmap.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 162e2850c622..833f152a2c43 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -500,17 +500,12 @@ struct region {
>         unsigned int nbits;
>  };
>
> -static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
> +static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
>  {
>         unsigned int start;
>
> -       if (r->end >= r->nbits)
> -               return -ERANGE;
> -
>         for (start = r->start; start <= r->end; start += r->group_len)
>                 bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
> -
> -       return 0;
>  }
>
>  static int bitmap_check_region(const struct region *r)
> @@ -518,6 +513,9 @@ static int bitmap_check_region(const struct region *r)
>         if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
>                 return -EINVAL;
>
> +       if (r->end >= r->nbits)
> +               return -ERANGE;
> +
>         return 0;
>  }
>
> @@ -656,9 +654,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>                 if (ret)
>                         return ret;
>
> -               ret = bitmap_set_region(&r, maskp);
> -               if (ret)
> -                       return ret;
> +               bitmap_set_region(&r, maskp);
>         }
>
>         return 0;
> --
> 2.17.1

Acked-by: Yury Norov <yury.norov@gmail.com>
