Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537B4366865
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbhDUJzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbhDUJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:55:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31875C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:54:37 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m7so36184072ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Amhw8bvKHF0P/YwOkjDFZIuS537DvDV3fmjtkAeOJmI=;
        b=zoLRYbRnOVyRRdmxgAJ2LPReQuKLKwaN8+bANZQrKWM6q+W6Wn/CVEpZSJlUSBncLv
         byYshVXoV2Sk4WYQB72TROIW4XGrpnayBThVJcu6UJMwN2hcSNe04vlgnb8kjgO7gSQZ
         Oi+hzv+UQ4wRuEqgm7uCgv6DgRdqEXzC6M6bf4PWWwt9j3j/odurauNaLTt0OlWJTOhd
         5nz9+7BC4qP0XPcmgL27iLMoU1cBrwEfo88PJ5WXHi4gw1euKJXApsYPi+7bksmVTdlO
         fZfkFwXM4Oc4r66rd+CtUsCFAySFznZ3YBx0vNUA/9HsDZeAVpClxXbDeM9obNXghR7T
         Tt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Amhw8bvKHF0P/YwOkjDFZIuS537DvDV3fmjtkAeOJmI=;
        b=a5CYO4qnGZ1vwrNX66zV9Uf1wnODfdFg6E8IGgglrWFud+oBLa0IlKNy01REcdCntV
         b0tKXcQ7ide7miVgDL7wV6Wy3Dz90suRNB8Yqy2Hbjm3g/LEDQzqYmrj6gD9ARZ0RJfi
         sNZfE0tNkZNzKK+IhxB/cqMs0hpFBRvRpVb4QcQEjOyNV1W4CREeZ2bYuUC6OkyrQ2PU
         s743FL0QIZh0eVfcAGdtdXCS/7Ow/9XnivIcMIDOJBOjQaJIizBd4nrUX1iIRG7ZGlRl
         FRT0hob0b+WsUKNZ6M77vZ8axPVmlMPRse2fjwfJxx6SxqC3yeecM2rslg78q0T6GTVb
         VJ1A==
X-Gm-Message-State: AOAM533jfqNbwmjq7AvBA2TSn/2iKczbJwB/TXg7nB7rYjigx+x9CC4h
        gRd5TuT1wYWfFUgvHatmVNGJ4p5K0VJQ4d/B9Pws/A==
X-Google-Smtp-Source: ABdhPJyJuUEXXYzilkrsnliZ/waDIzceWTF++xtfReO6qLkFGuOGc+BPYe/Pelkuq4dg5lUMXtVtTwvYmgCTUtoIvrg=
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr18074061ljp.368.1618998875678;
 Wed, 21 Apr 2021 02:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
 <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com> <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com>
In-Reply-To: <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Apr 2021 11:54:24 +0200
Message-ID: <CACRpkdbtnCoDdwJA9oi88NKStf5uhi72DgP_a=3Dpp_aT=kYNg@mail.gmail.com>
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Nathan Royer <nroyer@invensense.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 11:26 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> I found a non-kernel example
> which uses a similar equation [1], but in a different form. The main
> difference is that the Arduino code interprets a raw temperature value
> as a signed integer, while upstream assumes it's unsigned.
>
> [1]
> https://github.com/blaisejarrett/Arduino-Lib.MPU3050/blob/master/MPU3050lib.cpp#L111

Oh that's nice. Room temperature as mentioned is 20 deg C
I think?

The divide by 280 part seems coherent in all examples.

> Still, even if assume that the raw temperature is a signed s16 value, it
> gives us ~35C in a result, which should be off by ~10C.
>
> Certainly a manual calibration is an option, but we will try to wait for
> the answer from Nathans and Jean-Baptiste before going that route.

The method I have seen used is:
- Collect many bags of silica gel, those little packages of "dryer" that
come in shoe boxes.
- Put the device with all these in two layers of plastic bags and pull out
cables, glue or strap many layers around the bags to make it really tight
where the cables come out.
- Submerge this into a mixture of ice and water which is known to be
a calibration point for 0 degrees C, wait for some hour or so to
stabilize, add some ice if it all melts.

Now measures should be 0 deg C so any deviance will be the constant
offset that need be added for the sensor.

I guess the OTP (one time programmable memory) also contains
device-unique calibration, maybe also for the temperature sensor,
but IIUC that is read in automatically by the hardware since no
drivers seem to look into that.

Yours,
Linus Walleij
