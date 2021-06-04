Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A739C41E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 01:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhFDX5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 19:57:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46462 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhFDX5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=V5I1izDyZnqQUKjkK30zMBQfBQvEtVeCrYW/vUGLITc=; b=taJ5M26h85Hh6an7Sw3/oDGsM9
        3UNfwOrMY2XoXO7B1NsAktD4pkB23xS0EtyeZRIFSp1GgoNHggT1WrmCMKU+XinXfBFDII6KY8svF
        NiHRTXpXC8f/hoMEC/Qo1piTnsA0TGEjiFQdpxqWaHIXPoHym093hOFNMrCXddUn8CtI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lpJfC-007sVC-DN; Sat, 05 Jun 2021 01:55:42 +0200
Date:   Sat, 5 Jun 2021 01:55:42 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Clause-22/Clause-45 MDIO regmap support
Message-ID: <YLq9fgtj1xb0peA+@lunn.ch>
References: <cover.1622743333.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1622743333.git.sander@svanheule.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have zero experience with clause-45 devices, and no such devices
> available for testing. As such, clause-45 code in the second patch is
> entirely untested, although it isn't very complex.

Normal kernel policy is not to merge something if it has no users. As
i said in another reply, the only users of regmap-mdio are going to be
Ethernet switch and funky mdio devices. So far, i've not seen a C45
Ethernet switch, nor a funky c45 mdio device. So i suggest we leave it
on the mainline list until some hardware which could use it comes
along.

	Andrew
