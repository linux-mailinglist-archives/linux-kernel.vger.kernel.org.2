Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5219035C681
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbhDLMoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:44:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbhDLMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:44:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618231425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9RuZZ4YV+l/Us1m/Gl2I6gMNQ53ylhCIs4MIYcNu8BU=;
        b=MruXWSjJepNb9KkoQUa+lcI+0juAUt8HZ2X957HwSkNGAm/DN3lU1Y5cizzDlj2UFmARy8
        tSZAFvJIUMlazms/oMivAw0j2SBVBBcMOOqF25CWVJ9qaBa7uMNqhOrBNkq1okxAZrePCt
        QBpF//hntSRN6FXDIqGjqjmdzBaKRMZrkTRoCAU+jkBkG06TZ79WxRxjQkdLRgKTtzqId/
        rB5tybsxlr8fcp8IZKYLd681qVpsh0e95eOKSMvFldeusmf4GgeRjyUxMPuAmRK1ASfFDt
        ZsxSOXR+xKRQSQOCjtYtMQK3pMc/M91iXUnkCc3LmEBgAraBu2Ch4qLxM1rYSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618231425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9RuZZ4YV+l/Us1m/Gl2I6gMNQ53ylhCIs4MIYcNu8BU=;
        b=yZc/jQ5gj6CXcOugItpqnX2WdyhWZIkock/eHfAL8/F0oScfCQJMBcbvI18/HD7fhTVD2V
        PBpovqvVcH+A2yAQ==
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: reduce irqdebug bouncing cachelines
In-Reply-To: <2dae4501-6f01-1b32-4b69-1dfc94c93425@kaod.org>
References: <20210402132037.574661-1-npiggin@gmail.com> <87im4u2vxx.ffs@nanos.tec.linutronix.de> <2dae4501-6f01-1b32-4b69-1dfc94c93425@kaod.org>
Date:   Mon, 12 Apr 2021 14:43:45 +0200
Message-ID: <87wnt71xmm.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C=C3=A9dric,

On Mon, Apr 12 2021 at 11:06, C=C3=A9dric Le Goater wrote:
> On 4/10/21 1:58 PM, Thomas Gleixner wrote:
>> --- a/kernel/irq/spurious.c
>> +++ b/kernel/irq/spurious.c
>> @@ -274,7 +274,7 @@ void note_interrupt(struct irq_desc *des
>>  	unsigned int irq;
>>=20=20
>>  	if (desc->istate & IRQS_POLL_INPROGRESS ||
>> -	    irq_settings_is_polled(desc))
>> +	    irq_settings_is_polled(desc) | irq_settings_no_debug(desc))
>
> Shouldn't it be '||' instead  ?

It could. But that's intentionally '|'. Why?

Because that lets the compiler merge the bit checks into one and
therefore spares one conditional branch.

>>  		return;
>>=20=20
>>  	if (bad_action_ret(action_ret)) {
>>=20
>
> We could test irq_settings_no_debug() directly under handle_nested_irq()=
=20
> and handle_irq_event_percpu() to avoid calling note_interrupt(), just=20
> like we do for noirqdebug.

We can do that, but then we should not just make it:

   if (!irqnodebug && !irq_settings_no_debug(desc))
   	note_interrupt(...);

Instead have only one condition:

   if (!irq_settings_no_debug(desc))
   	note_interrupt(...);

See the uncompiled delta patch below.

Thanks,

        tglx
---
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1690,6 +1690,9 @@ static int
 				irq_settings_set_no_debug(desc);
 		}
=20
+		if (noirqdebug)
+			irq_settings_set_no_debug(desc);
+
 		if (new->flags & IRQF_ONESHOT)
 			desc->istate |=3D IRQS_ONESHOT;
=20
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -274,7 +274,7 @@ void note_interrupt(struct irq_desc *des
 	unsigned int irq;
=20
 	if (desc->istate & IRQS_POLL_INPROGRESS ||
-	    irq_settings_is_polled(desc) | irq_settings_no_debug(desc))
+	    irq_settings_is_polled(desc))
 		return;
=20
 	if (bad_action_ret(action_ret)) {
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -481,7 +481,7 @@ void handle_nested_irq(unsigned int irq)
 	for_each_action_of_desc(desc, action)
 		action_ret |=3D action->thread_fn(action->irq, action->dev_id);
=20
-	if (!noirqdebug)
+	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, action_ret);
=20
 	raw_spin_lock_irq(&desc->lock);
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -197,7 +197,7 @@ irqreturn_t handle_irq_event_percpu(stru
=20
 	add_interrupt_randomness(desc->irq_data.irq, flags);
=20
-	if (!noirqdebug)
+	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, retval);
 	return retval;
 }
