Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C7379C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhEKBlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:41:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2554 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhEKBlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:41:42 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FfLCS4THPzkWVG;
        Tue, 11 May 2021 09:37:56 +0800 (CST)
Received: from [10.174.176.232] (10.174.176.232) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 09:40:33 +0800
Subject: Re: [PATCH] ksm: Revert "use GET_KSM_PAGE_NOLOCK to get ksm page in
 remove_rmap_item_from_tree()"
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <alpine.LSU.2.11.2105092253500.1127@eggly.anvils>
 <0e04877c-5b2d-b810-7464-108e793b84d3@huawei.com>
 <alpine.LSU.2.11.2105101615570.1127@eggly.anvils>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f568172f-e672-b6bd-584d-94701f34cbfc@huawei.com>
Date:   Tue, 11 May 2021 09:40:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2105101615570.1127@eggly.anvils>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/11 7:42, Hugh Dickins wrote:
> On Mon, 10 May 2021, Miaohe Lin wrote:
>> On 2021/5/10 13:59, Hugh Dickins wrote:
>>> This reverts commit 3e96b6a2e9ad929a3230a22f4d64a74671a0720b.
>>> General Protection Fault in rmap_walk_ksm() under memory pressure:
>>> remove_rmap_item_from_tree() needs to take page lock, of course.
>>>
>>
>> I'am really sorry about it! And many thanks for this bugfix!
>> It seems rmap_walk_ksm() relies on the page lock to protect against
>> concurrent modifications to that page's node of the stable tree.
>> Could you please add a comment in remove_rmap_item_from_tree() to
>> clarify this in case similar trouble again? Many thanks!
> 
> Sorry, no.  Page lock is held by callers of stable_tree_append() when
> adding an rmap_item to the tree, and held by callers of rmap_walk_ksm()
> (see VM_BUG_ON_PAGE there) when walking the tree: you would surely
> expect some kind of locking when removing an rmap_item from the tree,
> and the appropriate page lock is what GET_KSM_PAGE_LOCK provided.
> 
> I do not want us to go through the kernel source adding a comment
> /* We really mean to take this lock: it protects against concurrency */
> every time we take a lock in the kernel: you should generally assume
> that if a lock is taken, then the writer intended it to be taken.
> 
> There are sure to be some exceptions, where a lock is taken pointlessly:
> but please look deeper before assuming that is the case.
> 

I see. I should have been more careful. Many thanks for your detailed explanation
and sorry about trouble!

> Hugh
> 
>>
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> ---
>>>
>>>  mm/ksm.c |    3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> --- 5.13-rc1/mm/ksm.c	2021-05-09 17:03:44.010422188 -0700
>>> +++ linux/mm/ksm.c	2021-05-09 22:12:39.403008350 -0700
>>> @@ -776,11 +776,12 @@ static void remove_rmap_item_from_tree(s
>>>  		struct page *page;
>>>  
>>>  		stable_node = rmap_item->head;
>>> -		page = get_ksm_page(stable_node, GET_KSM_PAGE_NOLOCK);
>>> +		page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
>>>  		if (!page)
>>>  			goto out;
>>>  
>>>  		hlist_del(&rmap_item->hlist);
>>> +		unlock_page(page);
>>>  		put_page(page);
>>>  
>>>  		if (!hlist_empty(&stable_node->hlist))
> .
> 

