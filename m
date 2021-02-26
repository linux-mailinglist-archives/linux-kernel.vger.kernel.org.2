Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE8325D39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 06:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBZFcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 00:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZFcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 00:32:52 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9CEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 21:32:11 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h4so5531007pgf.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 21:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=nFi/Tly9ElESGJN8oskhUGGfZDgsnBKdYL375bNbXVw=;
        b=JioBCib/pjgVwCE+1j1L7J+4tfJ9rsxj0xJ7mNV1d3h4lgyYYI+qXuyqmqRt0Xwh0d
         jvgqMIUemTP1Lxdkok+irPUbY9vjvRqFh+xYTMJ75GlhbbNR7oUGVVKPAP6Oby4RBv44
         e9iDymH6Ev2uwlY4gCPNa2O1KttsCUTEVQRd7C51U3UXZIw+THXC64dshlRia/zQiwAt
         16lxLPURQRa2lGSL7pgl7PG6TBPphwj0yQrJAaxEAyfpQA49h9OUNuOT0Y2dgs+UgJG0
         qu7gjTDhzUNgfSBeOZg8lZclZzq88UQCur3Dxm3QBLH3KzhgKAYv0i085XeC2lFzpUWX
         W4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=nFi/Tly9ElESGJN8oskhUGGfZDgsnBKdYL375bNbXVw=;
        b=XIrXe8Jy0ioGFRsZiNgIJloPRev3BRe83wqGKIKeABqflJck8QZoYZge4vKCDEkEUY
         A5Mcf0HUWfKCTA0WfhDIO4WwKpaloj4nQ5Lln/4Kxs8yBzE49kB2c0l2/M95l7XIH3dM
         E5yprHeRKXoYzbvbTVqZ3QVyWCs+UIraqw8hMM/jgKHmfLuiJJE0hcd+K0dj7u6ZfSOx
         1unfriIQUiaRqCg66QcJsJqLd7UrMfz9Z9hSr9+Hj9vop3MJix6WxfHaVQ+C2vv0M8ez
         A+5UvnouAC0pRNRj5IVzEPOkK41xe1eah8k0ctTp1ZKwqsG4G/89baAU7O2ffrOB22El
         sw/Q==
X-Gm-Message-State: AOAM532DZhz4F8T3KT0WEcnWgEPUuhS0NdR0puk/cq0JvjxgtJaRg1dS
        Pi9m0ZlOhqLcF4R88wAzuF2fAg==
X-Google-Smtp-Source: ABdhPJzqqNWI8LPb+RbI+afEQbemNqMMfrtDVHxnRHynUOPZCKSmIemE8l7c3ZOEysW+aIpylADAKA==
X-Received: by 2002:aa7:85cf:0:b029:1ee:8ae:533a with SMTP id z15-20020aa785cf0000b02901ee08ae533amr1486354pfn.30.1614317531108;
        Thu, 25 Feb 2021 21:32:11 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v185sm7960624pfb.125.2021.02.25.21.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 21:32:10 -0800 (PST)
Date:   Thu, 25 Feb 2021 21:32:10 -0800 (PST)
X-Google-Original-Date: Thu, 25 Feb 2021 21:31:51 PST (-0800)
Subject:     Re: [PATCH] riscv: Add KASAN_VMALLOC support
In-Reply-To: <bdef5309-03dd-6c0b-7d0c-9dd036ceae95@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        nylon7@andestech.com, nickhu@andestech.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-ea9a6037-0f18-41d5-8c01-6c16b14b6a63@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 23:48:13 PST (-0800), alex@ghiti.fr wrote:
> Le 2/25/21 à 2:42 AM, Alexandre Ghiti a écrit :
>> Populate the top-level of the kernel page table to implement KASAN_VMALLOC,
>> lower levels are filled dynamically upon memory allocation at runtime.
>>
>> Co-developed-by: Nylon Chen <nylon7@andestech.com>
>> Signed-off-by: Nylon Chen <nylon7@andestech.com>
>> Co-developed-by: Nick Hu <nickhu@andestech.com>
>> Signed-off-by: Nick Hu <nickhu@andestech.com>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   arch/riscv/Kconfig         |  1 +
>>   arch/riscv/mm/kasan_init.c | 35 ++++++++++++++++++++++++++++++++++-
>>   2 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 8eadd1cbd524..3832a537c5d6 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -57,6 +57,7 @@ config RISCV
>>   	select HAVE_ARCH_JUMP_LABEL
>>   	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>>   	select HAVE_ARCH_KASAN if MMU && 64BIT
>> +	select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>>   	select HAVE_ARCH_KGDB
>>   	select HAVE_ARCH_KGDB_QXFER_PKT
>>   	select HAVE_ARCH_MMAP_RND_BITS if MMU
>> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
>> index 719b6e4d6075..171569df4334 100644
>> --- a/arch/riscv/mm/kasan_init.c
>> +++ b/arch/riscv/mm/kasan_init.c
>> @@ -142,6 +142,31 @@ static void __init kasan_populate(void *start, void *end)
>>   	memset(start, KASAN_SHADOW_INIT, end - start);
>>   }
>>
>> +void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned long end)
>> +{
>> +	unsigned long next;
>> +	void *p;
>> +	pgd_t *pgd_k = pgd_offset_k(vaddr);
>> +
>> +	do {
>> +		next = pgd_addr_end(vaddr, end);
>> +		if (pgd_page_vaddr(*pgd_k) == (unsigned long)lm_alias(kasan_early_shadow_pmd)) {
>> +			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> +			set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
>> +		}
>> +	} while (pgd_k++, vaddr = next, vaddr != end);
>> +}
>> +
>> +void __init kasan_shallow_populate(void *start, void *end)
>> +{
>> +	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
>> +	unsigned long vend = PAGE_ALIGN((unsigned long)end);
>> +
>> +	kasan_shallow_populate_pgd(vaddr, vend);
>> +
>> +	local_flush_tlb_all();
>> +}
>> +
>>   void __init kasan_init(void)
>>   {
>>   	phys_addr_t _start, _end;
>> @@ -149,7 +174,15 @@ void __init kasan_init(void)
>>
>>   	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
>>   				    (void *)kasan_mem_to_shadow((void *)
>> -								VMALLOC_END));
>> +								VMEMMAP_END));
>> +	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
>> +		kasan_shallow_populate(
>> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
>> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
>> +	else
>> +		kasan_populate_early_shadow(
>> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
>> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
>>
>>   	for_each_mem_range(i, &_start, &_end) {
>>   		void *start = (void *)_start;
>>
>
> Palmer, this commit should replace (if everyone agrees) Nylon and Nick's
> Commit e178d670f251 ("riscv/kasan: add KASAN_VMALLOC support") that is
> already in for-next.

Sorry, but it's way too late to be rebasing things.  I can get trying to have
the history clean, but in this case we're better off having this as an explicit
fix patch -- changing hashes this late in the process messes with all the
testing.

I'm not sure what the issue actually is, so it'd be great if you could send the
fix patch.  If not then LMK and I'll try to figure out what's going on.  Either
way, having the fix will make sure this gets tested properly as whatever's
going on isn't failing for me.
