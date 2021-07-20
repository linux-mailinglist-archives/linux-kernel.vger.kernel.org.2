Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E350F3D03DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 23:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhGTUrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 16:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhGTUqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 16:46:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B6C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 14:27:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c23so234595ljr.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNyYA05ylU2XvRUfrq05bnLIwQDYxkRccZveeJvkl54=;
        b=nyPyS8j29YzOV3W5hC0WKKPhbhG/VyL5LXoVZNrXlICf1TF0yf/aaVryX160Fi3Dlq
         NyBK/+QQm5fJUpSdjV1mhcvj/ENGOOYnMBeiMXYHWSR60QlwUzS835imVP+P6M7H1YRj
         p96qmwII9W3WT9cbOBnBiWAWYx26tr/n7iLkOMoWXXSu02/QjELIlHllDlHzaUHsL8QP
         TV+x7Ys34raApA9sK3A5QE72qZ2lxfBQTnSJ0LgV9U3edO0+2SMba+ChpV0dxHVZdRnc
         JxKJLgaNbOQy2jaLd0FlXpHaE2Cl4aN452zhcuh6RssvdCQd624ZPU0qzTEj34rNzAs1
         RiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNyYA05ylU2XvRUfrq05bnLIwQDYxkRccZveeJvkl54=;
        b=U+BPajUFwYX5CYxeZNYoSBOEdh+tZ3Zju8QzeNIO2T8KAhCSPgWIt0YEc+OJadvsOz
         HeLUlAvYdCkp0IkD6sNh2LzH2bvsAZbsWDUilgxLgRBnAEpY+yVvU/OjFt17kRQZOMyV
         du4TXlGD5G3ZLgFQW2ZddJQRQgg3MQvmAWGwGx78Y8qPXHXdGKnGs8bqV5VSNsCJH9ma
         hQt+pLz2yxid8+RvSSvtv+6iqKX2lg6vCEZHcl+9DYj02XiQUNMlMys5ThHGjoFp6sna
         72gMD8A+3LTHEWl1UvnPA0j9IbE55C+DyGiDqwhMLcrW4XWiHv1ebFeesXi++l6QLSzj
         y/Mw==
X-Gm-Message-State: AOAM530lb5pxzK59yG4DCUDi7Hxb5dpgw/HxJ31Ee+7SUdgTcSrX4Pwd
        5OqhgpCEv/1DLdyeMB5YlEZhZFRZbRh8iiuRu2NenQ==
X-Google-Smtp-Source: ABdhPJxrOj+Jm37rU9hqwWfFoY2vsD5IZ88MYg7a5i30OSi5oVHFIzKL+6LR32Xlpue7pPsvCxVG/IYkWw/LWIe7BqE=
X-Received: by 2002:a2e:a784:: with SMTP id c4mr3289166ljf.479.1626816440772;
 Tue, 20 Jul 2021 14:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210708232522.3118208-1-ndesaulniers@google.com>
 <20210708232522.3118208-3-ndesaulniers@google.com> <CAK7LNARye5Opc0AdXpn+DHB7hTaphoRSCUWxJgXu+sjuNjWUCg@mail.gmail.com>
 <CAHk-=wgGxu4_hgzdYpFuKd95SfnkJbPTWAQ9-fMgmMN1Oxs2xQ@mail.gmail.com>
 <CAKwvOdn065OJpow=7VF=ujagFoyN4sYMKAA_E2_39ZC7uThchg@mail.gmail.com> <CAHk-=wjDdDPDa6mfoC-QM=NZULsmQfcUbF2RdwMq0J4Ztm+UAw@mail.gmail.com>
In-Reply-To: <CAHk-=wjDdDPDa6mfoC-QM=NZULsmQfcUbF2RdwMq0J4Ztm+UAw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 20 Jul 2021 14:27:10 -0700
Message-ID: <CAKwvOdk7ATbLP9uRVgWnYHQT0BKAuOTPmOeWdZgytTs=bqTLfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: infer CROSS_COMPILE from SRCARCH for
 LLVM=1 LLVM_IAS=1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 2:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jul 20, 2021 at 1:52 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > >     -CC = $(CROSS_COMPILE)gcc
> > >     +CC = $(CROSS_COMPILE)clang
> >
> > So you haven't been using LLD... :( (imagine using more than one
> > thread to link, and being faster than ld.gold)
>
> I started out just building my own clang - nothing else.
>
> And now that I'm using the distro clang, the linker isn't even _close_
> to a performance issue. Since clang is a big, slow, bloated pig.
>
> I posted profiles and performance numbers of clang being three times
> slower than gcc, and it was all just clang itself, not the linker. All
> due to insanely expensive startup costs.

Yeah, it's unfortunate that package maintainers for your distro chose
to distribute clang built in such a manner.  But in response to that
thread:
1. I planned a whole conference around how folks distribute LLVM
(particularly how the configurations are done, and important ones to
use):
https://lists.llvm.org/pipermail/llvm-dev/2021-June/150861.html
We have a pretty good set of CFPs lined up (and I need to go chase
folks from Apple and Qualcomm that are working on proposals...)
https://github.com/ClangBuiltLinux/llvm-distributors-conf-2021/issues

2. I brainstormed a whole set of ways to make Clang even faster.
https://github.com/ClangBuiltLinux/tc-build/issues
Most promising I think would be building musl with LTO and statically
linking that into the toolchain.  I don't have a ton of time to pursue
that, but I will continue to bang on that drum in front of management.
It's just very hard to fund improving build times for users on
thinkpads when the corporate world has moved on to distributed and
cached building in the cloud.

3. Pretty sure we've resolved that config with your distro's packager,
and made other changes to upstream LLVM to default on some flags that
help a lot when those unfortunate configs are used.
https://reviews.llvm.org/D102090

> I suspect a lot of clang users build bloated C++ code where the time
> to compile a single object file is so big that the startup costs don't
> even show up. But for the (fairly) lean C kernel header files that
> don't bring in millions of lines of headers for some template library,
> startup costs are a big deal.
>
> So honestly, I don't care at all about "imagine being faster than ld.gold".
>
> I can only _dream_ of clang itself not being 3x slower than gcc.

Let's be precise here, because quotes (even when imprecise) lead to PR
cycles.  Clang startup time for NULL input when testing command line
flags as part of a build configure step, when clang is misconfigured
is slower than GCC. Clang is not generally 3x slower than GCC.
-- 
Thanks,
~Nick Desaulniers
