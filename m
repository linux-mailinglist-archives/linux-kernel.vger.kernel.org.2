Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8571E3A93E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhFPHbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:31:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39210 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhFPHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:31:43 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623828576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=POzM0Y8byvr+jQJVKWB+DDxB1MIjaCquyA71sc4SR/w=;
        b=SOzhCyFA8p1ORJQPK3hFwI6Lg7BF+97Z2ROwOzyv+IgXDWNDzYYYPM3XGGmf/glmq2BNZD
        oHzW869iWQjYM298MjbS4tYS6UrHrSRvPxMFC8eW3lDbKNev8jKIylHQl3KYI1LNlcNIKH
        rUJJ/6OHAgQlebxKcVf9BSIBIsOr3McB7biPwJ3q4LEbRyGheEQ5VeO8u7L+UOYpvDbj8w
        dm9xLW+M7SXSpMvbttIDw1hmNDsphCzrNSfogvLr3Y84unKmjkpE/ocz9m1wvty4qH43UX
        iX+e9+m09jx3QcK4lyvEhR0MPCkvNx6lE1URstIdLIYlcReNS7koPdpT8+G8HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623828576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=POzM0Y8byvr+jQJVKWB+DDxB1MIjaCquyA71sc4SR/w=;
        b=BLD3PcoFfUKBM2ydNzit2ACYZYkMhCsXp3/XbW2OHiCnhe4ZqnL59CVunWo4RUEIoffKHS
        /M9By1b17Hlx77Cg==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH next v3 1/2] dump_stack: move cpu lock to printk.c
In-Reply-To: <YMmi5xoTOb82TKtJ@google.com>
References: <20210615174947.32057-1-john.ogness@linutronix.de> <20210615174947.32057-2-john.ogness@linutronix.de> <8735tiq0d8.fsf@jogness.linutronix.de> <YMmi5xoTOb82TKtJ@google.com>
Date:   Wed, 16 Jun 2021 09:35:35 +0206
Message-ID: <87mtrqnu74.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-16, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> On (21/06/15 23:39), John Ogness wrote:
>> On 2021-06-15, John Ogness <john.ogness@linutronix.de> wrote:
>> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> > index 114e9963f903..5369d8f33299 100644
>> > --- a/kernel/printk/printk.c
>> > +++ b/kernel/printk/printk.c
>> > @@ -3532,3 +3532,70 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
>> >  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>> >  
>> >  #endif
>> > +
>> > +#ifdef CONFIG_SMP
>> > +static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
>> > +static bool printk_cpulock_nested;
>> 
>> I just realized that @printk_cpulock_nested will need to be an atomic_t
>> counter to allow multiple nested levels since nesting can also occur
>
> Strictly speaking, this is not nested printk, right? printk recursion is
> handled in printk separately. This one is more like "nested dump_stack()-s",
> or nested "error reporinting".
>
> Because the original code has never limited nested error reporting
> contexts.

It isn't about limiting. It is about tracking. The current dump_stack()
handles it correctly because the tracking is done in the stack frame of
the caller (in @was_locked of dump_stack_lvl()). My previous versions
also handled it correctly by using the same technique.

With this series version I moved the tracking into a global variable
@printk_cpulock_nested, which is fine, except that a boolean is not
capable of tracking more than 1 nesting. Which means that
__printk_cpu_unlock() would release cpu lock ownership too soon.

Doing this correctly is a simple change:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e67dc510fa1b..5376216e4f3d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3535,7 +3535,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 #ifdef CONFIG_SMP
 static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
-static bool printk_cpulock_nested;
+static atomic_t printk_cpulock_nested = ATOMIC_INIT(0);
 
 /**
  * __printk_wait_on_cpu_lock() - Busy wait until the printk cpu-reentrant
@@ -3596,7 +3598,7 @@ int __printk_cpu_trylock(void)
 
 	} else if (old == cpu) {
 		/* This CPU is already the owner. */
-		printk_cpulock_nested = true;
+		atomic_inc(&printk_cpulock_nested);
 		return 1;
 	}
 
@@ -3613,8 +3615,8 @@ EXPORT_SYMBOL(__printk_cpu_trylock);
  */
 void __printk_cpu_unlock(void)
 {
-	if (printk_cpulock_nested) {
-		printk_cpulock_nested = false;
+	if (atomic_read(&printk_cpulock_nested)) {
+		atomic_dec(&printk_cpulock_nested);
 		return;
 	}

> Shall this be a separate patch?

I would prefer a v4 because I also noticed that this patch accidentally
implements atomic_set_release() instead of moving over the atomit_set()
from dump_stack(). That also needs to be corrected, otherwise the next
patch in the series makes no sense.

John Ogness
