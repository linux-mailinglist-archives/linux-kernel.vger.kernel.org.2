Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835BD3073D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhA1KgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:36:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:55482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232361AbhA1Kfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:35:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3DDDFAC97;
        Thu, 28 Jan 2021 10:35:01 +0000 (UTC)
Subject: Re: [PATCH 2/3] mm, slub: don't combine pr_err with INFO
To:     Yafang Shao <laoar.shao@gmail.com>, david@redhat.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210128021947.22877-1-laoar.shao@gmail.com>
 <20210128021947.22877-3-laoar.shao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0b2f4419-06a9-0b6c-067b-8d0848e78c33@suse.cz>
Date:   Thu, 28 Jan 2021 11:35:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128021947.22877-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 3:19 AM, Yafang Shao wrote:
> It is strange to combine "pr_err" with "INFO", so let's clean them up.
> This patch is motivated by David's comment[1].
> 
> - before the patch
> [ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)
> 
> - after the patch
> [ 6312.639698] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(slab|head)
> 
> [1]. https://lore.kernel.org/linux-mm/b9c0f2b6-e9b0-0c36-ebdd-2bc684c5a762@redhat.com/#t
> 
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

These are usually printed as part of slab_bug() with its prominent banner. In
that sense it's additional details, thus INFO. The details itself are not error,
thus ERR makes little sense imho. How about removing the prefix completely, or
just replacing with an ident to make it visually part of the BUG report.

> ---
>  mm/slub.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 4b9ab267afbc..18b4474c8fa2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -615,7 +615,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
>  	if (!t->addr)
>  		return;
>  
> -	pr_err("INFO: %s in %pS age=%lu cpu=%u pid=%d\n",
> +	pr_err("ERR: %s in %pS age=%lu cpu=%u pid=%d\n",
>  	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
>  #ifdef CONFIG_STACKTRACE
>  	{
> @@ -641,7 +641,7 @@ void print_tracking(struct kmem_cache *s, void *object)
>  
>  static void print_page_info(struct page *page)
>  {
> -	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
> +	pr_err("ERR: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
>  	       page, page->objects, page->inuse, page->freelist,
>  	       page->flags, &page->flags);
>  
> @@ -698,7 +698,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
>  
>  	print_page_info(page);
>  
> -	pr_err("INFO: Object 0x%p @offset=%tu fp=0x%p\n\n",
> +	pr_err("ERR: Object 0x%p @offset=%tu fp=0x%p\n\n",
>  	       p, p - addr, get_freepointer(s, p));
>  
>  	if (s->flags & SLAB_RED_ZONE)
> @@ -791,7 +791,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
>  		end--;
>  
>  	slab_bug(s, "%s overwritten", what);
> -	pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> +	pr_err("ERR: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
>  					fault, end - 1, fault - addr,
>  					fault[0], value);
>  	print_trailer(s, page, object);
> @@ -3855,7 +3855,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
>  	for_each_object(p, s, addr, page->objects) {
>  
>  		if (!test_bit(__obj_to_index(s, addr, p), map)) {
> -			pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
> +			pr_err("ERR: Object 0x%p @offset=%tu\n", p, p - addr);
>  			print_tracking(s, p);
>  		}
>  	}
> 

