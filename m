Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C03F6B87
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhHXWI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbhHXWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:08:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3EFC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:08:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a5so13115819plh.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYgNlhYCjdmXO4IIXLzxiUks/mikPCsz+I8vx+exU7k=;
        b=miJEWiUCmYLfwBr4/NJ6Q1mhlJGDwlrW4NA/zfvrPthvOsUMQJpumaGYAkKVryHAv3
         Xsui/JHE8LDmcUBP3Ky0OZR/excgcdtkGXntcClRwJliv2V+x4tEG1QfR81HeByXQy6Q
         iRtIGpUwAwx2eAejEkxg6K0UFAUWk7ybS7P+ap5kjl5Pe2VGJz0hmWQeBAFOZXIglYBM
         vDxQeyRV/fvQUYihQSLYSCaGGDiSpWC+xP6OUYGYBqowlwAhdwgg3Ux0aFRIfgNjmgtB
         bYAXsiWcnKy65eFaViV3VUNbHsfiPHu26O+flkd7WLn1vekqGgJ8aEFxft1bH712v2UT
         iXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYgNlhYCjdmXO4IIXLzxiUks/mikPCsz+I8vx+exU7k=;
        b=MPnJuLUxTxyEO89jCI6EGoTWd8DN8VNlnv7yiVukT+D9Mz7ceLreSg9blLh5KshegC
         7aXiOm4Hcrfw/W3JIzfXvbl1yv8NhxNeBv6dDeczF4BJOsQj77bR5CYIlWQ8dlu24H0Q
         /PTRtHklk/UOFGMb3Xarz1okEsHcPgamtwcoR+H9YyTqkLTsa5pE+ksFp4XPwOS3oExP
         Vf3ECwuGX2kFV6IcXKpiRsIVrS5VFI4mx6PzL9CZUI3NMWTE84tM2JK+Jhp+1xg66vRC
         PhD+FEBCLjEHgfoBWdxFHWoeDesWOz2iLcF/IhRGqAFlcbr/jSPHv8vamb/6FcpUbkNJ
         ysQA==
X-Gm-Message-State: AOAM530onK3f3UtJEsbUQ/yQXeqSJKnNgPSQOfCl/xu1OhCHFU7voKUa
        5eLW3+hmQ17ixizeOzk8kGJ7mtt9ZZHH/nd/NirBHg==
X-Google-Smtp-Source: ABdhPJx39aSQgrstRV9TO2YQhI96WwKnQj2hL6WTESRHWFG68fPwMHL8QNV2sbihkycfOiLyqq8MmDlrYX/J24y2SYc=
X-Received: by 2002:a17:90a:1b2e:: with SMTP id q43mr6764073pjq.217.1629842890628;
 Tue, 24 Aug 2021 15:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629642658.git.paskripkin@gmail.com> <2424268.2DCLMNk6Lg@localhost.localdomain>
 <2355365e-d75e-8d1b-aad8-6979b70f33ec@gmail.com> <3419359.n4KOUNuIW1@localhost.localdomain>
 <77da7c63-a5b1-a09d-39ec-32c5485b8eac@gmail.com>
In-Reply-To: <77da7c63-a5b1-a09d-39ec-32c5485b8eac@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 24 Aug 2021 23:07:59 +0100
Message-ID: <CAA=Fs0nhURb+1TsqvoSohz_Mppsr0M1Wa-ymKHRAfQvxhEGyrQ@mail.gmail.com>
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

On Tue, 24 Aug 2021 at 09:47, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On 8/24/21 11:38 AM, Fabio M. De Francesco wrote:
> > On Tuesday, August 24, 2021 8:40:18 AM CEST Pavel Skripkin wrote:
> >> On 8/24/21 3:10 AM, Fabio M. De Francesco wrote:
> >> > On Tuesday, August 24, 2021 1:33:46 AM CEST Phillip Potter wrote:
> >> >> On Sun, 22 Aug 2021 at 15:36, Pavel Skripkin <paskripkin@gmail.com> wrote:
> >> >> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
> >> >> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
> >> >> >  {
> >> >> >         u8 requesttype;
> >> >> >         u16 wvalue;
> >> >> >         u16 len;
> >> >> > -       __le32 data;
> >> >> > +       int res;
> >> >> > +       __le32 tmp;
> >> >> > +
> >> >> > +       if (WARN_ON(unlikely(!data)))
> >> >> > +               return -EINVAL;
> >> >> >
> >> >> >         requesttype = 0x01;/* read_in */
> >> >> >
> >> >> >         wvalue = (u16)(addr & 0x0000ffff);
> >> >> >         len = 4;
> >> >> >
> >> >> > -       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> >> >> > +       res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> >> >> > +       if (res < 0) {
> >> >> > +               dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
> >> >> > +       } else {
> >> >> > +               /* Noone cares about positive return value */
> >> >> > +               *data = le32_to_cpu(tmp);
> >> >> > +               res = 0;
> >> >> > +       }
> >> >> >
> >> >> > -       return le32_to_cpu(data);
> >> >> > +       return res;
> >> >> >  }
> >> >>
> >> >> Dear Pavel,
> >> >>
> >> >> OK, found the issue with decoded stack trace after reviewing this
> >> >> usb_read32 function. Your line:
> >> >> res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> >> >>
> >> >> should read:
> >> >> res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);
> >> >
> >> > Dear Philip,
> >> >
> >> > No, it should read:
> >> >
> >> > res = usbctrl_vendorreq(pintfhdl, wvalue, data, len, requesttype);
> >> >
> >> > I suspect that Pavel didn't notice he was reusing a line of the old code
> >> > wth no due changes.
> >> >
> >> >> With this change, the driver runs fine with no crashes/oopses. I will
> >> >> explain the issue but you can probably see already, so I hope I'm not
> >> >> coming across as patronising, just trying to be helpful :-)
> >> >>
> >> >> Essentially, you are taking the address of the data function parameter
> >> >> on this line with &data, a pointer to u32, which is giving you a
> >> >> pointer to a pointer to u32 (u32 **) for this function parameter
> >> >> variable. When passed to usbctrl_vendorreq, it is being passed to
> >> >> memcpy inside this function as a void *, meaning that memcpy
> >> >> subsequently overwrites the value of the memory address inside data to
> >> >> point to a different location, which is problem when it is later
> >> >> deferenced at:
> >> >> *data = le32_to_cpu(tmp);
> >> >> causing the OOPS
> >> >>
> >> >> Also, as written, you can probably see that tmp is uninitialised. This
> >> >> looks like a typo, so guessing this wasn't your intention. Anyhow,
> >> >> with that small change, usbctrl_vendorreq reads into tmp, which is
> >> >> then passed to le32_to_cpu whose return value is stored via the
> >> >> deferenced data ptr (which now has its original address within and not
> >> >> inadvertently modified). Hope this helps, and I'd be happy to Ack the
> >> >> series if you want to resend this patch. Many thanks.
> >> >
> >> > I think that another typo is having 'tmp', because that variable is unnecessary
> >> > and "*data = le32_to_cpu(tmp);" is wrong too.
> >> >
> >> > Now I also see that also usb_read16() is wrong, while usb_read8() (the one that
> >> > I had read yesterday) is the only correct function of the three usb_read*().
> >> >
> >>
> >> Hi, guys!
> >>
> >>
> >> Sorry for breaking your system, Phillip. This code was part of "last
> >> minute" changes and yes, it's broken :)
> >>
> >> I get what Phillip said, because I _should_ read into tmp variable
> >> instead of directly to data, but I don't get Fabio's idea, sorry.
> >
> > Hi Pavel,
> >
> > I (wrongly?) assumed from the prototype of usb_read32() that u32 *data is in native
> > endianness. So, I didn't see the necessity of using _le32 tmp and then convert that tmp
> > with le32_to_cpu().
> >
> > I simply thought that data could be passed to usbctrl_vendorreq as it-is.
> >
> >> Data from chip comes in little-endian, so we _should_ convert it to
> >> cpu's endian. Temp variable is needed to make smatch and all other
> >> static anylis tools happy about this code.
> >
> > Now that you explained that "Data from chip comes in little-endian", obviously
> > I must agree with you that the code needs tmp and that tmp must be
> > swapped by le32_to_cpu(), ahead of assigning it to *data.
> >
> > Just a curiosity... Since I was not able to see that *data is returned in little endian,
> > can you please point me where in the code you found out that it is? There must
> > be some place in the code that I'm unable to find and see that *data is LE.
> >
> > Thanks in advance,
> >
> > Fabio
>
> Hi, Fabio!
>
> previous usb_read16() realization, which is 100% right:
>
>
> static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
> {
>         u8 requesttype;
>         u16 wvalue;
>         u16 len;
>         __le32 data;
>
>         requesttype = 0x01;/* read_in */
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 2;
>         usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>
>         return (u16)(le32_to_cpu(data) & 0xffff);
> }
>
>
> Bases on this code, I think, it's oblivious, that data comes in
> little-endian. That's why I leaved temp variable for casting le32 to
> cpu's endianess.
>
> I could just read into u{16,32} * and then make smth like
>
> *data = le32_to_cpu(*data)
>
> but static analysis tools will complain about wrong data type passed to
>   le32_to_cpu()
>
> + Phillip tested fixed v2 version and it worked well for him. I guess,
> Phillip was able to spot weird driver behavior, if this cast is wrong.
>
>
>
>
> With regards,
> Pavel Skripkin

In my mind we can't necessarily assume we are running on a little
endian CPU, even if we probably are for practical purposes. That's why
my fix looked how it did, but I'm happy to be corrected :-) Also, I
can see Dan has looked at the code with suggestions as well. I know
you have published v3 - sorry, not had time to review/test it yet.

Regards,
Phil
