Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9FF39C16E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhFDUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:40:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46114 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhFDUkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ddxgeeibrSxUcXVfcvxII7HHK8VvoeqvHMOdOUWFBHk=; b=5w2TfyaeKaPAFA8l6zq7etUFUg
        JuCA+AK8lxijnO6MljdPCveCyNQ7lIFzu0sHLlbomqYKq8rKlb0oz7gfnkt+fo7DRDOWpTGQY72bU
        W0Jso7FUPxR4dkXsisxsTWtCmQ3CmZeXZsvtu4/t1bo22JQvPzkBz8nhulJoJH6K3WpY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lpGaB-007quD-RB; Fri, 04 Jun 2021 22:38:19 +0200
Date:   Fri, 4 Jun 2021 22:38:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sander Vanheule <sander@svanheule.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Clause-22/Clause-45 MDIO regmap support
Message-ID: <YLqPO38YkVZzHfmS@lunn.ch>
References: <cover.1622743333.git.sander@svanheule.net>
 <20210604172515.GG4045@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604172515.GG4045@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 06:25:15PM +0100, Mark Brown wrote:
> On Thu, Jun 03, 2021 at 08:25:08PM +0200, Sander Vanheule wrote:
> 
> > 1. I've opted to just ignore any bits that lie beyond the allowed address
> >    width. Would it be cleaner to raise an error instead?
> 
> It doesn't *really* matter, enforcement is probably a bit better as it
> might catch bugs.

I would agree with that. The mostly likely problem is that somebody
misses the difference between C22 and C45 and instantiates the wrong
sort of regmap. You can quickly detect a C22 regmap being used for C45
due to the range difference.

> > 2. Packing of the clause-45 register addresses (16 bit) and adressed device
> >    type (5 bit) is the same as in the mdio subsystem, resulting in a 21 bit
> >    address. Is this an appropriate way to pack this information into one
> >    address for the regmap interface?
> 
> Either that or pass the type in when instantiating the regmap (it sounds
> like it should be the same for all registers on the device?).

A device can implement both C22 and C45. There is also a standardized
way to perform C45 access over C22, using two registers in C22 space.
But this assumes the device is an Ethernet PHY, or is at least making
use of the Ethernet PHY way of doing this tunnelling. But i doubt any
Ethernet PHY driver will ever use regmap.

Where i see regmap-mdio being used it for non-Ethernet PHY
devices. That mostly means Ethernet Switches and oddball devices like
this like LED controller. Broadcom also have a generic PHY driver
talking over MDIO to hardware.

     Andrew
