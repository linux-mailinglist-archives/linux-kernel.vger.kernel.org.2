Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A7365964
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhDTM7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 08:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231769AbhDTM7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618923538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InC/09SU2jowBshG+H/mXghIo0fijTDczsPvBvuygWs=;
        b=V9HkKsJEs+iXVBZ19m0IwEmBxNHpDWJprZ4tTQq+3jrsa3cNXxYXC8RyXVuV1lUrhM4v78
        6AQq2KLKklcoh/WI0Zkqa1ZnhQwkAUxK6Hcat645vrhZozNU78d23hwYsz93wtCbgyb+wU
        d90+9bmFH2jXpZiuXJN3hOWyh8tQIjM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-uKK6nC9vNCSdozjytsYcnQ-1; Tue, 20 Apr 2021 08:58:56 -0400
X-MC-Unique: uKK6nC9vNCSdozjytsYcnQ-1
Received: by mail-wm1-f71.google.com with SMTP id o18-20020a1ca5120000b02901333a56d46eso1699211wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 05:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=InC/09SU2jowBshG+H/mXghIo0fijTDczsPvBvuygWs=;
        b=F2d2dmFNWubbEFlNFzoJx7UTS4HpxgLwdgRl6zGNlH3JlEClMRMZgi/FnnY3jH4nxG
         Tr5yfxhrowgLeoIriW2mN5olpZw4umCW8hNWny7YF5KvzBsU5rG0hM/MrZJ3Fwu9QPH8
         wrEVmnKjxG6GKdsoO+m4bVM5QlgtTcq2kntn2a48nYpb0ymeZxbOoF/+VCOAxUio0Vvg
         kLAi4RORY1N5EHGeQcdNwkmvCAXUIcePB1SaA0m+OHqq2fdzttq6fwdfaeNRXJu781Vz
         9JXaBRNCwkac1xbYj2jsXu8MQ1XxW/713Xi2RYSc3gAcch/ShFNsGwn+v6qtZE20Dz2f
         GtqQ==
X-Gm-Message-State: AOAM532hXpZzuzr2sA9YP7yiROxldFWFycnbs4MVfG0Q5W7kFnv9YlZK
        ewWNoHjV+G+0B/17vJPm0aHKTw6lRDKJLCik/6RcaHFNJZtCNBsgsp2KfrSSr2GG+/5kUtvtRdW
        phmsREUoAKql8FFyGdPz9zHqv
X-Received: by 2002:a1c:454:: with SMTP id 81mr4372382wme.186.1618923535250;
        Tue, 20 Apr 2021 05:58:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN432Bkl8h0VlShbz+ZgmHfmV79yLlF8E3/1xyjGalQUC9+ROSAJDjYzCWA1CcV6ig2Ye5wQ==
X-Received: by 2002:a1c:454:: with SMTP id 81mr4372354wme.186.1618923534988;
        Tue, 20 Apr 2021 05:58:54 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id x2sm30458360wrg.31.2021.04.20.05.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 05:58:54 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] include/linux/mmzone.h: add documentation for
 pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210420090925.7457-1-rppt@kernel.org>
 <20210420090925.7457-2-rppt@kernel.org>
 <f900f889-f059-7d48-dfc7-145c8cd54cf6@redhat.com>
 <YH7P0J4+1erJK7v5@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <07216f89-369f-0dcc-7bc0-97c204981396@redhat.com>
Date:   Tue, 20 Apr 2021 14:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YH7P0J4+1erJK7v5@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.21 14:57, Mike Rapoport wrote:
> On Tue, Apr 20, 2021 at 11:22:53AM +0200, David Hildenbrand wrote:
>> On 20.04.21 11:09, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> Add comment describing the semantics of pfn_valid() that clarifies that
>>> pfn_valid() only checks for availability of a memory map entry (i.e. struct
>>> page) for a PFN rather than availability of usable memory backing that PFN.
>>>
>>> The most "generic" version of pfn_valid() used by the configurations with
>>> SPARSEMEM enabled resides in include/linux/mmzone.h so this is the most
>>> suitable place for documentation about semantics of pfn_valid().
>>>
>>> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>>    include/linux/mmzone.h | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 47946cec7584..961f0eeefb62 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -1410,6 +1410,17 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>>>    #endif
>>>    #ifndef CONFIG_HAVE_ARCH_PFN_VALID
>>> +/**
>>> + * pfn_valid - check if there is a valid memory map entry for a PFN
>>> + * @pfn: the page frame number to check
>>> + *
>>> + * Check if there is a valid memory map entry aka struct page for the @pfn.
>>> + * Note, that availability of the memory map entry does not imply that
>>> + * there is actual usable memory at that @pfn. The struct page may
>>> + * represent a hole or an unusable page frame.
>>> + *
>>> + * Return: 1 for PFNs that have memory map entries and 0 otherwise
>>> + */
>>>    static inline int pfn_valid(unsigned long pfn)
>>>    {
>>>    	struct mem_section *ms;
>>>
>>
>> I'd rephrase all "there is a valid memory map" to "there is a memory map"
>> and add "pfn_valid() does to indicate whether the memory map as actually
>> initialized -- see pfn_to_online_page()."
>>
>> pfn_valid() means that we can do a pfn_to_page() and don't get a fault when
>> accessing the "struct page". It doesn't state anything about the content.
> 
> Well, I mean valid in the sense you can access the struct page :)
> How about:
> 
> /**
>   * pfn_valid - check if there is a memory map entry for a PFN
>   * @pfn: the page frame number to check
>   *
>   * Check if there is a memory map entry aka struct page for the @pfn and it
>   * is safe to access that struct page; the struct page state may be
>   * uninitialized -- see pfn_to_online_page().
>   *
>   * Note, that availability of the memory map entry does not imply that
>   * there is actual usable memory at that @pfn. The struct page may
>   * represent a hole or an unusable page frame.
>   *
>   * Return: 1 for PFNs that have memory map entries and 0 otherwise.
>   */
> 

Sounds good to me -- thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

