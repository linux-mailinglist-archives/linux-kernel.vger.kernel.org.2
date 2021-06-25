Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4E43B462C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhFYO5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:57:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60302 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhFYO5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:57:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 94AD51FEBB;
        Fri, 25 Jun 2021 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624632908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDZpsIs/N5XU/kxkWnJfJE+FiKybAILtt39imZf63To=;
        b=aX/Qi/Bmvx7ALhe+DiBaZVa1uOUnQuD5k6dlg9/kHjDoEeU/QvN5DF4GN4fwKkR75edPGb
        lO/JvNJFW/gz81tUEmMhuUQsKYiqq2RSt9dmDjfniuojVGLawPKoSbKKp+HTOw1z5lWWXR
        Qe9nOds6giLRCgeXFdl9QXet2o8/B54=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 67FD6A3BEE;
        Fri, 25 Jun 2021 14:55:08 +0000 (UTC)
Date:   Fri, 25 Jun 2021 16:55:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: syslog: close window between wait
 and read
Message-ID: <YNXuSx5KaCSaotqC@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
 <20210624111148.5190-7-john.ogness@linutronix.de>
 <YNSj59rKfGARoWRD@alley>
 <87zgvetlc3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgvetlc3.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-06-25 10:17:40, John Ogness wrote:
> On 2021-06-24, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 90954cb5a0ab..4737804d6c6d 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -1542,8 +1570,13 @@ static int syslog_print(char __user *buf, int size)
> >>  		len += n;
> >>  		size -= n;
> >>  		buf += n;
> >> -	}
> >>  
> >> +		if (!size)
> >> +			break;
> >
> > This looks like an unrelated optimization. If I get it correctly, it
> > does not change the existing behavior.
> 
> It was a necessary change in order to preserve the existing logic but
> allow the lock to be held when enterring the loop. Before the patch we
> have:
> 
>         ...get seq to read...
> 
>         while (size > 0) {
>             mutex_lock(&syslog_lock);
>             ...read record...
>             mutex_unlock(&syslog_lock);
>             ...copy record...
>        }
> 
> After the patch we enter the loop with the lock already held. So this
> changes the code to:
> 
>         mutex_lock(&syslog_lock);
>         ...get seq to read...
> 
>         for (;;) {
>             ...read record...
>             mutex_unlock(&syslog_lock);
>             ...copy record...
>            
>             if (!size)
>                 break;
>             mutex_lock(&syslog_lock);               
>         }
> 
> Note that @size always starts with >0, so there is no need to check it
> at the beginning of the loop. And checking for !0 instead of >0 is also
> ok, since @size will never be less than zero.

Ah, I have missed that you replaced the while-cycle with a for-cycle.
It makes sense now.

Plese, just mention these changes in the commit message. I mean that
size is always >0 at the befinning and never <0 later.

> > The patch itself makes sense. It somehow fixes a long standing race.
> > Even though the result still might be racy. The lock is released
> > when each record is copied to the user-provided buffer.
> 
> I do not understand this conclusion. The existing race is
> real. SYSLOG_ACTION_READ could return with no data, not because there is
> no records available, but because the race was hit. With this patch that
> race is closed: SYSLOG_ACTION_READ will either return with data or with
> an error.
> 
> You claim the result is still racy, but I do not know what you are
> referring to. If you have multiple readers, they will get different
> records (and record pieces), but collectively no data would be lost and
> no data would be redundant. And no readers would return from
> SYSLOG_ACTION_READ without data.

I mean that each reader will still get random lines. The race is that
it is not guaranteed what reader would get what lines.

By other words, the improvement is that each reader will read
at least something. But it is still not guaranteed that it will
see everything.

My understanding is that it was designed for a single daemon reading
all messages. And dmesg might probably cause races when using
the syslog interface.

Best Regards,
Petr
