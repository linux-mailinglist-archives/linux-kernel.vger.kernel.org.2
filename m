Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5752A3F5A14
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhHXIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbhHXIsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:48:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD2C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:47:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p38so43951229lfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l/0DcoU3NR5Hm+Z2+0dYvQke43s7NiVsSxOhSfpWkyE=;
        b=KItREUdnxeMFcle3E7sljnZ3PpyGaLXWXOR1lbD+JaDUQ7TOO2KpmsV3I+YeXz2RDq
         IUkircfEpRJ/72D1ETGD2RKXrKXgd10JB+xUOZFqgOaB24/gXCFZ7j4PaxSWrQGjyaeO
         Pv7VXjFIh6L3buSbrsRCnXtHbw+VspB4TDQHhTAlXXDW8MAji6HnOMbl7nd7y7ERE++m
         mj/IoaQsEXmYGB0ECXoC+CaPelys7WHzGG/gUbZjwmolyFSq3iMYG7aFAIcxY1qkOAir
         H+UN4mykEll86s2cs95q0MDcT/s80+5vEYZOU4zR4NKjMS7oDlskTUTb+t46f2WL5tKo
         NNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l/0DcoU3NR5Hm+Z2+0dYvQke43s7NiVsSxOhSfpWkyE=;
        b=f057CdldOVcr35OTs/8VW+3O1DCNuoIjRzFNfWbmI6mWSJGePLk3gTQdx8iZRiXc/R
         WwJUi7UB6q3kDnDIFjAcTPzVDZ41KFw2Z+uMJuxwD3Rb+TVJbPGPwIqprqSG356gjR8E
         yg5DhlsEONxeqaLZEjKWgrANCZ49TECmwOk0JW+WQsT8vK3QkpepWDquwO+ieHufnOWu
         0iDvFOZXcXuma5lfDklpCvkVYi1StCSh6LKxjIld9CP3Pa+70SKkeQDVHvZWoaIO0o7q
         LSFjmAHQYDMGMBclYrcMFuFB0HqI2QDwpk5rJXIa4Fc35UgOtLb++xmhnMKfhzlpKEVm
         OZZg==
X-Gm-Message-State: AOAM532nBYqEjJfWBhFehmDMG6DtRYgvCqaXQHCeTgWZGNMu9/71AYnp
        If/SD8NDZ/ROYrteCbg7A9IaIRYL1CX8AQ==
X-Google-Smtp-Source: ABdhPJypAbTeZN5vx+Sh2a5uJJ2rXXiMS1W8bm6Usj7WPhEdVnu0MEht7qeSR1Tfn7vKOa3lqADXJA==
X-Received: by 2002:a05:6512:2290:: with SMTP id f16mr1315159lfu.525.1629794834129;
        Tue, 24 Aug 2021 01:47:14 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id x2sm1700054ljn.12.2021.08.24.01.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 01:47:13 -0700 (PDT)
Subject: Re: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of
 rtw_read32
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1629642658.git.paskripkin@gmail.com>
 <2424268.2DCLMNk6Lg@localhost.localdomain>
 <2355365e-d75e-8d1b-aad8-6979b70f33ec@gmail.com>
 <3419359.n4KOUNuIW1@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <77da7c63-a5b1-a09d-39ec-32c5485b8eac@gmail.com>
Date:   Tue, 24 Aug 2021 11:47:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3419359.n4KOUNuIW1@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 11:38 AM, Fabio M. De Francesco wrote:
> On Tuesday, August 24, 2021 8:40:18 AM CEST Pavel Skripkin wrote:
>> On 8/24/21 3:10 AM, Fabio M. De Francesco wrote:
>> > On Tuesday, August 24, 2021 1:33:46 AM CEST Phillip Potter wrote:
>> >> On Sun, 22 Aug 2021 at 15:36, Pavel Skripkin <paskripkin@gmail.com> wrote:
>> >> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>> >> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
>> >> >  {
>> >> >         u8 requesttype;
>> >> >         u16 wvalue;
>> >> >         u16 len;
>> >> > -       __le32 data;
>> >> > +       int res;
>> >> > +       __le32 tmp;
>> >> > +
>> >> > +       if (WARN_ON(unlikely(!data)))
>> >> > +               return -EINVAL;
>> >> >
>> >> >         requesttype = 0x01;/* read_in */
>> >> >
>> >> >         wvalue = (u16)(addr & 0x0000ffff);
>> >> >         len = 4;
>> >> >
>> >> > -       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>> >> > +       res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>> >> > +       if (res < 0) {
>> >> > +               dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
>> >> > +       } else {
>> >> > +               /* Noone cares about positive return value */
>> >> > +               *data = le32_to_cpu(tmp);
>> >> > +               res = 0;
>> >> > +       }
>> >> >
>> >> > -       return le32_to_cpu(data);
>> >> > +       return res;
>> >> >  }
>> >> 
>> >> Dear Pavel,
>> >> 
>> >> OK, found the issue with decoded stack trace after reviewing this
>> >> usb_read32 function. Your line:
>> >> res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>> >> 
>> >> should read:
>> >> res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);
>> > 
>> > Dear Philip,
>> > 
>> > No, it should read:
>> > 
>> > res = usbctrl_vendorreq(pintfhdl, wvalue, data, len, requesttype);
>> > 
>> > I suspect that Pavel didn't notice he was reusing a line of the old code
>> > wth no due changes.
>> > 
>> >> With this change, the driver runs fine with no crashes/oopses. I will
>> >> explain the issue but you can probably see already, so I hope I'm not
>> >> coming across as patronising, just trying to be helpful :-)
>> >> 
>> >> Essentially, you are taking the address of the data function parameter
>> >> on this line with &data, a pointer to u32, which is giving you a
>> >> pointer to a pointer to u32 (u32 **) for this function parameter
>> >> variable. When passed to usbctrl_vendorreq, it is being passed to
>> >> memcpy inside this function as a void *, meaning that memcpy
>> >> subsequently overwrites the value of the memory address inside data to
>> >> point to a different location, which is problem when it is later
>> >> deferenced at:
>> >> *data = le32_to_cpu(tmp);
>> >> causing the OOPS
>> >> 
>> >> Also, as written, you can probably see that tmp is uninitialised. This
>> >> looks like a typo, so guessing this wasn't your intention. Anyhow,
>> >> with that small change, usbctrl_vendorreq reads into tmp, which is
>> >> then passed to le32_to_cpu whose return value is stored via the
>> >> deferenced data ptr (which now has its original address within and not
>> >> inadvertently modified). Hope this helps, and I'd be happy to Ack the
>> >> series if you want to resend this patch. Many thanks.
>> > 
>> > I think that another typo is having 'tmp', because that variable is unnecessary
>> > and "*data = le32_to_cpu(tmp);" is wrong too.
>> > 
>> > Now I also see that also usb_read16() is wrong, while usb_read8() (the one that
>> > I had read yesterday) is the only correct function of the three usb_read*().
>> > 
>> 
>> Hi, guys!
>> 
>> 
>> Sorry for breaking your system, Phillip. This code was part of "last 
>> minute" changes and yes, it's broken :)
>> 
>> I get what Phillip said, because I _should_ read into tmp variable 
>> instead of directly to data, but I don't get Fabio's idea, sorry.
> 
> Hi Pavel,
> 
> I (wrongly?) assumed from the prototype of usb_read32() that u32 *data is in native
> endianness. So, I didn't see the necessity of using _le32 tmp and then convert that tmp
> with le32_to_cpu().
> 
> I simply thought that data could be passed to usbctrl_vendorreq as it-is.
> 
>> Data from chip comes in little-endian, so we _should_ convert it to 
>> cpu's endian. Temp variable is needed to make smatch and all other 
>> static anylis tools happy about this code.
> 
> Now that you explained that "Data from chip comes in little-endian", obviously
> I must agree with you that the code needs tmp and that tmp must be
> swapped by le32_to_cpu(), ahead of assigning it to *data.
> 
> Just a curiosity... Since I was not able to see that *data is returned in little endian,
> can you please point me where in the code you found out that it is? There must
> be some place in the code that I'm unable to find and see that *data is LE.
> 
> Thanks in advance,
> 
> Fabio

Hi, Fabio!

previous usb_read16() realization, which is 100% right:


static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
{
	u8 requesttype;
	u16 wvalue;
	u16 len;
	__le32 data;

	requesttype = 0x01;/* read_in */
	wvalue = (u16)(addr & 0x0000ffff);
	len = 2;
	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);

	return (u16)(le32_to_cpu(data) & 0xffff);
}


Bases on this code, I think, it's oblivious, that data comes in 
little-endian. That's why I leaved temp variable for casting le32 to 
cpu's endianess.

I could just read into u{16,32} * and then make smth like

*data = le32_to_cpu(*data)

but static analysis tools will complain about wrong data type passed to 
  le32_to_cpu()

+ Phillip tested fixed v2 version and it worked well for him. I guess, 
Phillip was able to spot weird driver behavior, if this cast is wrong.




With regards,
Pavel Skripkin
