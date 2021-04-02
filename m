Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE52352F09
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhDBSRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhDBSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:17:27 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE98C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:17:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o16so6385075ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zliiDDAsTwkrrTylXBgddm70OO8AdbUDRcZfji03hH8=;
        b=EoQDhfx90AsqZ7QfCWLGz93QI+7II1mb+FygdvP+HsAXKfAxZqWEabX0p1PczWOpb9
         SLQxbJHYoOSgxncNVX8QmwHsNuo+WTx+/cgtkWcKJahDc65cYcx2/9vlaxBRaaRaIn5I
         jzPpWouABQgrsqrkXwv9QpOB79yM1J3J6SGwUHn3IRGmF4f5+V4cUAiLlcg7IuFogOfy
         QU5Tj5vmkRi/6W8CBIs7M3eh+zJoqL23SboNf7bs97rXuy4LMMLp5bwpEu5oFbX/0ils
         yKxdjingRi6bDwSnUwvL8B+T+aAl86L7zurgiXSTJHFA2Cx5iXC9aUfMtwH0tgyP6LLX
         yQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zliiDDAsTwkrrTylXBgddm70OO8AdbUDRcZfji03hH8=;
        b=iKJ30lBMoH+mXhXNfb42uPV1q18v+DEtUk5cyjLRPjCOFSYNHelSeEmH4eL0PK73kD
         s5z7N4mMtSVEM5wZ46wmhxsrbYfTXALt+Eumu6XA+I2Z95KIC4CcZXS06GmHI48fFXjj
         gNCqtUZ2b07jiZL8whM2NjJRR9e7Q+rch27/hHKGKrPWBwyiRQ8M5zgkzXo1rd+2xIx+
         8U/bR6j7t3d4RiXeSg8s+zgI26P3UC+1fM+cb5iGYx6EyUNWa8Pb+QxLKvIBd/9gRFUk
         SKBjsnoHev9cVLWyBgqf4oCpfi0iUz+JBsDcUaJMu5yreAp8Df0q5toIpKHy80qi9CS8
         14Kw==
X-Gm-Message-State: AOAM532uiIVVk+TxBuJZiuLAF85HAE/RC9R5l878dEFc33jO7g1CewN9
        yC8N/uyA/InRwBqIOu4yd9QgE6ipu0i3ekpi7qvYxQ==
X-Google-Smtp-Source: ABdhPJy+R8eCmxg02JelSrjoVIMjslbjDwAStEfGcVJaO/1a+KNS2qafGjgDuHvnWZbRMUtYRnZo8zxkzTH5bpZcQu4=
X-Received: by 2002:a2e:988a:: with SMTP id b10mr9101771ljj.341.1617387444146;
 Fri, 02 Apr 2021 11:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210402094042.9218-1-gi-oh.kim@ionos.com>
In-Reply-To: <20210402094042.9218-1-gi-oh.kim@ionos.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 2 Apr 2021 11:17:13 -0700
Message-ID: <CAKwvOdkFJ_WFpt2+rnNR3tbrdFky2NnEOWSG7MhgLrBHJAOEVw@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Introduce sysfs_streqcase
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, jinpu.wang@ionos.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch!

+ akpm (please remember to run ./scripts/get_maintainer.pl on your patch files)

On Fri, Apr 2, 2021 at 2:41 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> As the name shows, it checks if strings are equal in case insensitive
> manner. I found some cases using strncasecmp to check the entire
> strings and they would not work as intended.
>
> For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
> strncasecmp to check that the input via sysfs is "mi". But it would
> work even-if the input is "min-wrongcommand".
> And also drivers/pnp/interface.c checks "disable" command with
> strncasecmp but it would also work if the command is "disable-wrong".

Perhaps those callers should be using strcasecmp then, rather than strncasecmp?

Also, if they're being liberal in accepting either case, I don't see
why the sysfs nodes should be strict in rejecting trailing input at
that point.

>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> ---
>  lib/string.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/lib/string.c b/lib/string.c
> index 7548eb715ddb..5e6bc0d3d5c6 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -714,6 +714,29 @@ bool sysfs_streq(const char *s1, const char *s2)
>  }
>  EXPORT_SYMBOL(sysfs_streq);
>
> +/**
> + * sysfs_streqcase - same to sysfs_streq and case insensitive
> + * @s1: one string
> + * @s2: another string
> + *
> + */
> +bool sysfs_streqcase(const char *s1, const char *s2)
> +{
> +       while (*s1 && tolower(*s1) == tolower(*s2)) {
> +               s1++;
> +               s2++;
> +       }
> +
> +       if (*s1 == *s2)
> +               return true;
> +       if (!*s1 && *s2 == '\n' && !s2[1])
> +               return true;
> +       if (*s1 == '\n' && !s1[1] && !*s2)
> +               return true;
> +       return false;
> +}
> +EXPORT_SYMBOL(sysfs_streqcase);

This should be declared in
include/linux/string.h
in order for others to use this (as 0day bot notes).

> +
>  /**
>   * match_string - matches given string in an array
>   * @array:     array of strings
> --
> 2.25.1
>


--
Thanks,
~Nick Desaulniers
