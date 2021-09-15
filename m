Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7340BF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhIOG1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:27:37 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16205 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhIOG1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:27:37 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H8VZM71Xyz1DGxX;
        Wed, 15 Sep 2021 14:25:15 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 15 Sep 2021 14:26:15 +0800
Subject: Re: [PATCH v3] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <mhocko@suse.com>, <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210914114348.15569-1-linmiaohe@huawei.com>
 <454bd51f-d7ee-6304-af23-7c95874f8890@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <660c452e-521b-a5de-1170-0327421e181e@huawei.com>
Date:   Wed, 15 Sep 2021 14:26:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <454bd51f-d7ee-6304-af23-7c95874f8890@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/15 2:13, David Hildenbrand wrote:
> On 14.09.21 13:43, Miaohe Lin wrote:
>> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
>> the first pfn in a pageblock while __first_valid_page() will traverse the
>> pageblock until the first online pfn is found. So we may miss the call to
>> unset_migratetype_isolate() in undo path and pages will remain isolated
>> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
>> also help to simplify the code further. Note we shouldn't ever trigger it
>> because MAX_ORDER-1 aligned pfn ranges shouldn't contain memory holes now.
>>
>> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> I read Michals reply, however, I am quite conservative with Fixes: tags. If there is nothing to fix, there is no BUG and the patch consequently merely a cleanup.
> 
> I'd have gone with a patch description/subject as follows:
> 
> "
> mm/page_isolation: cleanup start_isolate_page_range()
> 
> We can heavily simplify the code by reusing undo_isolate_page_range().
> 
> Note that this also tackles a theoretical issue that would have been a real BUG before commit c5e79ef561b0 ("mm/memory_hotplug.c: don't allow to online/offline memory blocks with holes"). In start_isolate_page_range() undo path, pfn_to_online_page() just checks
> the first pfn in a pageblock while __first_valid_page() will traverse the pageblock until the first online pfn is found. So we may miss the call to unset_migratetype_isolate() in undo path and pages will remain isolated unexpectedly.
> 
> Nowadays, start_isolate_page_range() never gets called on ranges that might contain memory holes. Consequently, this patch is not a fix but a cleanup.
> "
> 
> Anyhow, whatever the other people prefer, no strong opinion.

I have no preference too. But if this is preferred, I will do it.

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Many thanks! :)

> 

