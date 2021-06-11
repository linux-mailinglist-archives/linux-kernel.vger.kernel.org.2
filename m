Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7913A3D28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFKHd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:33:59 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46596 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFKHd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:33:57 -0400
Received: by mail-pg1-f181.google.com with SMTP id n12so1727911pgs.13;
        Fri, 11 Jun 2021 00:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fG0F4HBoROHD6DXq0+EVGrn1s2SpM2ZJvpNOm1d4zUg=;
        b=SnPIV5vze7J7JcnPD4B4Awerb0mcgkxEYKR+YeEzoxtMuRl6WUKi2YWHAs3CrsUcmb
         JWhZLp/mVOjQhPrefHUsnTMfu0c8rLZj5S001QRBnvpttQS3QGOvUZpcXPNrYQq5Apgh
         A22UhddUK7q3Bam4yebGnaolkneUyXXP0cwlS44X+fhmIVQTwT+iO409YiB/Pbr07rNu
         /gsiq9KmYp2cRVzhTLy1qyD+PFjx9mjcarcCAXucLBlig7mx1P29bOM6lQZj1spZvW2g
         677+GJSl29RoRKz/7kvf+MRvhZomZgj07MWXgLIaVA1Jj9Ttr5vcxtopLJu5udH55FKH
         iZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fG0F4HBoROHD6DXq0+EVGrn1s2SpM2ZJvpNOm1d4zUg=;
        b=EGuTuuST6rggi1FoUjnmAH5rwmblk3ot4PSt2zUGXI+8BJ8xubdxZxWAF5MOqpKP6j
         085901tcjDV3Jo7v/RxCqpflc5SjtkSdaljw5dNYrRL7bsvSkAE5lkDePJKBFgpd0cCS
         UVbEfNVVPxdz0R+9jMphsON56OfZQ7VfInhu5vY48Z2an4g4GZZ7YxEWBDxRvztzI5Jf
         oQzPZDzNGU6mes4+N31vUIzIf6nl8PJS7Scd2RmIy3dDCFu1sTDfmj0I9nyCyDkPwx79
         gwrl8JUqQWAKASGsFcZqDuE6hcb+5zyH59evXG+F3qlurwr4BxNS0JDxfQK+QdliD31n
         dEKw==
X-Gm-Message-State: AOAM531QWHhroYTEb/1+I7GYcrjv0mUB/WvEvU5PEVEaSKC0BFEbGny9
        5Qqo6LRHdvosOPlYjq0yiut0iXAbq4ohxegQpXk=
X-Google-Smtp-Source: ABdhPJwgxg5M1F7Tbl6QjEiV5uVfgPWNOoW1AlwpYF/7g/rhoAsBS/3d+ETCatkdfjOsXrQ3Y5NDIpdCRtjOLqbtIkA=
X-Received: by 2002:a63:181f:: with SMTP id y31mr2280746pgl.145.1623396644577;
 Fri, 11 Jun 2021 00:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210609012849.797576-1-xieqinick@gmail.com> <11da3ae4-91d4-1e51-c652-e4ad518f13bd@baylibre.com>
 <CAP4nuTVMZV7pz8NrM2MHcZzBdueRXjS+KYsU4=cQ1CB67gr_Hg@mail.gmail.com> <ee3341d9-350e-a84d-6836-3401be679b2a@baylibre.com>
In-Reply-To: <ee3341d9-350e-a84d-6836-3401be679b2a@baylibre.com>
From:   Nick Xie <xieqinick@gmail.com>
Date:   Fri, 11 Jun 2021 15:30:33 +0800
Message-ID: <CAP4nuTUt1vQjVP=3_NYaeu+m47f78ru6-MgGBiAqLeU9fJAsNg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: vim3: reduce cpu thermal fan trigger temperature
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick <nick@khadas.com>, artem@khadas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,


Neil Armstrong <narmstrong@baylibre.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=883:15=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi,
>
> On 11/06/2021 08:54, Nick Xie wrote:
> > Hello Neil,
> >
> > The MCU FAN won't work until the temperature reach to 80 degree centigr=
ade,
> > Do you think the temperature is too high?
>
> I think 80 is tool high, but I fear 50 is way too low, but if you think 5=
0 is OK after you ran some tests, just add it to the commit log and it's ok=
 for me.

I think it is OK, we use it for a long time.

Thanks.

>
> Neil
>
> >
> > Thanks.
> >
> > Neil Armstrong <narmstrong@baylibre.com <mailto:narmstrong@baylibre.com=
>> =E4=BA=8E2021=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=
=E5=8D=882:44=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     Hi Nick,
> >
> >     On 09/06/2021 03:28, xieqinick@gmail.com <mailto:xieqinick@gmail.co=
m> wrote:
> >     > From: Nick Xie <nick@khadas.com <mailto:nick@khadas.com>>
> >     >
> >     > Reduce the MCU FAN trigger temperature from
> >     > 80 degree centigrade to 50 degree centigrade.
> >
> >     Can you add some more rationale to this change ?
> >
> >     >
> >     > Signed-off-by: Nick Xie <nick@khadas.com <mailto:nick@khadas.com>=
>
> >     > ---
> >     >  arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 2 +-
> >     >  1 file changed, 1 insertion(+), 1 deletion(-)
> >     >
> >     > diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b=
/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> >     > index 66d67524b031..a9c34fee91f4 100644
> >     > --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> >     > +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> >     > @@ -256,7 +256,7 @@ &cecb_AO {
> >     >  &cpu_thermal {
> >     >       trips {
> >     >               cpu_active: cpu-active {
> >     > -                     temperature =3D <80000>; /* millicelsius */
> >     > +                     temperature =3D <50000>; /* millicelsius */
> >     >                       hysteresis =3D <2000>; /* millicelsius */
> >     >                       type =3D "active";
> >     >               };
> >     >
> >
> >     With that:
> >     Reviewed-by: Neil Armstrong <narmstrong@baylibre.com <mailto:narmst=
rong@baylibre.com>>
> >
>
