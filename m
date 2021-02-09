Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8D131563A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 19:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhBISoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 13:44:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:58828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233238AbhBIRtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:49:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612892861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jni2W/IDi/GWvC25GgqGCfHqUn0ldqQ6jWnvtbK6ewk=;
        b=F2JizNrEBrmtY1YGQeraNmBLSU/uLcXhtkc9Kkm1/r1i7YqHlGtIxz+1YrVR8hL+/RHyFP
        D9NU1q4aV4m9gZ3H1lJkJ3ou69x0R47NmtXSho2Bde5OMlXCTzxo0AytQleALlEniyo5P0
        JD4BK+8usFFcuMKUdLkPVO6UqxIW2KA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DF4FAB71;
        Tue,  9 Feb 2021 17:47:41 +0000 (UTC)
Date:   Tue, 9 Feb 2021 18:47:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, "J. Avila" <elavila@google.com>
Subject: Re: [PATCH] printk: avoid prb_first_valid_seq() where possible
Message-ID: <YCLKvCNJwabVavAP@alley>
References: <20210205141728.18117-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205141728.18117-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-02-05 15:23:28, John Ogness wrote:
> If message sizes average larger than expected (more than 32
> characters), the data_ring will wrap before the desc_ring. Once the
> data_ring wraps, it will start invalidating descriptors. These
> invalid descriptors hang around until they are eventually recycled
> when the desc_ring wraps. Readers do not care about invalid
> descriptors, but they still need to iterate past them. If the
> average message size is much larger than 32 characters, then there
> will be many invalid descriptors preceding the valid descriptors.
> 
> The function prb_first_valid_seq() always begins at the oldest
> descriptor and searches for the first valid descriptor. This can
> be rather expensive for the above scenario. And, in fact, because
> of its heavy usage in /dev/kmsg, there have been reports of long
> delays and even RCU stalls.
> 
> For code that does not need to search from the oldest record,
> replace prb_first_valid_seq() usage with prb_read_valid_*()
> functions, which provide a start sequence number to search from.
> 
> Fixes: 896fbe20b4e2333fb55 ("printk: use the lockless ringbuffer")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: J. Avila <elavila@google.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  patch against next-20210205
> 
>  kernel/printk/printk.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5a95c688621f..035aae771ea1 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1559,6 +1560,7 @@ static void syslog_clear(void)
>  
>  int do_syslog(int type, char __user *buf, int len, int source)
>  {
> +	struct printk_info info;
>  	bool clear = false;
>  	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
>  	int error;
> @@ -1629,9 +1631,13 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  	/* Number of chars in the log buffer */
>  	case SYSLOG_ACTION_SIZE_UNREAD:
>  		logbuf_lock_irq();
> -		if (syslog_seq < prb_first_valid_seq(prb)) {
> -			/* messages are gone, move to first one */
> -			syslog_seq = prb_first_valid_seq(prb);
> +		if (prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
> +			if (info.seq != syslog_seq) {
> +				/* messages are gone, move to first one */
> +				syslog_seq = info.seq;
> +				syslog_partial = 0;
> +			}
> +		} else {
>  			syslog_partial = 0;

I am scratching my head when prb_read_valid_info(prb,
syslog_seq, &info, NULL)) might fail.

It might fail when syslog_seq points to the next message
after the last valid one. In this case, we could return
immediately (after releasing the lock) because there are
zero unread messages.

Anyway, syslog_partial must be zero in this case. syslog_seq
should stay when the last read was partial. And there should
always be at least one valid message in the log buffer
be design.

Do I get it correctly, please?

IMHO, it would deserve a comment and maybe even a warning.
What about something like?

	/* Number of chars in the log buffer */
	case SYSLOG_ACTION_SIZE_UNREAD:
		logbuf_lock_irq();
		if (!prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
			/* No unread message */
			if (syslog_partial) {
				/* This should never happen. */
				pr_err_once("Unable to read any message even when the last syslog read was partial: %zu", syslog_partial);
				syslog_partial = 0;
			}
			logbuf_unlock_irq();
			return 0;
		}
		if (info.seq != syslog_seq) {
			/* messages are gone, move to first one */
			syslog_seq = info.seq;
			syslog_partial = 0;
		}
		if (source == SYSLOG_FROM_PROC) {
			/*
			 * Short-cut for poll(/"proc/kmsg") which simply checks
		[...]


Best Regards,
Petr
