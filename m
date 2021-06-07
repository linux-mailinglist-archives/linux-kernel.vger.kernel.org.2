Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0039D8F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFGJmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGJmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:42:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28AA461130;
        Mon,  7 Jun 2021 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623058820;
        bh=dMkA7yzKDAeneap0OuN2Vstxla6Z28FLe6DXYuZEa04=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=uGT5UbIFKs0CskDKD4TxNsCUBNZylywLGUDNrTLHk6c2D0WnTGwB6DjJmk8AXCISu
         PWpLoU7Ull6mcducoMHM+YSQu45MIDWQpMNF5ygDaHMp8vuqybZj/LXq/cAiUMasUe
         yS4Vo+42QouyL3I5ZacGxF3uiYXDycRF/YglKUi8Nnt3a+ATluPfTbbat0YDXEqGfS
         fmkInv73TTzj1D2B8eOYEP/dpoII59MMFrH15RlwQQzIwmK8mjrx77bdlNT2RVLoJC
         Q1abQPA04R1oYpP/4Rj7le/p00JFiFcHyj1RrXWSQ+Xyiel6AmZHOYYnNtnjI1/2Y4
         0FwnCRQMh70kw==
Received: by mail-lj1-f170.google.com with SMTP id u18so1111089lju.12;
        Mon, 07 Jun 2021 02:40:20 -0700 (PDT)
X-Gm-Message-State: AOAM532h5+X0ZsLrpOhFN96mHR51daj4KubBTro+v0Yn2xdq4E7FapYV
        MkzsfqvJw7L8wnJbdvmJNmPRkBc2s1sUQ13dF5I=
X-Google-Smtp-Source: ABdhPJwtnCxXRODVLvwSZYHacPCSYfKjqwYa1aRIPYbWYZ28HuJpG9cpmfbQQr1W0d32g/V56ITtxAED2434k/gmzUo=
X-Received: by 2002:a2e:a717:: with SMTP id s23mr13994339lje.282.1623058818373;
 Mon, 07 Jun 2021 02:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210607081727.4723-1-cnsztl@gmail.com> <9258ab23-ef65-2c3d-f0d2-ca5f77d7c12a@gmail.com>
In-Reply-To: <9258ab23-ef65-2c3d-f0d2-ca5f77d7c12a@gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 7 Jun 2021 17:40:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v65ck=LV+UCdQoaUtEjFaTaHr9-wmGmpkCCkebUOuYtikw@mail.gmail.com>
Message-ID: <CAGb2v65ck=LV+UCdQoaUtEjFaTaHr9-wmGmpkCCkebUOuYtikw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marty Jones <mj8263788@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 5:31 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Tianling,
>
> On 6/7/21 10:17 AM, Tianling Shen wrote:
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
> >       status = "disabled";
> >  };
> >
> > +&i2c2 {
> > +     eeprom@51 {
> > +             compatible = "microchip,24c02", "atmel,24c02";
> > +             reg = <0x51>;
> > +             pagesize = <16>;
>
> > +             read-only; /* This holds our MAC */
>
> The mainline dts files should be generic I think.
> Any comment about "use", partitions or write ability should be avoided.
> It's up the user.

Per the datasheet for this specific EEPROM, the latter half (128 bytes)
is read-only in hardware by design though.

ChenYu
