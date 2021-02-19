Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D008131F99B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBSM77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:59:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:50910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBSM74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:59:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613739550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iT7v/Hc6pbxGAvbGXPE669iCQ8dOSQOpgK8a7zDBA9A=;
        b=cp5Wn4I40q1yGdoDovkieIbWyHntzZ8In07rW3nZvT/GTcGuwAPtlCZdMqE3+Of5kE+sT1
        IEpJuiqAGxpl/68iYHyGmFMVGySInr2/6syaM098TgZf3SDPeMideq6WzDEkwvLVsReZto
        J1OUMiNhp8lEC/eQv/qfcnzOFazmUbE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60E04AC6E;
        Fri, 19 Feb 2021 12:59:10 +0000 (UTC)
Date:   Fri, 19 Feb 2021 13:59:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 07/14] printk: use atomic64_t for
 devkmsg_user.seq
Message-ID: <YC+2HaMczMmuaEM8@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-8-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:10, John Ogness wrote:
> @user->seq is indirectly protected by @logbuf_lock. Once @logbuf_lock
> is removed, @user->seq will be no longer safe from an atomicity point
> of view.
> 
> In preparation for the removal of @logbuf_lock, change it to
> atomic64_t to provide this safety.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index a71e0d41ccb5..20c21a25143d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -865,9 +865,9 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
>  	poll_wait(file, &log_wait, wait);
>  
>  	logbuf_lock_irq();
> -	if (prb_read_valid_info(prb, user->seq, &info, NULL)) {
> +	if (prb_read_valid(prb, atomic64_read(&user->seq), NULL)) {

s/prb_read_valid/prb_read_valid_info/

It is likely a mistake when rebasing on top of the commit
13791c80b0cdf54d ("printk: avoid prb_first_valid_seq() where possible").

>  		/* return error when data has vanished underneath us */
> -		if (info.seq != user->seq)
> +		if (info.seq != atomic64_read(&user->seq))
>  			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
>  		else
>  			ret = EPOLLIN|EPOLLRDNORM;

With the above fix:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
