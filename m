Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483BC397974
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhFARsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhFARsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:48:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5991EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 10:47:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x38so23093653lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJYP1ahOHUDkEz4I2iYxmBxvA/YEgFvm6f/leHoOsVY=;
        b=uiisl/l2JAeeqyGsUirCfSyUuUVpC8Cfit36EJ+bP2ODPTY7wxHgP0BQmI5rHxhTY9
         LbJTI6WRjpjYGzpNwaOxqr6d7GSJnRpo+o1iVKkG0xUFVi7v3lmS5lLTRM4le9l4botv
         yb/lYPJKPLxS6ZbEdq69Yj5yZIgEUa+RdqMg4bJ8B4Vfe/M4ybKPhrZwW8ZFgr2tQInN
         uwTSyR7MUp+ysnFEOyUgaIuszyz0531mGUwp7h0eGYilZYVVX0Dm2TgvSAkimrIaEzRX
         Q9OP9icLpFN8qXEnagMF2oBO+ou8qmSVs5yuHmh0DNud2zh4Hl+K7BShc36iIkUaP4rr
         9hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJYP1ahOHUDkEz4I2iYxmBxvA/YEgFvm6f/leHoOsVY=;
        b=a/21lTKqlaUiag4OzplRxO9oRehG6vh8XMBzooTrJ6+EChHztH+xq2j/1/Zg5STMkf
         xIdBcNMji947kxOyFC5BY8ePaL73HGYidwqhLnYSZWS7BvXzR4jm2kpYV4gxMgGm3CY2
         Q5XzfA3PVIlzJVs6EjRyjp5Dyu0COYHbfBxfiJmb4R0GRUA4MWcRiqupjSdWZEc/UAwL
         4UXci9RQPVjZ2wJv8FfMHaORGETcgODbWfcjSO4LwFJcEZDQXB9Kby2Z7thgn694F+D6
         XTTVPPXSjbmc+12xbFC0CtmfNQ/pBaj7f/GvzOYC6kYHG3KWSEbZzeWpOk1vmonwq1pZ
         oDsw==
X-Gm-Message-State: AOAM532G68v5q8T8H2kx4LwdaiEWZGVb9bN6GM/gDnJd6BsFofTChSN7
        MjmAfaqM5o+1NtfGN8ZHmz2/aWmuC0DwyKrdA46XeUbQURQ=
X-Google-Smtp-Source: ABdhPJw42vulKDibjXHniD1a5KBQ7FuDHO9ORXGzCVu1stGaMi5omtQP2h7TLf4fg+sYsaNxhkBj+xxxGDJcXv2pTZw=
X-Received: by 2002:a19:dc08:: with SMTP id t8mr8284937lfg.503.1622569618435;
 Tue, 01 Jun 2021 10:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210527162655.3246381-1-elver@google.com> <CAKwvOdmgZXJB2dV7iG67qHgbDgVTJaH7b3dkpgZyea4ULgQjgA@mail.gmail.com>
In-Reply-To: <CAKwvOdmgZXJB2dV7iG67qHgbDgVTJaH7b3dkpgZyea4ULgQjgA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 1 Jun 2021 19:46:47 +0200
Message-ID: <CANpmjNNqzCTks5dFkbbqzPP4UX7GDTdjbvJ7SbN2jcSNWjxQzA@mail.gmail.com>
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

On Tue, 1 Jun 2021 at 19:42, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Thu, May 27, 2021 at 9:27 AM Marco Elver <elver@google.com> wrote:
> >
> > Until now no compiler supported an attribute to disable coverage
> > instrumentation as used by KCOV.
> >
> > To work around this limitation on x86, noinstr functions have their
> > coverage instrumentation turned into nops by objtool. However, this
> > solution doesn't scale automatically to other architectures, such as
> > arm64, which are migrating to use the generic entry code.
> >
> > Clang [1] and GCC [2] have added support for the attribute recently.
> > [1] https://github.com/llvm/llvm-project/commit/280333021e9550d80f5c1152a34e33e81df1e178
> > [2] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=cec4d4a6782c9bd8d071839c50a239c49caca689
> > The changes will appear in Clang 13 and GCC 12.
> >
> > Add __no_sanitize_coverage for both compilers, and add it to noinstr.
> >
> > Note: In the Clang case, __has_feature(coverage_sanitizer) is only true
> > if the feature is enabled, and therefore we do not require an additional
> > defined(CONFIG_KCOV) (like in the GCC case where __has_attribute(..) is
> > always true) to avoid adding redundant attributes to functions if KCOV
> > is off. That being said, compilers that support the attribute will not
> > generate errors/warnings if the attribute is redundantly used; however,
> > where possible let's avoid it as it reduces preprocessed code size and
> > associated compile-time overheads.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> > v2:
> > * Implement __has_feature(coverage_sanitizer) in Clang
> >   (https://reviews.llvm.org/D103159) and use instead of version check.
> > * Add Peter's Ack.
> > ---
> >  include/linux/compiler-clang.h | 11 +++++++++++
> >  include/linux/compiler-gcc.h   |  6 ++++++
> >  include/linux/compiler_types.h |  2 +-
> >  3 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > index adbe76b203e2..e15eebfa8e5d 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -45,6 +45,17 @@
> >  #define __no_sanitize_undefined
> >  #endif
> >
> > +/*
> > + * Support for __has_feature(coverage_sanitizer) was added in Clang 13 together
> > + * with no_sanitize("coverage"). Prior versions of Clang support coverage
> > + * instrumentation, but cannot be queried for support by the preprocessor.
>
> I'm not against a version check for supporting older releases (in
> addition to the cleaner feature check, since the feature check was
> non-existent); we can clean it up someday when clang-13 is the
> minimally supported version.  Would having an additional version check
> help support existing/older releases here?

The feature check will just return 0 on older releases, since the
feature does not exist there. Therefore, no additional code is
required to support older releases and a version check would be
redundant.

> > + */
> > +#if __has_feature(coverage_sanitizer)
> > +#define __no_sanitize_coverage __attribute__((no_sanitize("coverage")))
> > +#else
> > +#define __no_sanitize_coverage
> > +#endif
> > +

Thanks,
-- Marco
