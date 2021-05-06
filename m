Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2640437547E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhEFNOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhEFNOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:14:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4988610FA;
        Thu,  6 May 2021 13:13:24 +0000 (UTC)
Date:   Thu, 6 May 2021 09:13:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <bobo.shaobowang@huawei.com>
Subject: Re: [PATCH] printk: stop spining waiter when console resume to
 flush prb
Message-ID: <20210506091323.20ba2464@gandalf.local.home>
In-Reply-To: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 16:00:26 +0800
Luo Jiaxing <luojiaxing@huawei.com> wrote:

> Some threads still call printk() for printing when resume_console() is
> being executed. In practice, the printk() is executed for a period of time
> and then returned. The duration is determined by the number of prints
> cached in the prb during the suspend/resume process. At the same time,
> resume_console() returns quickly.
> 
> Base on owner/waiter machanism, the frist one who fail to lock console will
> become waiter, and start spining. When current owner finish print one
> informance, if a waiter is waitting, owner will give up and let waiter
> become a new owner. New owner need to flush the whole prb unitl prb empty
> or another new waiter come and take the job from him.
> 
> So the first waiter after resume_console() will take seconds to help to
> flush prb, but driver which call printk() may be bothered by this. New
> a flag to mark resume flushing prb. When the console resume, before the
> prb is empty, stop to set a new waiter temporarily.
> 
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
> ---
>  kernel/printk/printk.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 575a34b..2c680a5 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -287,6 +287,9 @@ EXPORT_SYMBOL(console_set_on_cmdline);
>  /* Flag: console code may call schedule() */
>  static int console_may_schedule;
>  
> +/* Flags: console flushing prb when resume */
> +static atomic_t console_resume_flush_prb = ATOMIC_INIT(0);

Why are you using an atomic? It's accessed within locks.

static bool console_resuming;


> +
>  enum con_msg_format_flags {
>  	MSG_FORMAT_DEFAULT	= 0,
>  	MSG_FORMAT_SYSLOG	= (1 << 0),
> @@ -1781,7 +1784,8 @@ static int console_trylock_spinning(void)
>  	raw_spin_lock(&console_owner_lock);
>  	owner = READ_ONCE(console_owner);
>  	waiter = READ_ONCE(console_waiter);

	resuming = READ_ONCE(console_removing);

> -	if (!waiter && owner && owner != current) {

	if (!resuming && (!waiter ...

> +	if (!waiter && owner && owner != current &&
> +	    !atomic_read(&console_resume_flush_prb)) {
>  		WRITE_ONCE(console_waiter, true);
>  		spin = true;
>  	}
> @@ -2355,6 +2359,7 @@ void resume_console(void)
>  	if (!console_suspend_enabled)
>  		return;
>  	down_console_sem();
> +	atomic_set(&console_resume_flush_prb, 1);
>  	console_suspended = 0;

	resuming = true;

>  	console_unlock();

	/* Keep clearing resume from entering the console_unlock */
	smp_wmb();
	resuming = false;


>  }
> @@ -2592,6 +2597,8 @@ void console_unlock(void)
>  	raw_spin_unlock(&logbuf_lock);
>  
>  	up_console_sem();
> +	if (atomic_read(&console_resume_flush_prb))
> +		atomic_set(&console_resume_flush_prb, 0);

Get rid of the above.

-- Steve

>  
>  	/*
>  	 * Someone could have filled up the buffer again, so re-check if there's

