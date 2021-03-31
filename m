Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C9B34F8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCaGpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233882AbhCaGpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617173103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOu3IBaGpEdrns18pR1ePpxympivW2akSHdNF3h92OE=;
        b=JI1muXHc5Gva7b7TOxGhihHE77rGy4pEVoQJduZJYEWbHwA9JpIeNNDr7eTX9aFUxGGP4N
        6n/W88+kVINuqvknkc/KLZCn5MUbGL77rPVWHdizzpWX5Fe5/dlkQO5JCDbfvmHz2mS9PK
        VStgt9rshBXK5IA/k3IdEXvC5HZyUQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-T3j-aA0FNWuBocLvx2Mxcg-1; Wed, 31 Mar 2021 02:44:59 -0400
X-MC-Unique: T3j-aA0FNWuBocLvx2Mxcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E8F0100960D;
        Wed, 31 Mar 2021 06:44:57 +0000 (UTC)
Received: from [10.36.113.60] (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C33E060CE7;
        Wed, 31 Mar 2021 06:44:54 +0000 (UTC)
Subject: Re: [PATCH v5] mm/gup: check page hwposion status for coredump.
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Aili Yao <yaoaili@kingsoft.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
 <20210318044600.GJ3420@casper.infradead.org>
 <20210318133412.12078eb7@alex-virtual-machine>
 <20210319104437.6f30e80d@alex-virtual-machine>
 <20210320003516.GC3420@casper.infradead.org>
 <20210322193318.377c9ce9@alex-virtual-machine>
 <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
 <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
 <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
 <20210331104303.145aea53@alex-virtual-machine>
 <20210331043231.GA26013@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9f49c415-a75a-1ea3-b80c-5ba512331de6@redhat.com>
Date:   Wed, 31 Mar 2021 08:44:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210331043231.GA26013@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.21 06:32, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Mar 31, 2021 at 10:43:36AM +0800, Aili Yao wrote:
>> On Wed, 31 Mar 2021 01:52:59 +0000 HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:
>>> On Fri, Mar 26, 2021 at 03:22:49PM +0100, David Hildenbrand wrote:
>>>> On 26.03.21 15:09, David Hildenbrand wrote:
>>>>> On 22.03.21 12:33, Aili Yao wrote:
>>>>>> When we do coredump for user process signal, this may be one SIGBUS signal
>>>>>> with BUS_MCEERR_AR or BUS_MCEERR_AO code, which means this signal is
>>>>>> resulted from ECC memory fail like SRAR or SRAO, we expect the memory
>>>>>> recovery work is finished correctly, then the get_dump_page() will not
>>>>>> return the error page as its process pte is set invalid by
>>>>>> memory_failure().
>>>>>>
>>>>>> But memory_failure() may fail, and the process's related pte may not be
>>>>>> correctly set invalid, for current code, we will return the poison page,
>>>>>> get it dumped, and then lead to system panic as its in kernel code.
>>>>>>
>>>>>> So check the hwpoison status in get_dump_page(), and if TRUE, return NULL.
>>>>>>
>>>>>> There maybe other scenario that is also better to check hwposion status
>>>>>> and not to panic, so make a wrapper for this check, Thanks to David's
>>>>>> suggestion(<david@redhat.com>).
>>>>>>
>>>>>> Link: https://lkml.kernel.org/r/20210319104437.6f30e80d@alex-virtual-machine
>>>>>> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>>> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>>>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>>>>>> Cc: Aili Yao <yaoaili@kingsoft.com>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>>>> ---
>>>>>>     mm/gup.c      |  4 ++++
>>>>>>     mm/internal.h | 20 ++++++++++++++++++++
>>>>>>     2 files changed, 24 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>>>> index e4c224c..6f7e1aa 100644
>>>>>> --- a/mm/gup.c
>>>>>> +++ b/mm/gup.c
>>>>>> @@ -1536,6 +1536,10 @@ struct page *get_dump_page(unsigned long addr)
>>>>>>     				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
>>>>>>     	if (locked)
>>>>>>     		mmap_read_unlock(mm);
>>>>>
>>>>> Thinking again, wouldn't we get -EFAULT from __get_user_pages_locked()
>>>>> when stumbling over a hwpoisoned page?
>>>>>
>>>>> See __get_user_pages_locked()->__get_user_pages()->faultin_page():
>>>>>
>>>>> handle_mm_fault()->vm_fault_to_errno(), which translates
>>>>> VM_FAULT_HWPOISON to -EFAULT, unless FOLL_HWPOISON is set (-> -EHWPOISON)
>>>>>
>>>>> ?
>>>
>>> We could get -EFAULT, but sometimes not (depends on how memory_failure() fails).
>>>
>>> If we failed to unmap, the page table is not converted to hwpoison entry,
>>> so __get_user_pages_locked() get the hwpoisoned page.
>>>
>>> If we successfully unmapped but failed in truncate_error_page() for example,
>>> the processes mapping the page would get -EFAULT as expected.  But even in
>>> this case, other processes could reach the error page via page cache and
>>> __get_user_pages_locked() for them could return the hwpoisoned page.
>>>
>>>>
>>>> Or doesn't that happen as you describe "But memory_failure() may fail, and
>>>> the process's related pte may not be correctly set invalid" -- but why does
>>>> that happen?
>>>
>>> Simply because memory_failure() doesn't handle some page types like ksm page
>>> and zero page. Or maybe shmem thp also belongs to this class.

Thanks for that info!

>>>
>>>>
>>>> On a similar thought, should get_user_pages() never return a page that has
>>>> HWPoison set? E.g., check also for existing PTEs if the page is hwpoisoned?
>>>
>>> Make sense to me. Maybe inserting hwpoison check into follow_page_pte() and
>>> follow_huge_pmd() would work well.
>>
>> I think we should take more care to broadcast the hwpoison check to other cases,
>> SIGBUS coredump is such a case that it is supposed to not touch the poison page,
>> and if we return NULL for this, the coredump process will get a successful finish.
>>
>> Other cases may also meet the requirements like coredump, but we need to identify it,
>> that's the poison check wrapper's purpose. If not, we may break the integrity of the
>> related action, which may be no better than panic.
> 
> If you worry about regression and would like to make this new behavior conditional,
> we could use FOLL_HWPOISON to specify that the caller is hwpoison-aware so that
> any !FOLL_HWPOISON caller ignores the hwpoison check and works as it does now.
> This approach looks to me helpful because it would encourage developers touching
> gup code to pay attention to FOLL_HWPOISON code.

FOLL_HWPOISON might be the right start, indeed.

-- 
Thanks,

David / dhildenb

