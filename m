Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4230DEBF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhBCPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:53:46 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46310 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234577AbhBCPls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:41:48 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1l7KH9-0043HO-7H; Wed, 03 Feb 2021 16:41:03 +0100
Date:   Wed, 3 Feb 2021 16:41:03 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kostya Porotchkin <kostap@marvell.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Ben Peled <bpeled@marvell.com>
Subject: Re: [EXT] Re: [PATCH 03/11] dts: mvebu: Add pin control definitions
 for SDIO interafce
Message-ID: <YBrED9hix11heWv0@lunn.ch>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-4-kostap@marvell.com>
 <20210203142806.GQ1463@shell.armlinux.org.uk>
 <DM5PR18MB145298C7C6CB673A6B4B5038CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR18MB145298C7C6CB673A6B4B5038CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +		sdhci_pins: sdhi-pins {
> > 
> > sdhi-pins ?
> > 
> [KP] You mean to replace the underline with dash?

I think he would like a c added in the correct place.

  Andrew
