Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63DA418D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhI0CJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 22:09:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11981 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhI0CJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 22:09:53 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HHmGp39q0zWMn5;
        Mon, 27 Sep 2021 10:06:58 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 10:08:14 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 10:08:13 +0800
Subject: Re: [PATCH] slub: Add back check for free nonslab objects
To:     <shakeelb@google.com>, <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210927020922.87449-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <05edb377-0168-6a16-d8a4-6dda77bb10e1@huawei.com>
Date:   Mon, 27 Sep 2021 10:08:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210927020922.87449-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry，wrong patch, please ignore

On 2021/9/27 10:09, Kefeng Wang wrote:
> After commit ("f227f0faf63b slub: fix unreclaimable slab stat for bulk
> free"), the check for free nonslab page is replaced by VM_BUG_ON_PAGE,
> which only check with CONFIG_DEBUG_VM enabled, but this config may
> impact performance, so it only for debug.
>
> Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
> add the ability, which should be needed in any configs to catch the
> invalid free, they even could be potential issue, eg, memory corruption,
> use after free and double free, so replace VM_BUG_ON_PAGE to WARN_ON, and
> add dump_page() to help use to debug the issue.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/slub.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 3095b889fab4..1bfe09098485 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3522,7 +3522,8 @@ static inline void free_nonslab_page(struct page *page, void *object)
>   {
>   	unsigned int order = compound_order(page);
>   
> -	VM_BUG_ON_PAGE(!PageCompound(page), page);
> +	if (WARN_ON(!PageCompound(page)))
> +		dump_page(page);
>   	kfree_hook(object);
>   	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
>   	__free_pages(page, order);
