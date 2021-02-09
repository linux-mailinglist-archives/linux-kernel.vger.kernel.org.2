Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F032A314540
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBIBHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:07:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12600 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhBIBHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:07:06 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZPnP4Gggz165Y3;
        Tue,  9 Feb 2021 09:04:57 +0800 (CST)
Received: from [10.174.179.149] (10.174.179.149) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 09:06:18 +0800
Subject: Re: [PATCH v3 2/3] mm, slub: don't combine pr_err with INFO
To:     Yafang Shao <laoar.shao@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <david@redhat.com>,
        <vbabka@suse.cz>, <willy@infradead.org>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>, <joe@perches.com>
References: <20210208101439.55474-1-laoar.shao@gmail.com>
 <20210208101439.55474-3-laoar.shao@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c17ff56c-fbbb-91c3-9754-fd92f744a837@huawei.com>
Date:   Tue, 9 Feb 2021 09:06:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210208101439.55474-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/8 18:14, Yafang Shao wrote:
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
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Looks good,thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/slub.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 87ff086e68a4..2514c37ab4e4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -612,7 +612,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
>  	if (!t->addr)
>  		return;
>  
> -	pr_err("INFO: %s in %pS age=%lu cpu=%u pid=%d\n",
> +	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
>  	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
>  #ifdef CONFIG_STACKTRACE
>  	{
> @@ -638,7 +638,7 @@ void print_tracking(struct kmem_cache *s, void *object)
>  
>  static void print_page_info(struct page *page)
>  {
> -	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
> +	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
>  	       page, page->objects, page->inuse, page->freelist,
>  	       page->flags, &page->flags);
>  
> @@ -695,7 +695,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
>  
>  	print_page_info(page);
>  
> -	pr_err("INFO: Object 0x%p @offset=%tu fp=0x%p\n\n",
> +	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
>  	       p, p - addr, get_freepointer(s, p));
>  
>  	if (s->flags & SLAB_RED_ZONE)
> @@ -788,7 +788,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
>  		end--;
>  
>  	slab_bug(s, "%s overwritten", what);
> -	pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> +	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
>  					fault, end - 1, fault - addr,
>  					fault[0], value);
>  	print_trailer(s, page, object);
> @@ -3854,7 +3854,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
>  	for_each_object(p, s, addr, page->objects) {
>  
>  		if (!test_bit(__obj_to_index(s, addr, p), map)) {
> -			pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
> +			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
>  			print_tracking(s, p);
>  		}
>  	}
> 

