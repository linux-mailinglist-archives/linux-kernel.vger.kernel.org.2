Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2730AD19
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBAQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:52:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58678 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBAQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:51:59 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612198276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0U85P18JGolozwquk8qN9IwcXoRxo63HyyVjJHZEc8=;
        b=KYw75ikcv2s0KEOGlQaMjbz3g2dr68+Vqc4WQszJi0x3GKMoq1j8NP9GpES9apaQX0ITBz
        O2HeMQ6Uyskw+a2IGpPBOHuPDQ4iA6nQaAVGbRQPF8Co2h+XgT73rpTA7orq9haap9xMUh
        QROqbUCaj6ZKv3JuNvcsbEQjYZAJN+HHGaLq4XdlcXmWSK5ek67XkJRlU0y9EuWBc5++1E
        tu/2445aqo0CtxKCX9VSZCoHqNRqJ7xRMyYUpQ6cE3ucfV3d3jgCx2GnrHLDQgh+lSwNDO
        V6uiJ5+XpyfeVukclrnMYGqhhGrbhWReRuAFWmCppPYHY3tlHueDBwzw9y9mjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612198276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0U85P18JGolozwquk8qN9IwcXoRxo63HyyVjJHZEc8=;
        b=kq8UO9DfsPpGaw/6A+z9zNFGr9cO16/wJ/venR82ZZ2aCYCvJXYMZ3Bbrx63pmJE5ox41K
        SjCN1f7QSLRUeLDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH printk-rework 09/12] um: synchronize kmsg_dumper
In-Reply-To: <YBgM5N4ebSr7YsPq@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de> <20210126211551.26536-10-john.ogness@linutronix.de> <YBgM5N4ebSr7YsPq@alley>
Date:   Mon, 01 Feb 2021 17:57:14 +0106
Message-ID: <875z3bk9z1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Added CC: Thomas Meyer, Richard Weinberger)

On 2021-02-01, Petr Mladek <pmladek@suse.com> wrote:
>> In preparation for removing printk's @logbuf_lock, dumpers that have
>> assumed to be protected against parallel calls must provide their own
>> synchronization. Add a locally static spinlock to synchronize the
>> kmsg_dump call and temporary buffer usage.
>> 
>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> ---
>>  arch/um/kernel/kmsg_dump.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
>> index f38349ad00ea..173999422ed8 100644
>> --- a/arch/um/kernel/kmsg_dump.c
>> +++ b/arch/um/kernel/kmsg_dump.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include <linux/kmsg_dump.h>
>> +#include <linux/spinlock.h>
>>  #include <linux/console.h>
>>  #include <shared/init.h>
>>  #include <shared/kern.h>
>> @@ -9,8 +10,10 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>>  				enum kmsg_dump_reason reason,
>>  				struct kmsg_dumper_iter *iter)
>>  {
>> +	static DEFINE_SPINLOCK(lock);
>>  	static char line[1024];
>>  	struct console *con;
>> +	unsigned long flags;
>>  	size_t len = 0;
>>  
>>  	/* only dump kmsg when no console is available */
>> @@ -25,11 +28,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>>  	if (con)
>>  		return;
>>  
>> +	if (!spin_trylock_irqsave(&lock, flags))
>> +		return;
>> +
>>  	printf("kmsg_dump:\n");
>>  	while (kmsg_dump_get_line(iter, true, line, sizeof(line), &len)) {
>>  		line[len] = '\0';
>>  		printf("%s", line);
>>  	}
>> +
>> +	spin_unlock_irqrestore(&lock, flags);
>
> What exactly is synchronized here, please?
> Access to @line buffer or @iter or both?

@line is being synchronized. @iter does not require synchronization.

> It looks to me that the access to @line buffer was not synchronized
> before. kmsg_dump_get_line() used a lock internally but
> it was not synchronized with the later printf("%s", line);

The line was previously synchronized for the kmsg_dump_get_line()
call. But yes, it was not synchronized after the call, which is a bug if
the dump is triggered on multiple CPUs simultaneously. The commit
message should also mention that it is handling that bug.

> IMHO, this patch is not needed.

I am not familiar enough with ARCH=um to know if dumps can be triggered
on multiple CPUs simultaneously. Perhaps ThomasM or Richard can chime in
here.

John Ogness
