Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE43B40C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhFYJry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYJrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:47:52 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDECC061574;
        Fri, 25 Jun 2021 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RM4Laxk4DlI2gmOx6X9srWjn3weJq33pQVfhRa0PR8I=; b=u0/E42Gkz2SDXRS9Frb65PciU
        RZViFaAoKBvGJq1fV1O6/WIvw60jVHUJjN6u/lI5WIwgFYeQaWSSc7UL6MlqrjsThErEtzkjrAX1d
        /WUuIu58TxlQK9xw0BhT8dPzD7fiIbbGaOHNlO+Vbiw+digrvi8W8O00zUDxzpRg6vjpTB1pfUPMI
        2lqFxsS+rS7/6sOIU0C6S28ZqM9D6heSYcwe65MJDwqZgaNFXHSnVgFkT1TOfPqahoQ0SABfo3Z7R
        Y3aKf5eUUdi6aKvNavkA5L2UdThHXmT1c2kW7InVWQ0LWV9/28gCmdYFwQjGA3r4g0LrpG1aGALT9
        gogCz90tw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45340)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lwiOu-0000Tt-VG; Fri, 25 Jun 2021 10:45:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lwiOu-0006a8-MM; Fri, 25 Jun 2021 10:45:28 +0100
Date:   Fri, 25 Jun 2021 10:45:28 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, thomas.petazzoni@bootlin.com,
        herve.codina@bootlin.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-sr-som: Increase the PHY reset
 duration to 10ms
Message-ID: <20210625094528.GU22278@shell.armlinux.org.uk>
References: <20210625083051.3691737-1-maxime.chevallier@bootlin.com>
 <20210625083840.GS22278@shell.armlinux.org.uk>
 <20210625113550.7a135e69@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625113550.7a135e69@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 11:35:50AM +0200, Maxime Chevallier wrote:
> Hi Russell,
> 
> On Fri, 25 Jun 2021 09:38:40 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> >On Fri, Jun 25, 2021 at 10:30:51AM +0200, Maxime Chevallier wrote:
> >> The datasheet for the AR803x PHY present on this SoM recommends that the
> >> reset line is asserted low for 10ms, so that the PHY has time to
> >> properly reset the internal blocks.
> >> 
> >> The previous value of 2ms was found to be problematic on some setups,
> >> causing intermittent issues where the PHY would be unresponsive
> >> every once in a while on some sytems, with a low occurence (it typically
> >> took around 30 consecutive reboots to encounter the issue).
> >> 
> >> Bumping the delay to the 10ms recommended value makes the issue
> >> dissapear, with more than 2500 consecutive reboots performed without the
> >> issue showing-up.  
> >
> >This isn't actually what the datasheet says, which is:
> >
> >  Input clock including the crystal and external input clock should be
> >  stable for at least 1ms before RESET can be deasserted.
> >
> >  When using crystal, the clock is generated internally after power is
> >  stable. For a reliable power on reset, suggest to keep asserting the
> >  reset low long enough (10ms) to ensure the clock is stable and
> >  clock-to-reset 1ms requirement is satisfied.
> >
> >The 10ms duration you quote is the _power on reset_ duration, and in
> >those circumstances, there is a delay before the required clocks will
> >be stable.
> >
> >This is not a power on reset scenario - the power was applied long ago
> >by the time the kernel starts booting, and XI clock would have been
> >running.
> >
> >So, I think the commit message which seems to be claiming that the reset
> >line always needs to be asserted for 10ms is not entirely accurate.
> 
> You're correct, indeed, I guess we read that a bit too fast.
> 
> However, we do see that bumping the reset duration fixes the issue that
> was encountered.
> 
> To give you more details about this issue, in that scenario the PHY
> would fail the autoneg process, no matter how many times we
> enable/disable the link and restart autoneg.
> 
> The low duration of the reset might put the internal blocks in an
> unknown state, but I don't actually have the real hardware-side
> explanation for what is actually happening.
> 
> Further testing showed, for example, that decreasing the time of reset
> assertion to 1ms made the issue appear everytime, whereas bumping it to
> 10 ms fixed it entirely.
> 
> In the absence of any other indication about how long should that reset
> be asserted, and after thourough testing, 10ms seems like a good enough
> value.
> 
> I'll send a V2 with the commit log fixed.
> 
> Thanks for the quick review,

Thanks. For the record, I don't have an issue with bumping it to 10ms,
only that the above would be useful information in the commit long.

I wonder if we should be recording these kinds of behaviours somewhere,
so e.g. we recommend that all AR803x should use a reset duration of
10ms with the above explanation. Just a thought to save others needing
to do the same research.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
