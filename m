Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3338B5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhETSZp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 May 2021 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhETSZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:25:44 -0400
Received: from cascadia.aikidev.net (cascadia.aikidev.net [IPv6:2600:3c01:e000:267:0:a171:de7:c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C45FC061574;
        Thu, 20 May 2021 11:24:22 -0700 (PDT)
Received: from localhost (97-120-1-76.ptld.qwest.net [97.120.1.76])
        (Authenticated sender: vagrant@aikidev.net)
        by cascadia.aikidev.net (Postfix) with ESMTPSA id C9AC71ACD4;
        Thu, 20 May 2021 11:24:19 -0700 (PDT)
From:   Vagrant Cascadian <vagrant@reproducible-builds.org>
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
In-Reply-To: <YKQm/F+JIjf/YUHm@eldamar.lan>
References: <1243888060.510560.1612783497400@ichabod.co-bxl>
 <20210210150118.ly252i37eykayrcb@gilmour>
 <1719200956.433094.1613199092092@ichabod.co-bxl>
 <6612268.HtAl026vyE@jernej-laptop> <YKFPGC2qBMipQPbd@eldamar.lan>
 <87o8dawhy3.fsf@yucca> <20210518150652.zxj56bljjeq3ogln@gilmour>
 <YKQiws6yP35QIpJd@eldamar.lan> <YKQm/F+JIjf/YUHm@eldamar.lan>
Date:   Thu, 20 May 2021 11:24:18 -0700
Message-ID: <87a6opqn59.fsf@ponder>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-18, Salvatore Bonaccorso wrote:
> On Tue, May 18, 2021 at 10:25:40PM +0200, Salvatore Bonaccorso wrote:
>> On Tue, May 18, 2021 at 05:06:52PM +0200, Maxime Ripard wrote:
>> > On Sun, May 16, 2021 at 01:18:44PM -0700, Vagrant Cascadian wrote:
>> > > On 2021-05-16, Salvatore Bonaccorso wrote:
>> > > > On Sat, Feb 13, 2021 at 09:51:17AM +0100, Jernej Škrabec wrote:
>> > > >> Let me first explain that it was oversight on my side not noticing initials in 
>> > > >> your SoB tag. But since the issue was raised by Maxime, I didn't follow up.
>> > > >> 
>> > > >> Dne sobota, 13. februar 2021 ob 07:51:32 CET je B.R. Oake napisal(a):
>> > > >> > On Wed Feb 10 at 16:01:18 CET 2021, Maxime Ripard wrote:
>> > > >> > > Unfortunately we can't take this patch as is, this needs to be your real
>> > > >> > > name, see:
>> > > >> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de
>> > > >> > > veloper-s-certificate-of-origin-1-1
>> > > >> > Dear Maxime,
>> > > >> > 
>> > > >> > Thank you very much for considering my contribution and for all your
>> > > >> > work on supporting sunxi-based hardware; I appreciate it.
>> > > >> > 
>> > > >> > Thank you for referring me to the Developer's Certificate of Origin, but
>> > > >> > I had already read it before submitting (I had to do so in order to know
>> > > >> > what I was saying by "Signed-off-by:") and I do certify what it says.
>> > > >> > 
>> > > >> > Looking through recent entries in the commit log of the mainline kernel,
>> > > >> > I see several patches from authors such as:
>> > > >> > 
>> > > >> >   H.J. Lu <hjl.tools@gmail.com>
>> > > >> >   B K Karthik <karthik.bk2000@live.com>
>> > > >> >   JC Kuo <jckuo@nvidia.com>
>> > > >> >   EJ Hsu <ejh@nvidia.com>
>> > > >> >   LH Lin <lh.lin@mediatek.com>
>> > > >> >   KP Singh <kpsingh@kernel.org>
>> > > >> >   Karthik B S <karthik.b.s@intel.com>
>> > > >> >   Shreyas NC <shreyas.nc@intel.com>
>> > > >> >   Vandana BN <bnvandana@gmail.com>
>> > > >> > 
>> > > >> > so I believe names of this form are in fact acceptable, even if the
>> > > >> > style might seem a little old-fashioned to some.
>> > > >> 
>> > > >> Speaking generally, not only for this case, prior art arguments rarely hold, 
>> > > >> because:
>> > > >> - it might be oversight,
>> > > >> - it might be a bad practice, which should not be followed in new 
>> > > >> contributions,
>> > > >> - different maintainers have different point of view on same thing,
>> > > >> - maintainer wants to adapt new practice or steer subsystem in new direction
>> > > >> 
>> > > >> > 
>> > > >> > I would like to add that I have met many people with names such as C.J.,
>> > > >> > A A, TC, MG, etc. That is what everybody calls them and it would be
>> > > >> > natural for them to sign themselves that way. Some of them might want to
>> > > >> > contribute to Linux some day, and I think it would be a great shame and
>> > > >> > a loss to all of us if they were discouraged from doing so by reading
>> > > >> > our conversation in the archives and concluding that any contribution
>> > > >> > from them, however small, would be summarily refused simply because of
>> > > >> > their name. Please could you ensure that does not happen?
>> > > >> 
>> > > >> The link you posted says following:
>> > > >> "using your real name (sorry, no pseudonyms or anonymous contributions.)"
>> > > >> 
>> > > >> I believe that real name means no initials, no matter what people are 
>> > > >> accustomed to. From my point of view, CJ is pseudonym derived from real name.
>> > > >> 
>> > > >> This is not the first time that fix of SoB tag was requested, you can find such 
>> > > >> requests in ML archives.
>> > > 
>> > > I'm sure this isn't the first time this sort of thing has been brought
>> > > up on this subject, but I feel obliged to mention:
>> > > 
>> > >   https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
>> > > 
>> > > This seems to be blocked on culturally dependent perception of what
>> > > looks like a "real name" as opposed to any technical grounds.
>> > > 
>> > > What is the goal of the "real name" in Signed-off-by actually trying to
>> > > achieve?
>> > 
>> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
>> > 
>> > I'm not the one making the rules, sorry
>> 
>> Would it be technically possible to do the following: Based on the
>> downstream report we receved in Debian in
>> https://bugs.debian.org/988574 wrap up the same patch (I guess I will
>> need to use another commit message wording) and resubmit with my own
>> SoB with my downstream hat on and say a Tested-by from Vagrant? So we
>> are not blocked on the SoB issue from this original post of the change
>> to apply to arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts ?
>
> Here is an attempt to do that and coming from
> https://bugs.debian.org/988574 for the change change submission.
>
> Regards,
> Salvatore
>
> From 93c335c997d6386fc5cb7b9c5621b9b9725de20e Mon Sep 17 00:00:00 2001
> From: Salvatore Bonaccorso <carnil@debian.org>
> Date: Tue, 18 May 2021 22:33:49 +0200
> Subject: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy-mode
>
> Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> config") sets the RX/TX delay according to the phy-mode property in the
> device tree. For the Orange Pi Plus board this is "rgmii", which is the
> wrong setting.
>
> Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
> Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
> the Ethernet working again on this board.
>
> Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> Reported-by: Vagrant Cascadian <vagrant@reproducible-builds.org>
> Link: https://bugs.debian.org/988574
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>

Seems worth crediting the original reporter "B.R. Oake"
<broake@mailfence.com> with a Reported-by as well?


live well,
  vagrant

> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> index 97f497854e05..d05fa679dcd3 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> @@ -85,7 +85,7 @@ &emac {
>  	pinctrl-0 = <&emac_rgmii_pins>;
>  	phy-supply = <&reg_gmac_3v3>;
>  	phy-handle = <&ext_rgmii_phy>;
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>  
>  	status = "okay";
>  };
> -- 
> 2.31.1
