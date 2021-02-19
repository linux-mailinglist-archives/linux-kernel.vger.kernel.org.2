Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDAD31F9EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhBSNbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:31:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:44626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhBSNb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:31:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613741441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aK2ILRLf8YuM5i5fQZRYdq2o3A8u9wye0ZbzUZCnAAA=;
        b=SBSSfvHHryGLCMHzhHX00YnE9GQ68eLmpmyGVvYoV5f2WVW5Wm/7H8AbOg6uIE7vaPQAxR
        6kti20J9CziOcMjib+LCvoUXyeSnYl3eq9fHgmr7Bxe1aDZs9oB3k69gempQwVh+fy2sam
        kZXRU5M5mIAPMTLBI8CXpb35soai/AM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 898C2ABAE;
        Fri, 19 Feb 2021 13:30:41 +0000 (UTC)
Date:   Fri, 19 Feb 2021 14:30:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 08/14] printk: add syslog_lock
Message-ID: <YC+9gc/IR8PzeIFf@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-9-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:11, John Ogness wrote:
> The global variables @syslog_seq, @syslog_partial, @syslog_time
> and write access to @clear_seq are protected by @logbuf_lock.
> Once @logbuf_lock is removed, these variables will need their
> own synchronization method. Introduce @syslog_lock for this
> purpose.
> 
> @syslog_lock is a raw_spin_lock for now. This simplifies the
> transition to removing @logbuf_lock. Once @logbuf_lock and the
> safe buffers are removed, @syslog_lock can change to spin_lock.
> ---
>  kernel/printk/printk.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 20c21a25143d..401df370832b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> +/* Return a consistent copy of @syslog_seq. */
> +static u64 read_syslog_seq_irq(void)
> +{
> +	u64 seq;
> +
> +	raw_spin_lock_irq(&syslog_lock);
> +	seq = syslog_seq;
> +	raw_spin_unlock_irq(&syslog_lock);

Is there any particular reason to disable interrupts here?

It would make sense only when the lock could be taken in IRQ
context. Then we would need to always disable interrupts when
the lock is taken. And if it is taken in IRQ context, we would
need to safe flags.

I guess that you got confused because it is used in
wait_event_interruptible(). The name is misleading.
"interruptible" means wake_up_process() and not IRQ here.

IMHO, we should remove _irq suffix from the lock operations
and also from the function name.

> +
> +	return seq;
> +}
> +
>  int do_syslog(int type, char __user *buf, int len, int source)
>  {
>  	struct printk_info info;
> @@ -1664,8 +1688,9 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  			return 0;
>  		if (!access_ok(buf, len))
>  			return -EFAULT;
> +
>  		error = wait_event_interruptible(log_wait,
> -				prb_read_valid(prb, syslog_seq, NULL));
> +				prb_read_valid(prb, read_syslog_seq_irq(), NULL));
>  		if (error)
>  			return error;
>  		error = syslog_print(buf, len);

Otherwise, the patch looks good to me.

Best Regards,
Petr
