Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54807337FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 23:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCKV7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:59:52 -0500
Received: from mailoutvs32.siol.net ([185.57.226.223]:58678 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229679AbhCKV7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:59:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 7D6D0524AD8;
        Thu, 11 Mar 2021 22:59:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id doooZCoLUepj; Thu, 11 Mar 2021 22:59:36 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 34F9D524D14;
        Thu, 11 Mar 2021 22:59:36 +0100 (CET)
Received: from kista.localnet (cpe-86-58-17-133.cable.triera.net [86.58.17.133])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 7C948524AD8;
        Thu, 11 Mar 2021 22:59:35 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: Re: [PATCH] ARM: dts: sun8i: h3: beelink-x2: Add power button
Date:   Thu, 11 Mar 2021 22:59:35 +0100
Message-ID: <2517400.0zBCEEo8qi@kista>
In-Reply-To: <20210308130506.v35gjviwknr5hat5@gilmour>
References: <20210306203611.15534-1-jernej.skrabec@siol.net> <20210308130506.v35gjviwknr5hat5@gilmour>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 08. marec 2021 ob 14:05:06 CET je Maxime Ripard napisal(a):
> Hi
> 
> On Sat, Mar 06, 2021 at 09:36:11PM +0100, Jernej Skrabec wrote:
> > Beelink X2 has power button. Add node for it.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> >  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/
sun8i-h3-beelink-x2.dts
> > index 62b5280ec093..4a2cb072ecf6 100644
> > --- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > +++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > @@ -111,6 +111,17 @@ spdif_out: spdif-out {
> >  		#sound-dai-cells = <0>;
> >  		compatible = "linux,spdif-dit";
> >  	};
> > +
> > +	r_gpio_keys {
> 
> Underscores are not valid for node names (and will trigger a dtc warning
> when running with W=1).

Unless I'm doing something wrong, I didn't get any warning with "make dtbs 
W=1". In fact many H3 boards have a node with this name and not a single 
warning is produced with this command for underscores (there are other 
warnings though).

Actually, several H3 DT files have nodes like "sound_spdif" or "wifi_pwrseq". It 
seems like warnings are triggered only for children of soc node.

> 
> > +		compatible = "gpio-keys";
> > +
> > +		power {
> > +			label = "power";
> 
> IIRC the node name is used as a fallback when the label isn't there?

Binding doesn't say anything about what happens if label is missing. Driver 
sets generic description "gpio_keys" in such case, which is not something that 
we want.

Best regards,
Jernej

> 
> Maxime
> 


