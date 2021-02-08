Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30A312B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhBHIAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:00:11 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:65131 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhBHIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612771204; x=1644307204;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z+w7Mvvg6cUtm7ma3xZyXbJcjOiFh98Ub1LCtlB9I0g=;
  b=R3QwRI4tT5xPozXhMMVnlRanBssi0U5aJejxaOpydqUx3rfiIrpIUq9K
   mTnhxjegi1rLuX/9YwHrybP+JqD9ii5505Gsj8LUN+h/XDNBqx9DbaInx
   pyksHjIAMITN0SB415/zuwY560+NBcvdbTOcO9RKFE4r7xMweVaxx3NbA
   LQazpJOWUYQVo/DALa45Dr/jYwyCUE8Yi+3EjIQ1gfeMiGNhjN/q/KIIP
   5zFip5Mqxamft4Ss0QY8GAx6yPyjp59IhyFbuTxFav/7hgNh37yrd4NhF
   GwLDsOuxHqSktouK1vtmbOFcIeLyt9Wr/VHPsknmBHWe3ECgOOI34EmvR
   Q==;
IronPort-SDR: 3R5QdFTRqJQ1gDxGnjeDcTAQgig8r0JNc8C5/xdHrp6Lam+gW2wDgdVEuiq2xdwPoc7hjAOFBf
 Yet1T77N+alC+S/0oltATEDO2sMmMJBPRrsQ05p6PfO8IwCtbxkZ+kaBYRWWT/lvVYaogftOKS
 U9V4/OdEA6Sx/geUkXUePgaPpTnVIPK9p3jPf8Q5ZHhDsTlsFAWf+Rrc5FChGEYTAbTYoJ+WkA
 Uy567tlf6LT6eVOI1BouhCMsCNXy+ad7NdE5LyeofbUGAGWkcq48f4wIJK6CGZXs43MH5Ks61x
 10k=
X-IronPort-AV: E=Sophos;i="5.81,161,1610434800"; 
   d="scan'208";a="108874727"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2021 00:58:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 00:58:42 -0700
Received: from tyr.hegelund-hansen.dk (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 8 Feb 2021 00:58:40 -0700
Message-ID: <c92626b109dacc133a38036bfdea8876b8963603.camel@microchip.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: reset: add microchip sparx5 switch
 reset driver
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Date:   Mon, 8 Feb 2021 08:58:40 +0100
In-Reply-To: <20210205223526.GA3869001@robh.at.kernel.org>
References: <20210120081921.3315847-1-steen.hegelund@microchip.com>
         <20210120081921.3315847-4-steen.hegelund@microchip.com>
         <20210205223526.GA3869001@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 2021-02-05 at 16:35 -0600, Rob Herring wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
> 
> On Wed, Jan 20, 2021 at 09:19:21AM +0100, Steen Hegelund wrote:
> > This provides reset driver support for the Microchip Sparx5 PCB134
> > and
> > PCB135 reference boards.
> 
> This isn't a compatible change. You need an explanation why that's
> okay
> if that's intended.
> 
> > 
> > Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> > ---
> >  arch/arm64/boot/dts/microchip/sparx5.dtsi | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > index 380281f312d8..4edbb9fcdce0 100644
> > --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > @@ -132,9 +132,17 @@ mux: mux-controller {
> >                       };
> >               };
> > 
> > -             reset@611010008 {
> > -                     compatible = "microchip,sparx5-chip-reset";
> > -                     reg = <0x6 0x11010008 0x4>;
> > +             gcb_ctrl: syscon@611010000 {
> > +                     compatible = "microchip,sparx5-gcb-syscon",
> > "syscon";
> > +                     reg = <0x6 0x11010000 0x10000>;
> > +             };
> > +
> > +             reset: reset-controller@0 {
> > +                     compatible = "microchip,sparx5-switch-reset";
> > +                     reg = <0x6 0x0 0x0>;
> 
> Your register length is 0?

Yes, I only use the syscons.

> 
> > +                     #reset-cells = <1>;
> > +                     cpu-syscon = <&cpu_ctrl>;
> 
> Can't you accomplish the same thing adding these to
> "microchip,sparx5-chip-reset"? Or possibly as a child node.
> 
> Define nodes based on h/w blocks, not as containers of things you
> happen
> to want for some driver.

Yes - I think the idea of using syscons came from another reset driver,
but it probably makes more sense to just use IO ranges directly.
I will try that out.

> 
> > +                     gcb-syscon = <&gcb_ctrl>;
> >               };
> > 
> >               uart0: serial@600100000 {
> > --
> > 2.29.2
> > 

Thanks for your comments

BR
Steen


