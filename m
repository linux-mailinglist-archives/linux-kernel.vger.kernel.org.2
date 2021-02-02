Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6A30BD15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhBBLaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:30:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:60174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhBBLXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:23:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612264952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uGxQsE8wyi/CotaCgKvwenbR9cscfI3Pt0Bv8Boe8Ds=;
        b=aPxR2b02bVqSJXq1QnYNdumubJghvz7UewCdNBwwi0hJqJ0bqMPMljuqNNAa4a9Xo6X5D/
        NqGm6UnkUpZFM7LpwC7P3kZnbQloREiGBcFF/B4dm+SK1PSzeUjHuaNtAWXYfnkdwnL1J/
        OyZIFGbzuF6R4gFMQtdzDRfuhAyQSGY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D71B3B18C;
        Tue,  2 Feb 2021 11:22:31 +0000 (UTC)
Date:   Tue, 2 Feb 2021 12:22:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: LINE_MAX: was: Re: [PATCH printk-rework 04/12] printk: define
 CONSOLE_LOG_MAX in printk.h
Message-ID: <YBk198XKRWYMcABr@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-5-john.ogness@linutronix.de>
 <YBQtbKrdwUAZQB9v@alley>
 <87r1m02o2d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1m02o2d.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-02-01 09:30:10, John Ogness wrote:
> On 2021-01-29, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/include/linux/printk.h b/include/linux/printk.h
> >> index fe7eb2351610..6d8f844bfdff 100644
> >> --- a/include/linux/printk.h
> >> +++ b/include/linux/printk.h
> >> @@ -45,6 +45,7 @@ static inline const char *printk_skip_headers(const char *buffer)
> >>  }
> >>  
> >>  #define CONSOLE_EXT_LOG_MAX	8192
> >> +#define CONSOLE_LOG_MAX		1024
> >>  
> >>  /* printk's without a loglevel use this.. */
> >>  #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index ec2174882b8e..5faf9c0db171 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -410,7 +410,7 @@ static u64 clear_seq;
> >>  #else
> >>  #define PREFIX_MAX		32
> >>  #endif
> >> -#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
> >> +#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
> >
> > CONSOLE_LOG_MAX defines size of buffers that are written by
> > record_print_text(). We must make sure that all stored
> > messages can actually get printed even with the trailing '\0'.
> >
> > We should limit the stored messages by:
> >
> > /*
> >  * Console log buffer needs extra space for the trailing '\0',
> >  * see reccord_print_text().
> >  */
> > #define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX - 1)
> >
> > It should not be a big problem. The PREFIX_MAX size has already
> > increased in the patch, for example, because of the caller ID.
> >
> > Does it make sense, please?
> 
> If we want to make sure "all stored messages can actually get printed",
> then CONSOLE_LOG_MAX needs to be set to:
> 
>    PREFIX_MAX * LOG_LINE_MAX + 1
> 
> and we should be specifying LOG_LINE_MAX instead of
> CONSOLE_LOG_MAX. record_print_text() adds up to PREFIX_MAX for every
> '\n' in the message.

Good point!

> I was initially confused by this, which led to my patch [0] to fix
> it. But then I realized that the buffer is way too small anyway. If we
> want to fix the issue, then LOG_LINE_MAX needs to be much larger.
> 
> IMO it makes no sense to do the -1 change because the buffer is too
> small anyway.

Multiple newlines might be soled by printing each line separately.
But we clearly do not have these issues in practice. I agree that
it does not make sense to play games with -1 here.

Best Regards,
Petr
