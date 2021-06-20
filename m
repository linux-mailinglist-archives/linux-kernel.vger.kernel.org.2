Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE843ADDB5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhFTILg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFTILZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 04:11:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14998C06175F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 01:09:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t7so14548320edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjSERqxDFGCyYrNN/qxA0ZiGx1EeVNWA0j1N532j0OQ=;
        b=O2mTGoMFVrnU3bwMOM112hgs3Z+LFM4ZVxbnAnn0MS6irjyF75/GvO5dfdLXAua/jf
         Xr9hkcbrhzoJeXx749WGZo5lY1lvdo6hJxC4KFtzwB3jn1rRG7394JGVBvd0Ob/gP29q
         a47ABW2L/YWjZLpn8qksbTNjdDK2Sx1CAVTfSy9CedEO1bOiy1EXeBESvHoVdA4N6qK6
         XkfOlaniy9s4/al3V9Uk7xVW+8qhPb4i3Vm77HwnS4TAGg97oj4vJcU7qPGsWdNNr42U
         7lcG6SaugtzlbgSzIq8V+B9eXVuT+24QuimRe1JDeLCLqVDFQ4nZyLGgsg6Sb7ivd1LT
         24tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjSERqxDFGCyYrNN/qxA0ZiGx1EeVNWA0j1N532j0OQ=;
        b=cGaFDHpM7BQVW4hpjt07lDb3VdUHRFaKKauQ7QJmeA6B38oirOI/RtBAzOU8j6XBiv
         mp3WWhKgKg9Y3mDz6N6/kXpHKc6FZ3PN4xvz4fgvebt+tS1haSLQL7/sPc0YdXRUCIqw
         DyTaUZru9Av+0Ca+DoIGUVX138vEH3hd9WkcT666KJ5t1b3wc11KiQkDS8YHimX7e9Wf
         iNAGm5xEKk9ZET4D2d0p7VWYTeXBVLwcc634MZz1yFyCAZnDU/K5VgD2bEaB5Zjvn1sp
         ctj3JDkuRzLC5ebikr2JnjaCFEVKdhGAPqQPcHDNHujWY7kw/By/OWCkMkiIBInTCPAI
         V/Fg==
X-Gm-Message-State: AOAM5306dTKqNxYlS04uKt/a9gl3PbdsljH09p1bQVwjErqP0fe2p796
        RG5rZB33ngAq/GPV8XEkHQgIg/PavPtvQOA1kKT9
X-Google-Smtp-Source: ABdhPJxRZvXKUEReti5s+grcd26OnOp3TX95hRrWOLTxyIX7eH6LObWJfBvB5fJdxksmCiFp5/LqjsTtg64W+ZisT2k=
X-Received: by 2002:a05:6402:946:: with SMTP id h6mr14509058edz.261.1624176549643;
 Sun, 20 Jun 2021 01:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210618233023.1360185-1-ndesaulniers@google.com> <202106181945.AC10BF38ED@keescook>
In-Reply-To: <202106181945.AC10BF38ED@keescook>
From:   Bill Wendling <morbo@google.com>
Date:   Sun, 20 Jun 2021 01:08:58 -0700
Message-ID: <CAGG=3QXcn0QMGj0AB9N2cSHHGpCmYWg-3Wq8M1jLM2AehEWh5A@mail.gmail.com>
Subject: Re: [PATCH 0/2] no_profile fn attr and Kconfig for GCOV+PGO
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Bill Wendling <wcw@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Martin Liska <mliska@suse.cz>,
        Marco Elver <elver@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Fangrui Song <maskray@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, johannes.berg@intel.com,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 7:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 18, 2021 at 04:30:21PM -0700, Nick Desaulniers wrote:
> > When we say noinstr, we mean noinstr.  GCOV and PGO can both instrument
> > functions. Add a new function annotation __no_profile that expands to
> > __attribute__((__no_profile__)) and Kconfig value
> > CC_HAS_NO_PROFILE_FN_ATTR.
> >
> > Base is
> > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-next/clang/pgo.
> >
> > Nick Desaulniers (2):
> >   compiler_attributes.h: define __no_profile, add to noinstr
> >   Kconfig: CC_HAS_NO_PROFILE_FN_ATTR, depend on for GCOV and PGO
>
> Oh, awesome! Thanks for the fast work on this. If there are no objections,
> I'll apply this in front of the PGO series and put it in -next.
>
That works for me! Thanks, Nick and Kees!

-bw
