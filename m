Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C731424BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 04:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhJGCq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 22:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhJGCq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:46:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DEAC061746;
        Wed,  6 Oct 2021 19:45:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b20so18785970lfv.3;
        Wed, 06 Oct 2021 19:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UbB1cUHSIw/ZuVAsACZPiSQBpvCldBuU8f84dBJFpe8=;
        b=ZxF3Sf93cWa/sNLhOiRbipSo8A6czSa7naFHt5giZ4rfxgaj3tT+BBoco1p2QgsJpg
         nAaul1l1b4FG9IfCzwLEMBb4mR0kssPrfnpjuLYbfr449KVnQOrTbJY2GiMCihSz7OFW
         bp11TL1vFPQ5V3aMoAU/AW/WXpp32NylvrcHQG3CsODRSvz5LOks1/x871cDIjF8z9hj
         4TZ3vqS4nlY4MQeAMV7AsQ+XbtfvH+shm4qqhZD4BgZKXhkGKgb2F/ZkbZVT//W6diat
         LECZmN+KQLL5W6jGK/vqWmCQe9/qNLTvGaDY6it1TATDz22TQv+mnmkwV/LGH+K6xtSz
         J5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UbB1cUHSIw/ZuVAsACZPiSQBpvCldBuU8f84dBJFpe8=;
        b=Y8LJk/DQpAjIr13pvoJl1vwEILIQytkb+5w4BkSStshIXXlSNbl7qGlOP3Au7lteuB
         ddHZHnqYLV0e6B1ZFrJtqLYk5bKcgGKhyxvQTj0F9nPcwu0exhdD6YhPOV8iuGiP9nlS
         V2Yp/r5Lh5f0tddFXdIXmI0iHCC1kJKIyj7gpbtvFtnxl4+t5+TydW1KSc/K0iEf8Ln4
         AqKCyTU5VsWE+Xy9Z8b2jAlqGneMxY7ckljJj8WTHz4CQi6qNVfm9fix4McW1TCiPxJn
         RevsSLN4VQKiq4yOZYi1+MtaAY6adlaOCTdqWzgoE/eSBDYTNV5EzbltvNRQaPp1ls/O
         V6zQ==
X-Gm-Message-State: AOAM533leeqwTO04YiqbJ8mWpY26y4bsuhW+yaofQ5giMby7ALCLCIzu
        MHQEGBInQ/Ke1Yp/8H1L2S2srP6WzSLXD48OXag=
X-Google-Smtp-Source: ABdhPJxOTJCZIiXIJyvWaIfIHwO/yvWic8ASH+U1t55w2J3UciFgAKlsHlSnSyer4bHTgKAWS83/ea7fGdRwXCpesa0=
X-Received: by 2002:ac2:4da4:: with SMTP id h4mr1582381lfe.356.1633574701728;
 Wed, 06 Oct 2021 19:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
 <YVw7vbpu4TS+7Su8@sirena.org.uk> <CADiBU39dvKS_a5FDgw9yMVFe8Uycn6bfjGwBWq+7MN_DdxkL1g@mail.gmail.com>
 <YVxFMaPhZdAFniMa@sirena.org.uk> <CADiBU3_TuHKiVG-r1TG-8WK_tW2GXi4VuqkidPwTyebOgE60OA@mail.gmail.com>
 <CADiBU3-4F-FdJxaa4Qp4xmUD3vsA=6u5_ojwDSr8zrDuW8JbXg@mail.gmail.com>
In-Reply-To: <CADiBU3-4F-FdJxaa4Qp4xmUD3vsA=6u5_ojwDSr8zrDuW8JbXg@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 7 Oct 2021 10:44:49 +0800
Message-ID: <CADiBU38zCZk_P-q8BtbPfdeSacUF7LOvQYUFgvidbWZwcLY=wA@mail.gmail.com>
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

Hi,

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=886=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:47=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi, Mark:
> ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:39=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:29=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Oct 05, 2021 at 08:25:43PM +0800, ChiYuan Huang wrote:
> > > > Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:49=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > > On Tue, Oct 05, 2021 at 09:16:54AM +0800, cy_huang wrote:
> > >
> > > > > > +  richtek,use-dvdd-1p8v:
> > > > > > +    description: Indicate DVDD 1P8V is used, default for 3P3V =
or 5V design
> > > > > > +    type: boolean
> > >
> > > > > I would expect this to be done through the regulator bindings, th=
ey
> > > > > would allow the driver to query the supply voltage.
> > >
> > > > It's more like as the I/O pad voltage.
> > > > Must be the same as I2C and I2S signal high level.
> > > > It depends on the application SOC design.
> > > > From my understanding, not all application SOC I/O voltage uses
> > > > regulator interface.
> > >
> > > It doesn't really matter what the SoC is doing here, you can always a=
dd
> > > regulator support to your device - you'd be requesting the supplies t=
o
> > > your device, if the SoC doesn't request the supplies that go to it th=
at
> > > doesn't really make a difference to what your driver does.
> > >
> > > Please don't take things off-list unless there is a really strong rea=
son
> > > to do so.  Sending things to the list ensures that everyone gets a
> > > chance to read and comment on things.
> >
> After contacting our HW RD, to support DVDD 1.8V not just SW config,
> also HW connections.
> To get only DVDD supply voltage is not enough to meet the HW design.
> The property seems indeed and need to be used by user's HW connection.
>
> Can this property to be kept?

After thinking, This property name may be improper.
I think this change depends on HW external circuit for lowv application.
Currently, I'm modifying the V3 change, this property name also affect
the property parsing code change.
May I directly change the name to 'richtek,dvdd-lowv-application' and
submit the patch v3?

Any comment is appreciated.
> > Sorry, my fault.
> > I just noticed the mail not reply all. Loop all again.
