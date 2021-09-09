Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C1D4048AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhIIKqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:46:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47825 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234319AbhIIKqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:46:52 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 39B0A5C01B2;
        Thu,  9 Sep 2021 06:45:41 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Thu, 09 Sep 2021 06:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=zjIGVs2CTSfPn8AaN0qQdBKPQtKq
        vzq2wmfTBbAMSSQ=; b=fj/s+jh7Uib0rMCoCxGuDxNn2kpbAswm52/4fCPlbViD
        fDdjJOOKaDe9yiyE18zJNHzBvGzqswalewOo69DRh0fQp2Y79hcB3+2EIMUYOaig
        BLpliyouCg7CKy6hnw334EEf3dOMq3UqdDHT3//h/2RgMXSVOhnhoJJa6aHz3Hke
        sVXmId0PhEcI/UZlj3MkzcH6HDzI/aEqzSQW0uo20cGnfoQvy1hIocmP8D1xyAmT
        uHPuQOZuyw9ICwen9gzicq8s+gSIJK4N2sX2e4SQwWUa8vOULhmDJ7WNOsCWwq3Y
        x5VIFanVeOzgJSuylNyXiLurtpaBu51OwuVQP4NIvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zjIGVs
        2CTSfPn8AaN0qQdBKPQtKqvzq2wmfTBbAMSSQ=; b=uSx4m4kgEySHfBqsvIYM5e
        HHSnI1utlcUFa5O+se5kaPWcXf5b70xYGZqS5/lo9WLfolkbp2mqtkRGC4JGpLWg
        UMRG0M1LAJRDjU+V4XRSZiUOYXztA7kKiNBrAXe5lK7Hqt7/ujfITEKlOWzRDCz0
        27WQcF5OSNk7DmML/vbQM2EThNuSX7yaiTqPRS3veJvG6c3EtXaDYGbH97GkHSAV
        WDphF3WeYpjdTM/DYLMmqs2B0XS0I52iLt6GuFYrFvrhBEdKnVhDnuL/CQ9H9aVS
        nzY8qd6tCJD+gFMpH0QEdKHcb5nMJhDggOpY6USmlH4g/VYYRMs7J2JR0z9o9drA
        ==
X-ME-Sender: <xms:1OU5YdGwtJLsC7vdOaCCefuNiXlD1P8DZIPRJngocL8hlUhK0pMURw>
    <xme:1OU5YSUrbVREtMb4hZbs05voZ8NGAthUg1dAH3tLUIWlU60fIKg0jcLj33F7aBKcl
    UzERr4hn5Y578zGg4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefledgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:1OU5YfL0utqX42xwjOWb58YI7kCV3ld74YXRGsZA-7pr5psuj0b_aA>
    <xmx:1OU5YTEjpwl1RtBW7uuQ8oZ61wE9cCTi96D6sjhlAsdNkbsXpHbwuA>
    <xmx:1OU5YTXGN3ENBem0P65EiNycgghSZFiVSNw4_VK41W3rblACjcoAqw>
    <xmx:1eU5YaHIO6mlRAeWwIWis2rj8ojaceXOpDWxX6dlTrZ6bkZFzkI6Ng>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 45F5451C0061; Thu,  9 Sep 2021 06:45:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1229-g7ca81dfce5-fm-20210908.005-g7ca81dfc
Mime-Version: 1.0
Message-Id: <8d646201-5257-47bd-b89e-d702051ff363@www.fastmail.com>
In-Reply-To: <CABb+yY3LYwybJfXTndPx5T+zKu4DdrSzNY0SAsZBr_qvfscEmw@mail.gmail.com>
References: <20210907145501.69161-1-sven@svenpeter.dev>
 <CABb+yY3LYwybJfXTndPx5T+zKu4DdrSzNY0SAsZBr_qvfscEmw@mail.gmail.com>
Date:   Thu, 09 Sep 2021 12:44:46 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Jassi Brar" <jassisinghbrar@gmail.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        "Devicetree List" <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Apple Mailbox Controller support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Sep 8, 2021, at 22:48, Jassi Brar wrote:
> On Tue, Sep 7, 2021 at 9:55 AM Sven Peter <sven@svenpeter.dev> wrote:
> >
> > Hi,
> >
> > This series adds support for the mailbox HW found in the Apple M1. These SoCs
> > have various co-processors controlling different peripherals (NVMe, display
> > controller, SMC (required for WiFi), Thunderbolt, and probably more
> > we don't know about yet). All these co-processors communicate with the main CPU
> > using these mailboxes. These mailboxes transmit 64+32 bit messages, are
> > backed by a hardware FIFO and have four interrupts (FIFO empty and FIFO not
> > empty for the transmit and receive FIFO each).
> >
> > The hardware itself allows to send 64+32 bit message using two hardware
> > registers. A write to or read from the second register transmits or receives a
> > message. Usually, the first 64 bit register is used for the message itself and
> > 8 bits of the second register are used as an endpoint. I originally considered
> > to have the endpoint exposed as a mailbox-channel, but finally decided against
> > it: The hardware itself only provides a single channel to the co-processor and
> > the endpoint bits are only an implementation detail of the firmware. There's
> > even one co-processor (SEP) which uses 8 bits of the first register as its
> > endpoint number instead.
> > There was a similar discussion about the BCM2835 / Raspberry Pi mailboxes
> > which came to the same conclusion [1].
> >
> > These mailboxes also have a hardware FIFO which make implementing them with the
> > current mailbox a bit tricky: There is no "transmission done" interrupt because
> > most transmissions are "done" immediately. There is only a "transmission fifo
> > empty" level interrupt. I have instead implemented this by adding a fast-path to
> > the core mailbox code as a new txready_fifo mode.
> > The other possibilities (which would not require any changes to the core mailbox
> > code) are to either use the polling mode or to enable the "tx fifo empty"
> > interrupt in send_message and then call txready from the irq handler before
> > disabling it again. I'd like to avoid those though since so far I've never seen
> > the TX FIFO run full which allows to almost always avoid the context switch when
> > sending a message. I can easily switch to one of these modes if you prefer to
> > keep the core code untouched though.
> >
> Yes, please keep the api unchanged.
> Let us please not dig our own tunnels when the existing ways serve the purpose.
> 

Ok, I'll use txdone_irq for v2 then and just ignore the HW FIFO.

Thanks,

Sven
