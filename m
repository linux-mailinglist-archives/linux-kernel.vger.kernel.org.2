Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3730A5F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhBAK5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:57:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56736 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhBAK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:56:49 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612176967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3b3ONkRx+Y110fQzzC6LdVzaXGV6aFBO4TMx+cCFyJQ=;
        b=MRg8GBEN5++zaK/UD+HezSsIxfIN/dVAKGywbh7sVoJlxvhG5+Vd/IDy+oJMs/5PMMSFEB
        /1pcn7M2n7kBpXYDiAGGbe6wa1t1vob9k3OLBJXwM4IdlTruWw5+qPIVt0H3qD84cbyhAq
        QcrY3R0qR37Qw9xLIL8HYAcA/PKT7VTtFQh40QdKCejSB7/mS2gpmhS7wSGdwNnwUsON0g
        aAF9nZvyZPBuQLqzJZJcn/NIc4A7Yr0I6KeyPT1w2ZEy5e4EKcFSpcIcOd7pXVMESxVlJC
        FL1Qqf8ZuTW/Sftq1VQHW9H4AcrPm9QsRrLvWk/+LUnn5U1MSnmUdq1hu9lw7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612176967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3b3ONkRx+Y110fQzzC6LdVzaXGV6aFBO4TMx+cCFyJQ=;
        b=v0PReqaTNqGifN5D0arrp1P5QqfhUkaSu6oV8lLt1ctS0qJIzlArkWTfPm521qt3ZsBLM0
        EVHozfUcqeR4s+Cw==
To:     Michael Kelley <mikelley@microsoft.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH printk-rework 10/12] hv: synchronize kmsg_dumper
In-Reply-To: <MWHPR21MB1593C37614E7F1334EB0AA7FD7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210126211551.26536-1-john.ogness@linutronix.de> <20210126211551.26536-11-john.ogness@linutronix.de> <MWHPR21MB1593C37614E7F1334EB0AA7FD7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
Date:   Mon, 01 Feb 2021 12:02:06 +0106
Message-ID: <87mtwojbuh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-27, Michael Kelley <mikelley@microsoft.com> wrote:
>> In preparation for removing printk's @logbuf_lock, dumpers that have
>> assumed to be protected against parallel calls must provide their own
>> synchronization. Add a locally static spinlock to synchronize the
>> kmsg_dump call.
>> 
>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> ---
>>  drivers/hv/vmbus_drv.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index fbeddef90941..08db95e1a139 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -1362,23 +1362,27 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
>>  			 enum kmsg_dump_reason reason,
>>  			 struct kmsg_dumper_iter *iter)
>>  {
>> +	static DEFINE_SPINLOCK(lock);
>>  	size_t bytes_written;
>>  	phys_addr_t panic_pa;
>> +	unsigned long flags;
>> 
>>  	/* We are only interested in panics. */
>>  	if ((reason != KMSG_DUMP_PANIC) || (!sysctl_record_panic_msg))
>>  		return;
>> 
>> +	if (!spin_trylock_irqsave(&lock, flags))
>> +		return;
>> +
>>  	panic_pa = virt_to_phys(hv_panic_page);
>> 
>> -	/*
>> -	 * Write dump contents to the page. No need to synchronize; panic should
>> -	 * be single-threaded.
>> -	 */
>> +	/* Write dump contents to the page. */
>>  	kmsg_dump_get_buffer(iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
>>  			     &bytes_written);
>>  	if (bytes_written)
>>  		hyperv_report_panic_msg(panic_pa, bytes_written);
>> +
>> +	spin_unlock_irqrestore(&lock, flags);
>>  }
>> 
>>  static struct kmsg_dumper hv_kmsg_dumper = {
>> --
>> 2.20.1
>
> I don't think this patch is needed.   Per some of the unmodified code
> above, and the comment, we proceed to the call to kmsg_dump_get_buffer()
> only in the panic path.  Code in the panic path prior to invoking kmsg_dump()
> ensures that we are single-threaded on a single CPU.   So I think everything
> is good here without the new spin lock.  The subsequent call to
> hyperv_report_panic_msg() also assumes that we are single-threaded.

You are correct. I will withdraw this patch from the series. Thanks for
the feedback.

John Ogness
