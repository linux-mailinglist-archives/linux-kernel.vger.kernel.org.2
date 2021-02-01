Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991FF30A49E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhBAJuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:50:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhBAJuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:50:06 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612172963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBJ7xeiaHzq8w0SSTCCosCGktNplLkq2ELydnDpCHUM=;
        b=rswIkpzF568gbO3cI0b5UjwSgiPe7ZHUd3flfYh+vpOixdO5OcbtiLJxaH9jJddVZwsQWR
        pqfMlqbu6tPUJkJBiYC1A1ytQcjn1+WsmMABRm1UZ6BFQWCEAKcumHfCCM5XmBtLm5OMwk
        kY9mFEFZCvdUaEynKdDufGPHBcVTJxBk3sGZ62kgfI7JS+i4HjQSyvzfjLjB+2jG1/sJqr
        FoYy4svZw49/oXzZdeuK1pTUJiWkZ3mhFFA/gy51J262SBOvRiI0GEaiaFUfN8WLGc9oP9
        Fb1q7oXfUGgsCIfmm3Z4ESvteYHT/ZbjSJlrYPJWxa/P3eavk9DySdnZfbYrsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612172963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBJ7xeiaHzq8w0SSTCCosCGktNplLkq2ELydnDpCHUM=;
        b=kQdBn5F/dvHWKwgnkzhuL1le/8hdHC4s8+bdCrVWtZUlLwOmLUle63Bt0QYB/C7akm+WDd
        9yN/Ob/Zq2j3PTAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 03/12] printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
In-Reply-To: <YBQgTQYTA5p6Wgj6@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de> <20210126211551.26536-4-john.ogness@linutronix.de> <YBQgTQYTA5p6Wgj6@alley>
Date:   Mon, 01 Feb 2021 10:55:22 +0106
Message-ID: <87pn1kjexp.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-29, Petr Mladek <pmladek@suse.com> wrote:
>> The logic for finding records to fit into a buffer is the same for
>> kmsg_dump_get_buffer() and syslog_print_all(). Introduce a helper
>> function find_first_fitting_seq() to handle this logic.
>> 
>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> ---
>>  kernel/printk/printk.c | 71 ++++++++++++++++++++++++------------------
>>  1 file changed, 41 insertions(+), 30 deletions(-)
>> 
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 1929aa372e7f..ec2174882b8e 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1421,6 +1421,41 @@ static size_t get_record_print_text_size(struct printk_info *info,
>>  	return ((prefix_len * line_count) + info->text_len + 1);
>>  }
>>  
>> +/*
>> + * Beginning with @start_seq, find the first record where it and all following
>> + * records up to (but not including) @max_seq fit into @size.
>
> Please, mention that all existing messages are checked when @max_seq
> == -1 is used.

-1 is not special for that purpose, but I will add a comment that if
 there is no required upper bound, the caller can use -1.

>> + */
>> +static u64 find_first_fitting_seq(u64 start_seq, u64 max_seq, size_t size,
>> +				  struct printk_info *info, bool syslog, bool time)
>> +{
>> +	unsigned int line_count;
>> +	size_t len = 0;
>> +	u64 seq;
>
> Please, use local struct printk_info. It will be clear that it does
> not have any side-effects for the callers.

OK. The compiler should be able to optimize the stack usage.

>> +
>> +	/* Determine the size of the records up to @max_seq. */
>> +	prb_for_each_info(start_seq, prb, seq, info, &line_count) {
>> +		if (info->seq >= max_seq)
>> +			break;
>> +		len += get_record_print_text_size(info, line_count, syslog, time);
>> +	}
>> +
>> +	/*
>> +	 * Move first record forward until length fits into the buffer. Ignore
>> +	 * newest messages that were not counted in the above cycle. Messages
>> +	 * might appear and get lost in the meantime. This is a best effort
>> +	 * that prevents an infinite loop that could occur with a retry.
>> +	 */
>> +	if (seq < max_seq)
>> +		max_seq = seq;
>
> This made my head twist around several times ;-)
>
> It should never be true in kmsg_dump_get_buffer().

Correct. It is there because of syslog_print_all().

> And there was nothing like this in the original syslog_print_all().

Yes, there was. But it was implemented subtly.

This upcoming second loop is subtracting string lengths from _messages
that were read in the first loop_. It would be a bug to subtract lengths
from messages that were not counted in the first loop. The comment even
mentions this:

"Ignore newest messages that were not counted in the above cycle."

With logbuf_lock, it is not possible that new messages arrive in between
these two loops. But without logbuf_lock, it _is_ possible and this
needs to be handled.

I can expand the commit message to mention this necessary change.

> But I still think that the original code had better results.
> Lost messages are typically replaced with similar amount
> of new messages. syslog_print_all() should return
> the newest messages. And the original code better
> fulfilled this requirement.

If you remove logbuf_lock, the original code is broken.

>> +	prb_for_each_info(start_seq, prb, seq, info, &line_count) {
>> +		if (len <= size || info->seq >= max_seq)
>> +			break;
>> +		len -= get_record_print_text_size(info, line_count, syslog, time);
>> +	}
>> +
>> +	return seq;
>> +}
>> +
>>  static int syslog_print(char __user *buf, int size)
>>  {
>>  	struct printk_info info;
>> @@ -1492,7 +1527,6 @@ static int syslog_print(char __user *buf, int size)
>>  static int syslog_print_all(char __user *buf, int size, bool clear)
>>  {
>>  	struct printk_info info;
>> -	unsigned int line_count;
>>  	struct printk_record r;
>>  	char *text;
>>  	int len = 0;
>> @@ -1509,15 +1543,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
>>  	 * Find first record that fits, including all following records,
>>  	 * into the user-provided buffer for this dump.
>>  	 */
>> -	prb_for_each_info(clear_seq, prb, seq, &info, &line_count)
>> -		len += get_record_print_text_size(&info, line_count, true, time);
>> -
>> -	/* move first record forward until length fits into the buffer */
>> -	prb_for_each_info(clear_seq, prb, seq, &info, &line_count) {
>> -		if (len <= size)
>> -			break;
>> -		len -= get_record_print_text_size(&info, line_count, true, time);
>> -	}
>> +	seq = find_first_fitting_seq(clear_seq, -1, size, &info, true, time);
>>  
>>  	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
>>  
>> @@ -3410,7 +3436,6 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
>>  			  char *buf, size_t size, size_t *len_out)
>>  {
>>  	struct printk_info info;
>> -	unsigned int line_count;
>>  	struct printk_record r;
>>  	unsigned long flags;
>>  	u64 seq;
>> @@ -3436,26 +3461,12 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
>>  
>>  	/*
>>  	 * Find first record that fits, including all following records,
>> -	 * into the user-provided buffer for this dump.
>> +	 * into the user-provided buffer for this dump. Pass in size-1
>> +	 * because this function (by way of record_print_text()) will
>> +	 * not write more than size-1 bytes of text into @buf.
>
> We should do the same also in syslog_print_all(). It must have the
> same problem. The last message might get lost when there is not
> a space for the trailing '\0' that was not counted before.

No, it does not have the same problem. I also made the mistake [0] of
thinking that.

copy_to_user() is the function filling the buffer, not
record_print_text(). And it will (and always has) fill the full
buffer. Only kmsg_dump_get_buffer() has the bizarre semantics of not
using the full buffer.

Note that syslog_print_all() uses CONSOLE_LOG_MAX for
record_print_text() and @size for copy_to_user().

The bug here is that CONSOLE_LOG_MAX is too small. But we've had this
bug for a long time.

> We should fix syslog_print_all() in a separate preparation patch
> before we introduce the common function.
>
> And it might be better to actually change the condition in
> find_first_fitting_seq(). I mean to replace:
>
> 	if (len <= size || info.seq >= max_seq)
> with
> 	if (len < size || info.seq >= max_seq)

I would prefer not twisting syslog_print_all() to act like
kmsg_dump_get_buffer().

John Ogness

[0] https://lkml.kernel.org/r/20210120194106.26441-2-john.ogness@linutronix.de
