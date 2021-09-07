Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8149403170
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 01:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347606AbhIGXSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 19:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhIGXSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:18:22 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCA5C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 16:17:15 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso520392otu.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnN+0NgFzidA6gPRetr+XvlpBJGnWHmkwX9iiDoK1Bk=;
        b=FJmMcleaW8tOSF7BlxlT9ZDLA7yxhClji31QRCClMXnEnD5LcH87At0hZiejtNhxeG
         +bq9ZGk0Mjb5z95X+UM1a2e+r1XObB0IgKaUeaBPXy+v/hFZEdOfvY5SwpPhb7N2+qUO
         zRxAyEvhYDL8S/XUmIAwal3siFQdaaC+X3NYr4icBhMv4F/VrUwt8LVJ07cfDYJr7QTJ
         EghtHQPBMzJ/FXRO2MIFSIyC4bpfnZ5ow9JYZ69nBt2DSbx/Mveo1sBT73KINegIfvnB
         +PnN6ySg+g2pcp2prEQJmHCyG+EgUgbuo8fgM1bT1FmEIIDJcneLn4SLsjFEakygSxbm
         I+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnN+0NgFzidA6gPRetr+XvlpBJGnWHmkwX9iiDoK1Bk=;
        b=i89EWOCHhzERiBu3SdP1GjrThmRB7aQ7TbooaBvJhQsQlZ3vJSeQgZctmngSuERKoZ
         CfR3SwQ9bX0ZT4YMc+jLR0HgHLfKy3fOwtZwGgNF4jckbxGQETYdeZHqrxwJb599Na6I
         tOkGrlnUWu/08C9GII2CHTZtoguK2mvbw102YffxDJpsuBsRyRzzmSz+aztYCSrFKhRD
         yJVnD2tcvxdg9GGNFN2oEDv0cX/7hGjS6JWPpEWDEFu2C2lt9lgfppQIEBE1ud+LXrrT
         X0GH4RhfWB2wahtugY3376n57fWWz/7LZfnJh3v/TmwXK3aMq/bYuAA4EIvns2KzOFRn
         ZOSQ==
X-Gm-Message-State: AOAM532SLrHvAbf0RKc5dlFeJMFEfYdkyUltXKritn1XZB4Gnu+KQ7di
        QQDeqBco7vk4n/vaB99ZG7EJKRXhGfXAY9yAclvAzQzJlZOycA==
X-Google-Smtp-Source: ABdhPJwOUTDmNi2ASfHPSyKT2mocfaP+CX48DJXl2frGEcxshg1NbaggzQ2fkgN+9myaB/RCbcM5yJL4OgCqgOKVdRw=
X-Received: by 2002:a9d:71db:: with SMTP id z27mr711371otj.292.1631056635100;
 Tue, 07 Sep 2021 16:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210908090720.0748b861@canb.auug.org.au> <20210908090907.74edb3a4@canb.auug.org.au>
In-Reply-To: <20210908090907.74edb3a4@canb.auug.org.au>
From:   Marco Elver <elver@google.com>
Date:   Wed, 8 Sep 2021 01:17:03 +0200
Message-ID: <CANpmjNMTUuMuEf_BsCROR6JS5q6GCyG163yaX710uctqvYXz5w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the origin tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sept 2021 at 01:09, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> On Wed, 8 Sep 2021 09:07:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Building Linus' tree, today's linux-next build (mips
> > allmodconfig) failed like this:
> >
> > In file included from /kisskb/src/include/linux/compiler_types.h:65:0,
> >                  from <command-line>:0:
> > include/linux/compiler_attributes.h:29:29: error: "__GCC4_has_attribute___no_sanitize_coverage__" is not defined [-Werror=undef]
> >  # define __has_attribute(x) __GCC4_has_attribute_##x
> >                              ^
> > include/linux/compiler-gcc.h:125:29: note: in expansion of macro '__has_attribute'
> >  #if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
> >                              ^
> > cc1: all warnings being treated as errors
> >
> > Caused by commit
> >
> >   540540d06e9d ("kcov: add __no_sanitize_coverage to fix noinstr for all architectures")
> >
> > This ia a gcc 4.9 build, so presumably this?
> >
> > diff -ru a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> > --- a/include/linux/compiler_attributes.h     2021-09-08 09:03:35.169225661 +1000
> > +++ b/include/linux/compiler_attributes.h     2021-09-08 09:05:47.790907780 +1000
> > @@ -36,6 +36,7 @@
> >  # define __GCC4_has_attribute___no_profile_instrument_function__ 0
> >  # define __GCC4_has_attribute___nonstring__           0
> >  # define __GCC4_has_attribute___no_sanitize_address__ 1
> > +# define __GCC4_has_attribute___no_sanitize_coverage__       0
> >  # define __GCC4_has_attribute___no_sanitize_undefined__ 1
> >  # define __GCC4_has_attribute___fallthrough__         0
> >  #endif
>
> Just to be clear, I haven't tested the above in any way.

I see this in next-20210907: "Compiler Attributes: fix
__has_attribute(__no_sanitize_coverage__) for GCC 4"
Which does the same fix.

Not sure what happened to it.

I would have also expected this to be merged as a fix into mainline by
now? Miguel?

Thanks,
-- Marco
