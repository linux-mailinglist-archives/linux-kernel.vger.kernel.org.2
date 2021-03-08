Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF9D331779
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCHTlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:41:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231154AbhCHTld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:41:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685B965287;
        Mon,  8 Mar 2021 19:41:32 +0000 (UTC)
Date:   Mon, 8 Mar 2021 14:41:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ovidiu Panait <ovidiu.panait@windriver.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@redhat.com, christian@brauner.io
Subject: Re: [PATCH] mm, tracing: improve rss_stat tracepoint message
Message-ID: <20210308144131.7b7df9cd@gandalf.local.home>
In-Reply-To: <20210308185000.14052-1-ovidiu.panait@windriver.com>
References: <20210308185000.14052-1-ovidiu.panait@windriver.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Mar 2021 20:50:00 +0200
Ovidiu Panait <ovidiu.panait@windriver.com> wrote:

> Adjust the rss_stat tracepoint to print the name of the resident page type
> that got updated(e.g. MM_ANONPAGES/MM_FILEPAGES), rather than the numeric
> index corresponding to it(the __entry->member value):
> 
> Before this patch:
> ------------------
> rss_stat: mm_id=1216113068 curr=0 member=1 size=28672B
> rss_stat: mm_id=1216113068 curr=0 member=1 size=0B
> rss_stat: mm_id=534402304 curr=1 member=0 size=188416B
> rss_stat: mm_id=534402304 curr=1 member=1 size=40960B
> 
> After this patch:
> -----------------
> rss_stat: mm_id=1726253524 curr=1 type=MM_ANONPAGES size=40960B
> rss_stat: mm_id=1726253524 curr=1 type=MM_FILEPAGES size=663552B
> rss_stat: mm_id=1726253524 curr=1 type=MM_ANONPAGES size=65536B
> rss_stat: mm_id=1726253524 curr=1 type=MM_FILEPAGES size=647168B
> 
> Also, make the resident_page_types[] array in kernel/fork.c non-static so
> that it can be reused from tracing code.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
> ---
>  include/linux/mm.h          | 2 ++
>  include/trace/events/kmem.h | 5 +++--
>  kernel/fork.c               | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 89fca443e6f1..7916112d5952 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3141,5 +3141,7 @@ void mem_dump_obj(void *object);
>  static inline void mem_dump_obj(void *object) {}
>  #endif
>  
> +extern const char * const resident_page_types[];
> +
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_MM_H */
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index 3a60b6b6db32..623506917cd0 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -5,6 +5,7 @@
>  #if !defined(_TRACE_KMEM_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_KMEM_H
>  
> +#include <linux/mm.h>
>  #include <linux/types.h>
>  #include <linux/tracepoint.h>
>  #include <trace/events/mmflags.h>
> @@ -365,10 +366,10 @@ TRACE_EVENT(rss_stat,
>  		__entry->size = (count << PAGE_SHIFT);
>  	),
>  
> -	TP_printk("mm_id=%u curr=%d member=%d size=%ldB",
> +	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
>  		__entry->mm_id,
>  		__entry->curr,
> -		__entry->member,
> +		resident_page_types[__entry->member],

This will be useless for user space tools that parse the raw data.

The correct way is to have before this:

#define TRACE_MM_PAGES		\
	EM(MM_FILEPAGES)	\
	EM(MM_ANONPAGES)	\
	EM(MM_SWAPENTS)		\	
	EMe(MM_SHMEMPAGES)

#undef EM
#undef EMe

#define EM(a)	TRACE_DEFINE_ENUM(a);
#define EMe(a)	TRACE_DEFINE_ENUM(a);

TRACE_MM_PAGES

#undef EM
#undef EMe

#define EM(a)	{ a, #a },
#define EMe(a)	{ a, #a }


Then you can have:

	TP_printk("mm_id=%u curr=%d type=%s size=%1dB",
		__entry->mm_id,
		__entry->curr,
		__print_symbolic(__entry->member,
			TRACE_MM_PAGES),
>  		__entry->size)
>  	);
>  #endif /* _TRACE_KMEM_H */


And then this will work fine for user space as well.

Other events have done this, for example, see
include/trace/events/writeback.h

-- Steve

> diff --git a/kernel/fork.c b/kernel/fork.c
> index d3171e8e88e5..b30fe8ca56b3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -128,7 +128,7 @@ static int max_threads;		/* tunable limit on nr_threads */
>  
>  #define NAMED_ARRAY_INDEX(x)	[x] = __stringify(x)
>  
> -static const char * const resident_page_types[] = {
> +const char * const resident_page_types[] = {
>  	NAMED_ARRAY_INDEX(MM_FILEPAGES),
>  	NAMED_ARRAY_INDEX(MM_ANONPAGES),
>  	NAMED_ARRAY_INDEX(MM_SWAPENTS),

