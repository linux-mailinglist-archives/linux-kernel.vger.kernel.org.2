Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E235811E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhDHKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHKu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:50:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215AC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 03:50:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v6so984593ejo.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtJVlzsPZD3O7jli1nBfxd2uFS4DzfABj+QSUufaHdg=;
        b=LXRo18VVgHpO4W8e7UjcQIXORCO10l3iRbXfxaFguBxm8xzo6kIlrPILqhAq8Yebdu
         k6W5axwTIN89InZgtMJhHYoaLo4FeF/BxIxRTRtTe9QO4kOV2AGFLDqYp9rYKjfajcLf
         NLrjfKKikXzUubUk6eyny6BN59lpGQxuBCE7Jih1+a5crdr81u+F5ywp0YO9mrgqyEg4
         nY3BiZUnvUhuJQOFeOwpcTujfSBkIWXyhMYVX8VtwmiW8U1uop2YMM01hUuCTIYvkwjV
         ticxAr1dYALk2ptYOIpTzoNt42BK9ImjLnsna3gYk5BFGw+Iv82ILykagci5vjHNLxL3
         aBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtJVlzsPZD3O7jli1nBfxd2uFS4DzfABj+QSUufaHdg=;
        b=ImvpMmmp/P8/kkPqhHfJLoCJ0TPoForoKXQFjae4bdyNEtJf8YpJDXfzDLcZhNgodC
         VC4jm3Ea1r86skGInn3gPdT9A6z6YIG5CtuYatdtd5+pP596AWer27rr9Wf/eHOYTD9P
         g8/TBLwc5tYeQT95KDwv9VB71tK71WnUWdxRGnrABhUVDPIWW6yEvteoYZQkpJXPWnk5
         1zLZW9mjl3/7OdnKZBb3G1isTc0nNrCJ/wa0cqzoBqk6l2oYbozh8LYPSqFVmRj6nonf
         KkDGGeVdViK5W69I91qR5axvDEWHl1k+2qib1alOyuCN/RYKUKVuU8nXInPEH68DdXwa
         Htng==
X-Gm-Message-State: AOAM532qkcYqeIT11fiBGMyzcrhSrB3dvSy3/HTRxFe92dTSdYjbk0mW
        MIa+KezeaUcsmNA7YBMkUa8uWyXvLfErNViqYBxvNw==
X-Google-Smtp-Source: ABdhPJwiL1w2grdvHylr9y++VqRMVvQt5fWkTPaQRkAi6po2zCDxCPlPUz5lpNa0icNz5860hRlMiRYossjsoFFX9uM=
X-Received: by 2002:a17:906:8242:: with SMTP id f2mr9331092ejx.478.1617879015767;
 Thu, 08 Apr 2021 03:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210408093354.509810-1-gi-oh.kim@ionos.com>
In-Reply-To: <20210408093354.509810-1-gi-oh.kim@ionos.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 8 Apr 2021 12:50:05 +0200
Message-ID: <CAMGffEkApJiMwdLF75c_539jKLkSPtVqNTFY2byR0Fe5XoiNzw@mail.gmail.com>
Subject: Re: [PATCH v3] lib/string: Introduce sysfs_streqcase
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        laniel_francis@privacyrequired.com,
        Kees Cook <keescook@chromium.org>, dja@axtens.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 11:34 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> As the name shows, it checks if strings are equal in case insensitive
> manner.
>
> For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
> strncasecmp to check that the input via sysfs is "mi". But it would
> work even-if the input is "min-wrongcommand".
>
> I found some more cases using strncasecmp to check the entire string
> such as rtrs-clt-sysfs.c does. drivers/pnp/interface.c checks
> "disable" command with strncasecmp but it would also work if the
> command is "disable-wrong".
>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
It looks good to me.
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  include/linux/string.h |  1 +
>  lib/string.c           | 38 ++++++++++++++++++++++++++++++--------
>  2 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 4fcfb56abcf5..36d00ff8013e 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -184,6 +184,7 @@ extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
>  extern void argv_free(char **argv);
>
>  extern bool sysfs_streq(const char *s1, const char *s2);
> +extern bool sysfs_streqcase(const char *s1, const char *s2);
>  extern int kstrtobool(const char *s, bool *res);
>  static inline int strtobool(const char *s, bool *res)
>  {
> diff --git a/lib/string.c b/lib/string.c
> index 7548eb715ddb..cb53845cc4ac 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -687,6 +687,18 @@ char *strsep(char **s, const char *ct)
>  EXPORT_SYMBOL(strsep);
>  #endif
>
> +#ifdef CONFIG_SYSFS
> +static inline bool __streq_terminal(const char *s1, const char *s2)
> +{
> +       if (*s1 == *s2)
> +               return true;
> +       if (!*s1 && *s2 == '\n' && !s2[1])
> +               return true;
> +       if (*s1 == '\n' && !s1[1] && !*s2)
> +               return true;
> +       return false;
> +}
> +
>  /**
>   * sysfs_streq - return true if strings are equal, modulo trailing newline
>   * @s1: one string
> @@ -703,17 +715,27 @@ bool sysfs_streq(const char *s1, const char *s2)
>                 s1++;
>                 s2++;
>         }
> -
> -       if (*s1 == *s2)
> -               return true;
> -       if (!*s1 && *s2 == '\n' && !s2[1])
> -               return true;
> -       if (*s1 == '\n' && !s1[1] && !*s2)
> -               return true;
> -       return false;
> +       return __streq_terminal(s1, s2);
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
> +       return __streq_terminal(s1, s2);
> +}
> +EXPORT_SYMBOL(sysfs_streqcase);
> +#endif
> +
>  /**
>   * match_string - matches given string in an array
>   * @array:     array of strings
> --
> 2.25.1
>
