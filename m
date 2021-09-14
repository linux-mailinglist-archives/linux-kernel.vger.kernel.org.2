Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF59640B960
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhINUkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhINUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:40:16 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:38:59 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id k65so761755yba.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tUhNAmB3jtMO0gp42EJpLQiu+VFBOkyW3SAAAq7Es0=;
        b=ftQuNUD3jSMSRh+XpHL49k409YunHBWy9hHpn+/k1fcL23TkgzbaS2M0+HoL4ePXZu
         LeDLpHnwHELMtbsje5OTNxaLk4EQOfqjauF7rF91GpSqz5paiaK1m3WXq1O7tTCdAZfm
         R9CyNECt+ve4IZQfeST4Shya0qXZhVoxAn2m8a6b+qp9XtkesagMoggau0GLTSJsJx2Q
         TpsMLZg80u57cBeTOabol4bH7ckl2SCpcqwiENrgbSstlxs0O6qpDShP8tuzE5qubZVE
         jlZVE3+Fmp88+7WN5RY01JXSQBA0aA2HNlofJntmCx6xJdfgyRJie7t3DRoRPHVz8UDj
         J5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tUhNAmB3jtMO0gp42EJpLQiu+VFBOkyW3SAAAq7Es0=;
        b=REo8yONZFTQKvYATJxnRHTDMmojDMQYynTXxyW3TbhjTQdyeTs0Gi81QVBOVk6Z8B+
         lIVm2Tvk5V203twlMZeDvETjC5n0YT8VqJZEPhf3Mc6LnVQzzjmb7nb9s8MEX1GOoNv3
         of2ciptVBPrQI4SvKLta1WZ0rZQ2Sur6jrrx0RXq14UskGU4TmyY6bRlKDR88SUQoeUU
         BjzT2E2nEzpg54Yebp0GRQkflfhuT+cgMPOYZ7EN+teOddSAK6K9Lr0hd40cBKa7z2yA
         4lRteBbcx2mVnUYa+98iP8pkQdV8FFSg2NSo4Jd2iHh8ZEVI9Yw2cWQuLgDOw0/4W46y
         jVGA==
X-Gm-Message-State: AOAM532fvFWDW6egfQ28M7XnzdxziouA3WI7VqVW6xI5roZzaC5eNQng
        eUfpNCWmxuUKYuzKGUScRBcp27hCFk5VSB8Lh6QdoQ==
X-Google-Smtp-Source: ABdhPJzPGpq4cEKMF4OI2L0ct9rNcXmPLf9No4wBpBUk+cU2MWdf5maRpDo0f37bCEkina5qzEhBylM9KOgNPQY9OZw=
X-Received: by 2002:a25:eb0b:: with SMTP id d11mr1361200ybs.101.1631651938181;
 Tue, 14 Sep 2021 13:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-11-samitolvanen@google.com> <202109141235.BE65491A4@keescook>
In-Reply-To: <202109141235.BE65491A4@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 14 Sep 2021 13:38:47 -0700
Message-ID: <CABCJKufuv_zNEu1=X+xnUYF6WmFU=ZjSCa0QzDJdUvFSD5gx0A@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] x86/extable: Mark handlers __cficanonical
To:     Kees Cook <keescook@chromium.org>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 14, 2021 at 12:10:39PM -0700, Sami Tolvanen wrote:
> > Exception tables are populated in assembly code, but the handlers are
> > called in fixup_exception, which trips indirect call checking with
> > CONFIG_CFI_CLANG. Mark the handlers __cficanonical to allow addresses
> > taken in assembly to pass CFI checking.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/x86/mm/extable.c | 64 ++++++++++++++++++++++++-------------------
> >  1 file changed, 36 insertions(+), 28 deletions(-)
> >
> > diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> > index e1664e9f969c..d16912dcbb4e 100644
> > --- a/arch/x86/mm/extable.c
> > +++ b/arch/x86/mm/extable.c
> > @@ -24,16 +24,18 @@ ex_fixup_handler(const struct exception_table_entry *x)
> >       return (ex_handler_t)((unsigned long)&x->handler + x->handler);
> >  }
> >
> > -__visible bool ex_handler_default(const struct exception_table_entry *fixup,
> > -                               struct pt_regs *regs, int trapnr,
> > -                               unsigned long error_code,
> > -                               unsigned long fault_addr)
> > +__visible __cficanonical
> > +bool ex_handler_default(const struct exception_table_entry *fixup,
> > +                     struct pt_regs *regs, int trapnr,
> > +                     unsigned long error_code,
> > +                     unsigned long fault_addr)
> >  {
> >       regs->ip = ex_fixup_addr(fixup);
> >       return true;
> >  }
> >  EXPORT_SYMBOL(ex_handler_default);
> >
> > +__visible __cficanonical
> >  __visible bool ex_handler_fault(const struct exception_table_entry *fixup,
>
> Double __visible here, but with that fixed:

Ah, thanks for noticing that. I'll fix it in the next version.

>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> I would note that given Linus's recent comments on attribute locations,
> it does seem that __cficanonical is more a function behavior attribute
> than a storage class... I'm not really sure:
> https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com

__visible is not really a storage class either, but I thought it would
make sense to keep these attributes together. I can certainly move
them if anyone has strong feelings about the location.

Sami
