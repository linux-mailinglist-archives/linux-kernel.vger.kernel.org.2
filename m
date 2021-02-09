Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D1F315C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhBJBnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:43:35 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41242 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234412AbhBIXwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:52:02 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l9cmX-0001IP-F6; Wed, 10 Feb 2021 00:50:57 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        robin.murphy@arm.com
Subject: Re: [PATCH 2/5] ARM: dts: rockchip: assign a fixed index to mmc devices on rv1108 boards
Date:   Wed, 10 Feb 2021 00:50:56 +0100
Message-ID: <6598201.ejJDZkT8p0@diego>
In-Reply-To: <CAK8P3a3_uO23Y0tyfdh26tmCVcyp6XM+ur0WUd4khGUoBb32Hw@mail.gmail.com>
References: <20210118155242.7172-1-jbx6244@gmail.com> <20210118155242.7172-2-jbx6244@gmail.com> <CAK8P3a3_uO23Y0tyfdh26tmCVcyp6XM+ur0WUd4khGUoBb32Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. Februar 2021, 23:25:40 CET schrieb Arnd Bergmann:
> On Mon, Jan 18, 2021 at 4:52 PM Johan Jonker <jbx6244@gmail.com> wrote:
> >
> > Recently introduced async probe on mmc devices can shuffle block IDs.
> > Pin them to fixed values to ease booting in environments where UUIDs are
> > not practical. Use newly introduced aliases for mmcblk devices from [1].
> > The sort order is based on reg address.
> >
> > [1] https://patchwork.kernel.org/patch/11747669/
> 
> I just saw this in the pull request:
> 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  arch/arm/boot/dts/rv1108.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> > index bec47e0be..a754851f4 100644
> > --- a/arch/arm/boot/dts/rv1108.dtsi
> > +++ b/arch/arm/boot/dts/rv1108.dtsi
> > @@ -19,6 +19,9 @@
> >                 i2c1 = &i2c1;
> >                 i2c2 = &i2c2;
> >                 i2c3 = &i2c3;
> > +               mmc0 = &emmc;
> > +               mmc1 = &sdio;
> > +               mmc2 = &sdmmc;
> >                 serial0 = &uart0;
> >                 serial1 = &uart1;
> >                 serial2 = &uart2;
> 
> Please don't put these aliases into a .dtsi file, as not every board
> will provide each instance. The entire point of the aliases is to
> have sane enumeration, so you should start at index 0 for the
> first one that is actually present and count up from there.

Hmm, right now I don't see the disadvantage of missing mmc numbers.
As similarly we count i2c and serial numbers for a long time, even though
not all of them appear on every board.

Especially as the main goal is to simply have stable numbers and
not having the mmc devices swap numbers on every boot.

So right now we're not using them from a userspace POV but
instead agreed on following the address ordering of the soc.
so when ordering mmc controllers by their io-address, mmc0
is the first one, then mmc1, etc.

So just for my understanding, what is different for mmc?
I guess to guarantee ongoing numbering similar to sd{a,b,c,...}
Or should all aliases be duplicted in each board dts and not
live in any soc dtsi?


Heiko


> I would suggest you move these aliases into the .dts files for
> the existing boards for the next cycle, and then make sure
> only the ones that are present have an alias.
> 
> It might actually be a good idea to have a warning in dtc when
> there is an alias pointing to a status="disabled" device, but I
> suspect there would be a lot of fallout from that.
> 
>       Arnd
> 




