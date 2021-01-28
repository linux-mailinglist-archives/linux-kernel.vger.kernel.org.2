Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1A3073AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhA1K0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:26:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:49734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhA1KYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:24:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEF8AAE57;
        Thu, 28 Jan 2021 10:23:26 +0000 (UTC)
Subject: Re: [PATCH 1/3] mm, slub: use pGp to print page flags
To:     Yafang Shao <laoar.shao@gmail.com>, david@redhat.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210128021947.22877-1-laoar.shao@gmail.com>
 <20210128021947.22877-2-laoar.shao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1c64112b-ade8-682f-3963-b4040fffb52d@suse.cz>
Date:   Thu, 28 Jan 2021 11:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128021947.22877-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 3:19 AM, Yafang Shao wrote:
> As pGp has been already introduced in printk, we'd better use it to make
> the output human readable.
> 
> Before this change, the output is,
> [ 6155.716018] INFO: Slab 0x000000004027dd4f objects=33 used=3 fp=0x000000008cd1579c flags=0x17ffffc0010200
> 
> While after this change, the output is,
> [ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 69742ab9a21d..4b9ab267afbc 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -641,8 +641,9 @@ void print_tracking(struct kmem_cache *s, void *object)
>  
>  static void print_page_info(struct page *page)
>  {
> -	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=0x%04lx\n",
> -	       page, page->objects, page->inuse, page->freelist, page->flags);
> +	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
> +	       page, page->objects, page->inuse, page->freelist,
> +	       page->flags, &page->flags);
>  
>  }
>  
> 

