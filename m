Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A6034821A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbhCXTlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhCXTkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:40:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9AEC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:40:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l3so18161449pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+yeH7O+SKmNDPP8TaHxytA3G6HzMFIl42cJgSOThu2I=;
        b=JGo/mcB0YjtnR+1GHNKVXI4+AHEvSmgx9OJfb33Luzzg9+3aeFAtBJUnWv5ZEJA2bU
         m+X2Z6tsiQ/vUUTpmstfSR/G0sURbnhrFMuGEcYq+NOfTVNuzQzO3XtvkZJqfN2UifDc
         cyKGgD8bt4VZQdK5qieDyLa4r/1OB/PNRwRaEOC1XwATI066WMl/K40+hWZg8nOw+RGB
         ZTbU5t2ccI/7e+zk+xUx76fNcFfpMfzV+BbgnGzizOkcq8ELSJPMVGemRvZDsoOGKe72
         UFJuNzZvF3C1nUj+b/sU1EusgmrCiY8BvPZE8aY9i+XhKgcmyuOD7UuQsdHWRJ6FFkpA
         2E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+yeH7O+SKmNDPP8TaHxytA3G6HzMFIl42cJgSOThu2I=;
        b=rj1gjdSoID0/AqVCz8V3WrVtxWYySSGeCkp5VUzFV+1mvXz26EpuZjJAhfxWoaSLsa
         MZqSj2Buh1DCDgjUPGdqeBqbEf6aI8vdCg1hFa52ibHN8lrm53jElTqhqtX5TJvNMpCA
         WfcTLlQMDBxwgRy1oAkKdWkhGfd8UiVfr2slIyS+zTEFLtL5m97MCrNWnu6nKgPTi7GY
         CQNAGJ1XMn2yS14nfa4GZePrazNjy0SiWUSN8KW0y70rbUypyhBNQw/aH4avcKwHXmAG
         DK6tgLGaspDzX3Deucu5MvYs1/sfPW4eRBqGtrzvAw8rHkyLiE7pKnWXACjFiROsmapG
         U8wg==
X-Gm-Message-State: AOAM531g5g5SiZS54vnxUXT2xHyNUKGb1Ie2EJ7Y4kQ0GHvbyiE7+8RW
        4ZjmVCqWjB875jad7GnJH8k=
X-Google-Smtp-Source: ABdhPJwWh1njqQv18gD4oaqp7GkE5xybIFL6i/QKhoBhPPVRekGPEeI/W0C6j5PpfBchLdHrsvVMhA==
X-Received: by 2002:a17:902:c317:b029:e4:aecd:8539 with SMTP id k23-20020a170902c317b02900e4aecd8539mr5184277plx.61.1616614840185;
        Wed, 24 Mar 2021 12:40:40 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id h2sm3085493pfq.139.2021.03.24.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:40:38 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 24 Mar 2021 12:40:36 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     rostedt@goodmis.org, akpm@linux-foundation.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Liam Mark <lmark@codeaurora.org>
Subject: Re: [PATCH] mm: cma: add trace events for CMA alloc perf testing
Message-ID: <YFuVtDn+FdJuCpVE@google.com>
References: <20210324160740.15901-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324160740.15901-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 06:07:40PM +0200, Georgi Djakov wrote:
> From: Liam Mark <lmark@codeaurora.org>
> 
> Add cma and migrate trace events to enable CMA allocation
> performance to be measured via ftrace.
> 
> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  include/trace/events/cma.h     | 39 +++++++++++++++++++++++++++++++++-
>  include/trace/events/migrate.h | 22 +++++++++++++++++++
>  mm/cma.c                       |  4 ++++
>  mm/migrate.c                   |  2 ++
>  4 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
> index 5017a8829270..cdfd06afb39a 100644
> --- a/include/trace/events/cma.h
> +++ b/include/trace/events/cma.h
> @@ -8,7 +8,7 @@
>  #include <linux/types.h>
>  #include <linux/tracepoint.h>
>  
> -TRACE_EVENT(cma_alloc,
> +DECLARE_EVENT_CLASS(cma_alloc_class,
>  
>  	TP_PROTO(unsigned long pfn, const struct page *page,
>  		 unsigned int count, unsigned int align),
> @@ -61,6 +61,43 @@ TRACE_EVENT(cma_release,
>  		  __entry->count)
>  );
>  
> +TRACE_EVENT(cma_alloc_start,
> +
> +	TP_PROTO(unsigned int count, unsigned int align),
> +
> +	TP_ARGS(count, align),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, count)
> +		__field(unsigned int, align)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->count = count;
> +		__entry->align = align;
> +	),
> +
> +	TP_printk("count=%u align=%u",
> +		  __entry->count,
> +		  __entry->align)
> +);
> +
> +DEFINE_EVENT(cma_alloc_class, cma_alloc,
> +
> +	TP_PROTO(unsigned long pfn, const struct page *page,
> +		 unsigned int count, unsigned int align),
> +
> +	TP_ARGS(pfn, page, count, align)
> +);
> +
> +DEFINE_EVENT(cma_alloc_class, cma_alloc_busy_retry,
> +
> +	TP_PROTO(unsigned long pfn, const struct page *page,
> +		 unsigned int count, unsigned int align),
> +
> +	TP_ARGS(pfn, page, count, align)
> +);
> +
>  #endif /* _TRACE_CMA_H */
>  
>  /* This part must be outside protection */
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 363b54ce104c..9fb2a3bbcdfb 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -82,6 +82,28 @@ TRACE_EVENT(mm_migrate_pages,
>  		__print_symbolic(__entry->mode, MIGRATE_MODE),
>  		__print_symbolic(__entry->reason, MIGRATE_REASON))
>  );
> +
> +TRACE_EVENT(mm_migrate_pages_start,
> +
> +	TP_PROTO(enum migrate_mode mode, int reason),
> +
> +	TP_ARGS(mode, reason),
> +
> +	TP_STRUCT__entry(
> +		__field(enum migrate_mode, mode)
> +		__field(int, reason)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->mode	= mode;
> +		__entry->reason	= reason;
> +	),
> +
> +	TP_printk("mode=%s reason=%s",
> +		  __print_symbolic(__entry->mode, MIGRATE_MODE),
> +		  __print_symbolic(__entry->reason, MIGRATE_REASON))
> +);
> +
>  #endif /* _TRACE_MIGRATE_H */
>  
>  /* This part must be outside protection */
> diff --git a/mm/cma.c b/mm/cma.c
> index 90e27458ddb7..984c85fd16ec 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -443,6 +443,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  	if (!count)
>  		goto out;
>  
> +	trace_cma_alloc_start(count, align);

Can we add cma->name here to identify what cma instance would be?

> +
>  	mask = cma_bitmap_aligned_mask(cma, align);
>  	offset = cma_bitmap_aligned_offset(cma, align);
>  	bitmap_maxno = cma_bitmap_maxno(cma);
> @@ -483,6 +485,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  
>  		pr_debug("%s(): memory range at %p is busy, retrying\n",
>  			 __func__, pfn_to_page(pfn));
> +
> +		trace_cma_alloc_busy_retry(pfn, pfn_to_page(pfn), count, align);
>  		/* try again with a bit different memory target */
>  		start = bitmap_no + mask + 1;
>  	}
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 47df0df8f21a..58b1b03e0c98 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1445,6 +1445,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	int rc, nr_subpages;
>  	LIST_HEAD(ret_pages);
>  
> +	trace_mm_migrate_pages_start(mode, reason);
> +
>  	if (!swapwrite)
>  		current->flags |= PF_SWAPWRITE;
>  
> 
