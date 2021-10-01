Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B847941E931
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbhJAIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:53:15 -0400
Received: from foss.arm.com ([217.140.110.172]:38072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhJAIxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:53:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F708101E;
        Fri,  1 Oct 2021 01:51:25 -0700 (PDT)
Received: from [10.163.74.5] (unknown [10.163.74.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91BE03F70D;
        Fri,  1 Oct 2021 01:51:21 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: update max_pfn after memory hotplug
To:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Florian Fainelli <f.fainelli@gmail.com>
References: <cover.1632853776.git.quic_cgoldswo@quicinc.com>
 <a51a27ee7be66024b5ce626310d673f24107bcb8.1632853776.git.quic_cgoldswo@quicinc.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <31f656c6-bee0-fc23-8ab7-3d62fd5aaeca@arm.com>
Date:   Fri, 1 Oct 2021 14:22:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a51a27ee7be66024b5ce626310d673f24107bcb8.1632853776.git.quic_cgoldswo@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/21 12:21 AM, Chris Goldsworthy wrote:
> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> 
> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
> needs updating to reflect on new PFNs being hot added to system.
> Without this patch, debug-related functions that use max_pfn such as
> get_max_dump_pfn() or read_page_owner() will not work with any page in
> memory that is hot-added after boot. 
> 
> Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Georgi Djakov <quic_c_gdjako@quicinc.com>

As these variables need to be updated in the platform.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cfd9deb..fd85b51 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	if (ret)
>  		__remove_pgd_mapping(swapper_pg_dir,
>  				     __phys_to_virt(start), size);
> +	else {
> +		max_pfn = PFN_UP(start + size);
> +		max_low_pfn = max_pfn;
> +	}
> +
>  	return ret;
>  }
>  
> 
