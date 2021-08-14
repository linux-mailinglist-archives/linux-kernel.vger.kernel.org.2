Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF43EC28C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 14:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbhHNMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbhHNMPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 08:15:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8258AC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 05:15:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w24so758732wmi.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6xH4+wad8SY6UvYHBVuUN3m2CgUddoKpHqr+9P6lAjc=;
        b=Q4cdUOVW6lZ4H0GA+DzE0XoaH/aCphh17VcFtqLl1ZUx1/CWxVUT1ANM4s/tZQ6KJa
         LcXKB+75Xx5Jw3CsQvBjcLSkKr+3ExR4XiIAva1Ee/mepohGrSDEgzuHFzTP/2+QbCRe
         DfcDtBwMd7l0OxCXfjNZNyOpTDuC9Nn0YPPLZsR0iHW04V9Y+BhExUz6gqA0j/N7PiK7
         b/gY2E7xriMXo9XRo9unzuvJtbWsVeg0JxBX0dOddZXEet/bTLkaysNFQfpdx7NMXN6X
         XzzmzJstb9efWWKMBo9QlLpA8iuvxwr3DDpoQdV5QSHpZcYk/fz785y/IYyCNsarWLi5
         XgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6xH4+wad8SY6UvYHBVuUN3m2CgUddoKpHqr+9P6lAjc=;
        b=GWt9KmyYeq8ldiPamfr/NFmFs+rXSq6mSdRc+lBrk8HcE7DT9TI47EvMozCLylDbs2
         CSmk81z30yfsPT7blRcI5LUM/9YDFwz95c/Ytyz1ZwXQkNyuS4nk1wP6XzHIdfJBk/gA
         6r1DBjgFJWWz70zAKCC4w8COz9IFrJNb6/DOMUqFGaHusQBQpA9OYhba3hjYfkS4b+nk
         BENyhbvRA3m0Wu3nkO6QKShxj/KGWwnbyf1xz+j+pR6yW2N8A/KX1NbdSJTS6e5Cd853
         TGrvfJ3Je5gFddNbRTOhRR98XouTKPUWYBARZA0l7sqOg2Qfc10iDTI2U37z8rgOBMPC
         pvzw==
X-Gm-Message-State: AOAM532LaSENf/0TiyAK+Pmk0JcKOMwCPnDkd70vOG7jYgUq/kV7yzzz
        lapIoxNCZTdvGBGhmxQMurQ=
X-Google-Smtp-Source: ABdhPJw4VfehoLo+qNBMhNicEfRE+/Xof1tyMMB5ZNvQ5Y4t4BC72BB7g7RR6/fbebNtkZ+2VkSOPg==
X-Received: by 2002:a7b:c354:: with SMTP id l20mr7091891wmj.159.1628943321084;
        Sat, 14 Aug 2021 05:15:21 -0700 (PDT)
Received: from pswork (187-64-142-46.pool.kielnet.net. [46.142.64.187])
        by smtp.gmail.com with ESMTPSA id i14sm3996907wmq.40.2021.08.14.05.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 05:15:20 -0700 (PDT)
Date:   Sat, 14 Aug 2021 14:15:19 +0200
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v4] kallsyms: strip CLANG CFI postfix ".cfi_jt"
Message-ID: <20210814121519.GA5871@pswork>
References: <CABCJKuei==gaaKw0qH1WkshcRyUbqdS_WGRWr6anYAew1HHT2w@mail.gmail.com>
 <20210805232741.9501-1-treasure4paddy@gmail.com>
 <CABCJKue6dYBYTJtyX6oE8Lq1LVHcS+vq+Z4cRE2-Tut8GRHjPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKue6dYBYTJtyX6oE8Lq1LVHcS+vq+Z4cRE2-Tut8GRHjPQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 04:05:25PM -0700, Sami Tolvanen wrote:
> On Thu, Aug 5, 2021 at 4:28 PM Padmanabha Srinivasaiah
> <treasure4paddy@gmail.com> wrote:
> >
> > Clang CFI adds a postfix ".cfi_jt" to a symbols of extern functions.
> > For e.g. this breaks syscall tracer that doesn't expect such postfix,
> > so strip out the postfix from the expanded symbol.
> >
> > Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
> > ---
> > Change in v4:
> >   - Remove redundant check; irrespective of LTO type (THIN/FULL),
> >     LTO_CLANG will be always enabled. Hence will be used as entry flag
> >     to check various postfix patterns.
> >   - And prior to stripping postfix ".cfi_jt", added a comment to
> >     justify why we are doing so.
> >
> > Change in v3:
> >   - Modified commit message to indicate fix is for Clang CFI postfix
> >   - Rebased on recent patch from ndesaulniers@google.com.
> >     https://lore.kernel.org/lkml/
> >         20210707181814.365496-1-ndesaulniers@google.com/#t
> >   - Fix is enabled even for CONFIG_LTO_CLANG
> >
> > Change in v2:
> >   - Use existing routine in kallsyms to strip postfix ".cfi_jt" from
> >     extern function name.
> >   - Modified the commit message accordingly
> >
> >  kernel/kallsyms.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 5cabe4dd3ff4..1b40bcf20fe6 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -174,13 +174,15 @@ static bool cleanup_symbol_name(char *s)
> >          * foo.llvm.974640843467629774. This can break hooking of static
> >          * functions with kprobes.
> >          */
> > -       if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
> > +       if (!IS_ENABLED(CONFIG_LTO_CLANG))
> >                 return false;
> >
> > -       res = strstr(s, ".llvm.");
> > -       if (res) {
> > -               *res = '\0';
> > -               return true;
> > +       if (IS_ENABLED(CONFIG_LTO_CLANG_THIN)) {
> > +               res = strstr(s, ".llvm.");
> > +               if (res) {
> > +                       *res = '\0';
> > +                       return true;
> > +               }
> >         }
> 
> I confirmed that LLVM renames these also with full LTO, so the config
> check can be dropped here.
>
Thank you sami for the input I missread your earlier review commit, will
re-genrate the patch

> >
> >         /*
> > @@ -194,6 +196,17 @@ static bool cleanup_symbol_name(char *s)
> >                 return false;
> >
> >         res = strrchr(s, '$');
> > +       if (!res) {
> > +               /*
> > +                * In case of non static function symbol <funcsym>,
> > +                * the local jump table will have entry as <funcsym>.cfi_jt.
> > +                *
> > +                * Such expansion breaks some built-in components,
> > +                * e.g. syscall tracer. Hence remove postfix ".cfi_jt".
> > +                */
> > +               res = strstr(s, ".cfi_jt");
> > +       }
> > +
> >         if (res) {
> >                 *res = '\0';
> >                 return true;
> 
> Otherwise, the logic looks pretty good to me. Nick, are you planning
> to resend your earlier patch? Should this be just folded into the next
> version?
> 
> Sami
