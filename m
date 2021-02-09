Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E15314DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhBILFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:05:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232035AbhBIK6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612868249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kK2ClUw3Cdk/dZ7XyshGuNhYtTCXK+mZDDdWQTvzzq4=;
        b=JiXA7FJcGduQn1si6xCRS145YZE4yOR9sU9OPMQuDratz+BD0bP7AK58kJQFDTvacHKgzO
        wMf/JmE/cUa5j2GyhZw0wE+6oEthIj+E0KnMvJffbwdt/h+IhWSCmSXHc2RNxJ+ULVqGKz
        J4203xotX487jAT/Naoys4O38WXZdhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-e56SiWe7OLG7HO4suxdo-A-1; Tue, 09 Feb 2021 05:57:25 -0500
X-MC-Unique: e56SiWe7OLG7HO4suxdo-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 062B0803F48;
        Tue,  9 Feb 2021 10:57:22 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A070110016F8;
        Tue,  9 Feb 2021 10:57:17 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] mm, slub: use pGp to print page flags
To:     Yafang Shao <laoar.shao@gmail.com>, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, linmiaohe@huawei.com,
        vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210209105613.42747-1-laoar.shao@gmail.com>
 <20210209105613.42747-2-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b23bba93-218b-4acc-4717-1b7e0a381e2d@redhat.com>
Date:   Tue, 9 Feb 2021 11:57:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210209105613.42747-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 11:56, Yafang Shao wrote:
> As pGp has been already introduced in printk, we'd better use it to make
> the output human readable.
> 
> Before this change, the output is,
> [ 6155.716018] INFO: Slab 0x000000004027dd4f objects=33 used=3 fp=0x000000008cd1579c flags=0x17ffffc0010200
> 
> While after this change, the output is,
> [ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Christoph Lameter <cl@linux.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/slub.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 34dcc09e2ec9..87ff086e68a4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -638,8 +638,9 @@ void print_tracking(struct kmem_cache *s, void *object)
>   
>   static void print_page_info(struct page *page)
>   {
> -	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=0x%04lx\n",
> -	       page, page->objects, page->inuse, page->freelist, page->flags);
> +	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
> +	       page, page->objects, page->inuse, page->freelist,
> +	       page->flags, &page->flags);
>   
>   }
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

