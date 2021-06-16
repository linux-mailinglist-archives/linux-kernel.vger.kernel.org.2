Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACE3A9903
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhFPLXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:23:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42276 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFPLXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:23:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87613219DB;
        Wed, 16 Jun 2021 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623842461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPDMKpVRTMbj2eUIf+T2kb3aGLBSo2KcxwA0iFoc3sY=;
        b=YJkUIMxk7uDq9ML0kW+4sM5qjBKmFkNY1eiqsNw+Ahef3xkEC9CjW3tT6JaaFN/MPPRNHe
        ELhC3lAhlZlHtfO3bWNNllJwJqcE0IzykVoqB+ECXypThveGFMq8ff1iBvv2Ke4Z76YVp2
        iovrlpdmXvFc2BVXZAn2yun3RI5BTRA=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C280CA3BBA;
        Wed, 16 Jun 2021 11:21:00 +0000 (UTC)
Date:   Wed, 16 Jun 2021 13:21:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
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
Message-ID: <YMnenOBTUclLld9i@alley>
References: <20210615174947.32057-1-john.ogness@linutronix.de>
 <20210615174947.32057-2-john.ogness@linutronix.de>
 <8735tiq0d8.fsf@jogness.linutronix.de>
 <YMmi5xoTOb82TKtJ@google.com>
 <87mtrqnu74.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtrqnu74.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-06-16 09:35:35, John Ogness wrote:
> On 2021-06-16, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> It isn't about limiting. It is about tracking. The current dump_stack()
> handles it correctly because the tracking is done in the stack frame of
> the caller (in @was_locked of dump_stack_lvl()). My previous versions
> also handled it correctly by using the same technique.
> 
> With this series version I moved the tracking into a global variable
> @printk_cpulock_nested, which is fine, except that a boolean is not
> capable of tracking more than 1 nesting. Which means that
> __printk_cpu_unlock() would release cpu lock ownership too soon.
> 
> Doing this correctly is a simple change:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e67dc510fa1b..5376216e4f3d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3535,7 +3535,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>  
>  #ifdef CONFIG_SMP
>  static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
> -static bool printk_cpulock_nested;
> +static atomic_t printk_cpulock_nested = ATOMIC_INIT(0);
>  
>  /**
>   * __printk_wait_on_cpu_lock() - Busy wait until the printk cpu-reentrant
> @@ -3596,7 +3598,7 @@ int __printk_cpu_trylock(void)
>  
>  	} else if (old == cpu) {
>  		/* This CPU is already the owner. */
> -		printk_cpulock_nested = true;
> +		atomic_inc(&printk_cpulock_nested);
>  		return 1;
>  	}
>  
> @@ -3613,8 +3615,8 @@ EXPORT_SYMBOL(__printk_cpu_trylock);
>   */
>  void __printk_cpu_unlock(void)
>  {
> -	if (printk_cpulock_nested) {
> -		printk_cpulock_nested = false;
> +	if (atomic_read(&printk_cpulock_nested)) {
> +		atomic_dec(&printk_cpulock_nested);

I think about handling printk_cpulock_nested with only one
atomic operation. Something like:

	if (atomic_dec_return(&printk_cpulock_level) == 0)
		atomic_set_release(&printk_cpulock_owner, -1);

It would require always incremanting the number in lock, e.g.

	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
	if (old == -1 || old == cpu) {
		atomic_inc(&printk_cpulock_level);
		return 1;
	}

But I am not sure if it is really better. Feel free to keep
your variant.

>  		return;
>  	}
> 
> > Shall this be a separate patch?
> 
> I would prefer a v4 because I also noticed that this patch accidentally
> implements atomic_set_release() instead of moving over the atomit_set()
> from dump_stack(). That also needs to be corrected, otherwise the next
> patch in the series makes no sense.

Yes, this needs to get fixed as well.

Otherwise, the patch looks good to me. I haven't found any other
problems, except for the two already mentioned (count nested levels,
introduce atomic_set_release() in 2nd patch).

Best Regards,
Petr
