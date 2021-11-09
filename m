Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7F744ABB4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbhKIKob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 05:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbhKIKoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:44:17 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28201C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 02:41:32 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id m6so6988851oim.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 02:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nt37Peic1jZ4kG3kSiSdbDiuGGxATK6tL4dJ/X3eVlg=;
        b=QvMKRgQrn+wxf5d//BzQ/s39JzY9GOrdAm+RM2Sy+cn4S3MArAVKwusHpQs2QexY8k
         LBfQUbc+nempuZsIEqsAqAWhA/nubmNOkNMMygRepbSPDH5iRagExMfdzY6nZPljiG1M
         pQgE/RovqZstH1rMSiCLCmOTaB5Rrkn6nGgBma+tTGhpnXgdjd+5oFTxAEMGm1Z6Vwfd
         BCxXJlEtbl7fOGShAeXCx74yUX9jIxmJHMtJHx9YGnSwbD8Og/W3F8f8i7sB4Z0v3BK3
         Rdeu2wqdT2r2+Oyw/rHlHknwmuEwtfbclgj/LmA2bzso8Z7pHLVqLJJMvy5lfIyXT5le
         mEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nt37Peic1jZ4kG3kSiSdbDiuGGxATK6tL4dJ/X3eVlg=;
        b=G3q7DqfxGyFmZTAG+1wCKJXESKTM5NaUtoYBhqcVbzRqOS7z5EzrjBCAdf7FTyE/Qu
         z0f3LbM/9HfxzDzRaKK3P8tjxt5s8hjMz+qtsA0Bn6HzVysOGTZ8fF/D6gWuKDmkBLRc
         62AqYV8eiWmDjN+2QfJcqjlBPTzi7m10UE2Ql55y1yEZSPf4RaTW7BXpb58HKlJ+B20+
         HUom9SBi3drCiSUUN4vkkQ1jUOAjyg2iZKpJPEGA2hAcSrz4D7GXrX7hg/YDO001MyHR
         oFtXuQbOslT37gtTjcPamMxGIFQiniYfme7j5f+sbsIjR+LOCm+QjQZZCHD3Vo6ed3jo
         1pLA==
X-Gm-Message-State: AOAM531QhisYP41BWNyk3dTUZt1Uwqq7GWOa5R8BCOCyoYzzXiqmInxH
        GfL5u684af1I0EvhoIDOazgi2YmDYck04FATXDY=
X-Google-Smtp-Source: ABdhPJxecaK2p2flfGhcC7OQEvqO8X0ns6o6TyAEJUuKgiwuqyAcadcQ1fD2AbYXCNkWnZ+UJ51f+kWLgmaHxN+VDns=
X-Received: by 2002:a54:4486:: with SMTP id v6mr4923200oiv.90.1636454491527;
 Tue, 09 Nov 2021 02:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20211108185818.GA73382@makvihas> <YYoUYOyyP4EFYTSJ@kroah.com>
In-Reply-To: <YYoUYOyyP4EFYTSJ@kroah.com>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Tue, 9 Nov 2021 16:11:20 +0530
Message-ID: <CAH1kMwSqfNT-jB70c6Md_Wa6Sn6GJKr2=LOunSaZwEk2TKzraA@mail.gmail.com>
Subject: Re: [PATCH] char: ppdev: fixed a validation issue
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 09, 2021 at 12:28:18AM +0530, Vihas Mak wrote:
> > Make sure the mode is a valid IEEE1284 mode.
> What is a valid mode?

The valid IEEE1284 modes are the ones defined in
<uapi/linux/parport.h>. Currently there are 10 modes. Namely nibble
mode, byte mode, ECP, ECPRLE, EPP and some specials.

> How did you test this?  And why is this needed now?  What hardware was
> working that is now not going to work with this driver?

I tested this on my local pc using a parallel port and read the
incoming data on my Raspberry PI.
I also used https://github.com/strezh/VPPSniffer. It's a simple
virtual parallel port used for debugging and sniffing.

The mainline code wasn't validating the mode when a user-space program
does a ioctl call to change the current mode. It might
create some bugs if the new mode isn't one of the IEEE1284 modes
defined in <uapi/linux/parport.h>. So it's better to throw a EINVAL
beforehand, if the mode is invalid.

> > +static int pp_validate_mode(int mode)
> bool?

My bad. Will do a v2.

Thanks,
Vihas

On Tue, Nov 9, 2021 at 11:55 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 09, 2021 at 12:28:18AM +0530, Vihas Mak wrote:
> > Make sure the mode is a valid IEEE1284 mode.
>
> What is a valid mode?
>
> > Signed-off-by: Vihas Mak <makvihas@gmail.com>
> > ---
> >  drivers/char/ppdev.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
> > index 38b46c7d1737..3b290cbf6c66 100644
> > --- a/drivers/char/ppdev.c
> > +++ b/drivers/char/ppdev.c
> > @@ -333,6 +333,28 @@ static enum ieee1284_phase init_phase(int mode)
> >       return IEEE1284_PH_FWD_IDLE;
> >  }
> >
> > +/*
> > + * Validate the mode and make sure the mode is power of two.
> > + *
> > + * IEEE1284_MODE_ECPRLE and IEEE1284_MODE_NIBBLE are exception
> > + * to this so handle them accordingly.
> > + */
> > +
>
> Why the extra line?
>
> > +static int pp_validate_mode(int mode)
>
> bool?
>
> > +{
> > +     if (mode == IEEE1284_MODE_ECPRLE || mode == IEEE1284_MODE_NIBBLE) {
> > +             return 1;
> > +     } else if (!(mode & (mode - 1)) &&
> > +                (mode & (IEEE1284_MODE_BYTE | IEEE1284_MODE_COMPAT |
> > +                         IEEE1284_MODE_BECP | IEEE1284_MODE_ECP |
> > +                         IEEE1284_MODE_ECPSWE | IEEE1284_MODE_EPP |
> > +                         IEEE1284_MODE_EPPSL | IEEE1284_MODE_COMPAT |
> > +                         IEEE1284_MODE_EPPSWE))) {
> > +             return 1;
> > +     }
> > +     return 0;
> > +}
>
> How did you test this?  And why is this needed now?  What hardware was
> working that is now not going to work with this driver?
>
> thanks,
>
> greg k-h
