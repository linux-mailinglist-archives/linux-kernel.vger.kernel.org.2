Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9329D3F5A36
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhHXIy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhHXIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:54:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F598C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:53:39 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c12so36329922ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2r4ngFjLjfq9YSn0jkH9oDjdsB7Zq43pzXKudghtmFc=;
        b=pfS31p19wSJYrzNTPwffVtwFHGcHwSbE703NfJkMZH5TEeMFBPQkz4U8U5NVDBcgud
         nelWuK3WRt3rFouau4tArlPm+lEYxJzuGkVRnbdDm+UvreOGbvUO/55dsiJkycjVM+VS
         nLe7P1dmc7V2VWWKcllGBVZreQFTPLpuzcSRu3y1FAIMNXWj/vsdEC7RKmby80DpzQ+i
         7v5yFX/4MhHpNzf0AkE01cJNiGXz0dmqDXk9AfYZHusHy+5jbo1X08oz6soEylDWipBm
         XaFMYU0beRWzYecyLRODrzOanqI0kxI07xNb9Y46WshIKKaj5vaG1AHZqvxVX19XFO6X
         /j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2r4ngFjLjfq9YSn0jkH9oDjdsB7Zq43pzXKudghtmFc=;
        b=ugGlHAQa+tVKwxyUQswEAJnXG45BiPBh0JY6dKD0gUfmC979sKQIjz6bneRgTwXFOw
         Sk+hypyjWgkj4KEy9AvMMpWh35E+Dx+4zAOs/23pKXOPqK9uMD2eUfNn2xyyELoLw+g8
         laQ81X6ua29fUoQ+DmibvrL/I+x6fK04+3+A/os0cE0mjTS61i9pQYZOT9kOOxxDPfwc
         jtFPUWXrrvLexTeHkZMJmLwC1x7Q/FnUQBgVQ5WNFMN/IF79MbVklsXByH8QtePfMu8v
         KJ0kJgSlYRDJccS1TVJJWhkOvACx5ivMu12evEQ3V+I4O8AYb0ltwGfcclXvozAkFjGE
         oE1A==
X-Gm-Message-State: AOAM533hcXd+/VX1HNO5pERq0VCp1CgB6u+tgr52onJ912bQu4Ig00B9
        IaXagx+0hR636FVDwr4UDTgICgk96gbHqQ==
X-Google-Smtp-Source: ABdhPJyz3LJTJ8WmlkjVQKtHRaQseRiwNI2uP++yp4ZBLERUO8lQSi1N4M9St5jdzKtYjGLY/1CL7w==
X-Received: by 2002:a05:651c:1695:: with SMTP id bd21mr31444075ljb.5.1629795217106;
        Tue, 24 Aug 2021 01:53:37 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id u2sm1715045lji.82.2021.08.24.01.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 01:53:36 -0700 (PDT)
Subject: Re: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of
 rtw_read32
From:   Pavel Skripkin <paskripkin@gmail.com>
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
 <77da7c63-a5b1-a09d-39ec-32c5485b8eac@gmail.com>
Message-ID: <96e3703e-a5e2-3c6d-ea3c-b5d3892849b2@gmail.com>
Date:   Tue, 24 Aug 2021 11:53:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <77da7c63-a5b1-a09d-39ec-32c5485b8eac@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 11:47 AM, Pavel Skripkin wrote:
> On 8/24/21 11:38 AM, Fabio M. De Francesco wrote:
>> On Tuesday, August 24, 2021 8:40:18 AM CEST Pavel Skripkin wrote:
>>> On 8/24/21 3:10 AM, Fabio M. De Francesco wrote:
>>> > On Tuesday, August 24, 2021 1:33:46 AM CEST Phillip Potter wrote:
>>> >> On Sun, 22 Aug 2021 at 15:36, Pavel Skripkin <paskripkin@gmail.com> wrote:
>>> >> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>>> >> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
>>> >> >  {
>>> >> >         u8 requesttype;
>>> >> >         u16 wvalue;
>>> >> >         u16 len;
>>> >> > -       __le32 data;
>>> >> > +       int res;
>>> >> > +       __le32 tmp;
>>> >> > +
>>> >> > +       if (WARN_ON(unlikely(!data)))
>>> >> > +               return -EINVAL;
>>> >> >
>>> >> >         requesttype = 0x01;/* read_in */
>>> >> >
>>> >> >         wvalue = (u16)(addr & 0x0000ffff);
>>> >> >         len = 4;
>>> >> >
>>> >> > -       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>>> >> > +       res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>>> >> > +       if (res < 0) {
>>> >> > +               dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
>>> >> > +       } else {
>>> >> > +               /* Noone cares about positive return value */
>>> >> > +               *data = le32_to_cpu(tmp);
>>> >> > +               res = 0;
>>> >> > +       }
>>> >> >
>>> >> > -       return le32_to_cpu(data);
>>> >> > +       return res;
>>> >> >  }
>>> >> 
>>> >> Dear Pavel,
>>> >> 
>>> >> OK, found the issue with decoded stack trace after reviewing this
>>> >> usb_read32 function. Your line:
>>> >> res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>>> >> 
>>> >> should read:
>>> >> res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);
>>> > 
>>> > Dear Philip,
>>> > 
>>> > No, it should read:
>>> > 
>>> > res = usbctrl_vendorreq(pintfhdl, wvalue, data, len, requesttype);
>>> > 
>>> > I suspect that Pavel didn't notice he was reusing a line of the old code
>>> > wth no due changes.
>>> > 
>>> >> With this change, the driver runs fine with no crashes/oopses. I will
>>> >> explain the issue but you can probably see already, so I hope I'm not
>>> >> coming across as patronising, just trying to be helpful :-)
>>> >> 
>>> >> Essentially, you are taking the address of the data function parameter
>>> >> on this line with &data, a pointer to u32, which is giving you a
>>> >> pointer to a pointer to u32 (u32 **) for this function parameter
>>> >> variable. When passed to usbctrl_vendorreq, it is being passed to
>>> >> memcpy inside this function as a void *, meaning that memcpy
>>> >> subsequently overwrites the value of the memory address inside data to
>>> >> point to a different location, which is problem when it is later
>>> >> deferenced at:
>>> >> *data = le32_to_cpu(tmp);
>>> >> causing the OOPS
>>> >> 
>>> >> Also, as written, you can probably see that tmp is uninitialised. This
>>> >> looks like a typo, so guessing this wasn't your intention. Anyhow,
>>> >> with that small change, usbctrl_vendorreq reads into tmp, which is
>>> >> then passed to le32_to_cpu whose return value is stored via the
>>> >> deferenced data ptr (which now has its original address within and not
>>> >> inadvertently modified). Hope this helps, and I'd be happy to Ack the
>>> >> series if you want to resend this patch. Many thanks.
>>> > 
>>> > I think that another typo is having 'tmp', because that variable is unnecessary
>>> > and "*data = le32_to_cpu(tmp);" is wrong too.
>>> > 
>>> > Now I also see that also usb_read16() is wrong, while usb_read8() (the one that
>>> > I had read yesterday) is the only correct function of the three usb_read*().
>>> > 
>>> 
>>> Hi, guys!
>>> 
>>> 
>>> Sorry for breaking your system, Phillip. This code was part of "last 
>>> minute" changes and yes, it's broken :)
>>> 
>>> I get what Phillip said, because I _should_ read into tmp variable 
>>> instead of directly to data, but I don't get Fabio's idea, sorry.
>> 
>> Hi Pavel,
>> 
>> I (wrongly?) assumed from the prototype of usb_read32() that u32 *data is in native
>> endianness. So, I didn't see the necessity of using _le32 tmp and then convert that tmp
>> with le32_to_cpu().
>> 
>> I simply thought that data could be passed to usbctrl_vendorreq as it-is.
>> 
>>> Data from chip comes in little-endian, so we _should_ convert it to 
>>> cpu's endian. Temp variable is needed to make smatch and all other 
>>> static anylis tools happy about this code.
>> 
>> Now that you explained that "Data from chip comes in little-endian", obviously
>> I must agree with you that the code needs tmp and that tmp must be
>> swapped by le32_to_cpu(), ahead of assigning it to *data.
>> 
>> Just a curiosity... Since I was not able to see that *data is returned in little endian,
>> can you please point me where in the code you found out that it is? There must
>> be some place in the code that I'm unable to find and see that *data is LE.
>> 
>> Thanks in advance,
>> 
>> Fabio
> 
> Hi, Fabio!
> 
> previous usb_read16() realization, which is 100% right:
> 
> 
> static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
> {
> 	u8 requesttype;
> 	u16 wvalue;
> 	u16 len;
> 	__le32 data;
> 
> 	requesttype = 0x01;/* read_in */
> 	wvalue = (u16)(addr & 0x0000ffff);
> 	len = 2;
> 	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> 
> 	return (u16)(le32_to_cpu(data) & 0xffff);
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
>    le32_to_cpu()
> 
> + Phillip tested fixed v2 version and it worked well for him. I guess,
> Phillip was able to spot weird driver behavior, if this cast is wrong.
> 
		^^^^^&

I am wrong with this statement, I guess. Most likely, Phillip is testing 
on smth like x64 and this arch is le, so...




With regards,
Pavel Skripkin
