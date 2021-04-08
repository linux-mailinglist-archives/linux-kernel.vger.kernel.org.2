Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC4358429
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhDHNHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhDHNHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:07:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BACC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:07:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bx20so1163827edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0gU83cShqlQConhKOM4Ex5L3h1kuIZnR2A8PS7YAjw=;
        b=W2ZY4TjDQ/KtojsYbcMYMwbQWyL90bjncs5LjTx1sUzWDUlOTvYHrPJLTvJI5CIV2A
         lEsG5TeLGCb85REsCqy5hBHBCwlmKMv34bqHBrMAnE8yXAWgA+LftKAJgP7nJ7lVln73
         q+BmXeFUuO/zGBZn7szIoCjsESGGv4nnPEd5+J9PE9UGYx+FwxC0EbasOMYsyVwFwLMj
         xZ8hC/46EEOrybCZQJAbXO+T9d8UmXmZboKBv3HFKRXpKN5j+2+DkyPmXA4Q3sG0MAdw
         jFm4g2PCLEaKGF69wye+PB8C837sDMS6Sfh7z6Ro3KqGeneZmczljfjRi6/zNjpjTOO9
         vDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0gU83cShqlQConhKOM4Ex5L3h1kuIZnR2A8PS7YAjw=;
        b=f4JoSeEjHMlvjdNX+upVXKbPI6SG45ZgPtyPTCi78srH1E7WIWy/MBzq+/HS5bH893
         t2Pl3O3x6MyjgZa7pg9YViIY9s4d3i4hm92Rt96YZ64+IChVI3SPJFbJUISMV2gFXFNh
         9T7ML2GwTt2X030KFWs8roY2guaE7TS2b294rUdMkjxvq8ZjINls1R8Y7fQHQ8/YFR5p
         7WECcD/1eJZBkOScfc4VCpqi26npYvYN7SDEKzv6hJQHpDBPaW7qYTKM0QumhZwzWcQM
         d54oqo4e2rP2+kMYTTuP/HchZay+bEjxpNpx+Yga7YEEdHH6dqes316JVCOFgjkEodsG
         GYEA==
X-Gm-Message-State: AOAM533vABE00pAXVdcgxwLKv8tt3cPYbjTzRJ6R2x4QgfqK15UNplzM
        SZxDdZvefbusFKOLdPq4igr1570CPXzczMig/i3Y5Q==
X-Google-Smtp-Source: ABdhPJz4dp2sEvphjCjt0YUqk4SoYRgO7T0b1xr0h7FgCEYdazaOBskXe/q0XgYCGLHkzm0gA2kmmg5jCLYI49/Tr5c=
X-Received: by 2002:aa7:c481:: with SMTP id m1mr11452660edq.186.1617887248853;
 Thu, 08 Apr 2021 06:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210408093354.509810-1-gi-oh.kim@ionos.com> <CAMGffEkApJiMwdLF75c_539jKLkSPtVqNTFY2byR0Fe5XoiNzw@mail.gmail.com>
In-Reply-To: <CAMGffEkApJiMwdLF75c_539jKLkSPtVqNTFY2byR0Fe5XoiNzw@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Thu, 8 Apr 2021 15:06:53 +0200
Message-ID: <CAJX1YtbVMMppbsqJ+fWECxzagnUEGdWT0DmQ+iaQY+SBL=E_jQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib/string: Introduce sysfs_streqcase
To:     Jinpu Wang <jinpu.wang@ionos.com>
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

Hi Jinpu,

I removed #ifdef CONFIG_SYSFS ~ #endif.
Could you please review again?

On Thu, Apr 8, 2021 at 12:50 PM Jinpu Wang <jinpu.wang@ionos.com> wrote:
>
> On Thu, Apr 8, 2021 at 11:34 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> >
> > As the name shows, it checks if strings are equal in case insensitive
> > manner.
> >
> > For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
> > strncasecmp to check that the input via sysfs is "mi". But it would
> > work even-if the input is "min-wrongcommand".
> >
> > I found some more cases using strncasecmp to check the entire string
> > such as rtrs-clt-sysfs.c does. drivers/pnp/interface.c checks
> > "disable" command with strncasecmp but it would also work if the
> > command is "disable-wrong".
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> It looks good to me.
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  include/linux/string.h |  1 +
> >  lib/string.c           | 38 ++++++++++++++++++++++++++++++--------
> >  2 files changed, 31 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 4fcfb56abcf5..36d00ff8013e 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -184,6 +184,7 @@ extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
> >  extern void argv_free(char **argv);
> >
> >  extern bool sysfs_streq(const char *s1, const char *s2);
> > +extern bool sysfs_streqcase(const char *s1, const char *s2);
> >  extern int kstrtobool(const char *s, bool *res);
> >  static inline int strtobool(const char *s, bool *res)
> >  {
> > diff --git a/lib/string.c b/lib/string.c
> > index 7548eb715ddb..cb53845cc4ac 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -687,6 +687,18 @@ char *strsep(char **s, const char *ct)
> >  EXPORT_SYMBOL(strsep);
> >  #endif
> >
> > +#ifdef CONFIG_SYSFS
> > +static inline bool __streq_terminal(const char *s1, const char *s2)
> > +{
> > +       if (*s1 == *s2)
> > +               return true;
> > +       if (!*s1 && *s2 == '\n' && !s2[1])
> > +               return true;
> > +       if (*s1 == '\n' && !s1[1] && !*s2)
> > +               return true;
> > +       return false;
> > +}
> > +
> >  /**
> >   * sysfs_streq - return true if strings are equal, modulo trailing newline
> >   * @s1: one string
> > @@ -703,17 +715,27 @@ bool sysfs_streq(const char *s1, const char *s2)
> >                 s1++;
> >                 s2++;
> >         }
> > -
> > -       if (*s1 == *s2)
> > -               return true;
> > -       if (!*s1 && *s2 == '\n' && !s2[1])
> > -               return true;
> > -       if (*s1 == '\n' && !s1[1] && !*s2)
> > -               return true;
> > -       return false;
> > +       return __streq_terminal(s1, s2);
> >  }
> >  EXPORT_SYMBOL(sysfs_streq);
> >
> > +/**
> > + * sysfs_streqcase - same to sysfs_streq and case insensitive
> > + * @s1: one string
> > + * @s2: another string
> > + *
> > + */
> > +bool sysfs_streqcase(const char *s1, const char *s2)
> > +{
> > +       while (*s1 && tolower(*s1) == tolower(*s2)) {
> > +               s1++;
> > +               s2++;
> > +       }
> > +       return __streq_terminal(s1, s2);
> > +}
> > +EXPORT_SYMBOL(sysfs_streqcase);
> > +#endif
> > +
> >  /**
> >   * match_string - matches given string in an array
> >   * @array:     array of strings
> > --
> > 2.25.1
> >
