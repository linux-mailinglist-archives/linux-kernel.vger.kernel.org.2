Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0041B34F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241699AbhI1Pvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbhI1Pvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:51:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E595C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:50:06 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r75so27987967iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wxYuy78GSwnBdZScF5Az+aCcxt1YS2AWU5xnG/nVgEk=;
        b=F6fY0qbhuT1hJI5Z/ipCwh0MerMWZ3dQ24GXGYOIK9M6LWFnGkLLywiqooiTeefo4p
         x5FJFoT03LXDWs+BoLRYGVze3wbt+RwkygMIlbRdQBEceHX6HoCxrFxnVZlzNQcPjlGa
         W6MUwh7yoxZ/EPuJoVGZHDTCAgrQPKM/EJ9g94MOEwP9iqzpMtj+vRZGgDxXU8MpC8JA
         MUVoVBS0GwbyBl/vpvyhhuo9k5WI+awyWXSrbEcdi14xF71YWae67JaweH2eiuqB4faJ
         cWzfTRsRwg/IluAFSjA/wEoSu803gubeD6BRfOnOqz5WGku6U/h5Tic99zb2Wog6LuLv
         Rd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wxYuy78GSwnBdZScF5Az+aCcxt1YS2AWU5xnG/nVgEk=;
        b=UUcpQ4/Ve/qLiE3t6/0IMaHfg6MWpR5pJPXmejHV8NKRURJk9fC4/kEfIrcH/fWijh
         u0FV3BVE/Js7Gzm4pkha1B4HQMiSkiFnBiFCVAfh/+yCxp32U4qR65xtbWZtAFNntQ2x
         lnTgbuzKs6GtEpqy8vHFjbY1jH72Y1vv3AXXMa39Rftbq3AhUWxv2ac1GvpOJ/BozX+r
         dRP/6RVIAofIN9Su3p0OvAavFp89CG9FZLscJvS8Uice1NegqGWISS004JEsrdPlebhT
         VUmYRPEhVebxw8fu7KFkSTJp1bwENRaUjBkx/fnHY2vOgMYZ73c7vQ3F99Vtf4JTy9xr
         sKAA==
X-Gm-Message-State: AOAM531AzuDtR/uzu+Egpk3oIFKhkzGQelaSBh9fZqQcmKnlTqtE6Gay
        4+PF5RF/w7IOMrHmTWY0GZyH9dn7mPHyaRZ6ZEP8sw==
X-Google-Smtp-Source: ABdhPJxqdEdu5RZ13HY1bsoM2w/abN75sG5289NlyZf1hcDlHxgjEaOCj73OMj6whGUTqyBmiCT0HQ9+k+bDnAUhZio=
X-Received: by 2002:a05:6638:24c4:: with SMTP id y4mr5111355jat.31.1632844205978;
 Tue, 28 Sep 2021 08:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210927154159.2168500-1-robert.marko@sartura.hr> <20210928151348.cqgy6uuxs3owxaug@pali>
In-Reply-To: <20210928151348.cqgy6uuxs3owxaug@pali>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 28 Sep 2021 17:49:55 +0200
Message-ID: <CA+HBbNGVMCEGnh9u9nkceRrsYkM6BNL4k0PA=i7eT7xs9GAM2g@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: marvell: espressobin-ultra: enable UART
 output by default
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 5:13 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 27 September 2021 17:41:56 Robert Marko wrote:
> > Since Espressobin Ultra board has a microUSB port
> > with the onboard USB to UART connected to it to be
> > used as a debug UART it makes no sense to require
> > the bootloader to pass console args to the kernel in
> > order to get console working.
> >
> > So, use the "stdout-path" property to enable the UART
> > output on the microUSB port by default.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.=
dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > index c5eb3604dd5b..c1770ceff3c1 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > @@ -15,6 +15,10 @@ / {
> >       compatible =3D "globalscale,espressobin-ultra", "marvell,armada37=
20",
> >                    "marvell,armada3710";
> >
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +
>
> This code is duplication of common espressobin code from
> armada-3720-espressobin.dtsi file:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi

Ahh yes, I don't know why was it not working by default then.
Sorry for the noise, I will drop this patch.

Regards,
Robert
>
> >       aliases {
> >               /* ethernet1 is WAN port */
> >               ethernet1 =3D &switch0port5;
> > --
> > 2.31.1
> >



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
