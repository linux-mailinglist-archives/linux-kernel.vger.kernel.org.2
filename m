Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B43B3ED903
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhHPOds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231419AbhHPOdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629124393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s0HlfQDZT3zdpybiMLoLwjOV9/aqL+zi+Rs7ejBw+yM=;
        b=W52WaA4czgmrVBh+W9u8GO1lqxCKQDqCnp1MpBxLOf9U/USsGT55Ce1WgVH7HQB4vrx1TY
        LBzq3rPuBOlE8p5E+HF2bfB3Gdn8cdcjF5OyUBh9G76fbnEGNoe5SxB+p3VG8ag5OsVrnM
        QA+GwzJwR1PsNrcdJCiKWMVLsaqjK5w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-QnHl47ZmNH-sDaF11jTd9w-1; Mon, 16 Aug 2021 10:33:11 -0400
X-MC-Unique: QnHl47ZmNH-sDaF11jTd9w-1
Received: by mail-wr1-f72.google.com with SMTP id q4-20020a05600000c400b00156d811312aso4999wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=s0HlfQDZT3zdpybiMLoLwjOV9/aqL+zi+Rs7ejBw+yM=;
        b=dSkqmQU/bVdtJb97pCL8RcgCYguMTnR4u2BBbvS/6udIfqDXulownNpGW6a8wlpRDJ
         F0fqvqTNkjVrlzPgeVWd27ZDVFaJ33d32NmMaUlYtgTgxc/qujHlBOZ6Ul46eF+QMzF2
         LWFE9oxzhsTr9uIhI5i9H/OvQ0bTfCtJTuQydrEEukvvN8eVG6teWLJ4jfB8MvsPAtGT
         yVTKx7V8vPbdyExQmVclFzHE2dz+O5/5xu+tNzh2K1uxkH+m2IWJnkZSvZMlqCzmZu5H
         eUWA0EZP0ElPWjttV2D9ZwW2i8YDf4AlJP8jHCIpf2RG0YxRFJ6qBK64TsYC1X7NV4+g
         SJBg==
X-Gm-Message-State: AOAM532U/QKYi/kshJO/K0fqRzIjia8lrmhMFcmtyTwQ2XjXrhW5U3P8
        iVpi7baedzky16Gts4rp+AmWoddzsGklMtXCz520r6ZmQ3bTMP72l9eUaphG8gXGbh7MedO3t3j
        HhDS/1gXdmzkrya7/v0Qo2tJT
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr15814190wmf.64.1629124390609;
        Mon, 16 Aug 2021 07:33:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1nlhS40F7oJL4sXwvMcpvPWdBw39MMkTdr4yytD4CKAdbIbkWVIxnDhGxRopGmsKiE7hCZg==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr15814174wmf.64.1629124390440;
        Mon, 16 Aug 2021 07:33:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id c190sm10547273wma.21.2021.08.16.07.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 07:33:10 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
 <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
 <YRpeHnP7QDNJRA8Y@casper.infradead.org>
 <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
 <YRpo4EAJSkY7hI7Q@casper.infradead.org>
 <40bad572-501d-e4cf-80e3-9a8daa98dc7e@redhat.com>
 <YRp169xvwB3j0rpD@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3ce1f52f-d84d-49ba-c027-058266e16d81@redhat.com>
Date:   Mon, 16 Aug 2021 16:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRp169xvwB3j0rpD@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 16:27, Matthew Wilcox wrote:
> On Mon, Aug 16, 2021 at 04:10:28PM +0200, David Hildenbrand wrote:
>>>>> Until recently, the CPUs only having 4 1GB TLB entries.  I'm sure we
>>>>> still have customers using that generation of CPUs.  2MB pages perform
>>>>> better than 1GB pages on the previous generation of hardware, and I
>>>>> haven't seen numbers for the next generation yet.
>>>>
>>>> I read that somewhere else before, yet we have heavy 1 GiB page users,
>>>> especially in the context of VMs and DPDK.
>>>
>>> I wonder if those users actually benchmarked.  Or whether the memory
>>> savings worked out so well for them that the loss of TLB performance
>>> didn't matter.
>>
>> These applications are extremely performance sensitive (i.e., RT workloads),
> 
> "real time does not mean real fast".  it means predictable latency.

I know, but that doesn't explain why you would use 2 MB vs 1 GiB.

(most of these applications want also a low predictable latency)

> 
>>>> I will rephrase my previous statement "hugetlbfs just doesn't raise these
>>>> problems because we are special casing it all over the place already". For
>>>> example, not allowing to swap such pages. Disallowing MADV_DONTNEED. Special
>>>> hugetlbfs locking.
>>>
>>> Sure, that's why I want to drag this feature out of "oh this is a
>>> hugetlb special case" and into "this is something Linux supports".
>>
>> I would have understood the move to optimize SHMEM internally - similar to
>> how we seem to optimize hugetlbfs SHMEM right now internally. (although
>> sharing page tables for shmem can still be quite tricky)
>>
>> I did not follow why we have to play games with MAP_PRIVATE, and having
>> private anonymous pages shared between processes that don't COW, introducing
>> new syscalls etc.
> 
> It's not about SHMEM, it's about file-backed pages on regular
> filesystems.  I don't want to have XFS, ext4 and btrfs all with their
> own implementations of ARCH_WANT_HUGE_PMD_SHARE.

Let me ask this way: why do we have to play such games with MAP_PRIVATE?

-- 
Thanks,

David / dhildenb

