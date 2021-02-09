Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E68331453D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBIBF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:05:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12499 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBIBFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:05:22 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DZPlR1szQzjKdr;
        Tue,  9 Feb 2021 09:03:15 +0800 (CST)
Received: from [10.174.179.149] (10.174.179.149) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 09:04:35 +0800
Subject: Re: [PATCH v3 1/3] mm, slub: use pGp to print page flags
To:     Yafang Shao <laoar.shao@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <david@redhat.com>,
        <vbabka@suse.cz>, <willy@infradead.org>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>, <joe@perches.com>
References: <20210208101439.55474-1-laoar.shao@gmail.com>
 <20210208101439.55474-2-laoar.shao@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <90e31853-d3db-df51-b32e-bebd030e44d2@huawei.com>
Date:   Tue, 9 Feb 2021 09:04:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210208101439.55474-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/8 18:14, Yafang Shao wrote:
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
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

LGTM. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/slub.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 34dcc09e2ec9..87ff086e68a4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -638,8 +638,9 @@ void print_tracking(struct kmem_cache *s, void *object)
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

