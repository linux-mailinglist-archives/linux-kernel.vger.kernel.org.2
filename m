Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF7638FF53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhEYKgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:36:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:46490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232213AbhEYKfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:35:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621938813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jaenNB/41FI7l1H6eXnKw5fm7YclHhGbzv0v463POLI=;
        b=kkDe7Sfv7/6so47rMx6o10QPDvBPQpt5UYFPWct54RvNJ//CLu0jlzsb1sEI+mNWJJudow
        e29tg81xRFRrJpnc0kaXT/VsQ/6gzgIGcOY1b9Tt1YJN0Gy8MQlwgFCZ0Nr/9Ew3T9vVOT
        C7SH2gxt39xJOVEcO26p7s0BFqQWNdY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81314AF09;
        Tue, 25 May 2021 10:33:33 +0000 (UTC)
Date:   Tue, 25 May 2021 12:33:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 2/4] printk: Straighten out log_flags into
 printk_info_flags
Message-ID: <YKzSfQIa99Ld2ZMI@alley>
References: <cover.1621338324.git.chris@chrisdown.name>
 <0b4f0e60960217ac36462316cf43497a9fad1747.1621338324.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b4f0e60960217ac36462316cf43497a9fad1747.1621338324.git.chris@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-05-18 13:00:38, Chris Down wrote:
> In the past, `enum log_flags` was part of `struct log`, hence the name.
> `struct log` has since been reworked and now this struct is stored
> inside `struct printk_info`. However, the name was never updated, which
> is somewhat confusing -- especially since these flags operate at the
> record level rather than at the level of an abstract log.
> 
> printk_info_flags also joins its other metadata struct friends in
> printk_ringbuffer.h.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Petr Mladek <pmladek@suse.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Just one nit below.

> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> index 73cc80e01cef..71918d47ca95 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -50,6 +50,12 @@ struct prb_data_blk_lpos {
>  	unsigned long	next;
>  };
>  
> +/* Flags for a single printk record. */
> +enum printk_info_flags {
> +	LOG_NEWLINE	= 2,	/* text ended with a newline */
> +	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
> +};

Nit: Could you please move this after "enum desc_state" declaration?

>  /*
>   * A descriptor: the complete meta-data for a record.
>   *
> -- 
> 2.31.1

Best Regards,
Petr
