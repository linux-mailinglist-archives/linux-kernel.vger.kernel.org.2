Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5D139EB93
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFHBnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:43:06 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4386 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFHBnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:43:05 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzXsr6cwDz6vQZ;
        Tue,  8 Jun 2021 09:37:20 +0800 (CST)
Received: from [10.174.176.210] (10.174.176.210) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:41:10 +0800
Subject: Re: [PATCH 1/2] mm/zbud: reuse unbuddied[0] as buddied in zbud_pool
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <sjenning@redhat.com>, <ddstreet@ieee.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210605075141.1359969-1-linmiaohe@huawei.com>
 <20210605075141.1359969-2-linmiaohe@huawei.com>
 <20210607161010.94168ddc8128da6af1e45cea@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b9ff2df8-e9d5-9572-c1b0-03c3a0608fb5@huawei.com>
Date:   Tue, 8 Jun 2021 09:41:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210607161010.94168ddc8128da6af1e45cea@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.210]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/8 7:10, Andrew Morton wrote:
> On Sat, 5 Jun 2021 15:51:40 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> Since commit 9d8c5b5284e4 ("mm: zbud: fix condition check on allocation
>> size"), zbud_pool.unbuddied[0] is always unused. We can reuse it as buddied
>> field to save some possible memory.
>>
>> ...
>>
>> --- a/mm/zbud.c
>> +++ b/mm/zbud.c
>> @@ -96,7 +96,7 @@
>>  struct zbud_pool {
>>  	spinlock_t lock;
>>  	struct list_head unbuddied[NCHUNKS];
>> -	struct list_head buddied;
>> +#define buddied unbuddied[0]
>>  	struct list_head lru;
>>  	u64 pages_nr;
>>  	const struct zbud_ops *ops;
> 
> That looks a bit hacky.  Can we at least have a comment explaining
> what's going on?
> 
> Would it be better to implement this with a union, rather than a #define?

It seems union is better and comment is necessary. Will try to do this.
Many thanks for your comment and reply!

> .
> 

