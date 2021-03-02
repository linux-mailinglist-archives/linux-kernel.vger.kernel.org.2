Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3223532A24D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444059AbhCBHds convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Mar 2021 02:33:48 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4640 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347615AbhCBHHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:07:01 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DqSm42pyGzYD8V;
        Tue,  2 Mar 2021 15:04:04 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 2 Mar 2021 15:05:35 +0800
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 2 Mar 2021 15:05:35 +0800
Received: from dggeme755-chm.china.huawei.com ([10.7.64.71]) by
 dggeme755-chm.china.huawei.com ([10.7.64.71]) with mapi id 15.01.2106.006;
 Tue, 2 Mar 2021 15:05:35 +0800
From:   "Zhouguanghui (OS Kernel)" <zhouguanghui1@huawei.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "npiggin@suse.de" <npiggin@suse.de>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Dingtianhong <dingtianhong@huawei.com>,
        Chenweilong <chenweilong@huawei.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
Thread-Topic: [PATCH] mm/memcg: set memcg when split pages
Thread-Index: AQHXDwe4PfGiAC+zfUG9IaYiC6n5KA==
Date:   Tue, 2 Mar 2021 07:05:35 +0000
Message-ID: <aab0bc059f3b4ffcb7acbac1724bcaa2@huawei.com>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com>
 <733264DE-1845-4615-8573-481E63895397@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.106]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/3/2 10:00, Zi Yan 写道:
> On 1 Mar 2021, at 20:34, Zhou Guanghui wrote:
> 
>> When split page, the memory cgroup info recorded in first page is
>> not copied to tail pages. In this case, when the tail pages are
>> freed, the uncharge operation is not performed. As a result, the
>> usage of this memcg keeps increasing, and the OOM may occur.
>>
>> So, the copying of first page's memory cgroup info to tail pages
>> is needed when split page.
>>
>> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
>> ---
>>   include/linux/memcontrol.h | 10 ++++++++++
>>   mm/page_alloc.c            |  4 +++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index e6dc793d587d..c7e2b4421dc1 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -867,6 +867,12 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
>>   extern bool cgroup_memory_noswap;
>>   #endif
>>
>> +static inline void copy_page_memcg(struct page *dst, struct page *src)
>> +{
>> +	if (src->memcg_data)
>> +		dst->memcg_data = src->memcg_data;
>> +}
>> +
>>   struct mem_cgroup *lock_page_memcg(struct page *page);
>>   void __unlock_page_memcg(struct mem_cgroup *memcg);
>>   void unlock_page_memcg(struct page *page);
>> @@ -1291,6 +1297,10 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>>   {
>>   }
>>
>> +static inline void copy_page_memcg(struct page *dst, struct page *src)
>> +{
>> +}
>> +
>>   static inline struct mem_cgroup *lock_page_memcg(struct page *page)
>>   {
>>   	return NULL;
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3e4b29ee2b1e..ee0a63dc1c9b 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3307,8 +3307,10 @@ void split_page(struct page *page, unsigned int order)
>>   	VM_BUG_ON_PAGE(PageCompound(page), page);
>>   	VM_BUG_ON_PAGE(!page_count(page), page);
>>
>> -	for (i = 1; i < (1 << order); i++)
>> +	for (i = 1; i < (1 << order); i++) {
>>   		set_page_refcounted(page + i);
>> +		copy_page_memcg(page + i, page);
>> +	}
>>   	split_page_owner(page, 1 << order);
>>   }
>>   EXPORT_SYMBOL_GPL(split_page);
>> -- 
>> 2.25.0
> 
> +memcg maintainers
> 
> split_page() is used for non-compound higher-order pages. I am not sure
> if there is any such pages monitored by memcg. Please let me know
> if I miss anything.

Thank you for taking time for this.

This should be put in kmemcg, and I'll modify it.

When the kmemcg is enabled and _GFP_ACCOUNT is set, the charged and 
uncharged sizes do not match when alloc/free_pages_exact method is used 
to apply for or free memory with exact size. This is because memcg data 
of the tail page is not set during the split page.

