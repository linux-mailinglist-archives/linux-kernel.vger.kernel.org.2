Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BCE430890
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245589AbhJQME4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:04:56 -0400
Received: from rosenzweig.io ([138.197.143.207]:47190 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236197AbhJQMEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:04:55 -0400
Date:   Sun, 17 Oct 2021 08:02:39 -0400
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
Subject: Re: [PATCH v3 2/2] mailbox: apple: Add driver for Apple mailboxes
Message-ID: <YWwQ36hoNPrUJifS@sunset>
References: <20211017114054.67737-1-sven@svenpeter.dev>
 <20211017114054.67737-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017114054.67737-3-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Apple SoCs such as the M1 come with various co-processors. Mailboxes
> are used to communicate with those. This driver adds support for
> two variants of those mailboxes.
> 
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

In the future, Reviewed-by tags should be dropped after making major
changes to a patch.

> +		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty |
> +				       apple_mbox->hw->irq_bit_send_empty,
> +			       apple_mbox->regs + apple_mbox->hw->irq_enable);

Nit: weird wrapping, much easier to read as:

+		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty |
+			       apple_mbox->hw->irq_bit_send_empty,
+			       apple_mbox->regs + apple_mbox->hw->irq_enable);

> +static const struct apple_mbox_hw apple_mbox_asc_hw = {
> +	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
> +	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
> +
> +	.a2i_control = APPLE_ASC_MBOX_A2I_CONTROL,
> +	.a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
> +	.a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
> +
> +	.i2a_control = APPLE_ASC_MBOX_I2A_CONTROL,
> +	.i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
> +	.i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
> +
> +	.has_irq_controls = false,
> +};

Nit: consider dropping the `has_irq_controls = false` assignment.
Clearly there are none, or you'd have to fill out the irq_* fields too.

> +static const struct of_device_id apple_mbox_of_match[] = {
> +	{ .compatible = "apple,t8103-asc-mailbox", .data = &apple_mbox_asc_hw },
> +	{ .compatible = "apple,t8103-m3-mailbox", .data = &apple_mbox_m3_hw },
> +	{}
> +};

No generic compatibles? I assume this driver hasn't changed much in
recent iPhones, and hopefully it won't change much in M1X...

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

Given this file lacks the context of the driver, and the questions
raised in v2 review, it might be beneficial to add a quick comment to
apple_mbox_msg explaiing that no, really, this is a 96-bit message.
