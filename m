Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0602030A79B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhBAM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:27:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:54354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhBAM10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:27:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612182398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PE9JrNiPE/waS59o8i1v4gEWcbHimWae5gJXMMipSF4=;
        b=b/z+QBJCHLvZ4MqEWcNfsnAUF2y+/fbIoxnYxOPxMr/8kxauEB51km9hFs5NWqWNg6bZAG
        GRlMgTdV2yOMh93axDQfX0THW27184QFNHY0j8s3jg78lU13WOVHGBvymgh79G8OSAbiBg
        yOzdvMXsZJrVmiZtaujLZCxSkIx5zw0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB3E7AC45;
        Mon,  1 Feb 2021 12:26:38 +0000 (UTC)
Date:   Mon, 1 Feb 2021 13:26:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 07/12] printk: add syslog_lock
Message-ID: <YBfzfs9zU8rgHl6y@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126211551.26536-8-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-01-26 22:21:46, John Ogness wrote:
> The global variables @syslog_seq, @syslog_partial, @syslog_time
> and write access to @clear_seq are protected by @logbuf_lock.
> Once @logbuf_lock is removed, these variables will need their
> own synchronization method. Introduce @syslog_lock for this
> purpose.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -390,8 +390,12 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
>  		printk_safe_exit_irqrestore(flags);	\
>  	} while (0)
>  
> +/* syslog_lock protects syslog_* variables and write access to clear_seq. */
> +static DEFINE_RAW_SPINLOCK(syslog_lock);

I am not expert on RT code but I think that it prefers the generic
spinlocks. syslog_lock seems to be used in a normal context.
IMHO, it does not need to be a raw spinlock.

Note that using normal spinlock would require switching the locking
order. logbuf_lock is a raw lock. Normal spinlock must not be taken
under a raw spinlock.

Or we could switch syslog_lock to the normal spinlock later
after logbuf_lock is removed.

> +
>  #ifdef CONFIG_PRINTK
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
> +/* All 3 protected by @syslog_lock. */
>  /* the next printk record to read by syslog(READ) or /proc/kmsg */
>  static u64 syslog_seq;
>  static size_t syslog_partial;
> @@ -1631,6 +1643,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  	bool clear = false;
>  	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
>  	int error;
> +	u64 seq;

This allows to remove definition of the same temporary variable
for case SYSLOG_ACTION_SIZE_UNREAD.

>  
>  	error = check_syslog_permissions(type, source);
>  	if (error)
> @@ -1648,8 +1661,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  			return 0;
>  		if (!access_ok(buf, len))
>  			return -EFAULT;
> +
> +		/* Get a consistent copy of @syslog_seq. */
> +		raw_spin_lock_irq(&syslog_lock);
> +		seq = syslog_seq;
> +		raw_spin_unlock_irq(&syslog_lock);
> +
>  		error = wait_event_interruptible(log_wait,
> -				prb_read_valid(prb, syslog_seq, NULL));
> +				prb_read_valid(prb, seq, NULL));

Hmm, this will not detect when syslog_seq gets cleared in parallel.
I hope that nobody rely on this behavior. But who knows?

A solution might be to have also syslog_seq latched. But I am
not sure if it is worth it.

I am for taking the risk and use the patch as it is now. Let's keep
the code for now. We could always use the latched variable when
anyone complains. Just keep it in mind.


>  		if (error)
>  			return error;
>  		error = syslog_print(buf, len);

Otherwise, the patch looks good to me.

Best Regards,
Petr
