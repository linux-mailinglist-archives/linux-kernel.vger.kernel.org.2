Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89436442F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhKBN43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:56:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:30904 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKBN42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:56:28 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HkB8M0BJkzcb3h;
        Tue,  2 Nov 2021 21:49:07 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 21:53:50 +0800
Received: from [10.174.177.232] (10.174.177.232) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 21:53:49 +0800
Subject: Re: [PATCH v2] mm, slub: emit the "free" trace report before freeing
 memory in kmem_cache_free()
To:     Yunfeng Ye <yeyunfeng@huawei.com>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <jhubbard@nvidia.com>, <songmuchun@bytedance.com>,
        <willy@infradead.org>, <wuxu.wu@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <a6824ebe-a0ad-fedb-ada3-c362f9c8f363@huawei.com>
From:   Tang Yizhou <tangyizhou@huawei.com>
Message-ID: <ee45ee4c-0993-e752-f4fc-fed519b67525@huawei.com>
Date:   Tue, 2 Nov 2021 21:53:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <a6824ebe-a0ad-fedb-ada3-c362f9c8f363@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.232]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/2 19:43, Yunfeng Ye wrote:
> After the memory is freed, it can be immediately allocated by other
> CPUs, before the "free" trace report has been emitted. This causes
> inaccurate traces.
> 
> For example, if the following sequence of events occurs:
> 
>     CPU 0                 CPU 1
> 
>   (1) alloc xxxxxx
>   (2) free  xxxxxx
>                          (3) alloc xxxxxx
>                          (4) free  xxxxxx
> 
> Then they will be inaccurately reported via tracing, so that they appear
> to have happened in this order:
> 
>     CPU 0                 CPU 1
> 
>   (1) alloc xxxxxx
>                          (2) alloc xxxxxx
>   (3) free  xxxxxx
>                          (4) free  xxxxxx
> 
> This makes it look like CPU 1 somehow managed to allocate mmemory that
> CPU 0 still had allocated for itself.
> 
> In order to avoid this, emit the "free xxxxxx" tracing report just
> before the actual call to free the memory, instead of just after it.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> v1 -> v2:
>  - Modify the description
>  - Add "Reviewed-by"
> 
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 432145d7b4ec..427e62034c3f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3526,8 +3526,8 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>  	s = cache_from_obj(s, x);
>  	if (!s)
>  		return;
> -	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>  	trace_kmem_cache_free(_RET_IP_, x, s->name);
> +	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>  }

It seems that kmem_cache_free() in mm/slab.c has the same problem.
We can fix it. Thanks.

>  EXPORT_SYMBOL(kmem_cache_free);
> 
