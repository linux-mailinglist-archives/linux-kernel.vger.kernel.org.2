Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B207F430894
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbhJQMNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:13:53 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59631 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242065AbhJQMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:13:51 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 13C8E5C00BE;
        Sun, 17 Oct 2021 08:11:42 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Sun, 17 Oct 2021 08:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=ZWWjC4g+NM5m34T/9263lf+QjNfD
        U6lB85qVjusw3Uk=; b=RlLLzMrH83WWRYMQcp2AOylkuhI1M6VsP1jfyGHstt+9
        xvswENN14Llbr1WKt+7rdU0pOdMBEeR/XwCYHONnD8Ph3GLIbfuVnL94bZJGDG/9
        sCAsg7QlSwKYRTc6B3q8j2ZD7PSjCf0XJH5i6XTWex8kP/vg7jgTWswfZVFUiD6w
        d3RO24O50tYnQtRicxmOQd97iOHCI6TUTNom+DrplcxQlkLyHQ7K9G5uaoGcQMYw
        s+W3UM7W8cVzWEff2KMDhioOsHYHTq2KpSPZn2Rn5cM0bWfj03jFxKwnRU62UEe9
        vwJ679WznVn/WCCYihxV6rSFp9ROojNC9V8GsYxPZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZWWjC4
        g+NM5m34T/9263lf+QjNfDU6lB85qVjusw3Uk=; b=NaRK9y7WCU1crZCmrgVt0S
        TGTtF4tf9B0urU1UApVzpqDEVX8b0xfbn1Ce6yNdf1T1rHwn3Q7MHDEK7yVFx0eX
        +HeHfUMLP6aic42ccXsVAmb+Y1+KXBgPGYRL50h0Mt6D+Jf5kahLVHgEDP7OxsI5
        D24bm4RmmYzMBMyhDmIM09ObIPVrwj7u92Lg5kcBGJnMxQE/9B0E/pW02kG2EcbE
        DvzzFeWrUJggEvExbkS1BZhyOphoRWayzX5Hp9liAXYJCjdkgWqPjDMO90kJjn/u
        ++qrxmWAkil7rD4MWpVTSR8qD4kAHmAaDmbjtIMNr0e1NP6ZElJrt+KcriNHRHOw
        ==
X-ME-Sender: <xms:_RJsYTQfpB-rWXKZfzmBuU2jY08LOUy2iwLYHEbHjNrZsDKnWPKNcw>
    <xme:_RJsYUwd0BBsC8m5qKE7qoO-9YMinDgOhFbXHL4zgvWmCqQtvOpP3YR6piLZgg4Ys
    MBbWFnTHiX9xSFs1yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddukedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:_RJsYY0ZXwRcWqZrwtQdXq7jvyTVeAqMWH9xpDNVhvttPqA3UjAGwg>
    <xmx:_RJsYTD7UWbeDjxMhu-IlfjsQ73WbE0Cgmd39enTT04hTFeOPQiFwg>
    <xmx:_RJsYcjXGKU-NtO1GdPy0FT31LRrGt-NCydOuvaq1Rx4MzTblbAUgA>
    <xmx:_hJsYYiS652QDuUGDhA9STUEDciK-ExmMh6lAyTPY6p-yuLtljUnxg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A5A342740061; Sun, 17 Oct 2021 08:11:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <02537a8a-e9c2-46f4-904e-6ff5c0583cbf@www.fastmail.com>
In-Reply-To: <YWwQ36hoNPrUJifS@sunset>
References: <20211017114054.67737-1-sven@svenpeter.dev>
 <20211017114054.67737-3-sven@svenpeter.dev> <YWwQ36hoNPrUJifS@sunset>
Date:   Sun, 17 Oct 2021 14:11:21 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Hector Martin" <marcan@marcan.st>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mailbox: apple: Add driver for Apple mailboxes
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 17, 2021, at 14:02, Alyssa Rosenzweig wrote:
>> Apple SoCs such as the M1 come with various co-processors. Mailboxes
>> are used to communicate with those. This driver adds support for
>> two variants of those mailboxes.
>> 
>> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>
> In the future, Reviewed-by tags should be dropped after making major
> changes to a patch.

I don't think there were any major changes since v2, but sure, I'll drop your
tag in the future. All your comments below already apply to v2.

>
>> +		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty |
>> +				       apple_mbox->hw->irq_bit_send_empty,
>> +			       apple_mbox->regs + apple_mbox->hw->irq_enable);
>
> Nit: weird wrapping, much easier to read as:
>
> +		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty |
> +			       apple_mbox->hw->irq_bit_send_empty,
> +			       apple_mbox->regs + apple_mbox->hw->irq_enable);
>

This is just what clang-format does and I'd rather keep it this way.
Note that the first two lines are the first argument combined with an OR.

>> +static const struct apple_mbox_hw apple_mbox_asc_hw = {
>> +	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
>> +	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
>> +
>> +	.a2i_control = APPLE_ASC_MBOX_A2I_CONTROL,
>> +	.a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
>> +	.a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
>> +
>> +	.i2a_control = APPLE_ASC_MBOX_I2A_CONTROL,
>> +	.i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
>> +	.i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
>> +
>> +	.has_irq_controls = false,
>> +};
>
> Nit: consider dropping the `has_irq_controls = false` assignment.
> Clearly there are none, or you'd have to fill out the irq_* fields too.

I'd rather keep it explicit as false here to make the intent clear.

>
>> +static const struct of_device_id apple_mbox_of_match[] = {
>> +	{ .compatible = "apple,t8103-asc-mailbox", .data = &apple_mbox_asc_hw },
>> +	{ .compatible = "apple,t8103-m3-mailbox", .data = &apple_mbox_m3_hw },
>> +	{}
>> +};
>
> No generic compatibles? I assume this driver hasn't changed much in
> recent iPhones, and hopefully it won't change much in M1X...

Then we can always have apple,tXXX-asc-mailbox, apple,t8103-asc-mailbox in the
device tree. From what I can tell this specific mailbox has only appeared in
this SoC generation.

>
>> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
>> +/*
>> + * Apple mailbox message format
>> + *
>> + * Copyright (C) 2021 The Asahi Linux Contributors
>> + */
>> +
>> +#ifndef _LINUX_APPLE_MAILBOX_H_
>> +#define _LINUX_APPLE_MAILBOX_H_
>> +
>> +#include <linux/types.h>
>> +
>> +struct apple_mbox_msg {
>> +	u64 msg0;
>> +	u32 msg1;
>> +};
>> +
>> +#endif
>
> Given this file lacks the context of the driver, and the questions
> raised in v2 review, it might be beneficial to add a quick comment to
> apple_mbox_msg explaiing that no, really, this is a 96-bit message.

I don't think that's necessary but it doesn't hurt either I guess.


Sven
