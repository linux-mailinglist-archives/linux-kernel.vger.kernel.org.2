Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE91A3F1F14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhHSR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233940AbhHSR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629393992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7x054qq8V6avmtMKVIeUs652PUiEW3OxCnV/9CBplM=;
        b=NrBewN4eevmbTYX7Zo0eW0FVGIXc7511FDptMlwibtvBhixtknywiMx6zCy6HAhVHBAtRT
        an0s/zPpGxLkwBRFalbyZqieVI3JZq0AYvic7ZwEVTSFNOyl0x8nGJHR2Bos3m/eFGZ1Ol
        u7RTv+fVdoMEo0E8iIfzjJBVv22y5/A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-mBwcKfD-POWmZDMxlBgOnA-1; Thu, 19 Aug 2021 13:26:31 -0400
X-MC-Unique: mBwcKfD-POWmZDMxlBgOnA-1
Received: by mail-wm1-f71.google.com with SMTP id 204-20020a1c04d5000000b002e70859ef00so1586868wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E7x054qq8V6avmtMKVIeUs652PUiEW3OxCnV/9CBplM=;
        b=IrcBxiM2MWMme9zVqH2b19EtLrsUOkbuFgi9z0KCa4eiEQDEuKUYgesxA3/8/al0u/
         T2pT9ouBw1b7QZarmyn+INuCRYKqMH7Y3RbOxtY+c9sT8upfxRohV+058WPv0Zs0bmRB
         II5/xM3jN6pq29dBw11EneEpLzXasQBMw62262X8VT3U31+kSgB6MBH51GoG3MlNkvgR
         NAh0GQT3Ey2Bi45ykz7i7TWiBqY1UYJSLRUaMbKym9lzZ9FcWrwhomdPWeemlWUHGWXw
         CQoMSJMif4dhNbyHuszW57doMH8Rd+c0g4Nrke/Prz42+uzBNSxDKuzqo2kfF4jbFBbT
         YylQ==
X-Gm-Message-State: AOAM533cOszwcoVgvbnuaBya26pgBQsiSf2Gy9nKap7xckPl1db3Pl3u
        gUGwlci+CNYegzPY1l3+bzDruTXeCzKwxOlba5i/w2MIEsnFgX8T1NF+Ftkd+3p5b24VlwAmOva
        XgPcJdhypdOK+h7xp6Wcvum8V
X-Received: by 2002:a7b:c396:: with SMTP id s22mr14417184wmj.131.1629393989714;
        Thu, 19 Aug 2021 10:26:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1WUgjTvxTf7y4kGr5oXSPThPdnTL77kevl6jQA7VDg8kx0wbAuM0V3R/BTrKjYAsxbeBKPw==
X-Received: by 2002:a7b:c396:: with SMTP id s22mr14417174wmj.131.1629393989498;
        Thu, 19 Aug 2021 10:26:29 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id z17sm3477703wrr.66.2021.08.19.10.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 10:26:29 -0700 (PDT)
Subject: Re: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     Peter Xu <peterx@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>
References: <20210807032521.7591-1-peterx@redhat.com>
 <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com> <YRvtPrPmAorX+KY5@t490s>
 <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com> <YRwa6+jx5PukCn53@t490s>
 <c29a9994-8fa3-d36d-d973-f99314c243cf@redhat.com>
 <7F645772-1212-4F0D-88AF-2569D5BBC2CD@nutanix.com>
 <6ab58270-c487-2a56-b522-ea5100edb13c@redhat.com>
 <0A4C4E37-88C9-4490-9D8B-6990D805F447@nutanix.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <5766d353-6ff8-fdfa-f8f9-764e8de9b5aa@redhat.com>
Date:   Thu, 19 Aug 2021 19:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0A4C4E37-88C9-4490-9D8B-6990D805F447@nutanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.21 16:54, Tiberiu Georgescu wrote:
> 
>> On 18 Aug 2021, at 19:13, David Hildenbrand <david@redhat.com> wrote:
>>
>>>>
>>>>> I'm now wondering whether for Tiberiu's case mincore() can also be used.  It
>>>>> should just still be a bit slow because it'll look up the cache too, but it
>>>>> should work similarly like the original proposal.
>>> I am afraid that the information returned by mincore is a little too vague to be of better help, compared to what the pagemap should provide in theory. I will have a look to see whether lseek on
>>> proc/map_files works as a "PM_SWAP" equivalent. However, the swap offset would still be missing.
>>
>> Well, with mincore() you could at least decide "page is present" vs. "page is swapped or not existent". At least for making pageout decisions it shouldn't really matter, no? madvise(MADV_PAGEOUT) on a hole is a nop.
> 
> I think you are right. In the optimisation we first presented, we should be able to
> send the madvise(MADV_PAGEOUT) call even if the page is none quite safely
> and get the wanted behaviour. Also, the "is_present" or "is_swap_or_none"
> question can be answered by the current pagemap too. Nice catch.
> 
> However, not all use cases are the same. AFAIK, there is still no way to figure
> out whether a shared page is swapped out or none unless it is directly
> read/accessed after a pagemap check. Bringing a page into memory to check
> if it previously was in swap does not seem ideal.

Well, you can lseek() to remove all the holes and use mincore() to 
remove all in-memory pages. You're left with the swapped ones. Not the 
most efficient interface maybe, but there is a way :)

> 
> Also, we still have no mechanism to retrieve the swap offsets of shmem pages
> AFAIK. There is one more QEMU optimisation we are working on that requires
> these mappings available outside of kernel space.

How exactly would the swap offset really help? IMHO that's a kernel 
internal that shouldn't be of any value to user space -- it's merely for 
debugging purposes. But I'd love to learn details.

[...]

>> If it has an fd and we can punch that into syscalls, we should much rather use that fd to lookup stuff then going via process page tables -- if possible of course (to be evaluated, because I haven't looked into the CRIU details and how they use lseek with anonymous shared memory).
> 
> I found out that it is possible to retrieve the fds of shmem/tmpfs file allocations
> using proc/pid/map_files, which is neat. Still, CRIU does not seem to care
> whether a page is swapped out or just empty, only if it is present on page cache.
> The holes that lseek finds would not be able to infer this difference, AFAIK. Will
> test the behaviour to make sure.

CRIU wants to migrate everything. lseek() gives you the definitive 
answer what needs migration -- if it's swapped out or resident. Just 
skip the holes.

-- 
Thanks,

David / dhildenb

