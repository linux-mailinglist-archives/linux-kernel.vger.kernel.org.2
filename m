Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3D30BF56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhBBN05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:26:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:34252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhBBN0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:26:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612272367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UoTc8bOW9a73YYpJw8OzZ66a6bNPlPn/jdMLo9zjDg=;
        b=YGJauBWO8UBxLjDoL61JsDvobUm18oKNkFq2qK6MuEI7cAZilY607byVPOkhD6IQGqnzke
        ZZzlh+OaqfvRktTV+jbpn+Qhv0u46spOZJS1mk0IPfSVm8gr+Ay/pld/I6GIK2lPzVaa/7
        Tsd8HZqIQaSzdkJFRbD0mM6nUrRC63o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 876D7AF9A;
        Tue,  2 Feb 2021 13:26:07 +0000 (UTC)
Date:   Tue, 2 Feb 2021 14:26:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH printk-rework 09/12] um: synchronize kmsg_dumper
Message-ID: <YBlS7nYgck0TWdpY@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-10-john.ogness@linutronix.de>
 <YBgM5N4ebSr7YsPq@alley>
 <875z3bk9z1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z3bk9z1.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-02-01 17:57:14, John Ogness wrote:
> (Added CC: Thomas Meyer, Richard Weinberger)
> 
> On 2021-02-01, Petr Mladek <pmladek@suse.com> wrote:
> >> In preparation for removing printk's @logbuf_lock, dumpers that have
> >> assumed to be protected against parallel calls must provide their own
> >> synchronization. Add a locally static spinlock to synchronize the
> >> kmsg_dump call and temporary buffer usage.
> >> 
> >> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> >> ---
> >>  arch/um/kernel/kmsg_dump.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >> 
> >> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> >> index f38349ad00ea..173999422ed8 100644
> >> --- a/arch/um/kernel/kmsg_dump.c
> >> +++ b/arch/um/kernel/kmsg_dump.c
> >> @@ -1,5 +1,6 @@
> >>  // SPDX-License-Identifier: GPL-2.0
> >>  #include <linux/kmsg_dump.h>
> >> +#include <linux/spinlock.h>
> >>  #include <linux/console.h>
> >>  #include <shared/init.h>
> >>  #include <shared/kern.h>
> >> @@ -9,8 +10,10 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >>  				enum kmsg_dump_reason reason,
> >>  				struct kmsg_dumper_iter *iter)
> >>  {
> >> +	static DEFINE_SPINLOCK(lock);
> >>  	static char line[1024];
> >>  	struct console *con;
> >> +	unsigned long flags;
> >>  	size_t len = 0;
> >>  
> >>  	/* only dump kmsg when no console is available */
> >> @@ -25,11 +28,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >>  	if (con)
> >>  		return;
> >>  
> >> +	if (!spin_trylock_irqsave(&lock, flags))
> >> +		return;
> >> +
> >>  	printf("kmsg_dump:\n");
> >>  	while (kmsg_dump_get_line(iter, true, line, sizeof(line), &len)) {
> >>  		line[len] = '\0';
> >>  		printf("%s", line);
> >>  	}
> >> +
> >> +	spin_unlock_irqrestore(&lock, flags);
> >
> > What exactly is synchronized here, please?
> > Access to @line buffer or @iter or both?
> 
> @line is being synchronized. @iter does not require synchronization.
> 
> > It looks to me that the access to @line buffer was not synchronized
> > before. kmsg_dump_get_line() used a lock internally but
> > it was not synchronized with the later printf("%s", line);
> 
> The line was previously synchronized for the kmsg_dump_get_line()
> call. But yes, it was not synchronized after the call, which is a bug if
> the dump is triggered on multiple CPUs simultaneously. The commit
> message should also mention that it is handling that bug.

Yes, please update the commit message.

In fact, I think that mentioning logbuf_lock might is a bit
misleading. This patch fixes an old bug. It was found when
auditing code that is using the kmsg_dump_get_line() and
might be affected the logbuf_lock removal.

Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Finally thanks Richard for the input about SMP on UM arch.

Best Regards,
Petr
