Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3670530533C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhA0Gbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhA0DI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:08:58 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB431C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 19:08:16 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id f18so436686ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 19:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUTNAgUXNGecAG/Nta5GFejsQORS+HhEBWnkH5z0cEk=;
        b=hpyeUAxjuKdnw26P1gWM08hqPghTI3CglMRiQp2OT36T3hGp/+azIwBxeAM11JfEjo
         msYwzi6XAj73owIzURFZnNvnpPUyv2lV9l39W2PLS598febakRWeFO8Jt+wT9uvlF/yw
         lDQnz1N3ij79boJoc77aIVNIUcRgeASUxlhrkKBJhchg9txt8XGH1dPJJ/tMsH5UAC56
         C1pPoTcJT79DGuJTWHN8RAFxwPruop+fos8dxBkO4csGyEZr5UbFS+eqlSgiRxy4SAwE
         EP5QMZ6BbFRDc/HlELHJfnq7lGepKsd68wYlJzlAm2AFWZPNbGiRq/J3wItwtAxBkFtK
         1yUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUTNAgUXNGecAG/Nta5GFejsQORS+HhEBWnkH5z0cEk=;
        b=AX0lr+A2CSbB+8pqEZ/NDGMcqdqb1M/smIbJYcENCW/o8xB+qNjYQ294KMP/WBdMBU
         raEhLRiazdCQ4evPkgsn5AZVoHDz4QQ3FibHI2/T9MMCOAt6kiZJA0rTbsg1tE0EVzcN
         0IrLcErRzKKG8pK6NlB+e3SDNkgmGs37r0oPYGqPBcCTshvvxVWAmJVwz7vaIj5HXTfH
         ByCZIskqRJseNQsIIrgiuVhbCde3adOub4B4Ne0giVy4C96E0YPmJgidpcmViI+CNwaf
         i4f75aXRMw7dIcdUIXF2BMlc10EujGPih3u6K/eJgvRsJmldpgvEmO9cgey+OWHMEa6L
         PvqA==
X-Gm-Message-State: AOAM532RWV44FidVdi8JxK3pImEqd58AzqBxdilDWBNe7cm0queD/vob
        HWUwy3m410lmiE4Aw++/gO8BxzU3d0xpZaBmroM=
X-Google-Smtp-Source: ABdhPJz3xRkk2w3mvSEBbuT/hBzsk8B1KsIYhyX5dMQOsNuvknmjdLwV/nejWpiGyQ14g66dzk/Zl0RZbc6pFzgk/hM=
X-Received: by 2002:a92:c6cb:: with SMTP id v11mr275556ilm.238.1611716896143;
 Tue, 26 Jan 2021 19:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20210126171141.122639-1-paul.gortmaker@windriver.com> <20210126171141.122639-4-paul.gortmaker@windriver.com>
In-Reply-To: <20210126171141.122639-4-paul.gortmaker@windriver.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 26 Jan 2021 19:08:05 -0800
Message-ID: <CAAH8bW8efPcdd9SoYhhVAujQcg7SUQe8sOrpCfG6bNDCB-bSCg@mail.gmail.com>
Subject: Re: [PATCH 3/8] lib: bitmap: fold nbits into region struct
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
> This will reduce parameter passing and enable using nbits as part
> of future dynamic region parameter parsing.
>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  lib/bitmap.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 75006c4036e9..162e2850c622 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -487,24 +487,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>
>  /*
>   * Region 9-38:4/10 describes the following bitmap structure:
> - * 0      9  12    18                  38
> - * .........****......****......****......
> - *         ^  ^     ^                   ^
> - *      start  off   group_len        end
> + * 0      9  12    18                  38           N
> + * .........****......****......****..................
> + *         ^  ^     ^                   ^           ^
> + *      start  off   group_len        end       nbits
>   */
>  struct region {
>         unsigned int start;
>         unsigned int off;
>         unsigned int group_len;
>         unsigned int end;
> +       unsigned int nbits;
>  };
>
> -static int bitmap_set_region(const struct region *r,
> -                               unsigned long *bitmap, int nbits)
> +static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
>  {
>         unsigned int start;
>
> -       if (r->end >= nbits)
> +       if (r->end >= r->nbits)
>                 return -ERANGE;
>
>         for (start = r->start; start <= r->end; start += r->group_len)
> @@ -640,7 +640,8 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>         struct region r;
>         long ret;
>
> -       bitmap_zero(maskp, nmaskbits);
> +       r.nbits = nmaskbits;
> +       bitmap_zero(maskp, r.nbits);
>
>         while (buf) {
>                 buf = bitmap_find_region(buf);
> @@ -655,7 +656,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>                 if (ret)
>                         return ret;
>
> -               ret = bitmap_set_region(&r, maskp, nmaskbits);
> +               ret = bitmap_set_region(&r, maskp);
>                 if (ret)
>                         return ret;
>         }
> --
> 2.17.1

Acked-by: Yury Norov <yury.norov@gmail.com>
