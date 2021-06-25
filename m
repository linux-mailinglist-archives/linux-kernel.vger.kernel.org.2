Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4342F3B3E47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFYIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFYIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:14:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8320C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:11:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624608700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtTpvCaDpTpRwJ7zZBGx4YUucpXj870woqm40fqmy5w=;
        b=rk4+OTUMLGh8+vYEkhJLLEhf4TnI5agvbTZXqsZmRQexJIlvqLWXt4HZAAxJ9iAmYjfKiF
        94l2i5qRAE8wDzBTzSpjPuObOZVADYYPhJ9agOG0KlICQMglXOIzfNinu25lRsULuK5q0t
        K1K0T3qoa5amuyzHWwmS3j2oOMCs4yU1o8gquZVUnZbDegcUdh11Tt4gNYRnv1CI7VO6ib
        /gJLY7eloHF/pclW1LM5oGAGgynaomeSYu0AjUcIn7q5hx1oxB4MCtLHIvKFnV57hc6moI
        5J9Az8HLDcWu/IaibgYjD8jLpInlGU6/e2VLJ5kzuh3gsP9qXc5MJxZ6P+pvDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624608700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtTpvCaDpTpRwJ7zZBGx4YUucpXj870woqm40fqmy5w=;
        b=Fo2+zSwBgRNxvmap/sIXPsg2rM1I0gI0dFvfVC6JtNK537Htv471XCF4TVM5xJjbSFfC8M
        LvrZN+2CKuETsbCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: syslog: close window between wait and read
In-Reply-To: <YNSj59rKfGARoWRD@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de> <20210624111148.5190-7-john.ogness@linutronix.de> <YNSj59rKfGARoWRD@alley>
Date:   Fri, 25 Jun 2021 10:17:40 +0206
Message-ID: <87zgvetlc3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-24, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 90954cb5a0ab..4737804d6c6d 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1542,8 +1570,13 @@ static int syslog_print(char __user *buf, int size)
>>  		len += n;
>>  		size -= n;
>>  		buf += n;
>> -	}
>>  
>> +		if (!size)
>> +			break;
>
> This looks like an unrelated optimization. If I get it correctly, it
> does not change the existing behavior.

It was a necessary change in order to preserve the existing logic but
allow the lock to be held when enterring the loop. Before the patch we
have:

        ...get seq to read...

        while (size > 0) {
            mutex_lock(&syslog_lock);
            ...read record...
            mutex_unlock(&syslog_lock);
            ...copy record...
       }

After the patch we enter the loop with the lock already held. So this
changes the code to:

        mutex_lock(&syslog_lock);
        ...get seq to read...

        for (;;) {
            ...read record...
            mutex_unlock(&syslog_lock);
            ...copy record...
           
            if (!size)
                break;
            mutex_lock(&syslog_lock);               
        }

Note that @size always starts with >0, so there is no need to check it
at the beginning of the loop. And checking for !0 instead of >0 is also
ok, since @size will never be less than zero.

> The next cycle would end up with n == 0 and break anyway.

Doing an extra loop of reading more data and sprinting it into the
temporary buffer even though we know the user buffer is not desirable.

If you insisted on keeping the "while (size > 0)" loop, then there would
be an unnecessary lock/unlock call and the code gets even more complex.

I could add some comments to the implementation if you prefer.

> The patch itself makes sense. It somehow fixes a long standing race.
> Even though the result still might be racy. The lock is released
> when each record is copied to the user-provided buffer.

I do not understand this conclusion. The existing race is
real. SYSLOG_ACTION_READ could return with no data, not because there is
no records available, but because the race was hit. With this patch that
race is closed: SYSLOG_ACTION_READ will either return with data or with
an error.

You claim the result is still racy, but I do not know what you are
referring to. If you have multiple readers, they will get different
records (and record pieces), but collectively no data would be lost and
no data would be redundant. And no readers would return from
SYSLOG_ACTION_READ without data.

> I would feel more comfortable if we handled the optimization one of
> the suggested way.

There is no optimization here. Perhaps you have missed that the loop
changes from "while (size > 0)" to "for (;;)".

John Ogness
