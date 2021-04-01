Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C771350D24
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbhDADbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:31:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14660 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhDADbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:31:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9pYk5srxznWxq;
        Thu,  1 Apr 2021 11:28:42 +0800 (CST)
Received: from [10.174.179.86] (10.174.179.86) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 11:31:16 +0800
Subject: Re: [PATCH] mm: memcontrol: fix forget to obtain the ref to objcg in
 split_page_memcg
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <duanxiongchun@bytedance.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, <guro@fb.com>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>
References: <20210401030141.37061-1-songmuchun@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5c183fe6-637f-151c-67f0-fe19a0ce3356@huawei.com>
Date:   Thu, 1 Apr 2021 11:31:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210401030141.37061-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.86]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/1 11:01, Muchun Song wrote:
> Christian Borntraeger reported a warning about "percpu ref
> (obj_cgroup_release) <= 0 (-1) after switching to atomic".
> Because we forgot to obtain the reference to the objcg and
> wrongly obtain the reference of memcg.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Thanks for the patch.
Is a Fixes tag needed?

> ---
>  include/linux/memcontrol.h | 6 ++++++
>  mm/memcontrol.c            | 6 +++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0e8907957227..c960fd49c3e8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -804,6 +804,12 @@ static inline void obj_cgroup_get(struct obj_cgroup *objcg)
>  	percpu_ref_get(&objcg->refcnt);
>  }
>  
> +static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
> +				       unsigned long nr)
> +{
> +	percpu_ref_get_many(&objcg->refcnt, nr);
> +}
> +
>  static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>  {
>  	percpu_ref_put(&objcg->refcnt);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c0b83a396299..64ada9e650a5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3133,7 +3133,11 @@ void split_page_memcg(struct page *head, unsigned int nr)
>  
>  	for (i = 1; i < nr; i++)
>  		head[i].memcg_data = head->memcg_data;
> -	css_get_many(&memcg->css, nr - 1);
> +
> +	if (PageMemcgKmem(head))
> +		obj_cgroup_get_many(__page_objcg(head), nr - 1);
> +	else
> +		css_get_many(&memcg->css, nr - 1);
>  }
>  
>  #ifdef CONFIG_MEMCG_SWAP
> 

