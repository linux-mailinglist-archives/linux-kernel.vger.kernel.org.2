Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9B135756C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355885AbhDGUHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348993AbhDGUHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:07:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF40C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:07:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s17so22196765ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/vai0nU8ahUeqHDsInaV1wXMfAHCPGayRkelay9Gu/c=;
        b=StO8y4z0YJ2sIRuWD+p8e7Q0l2T+hS4BK/yjQ6bJK+W10NuDwLqYxNiiGdsE6ZzdY0
         j5a8upBcHwOMaeAl62P8GmWlvbXebRR1GVHqOaslaIr91tYKokBXvYck8jWN1FSox0uJ
         f23DP4ylp17dus6Ds57Y6XXprOAWwypPgbcijbM5PZzQLyV3q+rOPlt1/mn6vWpoNyfW
         HlLXSB0B4lK9jeO6DQki1BUO7LRGpviFWusMBzKk0drwLzvY+sXaAZ9PQd9l3ODJty6S
         QeagHf5w5w8L/IkKxk3MQlf4KB8kMF6aejgoi++beiL9iNTK7ECFVgeSUDS7FOUgBEJs
         v0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/vai0nU8ahUeqHDsInaV1wXMfAHCPGayRkelay9Gu/c=;
        b=Mu/iKSNNWpwDe2eEzm2nw7A12BA3E6hS2fPSVD9F7WF9X1Z4FeOmJZ5AYwdypF7Mum
         40hB+0ZWOlhRxFmL9NpFmUbG4+h4cJKvHM4QvbigVcHzuq8EH0v8oUBCN5HaL5NqVzXm
         sJyqDAWs3nlgw0ae0tLRkO7rYwRfPs23xuF7zkZ/tO8TdHCo+yLL35KPyDKaFd0S5n25
         enPaNrV80rG3A4CGCaB9Rl4qv18UsigUAO2itVI8YuClUoMuqVcMyZT0MP80IZP07dzx
         bvI0s/76cZZw4tg05GYJM1yctKGVaaO+3X21drV84+aPOyu3VzrAsSCObtYeiETH5Jw5
         cD+w==
X-Gm-Message-State: AOAM531MwpOV6/xhX0rzwJzbCW7ULdexY0LCIaTjvdNuxoQpqG2X5BUy
        vmYDJojNMhobaHJb9BK17fT58r+d0viztdP8NZX9ZA==
X-Google-Smtp-Source: ABdhPJyndP97T1i1A544kUEqIbgjl3iGA5vSMvrx036WuFZ7dPSMke1t+D6LyfOzk9N/4LJPbB2474jblVritRHulZY=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr3264560ljp.479.1617826029695;
 Wed, 07 Apr 2021 13:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210407061456.5914-1-gi-oh.kim@ionos.com>
In-Reply-To: <20210407061456.5914-1-gi-oh.kim@ionos.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 7 Apr 2021 13:06:58 -0700
Message-ID: <CAKwvOdnaLT8sn4e3PQoASjKaNP4gUKQikhxtJM5G94-7CMUKTw@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Introduce sysfs_streqcase
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        laniel_francis@privacyrequired.com,
        Kees Cook <keescook@chromium.org>,
        Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 11:15 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
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

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I do wonder if these (sysfs_streqcase and sysfs_streq) could or should
be conditionally available on CONFIG_SYSFS=3Dy; don't pay for what you
don't use (without needing CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy)?

Also, it might be nice to share the second half of the function with
sysfs_streq via a new static function.  Though it will just get
inlined in both for CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy, it might
help the compiler if CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy was instead chosen
if the compiler cannot outline/deduplicate the shared code.  At the
least, there's less duplication between two very similar functions; if
one changes then authors may need to be careful to update both.

Are either of those concerns worth a v3? =C2=AF\_(=E3=83=84)_/=C2=AF

>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> ---
>  include/linux/string.h |  1 +
>  lib/string.c           | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 4fcfb56abcf5..36d00ff8013e 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -184,6 +184,7 @@ extern char **argv_split(gfp_t gfp, const char *str, =
int *argcp);
>  extern void argv_free(char **argv);
>
>  extern bool sysfs_streq(const char *s1, const char *s2);
> +extern bool sysfs_streqcase(const char *s1, const char *s2);
>  extern int kstrtobool(const char *s, bool *res);
>  static inline int strtobool(const char *s, bool *res)
>  {
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
> +       while (*s1 && tolower(*s1) =3D=3D tolower(*s2)) {
> +               s1++;
> +               s2++;
> +       }
> +
> +       if (*s1 =3D=3D *s2)
> +               return true;
> +       if (!*s1 && *s2 =3D=3D '\n' && !s2[1])
> +               return true;
> +       if (*s1 =3D=3D '\n' && !s1[1] && !*s2)
> +               return true;
> +       return false;
> +}
> +EXPORT_SYMBOL(sysfs_streqcase);
> +
>  /**
>   * match_string - matches given string in an array
>   * @array:     array of strings
> --
> 2.25.1
>


--=20
Thanks,
~Nick Desaulniers
