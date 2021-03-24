Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53370346FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhCXCkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:40:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14135 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbhCXCke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:40:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4sqZ00ywz19HGZ;
        Wed, 24 Mar 2021 10:38:33 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 10:40:28 +0800
Subject: Re: [PATCH v2 1/5] mm/migrate.c: remove unnecessary VM_BUG_ON_PAGE on
 putback_movable_page()
To:     David Hildenbrand <david@redhat.com>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>, <aquini@redhat.com>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210323135405.65059-1-linmiaohe@huawei.com>
 <20210323135405.65059-2-linmiaohe@huawei.com>
 <0017dfc4-05a4-1989-59dc-3f34f7b3517c@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8a25f3e9-c502-068e-ca40-242cce875584@huawei.com>
Date:   Wed, 24 Mar 2021 10:40:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0017dfc4-05a4-1989-59dc-3f34f7b3517c@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/23 22:27, David Hildenbrand wrote:
> On 23.03.21 14:54, Miaohe Lin wrote:
>> The !PageLocked() check is implicitly done in PageMovable(). Remove this
>> explicit one.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/migrate.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 47df0df8f21a..facec65c7374 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -145,7 +145,6 @@ void putback_movable_page(struct page *page)
>>   {
>>       struct address_space *mapping;
>>   -    VM_BUG_ON_PAGE(!PageLocked(page), page);
>>       VM_BUG_ON_PAGE(!PageMovable(page), page);
>>       VM_BUG_ON_PAGE(!PageIsolated(page), page);
>>  
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Many thanks for your review. But I'am going to change this patch, so this Reviewed-by tag may not
applies any more. Sorry about it!

> 

