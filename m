Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A09B356C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352376AbhDGMjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352257AbhDGMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E20C06175F;
        Wed,  7 Apr 2021 05:38:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso1237562pjb.3;
        Wed, 07 Apr 2021 05:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PUjKE8eTPy2MYu9gM8lGkbrGpIC4uZ+AdNBDhybjmeg=;
        b=RlMafCS8G388rdM86H2WtpX/m/6ZhmIBq4/TXUAsrL1YPDEI+Nw8HplZTtYLjMJDQI
         gzlORPniQvhEEZCl3KV54wQuxFzPZQAxCRgoos/BSUWvBGssYj95bxTcRkp5O9waxihm
         n63JlirHQfoIUNpjGRD1P9RkOHR1aOUiE9UxAe1LZ7Nkf1j0Eid88i0Hi3PMRrNkDbn7
         zNlCRBE15Ike3ntcxAmRR10R1eZCyO1Mxdt1HJnATpraO3npFqAa/it6dom2qEYKEXik
         rIRs0TbC+ar1TwwHdMdR734kGB26U4vxm84JvKIEyFtMLAjWVvY4jgaXmtXfc57Rq2nY
         UY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PUjKE8eTPy2MYu9gM8lGkbrGpIC4uZ+AdNBDhybjmeg=;
        b=Ck0M05XAm7iCUpirhPwQBpsOw+l9lN6mWegZb+xobQfOALLD0ThKyua1xg6s8ziCAT
         eW2xqRbznvvWfNiaw3yjh9t2MGb15kCcCusM13x2oZbTnSQw4zwvBBsNPNCMBx/xTvs2
         THRuyyQydeh7J92a/PFdNX57pOSf97FNU8ZQqTbaEu5EVVa2gZ0LhA/A2nVyklu9CO4Q
         zh1r2aD1i5lH+Sz5/QpRr4Gd9K/R+bYy+8WBQWgrc5Z6iKVejUn3+78i7UmYruZCxjhZ
         YySFl8z4akUNWXZb0AgKFVwj9lTw1TGw3ZyRFo/OmoRQdyDCZVVDScsbUMYNZWC9QAjZ
         Szhw==
X-Gm-Message-State: AOAM533jSBSwy3caDRHTfDLY8/gaIY9rIl/4aOym5FbbHrdQ5k5qQR4d
        4oh9XQYf/sv2Nlgpyxq3hZlTOdje/JX5tPDYQpA=
X-Google-Smtp-Source: ABdhPJytzqkPuM1b25yKVRQlYpNqFqoTfLBVXWPZOOTrwFuS7Oa+x9hJIfuvJNHOWfmXrRulQZ0UXrafXXsC30A0zAE=
X-Received: by 2002:a17:90a:5407:: with SMTP id z7mr3180483pjh.228.1617799105256;
 Wed, 07 Apr 2021 05:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210406101850.3111-1-photranvan0712@gmail.com>
 <CAHp75Vf8jwhLkaHL2D6FvRJpmbBqpTzePpNqVAFVt8EhSCgxnw@mail.gmail.com> <CAG-T6mP98t6JuQ68bi0aD9PDEpLbkAVwrf-Gp7H7GLQV5rW_GQ@mail.gmail.com>
In-Reply-To: <CAG-T6mP98t6JuQ68bi0aD9PDEpLbkAVwrf-Gp7H7GLQV5rW_GQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Apr 2021 15:38:09 +0300
Message-ID: <CAHp75VdMLtFe6uEQiBg=9TSR1OVEvAZwpB7keTKFH5UWSa9tKw@mail.gmail.com>
Subject: Re: [PATCH v8] USB: serial: cp210x: Add support for GPIOs on CP2108
To:     Tran Van Pho <photranvan0712@gmail.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hung.Nguyen@silabs.com" <Hung.Nguyen@silabs.com>,
        "Tung.Pham@silabs.com" <Tung.Pham@silabs.com>,
        Pho Tran <pho.tran@silabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 6:21 AM Tran Van Pho <photranvan0712@gmail.com> wrot=
e:
> On Wed, Apr 7, 2021 at 5:25 AM Andy Shevchenko <andy.shevchenko@gmail.com=
> wrote:
>> On Tuesday, April 6, 2021, Pho Tran <photranvan0712@gmail.com> wrote:

...

>>> CP2108 has 16 GPIOs, So data types of several variables need to be is u=
16
>>> instead of u8(in struct cp210x_serial_private). This doesn't affect oth=
er
>>> CP210x devices.
>>
>> Here I am wondering if you should use 4 pins per interface. Is any point=
er to data sheet?

> In datasheet, Using 4 pins per interface isn't specified. And when settin=
g or getting Latch
> of GPIO, all of 16 gpios will be done on the same command. So there no di=
fference between
> 4 interfaces of CP2108 in terms of GPIOs.

Okay, so we may have different configurations:
 1 interface + 1 GPIO (N or M pins)
 4 interfaces + 1 GPIO (N or M pins)

...

>>> Because CP2108 has 16 GPIO pins, the parameter passed by cp210x functio=
ns
>>> will be different from other CP210x devices. So need to check part numb=
er
>>> of the device to use correct data format  before sending commands to
>>> devices.
>>>
>>> Like CP2104, CP2108 have GPIO pins with configurable options. Therefore=
,
>>> should be mask all pins which are not in GPIO mode in cp2108_gpio_init(=
)
>>> function.
>>
>> This I didn=E2=80=99t get. If you are talking about usage pin as GPIO, p=
erhaps you should use valid_mask in GPIO chip structure. Otherwise you prob=
ably need to implement a proper pinmux ops for this (and register a pin con=
troller which the code below also suggests).
>
>
> This message means 16 pins on  CP2108 can have many options like GPIO, TX=
 toggle, RX toggle, clock output for example.
> If there are any pins set in the mode that aren't GPIO mode, we should ma=
sk these pins at gpio_altfunc in struct cp210x_serial_private.

Can those functions be changed at run time? Or is it simply one time settin=
g?

> I am not clear  with what you said about pinmux, But I think "gpio_altfun=
c in struct cp210x_serial_private" has the same meaning as your idea.

Yeah, but it's custom grown (I believe due to historical reasons, i.e.
there was no pin controller framework at that time) approach.
If pin functions may be changed at run time, it's better to have them
described as pinmux.

...

>>> +       __le16 gpio_lowpower_PB0;
>>> +       __le16 gpio_lowpower_PB1;
>>> +       __le16 gpio_lowpower_PB2;
>>> +       __le16 gpio_lowpower_PB3;
>>> +       __le16 gpio_lowpower_PB4;
>>> +
>>> +       __le16 gpio_latch_PB0;
>>> +       __le16 gpio_latch_PB1;
>>> +       __le16 gpio_latch_PB2;
>>> +       __le16 gpio_latch_PB3;
>>> +       __le16 gpio_latch_PB4;
>>
>>
>> Sounds to me like pin controller functions rather than GPIO.
>
> Oh yes, This is related to the functions of pins. But we need to define i=
t to get the state of the pins to
> check whether It's  GPIO mode or other function.

Yep, and this is pinmux functionality, no?

> It's also included in vendor specified USB packet structure.
> You can refer to https://www.silabs.com/documents/public/application-note=
s/an978-cp210x-usb-to-uart-api-specification.pdf
> at page34 to see struct _QUAD_PORT_CONFIG.
>
> I have  a question, Should I need to resolve the build warning on i386 re=
ported by the kernel test robot?

If you get a warning, yes, it's better to resolve it.

>>> +       struct cp210x_quad_port_state reset_state;
>>> +       struct cp210x_quad_port_state suspend_state;
>>> +       u8 ipdelay_IFC[4];
>>> +       u8 enhancedfxn_IFC[4];
>>> +       u8 enhancedfxn_device;
>>> +       u8 extclkfreq[4];
>>> +} __packed;

--=20
With Best Regards,
Andy Shevchenko
