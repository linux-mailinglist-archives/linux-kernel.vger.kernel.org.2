Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD023D13EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhGUPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235437AbhGUPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626884386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7y5PxxinjSuGtzbBWLAF5HzlJtIegTZwJLIEdYSHihE=;
        b=O+YdnPMEf+LOFmo7qokEgXPhZ84r/8KXAxrn9b9ayYAaP8j+++6T7Vg35OJIPlvolvZ58e
        iFTeiiY6sYKkIANP2knC2Kd15ZkA0u96VCCiFnLtRRqw5Prh5OVU8rh9lqaiXLAHKn+0L/
        1/aQFMu02kKc/ZiZmAK2UmV67CCjAfc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-psBr-MP1NI-n9JcaU3RVoA-1; Wed, 21 Jul 2021 12:19:45 -0400
X-MC-Unique: psBr-MP1NI-n9JcaU3RVoA-1
Received: by mail-wm1-f70.google.com with SMTP id x6-20020a7bc2060000b0290218ad9a8d4aso1221795wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7y5PxxinjSuGtzbBWLAF5HzlJtIegTZwJLIEdYSHihE=;
        b=c6N5DwIPkltqAwA6dWQ6FdmnFCTqRTSki7DFvqHMFEU4LU2U8tFVT0HpzQL+pAXv7Y
         +6nB/JvEowjay0uBiSyu2aMTXwnZAEdaLcjj8ZdArK6GyN3fIt/Xlo5fZRTqdGXN12Jr
         V7uGJi8IF9Lmz12+RgUPWucmDZW0JXRLwmMKDEMzPA/FBhgGQ5pOFDHDpxabvV6wBJhF
         YOQRH3iybg+t47aKxdbi3+mPVLpG9isWr8yoaHQ71MHIzxgNkDuZfejMMwj32Rih3KoS
         DqD8mG4s2EY/FshfzoIdYYOA6Ua5GMnimVMVqCZyf7leX1+/p9hyWW5Valuxf2sYPxav
         D0mQ==
X-Gm-Message-State: AOAM530zbvNCuyGEbtr18n15nJIUk5H5vKXfjCGW0dUvI2FywPOGjNaV
        i9+mGZDOq89hTPYxAtjkOC11A+YPwRf7c6s1O9xr02BSfmccoAYDfDc8jliRi5fMP3stHDVBLJE
        cby31Y2cPMRz+jpLQ4J1xvEYj
X-Received: by 2002:a1c:23d0:: with SMTP id j199mr19604581wmj.176.1626884383932;
        Wed, 21 Jul 2021 09:19:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi2aVJKRRkL7W7lwqE3FHvjYx9QJvQYekUcCXTyn1xROQV5WZPFTYQC7kuJCV/DdCtwoqcEQ==
X-Received: by 2002:a1c:23d0:: with SMTP id j199mr19604543wmj.176.1626884383690;
        Wed, 21 Jul 2021 09:19:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c3.dip0.t-ipconnect.de. [91.12.101.195])
        by smtp.gmail.com with ESMTPSA id n5sm26402169wri.31.2021.07.21.09.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 09:19:43 -0700 (PDT)
To:     Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Peter Xu <peterx@redhat.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "ovzxemul@gmail.com" <ovzxemul@gmail.com>
References: <20210715201422.211004-1-peterx@redhat.com>
 <20210715201651.212134-1-peterx@redhat.com>
 <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com> <YPWiRsNaearMNB2g@t490s>
 <D2FD5D85-BA6D-492E-801F-E5003452DA70@nutanix.com> <YPW8xaejtl68AYCk@t490s>
 <CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Message-ID: <5c3c84ee-02f6-a2af-13b8-5dcf70676641@redhat.com>
Date:   Wed, 21 Jul 2021 18:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.21 16:38, Ivan Teterevkov wrote:
> On Mon, Jul 19, 2021 5:56 PM +0000, Peter Xu wrote:
>> I'm also curious what would be the real use to have an accurate PM_SWAP
>> accounting.  To me current implementation may not provide accurate value but
>> should be good enough for most cases.  However not sure whether it's also true
>> for your use case.
> 
> We want the PM_SWAP bit implemented (for shared memory in the pagemap
> interface) to enhance the live migration for some fraction of the guest
> VMs that have their pages swapped out to the host swap. Once those pages
> are paged in and transferred over network, we then want to release them
> with madvise(MADV_PAGEOUT) and preserve the working set of the guest VMs
> to reduce the thrashing of the host swap.

There are 3 possibilities I think (swap is just another variant of the 
page cache):

1) The page is not in the page cache, e.g., it resides on disk or in a 
swap file. pte_none().
2) The page is in the page cache and is not mapped into the page table. 
pte_none().
3) The page is in the page cache and mapped into the page table. 
!pte_none().

Do I understand correctly that you want to identify 1) and indicate it 
via PM_SWAP?

-- 
Thanks,

David / dhildenb

