Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8895F395092
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 13:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhE3LHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 07:07:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35135 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3LHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 07:07:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F11145C00AD;
        Sun, 30 May 2021 07:05:55 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sun, 30 May 2021 07:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=u0MhSb585QgPJzlJXW10jkFwsiRu
        ZjELPPZmVFDxz7Y=; b=6JNGLtvnl34MbkNuqB6p8CcHV2oVISaQaVRWwrwIrCkG
        hpk6EryP65iSK6ODddL5iOkhrOkvp6QdAEpzT4LJxNPe6tt+7rcHn3VL5Y9D9yJi
        d5GB8Stt8dvi1zqzwITKgBTdUaWeVVzSHhHFVhf4KXdCOnRFW/qUTHCXIx91lPda
        6tJ4nHIO0BZxR4Owr9f7COA5DMHOwfe/pmxkvLRU6zi8Xqpcg1m9RmphRylMyt6t
        svGuKpjJnKLINaXYGFZWl7NF/iAXwOqeNn2oL8xJaBD7cP971AMmD6kRb3DN0Nr0
        2X6MRZ4tIimluxeiJ+sA6G6kRL2ijvIWl6v79uyPkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=u0MhSb
        585QgPJzlJXW10jkFwsiRuZjELPPZmVFDxz7Y=; b=CFb6s8lUqbLC3bgTAb2QCK
        g+XEYDy+9hPqcap7fWOeNDlIN+/MqlcdninjIYjVysBzmqML1YcYOA3XqkpgQhqB
        +wn1sddiUXzdKjsWwMkq3iKbU0yryUGx52f64we2RCmu1x8hP8h6LovkQfQEqo05
        IndE65PIA5bzxzmlqYh70UsrRKwP6sXI17LcHo8I62u0oV0+5Cy/DPcYMz1+26jm
        nCsCKyCEx9KtOUQm3GljXC/Psxq7dpNNB7uOppgxBpq1Z1v403BlSO6EvLKLxnWh
        4NOp7w/V/Df3O6PAeYQI1x6DrimzxkwNvcPVQdjTd0LPEoqQ3MBig/xqfrHKgGgQ
        ==
X-ME-Sender: <xms:knGzYI3S9_mxBkbCfYc0JlrVd-h8fiFZcxFTwI7WGC5cRN_BzMuP8A>
    <xme:knGzYDFwob1w7vGI0ZKzXmBHbSQXWTL3B2gBgyGTI4qvt6PftdscuPpZuRMzw51Za
    JNcEPlQQH7TXM-2sv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeluddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:knGzYA4jFauztDL6eTjxpjUqaNAVuBV6dcq82JatqNTJBOS8SqMbIg>
    <xmx:knGzYB3tSY9pTPcu93jaflx3nf3UpIRkR0ktmv94WpxbNVz1rYbemw>
    <xmx:knGzYLHHgWaTTx0BsJ43R-xyBfRP9Xmvphm1llhfVqVQ8saZnkTdlQ>
    <xmx:k3GzYK1oe5Hc66iWidYHsdSddClSUA4XQjKnG4KyXpdmA9BTQ7yzxA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B350751C0060; Sun, 30 May 2021 07:05:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-468-gdb53729b73-fm-20210517.001-gdb53729b
Mime-Version: 1.0
Message-Id: <6052f2f1-1e3f-474e-a767-e08ca19fbd43@www.fastmail.com>
In-Reply-To: <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
References: <20210524182745.22923-1-sven@svenpeter.dev>
 <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
Date:   Sun, 30 May 2021 13:05:20 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
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



On Tue, May 25, 2021, at 19:41, Rob Herring wrote:
> On Mon, May 24, 2021 at 1:28 PM Sven Peter <sven@svenpeter.dev> wrote:
> >
> > Additionally, these clocks have a topology that is usually specified in Apple's
> > Device Tree. As far as I can tell most Linux drivers seem to encode this topology
> > directly in the source code though. Despite this, we would still like to encode
> > the topology in the device tree itself:
> 
> We only define leaf clocks primarily. There's some exceptions such as
> if PLLs are a separate h/w block. The reason for this is because
> typical SoCs have 100s of just leaf clocks. If we tried to model
> everything, it would never be complete nor correct. Actually, we did
> try that at first.

Makes sense.

For Apple SoCs specifically most topology seems to documented (with names!)
in the arm-io/pmgr device node of their ADT.

> 
> > Apple seems to only change HW blocks when they have a very good reason and even
> > then they seem to keep the changes minimal. This specific clock gate MMIO block
> > has already been used in the Apple A7 released in 2013. The only differences
> > since then are the available clocks (which can be identified by a simple offset)
> > and their topology.
> 
> Clock gates are easy. What about muxes, dividers, etc.?

These are preconfigured by iBoot long before we get control and I'm not
sure we will be able to figure out how they work in detail. All we know
are their frequencies and we will probably have to just treat them as
fixed frequency clocks.

Some details:

In Apple's device tree, each node can have a "clock-gates" or "power-gates"
property which refer to clock gates required to enable the peripheral.
These are implemented with this small driver and required to make most of
the hardware work. Most of these are turned off by the time we get control.

Additionally, there is a "clocks" property that either refers to one of
eight or so static clocks (starting at index 0) which are not backed by any
configurable PLL, mux or divider. On top of that there is a list of what I
believe to be mux/divider clocks (index >0x100) specified by the
clock-frequencies and clock-frequencies-regs properties of the arm-io node.
These registers are in a separate MMIO region and XNU only seems to use
clock-frequencies to find the clock rate. It never even reads
clock-frequencies-regs.

While I can guess some of the bits of these registers (I believe I know the
enable bit and the divisor field and possibly the input select but I do not
know the inputs and believe they are actually different for each clock) I
don't see a need to implement them right now. If we need them in the future
they'd probably be a separate node anyway since they are all also located in
an entirely different MMIO region and not related to these gates at all.


> 
> > It's likely that Apple will still use this block in future SoCs as well. By
> > encoding the clock gate topology inside the device tree as well we can use a
> > single driver and only need updates to the device tree once they are released.
> > This might allow end users to already run their favorite distribution by just
> > updating the bootloader with a new device tree instead of having to wait until
> > the new topology is integrated into their distro kernel.
> >
> > Additionally, the driver itself can be kept very simple and not much code needs
> > to be duplicated and then updated for each new SoC between various consumers of
> > these device tree nodes (Linux, u-boot, and OpenBSD for now).
> >
> >
> > This series therefore creates a single device tree node for each clock gate.
> > This unfortunately maps a whole page out of which only a single register will
> > be used for each node.
> >
> > The other alternative I considered was to create a syscon/simple-mfd node
> > and have the clock nodes as children. The gates would then use a regmap which
> > would only require a single entry in the pagetable for all clocks. I decided
> > against this option since the clock gate MMIO region actually isn't a
> > multi-function device.
> 
> I would do a single node per mmio region with the register offset (or
> offset / 4) being the clock id. This can still support new SoCs easily
> if you have a fallback compatible. If you want/need to get all the
> clocks, just walk the DT 'clocks' properties and extract all the IDs.
> 

The problem with that approach is that to enable e.g. UART_0 we actually need
to enable its parents as well, e.g. the Apple Device Tree for the M1 has the
following clock topology:

    UART0  (0x23b700270), parent: UART_P
    UART_P (0x23b700220), parent: SIO
    SIO    (0x23b7001c0), parent: n/a

The offsets and the parent/child relationship for all of these three clocks
change between SoCs. If I now use the offset as the clock id I still need
to specify that if e.g. UART uses <&clk_controller 0x270> I first need
to enable 0x1c0 and then 0x220 and only then 0x270.

I can hardcode this in the driver itself by just selecting the appropriate table
depending on the compatible but I think we're then back to requiring a code
change for new SoCs. Just using the fallback compatible won't be enough unless
I introduce dummy nodes that enable UART_P and SIO as well.

If I do it like this I'll also need two compatibles for the two MMIO regions
since they have different child/parent clocks in there. Any suggestions for
how to call those two then? Just t8103-gate-clock-0/1? 

I'd still prefer to somehow put this information into the device tree since
then only a single compatible that will likely work across many SoC generations
is required. I'm not sure how to do this though.


Best,


Sven
