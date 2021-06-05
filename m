Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F239C80E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFEMOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 08:14:43 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40605 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229931AbhFEMOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 08:14:41 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8DE7D580495;
        Sat,  5 Jun 2021 08:12:53 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sat, 05 Jun 2021 08:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=MxyOvMLl95ktMBkCbMfFZ11IUGzG
        uBuq3YVlZ9Bud88=; b=nVRc+gaMsaB9JcUDdwZ9eRwOC7MDvLZtIPJ3UJS8COsK
        701EFjYtgt+V9PiXfOwUcrbza3T3BriPuo37SIafWFMVpJ5K7p4jFMPH0ja5P6CS
        gjAfP65STMemVkOWQH/g42w6aLthHHVOA/cKUhqK61VbVUowBF6JpY4rXcAPgSFP
        7vYrrFf+gNSy06U8cjjrkd6/GtEUHnlFzFmDZ9w1om5Xt1USSB3Zc0aC5I/Y8cfU
        c+nsxbWPrI0QjSLxd4dM+Du9z+Gi8VgVhy59zKJx/NuPN+wjb9TQgxuTelI6o6aF
        sDUHYhkbSIsUN0Hw5yDYnHL60ZlZDNwRoHGwSp/Q+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MxyOvM
        Ll95ktMBkCbMfFZ11IUGzGuBuq3YVlZ9Bud88=; b=TP9rISCfVzcyZQPFW7M+ZE
        HR+e0uhf3VnH/zKrWK+9zp5WhD80OljFuHTRaSlvbarGfO8YxGzlrzXfIZzrZxD3
        KJlfidUVv5sp+Pyg4RK67k7Ttu2ADRVR8Gf5y3P3RYZ/9XdObIOx5Rgr8hxH2TWr
        aDrHuzxrv1cXez5+nio7YCgkk9H5XgXTM2U6ylwoF15z/ivF2y3gFDTGTKpCmn62
        F2Ae9bLaaP5CUrluqwPh0ddrTDm5o6Q3uZMLbfvt0EBwmMR+PnCIZytw8srANGwC
        D9JcqQ9sE+SruupxUuBv0CJtC62qrcSl73NQpjM8gwVsNtT0nrml7H3KbBf1doiw
        ==
X-ME-Sender: <xms:Q2q7YB54fnEfX6mH32TaiKKmEaXTnIQeF4VWdfAsVlj02X3btYGjYA>
    <xme:Q2q7YO40Yvog3dpEFW5WFY6Wvpo9c3vZb96KWu_D3CrQf96JQgrVw6QmINff8f3to
    v3v6ZzKG--5uM5CniU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtfedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Q2q7YIe1Jv7qmmIMci7Gr-PNWq-CwWYbz-GTi3fINlLWpdYkWsVzDg>
    <xmx:Q2q7YKIA6qxdJB0QFZQ1CZO8rYGpSHuSGgyDnheJvK08Q7aSBg14KA>
    <xmx:Q2q7YFKVzykK6BPKOeUIirfIyapc40AnujpiEkOW9m75vbjCZLMCww>
    <xmx:RWq7YM8NGu4nGXOPK4nOCz6pt8G8SdC7opf2DIxPuqSHjURRuy9Tig>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B6BE651C0060; Sat,  5 Jun 2021 08:12:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <02176203-7f29-4ff4-933b-70235cf0dd22@www.fastmail.com>
In-Reply-To: <YLnZtJtUKdif47zE@atomide.com>
References: <20210524182745.22923-1-sven@svenpeter.dev>
 <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
 <YK32Mmiq9QXGkELF@atomide.com>
 <9ff6ec26-4b78-4684-9c23-16d5cbfef857@www.fastmail.com>
 <YLdOsA63GyMj4SgR@atomide.com>
 <1ff54382-7137-49d6-841d-318e400e956e@www.fastmail.com>
 <YLnZtJtUKdif47zE@atomide.com>
Date:   Sat, 05 Jun 2021 14:12:31 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Tony Lindgren" <tony@atomide.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH 0/3] Apple M1 clock gate driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Fri, Jun 4, 2021, at 09:43, Tony Lindgren wrote:
> Hi,
> 
> How about the following where you set up the gate clocks as separate 
> child nodes:
> 
> pmgr0: clock-controller@23b700000 {
> 	compatible = "apple,foo-clock-controller";
> 	#clock-cells = <1>;
> 	reg = <0x2 0x3b700000 0x0 0x4000>;
> 
> 	clk_uart0: clock@270 {
> 		compatible = "apple,t8103-gate-clock";
> 		#clock-cells = <0>;
> 		assigned-clock-parents = <&pmgr0 APPLE_CLK_SIO>,
> 					 <&pmgr0 APPLE_CLK_UART_P>;
> 		// ...
> 	};
> 
> };
> 
> Keep the clock controller still addressable by offset from base as discussed,
> and additionally have the driver parse and set up the child node clocks.

Nice, I like that one even better! We can keep the internal clocks "hidden"
inside the parent node and only need to model the actual consumer clocks
as separate nodes.

Are you aware of any clock driver that implements something similar?
I'd like to avoid reinventing the wheel if it's already been done before.

> 
> Then I think the consumer driver can just do:
> 
> serial0: serial@235200000 {
> 	// ...
> 	clocks = <&clk_uart0>, <&clk24>;
> 	clock-names = "uart", "clk_uart_baud0";
> 	// ...
> };
> 
> Regards,
> 
> Tony
> 

Best,

Sven
