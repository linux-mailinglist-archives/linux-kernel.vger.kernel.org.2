Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB63B062F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFVNv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:51:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11082 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFVNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:51:56 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G8SNs3cPxzZh5K;
        Tue, 22 Jun 2021 21:46:37 +0800 (CST)
Received: from [10.174.177.120] (10.174.177.120) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 22 Jun 2021 21:49:37 +0800
Subject: Re: [PATCH 6/6] mm/z3fold: use release_z3fold_page_locked() to
 release locked z3fold page
To:     Hillf Danton <hdanton@sina.com>
CC:     <akpm@linux-foundation.org>, <vitalywool@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20210619093151.1492174-1-linmiaohe@huawei.com>
 <20210620002604.1575-1-hdanton@sina.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ef4e77a6-4c30-d92c-bd7a-35fa27290401@huawei.com>
Date:   Tue, 22 Jun 2021 21:49:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210620002604.1575-1-hdanton@sina.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.120]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/20 8:26, Hillf Danton wrote:
> On Sat, 19 Jun 2021 17:31:51 +0800 Miaohe Lin wrote:
>> We should use release_z3fold_page_locked() to release z3fold page when it's
>> locked, although it looks harmless to use release_z3fold_page() now.
>>
>> Fixes: dcf5aedb24f8 ("z3fold: stricter locking and more careful reclaim")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/z3fold.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/z3fold.c b/mm/z3fold.c
>> index 196d886a3436..b3c0577b8095 100644
>> --- a/mm/z3fold.c
>> +++ b/mm/z3fold.c
>> @@ -1372,7 +1372,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>>  			if (zhdr->foreign_handles ||
>>  			    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
>>  				if (kref_put(&zhdr->refcount,
>> -						release_z3fold_page))
>> +						release_z3fold_page_locked))
>>  					atomic64_dec(&pool->pages_nr);
> 
> LGTM. JFYI other issue in z3fold was reported [1] and if the fix proposed there
> makes any sense to you feel free to pick it up and ask Mike for his tests.
> 

Thank you for review and reply.

I browsed [1] several times but I failed to figure out what's the root cause. And I found
some bugs and possible race windows from previous code inspection. I think we can try fix
these first and see whether [1] is (hopefully) fixed. :)
Thanks again.

> [1] https://lore.kernel.org/linux-mm/20210316061351.1649-1-hdanton@sina.com/
> .
>
