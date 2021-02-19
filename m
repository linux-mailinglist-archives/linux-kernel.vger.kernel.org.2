Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BB831FE6F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBSR55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:57:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:57084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhBSR5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:57:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613757429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWY8xI+Usm9FV+xcYQhWMtFPe+LVM4soL0lhsTn6/js=;
        b=uGBIvPWMGF04XRRNYBtjJUEXBabwr8fLio76PssWIdQlU7tRTk9Hx04po2xW+eicyjXrpr
        d2P0RNhnYWG7u0g6UPYQm6OH1/yO4KKyrfqYiwgjLeeEcYqHeZ/vlfU0FVJ7/D5XWK3zTA
        VlNpkEQh+a7qStcCuNtBVQCdYazUJ4c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ECBE8ABAE;
        Fri, 19 Feb 2021 17:57:08 +0000 (UTC)
Date:   Fri, 19 Feb 2021 18:57:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: synchronization model: was: Re: [PATCH printk-rework 09/14] printk:
 introduce a kmsg_dump iterator
Message-ID: <YC/79JPVKcVaSEEH@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-10-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:12, John Ogness wrote:
> Rather than store the iterator information into the registered
> kmsg_dump structure, create a separate iterator structure. The
> kmsg_dump_iter structure can reside on the stack of the caller,
> thus allowing lockless use of the kmsg_dump functions.
> 
> This is in preparation for removal of @logbuf_lock.
> 
> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> index 4095a34db0fa..2fdb10ab1799 100644
> --- a/include/linux/kmsg_dump.h
> +++ b/include/linux/kmsg_dump.h
> @@ -29,6 +29,18 @@ enum kmsg_dump_reason {
>  	KMSG_DUMP_MAX
>  };
>  
> +/**
> + * struct kmsg_dumper_iter - iterator for kernel crash message dumper
> + * @active:	Flag that specifies if this is currently dumping
> + * @cur_seq:	Points to the oldest message to dump (private)
> + * @next_seq:	Points after the newest message to dump (private)
> + */
> +struct kmsg_dumper_iter {
> +	bool	active;
> +	u64	cur_seq;
> +	u64	next_seq;
> +};
> +

This is likely beyond the scope of this patchset.

I am still scratching my head about the synchronization if these dumpers.

There is the "active" flag. It has been introduced by the commit
e2ae715d66bf4becfb ("kmsg - kmsg_dump() use iterator to receive log
buffer content"). I do not see any explanation there.

It might prevent some misuse of the API. But the synchronization
model is not much clear:

	+ cur_seq and next_seq might be manipulated by
	  kmsg_dump_rewind() even when the flag is not set.

	+ It is possible to use the same dumper more times in parallel.
	  The API will fill the provided buffer of all callers
	  as long as the active flag is set.

	+ The "active" flag does not synchronize other operations with
	  the provided buffer. The "dump" callback is responsible
	  to provide some synchronization on its own.

In fact, it is not much clear how struct kmsg_dumper_iter, struct kmsg_dumper,
and the used buffers are connected with each other and synchronized.

It might some sense to have the iterator in a separate structure.
But the only safe scenario seems to be when all these three things
(both structures and the buffer) are connected together and
synchronized by the same lock. Also the "active" flag does not look
much helpful and can be removed.

As I said, this is likely beyond this patchset. This patch does more
or less just a refactoring and helps to understand the dependencies.

It is possible that it will be more clear the following week
with a fresh mind.

Best Regards,
Petr
