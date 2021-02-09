Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82C314DD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhBILFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:05:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231803AbhBIK7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612868258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pl+kXJcGHVLhboOXu04p8JkvHESDiRMekBqRBDF4Hj0=;
        b=ASZxT5LIjdB9XaqAAtffvm0ruRn9HzVg87nnFpNvH+Etw2add9fOx4H51rdYqay1G7sK4d
        NWVhMcMhPdBZLBvjQxM4wmgRmzmN+Yr6otYVe58lBjmpqLypeAsU4oh25EiBWjwkBNQUka
        aZJ3p7raLZSdVKaKbRNASELj+sN9oTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-LaxsbjAxMWOM0CccHl9eGw-1; Tue, 09 Feb 2021 05:57:34 -0500
X-MC-Unique: LaxsbjAxMWOM0CccHl9eGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FD6D801977;
        Tue,  9 Feb 2021 10:57:32 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEFA217AE2;
        Tue,  9 Feb 2021 10:57:28 +0000 (UTC)
Subject: Re: [PATCH v4 2/3] mm, slub: don't combine pr_err with INFO
To:     Yafang Shao <laoar.shao@gmail.com>, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, linmiaohe@huawei.com,
        vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210209105613.42747-1-laoar.shao@gmail.com>
 <20210209105613.42747-3-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a7a7c37b-5bda-25d2-5bcf-cea17b78a03f@redhat.com>
Date:   Tue, 9 Feb 2021 11:57:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210209105613.42747-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 11:56, Yafang Shao wrote:
> It is strange to combine "pr_err" with "INFO", so let's remove the
> prefix completely.
> This patch is motivated by David's comment[1].
> 
> - before the patch
> [ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)
> 
> - after the patch
> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> 
> [1]. https://lore.kernel.org/linux-mm/b9c0f2b6-e9b0-0c36-ebdd-2bc684c5a762@redhat.com/#t
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>   mm/slub.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 87ff086e68a4..2514c37ab4e4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -612,7 +612,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
>   	if (!t->addr)
>   		return;
>   
> -	pr_err("INFO: %s in %pS age=%lu cpu=%u pid=%d\n",
> +	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
>   	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
>   #ifdef CONFIG_STACKTRACE
>   	{
> @@ -638,7 +638,7 @@ void print_tracking(struct kmem_cache *s, void *object)
>   
>   static void print_page_info(struct page *page)
>   {
> -	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
> +	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
>   	       page, page->objects, page->inuse, page->freelist,
>   	       page->flags, &page->flags);
>   
> @@ -695,7 +695,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
>   
>   	print_page_info(page);
>   
> -	pr_err("INFO: Object 0x%p @offset=%tu fp=0x%p\n\n",
> +	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
>   	       p, p - addr, get_freepointer(s, p));
>   
>   	if (s->flags & SLAB_RED_ZONE)
> @@ -788,7 +788,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
>   		end--;
>   
>   	slab_bug(s, "%s overwritten", what);
> -	pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> +	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
>   					fault, end - 1, fault - addr,
>   					fault[0], value);
>   	print_trailer(s, page, object);
> @@ -3854,7 +3854,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
>   	for_each_object(p, s, addr, page->objects) {
>   
>   		if (!test_bit(__obj_to_index(s, addr, p), map)) {
> -			pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
> +			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
>   			print_tracking(s, p);
>   		}
>   	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

