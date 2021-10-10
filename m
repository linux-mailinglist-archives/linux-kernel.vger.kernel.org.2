Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA055428245
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhJJPXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 11:23:35 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59596 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232515AbhJJPX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 11:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=17HAEeNvZoc38s0guR7ln5hAgEeKyQs01wiuF4tGFGg=; b=AOut00jgjwMXC8OnbnNKK8Qrh9
        8XYOoOhvxofl+9PzyoJr2sIkshVGfYFz/ccLkNTnh6jevJVux+LBw6dyGMzu958RFvoSnkwYyAFUV
        RiEMTzjp805f8rnCFUz0N66sOclB8zNXsLOKC0LcQ/lQ2d6V0OEPw1KWNER/ZUdX5aeg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mZadZ-00AF3G-Iz; Sun, 10 Oct 2021 17:21:17 +0200
Date:   Sun, 10 Oct 2021 17:21:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB device
 tree
Message-ID: <YWME7f31MzaTvL8N@lunn.ch>
References: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
 <20211007230619.957016-3-chris.packham@alliedtelesis.co.nz>
 <YV+IDzEdYuy+s/Ak@lunn.ch>
 <62e8a697-666c-03ae-cc06-0a51e3ff09c0@alliedtelesis.co.nz>
 <YWL8laRaWwordXdE@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWL8laRaWwordXdE@lunn.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Given that this is a marvell device, you might also need some comphy
> configuration in the MAC node:
> 
>         phy-names = "comphy";
>         phys = <&cps_comphy5 0>;

Humm, actually, forget that, this is a switch, not a SoC.

      Andrew
