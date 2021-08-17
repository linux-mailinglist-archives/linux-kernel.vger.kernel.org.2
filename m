Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6543EE0E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhHQAbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:31:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233009AbhHQAbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:31:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4BF91FB;
        Mon, 16 Aug 2021 17:30:46 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F21EC3F66F;
        Mon, 16 Aug 2021 17:30:45 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/gic: Convert to handle_strict_flow_irq()
In-Reply-To: <87eeav19mc.wl-maz@kernel.org>
References: <20210814194737.GA3951530@roeck-us.net> <87sfzb7jeo.mognet@arm.com> <87eeav19mc.wl-maz@kernel.org>
Date:   Tue, 17 Aug 2021 01:30:43 +0100
Message-ID: <87k0kk7w0c.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/21 07:54, Marc Zyngier wrote:
> This is going and-up in a wack-a-mole game. There is probably a bunch
> of these all over the place. I'd rather squash it at the root,
> i.e. with something like this (untested):
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 099bc7e13d1b..601ad3fc47cd 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -410,7 +410,12 @@ void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu)
>
>  void ack_irq(struct irq_desc *desc)
>  {
> -	desc->irq_data.chip->irq_ack(&desc->irq_data);
> +	struct irq_data *data = &desc->irq_data;
> +
> +	while (!data->chip->irq_ack)
> +		data = data->parent_data;
> +
> +	data->chip->irq_ack(&desc->irq_data);
>
>       if (desc->irq_data.chip->flags & IRQCHIP_AUTOMASKS_FLOW)
>               irq_state_set_flow_masked(desc);
>
> We probably need something similar for irq_eoi().
>
> This however shows a more fundamental problem, I'm afraid. We set
> IRQCHIP_AUTOMASKS_FLOW in the GIC drivers (i.e. at the root), but test
> for it at the top of the hierarchy. As soon as we have more than a
> single layer of irqchip, this will do the wrong thing (or at least
> miss the masking optimisation).
>

Yup.

> This probably advocates for moving the flag into the descriptor. This
> really makes sense, as the flow is global to the whole stack, not just
> to the localised irqchip.
>

Are we guaranteed to have

  .irq_ack \in {NULL, irq_chip_ack_parent}

for all intermediate (!root) irqchips? I don't see why that wouldn't be the
case, and with that in mind what you described makes sense to me.

> In order to restore -next into a working state, I'm temporarily
> dropping this series. Hopefully, we can sort this out before the merge
> window and reinstate it.
>

I'm away from any keyboard for most of this week, but I'll get to it by the
weekend.

> Thanks,
>
>       M.
>
> --
> Without deviation from the norm, progress is not possible.
