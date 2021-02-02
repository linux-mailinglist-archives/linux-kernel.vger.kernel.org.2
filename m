Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE030BE38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhBBMby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:31:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:59098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhBBMbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:31:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612269064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+kOUFeIToWVoJVVF7dCnhiy06d4JGpuZE1QLGnt+Rw=;
        b=VqYp9mwzODgfdBcxFJ/ZlKCiQuYtCR8hzvYkYwdt4F96ORsc1X8lajfLKpcKyGBcQubKJs
        QHIHoRqgK9UK2VAv27iIqcqFLDIHNy2aGD0J0z+0eTUxfELZX5Y83oMAE32gXwEVjCTTjy
        wx5yFi8O6HZP5sIkVIwquGiqRB0q1Mw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4F51AC45;
        Tue,  2 Feb 2021 12:31:04 +0000 (UTC)
Date:   Tue, 2 Feb 2021 13:31:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 03/12] printk: consolidate
 kmsg_dump_get_buffer/syslog_print_all code
Message-ID: <YBlGCBKgOzf3At/c@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-4-john.ogness@linutronix.de>
 <YBQgTQYTA5p6Wgj6@alley>
 <87pn1kjexp.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn1kjexp.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-02-01 10:55:22, John Ogness wrote:
> On 2021-01-29, Petr Mladek <pmladek@suse.com> wrote:
> >> The logic for finding records to fit into a buffer is the same for
> >> kmsg_dump_get_buffer() and syslog_print_all(). Introduce a helper
> >> function find_first_fitting_seq() to handle this logic.
> >> 
> >> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> >> ---
> >>  kernel/printk/printk.c | 71 ++++++++++++++++++++++++------------------
> >>  1 file changed, 41 insertions(+), 30 deletions(-)
> >> 
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 1929aa372e7f..ec2174882b8e 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -1421,6 +1421,41 @@ static size_t get_record_print_text_size(struct printk_info *info,
> >>  	return ((prefix_len * line_count) + info->text_len + 1);
> >>  }
> >>  
> >> +/*
> >> + * Beginning with @start_seq, find the first record where it and all following
> >> + * records up to (but not including) @max_seq fit into @size.
> >
> > Please, mention that all existing messages are checked when @max_seq
> > == -1 is used.
> 
> -1 is not special for that purpose, but I will add a comment that if
>  there is no required upper bound, the caller can use -1.

Thanks. I think that it is good to mention that the function is able
to handle this situation. For example, it will not wait until
a message with @max_seq is available ;-)

> >> + */
> >> +static u64 find_first_fitting_seq(u64 start_seq, u64 max_seq, size_t size,
> >> +				  struct printk_info *info, bool syslog, bool time)
> >> +{

> >> +	/*
> >> +	 * Move first record forward until length fits into the buffer. Ignore
> >> +	 * newest messages that were not counted in the above cycle. Messages
> >> +	 * might appear and get lost in the meantime. This is a best effort
> >> +	 * that prevents an infinite loop that could occur with a retry.
> >> +	 */
> >> +	if (seq < max_seq)
> >> +		max_seq = seq;
> >
> > This made my head twist around several times ;-)
> >
> > It should never be true in kmsg_dump_get_buffer().
> 
> Correct. It is there because of syslog_print_all().
> 
> > And there was nothing like this in the original syslog_print_all().
> 
> With logbuf_lock, it is not possible that new messages arrive in between
> these two loops. But without logbuf_lock, it _is_ possible and this
> needs to be handled.

I see.

> I can expand the commit message to mention this necessary change.

Yes, please. I am fine with the code now.



> >> @@ -3436,26 +3461,12 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
> >>  
> >>  	/*
> >>  	 * Find first record that fits, including all following records,
> >> -	 * into the user-provided buffer for this dump.
> >> +	 * into the user-provided buffer for this dump. Pass in size-1
> >> +	 * because this function (by way of record_print_text()) will
> >> +	 * not write more than size-1 bytes of text into @buf.
> >
> > We should do the same also in syslog_print_all(). It must have the
> > same problem. The last message might get lost when there is not
> > a space for the trailing '\0' that was not counted before.
> 
> No, it does not have the same problem. I also made the mistake [0] of
> thinking that.
> 
> copy_to_user() is the function filling the buffer, not
> record_print_text(). And it will (and always has) fill the full
> buffer. Only kmsg_dump_get_buffer() has the bizarre semantics of not
> using the full buffer.

Right. I got it the wrong way.

> > And it might be better to actually change the condition in
> > find_first_fitting_seq(). I mean to replace:
> >
> > 	if (len <= size || info.seq >= max_seq)
> > with
> > 	if (len < size || info.seq >= max_seq)
> 
> I would prefer not twisting syslog_print_all() to act like
> kmsg_dump_get_buffer().

I agree. It is not a common problem after all.

Best Regards,
Petr
