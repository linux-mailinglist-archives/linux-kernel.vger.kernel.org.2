Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026784281FB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhJJOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 10:47:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59488 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231990AbhJJOr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 10:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=XZpXfE81hl2GLeGyZKWimAEjp7hFRT6iSMzwNGCRpXs=; b=GMHop48KOdYTfy/WQSqo2gK03W
        WGXCxWGgWfir9NwjjvQfJQeJ9dU1YydibcwyWLmDaPEBsBp8sUiIxpboQqOgTxw8LoHUwzc2i+VUF
        RDYMYI6hlB4avGkKPmMresT0SB7QA8BjIIdfHSDIsi67UIl4wfogfRtIx+7w3EO7XnDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mZa57-00AEqu-3b; Sun, 10 Oct 2021 16:45:41 +0200
Date:   Sun, 10 Oct 2021 16:45:41 +0200
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
Message-ID: <YWL8laRaWwordXdE@lunn.ch>
References: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
 <20211007230619.957016-3-chris.packham@alliedtelesis.co.nz>
 <YV+IDzEdYuy+s/Ak@lunn.ch>
 <62e8a697-666c-03ae-cc06-0a51e3ff09c0@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e8a697-666c-03ae-cc06-0a51e3ff09c0@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +			port@9 {
> >> +				reg = <9>;
> >> +				label = "wanp9";
> > Do these names correspond to some labeling? Ether the case or the silk
> > screen?
> The silkscreen just says P1-P8. I was tempted to rename "wan1" -> "lan1" 
> to match the others. I could also change them all to "pN" or "portN" if 
> preferred.

I normally say, use the labels from the case. That is what the user
sees. But if this RDK does not have case, then maybe lan1-lan8 would
be better, to match the silk screen. And then call port9 sfp1?

> P9 is connected to a SFP+ cage. I know there has been some work on the 
> bindings for that which I haven't caught up with.

Pretty simple. You need a node about the SFP itself:

sfp_eth3: sfp-eth3 {
        compatible = "sff,sfp";
        i2c-bus = <&sfp_1g_i2c>;
        los-gpios = <&cpm_gpio2 22 GPIO_ACTIVE_HIGH>;
        mod-def0-gpios = <&cpm_gpio2 21 GPIO_ACTIVE_LOW>;
        maximum-power-milliwatt = <1000>;
        pinctrl-names = "default";
        pinctrl-0 = <&cpm_sfp_1g_pins &cps_sfp_1g_pins>;
        tx-disable-gpios = <&cps_gpio1 24 GPIO_ACTIVE_HIGH>;
        tx-fault-gpios = <&cpm_gpio2 19 GPIO_ACTIVE_HIGH>;
};

If you don't have any of the GPIO, just don't list them.

And in the MAC you need to reference the sfp:

        sfp = <&sfp_eth3>;

Given that this is a marvell device, you might also need some comphy
configuration in the MAC node:

        phy-names = "comphy";
        phys = <&cps_comphy5 0>;

	Andrew
