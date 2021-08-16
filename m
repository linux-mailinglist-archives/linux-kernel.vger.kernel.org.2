Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554783EDA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhHPQN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhHPQN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629130404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omSfE1i2O/mSMW260UhgiDj/AWHS5s3qHE5PmalCULs=;
        b=Isb3WUPr7euLKooJCyrMjkComkNyFNT9Jw3fniIXw2LJcOyZPVhnyv7ugh2sl0Wrp8Cwuk
        W4antT8l7xXWpC9oiHkubelSXq4fSimULzH73j2R82Verw8PpCy6WeSoMZR40uzvPaLNjA
        F0LScVM+x54VWYMbzKSzkRdDMnvI1UA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-9HrOTVMpN9KIeiMcnhblfA-1; Mon, 16 Aug 2021 12:13:23 -0400
X-MC-Unique: 9HrOTVMpN9KIeiMcnhblfA-1
Received: by mail-wm1-f72.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so127414wmr.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=omSfE1i2O/mSMW260UhgiDj/AWHS5s3qHE5PmalCULs=;
        b=qA+5zM1K2tBorzorSkZC0i4nsGs9n007We8+U3GonwPGKcz1ZKkevMBc+cLdp5q56r
         nxxNTJFytqeb8jpET2meDCGaMUMTx8AV6a7WiFoGnkfO0BXE557AFNM20Fy9zVHEIgri
         7bHHSM2C8ZQA27WabJTmU9YU7wZQvTMpCZDwXNzdnWkHZhh19OyBZVxaUAM96lmRL4yy
         zT6hDBlPh7wMt8XpRU0AtxosWHWVCULDByywWSbALb2RZTi0t7F9LskD11NfZBULSt7X
         QwenilkGSW1jI8feEpPUX9RK2Lvi24zrTT+jyt8kSuUxLzL7rU7odJiA0c2uj9JqUgXg
         bpTw==
X-Gm-Message-State: AOAM533YDmgT3RKWs/FkQS21umr5R58Jp2TsIJQverYws4y0Nrcb7vWt
        Dm7zpCX635qyuIiwb0nkmAhs89oDSPARfNki5MxheiOLXmydyI+8hl5NKxXFv5SB7oaMFpmzN2l
        opmBRUjyMCiJY8wKIop62CWQI
X-Received: by 2002:a7b:c2f0:: with SMTP id e16mr16018851wmk.144.1629130402169;
        Mon, 16 Aug 2021 09:13:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX5+2pq1udnYpXDWSnKOhLd1QNqtk4jCRZuoif26U3VsJumuh0AbpdtyZUzhe9vTG+rdBF0w==
X-Received: by 2002:a7b:c2f0:: with SMTP id e16mr16018840wmk.144.1629130401978;
        Mon, 16 Aug 2021 09:13:21 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id k14sm11425807wri.46.2021.08.16.09.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:13:21 -0700 (PDT)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <YRpVHnr55LpQQvTb@casper.infradead.org>
 <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
 <YRpeHnP7QDNJRA8Y@casper.infradead.org>
 <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
 <YRpo4EAJSkY7hI7Q@casper.infradead.org>
 <40bad572-501d-e4cf-80e3-9a8daa98dc7e@redhat.com>
 <YRp169xvwB3j0rpD@casper.infradead.org>
 <3ce1f52f-d84d-49ba-c027-058266e16d81@redhat.com>
 <YRp4+EmohNoxzv2x@casper.infradead.org>
 <e6a31927-8f93-22af-2d5a-9d80578e9317@redhat.com>
 <YRqLc2W1P77tiSqj@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <97ed86a0-9fac-3dbc-0f9e-d669484c9485@redhat.com>
Date:   Mon, 16 Aug 2021 18:13:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRqLc2W1P77tiSqj@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 17:59, Matthew Wilcox wrote:
> On Mon, Aug 16, 2021 at 05:01:44PM +0200, David Hildenbrand wrote:
>> On 16.08.21 16:40, Matthew Wilcox wrote:
>>> On Mon, Aug 16, 2021 at 04:33:09PM +0200, David Hildenbrand wrote:
>>>>>> I did not follow why we have to play games with MAP_PRIVATE, and having
>>>>>> private anonymous pages shared between processes that don't COW, introducing
>>>>>> new syscalls etc.
>>>>>
>>>>> It's not about SHMEM, it's about file-backed pages on regular
>>>>> filesystems.  I don't want to have XFS, ext4 and btrfs all with their
>>>>> own implementations of ARCH_WANT_HUGE_PMD_SHARE.
>>>>
>>>> Let me ask this way: why do we have to play such games with MAP_PRIVATE?
>>>
>>> : Mappings within this address range behave as if they were shared
>>> : between threads, so a write to a MAP_PRIVATE mapping will create a
>>> : page which is shared between all the sharers.
>>>
>>> If so, that's a misunderstanding, because there are no games being played.
>>> What Khalid's saying there is that because the page tables are already
>>> shared for that range of address space, the COW of a MAP_PRIVATE will
>>> create a new page, but that page will be shared between all the sharers.
>>> The second write to a MAP_PRIVATE page (by any of the sharers) will not
>>> create a COW situation.  Just like if all the sharers were threads of
>>> the same process.
>>>
>>
>> It actually seems to be just like I understood it. We'll have multiple
>> processes share anonymous pages writable, even though they are not using
>> shared memory.
>>
>> IMHO, sharing page tables to optimize for something kernel-internal (page
>> table consumption) should be completely transparent to user space. Just like
>> ARCH_WANT_HUGE_PMD_SHARE currently is unless I am missing something
>> important.
>>
>> The VM_MAYSHARE check in want_pmd_share()->vma_shareable() makes me assume
>> that we really only optimize for MAP_SHARED right now, never for
>> MAP_PRIVATE.
> 
> It's definitely *not* about being transparent to userspace.  It's about
> giving userspace new functionality where multiple processes can choose
> to share a portion of their address space with each other.  What any
> process changes in that range changes, every sharing process sees.
> mmap(), munmap(), mprotect(), mremap(), everything.

Oh okay, so it's actually much more complicated and complex than I 
thought. Thanks for clarifying that! I recall virtiofsd had similar 
requirements for sharing memory with the QEMU main process, I might be 
wrong.

"existing shared memory area" and your initial page table example made 
me assume that we are simply dealing with sharing page tables of MAP_SHARED.

It's actually something like a VMA container that you share between 
processes. And whatever VMAs are currently inside that VMA container is 
mirrored to other processes. I assume sharing page tables could actually 
be an implementation detail, especially when keeping MAP_PRIVATE 
(confusing in that context!) and other features that will give you 
surprises (uffd) out of the picture.

-- 
Thanks,

David / dhildenb

