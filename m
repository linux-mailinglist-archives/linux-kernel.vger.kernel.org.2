Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D627542170A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhJDTMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhJDTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:12:48 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C42C061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:10:59 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id n65so10338315ybb.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX98aLvs0jm488r8l6cPv4x2o09VgHdP6nIV9yzsoR8=;
        b=jrdny670eRSrixabawz8NM8mV1j3NcKBf3/5o2HmMYs5Pt/3jEDKejaagNLZuHD4eA
         XsA7lnk5rlDb255PMmTfbkU01FmcbAxBIYEQtM94T1iMAclIOyb2sv35ZTukC2pwU2GG
         ltnDtI/O33I3Ik/UGu+M8Yrc0A6fNj4jCPp0p3IE11EK9JyQmUG6php2mjyq7W1jvwzx
         hm4UYlfHmBM4ZggOpSlbBQ2TH3Rh8u5TAQjTysy9vuPEMDgSJTBc8GQ46Bm7g/nowXkw
         mNseks8sftxpTK7nsWq+M26M6JTRKKfc+IXpLEJJw6dXy7eJuoEmg5mbmgeSD8SJR7lw
         RJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX98aLvs0jm488r8l6cPv4x2o09VgHdP6nIV9yzsoR8=;
        b=7ov3rikhBFtJzIf2DuVbJbHyEBJWJQBy4Y9+sKxj+CmSvMhpIZJIjAQJr/kNTF7c0P
         52RMJEqTQbapOVw1moHxrnf5NbW6rBE0v9pr9g2j30PCY1qJGOV3c7L9z/+IoZu+HpBH
         CBKU5bkECiL2h1589K6ozVWcE1t3CXRp7wfMapZoniZJDLKnGHMUlZPzS+6MzQIO1RzF
         ShJZv/jtIvB4SLsohPdTjqTqof23Nl4guaId+168y3rDrF6Ww6LEWntdHuhe/EYjVCB8
         bFc0XUKBP0Eq0qf5hNEC+b3AjGxeZi+SbVk3c8zIEG2BOx5mxQf//YwH0sKWkoVQHlAN
         OOXg==
X-Gm-Message-State: AOAM531t7ITPB352Ufk5Y21rIZjJEtdNsOcBDX6h0r1bjdHQUVzo0lJt
        jE0eV1DtgeVpGbkdm0Y8rvjiwR6Cyh81LJqlqnaoQQ==
X-Google-Smtp-Source: ABdhPJyvignQgUWVGULEBdeVmUDF7c5rAhbNIgSFqFjfcL8Oh9L1Nm3LtbDC/MhhvQjpl759ZDx6OBAK3+tEv7om3q8=
X-Received: by 2002:a25:aaec:: with SMTP id t99mr17333011ybi.456.1633374657849;
 Mon, 04 Oct 2021 12:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-5-samitolvanen@google.com> <YVsGoJ+NN6wRFi22@hirez.programming.kicks-ass.net>
In-Reply-To: <YVsGoJ+NN6wRFi22@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 4 Oct 2021 12:10:46 -0700
Message-ID: <CABCJKudBrHfwR=gQc=9=cfBjR9p5jm65ovSNwzLLEpDUdo6ZPQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 6:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 30, 2021 at 11:05:20AM -0700, Sami Tolvanen wrote:
> > This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
> > which defines a stub function that immediately returns and when
> > defined in the core kernel, always passes indirect call checking
> > with CONFIG_CFI_CLANG. Note that this macro should only be used when
> > a stub cannot be called using the correct function type.
>
> > diff --git a/include/linux/cfi.h b/include/linux/cfi.h
> > index 879744aaa6e0..19f74af8eac2 100644
> > --- a/include/linux/cfi.h
> > +++ b/include/linux/cfi.h
> > @@ -20,6 +20,17 @@ extern void __cfi_check(uint64_t id, void *ptr, void *diag);
> >  #define __CFI_ADDRESSABLE(fn, __attr) \
> >       const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
> >
> > +/*
> > + * Defines a stub function that returns immediately, and when defined and
> > + * referenced in the core kernel, always passes CFI checking. This should
> > + * be used only for stubs that cannot be called using the correct function
> > + * pointer type, which should be rare.
> > + */
> > +#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
> > +     void fn(void) { return; } \
> > +     const void *__cfi_excl_ ## fn __visible \
> > +             __section(".cfi_excluded_stubs") = (void *)&fn
> > +
> >  #ifdef CONFIG_CFI_CLANG_SHADOW
> >
> >  extern void cfi_module_add(struct module *mod, unsigned long base_addr);
> > @@ -35,6 +46,8 @@ static inline void cfi_module_remove(struct module *mod, unsigned long base_addr
> >  #else /* !CONFIG_CFI_CLANG */
> >
> >  #define __CFI_ADDRESSABLE(fn, __attr)
> > +#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
> > +     void fn(void) { return; }
> >
> >  #endif /* CONFIG_CFI_CLANG */
> >
>
> Why DEFINE_CFI_IMMEDIATE_RETURN_STUB() vs __no_cfi attribute that we can
> stick on the relvant functions?

To avoid accidentally creating useful gadgets for attackers. For
example, while excluding an empty stub isn't necessarily ideal,
allowing calls to a function that always returns zero would be worse.

> Because I've got at least one more variant for you :-) See
> kernel/static_call.c:__static_call_return0

Does __static_call_return0 ever get called indirectly on architectures
that support static calls? If it's always patched into a direct call,
the type mismatch isn't an issue.

Sami
