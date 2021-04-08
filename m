Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33ED358459
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhDHNOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhDHNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:14:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F576C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:14:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z1so2354936edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLvXfE9yTQhzebXvSr5GWrY5y7DFQ3AYDONnvbfqSCI=;
        b=gTvW7hyWlqpyopox13gzcDUyzoxUlti5J+Gf8now6d7ltOrQHf6rL67R3NsEt/B/nv
         dYduNKineelej802JiKusx8uozj6Y7eC87GESU4+i+D50Xejbm57lHLgMij0i9ZPFWjg
         Ecv+Ii89zNYTxxqjnQI7oK3q1KjuPxZfZDQ5OILKA+BEwVBAlXskgw4yqs+qyPkGn9pc
         EJ4JWLc9tGwv9ajU9DC+YzbUtamKEo2haJhn8FOPYkU3aij/GtaQ/0MA0yYEE2w6B11Z
         lyzV9p3sUjvF1xYeBMVyQQRXzFcJj6W9IqVjDwOV/xeuZVCUFLuCMcyUk34E6ucBEyZb
         XVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLvXfE9yTQhzebXvSr5GWrY5y7DFQ3AYDONnvbfqSCI=;
        b=AX1rJj3jJiRNObBhQKZfxHlGmLXnE/QC2cW8pM8PvXIStR4VSH0hhtLGLBwBSIQW+6
         IpGz3BeABuZbHQUTMOrw5n4QKBRJHeIpVvQ4Z5P6SWsBM/FAy/u+GsPrbLdpsMIUUXJR
         UO1l+VXEHYqLqSD4dsLTOYMlLDfiVcCn28nHTHeZ8o1mlqUj33ZbCC4+PPd2u78GrK13
         DRBxw+47Sbt/gXKSbIiumtupFehjYFhYaKkdHrCJeMLns0kJk/CRpQ9I8xJ+7p2oKBt0
         6pkq6/cO/yonQC4rcxrTUUNShix26zR/ik7uUcsTFsdMYNvPbIyYUS5oqQPcJoz7QE7J
         QZZw==
X-Gm-Message-State: AOAM533/prRyan/Pg+gpAeHBvXPnd7oUcl+NUi2tXtuibDUn7vZZJpCX
        gD6B2/9LX8sPGgLYOQXpHSdEr4lpnXk3xUQG8qkAdg==
X-Google-Smtp-Source: ABdhPJz/wWlis90jZyWFg5TiZXUkwVA4/xjmV1JQJDwJ8/cO5FRTj7jP7hFmyCMkz3zcvm3mxX6SAEY2yDYi23QbQTg=
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr11273981edu.100.1617887649203;
 Thu, 08 Apr 2021 06:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210408130605.541796-1-gi-oh.kim@ionos.com>
In-Reply-To: <20210408130605.541796-1-gi-oh.kim@ionos.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 8 Apr 2021 15:13:58 +0200
Message-ID: <CAMGffEkPRJ1vBi7+bbejS+Acttt269DjW9M6P8n=5xVZ50aGXg@mail.gmail.com>
Subject: Re: [PATCH v4] lib/string: Introduce sysfs_streqcase
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

On Thu, Apr 8, 2021 at 3:06 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
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
you should add the
Reported-by: kernel test robot <lkp@intel.com>
> ---
you can add the changelog here after the ---
v4->v3:  removed #ifdef CONFIG_SYSFS ~ #endif.

The string comparison doesn't depends on CONFIG_SYSFS at all.

It looks good to me.
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>



>  include/linux/string.h |  1 +
>  lib/string.c           | 36 ++++++++++++++++++++++++++++--------
>  2 files changed, 29 insertions(+), 8 deletions(-)
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
> index 7548eb715ddb..d0fb02efd5da 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -687,6 +687,17 @@ char *strsep(char **s, const char *ct)
>  EXPORT_SYMBOL(strsep);
>  #endif
>
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
> @@ -703,17 +714,26 @@ bool sysfs_streq(const char *s1, const char *s2)
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
> +
>  /**
>   * match_string - matches given string in an array
>   * @array:     array of strings
> --
> 2.25.1
>
