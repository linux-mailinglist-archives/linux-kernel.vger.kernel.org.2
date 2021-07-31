Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D103DC7E5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhGaTL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 15:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhGaTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 15:11:25 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B9C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 12:11:19 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so13316144ott.9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/nOnPAAlrT9e+E2Vf8iJWRNSF3TLuj1r9krCEzJu7Lk=;
        b=itAY14TQQQT2TR2hYiNgc2WVPZBnHGEJGAvZcL/Xtx1BNuuD/pTHQrwpQF/BSAc0z+
         lzOCtMCHIiup7hCKQgur4d4ASunZIXJULNTN3s1qR70EyhrVHx/FwLjxxcvZWHh3hi+S
         NoFf30eeKHMyENHyaxJ9YgVC8HYPgFbBZZBeWLsk++kbOhhfd3OIYLhq6ZRU16N3ZS6h
         +3jjSt1dpUhMvtDSv5jIhxoewMjce7PmUeaDUrA3CfmDgcbGHLK0yUkWS9j4+UJOcIeD
         yUbom4z4ZN6N4iBwDyLl8SpbUG+584aF9JP+qaBF+9QPDZXNzEdDvEc7njvvBmRwhDeq
         4toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/nOnPAAlrT9e+E2Vf8iJWRNSF3TLuj1r9krCEzJu7Lk=;
        b=QkNym1K2HsIb3vcVIyFiDZ+orMDUqSJleKlHrXnl/kxWSXKEf0vEAf6gap9z3L0iiN
         Ly5lSQ1Oj3DTtQbd8KFh+/hkxKpPtpvqm60VQc8lHzKfBj5ZHacoBtl2gCNuhbXv4fX6
         dUKfVgIA6PgbGPBXpcfGZhTn0aWNgLJeWHKol5EAWfFu1IWfVUkFyddEUWtaoRdg4iIN
         UIy1BPHWszJJ1CItZ66VHGU4NALFfQWPVdV6ug2B0763PqNH1tKBSTeWDGRL08uYQa3R
         qawfl3xGXGRSUmJBAdetF+azEP6fbdmmNYQmVfSd9Bc4MQeruCmaAlK4xKpXfCZBWbuk
         Kcdg==
X-Gm-Message-State: AOAM532s0Ck+AiGmi4D90SgvXgrK+0Bin4Q/snpMIAv3kiIkr2RXjUY5
        lnKABW20WOksSrpfsvA2ENc=
X-Google-Smtp-Source: ABdhPJwVfGiDa5NlN5YesMpvSnBAmVvb+nO0X0XnlxxYq+9Vv2ZVAJxgz5oo7Aa4ubY9HqN+zobaVg==
X-Received: by 2002:a9d:174:: with SMTP id 107mr6580495otu.179.1627758678481;
        Sat, 31 Jul 2021 12:11:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w190sm939944oif.17.2021.07.31.12.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 12:11:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/4] mm/page_alloc: always initialize memory map for the
 holes
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210714123739.16493-1-rppt@kernel.org>
 <20210714123739.16493-2-rppt@kernel.org>
 <20210731165601.GA1900220@roeck-us.net> <YQWW3RCE4eWBuMu/@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f6ec888c-91ee-de4e-45c8-58133c5ffeb4@roeck-us.net>
Date:   Sat, 31 Jul 2021 12:11:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQWW3RCE4eWBuMu/@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/31/21 11:30 AM, Mike Rapoport wrote:
> On Sat, Jul 31, 2021 at 09:56:01AM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Wed, Jul 14, 2021 at 03:37:36PM +0300, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> Currently memory map for the holes is initialized only when SPARSEMEM
>>> memory model is used. Yet, even with FLATMEM there could be holes in the
>>> physical memory layout that have memory map entries.
>>>
>>> For instance, the memory reserved using e820 API on i386 or
>>> "reserved-memory" nodes in device tree would not appear in memblock.memory
>>> and hence the struct pages for such holes will be skipped during memory map
>>> initialization.
>>>
>>> These struct pages will be zeroed because the memory map for FLATMEM
>>> systems is allocated with memblock_alloc_node() that clears the allocated
>>> memory. While zeroed struct pages do not cause immediate problems, the
>>> correct behaviour is to initialize every page using __init_single_page().
>>> Besides, enabling page poison for FLATMEM case will trigger
>>> PF_POISONED_CHECK() unless the memory map is properly initialized.
>>>
>>> Make sure init_unavailable_range() is called for both SPARSEMEM and FLATMEM
>>> so that struct pages representing memory holes would appear as PG_Reserved
>>> with any memory layout.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>
>> This patch causes microblaze petalogix-ml605 qemu emulations to fail
>> silently (no console output). Reverting it fixes the problem.
> 
> It appears that petalogix-ml605 memory starts at 0x50000, but microblaze's
> pfn_valid does not reject pfns < ARCH_PFN_OFFSET.
> 
> This should fix the issue:
> 
> diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> index ce550978f4fc..4b8b2fa78fc5 100644
> --- a/arch/microblaze/include/asm/page.h
> +++ b/arch/microblaze/include/asm/page.h
> @@ -112,8 +112,7 @@ extern int page_is_ram(unsigned long pfn);
>   #  define page_to_phys(page)     (page_to_pfn(page) << PAGE_SHIFT)
>   
>   #  define ARCH_PFN_OFFSET	(memory_start >> PAGE_SHIFT)
> -#  define pfn_valid(pfn)	((pfn) < (max_mapnr + ARCH_PFN_OFFSET))
> -
> +#  define pfn_valid(pfn)	((pfn) >= ARCH_PFN_OFFSET && (pfn) < (max_mapnr + ARCH_PFN_OFFSET))
>   # endif /* __ASSEMBLY__ */
>   
>   #define	virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))

Indeed, that does the trick.

Feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

to the patch.

Thanks,
Guenter

>> Guenter
>>
>> ---
>> Bisect log:
>>
>> # bad: [8d4b477da1a807199ca60e0829357ce7aa6758d5] Add linux-next specific files for 20210730
>> # good: [ff1176468d368232b684f75e82563369208bc371] Linux 5.14-rc3
>> git bisect start 'HEAD' 'v5.14-rc3'
>> # good: [8f3eb1f5c702ef868d89799b03c21d122f2fe197] Merge remote-tracking branch 'bpf-next/for-next'
>> git bisect good 8f3eb1f5c702ef868d89799b03c21d122f2fe197
>> # good: [32286c7080c56c835f25302c38eebccf41b7b576] Merge remote-tracking branch 'tip/auto-latest'
>> git bisect good 32286c7080c56c835f25302c38eebccf41b7b576
>> # good: [70c40604c7d393f95171f49717a27bf8e05b5439] Merge remote-tracking branch 'dmaengine/next'
>> git bisect good 70c40604c7d393f95171f49717a27bf8e05b5439
>> # good: [b038834891b35ec410693028a500f769db132a81] Merge remote-tracking branch 'rust/rust-next'
>> git bisect good b038834891b35ec410693028a500f769db132a81
>> # bad: [d8f4e506a9ba375110945d75573b3304491e6350] memory-hotplug.rst: complete admin-guide overhaul
>> git bisect bad d8f4e506a9ba375110945d75573b3304491e6350
>> # good: [bef692dcfb7cdb5c960abfc31e2386a0ff41af54] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
>> git bisect good bef692dcfb7cdb5c960abfc31e2386a0ff41af54
>> # bad: [5fcd957e2f0dc4cb25a6ee60ebfb1200de09c9d1] mm-migrate-demote-pages-during-reclaim-v11
>> git bisect bad 5fcd957e2f0dc4cb25a6ee60ebfb1200de09c9d1
>> # good: [8c2a82ab20eb09d217446989ae209f5ff19a64ac] mm/vmalloc: use batched page requests in bulk-allocator
>> git bisect good 8c2a82ab20eb09d217446989ae209f5ff19a64ac
>> # bad: [c36a5446e29f1461780b06785769b9402522f847] mm/page_alloc.c: fix 'zone_id' may be used uninitialized in this function warning
>> git bisect bad c36a5446e29f1461780b06785769b9402522f847
>> # good: [05e358c552628e26be3985933bea88e7512414c0] mm/kasan: move kasan.fault to mm/kasan/report.c
>> git bisect good 05e358c552628e26be3985933bea88e7512414c0
>> # bad: [b467ff7f560908e60ca181658b7ee48e5da94da1] microblaze: simplify pte_alloc_one_kernel()
>> git bisect bad b467ff7f560908e60ca181658b7ee48e5da94da1
>> # bad: [d2a572bf593a57246827bd79c91fe2ee6b7af1f0] mm/page_alloc: always initialize memory map for the holes
>> git bisect bad d2a572bf593a57246827bd79c91fe2ee6b7af1f0
>> # first bad commit: [d2a572bf593a57246827bd79c91fe2ee6b7af1f0] mm/page_alloc: always initialize memory map for the holes
> 

