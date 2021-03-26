Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A1434A99D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhCZOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230194AbhCZOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616768579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hiYYMuSGtUxuJHxwx4NFJyHebtaUSA1v/Jrod5zbAAY=;
        b=fSA0bolPwBG63Q/HVGkQTaUWyE2jn71KjTw2vGOFKLmZ6AJfecNzPyZ1pJmsUINTvL/kji
        t//HTC/jARKdf6jS7DtTEoGRzF1Tof4sEwbbs3d2L04mQDBMK14M0+ANu0X/rfmDHtzQCN
        kFUqs8k6NfM9ytqPEP2y4Nx+jDglwVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-BdSci58rPgWwzEHRpWXxVg-1; Fri, 26 Mar 2021 10:22:55 -0400
X-MC-Unique: BdSci58rPgWwzEHRpWXxVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 298F287504F;
        Fri, 26 Mar 2021 14:22:53 +0000 (UTC)
Received: from [10.36.112.81] (ovpn-112-81.ams2.redhat.com [10.36.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 881E118035;
        Fri, 26 Mar 2021 14:22:50 +0000 (UTC)
Subject: Re: [PATCH v5] mm/gup: check page hwposion status for coredump.
From:   David Hildenbrand <david@redhat.com>
To:     Aili Yao <yaoaili@kingsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yangfeng1@kingsoft.com, sunhao2@kingsoft.com,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20210317163714.328a038d@alex-virtual-machine>
 <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
 <20210318044600.GJ3420@casper.infradead.org>
 <20210318133412.12078eb7@alex-virtual-machine>
 <20210319104437.6f30e80d@alex-virtual-machine>
 <20210320003516.GC3420@casper.infradead.org>
 <20210322193318.377c9ce9@alex-virtual-machine>
 <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
Date:   Fri, 26 Mar 2021 15:22:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.21 15:09, David Hildenbrand wrote:
> On 22.03.21 12:33, Aili Yao wrote:
>> When we do coredump for user process signal, this may be one SIGBUS signal
>> with BUS_MCEERR_AR or BUS_MCEERR_AO code, which means this signal is
>> resulted from ECC memory fail like SRAR or SRAO, we expect the memory
>> recovery work is finished correctly, then the get_dump_page() will not
>> return the error page as its process pte is set invalid by
>> memory_failure().
>>
>> But memory_failure() may fail, and the process's related pte may not be
>> correctly set invalid, for current code, we will return the poison page,
>> get it dumped, and then lead to system panic as its in kernel code.
>>
>> So check the hwpoison status in get_dump_page(), and if TRUE, return NULL.
>>
>> There maybe other scenario that is also better to check hwposion status
>> and not to panic, so make a wrapper for this check, Thanks to David's
>> suggestion(<david@redhat.com>).
>>
>> Link: https://lkml.kernel.org/r/20210319104437.6f30e80d@alex-virtual-machine
>> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Aili Yao <yaoaili@kingsoft.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>    mm/gup.c      |  4 ++++
>>    mm/internal.h | 20 ++++++++++++++++++++
>>    2 files changed, 24 insertions(+)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index e4c224c..6f7e1aa 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -1536,6 +1536,10 @@ struct page *get_dump_page(unsigned long addr)
>>    				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
>>    	if (locked)
>>    		mmap_read_unlock(mm);
> 
> Thinking again, wouldn't we get -EFAULT from __get_user_pages_locked()
> when stumbling over a hwpoisoned page?
> 
> See __get_user_pages_locked()->__get_user_pages()->faultin_page():
> 
> handle_mm_fault()->vm_fault_to_errno(), which translates
> VM_FAULT_HWPOISON to -EFAULT, unless FOLL_HWPOISON is set (-> -EHWPOISON)
> 
> ?

Or doesn't that happen as you describe "But memory_failure() may fail, 
and the process's related pte may not be correctly set invalid" -- but 
why does that happen?

On a similar thought, should get_user_pages() never return a page that 
has HWPoison set? E.g., check also for existing PTEs if the page is 
hwpoisoned?

@Naoya, Oscar

-- 
Thanks,

David / dhildenb

