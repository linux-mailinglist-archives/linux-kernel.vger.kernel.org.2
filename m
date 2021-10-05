Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87274226EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhJEMl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhJEMl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:41:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68548C061749;
        Tue,  5 Oct 2021 05:40:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i4so86369421lfv.4;
        Tue, 05 Oct 2021 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=56g+f47LG+7NwwLmTAwXFmCavIf0OsJkTi6i6izLBEM=;
        b=oG9Y1Q1UY1dSECzyWbV+5gHboovVOEP8dzgj3bSciTu6fdkDkwDI3A5I8Buh0MJp8o
         6wsALw8bdFB68WTYulpp904AJgy4Xn+N3/HiQ2xaAwfsiYSjgqSDEGuKmIfOHccvSHZC
         /b3evmrS2B0wkUvd/TpDUKiuy6+NXs+g3pSysEkm8HDX28QTpbF9ygr9chuX2WymGIXk
         k9rLZMboqEgkjBP+petzQOPRnGGiKqloVzyyHaJLU0B619TIEeU5Cn2xMXhWBdWdyDWy
         eNgtj3UeEE/REVJedaRvcer7G4tdN8ZQLuzEOhqi1v2yJFy+ulo+X5TuQBX3Wgpq6y9q
         e3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=56g+f47LG+7NwwLmTAwXFmCavIf0OsJkTi6i6izLBEM=;
        b=oU+h8+bGYv0BSIyrlrsxEfyqo6dBC8rVRLScO4MDJc02Q5RVpOQHQuggvYzsimWk0y
         lC3dgS7o73azgNNVP1BY1hArJGl4RWN36cSrM1WdgzeAZ4HFHX6Sh1pSd4CyTPUmpwPH
         CkVXJWbl0BjunqhXa4B7QKlTRFPNfv6aS+BoCuKMvRK2tvOhX5EsprOKprWMSalfCJHv
         u/QZ2krMe2piWI5hwmUMydW+DDDKUUFeJfa9hxsmd3zUp5qf/HU2VwbDZHbPZIJozU0/
         jzRqEyc8MRKzq+T8Rwngt58a9Fcp7QqQD/2S79ASIK9bHXUrM84Q3YBOI/+IjIjiVGy8
         Gf8Q==
X-Gm-Message-State: AOAM532RBorgPmOXT1rTKcn+raHMsGdw8w8PwWCt3Z70fufcuGSdtzKx
        EXbT/eayWPq7VQ01SbejHI0FXulS4wZoX0fPeys=
X-Google-Smtp-Source: ABdhPJxTGn+Sz7koXZ0EUatuFym5j3w4GRMkZ8Ov89oLDTj+4uHPboB5rhglPyEmAtkv3hcu4KxnUTBosUXR38dL3bg=
X-Received: by 2002:a05:651c:44f:: with SMTP id g15mr23091575ljg.396.1633437604608;
 Tue, 05 Oct 2021 05:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
 <YVw7vbpu4TS+7Su8@sirena.org.uk> <CADiBU39dvKS_a5FDgw9yMVFe8Uycn6bfjGwBWq+7MN_DdxkL1g@mail.gmail.com>
 <YVxFMaPhZdAFniMa@sirena.org.uk>
In-Reply-To: <YVxFMaPhZdAFniMa@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 5 Oct 2021 20:39:53 +0800
Message-ID: <CADiBU3_TuHKiVG-r1TG-8WK_tW2GXi4VuqkidPwTyebOgE60OA@mail.gmail.com>
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

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 05, 2021 at 08:25:43PM +0800, ChiYuan Huang wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:49=E5=AF=AB=E9=81=93=EF=BC=9A
> > > On Tue, Oct 05, 2021 at 09:16:54AM +0800, cy_huang wrote:
>
> > > > +  richtek,use-dvdd-1p8v:
> > > > +    description: Indicate DVDD 1P8V is used, default for 3P3V or 5=
V design
> > > > +    type: boolean
>
> > > I would expect this to be done through the regulator bindings, they
> > > would allow the driver to query the supply voltage.
>
> > It's more like as the I/O pad voltage.
> > Must be the same as I2C and I2S signal high level.
> > It depends on the application SOC design.
> > From my understanding, not all application SOC I/O voltage uses
> > regulator interface.
>
> It doesn't really matter what the SoC is doing here, you can always add
> regulator support to your device - you'd be requesting the supplies to
> your device, if the SoC doesn't request the supplies that go to it that
> doesn't really make a difference to what your driver does.
>
> Please don't take things off-list unless there is a really strong reason
> to do so.  Sending things to the list ensures that everyone gets a
> chance to read and comment on things.

Sorry, my fault.
I just noticed the mail not reply all. Loop all again.
