Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410F7315C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhBJBb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbhBIXRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:17:03 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80378C061794
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 15:16:22 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id m20so141820ilj.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 15:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjRKzW5JMqCp6QYP7LThHIEENo3kUyszX9fbP1T00KA=;
        b=IWkjj3e5uLQ1/OigKSA2DmYFIP+vyxQVkt40a9UqpskJAxx9w5xW3Zv3OJrTZYcdfd
         /wrCcz+t3G28ywg6qa7vmsPb7pKfVZzmvUl8CWJsNfSgYSMqjEdoPipKHb/meEbs2N5n
         IEe9Gkm0TCiPFhcaOzdJUSwbOrreOpL9ePaCVASODexo98IBdzNbraamlejdrmgQZh2B
         wnmU8n8lCH4GBLG8OY+1epYVK1u+bCP4/2DpUtAUFrhJTWKtZ1SvoQLvTFjZDa+BcPb/
         7sn5KOVvYCI2+dhI9hM4zI/PemxrSGG2AvIDZUQzAqu6JqJ0nlesB9O559TOsBNWP3vA
         5GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjRKzW5JMqCp6QYP7LThHIEENo3kUyszX9fbP1T00KA=;
        b=PwD0/15RiSMjyEPQzUiz8hKYI5N6Pjx6R9O4txbYz/PS+0grMnfJs5LW2G9dhVRNOg
         m7sc0uwC9YqldLr42IyUFOIJvFyJy9l1BzKeHxzSZneu6+G3f+W4KPyRwKKOEzP/he9I
         GAsqCpEfzfnF7QFjl9O/WPem4MATYx1W0lXVWMy2cPpZ/VZUAsmiZR47ADriY8BJAp17
         M6srOeB3M981DWoeTsb0QanUYyn2pHughnLm+DMxws4R4tsYxfgNbU0m1MjCBAuSHCfF
         50Knook1QAQy11EFSId1bHhoc63O//1XfzlrhwCic6QuSWAD5DHweFYP1KM5vtzFiQG/
         leUg==
X-Gm-Message-State: AOAM531ijTNWeUsta8sqiL6KIxi1rsj6LON+IFL9vEBElKopB0ZnLYiN
        9ja67ATFCnIlFkuvMmh+hMFkWWQH8xHtgPwF3AY=
X-Google-Smtp-Source: ABdhPJw9eTyHLq6Y+8A4T96fd5CPRvnxdizAk+xCwG7/LNBH7XX03GOF/csHQ1DH3/LzTVfH3SroNfIv3GdfyERsH/o=
X-Received: by 2002:a92:da8a:: with SMTP id u10mr347356iln.238.1612912581809;
 Tue, 09 Feb 2021 15:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20210209225907.78405-1-paul.gortmaker@windriver.com> <20210209225907.78405-7-paul.gortmaker@windriver.com>
In-Reply-To: <20210209225907.78405-7-paul.gortmaker@windriver.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 9 Feb 2021 15:16:10 -0800
Message-ID: <CAAH8bW_fJi_PeHrXsPZzLtRP=-L99QJBXEvHkN9w6DBP-1FPWQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 3:01 PM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> While this is done for all bitmaps, the original use case in mind was
> for CPU masks and cpulist_parse() as described below.
>
> It seems that a common configuration is to use the 1st couple cores for
> housekeeping tasks.  This tends to leave the remaining ones to form a
> pool of similarly configured cores to take on the real workload of
> interest to the user.
>
> So on machine A - with 32 cores, it could be 0-3 for "system" and then
> 4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
> setting up the worker pool of CPUs.
>
> But then newer machine B is added, and it has 48 cores, and so while
> the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.
>
> Multiple deployment becomes easier when we can just simply replace 31
> and 47 with "N" and let the system substitute in the actual number at
> boot; a number that it knows better than we do.
>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com> # move it from CPU code
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  .../admin-guide/kernel-parameters.rst         |  7 +++++
>  lib/bitmap.c                                  | 27 ++++++++++++++-----
>  2 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index 682ab28b5c94..7733a773f5f8 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -68,6 +68,13 @@ For example one can add to the command line following parameter:
>
>  where the final item represents CPUs 100,101,125,126,150,151,...
>
> +The value "N" can be used to represent the numerically last CPU on the system,
> +i.e "foo_cpus=16-N" would be equivalent to "16-31" on a 32 core system.
> +
> +Keep in mind that "N" is dynamic, so if system changes cause the bitmap width
> +to change, such as less cores in the CPU list, then N and any ranges using N
> +will also change.  Use the same on a small 4 core system, and "16-N" becomes
> +"16-3" and now the same boot input will be flagged as invalid (start > end).
>
>
>  This document may not be entirely up to date and comprehensive. The command
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 6b568f98af3d..cc7cb1fca1ac 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -530,11 +530,17 @@ static int bitmap_check_region(const struct bitmap_region *br)
>         return 0;
>  }
>
> -static const char *bitmap_getnum(const char *str, unsigned int *num)
> +static const char *bitmap_getnum(const char *str, unsigned int *num,
> +                                unsigned int lastbit)

The idea of struct bitmap_region is avoid passing the lastbit to the functions.
But here you do pass. Can you please be consistent? Or if I misunderstand
the idea of struct bitmap_region, can you please clarify it?

Also, I don't think that in this specific case it's worth it to create
a hierarchy of
structures. Just adding lastbits to struct region will be simpler and more
transparent.

>  {
>         unsigned long long n;
>         unsigned int len;
>
> +       if (str[0] == 'N') {
> +               *num = lastbit;
> +               return str + 1;
> +       }
> +
>         len = _parse_integer(str, 10, &n);
>         if (!len)
>                 return ERR_PTR(-EINVAL);
> @@ -580,9 +586,12 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
>         return end;
>  }
>
> -static const char *bitmap_parse_region(const char *str, struct region *r)
> +static const char *bitmap_parse_region(const char *str, struct bitmap_region *br)

It seems like you declare struct bitmap_region in patch 8, but use it
in patch 6.
Can you please reorder your patches and resubmit?

>  {
> -       str = bitmap_getnum(str, &r->start);
> +       struct region *r = br->r;
> +       unsigned int lastbit = br->nbits - 1;
> +
> +       str = bitmap_getnum(str, &r->start, lastbit);
>         if (IS_ERR(str))
>                 return str;
>
> @@ -592,7 +601,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
>         if (*str != '-')
>                 return ERR_PTR(-EINVAL);
>
> -       str = bitmap_getnum(str + 1, &r->end);
> +       str = bitmap_getnum(str + 1, &r->end, lastbit);
>         if (IS_ERR(str))
>                 return str;
>
> @@ -602,14 +611,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
>         if (*str != ':')
>                 return ERR_PTR(-EINVAL);
>
> -       str = bitmap_getnum(str + 1, &r->off);
> +       str = bitmap_getnum(str + 1, &r->off, lastbit);
>         if (IS_ERR(str))
>                 return str;
>
>         if (*str != '/')
>                 return ERR_PTR(-EINVAL);
>
> -       return bitmap_getnum(str + 1, &r->group_len);
> +       return bitmap_getnum(str + 1, &r->group_len, lastbit);
>
>  no_end:
>         r->end = r->start;
> @@ -636,6 +645,10 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
>   * From each group will be used only defined amount of bits.
>   * Syntax: range:used_size/group_size
>   * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
> + * The value 'N' can be used as a dynamically substituted token for the
> + * maximum allowed value; i.e (nmaskbits - 1).  Keep in mind that it is
> + * dynamic, so if system changes cause the bitmap width to change, such
> + * as more cores in a CPU list, then any ranges using N will also change.
>   *
>   * Returns: 0 on success, -errno on invalid input strings. Error values:
>   *
> @@ -660,7 +673,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>                 if (buf == NULL)
>                         return 0;
>
> -               buf = bitmap_parse_region(buf, &r);
> +               buf = bitmap_parse_region(buf, &br);
>                 if (IS_ERR(buf))
>                         return PTR_ERR(buf);
>
> --
> 2.17.1
>
