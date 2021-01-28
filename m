Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF74306DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 07:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhA1Gss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 01:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhA1Grp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 01:47:45 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F166CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 22:47:04 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id w24so4469723ybi.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 22:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qigc4Q2zk4kidcc5fEGaK1ackCv7ueDldw+kGCII7Bw=;
        b=hgoerTFgqNvDpLMPuMzlDkC+IuNj/hB86RUKJAWckBtM75bFjZhqdiqg9/FqsECrsc
         rNw/AFqRO2MGcIcpAosrYvSOY4jEg0lffZp6BO1MFGAVUGiPRoF0czDRDSgWrX/Lt5Jt
         URJszFQoQ4Dj2T99LuByD18ivtQa8Oh4EGntDwZJa8FvP+3chJIIPIoUoNKLRPd7GwTp
         MxYleGons4w1O89FdTKTMJYY/UmA5Rpz/lyhmFgx23gbmlPIltZgfSLCef3OOLHtN/kM
         tHPg4npdzidpUPyzdH2NtwEaFCPyFlaK4yJ4hyognKLJe9N8swraSAilXpNEOgdjLt1s
         IHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qigc4Q2zk4kidcc5fEGaK1ackCv7ueDldw+kGCII7Bw=;
        b=fwlchH33doYw1bMsHQjD+mEetK6+XD4idi7UKOlEOC3kzb0nybTDsS+zfDlIrq3U9Y
         7Vfbal8ObacJ6TUFDbhOpq9kmnu+j+qjddXMl3G6hjInhF+H67Iuu2AEtfdpaz+VGNxC
         bNm+LZUToLslmS+iwu2Cf42S2jEq5WgVoBK5gJ6MIrRTRTCECnYTNpgQVvInE8d7g2k2
         c7vTdrO5riLtRmKBz9zPbGwDm8Uv9URG0QYH311jdTg2nmONBelWxoWVXLTOmldYgrRt
         Kaw1c2kVmQmWqhjqsfpqtatkeZKAw6enk9fie+87jkHxG8eF1vzFpmFkoTLzcevuObNl
         L91A==
X-Gm-Message-State: AOAM530PLSBzXVPndhojmZQzDliHbPsvVN8Hs49IbzKXaMWHUQlCNaUT
        heMMdIxealfzzfQNKsYVOfg9FJr/97GxgnE1EUY=
X-Google-Smtp-Source: ABdhPJytiUOd9V3L5u4KUvlAzxRbcw+pCVek5LBOTYfa4EicfpLXGlNVPkUGVtq55oAu6rxFsWk08qJIA3io+f5z9C0=
X-Received: by 2002:a25:3bc5:: with SMTP id i188mr21663855yba.332.1611816424260;
 Wed, 27 Jan 2021 22:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20210127110510.24492-1-candlesea@gmail.com> <CAKwvOdm4XaoW+yrtj=7C7ct5dvNuxT81zs1Wp=X0MBFceukd9g@mail.gmail.com>
In-Reply-To: <CAKwvOdm4XaoW+yrtj=7C7ct5dvNuxT81zs1Wp=X0MBFceukd9g@mail.gmail.com>
From:   Candle Sun <candlesea@gmail.com>
Date:   Thu, 28 Jan 2021 14:46:52 +0800
Message-ID: <CAPnx3XMEtVQVYUD5aLAC3Adp+Y0fz13nbBTHg75f6W1q1g9Usg@mail.gmail.com>
Subject: Re: [PATCH v2] lkdtm: fix memory copy size for WRITE_KERN
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Candle Sun <candle.sun@unisoc.com>,
        David Laight <David.Laight@aculab.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 1:40 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jan 27, 2021 at 3:05 AM Candle Sun <candlesea@gmail.com> wrote:
> >
> > From: Candle Sun <candle.sun@unisoc.com>
> >
> > Though do_overwritten() follows do_nothing() in source code, the final
> > memory address order is determined by compiler. We can't always assume
>
> ^ "by the compiler."
>
> > address of do_overwritten() is bigger than do_nothing(). At least the
> > Clang we are using places do_overwritten() before do_nothing() in the
> > object. This causes the copy size in lkdtm_WRITE_KERN() is *really*
>
> Hopefully nothing else gets placed in between the two, otherwise we're
> going to overwrite that, too.
>
> > big and WRITE_KERN test on ARM32 arch will fail.
> >
> > Get absolute value of the address substraction for memcpy() size.
>
> ^ typo: subtraction
>
> >
> > Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> > ---
> > Changes in v2:
> > - Use abs() in place of address comparison.
> > ---
> >  drivers/misc/lkdtm/perms.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> > index 2dede2ef658f..fbb7f4554054 100644
> > --- a/drivers/misc/lkdtm/perms.c
> > +++ b/drivers/misc/lkdtm/perms.c
> > @@ -31,13 +31,13 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
> >   * This just returns to the caller. It is designed to be copied into
> >   * non-executable memory regions.
> >   */
> > -static void do_nothing(void)
> > +static noinline void do_nothing(void)
> >  {
> >         return;
> >  }
> >
> >  /* Must immediately follow do_nothing for size calculuations to work out. */
>
> ^ This comment is now obsolete and should be removed together with
> this patch.  That will also fix the typo in it.
>
> > -static void do_overwritten(void)
> > +static noinline void do_overwritten(void)
> >  {
> >         pr_info("do_overwritten wasn't overwritten!\n");
> >         return;
> > @@ -113,7 +113,7 @@ void lkdtm_WRITE_KERN(void)
> >         size_t size;
> >         volatile unsigned char *ptr;
> >
> > -       size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
> > +       size = (size_t)abs((uintptr_t)do_overwritten - (uintptr_t)do_nothing);
> >         ptr = (unsigned char *)do_overwritten;
> >
> >         pr_info("attempting bad %zu byte write at %px\n", size, ptr);
> > --
> > 2.17.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers

Thanks Nick. I will clean the typo and the comment line in the next patch.

Regards,
Candle
