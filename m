Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CD63E2619
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbhHFI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbhHFI24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:28:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C5C061199
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WgUB9XS+K/dJBgBtcRVvUCChqOB+hRaKcnIXrDZf5Ns=; b=vDNtImF3KwH4DkaRC4akHk6qpu
        YatYbDnoQX59d/THl5lJJFPpon/H1icjuRFqXX+82i58maHeO9H1EYE0A2N0KgrUxx2fWSbz/ItXW
        4iVDfRV2UqsEmzM6j5+ohAjVsZkzlJYM6SJjNstPGTThpttw0ZGR3V83zRpTQZqJ9waMt7OUP/Wu2
        onHCeM+PAkA7+5dWBJBacv9h/SoHYO1zryB/gtP035CidAasgABZVlDqRXBTHq7iZOojrgpPA6Zy1
        LAixQ67QzkBjAzwAcr4s7gjNsR8QwAp+FoDvhyMFQ++ypcfy6wBLV8oSb3t8dLDBJs6ORaM+c5Sl1
        vqOiSUKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBv8T-007yQH-Rn; Fri, 06 Aug 2021 08:23:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9449981053; Fri,  6 Aug 2021 10:23:20 +0200 (CEST)
Date:   Fri, 6 Aug 2021 10:23:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, rjw@rjwysocki.net,
        lenb@kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        "xiaoqian9@huawei.com" <xiaoqian9@huawei.com>,
        "wangle6@huawei.com" <wangle6@huawei.com>
Subject: Re: Question: Can I call down() in an atomic context?
Message-ID: <20210806082320.GD22037@worktop.programming.kicks-ass.net>
References: <6b5e1da8-4360-e9da-ad42-a5365fb853fa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b5e1da8-4360-e9da-ad42-a5365fb853fa@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:35:36AM +0800, Xiaoming Ni wrote:
> might_sleep() is called in kernel/locking/rwsem.c (API:
> down_read/down_write/...)
> but not in kernel/locking/semaphore.c (API: down/down_timeout/..).
> Was it designed so purposely, or was it missed by mistake?

Simply forgotten I suspect. The semaphore is definitely a sleeping lock.

> After I added might_sleep() to kernel/locking/semaphore.c,
> an alarm log was occasionally detected in my test environment:
> 
> 	BUG: sleeping function called from invalid context at
> kernel/locking/semaphore.c:163
> 	in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/8
> 	...
> 	Call trace:
> 	dump_backtrace+0x0/0x3c
> 	dump_backtrace+0x2c/0x3c
> 	show_stack+0x24/0x34
> 	dump_stack+0xb0/0xf0
> 	___might_sleep+0x130/0x144
> 	__might_sleep+0x78/0x88
> 	down_timeout+0x40/0xc8
> 	acpi_os_wait_semaphore+0x78/0xa0  drivers/acpi/osl.c#L1266
> 	acpi_ut_acquire_mutex+0x50/0xb4   drivers/acpi/acpica/utmutex.c#L241
> 	acpi_get_table+0x3c/0xc8          drivers/acpi/acpica/tbxface.c#L318
> 	acpi_find_last_cache_level+0x7c/0x140  drivers/acpi/pptt.c#L602
> 	_init_cache_level+0xd0/0xd8    arch/arm64/kernel/cacheinfo.c#L64
> 	flush_smp_call_function_queue+0x138/0x160   kernel/smp.c#L561
> 	generic_smp_call_function_single_interrupt+0x18/0x24
> 	handle_IPI+0x1d0/0x50c
> 	gic_handle_irq+0x13c/0x140
> 	el1_irq+0xcc/0x180
> 	arch_cpu_idle+0xc0/0x16c
> 	default_idle_call+0x34/0x38
> 	cpu_startup_entry+0x2b4/0x358
> 	secondary_start_kernel+0x1a8/0x1dc
> 
> Does this mean that it is necessary to add might_sleep in
> kernel/locking/semaphore.c?

Necessary might be the wrong word, but yes, I think the whole down_*()
family (with exception of down_trylock() obvs) could do with a
might_sleep().
