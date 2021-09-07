Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24933403018
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346891AbhIGVIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:08:06 -0400
Received: from rosenzweig.io ([138.197.143.207]:46240 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346428AbhIGVIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:08:02 -0400
Date:   Tue, 7 Sep 2021 17:06:48 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mailbox: apple: Add driver for Apple mailboxes
Message-ID: <YTfUaER6aq+YjBFs@sunset>
References: <20210907145501.69161-1-sven@svenpeter.dev>
 <20210907145501.69161-4-sven@svenpeter.dev>
 <YTe1cFs5ERe9LDu8@sunset>
 <39b92560-b236-4abb-9de0-ac3a3fa3a506@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39b92560-b236-4abb-9de0-ac3a3fa3a506@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > + * Both the main CPU and the co-processor see the same set of registers but
> > > + * the first FIFO (A2I) is always used to transfer messages from the application
> > > + * processor (us) to the I/O processor and the second one (I2A) for the
> > > + * other direction.
> > 
> > Do we actually know what the copro sees? It seems obvious, but *know*?
> 
> Yes, I know. They see the exact same set of registers. I wouldn't have written
> it like that otherwise.

Ack.

> > > +struct apple_mbox {
> > > +	void __iomem *regs;
> > > +	const struct apple_mbox_hw *hw;
> > > +     ...
> > > +};
> > 
> > This requires a lot of pointer chasing to send/receive messages. Will
> > this become a perf issue in any case? It'd be good to get ballparks on
> > how often these mboxes are used. (For DCP, it doesn't matter, only a few
> > hundred messages per second. Other copros may have different behaviour)
> 
> If this actually becomes a problem I'm happy to fix it but right now
> this feels like premature optimization to me. DCP is going to be the
> worst offender followed by SMC (at most a few per second when it's really
> busy during boot time) and SEP (I've also never seen more than a few per
> second here). The rest of them are mostly quiet after they have booted.

Good enough for me -- it won't matter for DCP, so if it doesn't get any
worse than DCP there's no point in optimizing this.

> > > +static bool apple_mbox_hw_can_send(struct apple_mbox *apple_mbox)
> > > +{
> > > +	u32 mbox_ctrl =
> > > +		readl_relaxed(apple_mbox->regs + apple_mbox->hw->a2i_control);
> > > +
> > > +	return !(mbox_ctrl & apple_mbox->hw->control_full);
> > > +}
> > 
> > If you do the pointer chasing, I suspect you want accessor
> > functions/macros at least to make it less intrusive...
> 
> There's regmap but that can't easily be used here because I need 32bit
> and 64bit writes. I also don't really see the advantage of replacing
> this with some custom functions like e.g.
> 
> 	mbox_ctrl = apple_mbox_hw_readl(apple_mbox, apple_mbox->hw->a2i_control);
> 
> which is almost as long. And if I introduce a separate function just to read the
> control reg this just becomes a lot of boilerplate and harder to follow.
> 
> Or did you have anything else in mind?

I was envisioning a macro:

>	#define apple_mbox_readl(mbox, name) \
>		readl_relaxed(mbox->regs + mbox->hw-> ## name)
>
> 	mbox_ctrl = apple_mbox_readl(apple_mbox, a2i_control);

Now that I've typed it out, however, it seems a bit too magical to
justify the minor space savings. And given you need both 32b and 64b
there would be ~4 such macros which is also a lot of boilerplate.

It's not a huge deal either way but I thought I'd raise it.

> > > +	dev_dbg(apple_mbox->dev, "> TX %016llx %08x\n", msg->msg0, msg->msg1);
> > 
> > Isn't "TX" redundant here?
> 
> Sure, but it also doesn't hurt in a debug message. I can spot the TX easier
> but I'm sure there are people who prefer >.

Fair enough.

> > > +	dev_dbg(apple_mbox->dev, "got FIFO empty IRQ\n");
> > 
> > I realize it's a dev_dbg but this still seems unnecessarily noisy.
> 
> This code path is almost never reached. I've only been able to trigger
> it by forcing send_message to return EBUSY even when it could still
> move messages to the FIFO to test this path.
> This also can't be triggered more often than the TX debug message.
> If this triggers more often there's a bug somewhere that kept the interrupt
> enabled and then the whole machine will hang due an interrupt storm anyway. In
> that case I'd prefer to have this as noisy as possible.

Ah! Sure, makes sense. Is it worth adding a few words to the functions
comments indicating this rarely occurs in good conditions?

> > > +static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
> > > +{
> > > +	struct apple_mbox *apple_mbox = data;
> > > +	struct apple_mbox_msg msg;
> > > +
> > > +	while (apple_mbox_hw_can_recv(apple_mbox)) {
> > > +		apple_mbox_hw_recv(apple_mbox, &msg);
> > > +		mbox_chan_received_data(&apple_mbox->chan, (void *)&msg);
> > > +	}
> > ```
> > 
> > A comment is warranted why this loop is safe and will always terminate,
> > especially given this is an IRQ context. (Ah... can a malicious
> > coprocessor DoS the AP by sending messages faster than the AP can
> > process them? freezing the system since preemption might be disabled
> > here? I suppose thee's no good way to protect against that level of
> > goofy.)
> 
> The only way this can't terminate is if the co-processor tries to stall
> us with messages, but what's your threat model here? If the co-processor wants
> to be evil it usually has many other ways to annoy us (e.g. ANS could just disable
> NVMe, SMC could just trigger a shutdown, etc.)
> 
> I could move this to threaded interrupt context though which would make that a bit
> harder to pull off at the cost of a bit more latency from incoming messages.
> Not sure that's worth it though.

Probably not worth it, no.

> > 
> > > +	 * There's no race if a message comes in between the check in the while
> > > +	 * loop above and the ack below: If a new messages arrives inbetween
> > > +	 * those two the interrupt will just fire again immediately after the
> > > +	 * ack since it's level sensitive.
> > 
> > I don't quite understand the reasoning. Why have IRQ controls at all
> > then on the M3?
> 
> Re-read the two lines just above this one. If the interrupt is not acked here
> it will keep firing even when there are no new messages.
> But it's fine to ack it even when there are message available since it will
> just trigger again immediately.

Got it, thanks.

> > > +	/*
> > > +	 * Only some variants of this mailbox HW provide interrupt control
> > > +	 * at the mailbox level. We therefore need to handle enabling/disabling
> > > +	 * interrupts at the main interrupt controller anyway for hardware that
> > > +	 * doesn't. Just always keep the interrupts we care about enabled at
> > > +	 * the mailbox level so that both hardware revisions behave almost
> > > +	 * the same.
> > > +	 */
> > 
> > Cute. Does macOS do this? Are there any tradeoffs?
> 
> Not sure if macOS does is and I also don't see a reason to care what it
> does exactly. I've verified that this works with the M3 mailboxes.
> I also don't see why there would there be any tradeoffs.
> Do you have anything specific in mind?
> 
> I suspect this HW was used in previous SoCs where all four interrupts
> shared a single line and required this chained interrupt controller
> at the mailbox level. But since they are all separate on the M1 it's
> just a nuisance we have to deal with - especially since the ASC
> variant got rid of the interrupt controls.

Makes sense for a legacy block 👍
