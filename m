Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9133454B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhCJRnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:43:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhCJRnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:43:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6669A60234;
        Wed, 10 Mar 2021 17:43:03 +0000 (UTC)
Date:   Wed, 10 Mar 2021 12:43:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ovidiu Panait <ovidiu.panait@windriver.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@redhat.com, christian@brauner.io
Subject: Re: [PATCH v2] mm, tracing: improve rss_stat tracepoint message
Message-ID: <20210310124301.7b79c21a@gandalf.local.home>
In-Reply-To: <20210310162305.4862-1-ovidiu.panait@windriver.com>
References: <20210310162305.4862-1-ovidiu.panait@windriver.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 18:23:05 +0200
Ovidiu Panait <ovidiu.panait@windriver.com> wrote:

> Adjust the rss_stat tracepoint to print the name of the resident page type
> that got updated (e.g. MM_ANONPAGES/MM_FILEPAGES), rather than the numeric
> index corresponding to it (the __entry->member value):
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
> Use TRACE_DEFINE_ENUM()/__print_symbolic() logic to map the enum values to
> the strings they represent, so that userspace tools can also parse the raw
> data correctly.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

You can change that to:

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

And

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!

-- Steve

> ---
> v2: - rework the patch so that user space tools can parse the raw
>       data correctly
> 
>  include/trace/events/kmem.h | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index 3a60b6b6db32..829a75692cc0 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -343,6 +343,26 @@ static unsigned int __maybe_unused mm_ptr_to_hash(const void *ptr)
>  #define __PTR_TO_HASHVAL
>  #endif
>  
> +#define TRACE_MM_PAGES		\
> +	EM(MM_FILEPAGES)	\
> +	EM(MM_ANONPAGES)	\
> +	EM(MM_SWAPENTS)		\
> +	EMe(MM_SHMEMPAGES)
> +
> +#undef EM
> +#undef EMe
> +
> +#define EM(a)	TRACE_DEFINE_ENUM(a);
> +#define EMe(a)	TRACE_DEFINE_ENUM(a);
> +
> +TRACE_MM_PAGES
> +
> +#undef EM
> +#undef EMe
> +
> +#define EM(a)	{ a, #a },
> +#define EMe(a)	{ a, #a }
> +
>  TRACE_EVENT(rss_stat,
>  
>  	TP_PROTO(struct mm_struct *mm,
> @@ -365,10 +385,10 @@ TRACE_EVENT(rss_stat,
>  		__entry->size = (count << PAGE_SHIFT);
>  	),
>  
> -	TP_printk("mm_id=%u curr=%d member=%d size=%ldB",
> +	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
>  		__entry->mm_id,
>  		__entry->curr,
> -		__entry->member,
> +		__print_symbolic(__entry->member, TRACE_MM_PAGES),
>  		__entry->size)
>  	);
>  #endif /* _TRACE_KMEM_H */

