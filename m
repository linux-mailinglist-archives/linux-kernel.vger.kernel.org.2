Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3DE34366F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVBwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:52:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14116 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhCVBwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:52:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F3crr4Pfyz19GQQ;
        Mon, 22 Mar 2021 09:50:20 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 09:52:12 +0800
Subject: Re: [PATCH 1/5] mm/migrate.c: remove unnecessary VM_BUG_ON_PAGE on
 putback_movable_page()
To:     Rafael Aquini <aquini@redhat.com>
CC:     <akpm@linux-foundation.org>, <jglisse@redhat.com>,
        <shy828301@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210320093701.12829-1-linmiaohe@huawei.com>
 <20210320093701.12829-2-linmiaohe@huawei.com> <YFYBIlkM+V0Nsl+5@x1-fbsd>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <efd21696-fb2b-e466-21fc-9b4cca40ffc1@huawei.com>
Date:   Mon, 22 Mar 2021 09:52:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YFYBIlkM+V0Nsl+5@x1-fbsd>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/3/20 22:11, Rafael Aquini wrote:
> On Sat, Mar 20, 2021 at 05:36:57AM -0400, Miaohe Lin wrote:
>> The !PageLocked() check is implicitly done in PageMovable(). Remove this
>> explicit one.
>>
> 
> I'd just keep the explicit assertion in place, regardless.
> But if you're going to stick with this patch, please fix it because it's 
> removing the wrong assertion.

Many thanks for your reply. I should have a coffee when I make this patch! :(
Will fix it. Many thanks for remind!

> 
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 47df0df8f21a..e4ca5ef508ea 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -146,7 +146,6 @@ void putback_movable_page(struct page *page)
>>  	struct address_space *mapping;
>>  
>>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>> -	VM_BUG_ON_PAGE(!PageMovable(page), page);
>>  	VM_BUG_ON_PAGE(!PageIsolated(page), page);
>>  
>>  	mapping = page_mapping(page);
>> -- 
>> 2.19.1
>>
>>
> 
> .
> 

