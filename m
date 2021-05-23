Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAC838D7DD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 02:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhEWADH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 20:03:07 -0400
Received: from foss.arm.com ([217.140.110.172]:35602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhEWADG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 20:03:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ECB21042;
        Sat, 22 May 2021 17:01:40 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CADBD3F73B;
        Sat, 22 May 2021 17:01:38 -0700 (PDT)
Date:   Sun, 23 May 2021 01:01:24 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 01/17] dt-bindings: mfd: axp20x: Add AXP305
 compatible (plus optional IRQ)
Message-ID: <20210523010124.2fb56fa5@slackpad.fritz.box>
In-Reply-To: <7ebfaef7-5cf2-e60c-99ef-4275c873e72d@sholland.org>
References: <20210519104152.21119-1-andre.przywara@arm.com>
        <20210519104152.21119-2-andre.przywara@arm.com>
        <7ebfaef7-5cf2-e60c-99ef-4275c873e72d@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 09:46:23 -0500
Samuel Holland <samuel@sholland.org> wrote:

> On 5/19/21 5:41 AM, Andre Przywara wrote:
> > The AXP305 PMIC used in AXP805 seems to be fully compatible to the  
>                   ^^^^^^^^^^^^^^
> Typo? Do you mean "used with the H616 SoC"?

Ouch, yes. And even more embarrassingly Chen-Yu pointed that out already
in the previous version. Same for the compatible string.

Thanks for having a look!

Cheers,
Andre

> 
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
>                    ^^^^^^
> This should be x-powers,axp305.
> 
> Regards,
> Samuel
> 
> >      * "x-powers,axp809"
> >      * "x-powers,axp813"
> >  - reg: The I2C slave address or RSB hardware address for the AXP chip
> > -- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> >  - interrupt-controller: The PMIC has its own internal IRQs
> >  - #interrupt-cells: Should be set to 1
> >  
> > @@ -43,6 +43,7 @@ more information:
> >  			AXP20x/LDO3: software-based implementation
> >  
> >  Optional properties:
> > +- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> >  - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
> >  		      AXP152/20X: range:  750-1875, Default: 1.5 MHz
> >  		      AXP22X/8XX: range: 1800-4050, Default: 3   MHz
> >   
> 
> 

