Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D4A4239F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbhJFIt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbhJFItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:49:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3A8C061749;
        Wed,  6 Oct 2021 01:47:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i24so7105082lfj.13;
        Wed, 06 Oct 2021 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qt1MU2rBHUcCG/itiqLGGGuQT3zd/XSnIPDfOKn/Ios=;
        b=kofkwor/Exw5fvZpgw8RKXo87GQ0UtBlNV5skI9mNMtOZVBYKg7R9sHNw1qy8RCy9K
         YQHGCMGVX/3a8t0XVF1JQ7x6YugN3L9s2+PSQCGpox9gTc1sQNXCrLLLQVpiiXxCrXW0
         KDPv+9k/5mwYlsYqFTLbKu7TzygRe273QRv8gexRDvoyHI1Z7VCybp2ucN6/XFeaQALJ
         rkDUpc7VnBDkOWPplETX4Xt3OrqiQw+h558dDb4GXRlDd50fyU+1W+7bvezdsrG8ygmg
         19mkkyGaD3IEtb5Oft/QGYZDBvq/T7+05fs64GSZrQu+yZ5XWMLYIWdF3T+o1gVzxikp
         iJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qt1MU2rBHUcCG/itiqLGGGuQT3zd/XSnIPDfOKn/Ios=;
        b=3ezdQgneTJbB/8g+Fl8pTYoIwAxkrmSTaYYif89/XCJ4gTIuR1LTVEoiZ493GAuo4G
         IegpoLyvWynUb8dDI7WSWls0tJHwKnb6sGvupKgCunN6wPFcLoP4FBXlDiGQm2UTwqSC
         QznOw7JCrtP+jGKoAVqsu2Fl7/w6Cq87/1kHVU19DI5yXpBe9p5mrCNAx3v3BcAEDGWJ
         l7kKYCuA6ejlMkIJdy952CvczSAEkZQEWo+xcNQ/laToPSnomNPN10gNcI5Xeg4SJONI
         KJ0GAmXal7ujRX8CFYpec+bOABIBkMR94fyjMZQVSLPWD4L1BcHFs8B0VBmd4ILaUQTi
         7CLg==
X-Gm-Message-State: AOAM532lvCDwhziFI5ySF12yxo/d+y4Z3JEscRihnHbkWRvnNsqbfNtO
        HA5MSgqu9rUxiKjj3C02+/qZNxISaaIkuGJvB08=
X-Google-Smtp-Source: ABdhPJxaeki3renWBs16/PtlBC3PGa0bzgH87pk9l6BVmGBv7CtNn1ORXziCn/HrbNw8V2syQmhIs6DqrrcmCLa6b7E=
X-Received: by 2002:a05:6512:12c9:: with SMTP id p9mr8839455lfg.345.1633510049583;
 Wed, 06 Oct 2021 01:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
 <YVw7vbpu4TS+7Su8@sirena.org.uk> <CADiBU39dvKS_a5FDgw9yMVFe8Uycn6bfjGwBWq+7MN_DdxkL1g@mail.gmail.com>
 <YVxFMaPhZdAFniMa@sirena.org.uk> <CADiBU3_TuHKiVG-r1TG-8WK_tW2GXi4VuqkidPwTyebOgE60OA@mail.gmail.com>
In-Reply-To: <CADiBU3_TuHKiVG-r1TG-8WK_tW2GXi4VuqkidPwTyebOgE60OA@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 6 Oct 2021 16:47:18 +0800
Message-ID: <CADiBU3-4F-FdJxaa4Qp4xmUD3vsA=6u5_ojwDSr8zrDuW8JbXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: rt9120: Add initial bindings
To:     Mark Brown <broonie@kernel.org>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, allen lin <allen_lin@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark:
ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:39=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:29=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, Oct 05, 2021 at 08:25:43PM +0800, ChiYuan Huang wrote:
> > > Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:49=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > On Tue, Oct 05, 2021 at 09:16:54AM +0800, cy_huang wrote:
> >
> > > > > +  richtek,use-dvdd-1p8v:
> > > > > +    description: Indicate DVDD 1P8V is used, default for 3P3V or=
 5V design
> > > > > +    type: boolean
> >
> > > > I would expect this to be done through the regulator bindings, they
> > > > would allow the driver to query the supply voltage.
> >
> > > It's more like as the I/O pad voltage.
> > > Must be the same as I2C and I2S signal high level.
> > > It depends on the application SOC design.
> > > From my understanding, not all application SOC I/O voltage uses
> > > regulator interface.
> >
> > It doesn't really matter what the SoC is doing here, you can always add
> > regulator support to your device - you'd be requesting the supplies to
> > your device, if the SoC doesn't request the supplies that go to it that
> > doesn't really make a difference to what your driver does.
> >
> > Please don't take things off-list unless there is a really strong reaso=
n
> > to do so.  Sending things to the list ensures that everyone gets a
> > chance to read and comment on things.
>
After contacting our HW RD, to support DVDD 1.8V not just SW config,
also HW connections.
To get only DVDD supply voltage is not enough to meet the HW design.
The property seems indeed and need to be used by user's HW connection.

Can this property to be kept?
> Sorry, my fault.
> I just noticed the mail not reply all. Loop all again.
