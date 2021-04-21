Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0AF366973
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhDUKtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:49:08 -0400
Received: from foss.arm.com ([217.140.110.172]:59128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhDUKtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:49:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C4FA113E;
        Wed, 21 Apr 2021 03:48:34 -0700 (PDT)
Received: from [10.163.74.228] (unknown [10.163.74.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A00AE3F73B;
        Wed, 21 Apr 2021 03:48:29 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 1/4] include/linux/mmzone.h: add documentation for
 pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210421065108.1987-1-rppt@kernel.org>
 <20210421065108.1987-2-rppt@kernel.org>
Message-ID: <d31ff896-ea1c-d47c-0d11-34fdcd3b7ad8@arm.com>
Date:   Wed, 21 Apr 2021 16:19:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421065108.1987-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 12:21 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Add comment describing the semantics of pfn_valid() that clarifies that
> pfn_valid() only checks for availability of a memory map entry (i.e. struct
> page) for a PFN rather than availability of usable memory backing that PFN.
> 
> The most "generic" version of pfn_valid() used by the configurations with
> SPARSEMEM enabled resides in include/linux/mmzone.h so this is the most
> suitable place for documentation about semantics of pfn_valid().
> 
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/mmzone.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 47946cec7584..961f0eeefb62 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1410,6 +1410,17 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>  #endif
>  
>  #ifndef CONFIG_HAVE_ARCH_PFN_VALID
> +/**
> + * pfn_valid - check if there is a valid memory map entry for a PFN
> + * @pfn: the page frame number to check
> + *
> + * Check if there is a valid memory map entry aka struct page for the @pfn.
> + * Note, that availability of the memory map entry does not imply that
> + * there is actual usable memory at that @pfn. The struct page may
> + * represent a hole or an unusable page frame.
> + *
> + * Return: 1 for PFNs that have memory map entries and 0 otherwise
> + */
>  static inline int pfn_valid(unsigned long pfn)
>  {
>  	struct mem_section *ms;
> 
