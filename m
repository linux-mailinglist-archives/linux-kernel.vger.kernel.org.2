Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAFA45E108
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356437AbhKYTfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 14:35:42 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47052 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243479AbhKYTdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:33:41 -0500
Received: from ip5f5b2004.dynamic.kabel-deutschland.de ([95.91.32.4] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mqKRs-0005mw-Ts; Thu, 25 Nov 2021 20:30:24 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rk356x: Add HDMI audio nodes
Date:   Thu, 25 Nov 2021 20:30:24 +0100
Message-ID: <4335378.eiKhv840gI@diego>
In-Reply-To: <08774d87-97e0-6afa-2816-bf78949e4e68@gmail.com>
References: <20211125100836.423808-1-frattaroli.nicolas@gmail.com> <20211125100836.423808-2-frattaroli.nicolas@gmail.com> <08774d87-97e0-6afa-2816-bf78949e4e68@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 25. November 2021, 20:07:21 CET schrieb Johan Jonker:
> Hi Nicolas,
> 
> Some comments...
> 
> On 11/25/21 11:08 AM, Nicolas Frattaroli wrote:
> > This adds the i2s0 node and an hdmi-sound sound device to the
> > rk356x device tree. On the rk356[68], the i2s0 controller is
> > connected to HDMI audio.
> > 
> > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 32 ++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > index 3c09cf6d4c37..ad4053402eef 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > @@ -614,6 +614,21 @@ hdmi_in_vp2: endpoint@2 {
> >  		};
> >  	};
> >  
> 
> > +	hdmi_sound: hdmi-sound {
> 
> Some DT sort rules:
> 
> For nodes:
> Sort things without reg alphabetical first,
> then sort the rest by reg address.
> 
> > +		compatible = "simple-audio-card";
> 
> simple-audio-card,name = "HDMI";
> 
> > +		simple-audio-card,format = "i2s";
> > +		simple-audio-card,mclk-fs = <256>;
> 
> > +		simple-audio-card,name = "hdmi-sound";
> 
> Exceptions:
> Sort simple-audio-card,name above other simple-audio-card properties.
> 
> Shouldn't we standardize to SPDIF, HDMI and Analog similar to rk3318/rk3328?
> Make a shorter label without spaces or special chars, so that chars
> don't get removed?
> See "aplay -l" screen print.
> 
> Maybe rename to "HDMI"?
> 
> > +		status = "disabled";
> > +
> > +		simple-audio-card,cpu {
> > +			sound-dai = <&i2s0_8ch>;
> > +		};
> 
> Add empty line between nodes.
> 
> Not sure if Heiko cares, but when alphabetical sort I get this:
> simple-audio-card,codec
> simple-audio-card,cpu

Hehe ... I do care, but would normally just (silently) re-sort these
things when applying ;-) .


Heiko


> > +		simple-audio-card,codec {
> > +			sound-dai = <&hdmi>;
> > +		};
> > +	};
> > +
> >  	qos_gpu: qos@fe128000 {
> >  		compatible = "rockchip,rk3568-qos", "syscon";
> >  		reg = <0x0 0xfe128000 0x0 0x20>;
> > @@ -789,6 +804,23 @@ spdif: spdif@fe460000 {
> >  		status = "disabled";
> >  	};
> >  
> > +	i2s0_8ch: i2s@fe400000 {
> > +		compatible = "rockchip,rk3568-i2s-tdm";
> > +		reg = <0x0 0xfe400000 0x0 0x1000>;
> > +		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > +		assigned-clocks = <&cru CLK_I2S0_8CH_TX_SRC>, <&cru CLK_I2S0_8CH_RX_SRC>;
> > +		assigned-clock-rates = <1188000000>, <1188000000>;
> > +		clocks = <&cru MCLK_I2S0_8CH_TX>, <&cru MCLK_I2S0_8CH_RX>, <&cru HCLK_I2S0_8CH>;
> > +		clock-names = "mclk_tx", "mclk_rx", "hclk";
> > +		dmas = <&dmac1 0>;
> > +		dma-names = "tx";
> > +		resets = <&cru SRST_M_I2S0_8CH_TX>, <&cru SRST_M_I2S0_8CH_RX>;
> > +		reset-names = "tx-m", "rx-m";
> > +		rockchip,grf = <&grf>;
> > +		#sound-dai-cells = <0>;
> > +		status = "disabled";
> > +	};
> > +
> >  	i2s1_8ch: i2s@fe410000 {
> >  		compatible = "rockchip,rk3568-i2s-tdm";
> >  		reg = <0x0 0xfe410000 0x0 0x1000>;
> > 
> 




