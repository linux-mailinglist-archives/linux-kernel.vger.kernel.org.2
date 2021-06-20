Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883A03ADCE3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 06:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhFTEny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 00:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhFTEnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 00:43:52 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EC8C061574;
        Sat, 19 Jun 2021 21:41:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u11so9084763ljh.2;
        Sat, 19 Jun 2021 21:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQIafI1N7mjXxp3LAVwoSKl9w56iiYhETX/yM5Qkk24=;
        b=SVtK2CyTmyg1plwJNmyDeAbTqa3x5YAJ/WVA2TwgFQm9ZOIqdwtoclFf1yNjoMqz1a
         Gg+RWjOjUGQZeuD05pPi3Y5fHALGeU8ncWQ710CMfETDltN+052a8ZPeuQqRfN3vja0o
         zCMHGMqZ2YrFYYX3+bV/hjWyQ8EYK4EZWhlTAnCfJgAZWLJsBDcznTIRjebn0/vSyUwb
         G3ItxLleyLDe9aoviS/xLP+QOcMgAH68KStEPMytOhsayf/L0vns7TTznMokJeqppyWg
         OW4QYRmnOUWTvZKwf89mEqU4bcnsi8NnJZmBcbUQkEV+s0LIUQeDdIcoanjQ3tN4NzDP
         EoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQIafI1N7mjXxp3LAVwoSKl9w56iiYhETX/yM5Qkk24=;
        b=rmsBqs1Oji0Btlu+48Okom4SxpZ0Aem7/I4atSFwD/bQc9LRwmYyhk83IK8/HLQdWw
         7IblqrPpdwQP1dHnnFsgVFxAaJTkXdR/sV36Vx8iY8gFqgE5YNpWSjpIbbFbadmehF8p
         EBa5XL03e/d5qJdNCzWiNw2N55EqbPGWxJbOKruuhhLdgc7JNENkAGq5au/gYoso6RYd
         6KJe07BTqyRJZlUYfVqNp6NtVl/uSprg4QflaRZh/8w31NlGDp364GlzmbnoVIEC3gzP
         oFF81WVqw/Ns40VH01+34KgUiAd5leoXyzttNsXc0bgezCJkeCgw2Wgw/U7lpanAmvjC
         aupQ==
X-Gm-Message-State: AOAM532vm6Mk+eHY4CdYGemv9NpRKOQT/4cK+yNgppt3rgFWFQYe8PfG
        6opOcrdbevxzgDwlVnnrUCIKjvAK9MKkoNgt/B1909b6zc4=
X-Google-Smtp-Source: ABdhPJz22ETIbOAUVHSeyZDBJygZsTtsDcL2NDGUCUqCaojgtaGjtPMi66K3pjkpKBqnER1/ZArOrSaU6Y3KYllI0k4=
X-Received: by 2002:a05:651c:111:: with SMTP id a17mr16371960ljb.151.1624164095734;
 Sat, 19 Jun 2021 21:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210610091357.6780-1-cnsztl@gmail.com> <4448985.BddDVKsqQX@phil>
In-Reply-To: <4448985.BddDVKsqQX@phil>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Sun, 20 Jun 2021 12:41:23 +0800
Message-ID: <CAOP2_TgO98D5T8TfYNjKzD3cZR1Hcp9=RYS56_WKtta_GZ85-g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Sun, Jun 20, 2021 at 6:11 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Donnerstag, 10. Juni 2021, 11:13:57 CEST schrieb Tianling Shen:
> > NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
> > stores the MAC address.
> >
> > Changes in v2:
> > - Added the size of EEPROM
> > - Added `mac-address` cell to pass the MAC address to kernel
> > - Removed `read-only` property in EEPROM node
> >
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>
> this produces errors when building the dtb:
>   DTC     arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb
> ../arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts:84.4-22: Warning (reg_format): /i2c@ff120000/eeprom@51/mac-address@fa:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> ../arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts:83.31-85.5: Warning (avoid_default_addr_size): /i2c@ff120000/eeprom@51/mac-address@fa: Relying on default #address-cells value
> ../arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts:83.31-85.5: Warning (avoid_default_addr_size): /i2c@ff120000/eeprom@51/mac-address@fa: Relying on default #size-cells value
>
> in the eeprom node you'll need to define #address-cells and #size-cells
> for this to work.

Thanks for pointing this out, added in v3.

Thanks,
Tianling.

>
> Thanks
> Heiko
>
>
> > ---
> >  .../boot/dts/rockchip/rk3399-nanopi-r4s.dts    | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > index cef4d18b599d..50d3b11eb925 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > @@ -68,6 +68,24 @@
> >       status = "disabled";
> >  };
> >
> > +&gmac {
> > +     nvmem-cells = <&mac_address>;
> > +     nvmem-cells-names = "mac-address";
> > +};
> > +
> > +&i2c2 {
> > +     eeprom@51 {
> > +             compatible = "microchip,24c02", "atmel,24c02";
> > +             reg = <0x51>;
> > +             pagesize = <16>;
> > +             size = <256>;
> > +
> > +             mac_address: mac-address@fa {
> > +                     reg = <0xfa 0x06>;
> > +             };
> > +     };
> > +};
> > +
> >  &i2c4 {
> >       status = "disabled";
> >  };
> >
>
>
>
>
