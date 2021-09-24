Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA96416A21
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbhIXCst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbhIXCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:48:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADB8C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 19:47:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g14so7650638pfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 19:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FEVFO1LUZkGAI7jrBtWeyG1oEu1in197SjBUjEFqaBo=;
        b=bFN4ME187FOK6Ne7xCgrtXgrNL4Arg6ETp1sVuwSuEpwcXDEEw+0nOjsg17lZr/MPg
         B4vcZT0jqymc9PtGUcIVOSz1YMZ6QJ8M4onZ3ElEVS4OVy3Ph2aCGn9+ix/KWUSfyW/3
         Xoah4qiEYvixvl5qc3M94eQ57JmIy1pSHYrB/q+OKSPdtuXnXFLxO64QqzoFArPA3+6a
         D35FDD2PtCO62UNhpvOiFcmMiYd2SE0wLfknkdZKWBLKp8UBELpy1v4rXWRjEnbEn4QD
         GvBEu5n/kg5wLEKmY6UD0IuJV6JTKywTZ9DWTFZdsw+vtqpUgNDKBj+HSBvpchuZ53yi
         Y4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FEVFO1LUZkGAI7jrBtWeyG1oEu1in197SjBUjEFqaBo=;
        b=WWErCNg1hIT2mga17gFKNBpktgdr3LsPLQTwSmLS4qJMl5b6N9RCfkk3cPfJYxKiJC
         M9xtNo27Khx1pMyzLwq7/t3iiFWUuNgKRBWlEhbNYH8WcP5zoAYKWIs9jTXzvH0xDXrS
         C3zwuAXaCzfrNYtuS+AaVgBsnDRkrPQlOKCE64PrT8iOpzkYXXA5psadf7xnQUlJXHOc
         5dXH/FHbIwngWwfunx7N8uOzsvnFNw1kXXmPA16NhvcZmanybzM4ZN8adJCa1VBRVc45
         LSWbNoKljhG5Xj7Xb4UNPZu1qxvuE6PxrJGeqD3PxISjjctPDQZGoWQA2PKwb0UjIJBl
         KXDw==
X-Gm-Message-State: AOAM5332bl42UwdvlX2LvYhX8HFHEvtSsNVcrOLnQQo1GciDJfM164E6
        LlNrN3LpbKtPo0idGAK4/uE=
X-Google-Smtp-Source: ABdhPJwQ66Az4BtCe3LR9g4AXjL9+g2UZM0qBW7WWQMktkugi/XVVaHm9tEwy67VXdWB6fl5jA+MuA==
X-Received: by 2002:a63:b147:: with SMTP id g7mr1809053pgp.478.1632451634704;
        Thu, 23 Sep 2021 19:47:14 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x9sm7247327pfo.172.2021.09.23.19.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 19:47:14 -0700 (PDT)
Message-ID: <6eb8319d-acba-b69a-5db3-5dca9ef426e8@gmail.com>
Date:   Thu, 23 Sep 2021 19:47:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
Content-Language: en-US
To:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Doug Berger <opendmb@gmail.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/2021 3:54 PM, Chris Goldsworthy wrote:
> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> 
> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
> needs updating to reflect on new PFNs being hot added to system.
> 
> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> ---
>   arch/arm64/mm/mmu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cfd9deb..fd85b51 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   	if (ret)
>   		__remove_pgd_mapping(swapper_pg_dir,
>   				     __phys_to_virt(start), size);
> +	else {
> +		max_pfn = PFN_UP(start + size);
> +		max_low_pfn = max_pfn;
> +	}

This is a drive by review, but it got me thinking about your changes a bit:

- if you raise max_pfn when you hotplug memory, don't you need to lower 
it when you hot unplug memory as well?

- suppose that you have a platform which maps physical memory into the 
CPU's address space at 0x00_4000_0000 (1GB offset) and the kernel boots 
with 2GB of DRAM plugged by default. At that point we have not 
registered a swiotlb because we have less than 4GB of addressable 
physical memory, there is no IOMMU in that system, it's a happy world. 
Now assume that we plug an additional 2GB of DRAM into that system 
adjacent to the previous 2GB, from 0x00_C0000_0000 through 
0x14_0000_0000, now we have physical addresses above 4GB, but we still 
don't have a swiotlb, some of our DMA_BIT_MASK(32) peripherals are going 
to be unable to DMA from that hot plugged memory, but they could if we 
had a swiotlb.

- now let's go even further but this is very contrived. Assume that the 
firmware has somewhat created a reserved memory region with a 'no-map' 
attribute thus indicating it does not want a struct page to be created 
for a specific PFN range, is it valid to "blindly" raise max_pfn if that 
region were to be at the end of the just hot-plugged memory?
-- 
Florian
