Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965D9352F26
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhDBSYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBSYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:24:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCBBC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:24:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a12so4067451pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d3veUeKKkUH0RsPWtYG2CYnAax7p+7VbssTzLIdp0F4=;
        b=c4q5KzCF8H5otc00haJ6k+g7KES2GT+/Bz0WUO2fArkJeI8c+o39+AIEugEoN81tn1
         jmmyHzjEZI2wjmMEoPWIvEXk6Y253Xrwo7YLPpbpzgZc5PbTHZbEj19KEU1t19OQE5JZ
         Ia1L+q8DorVAWBXz0gjSsiDOs6ycu09VBm/Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3veUeKKkUH0RsPWtYG2CYnAax7p+7VbssTzLIdp0F4=;
        b=T2gfdyvdnbSRrS7UAho5mwIAxWKcy1zUTMAN0Vav2PNI8v4cYOX5HEt4giODYvo8e4
         6ofJq8VHzewEtwxuq1J6PTzQltrGBgBRAeNsKODtJSL8t4pBFiouuWg2j0Bx4M1yG6+N
         YB+ReHBebqy8bzX/rXRI3+XjQAPuRcJFT6evQO3ou1jFcoN+l5TYOzk0hjrF17dgMYBN
         Maj1ImQUEhMUzew4CYuGrm/hEb1+UkNi4C8VPjRq7hbgGkXQC+IgNsgBi+8X18xBhfOc
         Pb9Fw+SpriW2PQarAhv0jTMIsMK1tmcsot0VLIj2DUxfitWxkdITfIBlOgV06lze8tCN
         uLGQ==
X-Gm-Message-State: AOAM531JOtSZ6SDTzD75rY6Od2a+JKeekfONBhLYR6hBFFddrukeTQfn
        C+HzvtG3yuRNXzcYMJl3ld99RQ==
X-Google-Smtp-Source: ABdhPJxAzQKiAhYXyr+2W64ujClRC8TUCDGS25s8WHsSDt5PLZX5SqDcoVNtbRJ1SUND3J1h5ONf2A==
X-Received: by 2002:a62:4e57:0:b029:203:93bc:3cb with SMTP id c84-20020a624e570000b029020393bc03cbmr12928980pfb.56.1617387840114;
        Fri, 02 Apr 2021 11:24:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r2sm8363076pgv.50.2021.04.02.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 11:23:59 -0700 (PDT)
Date:   Fri, 2 Apr 2021 11:23:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>,
        LKML <linux-kernel@vger.kernel.org>, jinpu.wang@ionos.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib/string: Introduce sysfs_streqcase
Message-ID: <202104021122.7896C66@keescook>
References: <20210402094042.9218-1-gi-oh.kim@ionos.com>
 <CAKwvOdkFJ_WFpt2+rnNR3tbrdFky2NnEOWSG7MhgLrBHJAOEVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkFJ_WFpt2+rnNR3tbrdFky2NnEOWSG7MhgLrBHJAOEVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 11:17:13AM -0700, Nick Desaulniers wrote:
> Thanks for the patch!
> 
> + akpm (please remember to run ./scripts/get_maintainer.pl on your patch files)
> 
> On Fri, Apr 2, 2021 at 2:41 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> >
> > As the name shows, it checks if strings are equal in case insensitive
> > manner. I found some cases using strncasecmp to check the entire
> > strings and they would not work as intended.
> >
> > For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
> > strncasecmp to check that the input via sysfs is "mi". But it would
> > work even-if the input is "min-wrongcommand".
> > And also drivers/pnp/interface.c checks "disable" command with
> > strncasecmp but it would also work if the command is "disable-wrong".
> 
> Perhaps those callers should be using strcasecmp then, rather than strncasecmp?
> 
> Also, if they're being liberal in accepting either case, I don't see
> why the sysfs nodes should be strict in rejecting trailing input at
> that point.

I think this shouldn't be prefixed "sysfs_" -- name it for what it does,
not where it gets used, if it's a general utility function.

-Kees

> 
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > ---
> >  lib/string.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/lib/string.c b/lib/string.c
> > index 7548eb715ddb..5e6bc0d3d5c6 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -714,6 +714,29 @@ bool sysfs_streq(const char *s1, const char *s2)
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
> > +
> > +       if (*s1 == *s2)
> > +               return true;
> > +       if (!*s1 && *s2 == '\n' && !s2[1])
> > +               return true;
> > +       if (*s1 == '\n' && !s1[1] && !*s2)
> > +               return true;
> > +       return false;
> > +}
> > +EXPORT_SYMBOL(sysfs_streqcase);
> 
> This should be declared in
> include/linux/string.h
> in order for others to use this (as 0day bot notes).
> 
> > +
> >  /**
> >   * match_string - matches given string in an array
> >   * @array:     array of strings
> > --
> > 2.25.1
> >
> 
> 
> --
> Thanks,
> ~Nick Desaulniers

-- 
Kees Cook
