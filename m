Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A876341F626
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354690AbhJAUKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:10:05 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:38870 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhJAUKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:10:04 -0400
Received: by mail-qk1-f170.google.com with SMTP id q81so10367378qke.5;
        Fri, 01 Oct 2021 13:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQlSEZZ+M9EHNYuoq+CO7QYaIkckaY1yCBN43D3/TuI=;
        b=34X1tSlk6SQVCRvE7SybF7rgdvJK/HitNO9wefDV4AoKE3OeY19ntuwiYUdbdrCaFg
         PNyifzcqTZPtUeM4Zuhw72JeK8JrHxryhYhXrrv4BmVZqiL65zauPqekSKIisQsyyqL4
         FC83wLlag4ZnhDH99Wilb4iEaCykiy7fJquGNX0YmEwW+XJPG0zAoAB8ZqQWec/IgmCz
         OnsgcuYOdRbHlgFvA2rWLxvSfGVp2VZh8JcRAFfcPmkzQ0zpBhHtPmin5h3NLpPc/gMV
         quy6pglz0egmevPMLJQ6uI4ckTWzhflLE6boHSABAjy27eHqua+lpBof0Yz2SBgKSVdF
         UEPA==
X-Gm-Message-State: AOAM531ZPUW9M2rwdi+vaaPccfHCV5on7+dOBV6MmmKlXCKbxPTIqCpN
        50Ko1jsKSbPkUj83DIJy+6R2u/qATFw=
X-Google-Smtp-Source: ABdhPJy96jyiQUtuC4jk63wYlX0eX6mVYq9VG3nkjLeeipINWSIYDzjgH2oVpfrWPTsyRPjLuZlfCQ==
X-Received: by 2002:a37:66d6:: with SMTP id a205mr11275641qkc.138.1633118898545;
        Fri, 01 Oct 2021 13:08:18 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id k19sm3884284qko.115.2021.10.01.13.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 13:08:17 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id a14so6287010qvb.6;
        Fri, 01 Oct 2021 13:08:17 -0700 (PDT)
X-Received: by 2002:a05:6214:36d:: with SMTP id t13mr11022398qvu.50.1633118897756;
 Fri, 01 Oct 2021 13:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000417.15334-1-leoyang.li@nxp.com> <20211001000417.15334-5-leoyang.li@nxp.com>
 <AS8PR04MB86734729E9E08F70FF7E5AEEE0AB9@AS8PR04MB8673.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86734729E9E08F70FF7E5AEEE0AB9@AS8PR04MB8673.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 1 Oct 2021 15:08:05 -0500
X-Gmail-Original-Message-ID: <CADRPPNTKsO7MYoUUXLgC+XnPPsrzjeBggvRnKvaB=3HUJy9-1A@mail.gmail.com>
Message-ID: <CADRPPNTKsO7MYoUUXLgC+XnPPsrzjeBggvRnKvaB=3HUJy9-1A@mail.gmail.com>
Subject: Re: [EXT] [PATCH v2 04/16] ARM: dts: ls1021a-qds: Add node for QSPI flash
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 12:30 AM Kuldeep Singh <kuldeep.singh@nxp.com> wrote:
>
> Hi Leo,
>
> > -----Original Message-----
> > From: Li Yang <leoyang.li@nxp.com>
> > Sent: Friday, October 1, 2021 5:34 AM
> > To: Shawn Guo <shawnguo@kernel.org>; Rob Herring
> > <robh+dt@kernel.org>; devicetree@vger.kernel.org; Oleksij Rempel
> > <linux@rempel-privat.de>; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org
> > Cc: Leo Li <leoyang.li@nxp.com>
> > Subject: [EXT] [PATCH v2 04/16] ARM: dts: ls1021a-qds: Add node for QSPI
> > flash
> >
> > Caution: EXT Email
> >
> > Add the missing node for qspi flash.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  arch/arm/boot/dts/ls1021a-qds.dts | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/ls1021a-qds.dts
> > b/arch/arm/boot/dts/ls1021a-qds.dts
> > index e2aa569ff404..522e1dc51059 100644
> > --- a/arch/arm/boot/dts/ls1021a-qds.dts
> > +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> > @@ -286,6 +286,21 @@ tbi0: tbi-phy@8 {
> >         };
> >  };
> >
> > +&qspi {
> > +       num-cs = <2>;
>
> Please drop "num-cs" property as it is not used by qspi driver.
>
> > +       status = "okay";
> > +
> > +       qflash0: flash@0 {
>
> Can we have flash chip name instead of qflash?
> There is no hard requirement, it will help in aligning node properties with other board properties such as LX2160A-RDB, LS1046A-RDB etc.

Thanks for the review.  I find that there is no reference to the label
at all.  I don't know why we added it in the first place.  Probably we
can just remove it?

>
> With above fixed,
> Reviewed-by: Kuldeep Singh <kuldeep.singh@nxp.com>
>
> > +               compatible = "jedec,spi-nor";
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               spi-max-frequency = <20000000>;
> > +               reg = <0>;
> > +               spi-rx-bus-width = <4>;
> > +               spi-tx-bus-width = <4>;
> > +       };
> > +};
> > +
> >  &sai2 {
> >         status = "okay";
> >  };
> > --
> > 2.25.1
>
