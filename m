Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E523B3281
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhFXP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:27:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48766 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhFXP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:27:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7FBCE1FD8F;
        Thu, 24 Jun 2021 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624548327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yc3h6TajWdbkUMkxCeO1oeYy15hHaSS3fkBWzEv4p5Y=;
        b=nGgd2eRmxU5On5RUmq8CvZeFQNx+NZV0PJ5S3xjs/ySYMa415OZYI0UKPessMxdLLCLKcE
        idDp4Ci+kPtewPgvXBPIsxMWoasYKANJnMhGRa/qLe9rVJxklhoU3f+sp5ap3RZlTFJFRZ
        s1+hToSz9/iF5DsJN7jZV0Zuhpmc4Ug=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 53CF8A3BD2;
        Thu, 24 Jun 2021 15:25:27 +0000 (UTC)
Date:   Thu, 24 Jun 2021 17:25:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: syslog: close window between wait
 and read
Message-ID: <YNSj59rKfGARoWRD@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
 <20210624111148.5190-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624111148.5190-7-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-24 13:17:48, John Ogness wrote:
> Syslog's SYSLOG_ACTION_READ is supposed to block until the next
> syslog record can be read, and then it should read that record.
> However, because @syslog_lock is not held between waking up and
> reading the record, another reader could read the record first,
> thus causing SYSLOG_ACTION_READ to return with a value of 0, never
> having read _anything_.
> 
> By holding @syslog_lock between waking up and reading, it can be
> guaranteed that SYSLOG_ACTION_READ blocks until it successfully
> reads a syslog record (or a real error occurs).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 50 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 90954cb5a0ab..4737804d6c6d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1542,8 +1570,13 @@ static int syslog_print(char __user *buf, int size)
>  		len += n;
>  		size -= n;
>  		buf += n;
> -	}
>  
> +		if (!size)
> +			break;

This looks like an unrelated optimization. If I get it correctly,
it does not change the existing behavior. The next cycle would
end up with n == 0 and break anyway.

It would have been better to do it in a separate patch or do not do
it at all or at least mention it in the commit message.

> +
> +		mutex_lock(&syslog_lock);
> +	}
> +out:
>  	kfree(text);
>  	return len;
>  }

The patch itself makes sense. It somehow fixes a long standing race.
Even though the result still might be racy. The lock is released
when each record is copied to the user-provided buffer.

I do not want to block it because of details. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

but I would feel more comfortable if we handled the optimization one
of the suggested way.

Best Regards,
Petr
