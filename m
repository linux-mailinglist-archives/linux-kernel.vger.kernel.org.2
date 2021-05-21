Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0038C7C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhEUNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbhEUNYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:24:15 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A139DC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:22:47 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id k4so14501036ili.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSPLG7KB+dtNRiEJ0aAzKp1A87evLj5m+0uYPmP7wtU=;
        b=H6exrxus36oglOe6gi2Xe1d8QM5/kABILf8SQQdYufyvLbWlztztkc01RzHUUMGtfx
         24BNqjdaH2KErZqllu2HOOqGbWfIxw/0nPTEH0RKBdvVAhhDFj2fv8N/0bcOiYfCad/t
         FLCCht9zh2alwYKH/6TNhvxrvgiRooyzmotUZfQwDvYNCAt9W/h9igq1DnUIFunrZ6ZI
         EkOC78cv0LP+T87mM0vosy+iVT9Yo1rKgicHFXSCfzoaN+RJIAOd58H6iiULBc2eJ2c1
         Az4TMliojHKg+EqpHiSjM5cJnn2+eNnYxEOdaUtU8dQYyXpWu8c+GD5p5LVYXfan5CTG
         rhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSPLG7KB+dtNRiEJ0aAzKp1A87evLj5m+0uYPmP7wtU=;
        b=HnfUPbWBhUoVQBM820retj3Sd2Np3Z7K7DOjRAdikedXo8/Dw1yIvuL0CaFxxqVxqf
         nedUML0dHrSluLMBh5dzhpkwL/V1+vUbf4mV7t3QatcGQ9OgAR8BUlEf9bwvBy9afr0H
         wgFxQ4+uWrjR1BnHmCbhmOXrFNTxSvPM7yFpQTKFPMS3u9HzGylJZnxd7noUyPUKZY42
         xf4zamRF/yX5hJ97h1lGQORrGjm9E24pZ0Wa7MoFbghSClrvy7KZJNxS9GcxbxIiqhNW
         XvY4qjSbc7GmP4Ay65KHkYfqVFITeaVcW2Qlp4f/510+cHU0wkTjtaRaYynUxPytxM0k
         8dSg==
X-Gm-Message-State: AOAM531CM/EYxcnY7+AGthV8/cJgFXODBI0wB9OQS9MDAOHLIfGnStJj
        ciUIzQp5iBY1L2SVR4wHena3yyYVCD0lfdeMgCqS2Q==
X-Google-Smtp-Source: ABdhPJzGz+af46E+PXvwwfG0ykwvxkO57e9OP87fqo4w8nYA4A+7ItBvt2QHSsB2Wc+TSJo5gd4ALewwwLmfBwg2rjs=
X-Received: by 2002:a92:cf45:: with SMTP id c5mr12471444ilr.182.1621603366981;
 Fri, 21 May 2021 06:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210430123511.116057-1-robert.marko@sartura.hr>
 <20210430123511.116057-3-robert.marko@sartura.hr> <20210506140024.GB3340759@robh.at.kernel.org>
 <3905879e67d50d6a7f73fcd83982c052@walle.cc>
In-Reply-To: <3905879e67d50d6a7f73fcd83982c052@walle.cc>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 21 May 2021 15:22:36 +0200
Message-ID: <CA+HBbNGrOG8E=B_HH83ok0+9nGubLEbyzGp=Qm2dvu1=WqSfVQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] gpio: Add Delta TN48M CPLD GPIO driver
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, jdelvare@suse.com,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        jmp@epiphyte.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 6:40 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2021-05-06 16:00, schrieb Rob Herring:
> > On Fri, Apr 30, 2021 at 02:35:08PM +0200, Robert Marko wrote:
> >> Delta TN48M CPLD is used as a GPIO expander for the SFP GPIOs.
> >>
> >> It is a mix of input only and output only pins.
> >>
> >> Since there is no logical GPIO numbering arbitrary one is used
> >> along dt-bindings to make it humanly readable.
> >>
> >> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >> ---
> >>  drivers/gpio/Kconfig      |  12 +++
> >>  drivers/gpio/Makefile     |   1 +
> >>  drivers/gpio/gpio-tn48m.c | 191
> >> ++++++++++++++++++++++++++++++++++++++
> >>  drivers/mfd/tn48m-cpld.c  |   6 +-
> >>  include/linux/mfd/tn48m.h |   3 +
> >>  5 files changed, 212 insertions(+), 1 deletion(-)
> >>  create mode 100644 drivers/gpio/gpio-tn48m.c
> >
> >
> >> +static const struct platform_device_id tn48m_gpio_id_table[] = {
> >> +    { "delta,tn48m-gpio", },
> >
> > Looks like a compatible, but is not. I think you can drop this and just
> > use 'tm48m-gpio' (the driver name).
>
> I'm just curious, why isn't the vendor included here (as there
> might be a chance for name clashes in the future).

It's my oversight, I have converted it to use simple I2C MFD so its
OF based now.

I will update the driver's name with the vendor's name.

Robert
>
> -michael



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
