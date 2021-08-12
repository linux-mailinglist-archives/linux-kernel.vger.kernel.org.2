Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE953EAC71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 23:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhHLVis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 17:38:48 -0400
Received: from foss.arm.com ([217.140.110.172]:48030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233283AbhHLVip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:38:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC6C11063;
        Thu, 12 Aug 2021 14:38:17 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C50D13F70D;
        Thu, 12 Aug 2021 14:38:16 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 05/13] genirq: Let purely flow-masked ONESHOT irqs through unmask_threaded_irq()
In-Reply-To: <87wnoq90wx.wl-maz@kernel.org>
References: <20210629125010.458872-1-valentin.schneider@arm.com> <20210629125010.458872-6-valentin.schneider@arm.com> <87bl639l8n.wl-maz@kernel.org> <875ywa944c.mognet@arm.com> <87wnoq90wx.wl-maz@kernel.org>
Date:   Thu, 12 Aug 2021 22:38:11 +0100
Message-ID: <87zgtm7398.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/21 15:45, Marc Zyngier wrote:
> On Thu, 12 Aug 2021 14:36:35 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> 
>> On 12/08/21 08:26, Marc Zyngier wrote:
>> > On Tue, 29 Jun 2021 13:50:02 +0100,
>> > Valentin Schneider <valentin.schneider@arm.com> wrote:
>> >> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> >> index ef30b4762947..e6d6d32ddcbc 100644
>> >> --- a/kernel/irq/manage.c
>> >> +++ b/kernel/irq/manage.c
>> >> @@ -1107,7 +1107,7 @@ static void irq_finalize_oneshot(struct irq_desc *desc,
>> >>  	desc->threads_oneshot &= ~action->thread_mask;
>> >>  
>> >>  	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
>> >> -	    irqd_irq_masked(&desc->irq_data))
>> >> +	    (irqd_irq_masked(&desc->irq_data) | irqd_irq_flow_masked(&desc->irq_data)))
>> >>  		unmask_threaded_irq(desc);
>> >
>> > The bitwise OR looks pretty odd. It is probably fine given that both
>> > side of the expression are bool, but still. I can fix this locally.
>> >
>> 
>> Thomas suggested that back in v1:
>> 
>>   https://lore.kernel.org/lkml/87v98v4lan.ffs@nanos.tec.linutronix.de/
>> 
>> I did look at the (arm64) disassembly diff back then and was convinced by
>> what I saw, though I'd have to go do that again as I can't remember much
>> else.
>
> Ah, fair enough.
>

Either I didn't have my glasses on or had a different output back then, but
I'm not so convinced anymore... (same result on both Ubuntu GCC 9.3.0 and
10.2 GCC release from Arm):


Logical OR:

     8f8:	b9400020 	ldr	w0, [x1]
     8fc:	3787fea0 	tbnz	w0, #16, 8d0 <irq_finalize_oneshot.part.0+0x60>
     900:	37880040 	tbnz	w0, #17, 908 <irq_finalize_oneshot.part.0+0x98>
     904:	36fffe60 	tbz	w0, #31, 8d0 <irq_finalize_oneshot.part.0+0x60>
     908:	aa1303e0 	mov	x0, x19
     90c:	94000000 	bl	0 <unmask_threaded_irq>

Bitwise OR (aka the patch):

     8f8:	b9400020 	ldr	w0, [x1]
     8fc:	3787fea0 	tbnz	w0, #16, 8d0 <irq_finalize_oneshot.part.0+0x60>
     900:	f26f001f 	tst	x0, #0x20000
     904:	7a400801 	ccmp	w0, #0x0, #0x1, eq  // eq = none
     908:	54fffe4a 	b.ge	8d0 <irq_finalize_oneshot.part.0+0x60>  // b.tcont
     90c:	aa1303e0 	mov	x0, x19
     910:	94000000 	bl	0 <unmask_threaded_irq>

If I get this right...

- TST sets the Z condition flag if bit 17 (masked) isn't set
- CCMP sets the condition flags to
  - the same as SUBS(flags, 0) if bit 17 wasn't set
  - NZCV=0001 otherwise
- B.GE branches if N==V

Soooo

- if we have bit 17 set, NZCV=0001, B.GE doesn't branch
- if we don't have bit 17 but bit 31 (flow-masked), NZCV=1000 because
  this is signed 32-bit, so having bit 31 set makes the result of
  SUBS(flags, 0) negative, B.GE doesn't branch
- if we have neither, NZCV=0XX0, B.GE branches

So this does appear to do the right thing, at the cost of an extra
instruction and a profound sense of dread to whoever stares at the
disassembly. I guess it does save us a branch which could be
mispredicted...

> Thanks,
>
> 	M.
>
> -- 
> Without deviation from the norm, progress is not possible.
