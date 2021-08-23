Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA84D3F52C0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhHWVVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 17:21:09 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54948 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232921AbhHWVU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:20:58 -0400
Received: from p5b036204.dip0.t-ipconnect.de ([91.3.98.4] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mIHMW-0002ta-Ce; Mon, 23 Aug 2021 23:20:08 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix GPU register width for RK3328
Date:   Mon, 23 Aug 2021 23:20:04 +0200
Message-ID: <7657417.31r3eYUQgx@phil>
In-Reply-To: <c586d864-994f-2d24-9b29-2933b567be84@gmail.com>
References: <20210623115926.164861-1-knaerzche@gmail.com> <c586d864-994f-2d24-9b29-2933b567be84@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Am Montag, 23. August 2021, 00:19:08 CEST schrieb Alex Bee:
> Hi Heiko,
> 
> is there anything left to do for this one?

nope, there wasn't anything missing, I just somehow managed to overlook
the patch till your ping. As you can see from the other mail, it is
applied now :-)

Heiko

> 
> Same for:
> 
> https://patchwork.kernel.org/project/linux-rockchip/patch/20210623145918.187018-1-knaerzche@gmail.com/
> 
> and
> 
> https://patchwork.kernel.org/project/linux-rockchip/patch/20210623150208.187201-1-knaerzche@gmail.com/
> 
> Alex
> 
> Am 23.06.21 um 13:59 schrieb Alex Bee:
> > As can be seen in RK3328's TRM the register range for the GPU is
> > 0xff300000 to 0xff330000.
> > It would (and does in vendor kernel) overlap with the registers of
> > the HEVC encoder (node/driver do not exist yet in upstream kernel).
> > See already existing h265e_mmu node.
> >
> > Fixes: 752fbc0c8da7 ("arm64: dts: rockchip: add rk3328 mali gpu node")
> > Signed-off-by: Alex Bee <knaerzche@gmail.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > index 8c821acb21ff..da84be6f4715 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > @@ -599,7 +599,7 @@ saradc: adc@ff280000 {
> >   
> >   	gpu: gpu@ff300000 {
> >   		compatible = "rockchip,rk3328-mali", "arm,mali-450";
> > -		reg = <0x0 0xff300000 0x0 0x40000>;
> > +		reg = <0x0 0xff300000 0x0 0x30000>;
> >   		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> >   			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> >   			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
> 




