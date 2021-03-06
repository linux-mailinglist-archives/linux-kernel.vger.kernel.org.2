Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0029332FD84
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 22:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhCFVeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 16:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhCFVdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 16:33:47 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3BBC06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 13:33:47 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id h4so9659875ljl.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 13:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYVEwzZhLwplYvENbyLDo2KBa4YyGfoYjQU60hfjeAE=;
        b=GeeH1OYVzaLLpPl2mP61ssVSI2UKJSm1EAkx4xzkZr84Wr3Nw/f5sD6LgJlbRFyxab
         XJG71kajxiLs01yTxCoNiDag9LNe0hXYgp1l4gznLjO91ntuKW7+sxaYeot4ghuHupke
         1pIs+cbYOLKakGudxCvKT4rmy2Fh4//V7dXYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYVEwzZhLwplYvENbyLDo2KBa4YyGfoYjQU60hfjeAE=;
        b=q9Qblw0spjfZ0A2aDabJSrV8og/0fwHNPVm70D05K1ngQMJPWzlcKUOa3Pt4OpaFQb
         4Dqbbr6FUV6bibBLE9n4BUMSrAj3iGZvn1MMqcA0LpvY5vCz+8DG+WEBXBAc5Bu8/L5H
         cH2eNcTPadT/nPVlSBUO+UeExXmZu7AqoDJDpN2qqrdmsYHZw2VJFATysKlGCwsoedJK
         q8P7dy9YzTOB331IL2BUX4m5Hvnu6Pm6E4SCRQhLdQtCbnFisiLZJej/yGQFBPb017mN
         Pvp+k4sTwBAkQJiX5VKaFmJFGl48NcsBheVjTy8wcaxTiagH63wGFgd3sQxSdzrd4OlQ
         +/JA==
X-Gm-Message-State: AOAM532r7in0ELtu+0yneZVscKnAhrvMLwe+TbCoRwsl46YQX0XxIzBg
        BAoi5i/P2CG2H4GzEfo7x1XHUdQ9bKMlMg==
X-Google-Smtp-Source: ABdhPJzUX72eK3y20pz8O/A36trYWiDOr94Nheh+qyse5ITVMgSBGHkKv7ykHfP3Iowju6RJNuo6fw==
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr9463406ljk.169.1615066425030;
        Sat, 06 Mar 2021 13:33:45 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id o20sm773675lfu.286.2021.03.06.13.33.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 13:33:44 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id p21so12627960lfu.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 13:33:43 -0800 (PST)
X-Received: by 2002:a19:ed03:: with SMTP id y3mr9567287lfy.377.1615066423154;
 Sat, 06 Mar 2021 13:33:43 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain> <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
 <877dmo10m3.fsf@tromey.com> <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
 <4835ec1d2ecc40b285596288a0df4f47@AcuMS.aculab.com> <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
 <44a0cc9cb5344add8ee4d91bffbf958f@AcuMS.aculab.com> <CAHk-=whh3fiL7FcLD_r1rfx-gP9W4HWS7vTPM9LKUH+0xzF2=A@mail.gmail.com>
 <CANiq72k-_ORGU+tCVhBGnr0QtH4hQ45ayzDtoHND8JZa2jYYPA@mail.gmail.com>
In-Reply-To: <CANiq72k-_ORGU+tCVhBGnr0QtH4hQ45ayzDtoHND8JZa2jYYPA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Mar 2021 13:33:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTWnAZitAYrSD508rxoLtB47p1ntyqYLzVeb=mTQ6tHw@mail.gmail.com>
Message-ID: <CAHk-=wgTWnAZitAYrSD508rxoLtB47p1ntyqYLzVeb=mTQ6tHw@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Tom Tromey <tom@tromey.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 5:07 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Concerning #pragma once: I actually would like to have a standard
> #once directive if what is a "seen file" could be defined a bit more
> precisely.

I think it would be ok if you had something like

   #pragma once IDTOKEN

which would basically act *exactly* as a "#ifndef IDTOKEN/#define
IDTOKEN" with that final #endif at the end of the file.

But even then it should have the rule that it must be the very first
thing in the file (ignoring whitespace and pure comments).

Then it would literally be just a cleaner and simpler version of the
guarding logic, with none of the semantic confusion that #pragma once
now has.

Because I cannot see any other way to define what "seen file" really means.

There's no sane "implied IDTOKEN" that I can see. It can't really be
the pathname, because pathnames are actually really hard to turn into
canonical form in user space thanks to things like symlinks. It can't
be st_ino/st_dev stat information, because the C preprocessor isn't a
"POSIX only" thing.

It could be a "Ok, #pragma once only works if you don't have multiple
ways to reach the same file, and you never have ambiguous include
paths". But that's actually not all that unusual in real projects: you
often have fairly complex include paths, you have C files that include
the header in the same directory with just "filename.h", but it
_could_ get included indirectly from _another_ header that gave a
pathname relative to the project root, etc etc.

This is not unrelated to another complete morass of horrible problems:
precompiled header files. That feature had exactly the same reason for
it as "#pragma once" - slow build speeds due to the cost of parsing
complex header file hierarchies.

And I guarantee that multiple compiler teams spent hundreds of
person-years of effort on trying to make it work. And several
compilers do support the notion. And they ALL have big warnings about
when you should enable it, and when you shouldn't, and what things
don't work if you use them, and about how it can cause really really
subtle problems.

Because it turns out that precompiled header files are a major pain
and a major mistake. Some projects still use them, because they can be
such a huge timesaver (again: particularly C++ projects that just have
a "include everything" approach to headers because trying to separate
things out is too hard). But they all come with huge warnings about
how they break the actual real semantics of a compiler, and if you do
_anything_ to change the build ("hey, I'd like to use a different
compiler option"), things may or may not work.

           Linus
