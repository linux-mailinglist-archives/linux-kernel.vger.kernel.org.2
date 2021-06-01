Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106AE397167
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhFAK1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:27:33 -0400
Received: from foss.arm.com ([217.140.110.172]:46478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhFAK1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:27:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44EE511FB;
        Tue,  1 Jun 2021 03:25:50 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 422D63F73D;
        Tue,  1 Jun 2021 03:25:49 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH v2 09/10] irqchip/gic: Convert to handle_strict_flow_irq()
In-Reply-To: <87wnrks6y5.wl-maz@kernel.org>
References: <20210525173255.620606-1-valentin.schneider@arm.com> <20210525173255.620606-10-valentin.schneider@arm.com> <87wnrks6y5.wl-maz@kernel.org>
Date:   Tue, 01 Jun 2021 11:25:46 +0100
Message-ID: <87pmx5g9ud.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/21 13:21, Marc Zyngier wrote:
> On Tue, 25 May 2021 18:32:54 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> @@ -1116,8 +1116,16 @@ static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
>>
>>      if (use_eoimode1) {
>>              gic->chip.irq_mask = gic_eoimode1_mask_irq;
>> +		gic->chip.irq_ack = gic_eoi_irq;
>>              gic->chip.irq_eoi = gic_eoimode1_eoi_irq;
>>              gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
>> +
>> +		/*
>> +		 * eoimode0 shouldn't expose FLOW_MASK because the priority
>> +		 * drop is undissociable from the deactivation, and we do need
>> +		 * the priority drop to happen within the flow handler.
>> +		 */
>> +		gic->chip.flags |= IRQCHIP_AUTOMASKS_FLOW | IRQCHIP_EOI_THREADED;
>>      }
>>
>>      if (gic == &gic_data[0]) {
>
> How about GICv2M, GICv3-MBI, and the collection of widget that build a
> domain on top of a GIC domain? I'm worried that they now all need
> updating one way or another...
>

Hmph, that's a good point. It's been a while since I've last stared at the
v2m, I'll go try to page that back in.

>       M.
>
> --
> Without deviation from the norm, progress is not possible.
