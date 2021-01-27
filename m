Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8C0306266
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbhA0Ros (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbhA0Rns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:43:48 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB8FC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:43:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y205so1660426pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zlwiY5SxMJVOztEip+vRdaCeKk5Mm+nlE5fqo+Zb0FA=;
        b=LpPZBL7IWp+avvUD4AzUU5jkTSOv4a2L96b3/nHUQiyqFMkCQODtNnG+XsUmnKs3AY
         hlvumGo0Dj549j+PRP3qUNrLdlKKR/46GPBYBzBlzvwzjAMvtFO5W9XEq1t4pAp7cmVC
         e1mYanbpEoIstcZ9nVIXuEg19mBEduL5ROQ9fkq0uTYv4qZlD8pSaqyW+1YicpfqMpkX
         8CD9cYUMQhXbEpQecXTs49RWQQ+/ADXxBpUjJPlaGD/RZ7uY4j+XquI0EOXXgzy17JP0
         34KT/8TVBWYwBpUnRprfcr+OSFNnRrnPAbsQnDh7WD0CLNwlJc3cR8wLz0nz+C9PDVJG
         IzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zlwiY5SxMJVOztEip+vRdaCeKk5Mm+nlE5fqo+Zb0FA=;
        b=Cwb3GlIgpEiCXyhjigC6TSnMAiCuBHJKfAE+UHwqhjItqhOZ5jYdYDOsXhqvz8j00n
         cPnzIDErhMrrLBtMvFKMdY3pHgAv3+3ULkSY+lCvwpDCWrqRD3C41ZVTLATAs2BGuVWw
         R/Xe0+Eq4BXlQEbyCCBs54lFd+/Tic4Vmhetphe14VPWOUbit1wYdTwZgs1jwRoiPCmN
         Kb03ZDu3UNUiOavQOSCXg8HRZdZ31aCCxW8Xl1MSCzOeVVM1rbsNJp/pz9dHzTcxQ8gx
         eh0BZAIMXatWKo/ZF7WW/VjobtKNzC4xJ/7u9EhEF8qSJ/JtIzz6MP8KKNDWgy4tqiIS
         4TJA==
X-Gm-Message-State: AOAM533Hp+HIWoR9sKs0CIyHSuwpNwTNdfSp14wqjT6S6XDz6dNjsHVi
        58qeYz/LbpU8L3cbiL7/3OnEiInqhzB8NpFgdG5ZPA==
X-Google-Smtp-Source: ABdhPJwnFQZuCHywqpXUd+Rn7Fhnk/fsLe0zWZ6CkZDkDXRUlH9WCvv5YJN9kgMDFXVH/aAMtrq8ZLTaEoBobivddX0=
X-Received: by 2002:a63:7e10:: with SMTP id z16mr12444711pgc.263.1611769387089;
 Wed, 27 Jan 2021 09:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20210125085622.2322-1-candlesea@gmail.com> <97d1f36a3b534b7fbd3790a0277ccaf5@AcuMS.aculab.com>
 <CAPnx3XPRnpPQyW7UO_TTmQrHwitDw+_i3ESVkaGq+JyiY9Pu0w@mail.gmail.com>
 <CAKwvOdnH8kXt+jAutjqsL_5H5PzswLGEZOieaGru2SDn13pj+w@mail.gmail.com> <9b48470af3b841e4bd8ba15a4ee5e745@AcuMS.aculab.com>
In-Reply-To: <9b48470af3b841e4bd8ba15a4ee5e745@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 Jan 2021 09:42:55 -0800
Message-ID: <CAKwvOd=Zx-uQxjRBPUitq7wp8OS06Vf6P09BXYmCt07sfZ_Prw@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
To:     David Laight <David.Laight@aculab.com>
Cc:     Candle Sun <candlesea@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "candle.sun@unisoc.com" <candle.sun@unisoc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 2:53 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Nick Desaulniers
> > Sent: 26 January 2021 18:40
> >
> > On Tue, Jan 26, 2021 at 6:13 AM Candle Sun <candlesea@gmail.com> wrote:
> > >
> > > On Mon, Jan 25, 2021 at 6:37 PM David Laight <David.Laight@aculab.com> wrote:
> > > >
> > > > From: Candle Sun
> > > > > Sent: 25 January 2021 08:56
> > > > >
> > > > > From: Candle Sun <candle.sun@unisoc.com>
> > > > >
> > > > > Though do_overwritten() follows do_nothing() in source code, the final
> > > > > memory address order is determined by compiler. We can't always assume
> > > > > address of do_overwritten() is bigger than do_nothing(). At least the
> > > > > Clang we are using places do_overwritten() before do_nothing() in the
> > > > > object. This causes the copy size in lkdtm_WRITE_KERN() is *really*
> > > > > big and WRITE_KERN test on ARM32 arch will fail.
> > > > >
> > > > > Compare the address order before doing the subtraction.
> > > >
> > > > It isn't clear that helps.
> > > > Compile with -ffunction-sections and/or do LTO an there
> > > > is no reason at all why the functions should be together.
> > > >
> > > > Even without that lkdtm_WRITE_KERN() could easily be between them.
> > > >
> > > > You need to get the size of the 'empty function' from the
> > > > symbol table.
> > > >
> > > >         David
> > >
> > > Thanks David.
> > >
> > > I think using abs() by Nick's advice would be better. But could you
> > > point out which kernel function can get function size?
> >
> > The Elf symbol table should contain this info, IIUC.
> >
> > Given a string literal of a symbol (such as a function identifier),
> > kallsyms_lookup_name() can be used to return its address.
> >
> > From there we'd want to fetch the Elf_Sym for the address which should
> > contain a st_size field which I think corresponds to the size in bytes
> > of the function.  (At least, from playing with `llvm-readelf -s`)
> > Probably would want to validate it's an STT_FUNC symbol type, too.  We
> > basically want something like kexec_purgatory_find_symbol(), but that
> > knows about the entire kernel image, and not the purgatory image used
> > during kexec.  I don't see any such function currently in the
> > kernel...but it's a large codebase to search through.
>
> The alternative is to get the linker script to define a specific
> constant to the size of the function.
> You can then link against it (by using it as the address of a symbol).

Or use __attribute__((__section())) to place the code we need to
measure in a custom section, then in the linker script define symbols
that bound the section then place it in .text.  That pattern is used
throughout the kernel.  But I suspect this is overkill for this
module.

A constant would depend on the arch.

>
> It may be easier to use an asm file for the 'return 0' code.
> I'm guessing there are things in the static branch area
> that could be used.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)



-- 
Thanks,
~Nick Desaulniers
