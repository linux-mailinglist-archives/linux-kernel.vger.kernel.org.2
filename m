Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E13A3E148A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbhHEMRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:17:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54012 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbhHEMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:17:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8751220211;
        Thu,  5 Aug 2021 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628165822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bxW42qJCGB2Umu46WQoAh/lTQsKPbKsX5IYw5Nj12Vs=;
        b=OzK/3B1+nUNHT1refnTEG7vUPsxyVv1i6R5mKpzCf9zlpjABX4uhwRBmVeUOXX99PaOyTf
        dW3naEvJ5IHVOity5UCfixm+QL2Ro/DNZsIe2Gy21iqkznk4FTxeYy2EfZ4+NYj60gD/c+
        /LppcSePhLwVFD+BOaW+IY9SCVA5KF4=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5046EA3B94;
        Thu,  5 Aug 2021 12:17:02 +0000 (UTC)
Date:   Thu, 5 Aug 2021 14:16:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 06/10] printk: use seqcount_latch for
 console_seq
Message-ID: <YQvWuzpAv1Tw/CoQ@alley>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803131301.5588-7-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-08-03 15:18:57, John Ogness wrote:
> In preparation for synchronous printing, change @console_seq to use
> seqcount_latch so that it can be read without requiring @console_sem.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 73 ++++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d07d98c1e846..f8f46d9fba9b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -489,9 +489,7 @@ static u64 syslog_seq;
>  static size_t syslog_partial;
>  static bool syslog_time;
>  
> -/* All 3 protected by @console_sem. */
> -/* the next printk record to write to the console */
> -static u64 console_seq;
> +/* Both protected by @console_sem. */
>  static u64 exclusive_console_stop_seq;
>  static unsigned long console_dropped;
>  
> @@ -500,6 +498,17 @@ struct latched_seq {
>  	u64			val[2];
>  };
>  
> +/*
> + * The next printk record to write to the console. There are two
> + * copies (updated with seqcount_latch) so that reads can locklessly
> + * access a valid value. Writers are synchronized by @console_sem.
> + */
> +static struct latched_seq console_seq = {
> +	.latch		= SEQCNT_LATCH_ZERO(console_seq.latch),
> +	.val[0]		= 0,
> +	.val[1]		= 0,
> +};
> +
>  /*
>   * The next printk record to read after the last 'clear' command. There are
>   * two copies (updated with seqcount_latch) so that reads can locklessly
> @@ -563,7 +572,7 @@ bool printk_percpu_data_ready(void)
>  	return __printk_percpu_data_ready;
>  }
>  
> -/* Must be called under syslog_lock. */
> +/* Must be called under associated write-protection lock. */
>  static void latched_seq_write(struct latched_seq *ls, u64 val)
>  {
>  	raw_write_seqcount_latch(&ls->latch);
> @@ -2405,9 +2414,9 @@ EXPORT_SYMBOL(_printk);
>  
>  #define prb_read_valid(rb, seq, r)	false
>  #define prb_first_valid_seq(rb)		0
> +#define latched_seq_read_nolock(seq)	0
> +#define latched_seq_write(dst, src)
>  
> -static u64 syslog_seq;
> -static u64 console_seq;
>  static u64 exclusive_console_stop_seq;
>  static unsigned long console_dropped;
>  
> @@ -2735,7 +2744,7 @@ void console_unlock(void)
>  	bool do_cond_resched, retry;
>  	struct printk_info info;
>  	struct printk_record r;
> -	u64 __maybe_unused next_seq;
> +	u64 seq;
>  
>  	if (console_suspended) {
>  		up_console_sem();
> @@ -2779,12 +2788,14 @@ void console_unlock(void)
>  		size_t len;
>  
>  skip:
> -		if (!prb_read_valid(prb, console_seq, &r))
> +		seq = latched_seq_read_nolock(&console_seq);
> +		if (!prb_read_valid(prb, seq, &r))
>  			break;
>  
> -		if (console_seq != r.info->seq) {
> -			console_dropped += r.info->seq - console_seq;
> -			console_seq = r.info->seq;
> +		if (seq != r.info->seq) {
> +			console_dropped += r.info->seq - seq;
> +			latched_seq_write(&console_seq, r.info->seq);
> +			seq = r.info->seq;
>  		}
>  
>  		if (suppress_message_printing(r.info->level)) {
> @@ -2793,13 +2804,13 @@ void console_unlock(void)
>  			 * directly to the console when we received it, and
>  			 * record that has level above the console loglevel.
>  			 */
> -			console_seq++;
> +			latched_seq_write(&console_seq, seq + 1);
>  			goto skip;
>  		}
>  
>  		/* Output to all consoles once old messages replayed. */
>  		if (unlikely(exclusive_console &&
> -			     console_seq >= exclusive_console_stop_seq)) {
> +			     seq >= exclusive_console_stop_seq)) {
>  			exclusive_console = NULL;
>  		}
>  
> @@ -2820,7 +2831,7 @@ void console_unlock(void)
>  		len = record_print_text(&r,
>  				console_msg_format & MSG_FORMAT_SYSLOG,
>  				printk_time);
> -		console_seq++;
> +		latched_seq_write(&console_seq, seq + 1);
>  
>  		/*
>  		 * While actively printing out messages, if another printk()
> @@ -2848,9 +2859,6 @@ void console_unlock(void)
>  			cond_resched();
>  	}
>  
> -	/* Get consistent value of the next-to-be-used sequence number. */
> -	next_seq = console_seq;
> -
>  	console_locked = 0;
>  	up_console_sem();
>  
> @@ -2860,7 +2868,7 @@ void console_unlock(void)
>  	 * there's a new owner and the console_unlock() from them will do the
>  	 * flush, no worries.
>  	 */
> -	retry = prb_read_valid(prb, next_seq, NULL);
> +	retry = prb_read_valid(prb, latched_seq_read_nolock(&console_seq), NULL);
>  	if (retry && console_trylock())
>  		goto again;
>  }
> @@ -2912,18 +2920,19 @@ void console_unblank(void)
>   */
>  void console_flush_on_panic(enum con_flush_mode mode)
>  {
> -	/*
> -	 * If someone else is holding the console lock, trylock will fail
> -	 * and may_schedule may be set.  Ignore and proceed to unlock so
> -	 * that messages are flushed out.  As this can be called from any
> -	 * context and we don't want to get preempted while flushing,
> -	 * ensure may_schedule is cleared.
> -	 */
> -	console_trylock();
> -	console_may_schedule = 0;
> -
> -	if (mode == CONSOLE_REPLAY_ALL)
> -		console_seq = prb_first_valid_seq(prb);
> +	if (console_trylock()) {
> +		if (mode == CONSOLE_REPLAY_ALL)
> +			latched_seq_write(&console_seq, prb_first_valid_seq(prb));

I am scratching my head about this. Of course, latched_seq_write() does
not guarantee the result when the console lock it taken by another process.
But console_lock(), called below, will call latched_seq_write()
anyway.

Also CONSOLE_REPLAY_ALL is used by panic_print_sys_info().
It is called the following way:

void panic(const char *fmt, ...)
{
[...]
	debug_locks_off();
	console_flush_on_panic(CONSOLE_FLUSH_PENDING);

	panic_print_sys_info();
[...]
}

On one hand, console_flush_on_panic(CONSOLE_FLUSH_PENDING) will
most likely take over the console lock even when it was taken
by another CPU before. And the 2nd console_flush_on_panic()
called from panic_print_sys_info() will not even notice.

On the other hand, CONSOLE_REPLAY_ALL would not even try to
reply the log when the console log was not available.

The risk of broken console_seq is neglible. console_unlock()
should be safe even with invalid console_seq.

My opinion:

I suggest to keep the original logic and maybe add some comment:

void console_flush_on_panic(enum con_flush_mode mode)
{
	/*
	 * If someone else is holding the console lock, trylock will fail
	 * and may_schedule may be set.  Ignore and proceed to unlock so
	 * that messages are flushed out.  As this can be called from any
	 * context and we don't want to get preempted while flushing,
	 * ensure may_schedule is cleared.
	 */
	console_trylock();
	console_may_schedule = 0;

	/*
	 * latched_seq_write() does not guarantee consistent values
	 * when console_trylock() failed. But this is the best effort.
	 * console_unlock() will update anyway console_seq. prb_read_valid()
	 * handles even invalid sequence numbers.
	 */
	if (mode == CONSOLE_REPLAY_ALL)
		latched_seq_write(&console_seq, prb_first_valid_seq(prb));

	console_unlock();
}

Best Regards,
Petr
