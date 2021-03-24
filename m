Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6086346FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhCXCh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:37:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14455 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhCXChU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:37:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4slq5jC0zwPYV;
        Wed, 24 Mar 2021 10:35:19 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 10:37:14 +0800
Subject: Re: [PATCH v2 1/5] mm/migrate.c: remove unnecessary VM_BUG_ON_PAGE on
 putback_movable_page()
To:     Yang Shi <shy828301@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210323135405.65059-1-linmiaohe@huawei.com>
 <20210323135405.65059-2-linmiaohe@huawei.com>
 <CAHbLzkrde4fMZtt7g+5HJ8PftwwDBvg-8b=W4F_64_EK-CusUA@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fffca253-87ba-6318-7039-2c0e88e2ffb1@huawei.com>
Date:   Wed, 24 Mar 2021 10:37:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkrde4fMZtt7g+5HJ8PftwwDBvg-8b=W4F_64_EK-CusUA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/24 1:58, Yang Shi wrote:
> On Tue, Mar 23, 2021 at 6:54 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> The !PageLocked() check is implicitly done in PageMovable(). Remove this
>> explicit one.
> 
> TBH, I'm a little bit reluctant to have this kind change. If "locked"
> check is necessary we'd better make it explicit otherwise just remove
> it.
> 
> And why not just remove all the 3 VM_BUG_ON_PAGE since
> putback_movable_page() is just called by putback_movable_pages() and
> we know the page is locked and both PageMovable and PageIsolated is
> checked right before calling putback_movable_page().
> 
> And you also could make putback_movable_page() static.
> 

Sounds good! Many thanks for your advice!

>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 47df0df8f21a..facec65c7374 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -145,7 +145,6 @@ void putback_movable_page(struct page *page)
>>  {
>>         struct address_space *mapping;
>>
>> -       VM_BUG_ON_PAGE(!PageLocked(page), page);
>>         VM_BUG_ON_PAGE(!PageMovable(page), page);
>>         VM_BUG_ON_PAGE(!PageIsolated(page), page);
>>
>> --
>> 2.19.1
>>
> .
> 

