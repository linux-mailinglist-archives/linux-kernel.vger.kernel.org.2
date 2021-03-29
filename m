Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DF134CCF7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhC2JYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231751AbhC2JXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617009828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNdWxHwtlPTSLgjKBuoZy8VuUpSPf2A9bGzW9m7EMqs=;
        b=B678AYHXDNIsV+qvSc6kD6mzLvkel2O++FltgGBLhQX31mIqli/NwwKA/9ZgjsV5pf3QYD
        hg7eBnODMcCB8bQMY0zlwYNTS3IzRTTjm9XZAz8LK8bxpcn3Ay7Lh6iZYvZUhJEeELMs4g
        QAsQSsSxYqXAWKhmJ/O996ultG1JUjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-3--sNhDeOqyirpC_2KIBtw-1; Mon, 29 Mar 2021 05:23:27 -0400
X-MC-Unique: 3--sNhDeOqyirpC_2KIBtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90B12801814;
        Mon, 29 Mar 2021 09:23:25 +0000 (UTC)
Received: from [10.36.114.205] (ovpn-114-205.ams2.redhat.com [10.36.114.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2738F5D9F0;
        Mon, 29 Mar 2021 09:23:23 +0000 (UTC)
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210327180348.137d8fe2@sf>
 <20210327182144.3213887-1-slyfox@gentoo.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v2] mm: page_alloc: ignore init_on_free=1 for
 debug_pagealloc=1
Message-ID: <e681dbc0-70b9-2185-28bf-012852f39102@redhat.com>
Date:   Mon, 29 Mar 2021 11:23:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210327182144.3213887-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.21 19:21, Sergei Trofimovich wrote:
> On !ARCH_SUPPORTS_DEBUG_PAGEALLOC (like ia64) debug_pagealloc=1
> implies page_poison=on:
> 
>      if (page_poisoning_enabled() ||
>           (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
>            debug_pagealloc_enabled()))
>              static_branch_enable(&_page_poisoning_enabled);
> 
> page_poison=on needs to init_on_free=1.
> 
> Before the change id happened too late for the following case:
> - have PAGE_POISONING=y
> - have page_poison unset
> - have !ARCH_SUPPORTS_DEBUG_PAGEALLOC arch (like ia64)
> - have init_on_free=1
> - have debug_pagealloc=1
> 
> That way we get both keys enabled:
> - static_branch_enable(&init_on_free);
> - static_branch_enable(&_page_poisoning_enabled);
> 
> which leads to poisoned pages returned for __GFP_ZERO pages.
> 
> After the change we execute only:
> - static_branch_enable(&_page_poisoning_enabled);
> and ignore init_on_free=1.
> 
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-mm@kvack.org
> CC: David Hildenbrand <david@redhat.com>
> CC: Andrey Konovalov <andreyknvl@gmail.com>
> Link: https://lkml.org/lkml/2021/3/26/443

Again, Fixes: tag? IOW, which commit initially broke it.

> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>   mm/page_alloc.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d57d9b4f7089..10a8a1d28c11 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -764,32 +764,36 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>    */
>   void init_mem_debugging_and_hardening(void)
>   {
> +	bool page_poison_requested = page_poisoning_enabled();

s/page_poison_requested/page_poisoning_requested/

And I wonder if you should just initialize to "false" here.

Without CONFIG_PAGE_POISONING, page_poisoning_enabled() will always 
return false, so it seems unnecessary.

> +
> +#ifdef CONFIG_PAGE_POISONING
> +	/*
> +	 * Page poisoning is debug page alloc for some arches. If
> +	 * either of those options are enabled, enable poisoning.
> +	 */
> +	if (page_poisoning_enabled() ||
> +	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
> +	      debug_pagealloc_enabled())) {
> +		static_branch_enable(&_page_poisoning_enabled);
> +		page_poison_requested = true;
> +	}
> +#endif

Apart from that, looks good.


-- 
Thanks,

David / dhildenb

