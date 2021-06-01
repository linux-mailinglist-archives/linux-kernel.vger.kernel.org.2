Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FB397986
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhFARzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhFARzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:55:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C16C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 10:53:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i9so23103176lfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKgq4o1KMFQWb4eqWEtxAreJyLSizVw7xMXtspskoP8=;
        b=lqW4OyYIyzQXiwKeWaV8Uk5Ch9HMdYdXO8sP+yS4DK+fiyA/TxN2TNwChsDB+cAUuR
         gz1+832czC+X1Eve6jIVmvAxrmJiDBBEjCSQdpQF3XjLzH9wqFZe/dgiNEiHsvg45h7/
         FWYhKk1rd4gqtMglXo+9b1f54dAw7x9QTqK0Raav47QddGYKRabmE56cHdM3cUXCs1X5
         +BgqBq6gkuImhEmxVwEk85VxFdwFWPLXNFTcQelD1PluCX+d5Ev2tgoEo8jpxxp+Kapc
         +nzXVW/181RyBw2hskDYeJzdiq/Lx6my/wjw4I7Ewlj50YhmUzAF60NsYWbkA3RPsT30
         iYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKgq4o1KMFQWb4eqWEtxAreJyLSizVw7xMXtspskoP8=;
        b=Gkq6Ak+uiQ1J+m4dv669TAGQox6Q6pffEu4jKZgC0eHym0Futqkz2E+95uXRSPVACh
         FU3e01h/J204yxLl1+dzRf1L5K2sa0OwN/TzJZvTuX0H9pzkR3pvaEvMzPW0EQYgBPJT
         T2gR7wFH4PLQWmCurwpzB+xZXJoFMmduIY/35iSIwNDNY0Tfl4n9l7Yzar506ZlrfRIw
         2xfXral7PjzhF9jzqg/vBfddSSh0GX2DczZ1+uTOMZJzNyJXLvPdov++tzcSyQ09nW0U
         w6vQoRQOvJiY0yFJcg+cOur/Ey609H4UGbTNnSOExJ9nFmTJLvq7d2Up8xSf6wcLGF7d
         73cg==
X-Gm-Message-State: AOAM530k6oa5vVRZoWe9tZT5qSqHRpHNdxD+ZtTaPe+hX9M4XEHlqKJw
        2HQuP/RY4j9um60lYDf+D+zA2p6/n0V/HZaxyMGTIA==
X-Google-Smtp-Source: ABdhPJwfSOAZDnV94K10x2/RCp7A5T3vVKm8Js/QttEd8REunw9pWBZPSBq/+DmK11JCvZU69TEsW2HYMLu2h2LCBSk=
X-Received: by 2002:a05:6512:46c:: with SMTP id x12mr5528836lfd.203.1622570015793;
 Tue, 01 Jun 2021 10:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210527162655.3246381-1-elver@google.com> <CAKwvOdmgZXJB2dV7iG67qHgbDgVTJaH7b3dkpgZyea4ULgQjgA@mail.gmail.com>
 <CANpmjNNqzCTks5dFkbbqzPP4UX7GDTdjbvJ7SbN2jcSNWjxQzA@mail.gmail.com>
In-Reply-To: <CANpmjNNqzCTks5dFkbbqzPP4UX7GDTdjbvJ7SbN2jcSNWjxQzA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 1 Jun 2021 19:53:24 +0200
Message-ID: <CANpmjNNXepu4=9Fgzdu9g8AzNQ_vfZvAf=AFOAfbWg8e8qzxRA@mail.gmail.com>
Subject: Re: [PATCH v2] kcov: add __no_sanitize_coverage to fix noinstr for
 all architectures
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 at 19:46, Marco Elver <elver@google.com> wrote:
>
> On Tue, 1 Jun 2021 at 19:42, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > On Thu, May 27, 2021 at 9:27 AM Marco Elver <elver@google.com> wrote:
> > >
> > > Until now no compiler supported an attribute to disable coverage
> > > instrumentation as used by KCOV.
> > >
> > > To work around this limitation on x86, noinstr functions have their
> > > coverage instrumentation turned into nops by objtool. However, this
> > > solution doesn't scale automatically to other architectures, such as
> > > arm64, which are migrating to use the generic entry code.
> > >
> > > Clang [1] and GCC [2] have added support for the attribute recently.
> > > [1] https://github.com/llvm/llvm-project/commit/280333021e9550d80f5c1152a34e33e81df1e178
> > > [2] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=cec4d4a6782c9bd8d071839c50a239c49caca689
> > > The changes will appear in Clang 13 and GCC 12.
> > >
> > > Add __no_sanitize_coverage for both compilers, and add it to noinstr.
> > >
> > > Note: In the Clang case, __has_feature(coverage_sanitizer) is only true
> > > if the feature is enabled, and therefore we do not require an additional
> > > defined(CONFIG_KCOV) (like in the GCC case where __has_attribute(..) is
> > > always true) to avoid adding redundant attributes to functions if KCOV
> > > is off. That being said, compilers that support the attribute will not
> > > generate errors/warnings if the attribute is redundantly used; however,
> > > where possible let's avoid it as it reduces preprocessed code size and
> > > associated compile-time overheads.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > > v2:
> > > * Implement __has_feature(coverage_sanitizer) in Clang
> > >   (https://reviews.llvm.org/D103159) and use instead of version check.
> > > * Add Peter's Ack.
> > > ---
> > >  include/linux/compiler-clang.h | 11 +++++++++++
> > >  include/linux/compiler-gcc.h   |  6 ++++++
> > >  include/linux/compiler_types.h |  2 +-
> > >  3 files changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > > index adbe76b203e2..e15eebfa8e5d 100644
> > > --- a/include/linux/compiler-clang.h
> > > +++ b/include/linux/compiler-clang.h
> > > @@ -45,6 +45,17 @@
> > >  #define __no_sanitize_undefined
> > >  #endif
> > >
> > > +/*
> > > + * Support for __has_feature(coverage_sanitizer) was added in Clang 13 together
> > > + * with no_sanitize("coverage"). Prior versions of Clang support coverage
> > > + * instrumentation, but cannot be queried for support by the preprocessor.
> >
> > I'm not against a version check for supporting older releases (in
> > addition to the cleaner feature check, since the feature check was
> > non-existent); we can clean it up someday when clang-13 is the
> > minimally supported version.  Would having an additional version check
> > help support existing/older releases here?
>
> The feature check will just return 0 on older releases, since the
> feature does not exist there. Therefore, no additional code is
> required to support older releases and a version check would be
> redundant.

And to avoid further confusion: -fsanitize-coverage exists, but the
feature "coverage_sanitizer" queryable by __has_feature() does not
exist. The confusion is the price we pay for this technical debt --
but I'd rather not write an essay about this in the comments. Most of
it is in the commit message, and if people are still confused I hope
they find this thread.

There was also a v3 explaining this more in the comments, too:
https://lkml.kernel.org/r/20210527194448.3470080-1-elver@google.com

Hopefully that is all enough.

> > > + */
> > > +#if __has_feature(coverage_sanitizer)
> > > +#define __no_sanitize_coverage __attribute__((no_sanitize("coverage")))
> > > +#else
> > > +#define __no_sanitize_coverage
> > > +#endif
> > > +
>
> Thanks,
> -- Marco
