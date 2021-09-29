Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0035D41C453
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbhI2MLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245453AbhI2MLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632917380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4DcsmdERvwEayP8lS8c/q6o204OALA6BwCBR3wwYSU=;
        b=hakrYV94LaND7pizWDCZsAW/JrKQ1HiUGVYd3+CVFXYqDrDn/ByAbvf7OZsRwdhWJvycrW
        rFsRKi+UGxS2jMXHt1iGfRqtFfYBqKSOvUv6JMIXic+9lMut5JQUG40YAu7EahBER0Z806
        A1h607qvOBu3vt8y9UTMH3ckOntCQb0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-L2GZLPetM9GsfeP1MTU-ag-1; Wed, 29 Sep 2021 08:09:38 -0400
X-MC-Unique: L2GZLPetM9GsfeP1MTU-ag-1
Received: by mail-wr1-f71.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso518571wrw.22
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=m4DcsmdERvwEayP8lS8c/q6o204OALA6BwCBR3wwYSU=;
        b=vp01oH/aWc7yFhv807goKBDpi4VliC6QdKmfIVSjUMbP7CvjgWgiuen7xVzMeDOZux
         fsCA0fu01A3kbuvAdJ3Atl3ZftV56CjQVs8ToeWYEgH/hMR9OX2mfH4y3PP1D2Huyhp7
         X4uNutJ1dVCGhPXgpvkUX8G2GgUcbuPW7vdu8+/UEV39ZV68gzyA6pyPCus0gBd8ztuX
         5xPAgGAi1cW/AKhoHS74o8jPwC/NtStEDVdKDBKa5FuHjan4XfVsn6RHbXDEDDvJx+iw
         Nk1BkEAQo0r69Nd+++8cDk7wmROauep9WdOrGdP8UStv+C3WyVgKwlHzX0wB/FxTQgbQ
         tzvw==
X-Gm-Message-State: AOAM530g+sJTA9sWH/DW6ymeskGb8nn7pNVK52w3JwZDqFZEjzHOwx8v
        kl5zD1Qpqkmgs3auijjfrFDxcWJfMlhn1luRjzWmj725Icg550dD3XBy1wC0sGo4cwS4a1khboZ
        S+H2YQAYX80/YvxLKqHFmF27R
X-Received: by 2002:a7b:c1d6:: with SMTP id a22mr9983252wmj.146.1632917377437;
        Wed, 29 Sep 2021 05:09:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEQO6IjIjiX7wFN2+HDTboYoYk/OTp98F2ya3lRO8pW+OuQGAUAEkqR2bTjtD2aDDY3KEI+g==
X-Received: by 2002:a7b:c1d6:: with SMTP id a22mr9983226wmj.146.1632917377186;
        Wed, 29 Sep 2021 05:09:37 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id u1sm1391208wmc.29.2021.09.29.05.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 05:09:36 -0700 (PDT)
To:     Will Deacon <will@kernel.org>
Cc:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <20210929101028.GB21057@willie-the-truck>
 <13f56b37-afc7-bf6f-d544-8d6433588bf9@redhat.com>
 <20210929104241.GA21395@willie-the-truck>
 <b0717829-c8dd-c7c0-47bb-5392ed22f700@redhat.com>
 <20210929110339.GA21510@willie-the-truck>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
Message-ID: <130a50d7-92fd-31fa-261e-f73dadcb4fcf@redhat.com>
Date:   Wed, 29 Sep 2021 14:09:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210929110339.GA21510@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.21 13:03, Will Deacon wrote:
> On Wed, Sep 29, 2021 at 12:49:58PM +0200, David Hildenbrand wrote:
>> On 29.09.21 12:42, Will Deacon wrote:
>>> On Wed, Sep 29, 2021 at 12:29:32PM +0200, David Hildenbrand wrote:
>>>> On 29.09.21 12:10, Will Deacon wrote:
>>>>> On Thu, Sep 23, 2021 at 03:54:48PM -0700, Chris Goldsworthy wrote:
>>>>>> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>>>>>
>>>>>> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
>>>>>> needs updating to reflect on new PFNs being hot added to system.
>>>>>>
>>>>>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>>>>> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
>>>>>> ---
>>>>>>     arch/arm64/mm/mmu.c | 5 +++++
>>>>>>     1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>>>> index cfd9deb..fd85b51 100644
>>>>>> --- a/arch/arm64/mm/mmu.c
>>>>>> +++ b/arch/arm64/mm/mmu.c
>>>>>> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>>>>     	if (ret)
>>>>>>     		__remove_pgd_mapping(swapper_pg_dir,
>>>>>>     				     __phys_to_virt(start), size);
>>>>>> +	else {
>>>>>> +		max_pfn = PFN_UP(start + size);
>>>>>> +		max_low_pfn = max_pfn;
>>>>>> +	}
>>>>>
>>>>> We use 'max_pfn' as part of the argument to set_max_mapnr(). Does that need
>>>>> updating as well?
>>>>>
>>>>> Do we have sufficient locking to ensure nobody is looking at max_pfn or
>>>>> max_low_pfn while we update them?
>>>>
>>>> Only the write side is protected by memory hotplug locking. The read side is
>>>> lockless -- just like all of the other pfn_to_online_page() machinery.
>>>
>>> Hmm. So the readers can see one of the variables updated but the other one
>>> stale?
>>
>> Yes, just like it has been on x86-64 for a long time:
>>
>> arch/x86/mm/init_64.c:update_end_of_memory_vars()
>>
>> Not sure if anyone really cares about slightly delayed updates while memory
>> is getting hotplugged. The users that I am aware of don't care.
> 
> Thanks, I'd missed that x86 also updates max_low_pfn. So at least we're not
> worse off in that respect.
> 
> Looking at set_max_mapnr(), I'm wondering why we need to call that at all
> on arm64 as 'max_mapnr' only seems to be used for nommu.

I think max_mapnr is only helpful without SPARSE, I can spot the most 
prominent consumer being simplistic pfn_valid() implementation.

MEMORY_HOTPLUG on arm64 implies SPARSE. ... and I recall that FLATMEM is 
no longer possible on arm64. So most probably the arm64 call of 
set_max_mapnr() can just be dropped.

-- 
Thanks,

David / dhildenb

