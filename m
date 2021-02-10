Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D566316EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhBJShv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhBJS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:26:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9386AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:26:12 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612981571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBuCn3mUPAVSytsaOkj6uZwzU9Wq36KTP7dWW+6MY18=;
        b=xJ8HvxrRoGGICXuuRHzYBBmWSgerRiTthB7PcUIi/jrKMh37ht+9JZxKeji1KiKH97JP79
        Xozmvn8+w8zsYhyHoeFMTJBgXWZbOv1dxA55xYsjDi//5xHzBNIjc+lB/o1+wjsx2Dk75q
        TIXbN3PiYbccHILLWtXAvMR/ehChTag2NEU/RSRF+jUeDAmEwt+B5SiZnhzzubly1EZGQ+
        9JbBmv+p0NC+ocjUaxalUcSEuuN+F+tTh3TiW5bY4r2FVucpiKJVBT98jc5SZm+81fqvkM
        BbY0NR7gdF0dI6cZBt36f4h2lUdJwdUthvXRpuyT7ux5WNWs+CfPcRA3N8lFHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612981571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBuCn3mUPAVSytsaOkj6uZwzU9Wq36KTP7dWW+6MY18=;
        b=ubDoMGXMYLFlyn4V3h1tLjPO+hpq/HL25V+yo+6rEvikU8m+T+uQ1+3t7aaYgTH/XyrI5B
        yi8sDTevmezIjOBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, "J. Avila" <elavila@google.com>
Subject: Re: [PATCH] printk: avoid prb_first_valid_seq() where possible
In-Reply-To: <YCLKvCNJwabVavAP@alley>
References: <20210205141728.18117-1-john.ogness@linutronix.de> <YCLKvCNJwabVavAP@alley>
Date:   Wed, 10 Feb 2021 19:32:10 +0106
Message-ID: <874kij4w59.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-09, Petr Mladek <pmladek@suse.com> wrote:
>> @@ -1629,9 +1631,13 @@ int do_syslog(int type, char __user *buf, int len, int source)
>>  	/* Number of chars in the log buffer */
>>  	case SYSLOG_ACTION_SIZE_UNREAD:
>>  		logbuf_lock_irq();
>> -		if (syslog_seq < prb_first_valid_seq(prb)) {
>> -			/* messages are gone, move to first one */
>> -			syslog_seq = prb_first_valid_seq(prb);
>> +		if (prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
>> +			if (info.seq != syslog_seq) {
>> +				/* messages are gone, move to first one */
>> +				syslog_seq = info.seq;
>> +				syslog_partial = 0;
>> +			}
>> +		} else {
>>  			syslog_partial = 0;
>
> I am scratching my head when prb_read_valid_info(prb,
> syslog_seq, &info, NULL)) might fail.

It can fail because the descriptor has been invalidated/recycled by
writers and perhaps there is no valid record that has yet come after it.

> It might fail when syslog_seq points to the next message
> after the last valid one. In this case, we could return
> immediately (after releasing the lock) because there are
> zero unread messages.

Yes, we could just return 0 in this case. If we are returning and not
modifying @syslog_seq, then there is no need to reset
@syslog_partial. At some point a reader will notice that the record is
gone and reset @syslog_partial accordingly.

> Anyway, syslog_partial must be zero in this case. syslog_seq
> should stay when the last read was partial. And there should
> always be at least one valid message in the log buffer
> be design.

A record can be invalidated at any time. It is a normal case that a
re-read of a record (to get the rest of the partial) can lead to the
record no longer being available.

> IMHO, it would deserve a comment and maybe even a warning.

I don't think we need a warning. It is something that can happen and it
is not a problem.

> What about something like?
>
> 	/* Number of chars in the log buffer */
> 	case SYSLOG_ACTION_SIZE_UNREAD:
> 		logbuf_lock_irq();
> 		if (!prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
> 			/* No unread message */
> 			if (syslog_partial) {
> 				/* This should never happen. */
> 				pr_err_once("Unable to read any message even when the last syslog read was partial: %zu", syslog_partial);
> 				syslog_partial = 0;
> 			}
> 			logbuf_unlock_irq();
> 			return 0;
> 		}

I recommend changing your suggestion to:

> 		if (!prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
>			/*
>			 * No unread messages. No need to check/reset
>			 * syslog_partial. When a reader does read a new
>			 * message it will notice and appropriately update
>			 * syslog_seq and reset syslog_partial.
>			 */
> 			logbuf_unlock_irq();
> 			return 0;
> 		}
> 		if (info.seq != syslog_seq) {
> 			/* messages are gone, move to first one */
> 			syslog_seq = info.seq;
> 			syslog_partial = 0;
> 		}

John Ogness
