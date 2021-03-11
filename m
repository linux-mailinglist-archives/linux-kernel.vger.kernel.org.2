Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1303379AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCKQlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:41:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhCKQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615480873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GkBT2/QcrP06DnXp9UhFQvFFWxYG4lqLjwld1F9Zqa0=;
        b=RB/44mUogC9h3oib6tmQWbF+QHqSyV9+yQm821zyiJj7Qv2qxkoLAXW/aiDP2XJTwL4KmC
        4eBbqQ4HNzdm8uz/KLwelzvOSeyEc4ibSlO61pitA3X/8KVrLU2Y5zAx6NuSOxVGzGTn34
        rO4gE6fVGU764BrXkUI5DRC7+f+IqTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-xJ9ALbmLNk2YfcormWPl-A-1; Thu, 11 Mar 2021 11:41:09 -0500
X-MC-Unique: xJ9ALbmLNk2YfcormWPl-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ABD88EC1A8;
        Thu, 11 Mar 2021 16:40:37 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0B3C60BE5;
        Thu, 11 Mar 2021 16:40:35 +0000 (UTC)
Subject: Re: [PATCH v3] mm: page_alloc: dump migrate-failed pages
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>, Jason Baron <jbaron@akamai.com>
References: <20210310180104.517886-1-minchan@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <cdca0d9b-0c7e-bafc-6d86-bc75654b16ae@redhat.com>
Date:   Thu, 11 Mar 2021 17:40:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310180104.517886-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.21 19:01, Minchan Kim wrote:
> Currently, debugging CMA allocation failures is quite limited.
> The most commong source of these failures seems to be page
> migration which doesn't provide any useful information on the
> reason of the failure by itself. alloc_contig_range can report
> those failures as it holds a list of migrate-failed pages.
> 
> page refcount, mapcount with page flags on dump_page are
> helpful information to deduce the culprit. Furthermore,
> dump_page_owner was super helpful to find long term pinner
> who initiated the page allocation.
> 
> The reason it approach with dynamic debug is the debug message
> could emit lots of noises as alloc_contig_range calls more
> frequently since it's a best effort allocator.
> 
> There are two ifdefery conditions to support common dyndbg options:
> 
> - CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE
> It aims for supporting the feature with only specific file
> with adding ccflags.
> 
> - CONFIG_DYNAMIC_DEBUG
> It aims for supporting the feature with system wide globally.
> 
> A simple example to enable the feature:
> 
> Admin could enable the dump like this(by default, disabled)
> 
> 	echo "func dump_migrate_failure_pages +p" > control
> 
> Admin could disable it.
> 
> 	echo "func dump_migrate_failure_pages =_" > control
> 
> Detail goes Documentation/admin-guide/dynamic-debug-howto.rst
> 
> A concern is utility functions in dump_page uses inconsistent
> loglevels.
> 
> __dump_page: KERN_WARNING
> __dump_page_owner: KERN_ALERT
>          stack_trace_print: KERN_DEFAULT
> 
> There are bunch of places to use the inconsistent loglevel
> utility functions(e.g., just grep dump_page/strace_trace_print).
> It's unfortunate but here we are. It could be addressed
> different patchset.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> * from v2 - https://lore.kernel.org/linux-mm/20210308202047.1903802-1-minchan@kernel.org/
>    * remove ratelimit - mhocko
> 
> * from v1 - https://lore.kernel.org/linux-mm/20210217163603.429062-1-minchan@kernel.org/
>    * use dynamic debugging with system wide instead of per-call site - mhocko
> 
>   mm/page_alloc.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee2b1e..f42f3e208794 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8453,6 +8453,27 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
>   				pageblock_nr_pages));
>   }
>   
> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> +static void alloc_contig_dump_pages(struct list_head *page_list)
> +{
> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> +			"migrate failure");
> +
> +	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
> +		struct page *page;
> +
> +		WARN(1, "failed callstack");

Not sure if we want that here. You can deterministically crash a kernel 
with panic_on_warn set - which is what some distros already do.

Some other way to dump the current call stack would be handy ...

> +		list_for_each_entry(page, page_list, lru)
> +			dump_page(page, "migration failure");
> +	}
> +}
> +#else
> +static inline void alloc_contig_dump_pages(struct list_head *page_list)
> +{
> +}
> +#endif
> +
>   /* [start, end) must belong to a single zone. */
>   static int __alloc_contig_migrate_range(struct compact_control *cc,
>   					unsigned long start, unsigned long end)
> @@ -8496,6 +8517,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
>   	}
>   	if (ret < 0) {
> +		alloc_contig_dump_pages(&cc->migratepages);
>   		putback_movable_pages(&cc->migratepages);
>   		return ret;
>   	}
> 

For me, this is good enough for now.

-- 
Thanks,

David / dhildenb

