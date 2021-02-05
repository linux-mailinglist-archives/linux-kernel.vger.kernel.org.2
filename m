Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76900310802
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBEJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:36:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:51584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhBEJdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:33:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612517551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Xr0bOaT7Hvlq3oqjXdSuH4B/qZdB5Dc6rx0+uuEpQI=;
        b=PA+NTz5sIaO95EayEOv4oJ/xu4jIPSUaWibcfl58SlcL64LDqOBN39GpmyA+6BT9zSzlaq
        3UtETeEVbe/jqdl2bsDQ66wollPkrvIHJ1iQ/KrWpLk0L1SCfyf4oAKk8f8iS2j19+8Id4
        FcrTxOwYegFPFLDnBk8kNxX4xXigoNQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 915B8ACBA;
        Fri,  5 Feb 2021 09:32:31 +0000 (UTC)
Date:   Fri, 5 Feb 2021 10:32:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com,
        "J. Avila" <elavila@google.com>
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
Message-ID: <YB0Qr1XDBCUghEja@alley>
References: <20210122081311.GA12834@xsang-OptiPlex-9020>
 <8735yev1dn.fsf@jogness.linutronix.de>
 <878s83h63x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s83h63x.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-04 22:38:02, John Ogness wrote:
> On 2021-01-22, kernel test robot <oliver.sang@intel.com> wrote:
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: b031a684bfd01d633c79d281bd0cf11c2f834ada ("printk: remove logbuf_lock writer-protection of ringbuffer")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> So I finally tracked down the problem. And yes, it is a problem with the
> ringbuffer. And it turns out this is the same problem reported here [0].

Uff. Great work!

> If message sizes average larger than expected (more than 32 characters),
> the data_ring will wrap before the desc_ring. Once the data_ring wraps,
> it will start invalidating descriptors. These invalid descriptors hang
> around until they are eventually recycled (when the desc_ring
> wraps). Readers do not care about invalid descriptors, but they still
> have to iterate past them. If the average message size is much larger
> than 32 characters, then there will be many invalid descriptors
> preceeding the valid descriptors.
> 
> For this particular LKP report, the RCU stalls started happening as the
> number of invalid descriptors approached 17000. The reason this causes a
> problem is because of the function prb_first_valid_seq(). It starts at
> the oldest descriptor and searches to find the oldest _valid_
> descriptor. In this case, it had to iterate past 17000 descriptors every
> time.

Sigh. Good to know that iterating over these many descriptors has
such a cost.

> prb_first_valid_seq() is used in devkmsg_read() and in
> devkmsg_poll(). And worse, it is called with local interrupts disabled
> and logbuf_lock locked.
> 
> The solution is to avoid using prb_first_valid_seq() if possible. And
> indeed, in both of these cases it is a simple change:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index c8847ee571f0..76e8df20fdf9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -736,9 +736,9 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  		logbuf_lock_irq();
>  	}
>  
> -	if (user->seq < prb_first_valid_seq(prb)) {
> +	if (r->info->seq != user->seq) {

NOTE: This made me to realize one thing. We return -EPIPE even when
      prb_reserve() was able to reserve the desriptor but not the data
      space. It means that the message was lost already when it was
      being stored.

      It makes sense. It seems that we handle correctly even the situation
      when empty line is stored. But it is something less obvious.
      And we should keep it in mind.


>  		/* our last seen message is gone, return error and reset */
> -		user->seq = prb_first_valid_seq(prb);
> +		user->seq = r->info->seq;
>  		ret = -EPIPE;
>  		logbuf_unlock_irq();
>  		goto out;
> @@ -813,6 +813,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
>  static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
>  {
>  	struct devkmsg_user *user = file->private_data;
> +	struct printk_info info;
>  	__poll_t ret = 0;
>  
>  	if (!user)
> @@ -821,9 +822,9 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
>  	poll_wait(file, &log_wait, wait);
>  
>  	logbuf_lock_irq();
> -	if (prb_read_valid(prb, user->seq, NULL)) {
> +	if (prb_read_valid_info(prb, user->seq, &info, NULL)) {
>  		/* return error when data has vanished underneath us */
> -		if (user->seq < prb_first_valid_seq(prb))
> +		if (info.seq != user->seq)
>  			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
>  		else
>  			ret = EPOLLIN|EPOLLRDNORM;
> 

The change looks good to me. Please, send it as a proper patch.

> Once logbuf_lock and safe buffer usage is removed, this efficiency
> wouldn't matter to the kernel anyway. But I am glad we hit it while it
> still mattered because we should not be carelessly wasting CPU cycles
> for any task.

+1

> Interestingly enough, LTP reported a problem with this code back in July
> 2020. The "invalid descriptor issue" was clearly stated [1] and Petr
> even made a suggestion [2] which is nearly identical to how I propose to
> fix it here.
> 
> prb_first_valid_seq() is used unnecessarily in some syslog and devkmsg
> locations as well. And prb_first_valid_seq() itself can also be slightly
> improved.

I am curious what idea you have ;-) I wonder if it might help to cache
that last known first_valid_seq, e.g. in struct prb_desc_ring.

But it might be tricky because it must be lockless and it is a 64-bit
value. It might be solved by some lazy approach, e.g. trylock.
But there is still the question who should pay the prize for this.
IMHO, it should be on the reader side.

> I am preparing a patch against linux-next for this. And although the
> current situation is not pretty, I do not think it needs to be rushed
> for 5.11. It is an inefficiency that occurs if the average message size
> greatly exceeds 32 bytes and the ringbuffer is being blasted by new
> messages and userspace is reading the ringbuffer.

I agree. 5.11 release is getting close. And it might go in via stable
quite quickly.

Best Regards,
Petr
