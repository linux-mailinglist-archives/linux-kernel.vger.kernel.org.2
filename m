Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448223519C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhDAR4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:56:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234932AbhDARni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:43:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617290027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mtYjimH27BNkKQWQsPQAw4+uvVPdvh/ki26vPC2H74E=;
        b=aqSk/FYqrSmkXhic8cv6txd/R/9YcdLS25ENfXEVUY3ONRy1Qh+gY7IDSzQeuSkMhIMXkj
        Jwu9ecCPfyySJrpELTaR7Ty1Cu49Sjyw4vADfQb2SqfFJy48j1SP7omoTwY1tDgfhgSF0R
        vrG4j3mNqiHL8DcK8XQ6cjVmM1KtECs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 452EFB2B9;
        Thu,  1 Apr 2021 15:13:47 +0000 (UTC)
Date:   Thu, 1 Apr 2021 17:13:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 4/5] printk: convert @syslog_lock to mutex
Message-ID: <YGXjKqCgXdTmtTxy@alley>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
 <20210330153512.1182-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330153512.1182-5-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-30 17:35:11, John Ogness wrote:
> @syslog_lock was a raw_spin_lock to simplify the transition of
> removing @logbuf_lock and the safe buffers. With that transition
> complete, and since all uses of @syslog_lock are within sleepable
> contexts, @syslog_lock can become a mutex.

It makes perfect sense.

> ---
>  Note: The removal of read_syslog_seq_irq() is technically a small
>        step backwards. But the follow-up patch moves forward again
>        and closes a window that existed with read_syslog_seq_irq()
>        and @syslog_lock as a spin_lock.

This change would deserve a comment in the commit message. Well, I do
not think that is a step backward, see below.

>  kernel/printk/printk.c | 49 +++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f090d6a1b39e..b771aae46445 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1603,21 +1603,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
>  
>  static void syslog_clear(void)
>  {
> -	raw_spin_lock_irq(&syslog_lock);
> +	mutex_lock(&syslog_lock);
>  	latched_seq_write(&clear_seq, prb_next_seq(prb));
> -	raw_spin_unlock_irq(&syslog_lock);
> -}
> -
> -/* Return a consistent copy of @syslog_seq. */
> -static u64 read_syslog_seq_irq(void)
> -{
> -	u64 seq;
> -
> -	raw_spin_lock_irq(&syslog_lock);
> -	seq = syslog_seq;
> -	raw_spin_unlock_irq(&syslog_lock);
> -
> -	return seq;
> +	mutex_unlock(&syslog_lock);
>  }
>  
>  int do_syslog(int type, char __user *buf, int len, int source)
> @@ -1644,8 +1633,12 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  		if (!access_ok(buf, len))
>  			return -EFAULT;
>  
> -		error = wait_event_interruptible(log_wait,
> -				prb_read_valid(prb, read_syslog_seq_irq(), NULL));
> +		/* Get a consistent copy of @syslog_seq. */
> +		mutex_lock(&syslog_lock);
> +		seq = syslog_seq;
> +		mutex_unlock(&syslog_lock);
> +
> +		error = wait_event_interruptible(log_wait, prb_read_valid(prb, seq, NULL));

Honestly, I am not sure how the syslog interface should work when there
are two readers in the system. They both share the same "syslog_seq".

This either fixes a historic bug. The caller of SYSLOG_ACTION_READ
might miss the new message when another reader did read it in the
meantime.

Or it might introduce a regression when two readers would read the
same message.

Or it does not matter because the behavior is racy by definition.

Best Regards,
Petr

PS: I am going to look at this more with a fresh head after Easter
 holidays.  The answer is important also for the next patch that
 basically restores the original behavior.
 
