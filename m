Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6A9418DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 05:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhI0DII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 23:08:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11982 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhI0DIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 23:08:07 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HHnZ039bYzWNSn;
        Mon, 27 Sep 2021 11:05:12 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 11:06:28 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 11:06:28 +0800
Subject: Re: [PATCH resend] slub: Add back check for free nonslab objects
To:     Matthew Wilcox <willy@infradead.org>
CC:     <shakeelb@google.com>, <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210927021538.155991-1-wangkefeng.wang@huawei.com>
 <YVEvgfJQJ1aRerg6@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <5fbb67aa-9651-6fb8-4339-a74ac53acb33@huawei.com>
Date:   Mon, 27 Sep 2021 11:06:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YVEvgfJQJ1aRerg6@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/27 10:42, Matthew Wilcox wrote:
> On Mon, Sep 27, 2021 at 10:15:38AM +0800, Kefeng Wang wrote:
>> Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
>> add the ability, which should be needed in any configs to catch the
>> invalid free, they even could be potential issue, eg, memory corruption,
>> use after free and double-free, so replace VM_BUG_ON_PAGE to WARN_ON, and
>> add dump_page() to help use to debug the issue.
> Is dump_page() really the best way to catch such a thing?  I would have
> thought that printing the address of 'object' would be more helpful.

With no vmcore, dump_page() do help us to find a memory corruption issue.

We could add 'object ' address print too.

>
>> @@ -3522,7 +3522,8 @@ static inline void free_nonslab_page(struct page *page, void *object)
>>   {
>>   	unsigned int order = compound_order(page);
>>   
>> -	VM_BUG_ON_PAGE(!PageCompound(page), page);
>> +	if (WARN_ON(!PageCompound(page)))
>> +		dump_page(page, "invalid free nonslab page");
> .
>
