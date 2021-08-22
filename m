Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F6B3F41E0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhHVWQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:16:58 -0400
Received: from foss.arm.com ([217.140.110.172]:46724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhHVWQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:16:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01E5FD6E;
        Sun, 22 Aug 2021 15:16:16 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504433F766;
        Sun, 22 Aug 2021 15:16:15 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/gic: Convert to handle_strict_flow_irq()
In-Reply-To: <87czqasn9u.wl-maz@kernel.org>
References: <20210814194737.GA3951530@roeck-us.net> <87sfzb7jeo.mognet@arm.com> <87eeav19mc.wl-maz@kernel.org> <87k0kk7w0c.mognet@arm.com> <87czqasn9u.wl-maz@kernel.org>
Date:   Sun, 22 Aug 2021 23:16:10 +0100
Message-ID: <878s0t6s7p.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/21 17:58, Marc Zyngier wrote:
> On Tue, 17 Aug 2021 01:30:43 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> Are we guaranteed to have
>>
>>   .irq_ack \in {NULL, irq_chip_ack_parent}
>>
>> for all intermediate (!root) irqchips? I don't see why that wouldn't
>> be the case, and with that in mind what you described makes sense to
>> me.
>
> An intermediate layer is allowed to implement its own irq_ack that is
> not irq_chip_ack_parent, but it then has to call irq_chip_ack_parent
> itself.
>

Right, makes sense.

> There is the bizarre case of drivers/gpio/gpio-thunderx.c that changes
> the irqchip flow to use either handle_fasteoi_ack_irq or
> handle_fasteoi_mask_irq, which won't play very nicely with this.
> Someone said Cavium?
>

Humph...

I'm not familiar at all with the gpiolib irqchips, but I was under the
impression those would involve chained IRQs (it does appear to be the case
for the pl061 GPIOs on a Juno). For those, the innermost desc would be handled
via chained_irq_{enter, exit}() [!!!], and the outermost one via whatever
flow was installed by the relevant driver.

I can't easily grok what goes on between that gpio-thunderx.c driver and
gpiolib, but since that GPIO chip has

        .irq_eoi		= irq_chip_eoi_parent,

and

        girq->parent_domain =
                irq_get_irq_data(txgpio->msix_entries[0].vector)->domain;

(GPIOs hooked to MSI-X? Do I want to know?)

I'm guessing it is *not* chained, which means the irq_set_handler_locked()
affects the entire stack :/

[!!!] Speaking of chained IRQs, I'm now thinking this series breaks them;
chained_irq_enter() + chained_irq_exit() will only issue an ->irq_eoi(),
skipping the ->irq_ack()... One more thing to add to the list!

>>
>> > In order to restore -next into a working state, I'm temporarily
>> > dropping this series. Hopefully, we can sort this out before the merge
>> > window and reinstate it.
>> >
>>
>> I'm away from any keyboard for most of this week, but I'll get to it by the
>> weekend.
>
> No worries, enjoy your break!
>

I sure did, Thanks!

>       M.
>
> --
> Without deviation from the norm, progress is not possible.
