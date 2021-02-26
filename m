Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0001A32607D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBZJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:50:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:47690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZJt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:49:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614332921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zAo19INku9JV8TASsarW++5xTYgcFe24ZLpcxrWP9U=;
        b=YM6p8dLFCCd9F+U0A6bq7BBctdbAVJ1zygOz3mBktval+EokTL7tAukmhOrqWfmaLIrJ0g
        LFE7rmXww2bR/+RfKPxIzyQn/7RCJTXys+KyaoEcVktzQ4RJZy6YkzYtB50NIA0F0h2RI2
        Mf3Mqgxac2s4/X74yYJOddeP+647QGs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69863AF33;
        Fri, 26 Feb 2021 09:48:41 +0000 (UTC)
Date:   Fri, 26 Feb 2021 10:48:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: synchronization model: was: Re: [PATCH printk-rework 09/14]
 printk: introduce a kmsg_dump iterator
Message-ID: <YDjD+C29unmb/psK@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-10-john.ogness@linutronix.de>
 <YC/79JPVKcVaSEEH@alley>
 <87eeh51wht.fsf@jogness.linutronix.de>
 <YDeZAA08NKCHa4s/@alley>
 <877dmvxm2i.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dmvxm2i.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-02-26 09:36:21, John Ogness wrote:
> On 2021-02-25, Petr Mladek <pmladek@suse.com> wrote:
> > IMHO, a better design would be:
> >
> > 1. dumper->dump() callback should have only one parameter @reason.
> >    The callback should define its own iterator, buffer, and
> >    do the dump.
> 
> Unfortunately this won't work because drivers/mtd/mtdoops.c is using the
> dumper parameter for container_of().

Ah, I have missed this.

mtdoops code is generic even though everything is static so that there
is always only one instance. But this use case makes sense in general.

> So we will need 2 parameters: dumper and reason.
> 
> Can we agree to proceed with 2 parameters in the callback?

Yup, go for it.

> > 2. dumpe->dump() callback should synchronize the entire operation
> >    using its own locks. Only the callback knows whether it is
> >    safe to do more dumps in parallel. Only the callback knows
> >    whether it is called only during panic() when no locks
> >    are needed.
> 
> Agreed. I implemented this part for the v3 series.

Great!

Best Regards,
Petr
