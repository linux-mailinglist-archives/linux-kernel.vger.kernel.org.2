Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20463F17E8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbhHSLVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:21:05 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:44243 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhHSLVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:21:03 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 602BE20005;
        Thu, 19 Aug 2021 11:20:26 +0000 (UTC)
Date:   Thu, 19 Aug 2021 13:20:25 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hari.PrasathGE@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        robh@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Subject: Re: [PATCH 2/2] ARM: at91: dts: at91-sama5d2_xplained: Add comments
 for sama5d29
Message-ID: <YR4+eUWdeHRCOMo3@piout.net>
References: <20210812140758.28273-1-Hari.PrasathGE@microchip.com>
 <20210812140758.28273-2-Hari.PrasathGE@microchip.com>
 <YRV13nfgpEEuOOxB@piout.net>
 <78b26b01-b66f-5779-9f67-fdd13e473dfc@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b26b01-b66f-5779-9f67-fdd13e473dfc@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2021 10:56:21+0000, Hari.PrasathGE@microchip.com wrote:
> Hello,
> 
> On 13/08/21 12:56 am, Alexandre Belloni wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hello,
> > 
> > On 12/08/2021 19:37:58+0530, Hari Prasath wrote:
> >> Add comments for the end user for modifying the DTS file for
> >> instantiating the sama5d29 SoC.
> >>
> >> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
> >> ---
> >>   arch/arm/boot/dts/at91-sama5d2_xplained.dts | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> >> index 627b7bf88d83..faa30063d9a9 100644
> >> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> >> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> >> @@ -6,6 +6,11 @@
> >>    *                2015 Nicolas Ferre <nicolas.ferre@atmel.com>
> >>    */
> >>   /dts-v1/;
> >> +/*
> >> + * Replace the line below with "sama5d29.dtsi" in order to instantiate the
> >> + * sama5d29 SoC of the sama5d2 family.Otherwise, leave it unchanged when
> >> + * using sama5d27 SoC for instance.
> >> + */
> > 
> > I guess it would be better to have a at91-sama5d29_xplained.dts (and we
> > should have had a at91-sama5d27_xplained.dts), else, you can't create an
> > image that will support both variants.
> > 
> > 
> The new SoC 'sama5d29' belongs to the same sama5d2 family. It is 
> essentially a new chip revision of the existing sama5d27 with a new GMAC 
> controller IP that addresses few silicon issues. There wouldn't be 
> separate evaluation boards that shall be made but we will be using the 
> existing sama5d2 XPlained boards itself but with the new SoC populated. 

That's what I understood but a board with a different SoC is a
different board.

> Hence we have taken this approach of having a separate DTSI file and 
> reuse the existing board specific DTS file.
> 
> We don't want to create single image that will support both variants. In 
> fact, we don't want our customers to enable certain features that are 
> broken at the silicon level in the existing revision of the SoC i.e 
> sama5d27. Instead, they could do this change manually and use it in the 
> new SoC i.e sama5d29.
> 

This will be confusing to your customers while you could make their
lives simpler by having the bootloader chose the proper dtb instead of
having them change that manually. They will then have to regenerate
images with that change, see how your customers struggle to do that:

https://stackoverflow.com/questions/68222619/update-custom-device-tree-on-yocto
https://stackoverflow.com/questions/37347808/how-to-use-an-own-device-tree-and-modified-kernel-config-in-yocto
https://stackoverflow.com/questions/63047955/overriding-defconfig-in-bbappend-file


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
