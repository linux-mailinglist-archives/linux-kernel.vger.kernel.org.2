Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D27C305945
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhA0LKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbhA0LBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:01:50 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5539C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:01:05 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e206so1575028ybh.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYWicv8n1FtRB8POyZv2LVDU05uMTM4tKwKje8Jv1Zg=;
        b=baeJsrrlPZfMg0LaEHoOhEIQ7/P41S1vCWg/B3e1fndVBxMdDtO5QBUhsPt7ProFVE
         KgFVj8/rBlOLKvVVvE5ATI1QoMxOTFO8Jhp7UALtPj0y/uvdndnQBawL2MqDFO55YDSv
         YaLdAanjI8TvxQ50fvfE+aoBrMW3n5wydks6y0r1+o52MuBjTBhpzQ8SJ2CE/AglOaCP
         j/+HD+L/C35emadbSm0pT7DT2ja/1p0eHIymX6PqWaFjZ93lcoQEen+jcOPhx9ZrT6Gz
         fwXkbfs5Or8OplikUJznfYz9epgKR9DHrcRRIeSjLDX9/+d3czAkAEWzn9zp4KohgLe+
         Gc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYWicv8n1FtRB8POyZv2LVDU05uMTM4tKwKje8Jv1Zg=;
        b=EPsZJBnud8wSGc0gwB6aE0wupHoQXj4A6FiqIKtO9ZSXM1AH/Ma6d3yAHGbkpWdhRR
         WR1XE7weWElzP+TOtbPeBcXVInhUSOt01coXzyZMnvi/uhVNZ8rPYpNL4/oLK3Bp3Hh9
         7QqCb5ipVOd3PFcIOFNYzv6uxpGuvoVjy7zPUxAf9CveaDv40pdEAIc1ese3qz5cHblU
         bF1mqV6acYG3cKDixMNH4UrHXC/ynpihzEbsMRDFzkNk9JXdVU4XNV128STRLuLRThC1
         6/RG9DTRqqusUF6YEWX2fAVIgqCQl5CghDXbdr5+qrO3soWpW4WX2wbi/v9jYN+gMLfy
         SqYQ==
X-Gm-Message-State: AOAM530K8IVKViJ9HaecwOy6FaR35MPpwp4MV5nSLINOpqpscWw9FIJO
        WePiq9vjTEzydcdAo5s80nAMg/zJpFXGho09LEU=
X-Google-Smtp-Source: ABdhPJxk5PxSni/6ANSrJNfFbRLmz35YVP8IrODEkLpaqQZSyYvsw8NeAvD3G8xzD7PRw1q+WJ7pWR6xDOrHmpyvzGs=
X-Received: by 2002:a25:1fc5:: with SMTP id f188mr15629746ybf.389.1611745264998;
 Wed, 27 Jan 2021 03:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20210125085622.2322-1-candlesea@gmail.com> <97d1f36a3b534b7fbd3790a0277ccaf5@AcuMS.aculab.com>
 <CAPnx3XPRnpPQyW7UO_TTmQrHwitDw+_i3ESVkaGq+JyiY9Pu0w@mail.gmail.com>
 <CAKwvOdnH8kXt+jAutjqsL_5H5PzswLGEZOieaGru2SDn13pj+w@mail.gmail.com> <9b48470af3b841e4bd8ba15a4ee5e745@AcuMS.aculab.com>
In-Reply-To: <9b48470af3b841e4bd8ba15a4ee5e745@AcuMS.aculab.com>
From:   Candle Sun <candlesea@gmail.com>
Date:   Wed, 27 Jan 2021 19:00:53 +0800
Message-ID: <CAPnx3XOLXWW5RWjzfwyfTo1Er+uJ2BcN7wxSr8m8G_8M=_sZdg@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
To:     David Laight <David.Laight@aculab.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

Thanks  David and Nick.

For simpleness. I just use abs() to get the copy size.

Patch version 2 is mailed. Please help review it.

Regards,
Candle


On Wed, Jan 27, 2021 at 6:53 AM David Laight <David.Laight@aculab.com> wrote:
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
