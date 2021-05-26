Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA239116B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhEZHcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:32:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:43636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232844AbhEZHch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:32:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622014266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DgjVnjQwWuIMJN9gyvKXhozYyF2i1dVc9TYfJdlrbtE=;
        b=h4gWB7lfvFS/Wvp3M3kfScyIXDNlL/5VoJdi0lJxVM+8Iht0rEQHMcSJNAvqIuvCDVk8vZ
        Y9oBahyRtkDVyGyD8xW0wQW3i1epb3E0GxVfgCNPNPQONUIcgbalgLZtqCrCJyPjOEAV09
        cnRzNGhiHzeb+arduQz4kdhpOt/MVts=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5DB1AD54;
        Wed, 26 May 2021 07:31:05 +0000 (UTC)
Date:   Wed, 26 May 2021 09:31:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 2/4] printk: Straighten out log_flags into
 printk_info_flags
Message-ID: <YK35OTteXMoET3SZ@alley>
References: <cover.1621338324.git.chris@chrisdown.name>
 <0b4f0e60960217ac36462316cf43497a9fad1747.1621338324.git.chris@chrisdown.name>
 <YKzSfQIa99Ld2ZMI@alley>
 <87tumr82ri.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tumr82ri.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-05-25 13:35:29, John Ogness wrote:
> On 2021-05-25, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> >> index 73cc80e01cef..71918d47ca95 100644
> >> --- a/kernel/printk/printk_ringbuffer.h
> >> +++ b/kernel/printk/printk_ringbuffer.h
> >> @@ -50,6 +50,12 @@ struct prb_data_blk_lpos {
> >>  	unsigned long	next;
> >>  };
> >>  
> >> +/* Flags for a single printk record. */
> >> +enum printk_info_flags {
> >> +	LOG_NEWLINE	= 2,	/* text ended with a newline */
> >> +	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
> >> +};
> >
> > Nit: Could you please move this after "enum desc_state" declaration?
> 
> Is there a reason that this enum is moved into printk_ringbuffer.h? The
> ringbuffer does not use this enum.

We want to use it in two source files: printk.c and index.c
Alternative solution would be to move it to kernel/printk/internal.h.

Well, will internal.h still be needed after we remove printk_safe?

Anyway, I do not have strong opinion about it.

Best Regards,
Petr
