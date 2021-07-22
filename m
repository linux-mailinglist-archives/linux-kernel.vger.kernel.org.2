Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362473D1EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhGVGaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 02:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhGVGaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:30:12 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9EC061575;
        Thu, 22 Jul 2021 00:10:48 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id o8so4497785ilf.4;
        Thu, 22 Jul 2021 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9R4GbaLb7x9qYxl2DeK7+TAwKctElQJWbiwEkX5Kzhk=;
        b=drEckRBoqNpLV7KnpEQDsBNrKsL1z88qdiMBOWSN+inGx/IgPK3kZh7HLjL9eQIZCf
         gcWfT3C1MXhCkjax7snHv0jZb9oMnWW6KhFukvrSe0qSYniu1DeGbaBadXCECKfexHJx
         cwbDJA8SXdVqOSmAuNuW+1QE23ZLEJcaOc8FT/JGdyOMZvXV82BH67J4Td+pquObDxAc
         TR6wY660uZ0NHlZZgMQKG07iOZgqu8oi/t8RKbcKnKOpeL7XaB029Hx4zZQ0+44UsYgF
         aUdqhrlTqEeZLrnvU87iwYWINJwFzSrAS9cyj5M1NHUvmWKZEbgB0qDSZJJYNLi6Ea09
         +eBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9R4GbaLb7x9qYxl2DeK7+TAwKctElQJWbiwEkX5Kzhk=;
        b=WSAFQqjXAfLr6rlEkLa8fOY7hWIquQYio5VeeiK+f5Rk9PYN0mVVOlhOkAxOqS2M1p
         ND6cB0rKeukPZUdXKoK1+HrOiJjO8kRGsugtgy2csczEIzLloUUMLlkpxLlgwBC+TbX9
         4IGTLKWEJ5CVVUT6HzmcbhGUmDAbhsHx4sClLYBPXacKjH/XGjNzFrib6oS0E51yGs76
         CWiq7Jf+KuAE2TVYJA4DdlWJPuk0GfG88Csyrk7zi4+ok9SLYgFiCvYgMBDUoNffMz5o
         21WeMHycsgXeHC7Que1AK/Jj0sOpBXuDrLPreJYIfYdVZf1iL8vpoZl5AbwghD5e8N0N
         tBnw==
X-Gm-Message-State: AOAM530b35w03XK7bzYef+15O9/E7KHLPdgxZfkX8eP9JI5Z3G/BhrP1
        JDsjUYDDD81ZWzNUIvKDSKwU3vAjmYhdiIPZ55k=
X-Google-Smtp-Source: ABdhPJwTjhAu6xTfG+QL54ZvXhMm9gqmN62x3piyRaO10skkcefHcASreEjbQs9lCGvv4P+2iukaRJZFPQezISZZX9g=
X-Received: by 2002:a92:ddcf:: with SMTP id d15mr13786756ilr.184.1626937847507;
 Thu, 22 Jul 2021 00:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com>
 <1626853288-31223-4-git-send-email-dillon.minfei@gmail.com>
 <8e091b9c-764d-d410-559e-3c5e25de2a3c@tronnes.org> <CAL9mu0K2yLsG0MXOd4ke8N8zn7311CJ54hL-JcbocJOK+H7W9A@mail.gmail.com>
 <1e4743b0-250f-975a-f83d-5d000c6496e3@tronnes.org>
In-Reply-To: <1e4743b0-250f-975a-f83d-5d000c6496e3@tronnes.org>
From:   Dillon Min <dillon.minfei@gmail.com>
Date:   Thu, 22 Jul 2021 15:10:11 +0800
Message-ID: <CAL9mu0J-1=bSG6bXqwHOefYtgK5mn7vwcN4tnf82z0crdERCfQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: Add ilitek ili9341 panel driver
To:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Noralf,

On Thu, 22 Jul 2021 at 15:03, Noralf Tr=C3=B8nnes <noralf@tronnes.org> wrot=
e:
>
>
>
> Den 22.07.2021 04.07, skrev Dillon Min:
> > Hi Noralf
> >
> > Thanks for your time to review my patch.
> >
> > On Thu, 22 Jul 2021 at 01:42, Noralf Tr=C3=B8nnes <noralf@tronnes.org> =
wrote:
> >>
> >>
> >>
> >> Den 21.07.2021 09.41, skrev dillon.minfei@gmail.com:
> >>> From: Dillon Min <dillon.minfei@gmail.com>
> >>>
> >>> This driver combine tiny/ili9341.c mipi_dbi_interface driver
> >>> with mipi_dpi_interface driver, can support ili9341 with serial
> >>> mode or parallel rgb interface mode by register configuration.
> >>>
> >>> Cc: Linus Walleij <linus.walleij@linaro.org>
> >>> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> >>> ---
> >>
> >>> +static const struct of_device_id ili9341_of_match[] =3D {
> >>> +     {
> >>> +             .compatible =3D "st,sf-tc240t-9370-t",
> >>> +             .data =3D &ili9341_stm32f429_disco_data,
> >>> +     },
> >>> +     {
> >>> +             /* porting from tiny/ili9341.c
> >>> +              * for original mipi dbi compitable
> >>> +              */
> >>> +             .compatible =3D "adafruit,yx240qv29",
> >>
> >> I don't understand this, now there will be 2 drivers that support the
> >> same display?
> >
> > There is no reason to create two drivers to support the same display.
> >
> > To support only-dbi and dbi+dpi panel at drm/panel or drm/tiny both
> > fine with me.
> >
> >>
> >> AFAICT drm/tiny/ili9341.c is just copied into this driver, is the plan
> >> to remove the tiny/ driver? If so I couldn't see this mentioned anywhe=
re.
> >
> > Yes, I'd like to merge the code from drm/tiny/ili9341.c to this driver
> > (to make a single driver to support different bus).
> >
> > I have two purpose to extend the feature drm/tiny/ili9341.c
> >
> > - keep compatible =3D "adafruit,yx240qv29", add bus mode dts bindings (=
panel_bus)
> >   to define the interface which host wants to use. such as
> > panel_bus=3D"dbi" or "rgb"
> >   or "i80" for this case, i will add dpi code to drm/tiny/ili9341.c.
> >
> > - merge tiny/ili9341.c to this driver,remove drm/tiny/ili9341.c, add
> > new dts compatible
> >   string to support other interfaces. just like what i'm doing now.
> >
> > I have no idea about your plan on drm/tiny drivers, actually some of
> > these panels under
> > the diny folder can support both dbi and dbi+dpi (much faster, need
> > more pins). no
> > doubt the requirement to support dpi is always there.
> >
> > What is your preference?
> >
>
> I have no plans for tiny/, it's just a place to put tiny DRM drivers of
> all sorts.

Thanks for clarifying.

>
> Whether or not to have "full" DRM drivers in panel/ is up to Sam and
> Laurent I guess, currently there's only drm_panel drivers in there. I
> have no objections to doing that though.
>
> I just wanted to make sure we don't have 2 drivers for the same display.

Sure, agree with you, sorry for not mentioning it in the cover letter.
I'm waiting for Sam and Laurent's feedback, then submit v3 after that.

Best regards.
Dillon

>
> Noralf.
>
> > Thanks & Regards
> > Dillon
> >
> >>
> >> Noralf.
> >>
> >>> +             .data =3D NULL,
> >>> +     },
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, ili9341_of_match);
