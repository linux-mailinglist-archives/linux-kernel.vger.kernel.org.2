Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF988416D86
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbhIXIT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244592AbhIXIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632471473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hv0DavdoyFzFPDaDYsQZiKG5xroiwpLoHl3JpBTrMIc=;
        b=PSk0vi48CyylLPcMDGGYHZlYFtSdboVe2vEhb9WFnTa8BRx8ZqlSphqLrBQP2hXxNf5fup
        I/K7a8zFr0GbYHtWu2z2t1KaMdaxSwYN8MtG6LIJHLL8ZTpDApexjxg5AgxvqkjdhHHa7h
        qh41xgXNmkJhLvaOwGRps3+4kmg8gl0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-ZhETw27CO369hmEC6pXzvg-1; Fri, 24 Sep 2021 04:17:49 -0400
X-MC-Unique: ZhETw27CO369hmEC6pXzvg-1
Received: by mail-wr1-f72.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so7385370wrn.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Hv0DavdoyFzFPDaDYsQZiKG5xroiwpLoHl3JpBTrMIc=;
        b=tGPitWMqN2XAdZo4VjvU8kO3Re6fS4xltYnAXRYzCJC3wJIfHD2QyooBiAM1MXcIUl
         wli9BP+6LuMaeMA4+heZp//Olwtds57JfC5NQ58lWQbRKnLIWShXvfrhdh1HSHrTdfY/
         vnGNwQCt7fSYZsSEwIsD+i6lYEaZS70ZCZtgK4Z5p8vZuszR28atEq1pebEsa6X0vSza
         ILCvhsQ01QyVZ9GkIWUbui/moB2CW9P9ZW43WcCKKlXLLRdcsLa4oBaEDwX8/KAOsn/m
         YgMK9nTQKrmAcSK18p1ru6g/Kvy14YDx8x7oakjVBDwXmFWpXUy2+NsXtga9Z9HAhs5l
         zkrw==
X-Gm-Message-State: AOAM531iUr8jz0GvHQCLbeiuXW4IuGLsaVNIBYuSL3wLGWgZ10dpLBST
        fY+ftblh5/o9CfCmRnXaEGYFEg/5mTuXHiF8nRANXxWndg0yUG7p0n6Ikl2L9Pd/Y2xyen7lg0O
        UX/mDqJNQiy1pRggTJjup/47S
X-Received: by 2002:a1c:f405:: with SMTP id z5mr671653wma.33.1632471467843;
        Fri, 24 Sep 2021 01:17:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrH74aZKFo1LlKFHQ42orrvv8hwQA4S5bh26q5ompTUH91rPUY1MEp2TJJUur1lv+fSj85rg==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr671634wma.33.1632471467602;
        Fri, 24 Sep 2021 01:17:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61fc.dip0.t-ipconnect.de. [91.12.97.252])
        by smtp.gmail.com with ESMTPSA id f1sm7642302wri.43.2021.09.24.01.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 01:17:47 -0700 (PDT)
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Doug Berger <opendmb@gmail.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <6eb8319d-acba-b69a-5db3-5dca9ef426e8@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
Message-ID: <41789cad-76c6-0ea5-4aa1-3e4a52acff86@redhat.com>
Date:   Fri, 24 Sep 2021 10:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6eb8319d-acba-b69a-5db3-5dca9ef426e8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.21 04:47, Florian Fainelli wrote:
> 
> 
> On 9/23/2021 3:54 PM, Chris Goldsworthy wrote:
>> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>
>> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
>> needs updating to reflect on new PFNs being hot added to system.
>>
>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
>> ---
>>    arch/arm64/mm/mmu.c | 5 +++++
>>    1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index cfd9deb..fd85b51 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>    	if (ret)
>>    		__remove_pgd_mapping(swapper_pg_dir,
>>    				     __phys_to_virt(start), size);
>> +	else {
>> +		max_pfn = PFN_UP(start + size);
>> +		max_low_pfn = max_pfn;
>> +	}
> 
> This is a drive by review, but it got me thinking about your changes a bit:
> 
> - if you raise max_pfn when you hotplug memory, don't you need to lower
> it when you hot unplug memory as well?

The issue with lowering is that you actually have to do some search to 
figure out the actual value -- and it's not really worth the trouble. 
Raising the limit is easy.

With memory hotunplug, anybody wanting to take a look at a "struct page" 
via a pfn has to do a pfn_to_online_page() either way. That will fail if 
there isn't actually a memmap anymore because the memory has been 
unplugged. So "max_pfn" is actually rather a hint what maximum pfn to 
look at, and it can be bigger than it actually is.

The a look at the example usage in fs/proc/page.c:kpageflags_read()

pfn_to_online_page() will simply fail and stable_page_flags() will 
indicate a KPF_NOPAGE.

Just like we would have a big memory hole now at the end of memory.

> 
> - suppose that you have a platform which maps physical memory into the
> CPU's address space at 0x00_4000_0000 (1GB offset) and the kernel boots
> with 2GB of DRAM plugged by default. At that point we have not
> registered a swiotlb because we have less than 4GB of addressable
> physical memory, there is no IOMMU in that system, it's a happy world.
> Now assume that we plug an additional 2GB of DRAM into that system
> adjacent to the previous 2GB, from 0x00_C0000_0000 through
> 0x14_0000_0000, now we have physical addresses above 4GB, but we still
> don't have a swiotlb, some of our DMA_BIT_MASK(32) peripherals are going
> to be unable to DMA from that hot plugged memory, but they could if we
> had a swiotlb.

That's why platforms that hotplug memory should indicate the maximum 
possible PFN via some mechanism during boot. On x86-64 (and IIRC also 
arm64 now), this is done via the ACPI SRAT.

And that's where "max_possible_pfn" and "max_pfn" differ. See 
drivers/acpi/numa/srat.c:acpi_numa_memory_affinity_init():

	max_possible_pfn = max(max_possible_pfn, PFN_UP(end - 1));$


Using max_possible_pfn, the OS can properly setup the swiotlb, even 
thought it wouldn't currently be required when just looking at max_pfn.

I documented that for virtio-mem in
	https://virtio-mem.gitlab.io/user-guide/user-guide-linux.html
"swiotlb and DMA memory".

> 
> - now let's go even further but this is very contrived. Assume that the
> firmware has somewhat created a reserved memory region with a 'no-map'
> attribute thus indicating it does not want a struct page to be created
> for a specific PFN range, is it valid to "blindly" raise max_pfn if that
> region were to be at the end of the just hot-plugged memory?

no-map means that no direct mapping is to be created, right? We would 
still have a memmap IIRC, and the pages are PG_reserved.

Again, I think this is very similar to just having no-map regions like 
random memory holes within the existing memory layout.


What Chris proposes here is very similar to 
arch/x86/mm/init_64.c:update_end_of_memory_vars() called during 
arch_add_memory()->add_pages() on x86-64.

-- 
Thanks,

David / dhildenb

