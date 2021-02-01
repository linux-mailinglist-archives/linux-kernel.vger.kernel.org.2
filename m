Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4730130AD2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhBAQzx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Feb 2021 11:55:53 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:40258 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhBAQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:55:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A14DF608A38A;
        Mon,  1 Feb 2021 17:54:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QdTC7UL6ZzsC; Mon,  1 Feb 2021 17:54:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 421C5608A38F;
        Mon,  1 Feb 2021 17:54:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qD71sWIEK9ZZ; Mon,  1 Feb 2021 17:54:41 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1EFC1608A38A;
        Mon,  1 Feb 2021 17:54:41 +0100 (CET)
Date:   Mon, 1 Feb 2021 17:54:41 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        tglx <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Meyer <thomas@m3y3r.de>
Message-ID: <1829482025.350347.1612198481059.JavaMail.zimbra@nod.at>
In-Reply-To: <875z3bk9z1.fsf@jogness.linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de> <20210126211551.26536-10-john.ogness@linutronix.de> <YBgM5N4ebSr7YsPq@alley> <875z3bk9z1.fsf@jogness.linutronix.de>
Subject: Re: [PATCH printk-rework 09/12] um: synchronize kmsg_dumper
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: synchronize kmsg_dumper
Thread-Index: rGdK+jOn3dkfStTjhSYaERhsgfIOaw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

----- Ursprüngliche Mail -----
> Von: "John Ogness" <john.ogness@linutronix.de>
> An: "Petr Mladek" <pmladek@suse.com>
> CC: "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>, "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
> "Steven Rostedt" <rostedt@goodmis.org>, "tglx" <tglx@linutronix.de>, "linux-kernel" <linux-kernel@vger.kernel.org>,
> "Thomas Meyer" <thomas@m3y3r.de>, "richard" <richard@nod.at>
> Gesendet: Montag, 1. Februar 2021 17:51:14
> Betreff: Re: [PATCH printk-rework 09/12] um: synchronize kmsg_dumper

> (Added CC: Thomas Meyer, Richard Weinberger)
> 
> On 2021-02-01, Petr Mladek <pmladek@suse.com> wrote:
>>> In preparation for removing printk's @logbuf_lock, dumpers that have
>>> assumed to be protected against parallel calls must provide their own
>>> synchronization. Add a locally static spinlock to synchronize the
>>> kmsg_dump call and temporary buffer usage.
>>> 
>>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>>> ---
>>>  arch/um/kernel/kmsg_dump.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>> 
>>> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
>>> index f38349ad00ea..173999422ed8 100644
>>> --- a/arch/um/kernel/kmsg_dump.c
>>> +++ b/arch/um/kernel/kmsg_dump.c
>>> @@ -1,5 +1,6 @@
>>>  // SPDX-License-Identifier: GPL-2.0
>>>  #include <linux/kmsg_dump.h>
>>> +#include <linux/spinlock.h>
>>>  #include <linux/console.h>
>>>  #include <shared/init.h>
>>>  #include <shared/kern.h>
>>> @@ -9,8 +10,10 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>>>  				enum kmsg_dump_reason reason,
>>>  				struct kmsg_dumper_iter *iter)
>>>  {
>>> +	static DEFINE_SPINLOCK(lock);
>>>  	static char line[1024];
>>>  	struct console *con;
>>> +	unsigned long flags;
>>>  	size_t len = 0;
>>>  
>>>  	/* only dump kmsg when no console is available */
>>> @@ -25,11 +28,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>>>  	if (con)
>>>  		return;
>>>  
>>> +	if (!spin_trylock_irqsave(&lock, flags))
>>> +		return;
>>> +
>>>  	printf("kmsg_dump:\n");
>>>  	while (kmsg_dump_get_line(iter, true, line, sizeof(line), &len)) {
>>>  		line[len] = '\0';
>>>  		printf("%s", line);
>>>  	}
>>> +
>>> +	spin_unlock_irqrestore(&lock, flags);
>>
>> What exactly is synchronized here, please?
>> Access to @line buffer or @iter or both?
> 
> @line is being synchronized. @iter does not require synchronization.
> 
>> It looks to me that the access to @line buffer was not synchronized
>> before. kmsg_dump_get_line() used a lock internally but
>> it was not synchronized with the later printf("%s", line);
> 
> The line was previously synchronized for the kmsg_dump_get_line()
> call. But yes, it was not synchronized after the call, which is a bug if
> the dump is triggered on multiple CPUs simultaneously. The commit
> message should also mention that it is handling that bug.
> 
>> IMHO, this patch is not needed.
> 
> I am not familiar enough with ARCH=um to know if dumps can be triggered
> on multiple CPUs simultaneously. Perhaps ThomasM or Richard can chime in
> here.

Well, uml has no SMP support, so no parallel dumps. :-)

Thanks,
//richard
