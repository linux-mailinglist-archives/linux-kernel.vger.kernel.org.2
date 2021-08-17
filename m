Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39693EF241
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhHQSuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbhHQSt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629226165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baYwYYkZDyG6gY72jjiG+by0VQ35N5hAyRH+FgVaEbw=;
        b=HlL7yhMjaW0kprEVvdEtfHmBsA8ixoSnXuaEgeD848mxBTSqJS7NFinsh82nexhSKgV5V2
        GxEHSpzps16ncBAXVjgiA5OrlYttsp6rM2NSLosG4fIo5K/ztPgPBTckFKBLe/bsOx96lO
        B+tVA6ZBy4A9TYNyt9uNH2HKl2Zftrw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-x1KMXHPrObCxMvuGK-CTeg-1; Tue, 17 Aug 2021 14:49:22 -0400
X-MC-Unique: x1KMXHPrObCxMvuGK-CTeg-1
Received: by mail-wr1-f72.google.com with SMTP id r17-20020adfda510000b02901526f76d738so6951076wrl.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=baYwYYkZDyG6gY72jjiG+by0VQ35N5hAyRH+FgVaEbw=;
        b=aGKfvMFyetunb5hjZWh6QeJ0KZgOs77HJuIIvgwevkDU82lD15UA7q39VlkU9Zx1Hc
         KkzARTzW7VH8LdNdd14zjjqg/2qAwBkLL32s2xQFOLLx96JKuCspaNi7v6WY4yqsEVLP
         fWX9EZawXeV9PbtWSpkKvIyUg/hVoTpWrd9T824BSIa/T9U54qQE4H+5v0AxY5h7yjsy
         Air7upgRL0zJop1fKv5ajaBNDwKS+bhg2tPdTkdhfKANLdYEltAb2ThWCLFY/r7p6txd
         SUBwuMNQCi8O7oO2kJPaDypfbwYM8+BPpR6T/086UsA3c4r4LnzNrEGaoVf0jcpFFOY6
         5A/w==
X-Gm-Message-State: AOAM531j4tE8Hbi3QMmYUvRJKCI38LBjeQRA17rvF7n7jDwZ5TlSiMK7
        EmnbNh/46iORaKnHnL8r6vZyiDImNKjjAbOXIADcmc9cBikOW36oK+1ha5mTQt2aZfP3y/VFngV
        b0fBibMhDTFghteZxLujiPqjW
X-Received: by 2002:adf:df0c:: with SMTP id y12mr5957303wrl.155.1629226161209;
        Tue, 17 Aug 2021 11:49:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywbJlhbKf8esflBDE7aeIHfrny+AAJ7FUGF98cVme5E3Dhu5GWJJ9GvRZorl8a0OdPuTP8SQ==
X-Received: by 2002:adf:df0c:: with SMTP id y12mr5957284wrl.155.1629226160974;
        Tue, 17 Aug 2021 11:49:20 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c6.dip0.t-ipconnect.de. [91.12.101.198])
        by smtp.gmail.com with ESMTPSA id d18sm3560117wrb.16.2021.08.17.11.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 11:49:20 -0700 (PDT)
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <f19bfed3-be85-114b-7a8e-72bef58cb74f@redhat.com>
 <b4799d79-7966-90ad-72d9-97e9deeec6da@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <5f55d761-1e29-bca3-4ca5-4015f91c7802@redhat.com>
Date:   Tue, 17 Aug 2021 20:49:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b4799d79-7966-90ad-72d9-97e9deeec6da@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.21 18:19, Mike Kravetz wrote:
> On 8/17/21 12:30 AM, David Hildenbrand wrote:
>> On 17.08.21 03:46, Andrew Morton wrote:
>>> On Mon, 16 Aug 2021 17:46:58 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>>>> It really is a ton of new code.  I think we're owed much more detail
>>>>> about the problem than the above.  To be confident that all this
>>>>> material is truly justified?
>>>>
>>>> The desired functionality for this specific use case is to simply
>>>> convert a 1G huegtlb page to 512 2MB hugetlb pages.  As mentioned
>>>>
>>>> "Converting larger to smaller hugetlb pages can be accomplished today by
>>>>    first freeing the larger page to the buddy allocator and then allocating
>>>>    the smaller pages.  However, there are two issues with this approach:
>>>>    1) This process can take quite some time, especially if allocation of
>>>>       the smaller pages is not immediate and requires migration/compaction.
>>>>    2) There is no guarantee that the total size of smaller pages allocated
>>>>       will match the size of the larger page which was freed.  This is
>>>>       because the area freed by the larger page could quickly be
>>>>       fragmented."
>>>>
>>>> These two issues have been experienced in practice.
>>>
>>> Well the first issue is quantifiable.  What is "some time"?  If it's
>>> people trying to get a 5% speedup on a rare operation because hey,
>>> bugging the kernel developers doesn't cost me anything then perhaps we
>>> have better things to be doing.
>>>
>>> And the second problem would benefit from some words to help us
>>> understand how much real-world hurt this causes, and how frequently.
>>> And let's understand what the userspace workarounds look like, etc.
>>>
>>>> A big chunk of the code changes (aprox 50%) is for the vmemmap
>>>> optimizations.  This is also the most complex part of the changes.
>>>> I added the code as interaction with vmemmap reduction was discussed
>>>> during the RFC.  It is only a performance enhancement and honestly
>>>> may not be worth the cost/risk.  I will get some numbers to measure
>>>> the actual benefit.
>>
>> If it really makes that much of a difference code/complexity wise, would it make sense to just limit denote functionality to the !vmemmap case for now?
>>
> 
> Handling vmemmap optimized huge pages is not that big of a deal.  We
> just use the existing functionality to populate vmemmap for the page
> being demoted, and free vmemmap for resulting pages of demoted size.
> 
> This obviously is not 'optimal' for demote as we will allocate more
> vmemmap pages than needed and then free the excess pages.  The complex
> part is not over allocating vmemmap and only sparsely populating vmemmap
> for the target pages of demote size.  This is all done in patches 6-8.
> I am happy to drop these patches for now.  The are the most complex (and
> ugly) of this series.  As mentioned, they do not provide any additional
> functionality.
> 

Just looking at the diffstat, that looks like a good idea to me :)

-- 
Thanks,

David / dhildenb

