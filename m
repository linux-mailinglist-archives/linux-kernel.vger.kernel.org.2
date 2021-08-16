Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5E3ED77E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhHPNeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26134 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241208AbhHPNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629120281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fsd158OY566OjNuqnho/MiPw3AgTcPdq2DX43UPAUYo=;
        b=B4nHQjrlBiiOLP8Fgz5LiDEJsxuGukYK9M6eRrT4LzXFGeNA20VlMlCgbzglaWdpki/MJr
        S5Le4EpEKMpALYF5rJTj4Y2PROjKmXmiCWnyJZmL7LUKRWH5/M1wikI1vruv3kVkbdgmdW
        ZhI/5wdmZDBZKe/+BMmnGYPDmBMM1VQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-yirRg8O0MSaNE4WjarkYlg-1; Mon, 16 Aug 2021 09:24:40 -0400
X-MC-Unique: yirRg8O0MSaNE4WjarkYlg-1
Received: by mail-wr1-f71.google.com with SMTP id a5-20020adffac5000000b00156c5929fadso714036wrs.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Fsd158OY566OjNuqnho/MiPw3AgTcPdq2DX43UPAUYo=;
        b=k/E7kmCnE46XEFq1EAUJTHwkBkWstLEnHUmxoOPmV5X32QXAnWhu+cY1VzdTCIrHcf
         X8sRCQk53ntCaUYgLpYwKCUJgEcOKn10dRThwEgNjrV0fx/gOr+2jmyQMTN8ztt9+uYl
         fMdaU/TO3gW/N2bsD5VIO+5AWhIYcnH5sDhV8JYLoxOKxhSfpm6HAQ0fi/QrSS7JWD0m
         rHgqmlEqsCpD+58Sp6s7eIfBxCDxSmBc2CZz8w960Tci8eV8MQGXaB9123lMLo9bNyAT
         T7K4p3Kx4/PX+trAtz2OKK4vjPfdSHp/Fug7PNahtMxo6KTUF18cQo8IdCnTTVb+OxpW
         OoBQ==
X-Gm-Message-State: AOAM530J6UvZgT+pFIyW2dVYtlFZ0kbwu8cfKoi/ZIAU06yD5AWFFCy9
        SAflocUTKTexHsQYH8oGFnSe3FuH+oigVUJzvx+5EohaqtAuK6i4VIPss8ReAT42fo74EiNZxya
        goG/6bnoNgtWA1kUzlCu4nB2K
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr396419wme.106.1629120279534;
        Mon, 16 Aug 2021 06:24:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+zn8Y/sVRuv+LI4mi0Apb9QM43FB5cReCM9GAf2si0PXlT7CKP2qZlhSorxCbG7zUjTBozQ==
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr396403wme.106.1629120279364;
        Mon, 16 Aug 2021 06:24:39 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id b12sm13924688wrx.72.2021.08.16.06.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 06:24:38 -0700 (PDT)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
 <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
 <YRpeHnP7QDNJRA8Y@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
Date:   Mon, 16 Aug 2021 15:24:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRpeHnP7QDNJRA8Y@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 14:46, Matthew Wilcox wrote:
> On Mon, Aug 16, 2021 at 02:20:43PM +0200, David Hildenbrand wrote:
>> On 16.08.21 14:07, Matthew Wilcox wrote:
>>> On Mon, Aug 16, 2021 at 10:02:22AM +0200, David Hildenbrand wrote:
>>>>> Mappings within this address range behave as if they were shared
>>>>> between threads, so a write to a MAP_PRIVATE mapping will create a
>>>>> page which is shared between all the sharers. The first process that
>>>>> declares an address range mshare'd can continue to map objects in the
>>>>> shared area. All other processes that want mshare'd access to this
>>>>> memory area can do so by calling mshare(). After this call, the
>>>>> address range given by mshare becomes a shared range in its address
>>>>> space. Anonymous mappings will be shared and not COWed.
>>>>
>>>> Did I understand correctly that you want to share actual page tables between
>>>> processes and consequently different MMs? That sounds like a very bad idea.
>>>
>>> That is the entire point.  Consider a machine with 10,000 instances
>>> of an application running (process model, not thread model).  If each
>>> application wants to map 1TB of RAM using 2MB pages, that's 4MB of page
>>> tables per process or 40GB of RAM for the whole machine.
>>
>> What speaks against 1 GB pages then?
> 
> Until recently, the CPUs only having 4 1GB TLB entries.  I'm sure we
> still have customers using that generation of CPUs.  2MB pages perform
> better than 1GB pages on the previous generation of hardware, and I
> haven't seen numbers for the next generation yet.

I read that somewhere else before, yet we have heavy 1 GiB page users, 
especially in the context of VMs and DPDK.

> 
>>> There's a reason hugetlbfs was enhanced to allow this page table sharing.
>>> I'm not a fan of the implementation as it gets some locks upside down,
>>> so this is an attempt to generalise the concept beyond hugetlbfs.
>>
>> Who do we account the page tables to? What are MADV_DONTNEED semantics? Who
>> cleans up the page tables? What happens during munmap? How does the rmap
>> even work? How to we actually synchronize page table walkers?
>>
>> See how hugetlbfs just doesn't raise these problems because we are sharing
>> pages and not page tables?
> 
> No, really, hugetlbfs shares page tables already.  You just didn't
> notice that yet.

So, it only works for hugetlbfs in case uffd is not in place (-> no 
per-process data in the page table) and we have an actual shared 
mappings. When unsharing, we zap the PUD entry, which will result in 
allocating a per-process page table on next fault.

I will rephrase my previous statement "hugetlbfs just doesn't raise 
these problems because we are special casing it all over the place 
already". For example, not allowing to swap such pages. Disallowing 
MADV_DONTNEED. Special hugetlbfs locking.

-- 
Thanks,

David / dhildenb

