Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A253530B18F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhBAU0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:26:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59912 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhBAU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:26:41 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612211159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5OCK7idbG8XOABo1sGDGqpQvwitqz1CHdDHNPEdV+84=;
        b=sRO98TWSBKbaVUEmX0yEqzNfSGhD+FZxBIAZyglkkrRje9+jsLRVZ0nPg/9x88j+bXnfQX
        XvklY1SCvnS5I2NG4O82pwquPp4OvTgs2cjGm776JhEYoamcrHQ6aTrxerMZMs6/Jx1EDa
        8cDDHbsDsqihlrsu7X/Z52QXCebADKUJkFDgemMcog7SEdOAUsMoroLu5AWvgzsA3ZDu9b
        r6KMWOTlBabPhDy7xAES3AJR6PaXKxTlHEZIxwCdKHli4X4uMFaZvHs14GXazeuyfgFses
        dkL/gGilgKjHMHBu1480T/DcRrvAfEjobdtg+fYgXAlwg/ZszrF6SK3uIwO0Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612211159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5OCK7idbG8XOABo1sGDGqpQvwitqz1CHdDHNPEdV+84=;
        b=9FqUDXXl8e2PryHBggLgWqyCEMIZa0DYWUo9gC74ireBoOhJ1RJHXUsGgpYt/bAclYbJ/S
        trnIE39l4vj+KyDA==
To:     Richard Weinberger <richard@nod.at>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        tglx <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [PATCH printk-rework 09/12] um: synchronize kmsg_dumper
In-Reply-To: <1829482025.350347.1612198481059.JavaMail.zimbra@nod.at>
References: <20210126211551.26536-1-john.ogness@linutronix.de> <20210126211551.26536-10-john.ogness@linutronix.de> <YBgM5N4ebSr7YsPq@alley> <875z3bk9z1.fsf@jogness.linutronix.de> <1829482025.350347.1612198481059.JavaMail.zimbra@nod.at>
Date:   Mon, 01 Feb 2021 21:31:57 +0106
Message-ID: <87v9bbzga2.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 2021-02-01, Richard Weinberger <richard@nod.at> wrote:
>>>> In preparation for removing printk's @logbuf_lock, dumpers that have
>>>> assumed to be protected against parallel calls must provide their own
>>>> synchronization. Add a locally static spinlock to synchronize the
>>>> kmsg_dump call and temporary buffer usage.
>>>> 
>>>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>>>> ---
>>>>  arch/um/kernel/kmsg_dump.c | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>> 
>>>> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
>>>> index f38349ad00ea..173999422ed8 100644
>>>> --- a/arch/um/kernel/kmsg_dump.c
>>>> +++ b/arch/um/kernel/kmsg_dump.c
>>>> @@ -1,5 +1,6 @@
>>>>  // SPDX-License-Identifier: GPL-2.0
>>>>  #include <linux/kmsg_dump.h>
>>>> +#include <linux/spinlock.h>
>>>>  #include <linux/console.h>
>>>>  #include <shared/init.h>
>>>>  #include <shared/kern.h>
>>>> @@ -9,8 +10,10 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>>>>  				enum kmsg_dump_reason reason,
>>>>  				struct kmsg_dumper_iter *iter)
>>>>  {
>>>> +	static DEFINE_SPINLOCK(lock);
>>>>  	static char line[1024];
>>>>  	struct console *con;
>>>> +	unsigned long flags;
>>>>  	size_t len = 0;
>>>>  
>>>>  	/* only dump kmsg when no console is available */
>>>> @@ -25,11 +28,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>>>>  	if (con)
>>>>  		return;
>>>>  
>>>> +	if (!spin_trylock_irqsave(&lock, flags))
>>>> +		return;
>>>> +
>>>>  	printf("kmsg_dump:\n");
>>>>  	while (kmsg_dump_get_line(iter, true, line, sizeof(line), &len)) {
>>>>  		line[len] = '\0';
>>>>  		printf("%s", line);
>>>>  	}
>>>> +
>>>> +	spin_unlock_irqrestore(&lock, flags);
>>>
>>> What exactly is synchronized here, please?
>>> Access to @line buffer or @iter or both?
>> 
>> @line is being synchronized. @iter does not require synchronization.
>> 
>>> It looks to me that the access to @line buffer was not synchronized
>>> before. kmsg_dump_get_line() used a lock internally but
>>> it was not synchronized with the later printf("%s", line);
>> 
>> The line was previously synchronized for the kmsg_dump_get_line()
>> call. But yes, it was not synchronized after the call, which is a bug if
>> the dump is triggered on multiple CPUs simultaneously. The commit
>> message should also mention that it is handling that bug.
>> 
>>> IMHO, this patch is not needed.
>> 
>> I am not familiar enough with ARCH=um to know if dumps can be triggered
>> on multiple CPUs simultaneously. Perhaps ThomasM or Richard can chime in
>> here.
>
> Well, uml has no SMP support, so no parallel dumps. :-)

When I grep through arch/um, I see many uses of spinlocks. This would
imply that uml at least has some sort of preemption model where they are
needed. Dumps can trigger from any context and from multiple paths.

If you are sure that this is no concern, then I will drop this patch
from my series.

John Ogness
