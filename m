Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622CF41F628
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354833AbhJAUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhJAUKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:10:43 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0D9C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 13:08:59 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z5so23019198ybj.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKG27X/tAaz6ZgSm5PLct1wo5H6VtWzGqhVRfSbCJeM=;
        b=K/EZX9fC9ZUuzFI6jrZypY1zTFUDt/PU70tLbqJHmQR1qUSX74ZaJgv2NcYZgAKyxp
         IGav/zFpLLCH001ejV1vMObkwX0wGHb+UKwQ6kSvjtnd8WWRAXyBC1NiC7MxyV9iJvcy
         rsCUB4L+pz5p17cwq7H2NsYsiU2vmQlHJ0Tcrq5gjSQbM8w8xZKBMin7C5Qzc1rpXYdz
         HKHH+DsRMvAYh8BOZSJFRxikufOUyCDSOOapRM7+NoJRPhev7XGLUTfGVqW8HkZcf0k2
         gZEuAouaG/VT/oHp5nPOEqDTxWb+ThYNaiR0o6i8VOaeFBhsVrUATAE4tcbhHOnazbOp
         7W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKG27X/tAaz6ZgSm5PLct1wo5H6VtWzGqhVRfSbCJeM=;
        b=yzUPyKvhI38DTFe90A87m3f77CDtbdhtj1VZWgICrZWlr1nNZz+mY7eliKui8JxhRz
         7S+xLEbdC+9Tu261DfpinHdxLuoh1ql2aDT7ibCdof3YszZzVkJr6ivMMtAkH+x0rG9G
         CviLE8sbrOnWm7DhXsITh1vZJkaviSDo50tAZ2n8gbVC8F5tL149FSTlVN1PablJ+0QH
         4F/UYMB7/xIXGmjjA+smAzxtCQj8nVVERKgeVH4ZN9AwQpGmnzDhTCLqImh5b0tswRBa
         I1KUAmB38SZQEaj0fmM4oUgQiyHre5qlVIacXeK3FZK/pGYNkgGsPkznutax7rt8JZiK
         GsKg==
X-Gm-Message-State: AOAM532bVZYpGnbMZ6w0BOdcHxR6cHiBNQ5PUeSaGi7cuPEZQtW70VbB
        OZ4MmuLqv9PJmZrebuT2lT6QjWRlho3tG2ZFynwR8g==
X-Google-Smtp-Source: ABdhPJwOtf4LpoL1TJ/IJSfZorBhBurQK2kH41u3Fyo5ujc2AgTfHjWisxqRuQ+5FkxK3/PBitfSFea2DlJ3i0S6fX4=
X-Received: by 2002:a25:e6d0:: with SMTP id d199mr8208144ybh.527.1633118938474;
 Fri, 01 Oct 2021 13:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-6-samitolvanen@google.com> <CAKwvOdnJ6EPPd5UbhZhdggPRzCXmdrnxg_tO=Bq_+Gcgarvw1g@mail.gmail.com>
In-Reply-To: <CAKwvOdnJ6EPPd5UbhZhdggPRzCXmdrnxg_tO=Bq_+Gcgarvw1g@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 1 Oct 2021 13:08:47 -0700
Message-ID: <CABCJKue1dDYe9aL0ExU8NMORxJN-7qhF=D+=sSKr0d2Quhb3YA@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] tracepoint: Exclude tp_stub_func from CFI checking
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:51 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Sep 30, 2021 at 11:05 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > If allocate_probes fails, func_remove replaces the old function
> > with a pointer to tp_stub_func, which is called using a mismatching
> > function pointer that will always trip indirect call checks with
> > CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
> > tp_stub_func to allow it to pass CFI checking.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  kernel/tracepoint.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index 64ea283f2f86..58acc7d86c3f 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
>
> looking at 4+5/15 together, I wonder if this TU should explicitly
> include linux/cfi.h?

Good point. Currently cfi.h is included in module.h, but including it
explicitly makes this less likely to break in future. I'll add an
explicit include in v5. Thanks for taking a look!

Sami
