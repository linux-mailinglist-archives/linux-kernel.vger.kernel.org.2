Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ACB3F48C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhHWKjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:39:49 -0400
Received: from foss.arm.com ([217.140.110.172]:51506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233589AbhHWKjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:39:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75BC71042;
        Mon, 23 Aug 2021 03:39:05 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3F063F66F;
        Mon, 23 Aug 2021 03:39:04 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/gic: Convert to handle_strict_flow_irq()
In-Reply-To: <87czq4qzd7.wl-maz@kernel.org>
References: <20210814194737.GA3951530@roeck-us.net> <87sfzb7jeo.mognet@arm.com> <87eeav19mc.wl-maz@kernel.org> <87k0kk7w0c.mognet@arm.com> <87czqasn9u.wl-maz@kernel.org> <878s0t6s7p.mognet@arm.com> <87czq4qzd7.wl-maz@kernel.org>
Date:   Mon, 23 Aug 2021 11:38:58 +0100
Message-ID: <875yvw78e5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/21 10:33, Marc Zyngier wrote:
> On Sun, 22 Aug 2021 23:16:10 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>>
>> On 18/08/21 17:58, Marc Zyngier wrote:
>> > There is the bizarre case of drivers/gpio/gpio-thunderx.c that changes
>> > the irqchip flow to use either handle_fasteoi_ack_irq or
>> > handle_fasteoi_mask_irq, which won't play very nicely with this.
>> > Someone said Cavium?
>> >
>>
>> Humph...
>>
>> I'm not familiar at all with the gpiolib irqchips, but I was under the
>> impression those would involve chained IRQs (it does appear to be the case
>> for the pl061 GPIOs on a Juno). For those, the innermost desc would be handled
>> via chained_irq_{enter, exit}() [!!!], and the outermost one via whatever
>> flow was installed by the relevant driver.
>
> Not all of them are built like this. There is actually a bunch of
> these build as full hierarchies (QC, nvidia and some others).
>

I see, thanks!

>> I can't easily grok what goes on between that gpio-thunderx.c driver and
>> gpiolib, but since that GPIO chip has
>>
>>         .irq_eoi		= irq_chip_eoi_parent,
>>
>> and
>>
>>         girq->parent_domain =
>>                 irq_get_irq_data(txgpio->msix_entries[0].vector)->domain;
>>
>> (GPIOs hooked to MSI-X? Do I want to know?)
>
> It's good, isn't it? TX1 has all its HW appearing as PCI, even if it
> clearly isn't PCI underneath.
>
>>
>> I'm guessing it is *not* chained, which means the irq_set_handler_locked()
>> affects the entire stack :/
>
> It does. We can probably fix that, but I won't be able to test (my TX1
> was taken away a few months ago...). I'll accept body donations, for
> scientific purposes.
>

Looks like there are still some over on s/packet/equinix/, so I should be
able to poke at one.
