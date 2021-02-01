Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1D030A974
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhBAOPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:15:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:33360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhBAOPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:15:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612188901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeVl/uzEZKfN6JgWary/epj1tkH9HJSzmu1c+QHyWZM=;
        b=XpnfmTTBFEQMJcse5aLbgofgX0qKhg6Tm1v5Kan32b7Weob53ydJOd0R8Mh7N5IwAWZFvO
        xFaUMCxcgfWDMdt/PgNJi6tscsoz/wGcejRcPZlBl0Nrd/QnuH8zheSCVRyONg/TRQeF9z
        ElDaxgR03BH7z260u7EHxF+v4y0ycXA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D801ABD5;
        Mon,  1 Feb 2021 14:15:01 +0000 (UTC)
Date:   Mon, 1 Feb 2021 15:15:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 09/12] um: synchronize kmsg_dumper
Message-ID: <YBgM5N4ebSr7YsPq@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126211551.26536-10-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-01-26 22:21:48, John Ogness wrote:
> In preparation for removing printk's @logbuf_lock, dumpers that have
> assumed to be protected against parallel calls must provide their own
> synchronization. Add a locally static spinlock to synchronize the
> kmsg_dump call and temporary buffer usage.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  arch/um/kernel/kmsg_dump.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> index f38349ad00ea..173999422ed8 100644
> --- a/arch/um/kernel/kmsg_dump.c
> +++ b/arch/um/kernel/kmsg_dump.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/kmsg_dump.h>
> +#include <linux/spinlock.h>
>  #include <linux/console.h>
>  #include <shared/init.h>
>  #include <shared/kern.h>
> @@ -9,8 +10,10 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>  				enum kmsg_dump_reason reason,
>  				struct kmsg_dumper_iter *iter)
>  {
> +	static DEFINE_SPINLOCK(lock);
>  	static char line[1024];
>  	struct console *con;
> +	unsigned long flags;
>  	size_t len = 0;
>  
>  	/* only dump kmsg when no console is available */
> @@ -25,11 +28,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>  	if (con)
>  		return;
>  
> +	if (!spin_trylock_irqsave(&lock, flags))
> +		return;
> +
>  	printf("kmsg_dump:\n");
>  	while (kmsg_dump_get_line(iter, true, line, sizeof(line), &len)) {
>  		line[len] = '\0';
>  		printf("%s", line);
>  	}
> +
> +	spin_unlock_irqrestore(&lock, flags);

What exactly is synchronized here, please?
Access to @line buffer or @iter or both?

It looks to me that the access to @line buffer was not synchronized
before. kmsg_dump_get_line() used a lock internally but
it was not synchronized with the later printf("%s", line);

The only remaining reason might be the access to @iter. But it is on stack
in kmsg_dump(). Nobody else could have access to it.

IMHO, this patch is not needed.

Do I miss something, please?

Best Regards,
Petr
