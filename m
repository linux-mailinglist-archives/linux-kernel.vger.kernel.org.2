Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD893AE2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 07:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFUFx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 01:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhFUFxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 01:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624254700;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4pB8j6tDZRW0gLAsi2832dbbAuey5XcjoKSFTOd6GI=;
        b=LWRZwLJpZWI9YerMkLafu7hbp6KAEXc1pprkaLcLwp1rp6D6hUdjRTWsA+WrePAmmp+7wl
        saANdP/D3RF21I5CkTxSk9R+KdeNitPUE3WCvJWf2k4kvwpPiukzBjz2lhUckoeLMOtHgu
        tALphjoGyjtPMIu9BHlvV4FqpnBVUAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-NfR_JVlMN6m7pwdk431LCw-1; Mon, 21 Jun 2021 01:51:38 -0400
X-MC-Unique: NfR_JVlMN6m7pwdk431LCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6707B18414A0;
        Mon, 21 Jun 2021 05:51:37 +0000 (UTC)
Received: from [10.64.54.84] (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC32C60861;
        Mon, 21 Jun 2021 05:51:30 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shan.gavin@gmail.com, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210601033319.100737-1-gshan@redhat.com>
 <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
 <0c0eb8c8-463d-d6f1-3cec-bbc0af0a229c@redhat.com>
 <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
 <CAKgT0Ue9SQ8=ju1m6ftKTb4Tai9EJ5NQhnB_uk-DzMc19-R4cQ@mail.gmail.com>
 <63c06446-3b10-762c-3a29-464854b74e08@redhat.com>
 <CAKgT0UfSx+qhfLvnukag+Z4Ab72Lyg8UXBvduiswm2BnFZH9vw@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <5a74f8ed-8579-290b-758f-faa24d2afa70@redhat.com>
Date:   Mon, 21 Jun 2021 17:52:32 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfSx+qhfLvnukag+Z4Ab72Lyg8UXBvduiswm2BnFZH9vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/21 12:15 AM, Alexander Duyck wrote:
> On Wed, Jun 16, 2021 at 12:10 AM Gavin Shan <gshan@redhat.com> wrote:
>> On 6/15/21 12:26 PM, Alexander Duyck wrote:
>>> On Mon, Jun 14, 2021 at 4:03 AM David Hildenbrand <david@redhat.com> wrote:
>>>> On 11.06.21 09:44, Gavin Shan wrote:
>>>>> On 6/1/21 6:01 PM, David Hildenbrand wrote:
>>>>>> On 01.06.21 05:33, Gavin Shan wrote:

[...]

>>>
>>> Yes, generally reporting pages comes at a fairly high cost so it is
>>> important to find the right trade-off between the size of the page and
>>> the size of the batch of pages being reported. If the size of the
>>> pages is reduced it maybe important to increase the batch size in
>>> order to avoid paying too much in the way of overhead.
>>>
>>> The other main reason for holding to pageblock_order on x86 is to
>>> avoid THP splitting. Anything smaller than pageblock_order will
>>> trigger THP splitting which will significantly hurt the performance of
>>> the VM in general as it forces it down to order 0 pages.
>>>
>>
>> Alex, Thanks for your reply and sorry for taking your time to this
>> discussion.
>>
>> Could you please confirm it's PAGE_REPORTING_CAPACITY or the budget
>> used in page_reporting_cycle() when you're talking about "batch"?
> 
> Yes, when I refer to batch it is how many pages we are processing in a
> single call. That is limited by PAGE_REPORTING_CAPACITY.
> 

Alex, It seems the batch mechanism is to avoid heavy contention on
zone's lock if I'm correct? The current design is to report all pages
in the corresponding free list within 17 calls to page_reporting_cycle().
Could you please explain why 17 was chosen? :)

    budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);

It's related to the magic number ("16"). With the threshold is decreased,
for example from 512MB to 2MB on arm64 with 64KB base page size, more
page reporting activities will be introduced. From this regard, it's
reasonable to increase the magic number as well, so that more calls
to page_reporting_cycle() to avoid the contention to zone's lock.

If you agree, I will come up with something, similar to what we do for
the threshold. However, I'm not sure if 64 is reasonable cycles to have
for this particular case.

    in arch/arm64/include/asm/page.h
       #ifdef CONFIG_ARM64_64K_PAGES
       #define PAGE_REPORTING_ORDER    5
       #define PAGE_REPORTING_CYCLES   64
       #endif
    in mm/page_reporting.h
       #ifndef PAGE_REPORTING_CYCLES
       #define PAGE_REPORTING_CYCLES   16
       #endif
    in mm/page_reporting.c::page_reporting_cycle()
       budget = DIV_ROUND_UP(area->nr_free,
                             PAGE_REPORTING_CAPACITY * PAGE_REPORTING_CYCLES);

Thanks,
Gavin

