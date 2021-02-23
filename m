Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90C32291D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhBWK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:56:05 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57504 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhBWKzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:55:16 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lEVKp-0000KT-FJ; Tue, 23 Feb 2021 11:54:31 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>, sboyd@kernel.org,
        Johan Jonker <jbx6244@gmail.com>
Cc:     huangtao@rock-chips.com, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        cl@rock-chips.com
Subject: Re: [PATCH v1 1/4] dt-bindings: add bindings for rk3568 clock controller
Date:   Tue, 23 Feb 2021 11:54:30 +0100
Message-ID: <6385562.anssfa2V6d@diego>
In-Reply-To: <eb82f0a4-ca89-d1bc-5660-49bd05b7fc50@gmail.com>
References: <20210223095352.11544-1-zhangqing@rock-chips.com> <20210223095352.11544-2-zhangqing@rock-chips.com> <eb82f0a4-ca89-d1bc-5660-49bd05b7fc50@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 23. Februar 2021, 11:50:25 CET schrieb Johan Jonker:
> Hi Elaine,
> 
> This is a new document.
> Could you convert rockchip,rk3568-cru.txt to yaml?

I'll definitly second that wish for a conversion to yaml.

Having the ability to check devicetrees for correctness is
quite helpful :-)


Heiko


> To get an acked-by you must include:
> 
> robh+dt@kernel.org
> devicetree@vger.kernel.org
> 
> ./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallback
> --nogit <patch>
> 
> Your patch should show up here after filtering:
> https://patchwork.ozlabs.org/project/devicetree-bindings/list/
> 
> Check with:
> 
> make ARCH=arm64 dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pinctrl/rockchip,rk3568-cru.yaml
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pinctrl/rockchip,rk3568-cru.yaml
> 
> ./scripts/checkpatch.pl --strict <patch>
> 
> 
> On 2/23/21 10:53 AM, Elaine Zhang wrote:
> > Add devicetree bindings for Rockchip cru which found on
> > Rockchip SoCs.
> > 
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > ---
> >  .../bindings/clock/rockchip,rk3568-cru.txt    | 66 +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.txt
> > new file mode 100644
> > index 000000000000..b1119aecb7c7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.txt
> > @@ -0,0 +1,66 @@
> > +* Rockchip RK3568 Clock and Reset Unit
> > +
> > +The RK3568 clock controller generates and supplies clock to various
> > +controllers within the SoC and also implements a reset controller for SoC
> > +peripherals.
> > +
> > +Required Properties:
> > +
> > +- compatible: PMU for CRU should be "rockchip,rk3568-pmucru"
> > +- compatible: CRU should be "rockchip,rk3568-cru"
> > +- reg: physical base address of the controller and length of memory mapped
> > +  region.
> > +- #clock-cells: should be 1.
> > +- #reset-cells: should be 1.
> > +
> > +Optional Properties:
> > +
> > +- rockchip,grf: phandle to the syscon managing the "general register files"
> > +  If missing, pll rates are not changeable, due to the missing pll lock status.
> > +
> > +Each clock is assigned an identifier and client nodes can use this identifier
> > +to specify the clock which they consume. All available clocks are defined as
> > +preprocessor macros in the dt-bindings/clock/rk3568-cru.h headers and can be
> > +used in device tree sources. Similar macros exist for the reset sources in
> > +these files.
> > +
> > +External clocks:
> > +
> > +There are several clocks that are generated outside the SoC. It is expected
> > +that they are defined using standard clock bindings with following
> > +clock-output-names:
> > + - "xin24m" - crystal input - required,
> > + - "xin32k" - rtc clock - optional,
> > + - "i2sx_mclkin" - external I2S clock - optional,
> > + - "xin_osc0_usbphyx_g" - external USBPHY clock - optional,
> > + - "xin_osc0_mipidsiphyx_g" - external MIPIDSIPHY clock - optional,
> > +
> > +Example: Clock controller node:
> > +
> > +	pmucru: clock-controller@fdd00000 {
> > +		compatible = "rockchip,rK3568-pmucru";
> > +		reg = <0x0 0xfdd00000 0x0 0x1000>;
> > +		#clock-cells = <1>;
> > +		#reset-cells = <1>;
> > +	};
> > +
> > +	cru: clock-controller@fdd20000 {
> > +		compatible = "rockchip,rK3568-cru";
> > +		reg = <0x0 0xfdd20000 0x0 0x1000>;
> > +		rockchip,grf = <&grf>;
> > +		#clock-cells = <1>;
> > +		#reset-cells = <1>;
> > +	};
> > +
> > +Example: UART controller node that consumes the clock generated by the clock
> > +  controller:
> > +
> > +	uart1: serial@fe650000 {
> > +		compatible = "rockchip,rK3568-uart", "snps,dw-apb-uart";
> > +		reg = <0x0 0xfe650000 0x0 0x100>;
> > +		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> > +		reg-shift = <2>;
> > +		reg-io-width = <4>;
> > +		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> > +		clock-names = "baudclk", "apb_pclk";
> > +	};
> > 
> 
> 




