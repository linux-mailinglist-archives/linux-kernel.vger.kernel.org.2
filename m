Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB641173F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhITOjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:39:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3846 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhITOjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:39:23 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HCnCj0h4qz67jtv;
        Mon, 20 Sep 2021 22:35:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 20 Sep 2021 16:37:54 +0200
Received: from [10.47.88.85] (10.47.88.85) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 20 Sep
 2021 15:37:53 +0100
Subject: Re: [RFC PATCH] Introducing lockless cache built on top of slab
 allocator
To:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20210919164239.49905-1-42.hyeyoo@gmail.com>
 <YUeM2J7X/i0CHjrz@casper.infradead.org>
 <20210920010938.GA3108@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YUfpniK6ZVeNhaX2@casper.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <56f30136-23ce-dd73-705c-4e1326768c9d@huawei.com>
Date:   Mon, 20 Sep 2021 15:41:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YUfpniK6ZVeNhaX2@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.85]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 02:53, Matthew Wilcox wrote:
> On Mon, Sep 20, 2021 at 01:09:38AM +0000, Hyeonggon Yoo wrote:
>> Hello Matthew, Thanks to give me a comment! I appreciate it.
>>
>> On Sun, Sep 19, 2021 at 08:17:44PM +0100, Matthew Wilcox wrote:
>>> On Sun, Sep 19, 2021 at 04:42:39PM +0000, Hyeonggon Yoo wrote:
>>>> It is just simple proof of concept, and not ready for submission yet.
>>>> There can be wrong code (like wrong gfp flags, or wrong error handling,
>>>> etc) it is just simple proof of concept. I want comment from you.
>>>
>>> Have you read:
>>>
>>> https://www.usenix.org/legacy/event/usenix01/full_papers/bonwick/bonwick_html/
>>> The relevant part of that paper is section 3, magazines.  We should have
>>> low and high water marks for number of objects
>>

In case unknown, jfyi there is an implementation of this in 
drivers/iommu/iova.c

Thanks,
John

>> I haven't read that before, but after reading it seems not different from
>> SLAB's percpu queuing.
>>   
>>> and we should allocate
>>> from / free to the slab allocator in batches.  Slab has bulk alloc/free
>>> APIs already.
>>>
