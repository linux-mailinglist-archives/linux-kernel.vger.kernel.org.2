Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4A33EA5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbhHLNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:37:05 -0400
Received: from foss.arm.com ([217.140.110.172]:43236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233260AbhHLNhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:37:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 156EF1042;
        Thu, 12 Aug 2021 06:36:39 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300E93F70D;
        Thu, 12 Aug 2021 06:36:38 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 05/13] genirq: Let purely flow-masked ONESHOT irqs through unmask_threaded_irq()
In-Reply-To: <87bl639l8n.wl-maz@kernel.org>
References: <20210629125010.458872-1-valentin.schneider@arm.com> <20210629125010.458872-6-valentin.schneider@arm.com> <87bl639l8n.wl-maz@kernel.org>
Date:   Thu, 12 Aug 2021 14:36:35 +0100
Message-ID: <875ywa944c.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/21 08:26, Marc Zyngier wrote:
> On Tue, 29 Jun 2021 13:50:02 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index ef30b4762947..e6d6d32ddcbc 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -1107,7 +1107,7 @@ static void irq_finalize_oneshot(struct irq_desc *desc,
>>  	desc->threads_oneshot &= ~action->thread_mask;
>>  
>>  	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
>> -	    irqd_irq_masked(&desc->irq_data))
>> +	    (irqd_irq_masked(&desc->irq_data) | irqd_irq_flow_masked(&desc->irq_data)))
>>  		unmask_threaded_irq(desc);
>
> The bitwise OR looks pretty odd. It is probably fine given that both
> side of the expression are bool, but still. I can fix this locally.
>

Thomas suggested that back in v1:

  https://lore.kernel.org/lkml/87v98v4lan.ffs@nanos.tec.linutronix.de/

I did look at the (arm64) disassembly diff back then and was convinced by
what I saw, though I'd have to go do that again as I can't remember much
else.

> Thanks,
>
> 	M.
>
> -- 
> Without deviation from the norm, progress is not possible.
