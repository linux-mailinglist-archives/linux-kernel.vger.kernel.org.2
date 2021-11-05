Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9836044622B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhKEK1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhKEK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:27:17 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A13C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 03:24:38 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y73so10126354iof.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpRU87aczKNt8pCnpW5GQbPMrLgRV+FWXIAVVwm+1ks=;
        b=bT9B1fITwmYV+PY51N96GYVFaPX1+Ee8OXYGq3NGAzRwfxbvfVtiKEhsTuCxhaNa26
         DAesW421GTbjotZLvw9sFznn3tBe3sdlDCthVOw4xfzhbtAbcLIEQAXwnMkiRB82Wkv8
         v8+jYchHaNGnC1LMcCaRQsvDK7gprwpoJdFT/YfNrrCPjFY0neNLSIR11MiUJVERzYDI
         8AvdPPOIWLjgR/+NGSAYO4HCpvOBTRIoLJ6mqex2svUQPUjFrmth4TLBmO3/GrHNXhxu
         o3wM7xPf+8Q3KjT3DmTnrx4ln6ZAiGGHVoYBsRlz2RLsUegGSt4192axrycJ/X7cDpbl
         S+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpRU87aczKNt8pCnpW5GQbPMrLgRV+FWXIAVVwm+1ks=;
        b=Usl3ZqLmgW1S9/8kJy0P7KKcgQnW4RdKRPfADrKHd9ARdw8bp2hH0/ngZxPZ5JBqRt
         mzrxQLMFRV1E01GGnDm/j9xBc4k+7pb6+IhsgYT0HdBqKuu00x0lCpcW1kr28jiM/HNL
         9oH9a/UQqqoLqlePKnMdQvinLkxt/43rTMp6K29BOIJ7A6fxFfIktVzoYGKu/OMuRauO
         3KMb6J2UqBYzzLEw0VUmkqajD2454tDO4Mshs/avQyLO0jeixJ45/VyumXi8mSRhY8nB
         v2xYcg/S67V3QwIuRgmz/QkAstyOmpjYxyNBXLz1FBMFIdqOCEzJsMPmrb6n8c5y8R1Q
         N7Pg==
X-Gm-Message-State: AOAM530BwHVAJuUo/RR4wkIK71ZiZRRCoiOu9m1e6BNhSLVJlmxNTka8
        xqR5YqB9PyXdLqV0uW5aB7HRXXFexY7lsf8n6YT/Cw==
X-Google-Smtp-Source: ABdhPJyaebHYRKyKjlBGJs0I9gVjv5cj397Ne2wgaB9n13zhgHwjy5GNMT1op+EiiCWDE9VyF4Mwh5lMIkRgnTIRRNI=
X-Received: by 2002:a05:6602:3350:: with SMTP id c16mr12909576ioz.43.1636107877555;
 Fri, 05 Nov 2021 03:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211102165657.3428995-1-robert.marko@sartura.hr>
 <20211102165657.3428995-4-robert.marko@sartura.hr> <CAHp75VcWWBHDpM9+POPMUmWuGmdbyH0wCGXvqFH3znbZnTht+w@mail.gmail.com>
In-Reply-To: <CAHp75VcWWBHDpM9+POPMUmWuGmdbyH0wCGXvqFH3znbZnTht+w@mail.gmail.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 5 Nov 2021 11:24:27 +0100
Message-ID: <CA+HBbNEp7-aheGr3jNbV_EYYVSmekp_AFc4hR8gVekjmRE-Y8A@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] reset: Add Delta TN48M CPLD reset controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 8:31 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Nov 2, 2021 at 6:57 PM Robert Marko <robert.marko@sartura.hr> wrote:
> >
> > Delta TN48M CPLD exposes resets for the following:
> > * 88F7040 SoC
> > * 88F6820 SoC
> > * 98DX3265 switch MAC-s
> > * 88E1680 PHY-s
> > * 88E1512 PHY
> > * PoE PSE controller
> >
> > Controller supports only self clearing resets.
>
> ...
>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
>
> > +#include <linux/of.h>
>
> I haven't found any user of this header, but mod_devicetable.h is missing.

Hi,
thanks will fix up in v8.

>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset-controller.h>
>
> > +#include <dt-bindings/reset/delta,tn48m-reset.h>
>
> Shouldn't this go before linux/* as it provides more generic definitions?

I have looked at other drivers and I would say that almost all of them
do it this way,
putting it after other includes.
I also personally prefer it this way.

>
> ...
>
> > +#define TN48M_RESET_TIMEOUT    125000
> > +#define TN48M_RESET_SLEEP      10
>
> In which units? (both)

Its microseconds, will make it clear in v8.

Regards,
Robert
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
