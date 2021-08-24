Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35AB3F6B93
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhHXWLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhHXWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:11:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96776C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:10:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b9so8736541plx.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVZKOjTWUVXVlz8oHjdrZ7UztOrSk5NQfTKfCoLHwJ8=;
        b=tnuOd5AxmG0CkoxMyHx25WepMt/Ltvye9Ceg8uoRR8ol2rWeG5ebTHj+BFXGSqeT9u
         9oQkEzcR2QVoffoz9c/MykU9I5cSxEjLD12QVoA69JL80vhGTtkAfOsSZfdXwtgV03I6
         pYTJUjvgmR4kBlWMa994IbK0vqUYcyJ7GRcAie8Xk94mI6Ohc08Y8Twnz+H6xxLmK0nl
         5myGW3CcOuGkisp5ga+r5tcAXI84p8bJ3k5YR2yRz/pf/K699vByERgSnrfTSwIdVM8f
         2uBJBqbBbV56xY9yur4FQmkkGdUikj53qDUNCyjgBjVBgS1PXcNphC0JwY1WnuSz/AW0
         iwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVZKOjTWUVXVlz8oHjdrZ7UztOrSk5NQfTKfCoLHwJ8=;
        b=KCrNzB3SjRl5R59dWjbG4rZIxq3NpS7lX+xsJw28F74Zx84hyHr1ecEwv0u6K8gf/V
         Z+gOi/1QDnNnaoPjnliCdQ98fI3XCgRqUSUKKsPc6vcgBUCLCxh4SjJibG2dI5Un6Rfe
         CABkCM4Oxbg0NpNejW8qtt3eLTIejxpXcbMku+jeJeFKnZwHBhblW14X/t49DftjPfB/
         JX0NtWg65A/dep+4MVqubpXmkze36uZVB5+SgtZY9u/s47sh53HOOPh1qe6PYFS2v7ir
         bqLzVqj6wnNibhj4zwD/gpLW/Xhphfjoz4Bxe6huWHIBR6XZprLpeo7TnFYKkIMKiNsj
         kO+A==
X-Gm-Message-State: AOAM533/l2UDD7j00fziV6vXlhWZT3zTyl1lf3T0ewZOT6RG/W1eGVYP
        IOyyryGGhPiY7teiAFi1EgrDsx1Rr+yBN5ANJyxpnw==
X-Google-Smtp-Source: ABdhPJz/bRIqGQF1++9B4wLeWxu/wV+eSPLphyaixwNs5xRT/Ukpb4QG+9fhI613V6Xd9JeRNQDQy4845OovKsKcabg=
X-Received: by 2002:a17:90a:1b2e:: with SMTP id q43mr6774975pjq.217.1629843049148;
 Tue, 24 Aug 2021 15:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629642658.git.paskripkin@gmail.com> <2424268.2DCLMNk6Lg@localhost.localdomain>
 <2355365e-d75e-8d1b-aad8-6979b70f33ec@gmail.com> <3419359.n4KOUNuIW1@localhost.localdomain>
 <77da7c63-a5b1-a09d-39ec-32c5485b8eac@gmail.com> <96e3703e-a5e2-3c6d-ea3c-b5d3892849b2@gmail.com>
In-Reply-To: <96e3703e-a5e2-3c6d-ea3c-b5d3892849b2@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 24 Aug 2021 23:10:38 +0100
Message-ID: <CAA=Fs0=aRaJRr7A2=9HJ=6SSoNV_AP0Xc3qYBNoO+nZ=Kie+ag@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of rtw_read32
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 at 09:53, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On 8/24/21 11:47 AM, Pavel Skripkin wrote:
> > On 8/24/21 11:38 AM, Fabio M. De Francesco wrote:
> >> On Tuesday, August 24, 2021 8:40:18 AM CEST Pavel Skripkin wrote:
> >>> On 8/24/21 3:10 AM, Fabio M. De Francesco wrote:
> >>> > On Tuesday, August 24, 2021 1:33:46 AM CEST Phillip Potter wrote:
> >>> >> On Sun, 22 Aug 2021 at 15:36, Pavel Skripkin <paskripkin@gmail.com> wrote:
> >>> >> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
> >>> >> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
> >>> >> >  {
> >>> >> >         u8 requesttype;
> >>> >> >         u16 wvalue;
> >>> >> >         u16 len;
> >>> >> > -       __le32 data;
> >>> >> > +       int res;
> >>> >> > +       __le32 tmp;
> >>> >> > +
> >>> >> > +       if (WARN_ON(unlikely(!data)))
> >>> >> > +               return -EINVAL;
> >>> >> >
> >>> >> >         requesttype = 0x01;/* read_in */
> >>> >> >
> >>> >> >         wvalue = (u16)(addr & 0x0000ffff);
> >>> >> >         len = 4;
> >>> >> >
> >>> >> > -       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> >>> >> > +       res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> >>> >> > +       if (res < 0) {
> >>> >> > +               dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
> >>> >> > +       } else {
> >>> >> > +               /* Noone cares about positive return value */
> >>> >> > +               *data = le32_to_cpu(tmp);
> >>> >> > +               res = 0;
> >>> >> > +       }
> >>> >> >
> >>> >> > -       return le32_to_cpu(data);
> >>> >> > +       return res;
> >>> >> >  }
> >>> >>
> >>> >> Dear Pavel,
> >>> >>
> >>> >> OK, found the issue with decoded stack trace after reviewing this
> >>> >> usb_read32 function. Your line:
> >>> >> res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> >>> >>
> >>> >> should read:
> >>> >> res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);
> >>> >
> >>> > Dear Philip,
> >>> >
> >>> > No, it should read:
> >>> >
> >>> > res = usbctrl_vendorreq(pintfhdl, wvalue, data, len, requesttype);
> >>> >
> >>> > I suspect that Pavel didn't notice he was reusing a line of the old code
> >>> > wth no due changes.
> >>> >
> >>> >> With this change, the driver runs fine with no crashes/oopses. I will
> >>> >> explain the issue but you can probably see already, so I hope I'm not
> >>> >> coming across as patronising, just trying to be helpful :-)
> >>> >>
> >>> >> Essentially, you are taking the address of the data function parameter
> >>> >> on this line with &data, a pointer to u32, which is giving you a
> >>> >> pointer to a pointer to u32 (u32 **) for this function parameter
> >>> >> variable. When passed to usbctrl_vendorreq, it is being passed to
> >>> >> memcpy inside this function as a void *, meaning that memcpy
> >>> >> subsequently overwrites the value of the memory address inside data to
> >>> >> point to a different location, which is problem when it is later
> >>> >> deferenced at:
> >>> >> *data = le32_to_cpu(tmp);
> >>> >> causing the OOPS
> >>> >>
> >>> >> Also, as written, you can probably see that tmp is uninitialised. This
> >>> >> looks like a typo, so guessing this wasn't your intention. Anyhow,
> >>> >> with that small change, usbctrl_vendorreq reads into tmp, which is
> >>> >> then passed to le32_to_cpu whose return value is stored via the
> >>> >> deferenced data ptr (which now has its original address within and not
> >>> >> inadvertently modified). Hope this helps, and I'd be happy to Ack the
> >>> >> series if you want to resend this patch. Many thanks.
> >>> >
> >>> > I think that another typo is having 'tmp', because that variable is unnecessary
> >>> > and "*data = le32_to_cpu(tmp);" is wrong too.
> >>> >
> >>> > Now I also see that also usb_read16() is wrong, while usb_read8() (the one that
> >>> > I had read yesterday) is the only correct function of the three usb_read*().
> >>> >
> >>>
> >>> Hi, guys!
> >>>
> >>>
> >>> Sorry for breaking your system, Phillip. This code was part of "last
> >>> minute" changes and yes, it's broken :)
> >>>
> >>> I get what Phillip said, because I _should_ read into tmp variable
> >>> instead of directly to data, but I don't get Fabio's idea, sorry.
> >>
> >> Hi Pavel,
> >>
> >> I (wrongly?) assumed from the prototype of usb_read32() that u32 *data is in native
> >> endianness. So, I didn't see the necessity of using _le32 tmp and then convert that tmp
> >> with le32_to_cpu().
> >>
> >> I simply thought that data could be passed to usbctrl_vendorreq as it-is.
> >>
> >>> Data from chip comes in little-endian, so we _should_ convert it to
> >>> cpu's endian. Temp variable is needed to make smatch and all other
> >>> static anylis tools happy about this code.
> >>
> >> Now that you explained that "Data from chip comes in little-endian", obviously
> >> I must agree with you that the code needs tmp and that tmp must be
> >> swapped by le32_to_cpu(), ahead of assigning it to *data.
> >>
> >> Just a curiosity... Since I was not able to see that *data is returned in little endian,
> >> can you please point me where in the code you found out that it is? There must
> >> be some place in the code that I'm unable to find and see that *data is LE.
> >>
> >> Thanks in advance,
> >>
> >> Fabio
> >
> > Hi, Fabio!
> >
> > previous usb_read16() realization, which is 100% right:
> >
> >
> > static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
> > {
> >       u8 requesttype;
> >       u16 wvalue;
> >       u16 len;
> >       __le32 data;
> >
> >       requesttype = 0x01;/* read_in */
> >       wvalue = (u16)(addr & 0x0000ffff);
> >       len = 2;
> >       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> >
> >       return (u16)(le32_to_cpu(data) & 0xffff);
> > }
> >
> >
> > Bases on this code, I think, it's oblivious, that data comes in
> > little-endian. That's why I leaved temp variable for casting le32 to
> > cpu's endianess.
> >
> > I could just read into u{16,32} * and then make smth like
> >
> > *data = le32_to_cpu(*data)
> >
> > but static analysis tools will complain about wrong data type passed to
> >    le32_to_cpu()
> >
> > + Phillip tested fixed v2 version and it worked well for him. I guess,
> > Phillip was able to spot weird driver behavior, if this cast is wrong.
> >
>                 ^^^^^&
>
> I am wrong with this statement, I guess. Most likely, Phillip is testing
> on smth like x64 and this arch is le, so...
>
>
>
>
> With regards,
> Pavel Skripkin

Dear Pavel,

You're correct in your assumption, my testing environment is an
little-endian x64 QEMU VM with USB passthrough for the wireless
adapter. I prefer to test this way so that driver crashes don't bring
down the whole machine :-)

Regards,
Phil
