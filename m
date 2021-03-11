Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97C3369EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCKBxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCKBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:52:53 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF21C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:52:51 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bm21so42914583ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QB223bp1Em333GDTsTwQxut+5emCQUk41ySuZ8lYHAE=;
        b=0OYveGf86C+r/sdX0HC+/3/RiOVvrtXNqI+AmOQQ1OK5Upm360KO8UBgkuDumsmE9r
         qa5zv21/Vj/ZJRbDbvWLRwjxW4KG+81UKLHeQAtQt/K4KBbC1sNvrV0r222i1Nrs5jFb
         XE2D05GWJ1l0kppMlHgH5KHNFYW15GmSQ8uMNURDFwwkzYKsPQIIKEXPrxBD82Q+cSxC
         nvgbcf6rGICIe4hGw3DU4I7xwhTqX7HZIRS06uZjK7m5kOkanyyO+S+eZHWbDm8hxNyE
         u4rVL1geDQdDXlDEfpuv7TU2fBpN47+56frbhNulAxn4hBs7qnIZCjB0te+d0/N0bTtw
         Lt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QB223bp1Em333GDTsTwQxut+5emCQUk41ySuZ8lYHAE=;
        b=rrnAJwDokque4fV6BaiUnyylOrq65JGEgScjk3uISk5BtofR8QL3M5/DiO71oS84rr
         jeMpH/wxdfND9wXoLsPn7ExFsQcoP2ZYgAZnjRzcFvFDmKHT1+7qhlR9M7GL5Upiz15N
         l2o9yydDvyiXJp9JA14ApYa61m9Zmhjh2DzJmaXpUqhK6HVkzcBxxmHHbxv+OggN3xmh
         2fwp4WFxfi35v3qNUyXzOks3/nxzcutHIvAIdZcHbaXySbFIeRkJtcziw6e0YOV6KamF
         D9J1LO50KM3jc5vZ3n2yqiFjDdoEdnvPNzJLY4UWpIB2ELnLBOAEDxpyN3HbPJ5HNUs4
         Livg==
X-Gm-Message-State: AOAM5302I1CYdjjrbifSfFCiaeTbV0JtkZDKKPlI8AQKn7/83Q7ABp6M
        0CaI+DOTQB1D5Vi/yjYakHUiHVHD0932Q/lrGX2qcw==
X-Google-Smtp-Source: ABdhPJwM9E9CqbfvXxPoIKdz6VLrM5ta6QNyhypWzaZANcUDgeMODn401RQk09cF1Hv4rRhXjiVJoF+GhaPv/kkrIMI=
X-Received: by 2002:a17:906:789:: with SMTP id l9mr709774ejc.161.1615427570161;
 Wed, 10 Mar 2021 17:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20210309220014.22205-1-tharvey@gateworks.com> <8ca5c54140d69307f3c08ca85a09f0b5@walle.cc>
In-Reply-To: <8ca5c54140d69307f3c08ca85a09f0b5@walle.cc>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 10 Mar 2021 17:52:38 -0800
Message-ID: <CAJ+vNU3_q_kmZKrr0V5_1zgDSWrSneL0nBJhch33Ku0xRqC5Ug@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: at25: add Fujitsu MB85RS4MT
To:     Michael Walle <michael@walle.cc>
Cc:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 2:59 PM Michael Walle <michael@walle.cc> wrote:
>
> Hi Tim,
>
> Am 2021-03-09 23:00, schrieb Tim Harvey:
> > Document the compatible value for the Fujitsu MB85RS4MT SPI
> > FRAM EEPROM device so that it can be used in DTS files.
> >
> > This is a 512KiB FRAM EEPROM.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml
> > b/Documentation/devicetree/bindings/eeprom/at25.yaml
> > index 6a2dc8b3ed14..f594db72b711 100644
> > --- a/Documentation/devicetree/bindings/eeprom/at25.yaml
> > +++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
> > @@ -26,6 +26,7 @@ properties:
> >                - anvo,anv32e61w
> >                - atmel,at25256B
> >                - fujitsu,mb85rs1mt
> > +              - fujitsu,mb85rs4mt
> >                - fujitsu,mb85rs64
> >                - microchip,at25160bn
> >                - microchip,25lc040
>
> Hm, the driver is spi-nor but this is for the at25 driver. Is
> this correct? Doesn't it work if you just add the ID to
> spi-nor/fujitsu.c and use 'compatible = "jedec,spi-nor' ?
>

Michael,

Yes it works just fine as 'compatible = "jedec,spi-nor"' and that
makes sense. I'll drop this patch and update my device-tree
accordingly.

Thanks,

Tim
