Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C70391397
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhEZJ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:27:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:41040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232218AbhEZJ1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:27:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622021153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GCig8rKx5c4CcthSjGBV15vJEfMn6ttS+WMWDo4MCb4=;
        b=bOrws3DYghwsXR1gGq5urFGw1/hH4bVYnIgQatESuqgnLx5cZR25hfAMCcNqAwB/zpqoO+
        FCyIlXuu8Pou1ZcTwLYO5cf+frl3DhHlJiPZS2HD/DAv2RjdqKXkkBu7buH4qM3oawqBZ2
        y/oPcId+TnTpHcOHOLKmjXip/ppwfCU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21413B1EC;
        Wed, 26 May 2021 09:25:53 +0000 (UTC)
Date:   Wed, 26 May 2021 11:25:52 +0200
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
Message-ID: <YK4UIBgdqr02QoHG@alley>
References: <cover.1621338324.git.chris@chrisdown.name>
 <0b4f0e60960217ac36462316cf43497a9fad1747.1621338324.git.chris@chrisdown.name>
 <YKzSfQIa99Ld2ZMI@alley>
 <87tumr82ri.fsf@jogness.linutronix.de>
 <YK35OTteXMoET3SZ@alley>
 <87v975c2ix.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v975c2ix.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-05-26 10:39:18, John Ogness wrote:
> On 2021-05-26, Petr Mladek <pmladek@suse.com> wrote:
> >> >> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> >> >> index 73cc80e01cef..71918d47ca95 100644
> >> >> --- a/kernel/printk/printk_ringbuffer.h
> >> >> +++ b/kernel/printk/printk_ringbuffer.h
> >> >> @@ -50,6 +50,12 @@ struct prb_data_blk_lpos {
> >> >>  	unsigned long	next;
> >> >>  };
> >> >>  
> >> >> +/* Flags for a single printk record. */
> >> >> +enum printk_info_flags {
> >> >> +	LOG_NEWLINE	= 2,	/* text ended with a newline */
> >> >> +	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
> >> >> +};
> >> >
> >> > Nit: Could you please move this after "enum desc_state" declaration?
> >> 
> >> Is there a reason that this enum is moved into printk_ringbuffer.h? The
> >> ringbuffer does not use this enum.
> >
> > We want to use it in two source files: printk.c and index.c
> > Alternative solution would be to move it to kernel/printk/internal.h.
> >
> > Well, will internal.h still be needed after we remove printk_safe?
> 
> We wouldn't be able to remove internal.h until deferred printing is
> removed. And that cannot happen until after printing kthreads exist. So
> it will still hang around for a while.
> 
> But even so, I do not like the idea of turning printk_ringbuffer.h into
> the new internal.h. The ringbuffer is quite complex and IMHO we should
> try to keep the printk_ringbuffer.* files as isolated as possible.
> 
> I would prefer to put this enum declaration in internal.h. Even if
> eventually it is the only thing left in internal.h.

Fair enough. Chris, please move enum printk_info_flags declaration
into kernel/printk/internal.h

Best Regards,
Petr
