Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4E40B951
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhINUeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbhINUeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:34:04 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2506C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:32:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c206so745483ybb.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfCs5ZOjiQwn8561ZlGnTqyiRoY51Z30liszO8UxNQY=;
        b=bcaWNiUmkwe6O+wIIy65AytawNojw83SBP2fQAkZFCKkQ5m+UNFh0SVKHeD9Tm1HWZ
         uszQabEJWi/OVKkhLwFZ/uNCVq8TzahJNZw9ppPmCbAEUQB2vDg3TQVBX9DdqWtpVwCF
         gTqrSnuoKk/jMCmAa9FJQJQ+DNoRoZMNeCPDGnYOUSHcRVOraJl7ATFALh7PSCmA3wWu
         NyvyLzKhIiCtq3ajsnqBaDoPgUtHKvvedNtdzWc675nYfwyakomLkU6Nte03hO+q+vrZ
         Foy8xooQQ7u9C47j5IHKWFwNSvWfimfm9OxmHEyF22wdToYgkTjWQI+RyNUPqPZj2DWx
         cj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfCs5ZOjiQwn8561ZlGnTqyiRoY51Z30liszO8UxNQY=;
        b=0Y4pql7KaFvyp7UPYXAoqNA+hU7z7Cb5czi0sDl+I20uvzzV4AT/NQ0aR+qLWu5fX3
         uFGzTQ1BQoxrHttGFkIzf5h/fBJpCWrPsHPohMp+Vc9WCr4dk4/rnxcbEEWts1GrTTvW
         fAL1Bt1Qp7upqeHT86/w64XiQdvoglG9uQXBPXq/AzP3qMbckWjNF5PI1nXBxZfVIKZi
         TMO5x7nwuihvaSx+vi4PcO6ev9KUxE4ZeNuk01kqV8xlc4Z1s09+dCVlvO1n0Ll11HUh
         3plQZiOUhLEkflFmQuMtz2K1bcqKxisVOnwKDm++AcqUhDPmEkDPxOd+R90K/It5CHCl
         kekQ==
X-Gm-Message-State: AOAM532HVJMUeSDB+Ho/gbbHyZvLaYlFb/UEzpJNecdViBkJ/WEjstZs
        /G6tvjx/x7bs32IgushtlPeje+iFwTsB0WbSMSumZA==
X-Google-Smtp-Source: ABdhPJxIvcMD+L8IGnxkRjwWdcD9kMSbk077KA22bPLKMcWA4LzDlbScguPptlpzJDanrJWpmENcGDtAzzfrX1U2RdM=
X-Received: by 2002:a25:2142:: with SMTP id h63mr1475940ybh.70.1631651565763;
 Tue, 14 Sep 2021 13:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-5-samitolvanen@google.com> <CAKwvOdnTeTLcrjPy5QcshSLr0Cc2uj7_hTt70j37eEBZzxr=PA@mail.gmail.com>
In-Reply-To: <CAKwvOdnTeTLcrjPy5QcshSLr0Cc2uj7_hTt70j37eEBZzxr=PA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 14 Sep 2021 13:32:34 -0700
Message-ID: <CABCJKuc1LNPfO=RBDpOahGBgc7TF1L4D_ujhbrNfFWJaExsjpQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:36 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 14, 2021 at 12:10 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
> > which defines a stub function that immediately returns and when
> > defined in the core kernel, always passes indirect call checking
> > with CONFIG_CFI_CLANG. Note that this macro should only be used when
> > a stub cannot be called using the correct function type.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
> >  include/linux/cfi.h               | 14 ++++++++++++++
> >  kernel/cfi.c                      | 24 +++++++++++++++++++++++-
> >  3 files changed, 48 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index f2984af2b85b..5b77284f7221 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -407,6 +407,16 @@
> >         KEEP(*(.static_call_tramp_key))                                 \
> >         __stop_static_call_tramp_key = .;
> >
> > +#ifdef CONFIG_CFI_CLANG
> > +#define CFI_EXCLUDED_DATA                                              \
> > +       . = ALIGN(8);                                                   \
> > +       __start_cfi_excluded = .;                                       \
> > +       KEEP(*(.cfi_excluded_stubs))                                    \
> > +       __stop_cfi_excluded = .;
> > +#else
> > +#define CFI_EXCLUDED_DATA
> > +#endif
> > +
> >  /*
> >   * Allow architectures to handle ro_after_init data on their
> >   * own by defining an empty RO_AFTER_INIT_DATA.
> > @@ -430,6 +440,7 @@
> >                 __start_rodata = .;                                     \
> >                 *(.rodata) *(.rodata.*)                                 \
> >                 SCHED_DATA                                              \
> > +               CFI_EXCLUDED_DATA                                       \
> >                 RO_AFTER_INIT_DATA      /* Read only after init */      \
> >                 . = ALIGN(8);                                           \
> >                 __start___tracepoints_ptrs = .;                         \
> > diff --git a/include/linux/cfi.h b/include/linux/cfi.h
> > index 879744aaa6e0..9ebf67a0d421 100644
> > --- a/include/linux/cfi.h
> > +++ b/include/linux/cfi.h
> > @@ -20,6 +20,18 @@ extern void __cfi_check(uint64_t id, void *ptr, void *diag);
> >  #define __CFI_ADDRESSABLE(fn, __attr) \
> >         const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
> >
> > +/*
> > + * Defines a stub function that returns immediately, and when defined and
> > + * referenced in the core kernel, always passes CFI checking. This should
> > + * be used only for stubs that cannot be called using the correct function
> > + * pointer type, which should be rare.
> > + */
> > +#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
> > +       void fn(void) { return; } \
> > +       const void *__cfi_excl_ ## fn __visible \
> > +               __attribute__((__section__(".cfi_excluded_stubs"))) \
>
> Can we use __section from include/linux/compiler_attributes.h here
> rather than open coding the function attribute?

Sure. I'll change this in v4.

Sami
