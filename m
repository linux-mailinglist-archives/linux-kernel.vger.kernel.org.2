Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E426940A428
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhINDLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:11:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9863 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbhINDLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:11:06 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7pBC0cQdz8yW6;
        Tue, 14 Sep 2021 11:05:23 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:09:48 +0800
Subject: Re: [PATCH v2] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
To:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210913115125.33617-1-linmiaohe@huawei.com>
 <YT9AS6I1Th14mCxh@dhcp22.suse.cz>
 <e1e772b8-b9a7-0182-c469-73f32cda005e@redhat.com>
 <6cb372ff-0b68-2143-913e-04ab3e6b4160@huawei.com>
 <YT9LPoSSTJbmF3eF@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1d0e15ab-4a1f-0820-26c2-4b9949164dfa@huawei.com>
Date:   Tue, 14 Sep 2021 11:09:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YT9LPoSSTJbmF3eF@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/13 20:59, Michal Hocko wrote:
> On Mon 13-09-21 20:43:35, Miaohe Lin wrote:
>> On 2021/9/13 20:20, David Hildenbrand wrote:
>>> On 13.09.21 14:12, Michal Hocko wrote:
>>>> On Mon 13-09-21 19:51:25, Miaohe Lin wrote:
>>>>> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
>>>>> the first pfn in a pageblock while __first_valid_page() will traverse the
>>>>> pageblock until the first online pfn is found. So we may miss the call to
>>>>> unset_migratetype_isolate() in undo path and pages will remain isolated
>>>>> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
>>>>> also help to simplify the code further.
>>>>
>>>> I like the clean up part but is this a real problem that requires CC
>>>> stable? Have you ever seen this to be a real problem? It looks like
>>>> something based on reading the code.
>>
>> I'm sorry but I haven't seen this to be a real problem. It's a theoretical bug.
> 
> Make it clear in the changelog

Will do.

> 
>>> We discussed that it isn't an issue anymore (we never call it on
>>> memory holes), but might have been an issue on older kernels, back
>>> when we didn't have the "memory holes" check in the memory offlining
>>> path in place.
>>
>> So is the Cc:stable needed in this case?
> 
> I do not think so. Even if this was happening in the practice then the
> practical consequences would be pretty minor, right? (few pageblocks
> stay isolated thus unavailable).
> 
> I do realize that the stable tree is in a hoarding mode for quite some
> years but my general approach has been (in line with the documentation)
> to mark and backport only fixes that really do matter.

So even the Fixes tag should be removed ?

Many thanks.

> 
