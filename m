Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D9E30DF5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhBCQMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhBCQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:12:22 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5356AC061573;
        Wed,  3 Feb 2021 08:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NEM3B+5uDLhDBQoDrux6VhVo3KJnVlV4DNcGykNwGAQ=; b=xKMfu7bPPtW93HcxNB+zsRWo9
        NbfYFb5ZBwm/8VBFC60rp9kYL6KqUYhVsLYisSxZ57GgjBv3ZxOlJ/dXWKUixABjQUtdp2lAqfRsE
        DDDS4DFPtIKy/wDtiH7g4Z1CJYx4jd3go2+TPmELkqY044O/8IhvtoaZwoyQnHUCR618jz3HKxOmj
        +7bN7ugy8G4RnnTCSnpvlBvQukbv66Tg8hRXvxjtwirveRd0WhUQMx18kGibMj1gIVnGMd+KyXCTX
        ENIaH7gpj7yUlIh22+fKjP1Ig7MJEyQ23Ne+dsbQixLAjZaMvDFtfp2wVNoeQ3t4bTO1tLm2V2M48
        2BPD3FVDQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38718)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7Kkl-0005pO-5I; Wed, 03 Feb 2021 16:11:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7Kkk-0004GQ-15; Wed, 03 Feb 2021 16:11:38 +0000
Date:   Wed, 3 Feb 2021 16:11:38 +0000
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
Message-ID: <20210203161137.GS1463@shell.armlinux.org.uk>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-3-kostap@marvell.com>
 <87h7mtckxe.fsf@tarshish>
 <DM5PR18MB14529A28A31785A574A4DEF5CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
 <20210203143851.GR1463@shell.armlinux.org.uk>
 <DM5PR18MB1452A6CF26E3A54730872A14CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR18MB1452A6CF26E3A54730872A14CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:50:45PM +0000, Kostya Porotchkin wrote:
> [KP] So for older systems this "slow mode" parameter could be set on the board level.
> When it is set in ap80x,dtsi file it downgrades all systems to HS-SDR52, even if they support HS400 on AP side.
> MacchiatoBIN AP eMMC is connected to 3.3v regulator and has "no-1-8-v" flag set, so it should remain in low speed anyway.

Your reasoning does not make sense.

The ap80x.dtsi file does not specify "marvell,xenon-phy-slow-mode".
It is not specified at this level. It is already specified at board
level.

Given that Macchiatobin will still use slow mode, why remove the
marvell,xenon-phy-slow-mode property from this file?

Also, if you're upgrading ap80x.dtsi to use a bus-width of 8, why
keep the bus-width specifier of 8 in the board files?

This patch just doesn't make sense, and your responses to our points
seem to add to the confusion.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
