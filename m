Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5CA402F96
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbhIGUZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:25:17 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36725 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346397AbhIGUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:25:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EB48F5C01E6;
        Tue,  7 Sep 2021 16:24:07 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Tue, 07 Sep 2021 16:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=uMJzNSDUeuqOaFPwWQfIZJ33AHPd
        KvrFZcDObQPT1Ko=; b=qTLy+r0xyTU5sH2PO9DFSoItV0fLYNOOHI15jRzKA7+7
        eXhh/BlzuT/kRrxaPJbHd1r9SsjpCgR/yPoxU9o9Eps/nbzIaqIL0fdm5nsfTPO8
        8Gf3sQ4Nn/zh9rM7tjw1J2sy4L35i8rJi0IIYfLeJXvL+hRCLiud/Rf4Ae9XJKZf
        ZiZWZB2wtM9ZcvwEOwkXjvpFw9s8DRxvOu8IDDFJIH/QxpRVMMCsrLAid2HQp0yT
        tYTEGrztmMkHVFyJp8tP6veYbaevrHqt9216foAhRAIelNBfK6WuL7p3pgA9k67g
        vINplNmp4eaBvaM0lJ+kLs94WAIMixzHtBcb47twPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uMJzNS
        DUeuqOaFPwWQfIZJ33AHPdKvrFZcDObQPT1Ko=; b=QN20SoXnxVibZmhiilN48t
        90hfIhV+HRsP+maVU30jj/V0KGCn7Csu+auW6IIUjsmlBgQzdtTs3QJz+YrDejfp
        a/yB9iPmYKS93RgPbVPI+NqkiGx1WUvpQxf501cT2ENgLV9UGyW2fbH35JNNmCXQ
        TUOP8qW7p8jlfA+T3EhLiwrPrMxPdLDlCD3Xpp1vP7miRtrcsp5+NfJJz4EmBnyj
        MNL9Q2VnrcvzKCPrhQOO33d92jz0OrY3wWBf9ZDvKcRKmwEXXl0PskR5fJkdDS9R
        Uso6lU+68hyusBCzeUc0pf9uTOYZt51PKIDLFveraUDq6gZ970pNw7wnO8OC59YQ
        ==
X-ME-Sender: <xms:Zso3YVKiiPQzhawxivhMJovGUQhdORw-lPsnER6UAyvDFPxwNigTqg>
    <xme:Zso3YRLlkOc5F52roICjXa4svKbTF_mQOilyu5FNtmQjetmcbJGcMKho5yNQC8Tt5
    e7q5iy0fq6g32cq-8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefhedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepfeejtdffvdehtefhkeekkeelhfefjeeufeetkeeigfejhffftddtieeh
    hfdtkefgnecuffhomhgrihhnpehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Zso3YdsMeIazzIdSIJlD-g9ITdaDTOhDsk9ks_vJA-qfCUCzIjMw9A>
    <xmx:Zso3YWancSV16OIgNd56Nn8M6HNgQ4P0K0ieT8SLYV_QHWPq7IyrjA>
    <xmx:Zso3YcauFRAXVxaMDMChXK7ee-iHfa6Ihn64TVhZOwLmfbtvpsTVvw>
    <xmx:Z8o3Yc7XJWyoFPRmDD4gUjoItLVWIPRwaW5i_EhMfpK0znlmTgEYaA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5B57A51C0060; Tue,  7 Sep 2021 16:24:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1126-g6962059b07-fm-20210901.001-g6962059b
Mime-Version: 1.0
Message-Id: <39b92560-b236-4abb-9de0-ac3a3fa3a506@www.fastmail.com>
In-Reply-To: <YTe1cFs5ERe9LDu8@sunset>
References: <20210907145501.69161-1-sven@svenpeter.dev>
 <20210907145501.69161-4-sven@svenpeter.dev> <YTe1cFs5ERe9LDu8@sunset>
Date:   Tue, 07 Sep 2021 22:23:02 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Hector Martin" <marcan@marcan.st>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mailbox: apple: Add driver for Apple mailboxes
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review!

On Tue, Sep 7, 2021, at 20:54, Alyssa Rosenzweig wrote:
> > +	  Apple SoCs have various co-processors that need to be started and
> > +	  initialized for certain peripherals to work (NVMe, display controller,
> > +	  etc.). This driver adds support for the mailbox controller used to
> > +	  communicate with those.
> 
> This makes it seem like it's just a boot time issue. Maybe that's the
> case for NVMe? In general the mailbox is needed 100% of the time. I
> suggest something like:
> 
> 	  Apple SoCs have various co-processors required for certain
> 	  peripherals to work (NVMe, display controller, etc.). This
> 	  driver adds support for the mailbox controller used to
> 	  communicate with those.

Sure.

> 
> > + * Copyright (C) 2021 The Asahi Linux Contributors
> 
> Isn't this all you?

Yes, but see e.g. the discussion on the M1 bringup series [1][2].

[1] https://www.linuxfoundation.org/en/blog/copyright-notices-in-open-source-software-projects/
[2] https://lore.kernel.org/linux-arm-kernel/d8454963-3242-699b-4c20-e85d26b19796@marcan.st/

> 
> > + * Various clients implement different IPC protocols based on these simple
> 
> s/clients/coprocessors/ or firmware or something?

Sure.

> 
> > + * Both the main CPU and the co-processor see the same set of registers but
> > + * the first FIFO (A2I) is always used to transfer messages from the application
> > + * processor (us) to the I/O processor and the second one (I2A) for the
> > + * other direction.
> 
> Do we actually know what the copro sees? It seems obvious, but *know*?

Yes, I know. They see the exact same set of registers. I wouldn't have written
it like that otherwise.

> 
> > +#define APPLE_ASC_MBOX_CONTROL_FULL BIT(16)
> > +#define APPLE_ASC_MBOX_CONTROL_EMPTY BIT(17)
> > +
> > +#define APPLE_ASC_MBOX_A2I_CONTROL 0x110
> > +#define APPLE_ASC_MBOX_A2I_SEND0 0x800
> > +#define APPLE_ASC_MBOX_A2I_SEND1 0x808
> > +#define APPLE_ASC_MBOX_A2I_RECV0 0x810
> > +#define APPLE_ASC_MBOX_A2I_RECV1 0x818
> > +
> > +#define APPLE_ASC_MBOX_I2A_CONTROL 0x114
> > +#define APPLE_ASC_MBOX_I2A_SEND0 0x820
> > +#define APPLE_ASC_MBOX_I2A_SEND1 0x828
> > +#define APPLE_ASC_MBOX_I2A_RECV0 0x830
> > +#define APPLE_ASC_MBOX_I2A_RECV1 0x838
> > +
> > +#define APPLE_M3_MBOX_A2I_CONTROL 0x50
> > +#define APPLE_M3_MBOX_A2I_SEND0 0x60
> > +#define APPLE_M3_MBOX_A2I_SEND1 0x68
> > +#define APPLE_M3_MBOX_A2I_RECV0 0x70
> > +#define APPLE_M3_MBOX_A2I_RECV1 0x78
> > +
> > +#define APPLE_M3_MBOX_I2A_CONTROL 0x80
> > +#define APPLE_M3_MBOX_I2A_SEND0 0x90
> > +#define APPLE_M3_MBOX_I2A_SEND1 0x98
> > +#define APPLE_M3_MBOX_I2A_RECV0 0xa0
> > +#define APPLE_M3_MBOX_I2A_RECV1 0xa8
> > +
> > +#define APPLE_M3_MBOX_CONTROL_FULL BIT(16)
> > +#define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
> 
> The ordering here is asymmetric (control bits on top or on bottom). Also
> might be nicer to align things.

Sure, I'll move them to the top for M3 as well.

> 
> > +struct apple_mbox {
> > +	void __iomem *regs;
> > +	const struct apple_mbox_hw *hw;
> > +     ...
> > +};
> 
> This requires a lot of pointer chasing to send/receive messages. Will
> this become a perf issue in any case? It'd be good to get ballparks on
> how often these mboxes are used. (For DCP, it doesn't matter, only a few
> hundred messages per second. Other copros may have different behaviour)

If this actually becomes a problem I'm happy to fix it but right now
this feels like premature optimization to me. DCP is going to be the
worst offender followed by SMC (at most a few per second when it's really
busy during boot time) and SEP (I've also never seen more than a few per
second here). The rest of them are mostly quiet after they have booted.

> 
> > +static bool apple_mbox_hw_can_send(struct apple_mbox *apple_mbox)
> > +{
> > +	u32 mbox_ctrl =
> > +		readl_relaxed(apple_mbox->regs + apple_mbox->hw->a2i_control);
> > +
> > +	return !(mbox_ctrl & apple_mbox->hw->control_full);
> > +}
> 
> If you do the pointer chasing, I suspect you want accessor
> functions/macros at least to make it less intrusive...

There's regmap but that can't easily be used here because I need 32bit
and 64bit writes. I also don't really see the advantage of replacing
this with some custom functions like e.g.

	mbox_ctrl = apple_mbox_hw_readl(apple_mbox, apple_mbox->hw->a2i_control);

which is almost as long. And if I introduce a separate function just to read the
control reg this just becomes a lot of boilerplate and harder to follow.

Or did you have anything else in mind?

> 
> > +	dev_dbg(apple_mbox->dev, "> TX %016llx %08x\n", msg->msg0, msg->msg1);
> 
> Isn't "TX" redundant here?

Sure, but it also doesn't hurt in a debug message. I can spot the TX easier
but I'm sure there are people who prefer >.

> 
> > +	dev_dbg(apple_mbox->dev, "got FIFO empty IRQ\n");
> 
> I realize it's a dev_dbg but this still seems unnecessarily noisy.

This code path is almost never reached. I've only been able to trigger
it by forcing send_message to return EBUSY even when it could still
move messages to the FIFO to test this path.
This also can't be triggered more often than the TX debug message.
If this triggers more often there's a bug somewhere that kept the interrupt
enabled and then the whole machine will hang due an interrupt storm anyway. In
that case I'd prefer to have this as noisy as possible.

> 
> > +static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
> > +{
> > +	struct apple_mbox *apple_mbox = data;
> > +	struct apple_mbox_msg msg;
> > +
> > +	while (apple_mbox_hw_can_recv(apple_mbox)) {
> > +		apple_mbox_hw_recv(apple_mbox, &msg);
> > +		mbox_chan_received_data(&apple_mbox->chan, (void *)&msg);
> > +	}
> ```
> 
> A comment is warranted why this loop is safe and will always terminate,
> especially given this is an IRQ context. (Ah... can a malicious
> coprocessor DoS the AP by sending messages faster than the AP can
> process them? freezing the system since preemption might be disabled
> here? I suppose thee's no good way to protect against that level of
> goofy.)

The only way this can't terminate is if the co-processor tries to stall
us with messages, but what's your threat model here? If the co-processor wants
to be evil it usually has many other ways to annoy us (e.g. ANS could just disable
NVMe, SMC could just trigger a shutdown, etc.)

I could move this to threaded interrupt context though which would make that a bit
harder to pull off at the cost of a bit more latency from incoming messages.
Not sure that's worth it though.

> 
> > +	 * There's no race if a message comes in between the check in the while
> > +	 * loop above and the ack below: If a new messages arrives inbetween
> > +	 * those two the interrupt will just fire again immediately after the
> > +	 * ack since it's level sensitive.
> 
> I don't quite understand the reasoning. Why have IRQ controls at all
> then on the M3?

Re-read the two lines just above this one. If the interrupt is not acked here
it will keep firing even when there are no new messages.
But it's fine to ack it even when there are message available since it will
just trigger again immediately.

> 
> > +	if (apple_mbox->hw->has_irq_controls)
> > +		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty,
> > +			       apple_mbox->regs + apple_mbox->hw->irq_ack);
> 
> Nit: { braces } since this is two lines. Unless kernel likes this sort
> of scary aesthetic. Would go away with an accessor, of course.

Sure.

> 
> > +	/*
> > +	 * Only some variants of this mailbox HW provide interrupt control
> > +	 * at the mailbox level. We therefore need to handle enabling/disabling
> > +	 * interrupts at the main interrupt controller anyway for hardware that
> > +	 * doesn't. Just always keep the interrupts we care about enabled at
> > +	 * the mailbox level so that both hardware revisions behave almost
> > +	 * the same.
> > +	 */
> 
> Cute. Does macOS do this? Are there any tradeoffs?

Not sure if macOS does is and I also don't see a reason to care what it
does exactly. I've verified that this works with the M3 mailboxes.
I also don't see why there would there be any tradeoffs.
Do you have anything specific in mind?

I suspect this HW was used in previous SoCs where all four interrupts
shared a single line and required this chained interrupt controller
at the mailbox level. But since they are all separate on the M1 it's
just a nuisance we have to deal with - especially since the ASC
variant got rid of the interrupt controls.

> 
> > +	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-recv", dev_name(dev));
> ...
> > +	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-send", dev_name(dev));
> 
> Not sure this is better or worse than specifying IRQ names in the device
> tree... probably less greppable.

This name will appear in e.g. /proc/interrupts and at least the device name
should be in there. Usually only dev_name is used here but since we have two
interrupts they should have different names. The names from the DT are taken a
few lines above when calling platform_get_irq_byname.

> 
> > +++ b/include/linux/apple-mailbox.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> > +/*
> > + * Apple mailbox message format
> > + *
> > + * Copyright (C) 2021 The Asahi Linux Contributors
> > + */
> > +
> > +#ifndef _LINUX_APPLE_MAILBOX_H_
> > +#define _LINUX_APPLE_MAILBOX_H_
> > +
> > +#include <linux/types.h>
> > +
> > +struct apple_mbox_msg {
> > +	u64 msg0;
> > +	u32 msg1;
> > +};
> > +
> > +#endif
> 
> Seems like such a waste to have a dedicated file for a single structure
> :'( I guess it's needed for the rtkit library but still ....
> 

It's needed for all clients that will use this mailbox controller, but yeah,
no way around this.



Sven
