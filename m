Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3492E39A1A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhFCM55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:57:57 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:51103 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230129AbhFCM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:57:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 31EBD10DE;
        Thu,  3 Jun 2021 08:56:08 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Thu, 03 Jun 2021 08:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=HFjpVEiJoJYTmtnTYuXMoFD2GTAK
        1rJxCBIwvY1xZpg=; b=ySSo951o5sncVZgAfB55+kF/4km0fk2Amn5A4WLBEQ0V
        Nq34zRZXNMjAllZ2CWNCsx4sKXLAqztk6fckgAG/RyvW+v0Xp+P8K410P+4vxp21
        AoZq7/E14y28gvVhvP02kYKQA0rnf37ywDMgikp0ajLJvpysjrr5E3MrxgLsnnqY
        qcsUgGQnPkiQ4o7t4M0MtZHnGhbYwqj2qIF/z6V5rEk/dLqGWStIbbK6dCH+IpZ3
        O9waMWz6lxbsFg9/jveartCnXDvJJQPO3BmRDD9wWKtNHCw5219QdTERCKo7LlyK
        77WHkGsMTM5XmJhDRophnFj02ca0GquAGUVSqn0drw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=HFjpVE
        iJoJYTmtnTYuXMoFD2GTAK1rJxCBIwvY1xZpg=; b=Xl+n3oHhBcL1hQnHtbnyJX
        eCRcmdYQu7nSH5kWriRXYu7Rf9AY0ovULXFljSFlVVXRuyRPp7fglWgE8QYvUp/8
        2H86nGShhzEG+9RkjztQvkPVoFsk8+V+1cT3jpcnpQYaD7tsMxe7RO/s4ekxZSOM
        GpVj6DQ7r6ZJkyzpIw86TH1huoXfBEdZxyA45SNf9VJwKERBUbyc96PvG5ccp99z
        tqpVRXu/OdAGj3yzHV7tZ2/tBxoiyJaf4U3vDUnt0dFCYd3IpHqVra/Wjy2dOrzl
        4aNamLiURNmCgM0kIaXlR2bpaAN92VlIWMS8f/Xnz9OIV3xxvEUbE2vqvfkHa9iQ
        ==
X-ME-Sender: <xms:ZdG4YOgyRbOD09eoA-v8HLecB8H2kqn3_XFopMtbOc4cEbsiZE06Eg>
    <xme:ZdG4YPA4CeYy_hydM3N74fwzWkKQqY_X3Jf4Gp-cIfoAPJ-QnTvjVPdY634UHHULd
    V-OyAxEq1IN4mWxGxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelledgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:ZdG4YGE2tc8oM5bJmxGOK0IuG0ncGSKKJQjK7Ib_lvzKS2xbWREQfw>
    <xmx:ZdG4YHS5UsOn3zTJu_KWyI2BMHN-7_6_H_wlcSFnVfT9EvqbPyBhGw>
    <xmx:ZdG4YLzyCkhALj6SHETXjgrGsWerF6OvIovpFhkxD2wGnNzNvCr6Cw>
    <xmx:Z9G4YCl5EmN4t5MXHD9cfa-chAtc5XcIb7HPKaO8vjZP_uBowiEnYAtacQA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 88B6D51C0060; Thu,  3 Jun 2021 08:56:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <1ff54382-7137-49d6-841d-318e400e956e@www.fastmail.com>
In-Reply-To: <YLdOsA63GyMj4SgR@atomide.com>
References: <20210524182745.22923-1-sven@svenpeter.dev>
 <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
 <YK32Mmiq9QXGkELF@atomide.com>
 <9ff6ec26-4b78-4684-9c23-16d5cbfef857@www.fastmail.com>
 <YLdOsA63GyMj4SgR@atomide.com>
Date:   Thu, 03 Jun 2021 14:55:45 +0200
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

On Wed, Jun 2, 2021, at 11:26, Tony Lindgren wrote:
> * Sven Peter <sven@svenpeter.dev> [210530 11:09]:
> > 
> > Now the big question is *how* to describe this additional data in the
> > dts. Essentially I need to specify that e.g. to enable clock 0x270
> > I first need to enable the (internal) clocks 0x1c0 and then 0x220.
> > Are you aware of any generic way to describe this? I'm not even sure
> > how a sane non-generic way would look like when I just have a single
> > clock controller node.
> 
> To me it seems you might be able to recycle the assigned-clocks and
> assigned-clock-parents etc properties in the clock controller node.
> 
> Sure the assigned-clocks property will point to clocks in the
> clock controller itself, and will have tens of entries, but should
> work :)

Thanks for the suggestion, I really like that idea!


If I understand the assigned-clocks-parent property correctly it's meant to select
one of the possible parents of e.g. a mux clock at startup. Internally it just
uses clk_set_parent which, unless I'm mistaken, would require to assign each
clock as a possible parent of every other clock.

Now the good news is that Apple seems to have sorted the clocks topologically
on the bus, i.e. there never is a clock at address X that requires a parent
with an address bigger than X. 
The bad news is that I'd probably still have to setup clocks at 0x0, 0x4,
0x8, ..., X-0x4 as possible parents of the clock at X.

Another possibility this made me think of is to instead just use the clocks
property the way it's usually used and simply refer to the controller itself, e.g.

#define APPLE_CLK_UART0  0x270
#define APPLE_CLK_UART_P 0x220
#define APPLE_CLK_SIO    0x1c0

pmgr0: clock-controller@23b700000 {
        compatible = "apple,t8103-gate-clock";
        #clock-cells = <1>;
        reg = <0x2 0x3b700000 0x0 0x4000>;
        clock-indices = <APPLE_CLK_SIO>, <APPLE_CLK_UART_P>, <APPLE_CLK_UART0>;
        clock-output-names = "clock-sio", "clock-uart-", "clock-uart0";
        clocks = <&some_dummy_root_clock>, <&pmgr0 APPLE_CLK_SIO>,
                 <&pmgr0 APPLE_CLK_UART_P>;
};

to represent the UART clocks

    UART0  (0x23b700270), parent: UART_P
    UART_P (0x23b700220), parent: SIO
    SIO    (0x23b7001c0), parent: n/a

and then have the consumer as

serial0: serial@235200000 {
    // ...
    clocks = <&pmgr0 APPLE_CLK_UART0>, <&clk24>;
    clock-names = "uart", "clk_uart_baud0";
    // ...
};


I'd have to see if it's possible to implement this sanely though if this binding
was acceptable. The self-reference to a node that hasn't been fully initialized
yet may turn out to be ugly.


> 
> And sounds like you can generate that list with some script from the
> Apple dtb.

Yup, absolutely. I don't want to write this all out by hand if I can avoid
that :-)

> 
> Regards,
> 
> Tony
> 

Thanks,


Sven

