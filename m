Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58B339DCE8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFGMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFGMu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:50:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB223C061766;
        Mon,  7 Jun 2021 05:48:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n12so19044815lft.10;
        Mon, 07 Jun 2021 05:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqSp7b2sF5G/FF6lZynv4Wa2NCgdSNo+g2maX/I5cg4=;
        b=pozxQO3Soc1f0c4FqsKQO2eA/CLdqPKeeIYIWArpk+9A/mym4x8dN7I/j5gGR3eWCA
         7+niI5ea+m1cgiXG0rITWVXWlhi9wqIwR+uOMaiyxnAfQVLMmTDlFWNofOaOGNuCaAr3
         0PuONwtNf++K6/Ic1rzwBZAHCCUg2yLTaXm4NYBCHfWWt3mggPqlZECDyQFqLHXGKVTL
         d6IPcVNbhsAGTPFqoD1oUBIZPh2wVxlsLsANH2szOnVKDKbA8vyDlHwfKWAtlfme1sMJ
         7LKj4LtX+sYYRL8oQosg4JYmqzo7x4HS2NBKfP7DfECNN2fg9VKQoiEw9uXxyFKOFMdS
         zFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqSp7b2sF5G/FF6lZynv4Wa2NCgdSNo+g2maX/I5cg4=;
        b=kk+eWdI4jtOLTKQcyNpjJAYJwWcYn7K/xvwYtnZrnmhhpix6ICHEYkMiUw81aysT43
         jRIHWvGYL2DFMqrHaOzRZ6bg2IG28jSV585puFuJXgsfxK5coA0UOUuCWohWlO/vhB3p
         QgSVNdLbG91kW71m2wvF83JbF+6IJ6s0OiMZxMImmFdodXPVUdfer8ILv3Yd8RR5PMZ9
         Ds5QA365+8tXny4TLsK3hD8vyAuYhoygUpghYBBlnkT3tzW5QIhxUge6sJq2sc8BMreI
         h1ZYThBupYqtIqtT5lSLvokzLLDhGJ+8PI1ROOUWKjgbg3/iMI9PXlodIVRfTybmRBvJ
         CrdA==
X-Gm-Message-State: AOAM532xXO92Ep4vsrT4KtpZc5p2mhCSHIiwmrFlhoIFLuNqNM7/m0mv
        SJyxi15VSidIwybjq5Vwx9qShEJctpsKAYZUvLMj29oeqk3q3rXA
X-Google-Smtp-Source: ABdhPJwabZWyYF88pXBQ24zGo/RXBDrYpovZ3Uck29FJ5jy9VhDjT86KbW2/5rSd+najOgm/CPFmNxVbSw0A8REqkr4=
X-Received: by 2002:a19:3846:: with SMTP id d6mr12512848lfj.187.1623070127020;
 Mon, 07 Jun 2021 05:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210607081727.4723-1-cnsztl@gmail.com> <CAGb2v66GAOtF40o5XoK_K3bWPa2L8jGxH=R-YK8060TGeAKreQ@mail.gmail.com>
In-Reply-To: <CAGb2v66GAOtF40o5XoK_K3bWPa2L8jGxH=R-YK8060TGeAKreQ@mail.gmail.com>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Mon, 7 Jun 2021 20:48:34 +0800
Message-ID: <CAOP2_TiZYXWnDZ1-_K-EvHt3-=sV1k8cRaenW8xqr44KdLCQiw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Marty Jones <mj8263788@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Mon, Jun 7, 2021 at 4:36 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> Hi,
>
> On Mon, Jun 7, 2021 at 4:19 PM Tianling Shen <cnsztl@gmail.com> wrote:
> >
> > NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
> > stores the MAC address.
> >
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > index cef4d18b599d..4a82f50a07c5 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > @@ -68,6 +68,15 @@
> >         status = "disabled";
> >  };
> >
> > +&i2c2 {
> > +       eeprom@51 {
> > +               compatible = "microchip,24c02", "atmel,24c02";
>
> The actual part number is Microchip 24AA025E48, but I don't think
> the way this device splits its storage area is easy to support
> without additional modifications to the driver.
>

On the face of it, it seems to work fine, and I can read the data correctly.
(built with at24 eeprom driver)

Thanks,
Tianling.

> > +               reg = <0x51>;
> > +               pagesize = <16>;
> > +               read-only; /* This holds our MAC */
>
> Please also add the size, as well as a cell defining the offset
> and length to the MAC address. The gmac node can then reference
> this with:
>
>     nvmem-cells = <&mac_address>;
>     nvmem-cells-names = "mac-address";
>
> which will actually pick up the MAC address.
>
>
> Regards
> ChenYu
>
> > +       };
> > +};
> > +
> >  &i2c4 {
> >         status = "disabled";
> >  };
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
