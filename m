Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847EC38E0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 08:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhEXGIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 02:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEXGIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 02:08:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E153EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 23:06:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i7so22069027ejc.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 23:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NFzZddPUGCZkHfUYYpFfWBQZHRe0lpFwnj50BECbHNo=;
        b=FwdSmf24pC1VcVkdHknLZYs5/NnPsGG9XwrZyuiYLAXCQjkSZdD0foCmDYazjTOUAj
         PrOSartWXBBorRbqercIGkYuQI/0OPCU1vvRs6p100jffudry9leVpQr4fTEgxiZLD+3
         jlCWwpsTbt0LU01jbiPOWVWHEGMOZfoVd5BmXrLQrNulRsgKPHZLz5NvULiloeNPL8n4
         6+uc+bhtQl75eetlJ4sxPhUXhFNXj7e0ti9Y2vLzpfdlS+iKeC+dFWhv4liWCHSwSq0m
         8i74wK5cIymlwo1+njYYYhLTdVJnKkyhvVl/8xIveScmoj7IfK3fsvKpJZ/ceOEJ9Juq
         gbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NFzZddPUGCZkHfUYYpFfWBQZHRe0lpFwnj50BECbHNo=;
        b=JnMzTKYvgo5PHeNcy58c2duC+t4ZU4xHUouPMqQI4jQ1tWypcDNQbJhZewd1al7/XQ
         68LcffqS7UFzWkQB+ob+/HSLDPgd+IGfDAvm59ZBmigM+OGsyU3VoupyaPDUTUK1SN+h
         QtM4p7h2fh6pvYr0DodcRkdjHTPz0ow2lTtbFVyK0xuGeiCbuPJvOUVDPhWdqWSHVSMI
         JJIl7yW2nwdO2yxcuFnGjgy2gqOgsOYDSDJViSDTiYJvFN4Tpc6NRopXbfBuBKyELvhC
         Ai6d2F+qwwSUIbF455gQgUO+xrreRYocPWTIEy0bXHCjQg9wb7WE8cifNYH7elzEp4ao
         PgKg==
X-Gm-Message-State: AOAM5333nT9iXSzw91/cmAPE80JquIMyCfnR5KlJfil/lSu1tiLgfNnr
        xkIizJUTVK5eIGr/QuxsB+kDY4LKUsWZCVoAVf4wJw==
X-Google-Smtp-Source: ABdhPJzVQwVVhvrSiDZSnTjiEr0J2zsMdE/QHHYo/6GL5pcI4A6he3jxemrFufD2HKwTRkTPlQXzJqFkr19UGrOw5Cg=
X-Received: by 2002:a17:906:1c46:: with SMTP id l6mr21924376ejg.328.1621836404428;
 Sun, 23 May 2021 23:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210523071045.2168904-1-axel.lin@ingics.com> <4189cb2094b4fe43e351eb1d80ca6c4cb1ac08ed.camel@fi.rohmeurope.com>
In-Reply-To: <4189cb2094b4fe43e351eb1d80ca6c4cb1ac08ed.camel@fi.rohmeurope.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Mon, 24 May 2021 14:06:08 +0800
Message-ID: <CAFRkauA8npjbAwwyRKh-VmMkmK59hE=P6+iHQPMSw-buduagDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: bd70528: Fix off-by-one for buck123
 .n_voltages setting
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> =E6=96=BC 2021=E5=B9=B4=
5=E6=9C=8824=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:41=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi Axel,
>
> On Sun, 2021-05-23 at 15:10 +0800, Axel Lin wrote:
> > The valid selectors for bd70528 bucks are 0 ~ 0xf, so the .n_voltages
> > should be 16 (0x10). Use 0x10 to make it consistent with
> > BD70528_LDO_VOLTS.
> > Also remove redundant defines for BD70528_BUCK_VOLTS.
> >
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> > I think this fix does not need "Fixes" tag because in original code
> > the
> > .n_voltage is greater than correct one. The latest selector is not
> > valid
> > in the linear range setting anyway.
> >  include/linux/mfd/rohm-bd70528.h | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/include/linux/mfd/rohm-bd70528.h
> > b/include/linux/mfd/rohm-bd70528.h
> > index a57af878fd0c..4a5966475a35 100644
> > --- a/include/linux/mfd/rohm-bd70528.h
> > +++ b/include/linux/mfd/rohm-bd70528.h
> > @@ -26,9 +26,7 @@ struct bd70528_data {
> >       struct mutex rtc_timer_lock;
> >  };
> >
> > -#define BD70528_BUCK_VOLTS 17
> > -#define BD70528_BUCK_VOLTS 17
> > -#define BD70528_BUCK_VOLTS 17
> > +#define BD70528_BUCK_VOLTS 0x10
>
> Thank you for fixing this. There really is only 16 valid voltage
> settings as you pointed out. Regarding changing the define to hex - I
> would prefer seeing the amount in decimal as it is easier to
> understand. (I do understand bit-patterns better when in HEX - but
> "real world" values like voltages, currents or amounts are easier (for
> me) to understand when in decimals)

Current code already uses hex-decimal (which is the reason I use
hex-decimal for BD70528_BUCK_VOLTS):
#define BD70528_LDO_VOLTS 0x20

So do you suggest to change BD70528_LDO_VOLTS to decimal as well?

Regards,
Axel
