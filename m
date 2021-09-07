Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89E3402E98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbhIGS6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:58:23 -0400
Received: from rosenzweig.io ([138.197.143.207]:46186 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235343AbhIGS6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:58:22 -0400
Date:   Tue, 7 Sep 2021 14:54:40 -0400
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
Message-ID: <YTe1cFs5ERe9LDu8@sunset>
References: <20210907145501.69161-1-sven@svenpeter.dev>
 <20210907145501.69161-4-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907145501.69161-4-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	  Apple SoCs have various co-processors that need to be started and
> +	  initialized for certain peripherals to work (NVMe, display controller,
> +	  etc.). This driver adds support for the mailbox controller used to
> +	  communicate with those.

This makes it seem like it's just a boot time issue. Maybe that's the
case for NVMe? In general the mailbox is needed 100% of the time. I
suggest something like:

	  Apple SoCs have various co-processors required for certain
	  peripherals to work (NVMe, display controller, etc.). This
	  driver adds support for the mailbox controller used to
	  communicate with those.

> + * Copyright (C) 2021 The Asahi Linux Contributors

Isn't this all you?

> + * Various clients implement different IPC protocols based on these simple

s/clients/coprocessors/ or firmware or something?

> + * Both the main CPU and the co-processor see the same set of registers but
> + * the first FIFO (A2I) is always used to transfer messages from the application
> + * processor (us) to the I/O processor and the second one (I2A) for the
> + * other direction.

Do we actually know what the copro sees? It seems obvious, but *know*?

> +#define APPLE_ASC_MBOX_CONTROL_FULL BIT(16)
> +#define APPLE_ASC_MBOX_CONTROL_EMPTY BIT(17)
> +
> +#define APPLE_ASC_MBOX_A2I_CONTROL 0x110
> +#define APPLE_ASC_MBOX_A2I_SEND0 0x800
> +#define APPLE_ASC_MBOX_A2I_SEND1 0x808
> +#define APPLE_ASC_MBOX_A2I_RECV0 0x810
> +#define APPLE_ASC_MBOX_A2I_RECV1 0x818
> +
> +#define APPLE_ASC_MBOX_I2A_CONTROL 0x114
> +#define APPLE_ASC_MBOX_I2A_SEND0 0x820
> +#define APPLE_ASC_MBOX_I2A_SEND1 0x828
> +#define APPLE_ASC_MBOX_I2A_RECV0 0x830
> +#define APPLE_ASC_MBOX_I2A_RECV1 0x838
> +
> +#define APPLE_M3_MBOX_A2I_CONTROL 0x50
> +#define APPLE_M3_MBOX_A2I_SEND0 0x60
> +#define APPLE_M3_MBOX_A2I_SEND1 0x68
> +#define APPLE_M3_MBOX_A2I_RECV0 0x70
> +#define APPLE_M3_MBOX_A2I_RECV1 0x78
> +
> +#define APPLE_M3_MBOX_I2A_CONTROL 0x80
> +#define APPLE_M3_MBOX_I2A_SEND0 0x90
> +#define APPLE_M3_MBOX_I2A_SEND1 0x98
> +#define APPLE_M3_MBOX_I2A_RECV0 0xa0
> +#define APPLE_M3_MBOX_I2A_RECV1 0xa8
> +
> +#define APPLE_M3_MBOX_CONTROL_FULL BIT(16)
> +#define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)

The ordering here is asymmetric (control bits on top or on bottom). Also
might be nicer to align things.

> +struct apple_mbox {
> +	void __iomem *regs;
> +	const struct apple_mbox_hw *hw;
> +     ...
> +};

This requires a lot of pointer chasing to send/receive messages. Will
this become a perf issue in any case? It'd be good to get ballparks on
how often these mboxes are used. (For DCP, it doesn't matter, only a few
hundred messages per second. Other copros may have different behaviour)

> +static bool apple_mbox_hw_can_send(struct apple_mbox *apple_mbox)
> +{
> +	u32 mbox_ctrl =
> +		readl_relaxed(apple_mbox->regs + apple_mbox->hw->a2i_control);
> +
> +	return !(mbox_ctrl & apple_mbox->hw->control_full);
> +}

If you do the pointer chasing, I suspect you want accessor
functions/macros at least to make it less intrusive...

> +	dev_dbg(apple_mbox->dev, "> TX %016llx %08x\n", msg->msg0, msg->msg1);

Isn't "TX" redundant here?

> +	dev_dbg(apple_mbox->dev, "got FIFO empty IRQ\n");

I realize it's a dev_dbg but this still seems unnecessarily noisy.

> +static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
> +{
> +	struct apple_mbox *apple_mbox = data;
> +	struct apple_mbox_msg msg;
> +
> +	while (apple_mbox_hw_can_recv(apple_mbox)) {
> +		apple_mbox_hw_recv(apple_mbox, &msg);
> +		mbox_chan_received_data(&apple_mbox->chan, (void *)&msg);
> +	}
```

A comment is warranted why this loop is safe and will always terminate,
especially given this is an IRQ context. (Ah... can a malicious
coprocessor DoS the AP by sending messages faster than the AP can
process them? freezing the system since preemption might be disabled
here? I suppose thee's no good way to protect against that level of
goofy.)

> +	 * There's no race if a message comes in between the check in the while
> +	 * loop above and the ack below: If a new messages arrives inbetween
> +	 * those two the interrupt will just fire again immediately after the
> +	 * ack since it's level sensitive.

I don't quite understand the reasoning. Why have IRQ controls at all
then on the M3?

> +	if (apple_mbox->hw->has_irq_controls)
> +		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty,
> +			       apple_mbox->regs + apple_mbox->hw->irq_ack);

Nit: { braces } since this is two lines. Unless kernel likes this sort
of scary aesthetic. Would go away with an accessor, of course.

> +	/*
> +	 * Only some variants of this mailbox HW provide interrupt control
> +	 * at the mailbox level. We therefore need to handle enabling/disabling
> +	 * interrupts at the main interrupt controller anyway for hardware that
> +	 * doesn't. Just always keep the interrupts we care about enabled at
> +	 * the mailbox level so that both hardware revisions behave almost
> +	 * the same.
> +	 */

Cute. Does macOS do this? Are there any tradeoffs?

> +	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-recv", dev_name(dev));
...
> +	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-send", dev_name(dev));

Not sure this is better or worse than specifying IRQ names in the device
tree... probably less greppable.

> +++ b/include/linux/apple-mailbox.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Apple mailbox message format
> + *
> + * Copyright (C) 2021 The Asahi Linux Contributors
> + */
> +
> +#ifndef _LINUX_APPLE_MAILBOX_H_
> +#define _LINUX_APPLE_MAILBOX_H_
> +
> +#include <linux/types.h>
> +
> +struct apple_mbox_msg {
> +	u64 msg0;
> +	u32 msg1;
> +};
> +
> +#endif

Seems like such a waste to have a dedicated file for a single structure
:'( I guess it's needed for the rtkit library but still ....
