Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D8F388479
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 03:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhESBiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 21:38:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3017 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhESBiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 21:38:54 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlFlJ3QsnzQpcH;
        Wed, 19 May 2021 09:34:04 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 09:37:34 +0800
Received: from [10.174.176.110] (10.174.176.110) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 09:37:33 +0800
Subject: Re: [PATCH 2/5] mm/swap: remove unused local variable nr_shadows
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210518135352.3705306-1-linmiaohe@huawei.com>
 <20210518135352.3705306-3-linmiaohe@huawei.com>
 <YKPREjo49dP8mW2J@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3b7bd04e-4995-1bfb-0c42-81bad94fd4a4@huawei.com>
Date:   Wed, 19 May 2021 09:37:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YKPREjo49dP8mW2J@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.110]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/18 22:37, Matthew Wilcox wrote:
> On Tue, May 18, 2021 at 09:53:49PM +0800, Miaohe Lin wrote:
>> Since commit 55c653b71e8c ("mm: stop accounting shadow entries"),
>> nr_shadows is not used anymore.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
>> +++ b/mm/swap_state.c
>> @@ -114,7 +114,6 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
>>  	SetPageSwapCache(page);
>>  
>>  	do {
>> -		unsigned long nr_shadows = 0;
>>  
> 
> Perhaps delete the blank line as well?

Will do. Many thanks for the review.

> 
> .
> 

