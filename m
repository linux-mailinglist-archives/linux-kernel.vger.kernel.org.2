Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B58530BBD7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBBKMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:12:51 -0500
Received: from foss.arm.com ([217.140.110.172]:47320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhBBKMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:12:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74B4A1396;
        Tue,  2 Feb 2021 02:11:56 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5317C3F7D7;
        Tue,  2 Feb 2021 02:11:54 -0800 (PST)
Date:   Tue, 2 Feb 2021 10:11:05 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2w=?= =?UTF-8?B?w6ltZW50IFDDqXJvbg==?= 
        <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Lee Jones <lee.jones@linaro.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH v5 04/20] dt-bindings: mfd: axp20x: Add
 AXP305 compatible (plus optional IRQ)
Message-ID: <20210202101105.3396862f@slackpad.fritz.box>
In-Reply-To: <CAGb2v674jBtROBXZ7HLj9Uqa_BZxW04z9VQ1R6Cn901+ES0k6g@mail.gmail.com>
References: <20210127172500.13356-1-andre.przywara@arm.com>
        <20210127172500.13356-5-andre.przywara@arm.com>
        <CAGb2v674jBtROBXZ7HLj9Uqa_BZxW04z9VQ1R6Cn901+ES0k6g@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 15:55:50 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

Hi,

> On Thu, Jan 28, 2021 at 1:26 AM Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > The AXP305 PMIC used in AXP805 seems to be fully compatible to the  
>                           ^
> This statement doesn't quite make sense. I assume you wanted to mention
> a board or the H616 SoC here?

Argh, indeed!

> > AXP805 PMIC, so add the proper chain of compatible strings.
> >
> > Also at least on one board (Orangepi Zero2) there is no interrupt line
> > connected to the CPU, so make the "interrupts" property optional.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > index 4991a6415796..4fd748101e3c 100644
> > --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> > +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > @@ -26,10 +26,10 @@ Required properties:
> >      * "x-powers,axp803"
> >      * "x-powers,axp806"
> >      * "x-powers,axp805", "x-powers,axp806"
> > +    * "x-powers,axp803", "x-powers,axp805", "x-powers,axp806"  
> 
> axp305? axp803 is used with A64 IIRC.

Oh, well spotted. This AXP naming already confused me when they were
all called 80x, now using 30x gave me the rest ;-)

Sorry for the blunder!

Cheers,
Andre

> 
> ChenYu
> 
> >      * "x-powers,axp809"
> >      * "x-powers,axp813"
> >  - reg: The I2C slave address or RSB hardware address for the AXP chip
> > -- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> >  - interrupt-controller: The PMIC has its own internal IRQs
> >  - #interrupt-cells: Should be set to 1
> >
> > @@ -43,6 +43,7 @@ more information:
> >                         AXP20x/LDO3: software-based implementation
> >
> >  Optional properties:
> > +- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> >  - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
> >                       AXP152/20X: range:  750-1875, Default: 1.5 MHz
> >                       AXP22X/8XX: range: 1800-4050, Default: 3   MHz
> > --
> > 2.17.5
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20210127172500.13356-5-andre.przywara%40arm.com.  

