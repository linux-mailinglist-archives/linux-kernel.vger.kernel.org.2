Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D23337CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCKSy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:54:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhCKSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615488789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fZ+OkiReHiMwmMnVJ4gBg5WJotQNpULPKr0L4tI8odM=;
        b=jGjChUTuT19Y5AVl4bfUAcEOVgAzLl7aSyQF/W8Bo1PX+1QUJutks21hPlg7k74/acUZaH
        yvTkI5AlQvU1E8mZp14N8UCm9xk7bnyYug1T7Z/MRUWSrjzBL6WWitc5oNL/UfmpOZBQj2
        e46kO6RSfdOkVyaKKtv1FbhxFpsVRd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-YdhZSmjgMZSkln9fb6UdSg-1; Thu, 11 Mar 2021 13:53:05 -0500
X-MC-Unique: YdhZSmjgMZSkln9fb6UdSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75788801596;
        Thu, 11 Mar 2021 18:53:04 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D17FB5C1C5;
        Thu, 11 Mar 2021 18:53:02 +0000 (UTC)
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>, Jason Baron <jbaron@akamai.com>
References: <20210311183047.805891-1-minchan@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v4] mm: page_alloc: dump migrate-failed pages
Message-ID: <c2bdb4c2-e025-53b2-5c96-6fe413eb242f@redhat.com>
Date:   Thu, 11 Mar 2021 19:53:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311183047.805891-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.21 19:30, Minchan Kim wrote:
> Currently, debugging CMA allocation failures is quite limited.
> The most commong source of these failures seems to be page

s/commong/common/

> migration which doesn't provide any useful information on the
> reason of the failure by itself. alloc_contig_range can report
> those failures as it holds a list of migrate-failed pages.
> 
> page refcount, mapcount with page flags on dump_page are
> helpful information to deduce the culprit. Furthermore,
> dump_page_owner was super helpful to find long term pinner
> who initiated the page allocation.

Maybe simply "The information logged by dump_page() has already proven 
helpful for debugging allocation issues, like identifying long-term 
pinnings on ZONE_MOVABLE or MIGRATE_CMA."

> 
> The reason it approach with dynamic debug is the debug message
> could emit lots of noises as alloc_contig_range calls more
> frequently since it's a best effort allocator.

"Let's use the dynamic debugging infrastructure, such that we avoid
flooding the logs and creating a lot of noise on frequent 
alloc_contig_range() calls. This information is helpful for debugging only."

 >>>

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
> 	echo "func alloc_contig_dump_pages +p" > control
> 
> Admin could disable it.
> 
> 	echo "func alloc_contig_dump_pages =_" > control
> 
> Detail goes Documentation/admin-guide/dynamic-debug-howto.rst

<<< I'd drop that completely and only mention:

"For details on dynamic debugging, see 
Documentation/admin-guide/dynamic-debug-howto.rst."

As you have usage in the code itself, I think you don't have to be 
repetitive. The ifdeffery seems to be common (e.g., 
include/linux/netdevice.) for dynamic debugging users, so I don't see 
the need to describe that in detail.

 >>>

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

<<< I'd drop that completely and mention

"In the future, we might want to make the loglevels used inside 
dump_page() consistent and eventually rework the way we log the 
information here. See [1]"

Where [1] is a link to the discussion.

> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> * from v3 - https://lore.kernel.org/linux-mm/20210310180104.517886-1-minchan@kernel.org
>    * add dyndgb usage comment - akpm
>    * use dumpstack instead of warn_on - david
> 
> * from v2 - https://lore.kernel.org/linux-mm/20210308202047.1903802-1-minchan@kernel.org/
>    * remove ratelimit - mhocko
> 
> * from v1 - https://lore.kernel.org/linux-mm/20210217163603.429062-1-minchan@kernel.org/
>    * use dynamic debugging with system wide instead of per-call site - mhocko
> 
>   mm/page_alloc.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 

Minor nits:

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee2b1e..76fc202cb105 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8453,6 +8453,36 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
>   				pageblock_nr_pages));
>   }
>   
> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> +/*
> + * usage)

"usage)" looks wrong here. Did you mean "Usage:"

> + * 	dyndbg_dir="/sys/kernel/debug/dynamic_debug"
> + * To enable:
> + * 	echo "func alloc_contig_dump_pages +p" > $dyndbg_dir/control
> + * To disable:
> + * 	echo "func alloc_contig_dump_pages =_" > $dyndbg_dir/control
> + * For detail, read dynamic-debug-howto.rst

Maybe simply

"See admin-guide/dynamic-debug-howto.rst"

> + */
> +static void alloc_contig_dump_pages(struct list_head *page_list)
> +{
> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> +			"migrate failure");

You can fit that into a single line.

> +
> +	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
> +		struct page *page;
> +
> +		dump_stack();
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
> @@ -8496,6 +8526,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
>   	}
>   	if (ret < 0) {
> +		alloc_contig_dump_pages(&cc->migratepages);
>   		putback_movable_pages(&cc->migratepages);
>   		return ret;
>   	}
> 

As I said, for my taste good enough for now. I would certainly preferred 
what Michal suggested (e.g., doing it via debug loglevels), but this 
gets the job done and is not too ugly.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

