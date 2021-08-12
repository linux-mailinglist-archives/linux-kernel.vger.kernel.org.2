Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD53EA5C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbhHLNgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:36:46 -0400
Received: from foss.arm.com ([217.140.110.172]:43226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232356AbhHLNgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:36:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45EB51042;
        Thu, 12 Aug 2021 06:36:17 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CE103F70D;
        Thu, 12 Aug 2021 06:36:16 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 02/13] genirq: Define ack_irq() and eoi_irq() helpers
In-Reply-To: <87a6ln9k7i.wl-maz@kernel.org>
References: <20210629125010.458872-1-valentin.schneider@arm.com> <20210629125010.458872-3-valentin.schneider@arm.com> <87a6ln9k7i.wl-maz@kernel.org>
Date:   Thu, 12 Aug 2021 14:36:11 +0100
Message-ID: <877dgq9450.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/21 08:49, Marc Zyngier wrote:
> On Tue, 29 Jun 2021 13:49:59 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> +void eoi_irq(struct irq_desc *desc)
>> +{
>> +	desc->irq_data.chip->irq_eoi(&desc->irq_data);
>> +
>> +	if (desc->irq_data.chip->flags & IRQCHIP_AUTOMASKS_FLOW)
>> +		irq_state_clr_flow_masked(desc);
>
> I just realised that this has a good chance to result in a mess with
> KVM, and specially the way we let the vGIC deactivate an interrupt
> directly from the guest, without any SW intervention (the magic HW bit
> in the LRs).
>

I didn't think to consider those. It can't ever be simple, can it...

> With this, interrupts routed to a guest (such as the timers) will
> always have the IRQD_IRQ_FLOW_MASKED flag set, which will never be
> cleared.
>
> I wonder whether this have a chance to interact badly with
> mask/unmask, or with the rest of the flow...
>

Isn't it the other way around? That is, eoi_irq() will clear
IRQD_IRQ_FLOW_MASKED regardless of what happens within chip->irq_eoi(),
so we would end up with !IRQD_IRQ_FLOW_MASKED even if the (physical) IRQ
remains Active (irqd_is_forwarded_to_vcpu() case).

This does not entirely match reality (if the IRQ is still Active then it is
still "flow-masked"), but AFAICT this doesn't impact our handling of
forwarded IRQs: IRQD_IRQ_FLOW_MASKED is only really relevant from ack_irq()
to eoi_irq(), and deactivation-from-the-guest (propagated via LR.HW=1)
happens after that.
