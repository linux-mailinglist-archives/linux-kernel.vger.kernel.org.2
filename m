Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FBD396DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhFAHAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:00:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:00:36 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622530734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qy5Dlvl3KVfi8a+CNTca0GFXKGaZXfGUgkLF8E1qAI=;
        b=r9UMyCOHdPczrCWrhXhSkQUgSkZZWfaZh1/hiRSfo1KUgL0oFSVKUvZsq2uzOaIzByS9Du
        DVrr/m8Fko2tqOQcj5WR2trUpn+BXN8aF9pQtcptz58e7ImPuvs5pRmRHT0FQfEcVA+guo
        CXF2GcEiG1ixoO+tbOvtkPCOyUQZhgq08Doqz0g7P5/AlgP6pjOvIAJKRnt2LNBei0aTVu
        n9kh//1o+K86AB1ny+phIaWkYsk/gtrC+4l5gYSqi3dzophK+1zrbTUe6VnTPUsaO+Fg+O
        iVBw9G7FFvIUNYZTL9GvYu2KIj4wiORaUytxNj3ixGf69IXZxFaaZD6Ubh+5PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622530734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qy5Dlvl3KVfi8a+CNTca0GFXKGaZXfGUgkLF8E1qAI=;
        b=bim+vB2xoBoTCb5W8JTOH2ih2VtenI8UuncyMXjFUJdTs2OjjJIzn8KOTHPkLdttT8C1yr
        dhAn2ggLiAm4s4BQ==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v1 1/2] dump_stack: move cpu lock to printk.c
In-Reply-To: <YLWhlZy8jQR3zpun@google.com>
References: <20210531162051.2325-1-john.ogness@linutronix.de> <20210531162051.2325-2-john.ogness@linutronix.de> <YLWhlZy8jQR3zpun@google.com>
Date:   Tue, 01 Jun 2021 08:58:54 +0200
Message-ID: <87y2bu2hqp.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-01, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> On (21/05/31 18:20), John Ogness wrote:
>> +void printk_cpu_lock(unsigned int *cpu_store, unsigned long *flags)
>> +{
>> +	unsigned int cpu;
>> +
>> +	for (;;) {
>> +		cpu = get_cpu();
>> +
>> +		*cpu_store = atomic_read(&printk_cpulock_owner);
>> +
>> +		if (*cpu_store == -1) {
>> +			local_irq_save(*flags);
>
> Is there any particular reason this does
>
> 	preempt_disable();
> 	cpu = smp_processor_id();
> 	local_irq_safe();
>
> instead of
>
> 	local_irq_safe();
> 	cpu = raw_smp_processor_id();
>
> ?

If the lock is owned by another CPU, there is no need to disable
interrupts for this CPU. (The local_irq_save() is conditional.)

John Ogness
