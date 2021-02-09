Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E9431488C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBIGUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:20:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12531 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBIGUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:20:06 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DZXk91psxzMWrY;
        Tue,  9 Feb 2021 14:17:37 +0800 (CST)
Received: from [10.174.179.149] (10.174.179.149) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 14:19:17 +0800
Subject: Re: [PATCH] mm/hugetlb: Remove redundant VM_BUG_ON_PAGE on
 putback_active_hugepage()
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210208083739.33178-1-linmiaohe@huawei.com>
 <7e1cdef7-e3cd-79c1-c30c-5f5e9e9f85ac@oracle.com>
 <a5a09912-72ab-f494-0f29-5e3b7fb7c5a4@huawei.com>
 <90572a26-a55c-10d1-3c7e-bcdea1f32fe2@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6082fd02-b78e-804c-a240-ed3bd2a91c34@huawei.com>
Date:   Tue, 9 Feb 2021 14:19:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <90572a26-a55c-10d1-3c7e-bcdea1f32fe2@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/9 11:39, Mike Kravetz wrote:
> On 2/8/21 6:10 PM, Miaohe Lin wrote:
>> Hi:
>> On 2021/2/9 9:26, Mike Kravetz wrote:
>>> On 2/8/21 12:37 AM, Miaohe Lin wrote:
>>>> PageHead(page) is implicitly checked in set_page_huge_active() via the
>>>> PageHeadHuge(page) check. So remove this explicit one.
>>>
>>> I do not disagree with the code change.  However, this commit message
>>> is not accurate.  set_page_huge_active() no longer exists in the tree
>>> you are changing.  It was replaced with SetHPageMigratable.  Also, the
>>> VM_BUG_ON_PAGE(!PageHeadHuge(page), page) was removed in the process.
>>> So, there is no redundant check.
>>>
>>> However, a quick audit of calling code reveals that all callers know they
>>> are operating on a hugetlb head page.
>>>
>>
>> So I should change the commit log like:
>>
>> 	All callers know they are operating on a hugetlb head page. So this VM_BUG_ON_PAGE
>> 	can't catch anything useful.
>>
>> and send a v2. Right?
> 
> Correct,
> 
Will do. Thanks a lot.
