Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952463F170D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbhHSKHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237746AbhHSKHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629367605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Opv2d9ol21udi4K0v30kbE3GUCegq3iBRM6wdcQpyVk=;
        b=HXzJmEAWYoOmyYEJhI6WLMBlnyUCgnVnsXrAayE8oDmK4SCc796d7uiYihvmMMLGEBXAv+
        huIK4TVN7vHaI6Fi/WZFP+fXjDGn7XnuGY3Af2KKcaCt3OUqP9gMbyE+j7D1ICT5zxraP9
        rbyEyXsQOBNejANgII12W14hLpw5XJo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-FYtCgnA-O_24Z0mnxc5XPg-1; Thu, 19 Aug 2021 06:06:43 -0400
X-MC-Unique: FYtCgnA-O_24Z0mnxc5XPg-1
Received: by mail-wr1-f72.google.com with SMTP id p4-20020a5d59a4000000b00156992180dbso1527029wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Opv2d9ol21udi4K0v30kbE3GUCegq3iBRM6wdcQpyVk=;
        b=H4UzCzyv0qNhZ9d0q4VFuynbVYARFwnoK08gwnDAxOgM9Zoi6RGcYhQkrDxTt7bKR8
         l6GgquOLCXLWiq7t7buPzuelkMseIzuxxAZnC2/Q/B5EGp+5Ox664LXsNP78QvKCQWj3
         8rYTl39OA624foKx9VKzetom6M0Mw1NO1xhZUY6XAgBJo48PM074ff6oDoq4qYQEznqk
         ZDbSj74pqE3JBuvGyT7vtvlXswtZv6qMh8P78yXJpiMz5Ev6h8fe0EhJBvCtbAjdZMIk
         d4pdSYjfVAodEx8znU0w9aJrc0+7poQYF01y70ZfvqY5MSjgF9Suo5vBVdAgx++84tjo
         u6Sg==
X-Gm-Message-State: AOAM531DYq2HwKl9OASPI1c+hjRoj5VgqtaRRrdNaDDaWRcxwechuKdw
        ffbV1dczX6dWD9xsm5hGWXWeVKxLLo8cKboPB28NIO7/y+q8MeB8M9mprC1FjKDrGVo66wbeTTD
        NS6d0Z2rVhpq9l5Buwfb+S+Ul
X-Received: by 2002:a5d:6483:: with SMTP id o3mr2757120wri.197.1629367602746;
        Thu, 19 Aug 2021 03:06:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+3/0fv0wKXrwU5A+P76meV3y97/X7hVUmMcENBq24d/DLFeQ19OprL9SSc1+K8XhulZ/xWQ==
X-Received: by 2002:a5d:6483:: with SMTP id o3mr2757086wri.197.1629367602415;
        Thu, 19 Aug 2021 03:06:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6bd1.dip0.t-ipconnect.de. [91.12.107.209])
        by smtp.gmail.com with ESMTPSA id y1sm2167170wmq.43.2021.08.19.03.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 03:06:41 -0700 (PDT)
Subject: Re: [PATCH 1/5] mm: Add support for unaccepted memory
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <d091b333-9ef8-ac32-58c5-c325d29f26d7@intel.com>
 <9748c07c-4e59-89d0-f425-c57f778d1b42@linux.intel.com>
 <17b6a3a3-bd7d-f57e-8762-96258b16247a@intel.com>
 <796a4b20-7fa3-3086-efa0-2f728f35ae06@linux.intel.com>
 <f445da8b-c044-3765-65f2-f911dbf6a507@intel.com>
 <3caf5e73-c104-0057-680c-7851476e67ac@linux.intel.com>
 <YRTZr/Pxyb8fsV58@suse.de> <25312492-5d67-e5b0-1a51-b6880f45a550@intel.com>
 <YRaGch+D5HPtUk9l@suse.de> <b0228048-d2c2-6081-cfae-147e17acf785@redhat.com>
 <YR4qexszQ+Wxqe5r@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <39d09b80-f79e-0dab-2be7-31d4db43ab77@redhat.com>
Date:   Thu, 19 Aug 2021 12:06:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR4qexszQ+Wxqe5r@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.21 11:55, Joerg Roedel wrote:
> Hi David,
> 
> On Tue, Aug 17, 2021 at 05:00:55PM +0200, David Hildenbrand wrote:
>> Not sure if already discussed, but what about making sure that free pages
>> are not a mixture (partially unaccepted, partially accepted).
>>
>> You'd have to expose the pages in that granularity to the buddy
>> (__free_pages_core), indicating the state. You'd have to reject merging
>> pages of differing acceptance state.
>>
>> Accepting a page would then be handled outside of the zone lock, completely
>> controlled by the state.
>>
>> So a page in the buddy would either be completely accepted or completely
>> unaccepted, signaled e.g., by PageOffline().
>>
>> Consequently, when allocating a 4KiB page, you'd split an unaccepted 2MiB
>> page into separate unaccepted pages. You'd grab one of the unaccepted 4KiB
>> pages and accept it before initializing it and handing it out.
> 
> Yes, that is the alternative to over-accepting memory on allocation. But
> the problem here is that accepting/validating memory is an expensive
> operation which also requires a hypercall. The hypercalls on SNP and TDX
> can accept/validate multiple pages in one call. So the recommendation is
> to accept memory in bigger chunks, like the 2MB that have been proposed.
> 

The general idea would be to have one thread scanning the free page list 
and accepting pages in the background. Take a page out, accept it, 
release it back to the buddy. If we place accepted pages to the front of 
the free list, allocations would be quite fast.

Sure, you'd have some slow early allocations, but I'd guess it really 
wouldn't make a big impact overall. We'd have to try.

It's quite similar to the free page reporting infrastructure, except 
that with free page reporting we want to place pages to the tail, not to 
the front. That would be easy to add.


> Only accepting memory in allocation size might be too slow, as there is
> a lot of code doing order-0 allocations. I think this approach will also
> be more intrusive to the page alloctor, as it needs more changes on the
> free path to check for acceptance states before pages can be merged.

That's already mostly done in this patch IIRC.

-- 
Thanks,

David / dhildenb

