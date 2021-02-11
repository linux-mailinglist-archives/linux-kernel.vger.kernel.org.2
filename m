Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A891318D29
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhBKOSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhBKODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:03:39 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1230C061574;
        Thu, 11 Feb 2021 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kktYp+pSh+O4XJKVd7hgFyroxYNNVW4Lv43MZBaTjMo=; b=q6cYOC4VWiAdEFG/xowGGAtNX
        D2VQS0sWKkIcHm4EKQd/JPMSva3XUgyPqdmMFQLXxJApcIgbEX8jma50a+1D4DC+yHy4xC895QJeb
        9p36MWFbjti7G0qp3oVamjZlb3VwRLfztoEhvBVyasCY6TsM0YVD4+fQVcYKNOG4WrLYA/RS+5bQ0
        VG2N2U3BWxVX2fj0589/apMTDt+XhB1+DpspyM1f8Pv4UCi0/uLCLvp4niJzjo7gF8bpjP9sf5wC3
        8IIVcUq31NAJzzufLIubu+HzteMgSR0T2rLvAJU8jwJPol6m8pNuctDB/xzr8qc6eC2jU8XWPgGwH
        QIi057Kkw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42062)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lACYA-0006Eu-Nm; Thu, 11 Feb 2021 14:02:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lACY8-00069e-0Z; Thu, 11 Feb 2021 14:02:28 +0000
Date:   Thu, 11 Feb 2021 14:02:27 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Kostya Porotchkin <kostap@marvell.com>
Cc:     Jon Nettleton <jon@solid-run.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Ben Peled <bpeled@marvell.com>
Subject: Re: [EXT] Re: [PATCH v2 01/12] fix: arm64: dts: replace wrong
 regulator on ap emmc
Message-ID: <20210211140227.GL1463@shell.armlinux.org.uk>
References: <20210210140949.32515-1-kostap@marvell.com>
 <20210210140949.32515-2-kostap@marvell.com>
 <20210211105222.GY1463@shell.armlinux.org.uk>
 <DM5PR18MB1452DFBCDCE970384339545BCA8C9@DM5PR18MB1452.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR18MB1452DFBCDCE970384339545BCA8C9@DM5PR18MB1452.namprd18.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 01:57:25PM +0000, Kostya Porotchkin wrote:
> 
> > ----------------------------------------------------------------------
> > On Wed, Feb 10, 2021 at 04:09:38PM +0200, kostap@marvell.com wrote:
> > > From: Konstantin Porotchkin <kostap@marvell.com>
> > >
> > > Replace wrong regulator in AP0 eMMC definition on MacchiatoBIN board
> > > with 3.3V regulator.
> > > The MacchiatoBIN board has no 1.8V regulator connected to AP0 eMMC
> > > (ap0_sdhci0) interface.
> > 
> > There seems to be some variability between Macchiatobin versions according
> > to the schematics.
> > 
> > The VDDO_H supply is connected to the eMMC VCCQ pins, and is also
> > connected to the AP_VDDO_H pins. It is wired to the 1.8V regulator on rev 1.1
> > schematics, but hard-wired to the 3.3V regulator on rev 1.3 schematics.
> > 
> > This needs clarification from SolidRun before the patch can be accepted - was
> > VDDO_H ever wired to the 1.8V regulator on production hardware?
> > 
> [KP] I will try to find a relevant contact in SolidRun for get this issue clarified.

I've already added Jon Nettleton.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
