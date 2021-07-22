Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565103D2067
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhGVI2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbhGVI2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F5A16124B;
        Thu, 22 Jul 2021 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626944936;
        bh=5vl/tvBRm8U2+bS0nYWt65GcpJ17JVUvMxzOOfaQelU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6vj8RcXEityaBeLrN9dCcMrpbv3KCQM13vyJ+fXj1Nu18kUOoe/WHYJmFcIM1ZZ1
         9Y13djBPuWAC/CVzRf8C7AFC+OvvRyV38PnpV6N6zNnLI0LPC0wRWz7ypiw1x0JDs9
         LLb4v0c5CtA3XCqgFaLoLN67QB2qWhSgeCF4eTv1vY/+L8D2mEp7n2+kLm0E6y360q
         nijVU7dYbHm+Js6ZLeT+vVf2qWJ2WZmNwwubLxN24oVflmVVSCEqXDPPxl9sNofASc
         3TkTZD0F3OvEnFAIYn+hYpEtIbOWVKsHu5LZECH6Tim4UYK3X5jQ67f6VwEoQKmRIM
         5ogINrgxuaWLA==
Date:   Thu, 22 Jul 2021 14:38:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: amlogic: Add a new driver for the HDMI TX
 PHY on Meson8/8b/8m2
Message-ID: <YPk1pNi3CyzB2Jf4@matsya>
References: <20210629182047.893415-1-martin.blumenstingl@googlemail.com>
 <20210629182047.893415-3-martin.blumenstingl@googlemail.com>
 <YPaLKwEKcDLWwztM@matsya>
 <CAFBinCCJ5DjvjkfjYg7SveDB0bvJ-XV6BwcF_yEeUqxRN9awiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCCJ5DjvjkfjYg7SveDB0bvJ-XV6BwcF_yEeUqxRN9awiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-21, 00:08, Martin Blumenstingl wrote:
> Hi Vinod,
> 
> On Tue, Jul 20, 2021 at 10:37 AM Vinod Koul <vkoul@kernel.org> wrote:
> [...]
> > > +     if (clk_get_rate(priv->tmds_clk) >= 2970UL * 1000 * 1000)
> > > +             hdmi_ctl0 = 0x1e8b;
> > > +     else
> > > +             hdmi_ctl0 = 0x4d0b;
> >
> > magic numbers..? I guess these are register offsets, would be better to
> > define..
> Unfortunately these are register values, not offsets
> The only "documentation" I have is:
> - documentation for the bits/bit-fields in these registers [0]
> - some reference code with magic values from the vendor BSP: [1]
> 
> HDMI_CTL0/HDMI_CTL1 (the names from the datasheet) is not very
> specific and I could not find any other explanation on what the values
> mean.
> That's why I cannot offer more than these magic values (same situation
> for your finding below).

Ok, Can you add a comment that register documentation not available ...


> > > +     ret = device_property_read_u32_array(&pdev->dev, "reg", reg,
> > > +                                          ARRAY_SIZE(reg));
> >
> > we have reg as single property, why array with 2 entries here?
> My thought when Rob requested a "reg" property in the dt-bindings was
> that I should use offset and size.
> I am not validating the size here, which would be in reg[1].
> If it's fine for Rob as well then I'll switch the dt-bindings to just
> have the offset inside the reg property.

So the property is reg address and size. Two would imply you are using
two reg values.

So I would recommend to use:
        reg_offset = platform_get_resource(pdev, IORESOURCE_MEM, 0);

and skip this reg array.


> 
> [...]
> > > +static const struct of_device_id phy_meson8_hdmi_tx_of_match[] = {
> > > +     { .compatible = "amlogic,meson8-hdmi-tx-phy" },
> > > +     { .compatible = "amlogic,meson8b-hdmi-tx-phy" },
> > > +     { .compatible = "amlogic,meson8m2-hdmi-tx-phy" },
> > > +     { /* sentinel */ }
> >
> > I see that all three are handled similarly, no difference!
> So far this is correct, they're all treated the same.
> However, it happened to me (multiple times) in the past that later on
> I would spot a difference hidden in the vendor BSP.
> One example is commit f004be596c28f9 ("phy: amlogic: meson8b-usb2: Add
> a compatible string for Meson8m2").
> I know that other parts of the graphics pipeline are different on
> Meson8 compared to the other two SoCs (because Meson8b/Meson8m2 have
> some reset lines which need to be toggled after updating the video
> clocks. these resets don't exist on Meson8).
> So I decided to play safe and add compatible strings for every SoC so
> I can easily handle any differences in the future (in case I find
> any).

Correct, that is why you need to *keep* the SoC specific compatible and
document them. But use a generic one when you don't have any delta

Above would become:
        { .compatible = "amlogic,meson8-hdmi" },

with DTS specifying:
        compatible = "amlogic,meson8-hdmi-tx-phy", "amlogic,meson8-hdmi";

That way if required you can always use the specific one

-- 
~Vinod
