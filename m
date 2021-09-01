Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56B03FD4F3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbhIAILg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242766AbhIAILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630483839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUY5Z2Iv6OS7sO/OYd+l0I4AgGgtwOSQSuYxV74fDgk=;
        b=iXl14elgH+vCszThOHQZTd5BGDR6ackTT2eLMExLhtFFuw+UVoVlackAi5JA/dTadrC17P
        G0Y8ISyFvjnZUyjzEVsR9opsq7hHrfeUAKCrvCPID2RulXUQSZAkLf2bvuCyqEG8VuCKec
        BHmyWpIMwOvxwjczdtze92gQhtd9fWk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-feqwScpkOsKLGqvISRaRKg-1; Wed, 01 Sep 2021 04:10:37 -0400
X-MC-Unique: feqwScpkOsKLGqvISRaRKg-1
Received: by mail-wm1-f70.google.com with SMTP id f19-20020a1c1f13000000b002e6bd83c344so729500wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 01:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jUY5Z2Iv6OS7sO/OYd+l0I4AgGgtwOSQSuYxV74fDgk=;
        b=mH6UQ7/6HbFteYFJDymJDA3hCGdyl+ZwVBqQtMBu38RfJtXq1pHVg0iU+jhkixC5HT
         R1pikV0V8VsxL4wZga26DAiQDsLMNTZ0ccpwyXXlWxZSbsOzgiEOSE6dC+91+5D/Kfpr
         3JfjeBYhv2FFhZy4phKtf/M7gibw8ez68Thc9oy1m9Ggt3pwFY14vtJnVc9wCVX4JNXc
         K+LHWMuSp/r5tm+kjEK2rADKXkAabljyqC6ixGkanOK5o5+VakFfJ9FMbTa3fFeiVy6v
         9pm3r/HXqjmu4l72OaHex2eyyevJvNrM7yYPEbIkG+ZmdkqR06+hg0Dw625HBzTZSlTU
         H93A==
X-Gm-Message-State: AOAM532U/0V1kpUHMA7xG1rY8ZHUkHs574Rlp28yqHUQANf7cDcF9N/p
        DdWBa2Uvh5qG0lJo3cNKgMZSEpIWXp5oQIs19AZ3MYdLlJ8ED+/PZSSBkMhzUKwL6oiIxlzo67n
        jQgcnDgiifvWW+xd6oWWqfeEz
X-Received: by 2002:a5d:4844:: with SMTP id n4mr35936867wrs.191.1630483836514;
        Wed, 01 Sep 2021 01:10:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoqaZqBTvVMe5dKfHcnx0bDUHB7P+ekcTkmSMATj4BEgp7WPgiI8UHBNpNryCD8J3Pkyf15A==
X-Received: by 2002:a5d:4844:: with SMTP id n4mr35936849wrs.191.1630483836354;
        Wed, 01 Sep 2021 01:10:36 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id m186sm4747276wme.48.2021.09.01.01.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 01:10:35 -0700 (PDT)
Subject: Re: [PATCH 5/6] mm/page_alloc.c: avoid accessing uninitialized pcp
 page migratetype
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sfr@canb.auug.org.au,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-6-linmiaohe@huawei.com>
 <20210831134311.GG4128@techsingularity.net>
 <877b7043-65c3-5e08-ac89-ad6f10e354b3@redhat.com>
 <f801cd23-6897-53c7-a689-2ade60578d7e@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e7f834ec-5551-07d7-f439-7e20e4345389@redhat.com>
Date:   Wed, 1 Sep 2021 10:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f801cd23-6897-53c7-a689-2ade60578d7e@huawei.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 10:02, Miaohe Lin wrote:
> On 2021/8/31 22:23, David Hildenbrand wrote:
>> On 31.08.21 15:43, Mel Gorman wrote:
>>> On Mon, Aug 30, 2021 at 10:10:50PM +0800, Miaohe Lin wrote:
>>>> If it's not prepared to free unref page, the pcp page migratetype is
>>>> unset. Thus We will get rubbish from get_pcppage_migratetype() and
>>>> might list_del &page->lru again after it's already deleted from the
>>>> list leading to grumble about data corruption.
>>>>
>>>> Fixes: 3dcbe270d8ec ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>
>>> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>>>
>>> This fix is fairly important. Take this patch out and send it on its own
>>> so it gets picked up relatively quickly. It does not belong in a series
>>> that is mostly cosmetic cleanups.
>>
>> I think the commit id is wrong. Shouldn't that be
>>
>> df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
>>
>> ?
>>
> 
> Many thanks for pointing this out.
> 
> I used to save the git log in a file to make life easier. But it seems this leads
> to the old commit id above.
> 
> commit 3dcbe270d8ec57e534f5c605279cdc3ceb1f044a
> Author: Mel Gorman <mgorman@techsingularity.net>
> Date:   Fri Jun 4 14:20:03 2021 +1000
> 
>      mm/page_alloc: avoid conflating IRQs disabled with zone->lock
> 
> git name-rev 3dcbe270d8ec
> 3dcbe270d8ec tags/next-20210604~2^2~196
> 
> vs
> 
> commit df1acc856923c0a65c28b588585449106c316b71
> Author: Mel Gorman <mgorman@techsingularity.net>
> Date:   Mon Jun 28 19:42:00 2021 -0700
> 
>      mm/page_alloc: avoid conflating IRQs disabled with zone->lock
> 
> git name-rev df1acc856923
> df1acc856923 tags/next-20210630~2^2~278
> 
> Their contents are same but with different commit id. The previous one
> could have been git-rebased.
> 

-mm tree commit ids keep changing until patches are upstream. Therefore, 
you can observe changing commit ids in -next. Always use the ones from 
Linus' tree, they are stable.

-- 
Thanks,

David / dhildenb

