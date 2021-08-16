Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36BE3ED430
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhHPMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235467AbhHPMnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629117747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gBv/Q8Q/QcULcj4Fd/NoN5uynO5Hm+7XVaOKGJhj8w=;
        b=Rt65P2d3UxUovW4/s8Xj7VDWhp08jfmG9gnndS3ngeD03UEhqxL377rnl8/cf3j6mW/E3x
        VGsyYQ7KU8rjf/LpcRjo64/g0r4lghOJdGum06jGkWBFuyRQ2FdTLzDmgt7scRar6BPVmu
        pL4Wmi2ZQ1xPX4wS/ZEOgr+Td0SAN8c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-OMFoNMMxMNC568AqAAaaQg-1; Mon, 16 Aug 2021 08:42:26 -0400
X-MC-Unique: OMFoNMMxMNC568AqAAaaQg-1
Received: by mail-wm1-f69.google.com with SMTP id b196-20020a1c80cd0000b02902e677003785so7762211wmd.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+gBv/Q8Q/QcULcj4Fd/NoN5uynO5Hm+7XVaOKGJhj8w=;
        b=WzBqyP/SII4la0HcHhks7BExaT2cKHx14ADgrIB/al3CyOQ3N9p7mYFy9eIZHgtWLV
         rZotEE0x9WoYaRNoZcbU1K4ipSq2k9m6ODYmSrdVXQSMpAfSoLUsKQvtVy5RQ6hLvT8b
         P2EJRg9fQHeoYfwc7u3JooS3d5+xLgxCtetlpCW5BTysNdx4UBfnHTHcBCsn11XbB+or
         qrtI/brnrj0cjoeFhcRoPQZNf4f4oZoVFzfS03fHz83d/6dC1Ee4kmC1PjoZbFZFL79f
         XvqNLB+4+qnfCRFeIEeejPnYiiSJUd2xxcqTYkCnN4W9F3TeGmwNU9bQtG9r85HTQSB3
         m5ZA==
X-Gm-Message-State: AOAM530ZTZFGUto9EPLlEzUvHGigoR//ge0RgAm2BqFOMx9ealNo9Lp5
        /Z1bkiCWetoOf6hDQn5jkKAiBRNvDnX078X1B/BXZ08r7yhiby8I2fA2NfIRJ+XdnQkeK79NuBm
        UEliA9e1OiNqVQFxLXP7QCktm
X-Received: by 2002:a7b:c2f0:: with SMTP id e16mr15153404wmk.144.1629117745523;
        Mon, 16 Aug 2021 05:42:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5WHvk1HuKVYAo9iZE9tGW9zzdilQKuTMoH0v+h7IZddDmuuTDSgukHZKbwBsTEVhiDvnRNQ==
X-Received: by 2002:a7b:c2f0:: with SMTP id e16mr15153391wmk.144.1629117745334;
        Mon, 16 Aug 2021 05:42:25 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id 6sm10396357wmk.20.2021.08.16.05.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 05:42:24 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
From:   David Hildenbrand <david@redhat.com>
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
Organization: Red Hat
Message-ID: <e37df835-6a00-8e42-3907-c6305c42ea6d@redhat.com>
Date:   Mon, 16 Aug 2021 14:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 14:20, David Hildenbrand wrote:
> On 16.08.21 14:07, Matthew Wilcox wrote:
>> On Mon, Aug 16, 2021 at 10:02:22AM +0200, David Hildenbrand wrote:
>>>> Mappings within this address range behave as if they were shared
>>>> between threads, so a write to a MAP_PRIVATE mapping will create a
>>>> page which is shared between all the sharers. The first process that
>>>> declares an address range mshare'd can continue to map objects in the
>>>> shared area. All other processes that want mshare'd access to this
>>>> memory area can do so by calling mshare(). After this call, the
>>>> address range given by mshare becomes a shared range in its address
>>>> space. Anonymous mappings will be shared and not COWed.
>>>
>>> Did I understand correctly that you want to share actual page tables between
>>> processes and consequently different MMs? That sounds like a very bad idea.
>>
>> That is the entire point.  Consider a machine with 10,000 instances
>> of an application running (process model, not thread model).  If each
>> application wants to map 1TB of RAM using 2MB pages, that's 4MB of page
>> tables per process or 40GB of RAM for the whole machine.
> 
> What speaks against 1 GB pages then?
> 
>>
>> There's a reason hugetlbfs was enhanced to allow this page table sharing.
>> I'm not a fan of the implementation as it gets some locks upside down,
>> so this is an attempt to generalise the concept beyond hugetlbfs.
> 
> Who do we account the page tables to? What are MADV_DONTNEED semantics?
> Who cleans up the page tables? What happens during munmap? How does the
> rmap even work? How to we actually synchronize page table walkers?
> 
> See how hugetlbfs just doesn't raise these problems because we are
> sharing pages and not page tables?

I found what you were referring to: CONFIG_ARCH_WANT_HUGE_PMD_SHARE

I was not aware that we have such a monstrosity in the kernel.

-- 
Thanks,

David / dhildenb

