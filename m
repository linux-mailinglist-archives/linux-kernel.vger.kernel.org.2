Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E923FD4C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbhIAHwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242844AbhIAHwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630482681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/n4oX+wgvboyZg/iFTnmBK58XCroGgLcRn2/A07gOQ=;
        b=Oc4EzyZOaFGKcO9FtwKX35hqRDwqlVH2Sk9gQ3CCvgMpo1K4VTWrxBvXvT/aP0dp6Jmfih
        tXAttoPieJQLgsHlIZmef4513r8x0g6fvxRi/yG0p+PjXBADIR5spZMpjUiKTrYRPw+Yfy
        NyrBWIAr2FdVtXtfgYFCsNH5dHdZU4c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-vsfy7XQyPiOK6KSkeOjifA-1; Wed, 01 Sep 2021 03:51:20 -0400
X-MC-Unique: vsfy7XQyPiOK6KSkeOjifA-1
Received: by mail-wm1-f71.google.com with SMTP id m16-20020a7bca50000000b002ee5287d4bfso705413wml.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 00:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5/n4oX+wgvboyZg/iFTnmBK58XCroGgLcRn2/A07gOQ=;
        b=K67WgMMSAUJsX/3sIlf21BCs2IR2wA90UN+8rKFRhysh8gzEx3S66W++JgzaCbLYep
         eyqQv9qzqlgIUyrEVhkJZQENpldxZIEsAbpPsDKH6dY7vgA8zqgOGzJUZvD94DyfNjp0
         yrahWiMP0fq/SgiIgMgXjCzlj+0oCs8+YIjRXVxx3xAVD+VJCG4xA7uCgSeXw/gS7lXk
         DvvoAj3hp6DuVZFV1zZ++OweQYU8cUxzF2L8WdDqL14P4mIGkaYt4uKGa0/LyIMakxeU
         g9ZJNGLAN8K2E9fflxh6uzAMadfYKy2t1qbG+6Y8NRlIGPQiZHDD6F5EbjdpUoi/cVp2
         6I6Q==
X-Gm-Message-State: AOAM531plEoLFYQJ+vvXPejWbEqS9Nv4kpV2M1Rq2VyFKm99vWtpjaMD
        kmNcvUlci1pKUfL2zMPZ+8U5MrC3JnR9iSOzK0LpEYa3nmNQ6cqgQ8jTCryIZUuhvVpqhdvDuaA
        Q6vyp0siRu6t54J4UszNVXU/Z
X-Received: by 2002:a5d:6909:: with SMTP id t9mr34318602wru.44.1630482678973;
        Wed, 01 Sep 2021 00:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMTvey89SA3DoF/1V8U6PpKmCzoHc/KiiggH+ZLjefcj776vc8ndYgcBGPfQkb8V+1P+tq7Q==
X-Received: by 2002:a5d:6909:: with SMTP id t9mr34318566wru.44.1630482678787;
        Wed, 01 Sep 2021 00:51:18 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id v13sm21108768wrf.55.2021.09.01.00.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 00:51:18 -0700 (PDT)
Subject: Re: [RFC] KVM: mm: fd-based approach for supporting KVM guest private
 memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
References: <20210824005248.200037-1-seanjc@google.com>
 <307d385a-a263-276f-28eb-4bc8dd287e32@redhat.com>
 <40af9d25-c854-8846-fdab-13fe70b3b279@kernel.org>
 <cfe75e39-5927-c02a-b8bc-4de026bb7b3b@redhat.com>
 <73319f3c-6f5e-4f39-a678-7be5fddd55f2@www.fastmail.com>
 <YSlnJpWh8fdpddTA@google.com>
 <949e6d95-266d-0234-3b86-6bd3c5267333@redhat.com>
 <YS6U1u/p+nOXVEfS@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a21fc9cf-0775-2c70-0ad6-61bb1363e2d0@redhat.com>
Date:   Wed, 1 Sep 2021 09:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YS6U1u/p+nOXVEfS@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.21 22:45, Sean Christopherson wrote:
> On Tue, Aug 31, 2021, David Hildenbrand wrote:
>> On 28.08.21 00:28, Sean Christopherson wrote:
>>> On Fri, Aug 27, 2021, Andy Lutomirski wrote:
>>>>
>>>> On Thu, Aug 26, 2021, at 2:26 PM, David Hildenbrand wrote:
>>>>> On 26.08.21 19:05, Andy Lutomirski wrote:
>>>>
>>>>>> Oof.  That's quite a requirement.  What's the point of the VMA once all
>>>>>> this is done?
>>>>>
>>>>> You can keep using things like mbind(), madvise(), ... and the GUP code
>>>>> with a special flag might mostly just do what you want. You won't have
>>>>> to reinvent too many wheels on the page fault logic side at least.
>>>
>>> Ya, Kirill's RFC more or less proved a special GUP flag would indeed Just Work.
>>> However, the KVM page fault side of things would require only a handful of small
>>> changes to send private memslots down a different path.  Compared to the rest of
>>> the enabling, it's quite minor.
>>>
>>> The counter to that is other KVM architectures would need to learn how to use the
>>> new APIs, though I suspect that there will be a fair bit of arch enabling regardless
>>> of what route we take.
>>>
>>>> You can keep calling the functions.  The implementations working is a
>>>> different story: you can't just unmap (pte_numa-style or otherwise) a private
>>>> guest page to quiesce it, move it with memcpy(), and then fault it back in.
>>>
>>> Ya, I brought this up in my earlier reply.  Even the initial implementation (without
>>> real NUMA support) would likely be painful, e.g. the KVM TDX RFC/PoC adds dedicated
>>> logic in KVM to handle the case where NUMA balancing zaps a _pinned_ page and then
>>> KVM fault in the same pfn.  It's not thaaat ugly, but it's arguably more invasive
>>> to KVM's page fault flows than a new fd-based private memslot scheme.
>>
>> I might have a different mindset, but less code churn doesn't necessarily
>> translate to "better approach".
> 
> I wasn't referring to code churn.  By "invasive" I mean number of touchpoints in
> KVM as well as the nature of the touchpoints.  E.g. poking into how KVM uses
> available bits in its shadow PTEs and adding multiple checks through KVM's page
> fault handler, versus two callbacks to get the PFN and page size.
> 
>> I'm certainly not pushing for what I proposed (it's a rough, broken sketch).
>> I'm much rather trying to come up with alternatives that try solving the
>> same issue, handling the identified requirements.
>>
>> I have a gut feeling that the list of requirements might not be complete
>> yet. For example, I wonder if we have to protect against user space
>> replacing private pages by shared pages or punishing random holes into the
>> encrypted memory fd.
> 
> Replacing a private page with a shared page for a given GFN is very much a
> requirement as it's expected behavior for all VMM+guests when converting guest
> memory between shared and private.
> 
> Punching holes is a sort of optional requirement.  It's a "requirement" in that
> it's allowed if the backing store supports such a behavior, optional in that
> support wouldn't be strictly necessary and/or could come with constraints.  The
> expected use case is that host userspace would punch a hole to free unreachable
> private memory, e.g. after the corresponding GFN(s) is converted to shared, so
> that it doesn't consume 2x memory for the guest.
> 

Okay, that matches my understanding then. I was rather thinking about 
"what happens if we punch a hole where private memory was not converted 
to shared yet". AFAIU, we will simply crash the guest then.

-- 
Thanks,

David / dhildenb

