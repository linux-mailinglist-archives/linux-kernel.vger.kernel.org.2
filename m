Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C04B30B9E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhBBI2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231406AbhBBI2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612254426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mTg2oMPOn40/ltsulP4d95N1N+NtkIehznJg+VXVl4=;
        b=cvUh4YZ4zw5wrXq/e5/RRpDJ9+MUKIAGKBBUMrnLK0CU9h8MPcrXhgyZ7BYLVmfaypYZZc
        223zb8Sy6ryn9m4w8eAywe1CM+TUrz8tpNyy2YAwddjRFFpwOf65qA+T3bPaE7v9xlgi1f
        9rL3dnV4T+aAgA2IPxehGkUwTQBlkB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-ssxtYByMNaumSNvBCcQfXg-1; Tue, 02 Feb 2021 03:27:03 -0500
X-MC-Unique: ssxtYByMNaumSNvBCcQfXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33081802B4E;
        Tue,  2 Feb 2021 08:27:01 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 495A419717;
        Tue,  2 Feb 2021 08:26:58 +0000 (UTC)
Subject: Re: [PATCH V2 2/2] arm64/mm: Reorganize pfn_valid()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
 <1612239114-28428-3-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5609cc64-317c-1517-0e90-027868bc9d4b@redhat.com>
Date:   Tue, 2 Feb 2021 09:26:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1612239114-28428-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.21 05:11, Anshuman Khandual wrote:
> There are multiple instances of pfn_to_section_nr() and __pfn_to_section()
> when CONFIG_SPARSEMEM is enabled. This can be optimized if memory section
> is fetched earlier. This replaces the open coded PFN and ADDR conversion
> with PFN_PHYS() and PHYS_PFN() helpers. While there, also add a comment.
> This does not cause any functional change.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/mm/init.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 1141075e4d53..5d8fd5360a68 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -219,16 +219,25 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   
>   int pfn_valid(unsigned long pfn)
>   {
> -	phys_addr_t addr = pfn << PAGE_SHIFT;
> +	phys_addr_t addr = PFN_PHYS(pfn);
>   
> -	if ((addr >> PAGE_SHIFT) != pfn)
> +	/*
> +	 * Ensure the upper PAGE_SHIFT bits are clear in the
> +	 * pfn. Else it might lead to false positives when
> +	 * some of the upper bits are set, but the lower bits
> +	 * match a valid pfn.
> +	 */
> +	if (PHYS_PFN(addr) != pfn)
>   		return 0;
>   
>   #ifdef CONFIG_SPARSEMEM
> +{
> +	struct mem_section *ms = __pfn_to_section(pfn);
> +
>   	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>   		return 0;
>   
> -	if (!valid_section(__pfn_to_section(pfn)))
> +	if (!valid_section(ms))
>   		return 0;
>   
>   	/*
> @@ -240,8 +249,9 @@ int pfn_valid(unsigned long pfn)
>   	 * memory sections covering all of hotplug memory including
>   	 * both normal and ZONE_DEVICE based.
>   	 */
> -	if (!early_section(__pfn_to_section(pfn)))
> -		return pfn_section_valid(__pfn_to_section(pfn), pfn);
> +	if (!early_section(ms))
> +		return pfn_section_valid(ms, pfn);
> +}
>   #endif
>   	return memblock_is_map_memory(addr);
>   }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

