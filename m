Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644BD31332F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhBHNYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:24:13 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:2467 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhBHNV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612790515; x=1644326515;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W2BjzWC9BaQTxGCPoKiQkeBSQA14Mx/turUvBnd088Y=;
  b=mKd8QQpAmV07GSZIFx/uq4tRQR68pai69yjsthVyV6CbC/cnf8Cjh0tI
   HZBKuusFgRobVimY10uuPT/sxcPLAPJJToRhKiGq0e3abdTh0iueeLDEs
   awpy18xDD2/0hx4DTtlWDAXTnHS8JCCj5L4sPVqSSi22IVXXErFaBrBPP
   vULcRXSTWuGqwSRx1eE4Zg1+PzOsyDR7lXKAckWHpbpASMsC/nfiWgb2w
   iiG6vSSeHa8DP7lmu9Z0Mm2+nY2ieva7PETY2UFa/FzP1mpjO8wOy3N2a
   wvkveb0fMWuLfL78L0KNigQbNPpXw2T5/n3HU+qAMArQQqqcs3MGUd+gJ
   w==;
IronPort-SDR: zaROYwu4Tjud2qRYhndUwY9GbH0xUA6x+FYIZCpTrOJT3y9ZHwuTbLo+LQXPfzOp6iTP3OhM/8
 PoobNIqEGCbktQFiduKH7Ff0u2NY0qA0dL6eWIL+4SMdC4AmTmvgy3rRvatoRWeu3VFU+X9897
 CQZcFUiSDiZspB2vX1F3rC5lTqq46Cukj+FJTy245+IESXqYJ8CaWrTHcuP2G1GQ8XfO1frE0n
 5ua8ldCv7UwU3HFRrQBAF0OYjTxhggj9MvAzMHUoGFWVMvumPnDNtjyUHOjeh8b7YBP5AzZ+YG
 xjg=
X-IronPort-AV: E=Sophos;i="5.81,162,1610434800"; 
   d="scan'208";a="43339662"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2021 06:20:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 06:20:33 -0700
Received: from tyr.hegelund-hansen.dk (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 8 Feb 2021 06:20:31 -0700
Message-ID: <23616bd06996c1df9480b879d804220269143f44.camel@microchip.com>
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
Date:   Mon, 8 Feb 2021 14:20:30 +0100
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

I am not entirely sure that I get your point.

The change (adding the reset driver) is new, and it is optional (but
strongly recommended) for the  clients to use it, so will this be a
incompatible change?

I can certainly add a an explanation.  Would that be needed here in the
bindings, or where do you suggest?


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

