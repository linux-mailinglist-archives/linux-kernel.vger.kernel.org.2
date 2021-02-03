Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E287730DD0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhBCOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhBCOjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:39:35 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E6EC061573;
        Wed,  3 Feb 2021 06:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bierinrFMjNlk/eOJLAOs9SjGrtfgZOx0myhFvRs7o0=; b=iGgl56fdFMppEd4UxvAX6LP9I
        FaLmPp0EpGYA3Sa+GO7SXATbEn5Zzjfsnlxrsy/yAjgE8XsAlkxT6ZCWUgcijk93qoujCclRKClcp
        mqhvRsjOtXn60LjwIJgGnVbQuPQher967AhhH2G8wnQhQU/yIwV67onsJk+XcFxbkO0P7uwiAurmf
        9rLGTFGb188UQWAT5dME5EuQd/VPkMhthd9VOjDoY04lJv/g4FUYxroruK+tzT5aM/gb4ApPVzWtX
        fqIP2aty34uCTGwg2d2nFpKVV7LJjRd6tY1lWFkvFM914JZF/FDMOg3Mmfspwocx2t7+PaSFJzhSu
        Coo1D9c9g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38692)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7JIz-0005kH-2N; Wed, 03 Feb 2021 14:38:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7JIy-0004CO-3x; Wed, 03 Feb 2021 14:38:52 +0000
Date:   Wed, 3 Feb 2021 14:38:52 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Kostya Porotchkin <kostap@marvell.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Stefan Chulski <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        Ben Peled <bpeled@marvell.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
 settings
Message-ID: <20210203143851.GR1463@shell.armlinux.org.uk>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-3-kostap@marvell.com>
 <87h7mtckxe.fsf@tarshish>
 <DM5PR18MB14529A28A31785A574A4DEF5CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR18MB14529A28A31785A574A4DEF5CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:37:22PM +0000, Kostya Porotchkin wrote:
> Hi, Baruch,
> 
> > -----Original Message-----
> > From: Baruch Siach <baruch@tkos.co.il>
> > Sent: Wednesday, February 3, 2021 15:59
> > To: Kostya Porotchkin <kostap@marvell.com>
> > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > andrew@lunn.ch; jaz@semihalf.com; gregory.clement@bootlin.com;
> > linux@armlinux.org.uk; Nadav Haklai <nadavh@marvell.com>;
> > robh+dt@kernel.org; Stefan Chulski <stefanc@marvell.com>;
> > mw@semihalf.com; Ben Peled <bpeled@marvell.com>;
> > sebastian.hesselbarth@gmail.com; linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
> > settings
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > Hi Konstantin,
> > 
> > On Wed, Feb 03 2021, kostap@marvell.com wrote:
> > > From: Konstantin Porotchkin <kostap@marvell.com>
> > >
> > > Update the settings for AP806 SDHCI interface according to latest
> > > Xenon drivers changes.
> > > - no need to select the PHY slow mode anymore
> > 
> > Why? Has anything changed since the introduction of marvell,xenon-phy-slow-
> > mode?
> [KP] AP806 B0, AP807 and later do not need the "slow mode" set by the default.
> The HWE-7296210 errata is not applicable to these components and they are able 
> to run  AP SDHCI in HS400 8-bit mode.

So what about all those people, such as me, who have A0 silicon on their
Macchiatobin boards?

You can't just go around removing DT properties like this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
