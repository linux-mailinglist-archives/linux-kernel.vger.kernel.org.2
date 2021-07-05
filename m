Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252D73BB608
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 05:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhGEEBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 00:01:09 -0400
Received: from foss.arm.com ([217.140.110.172]:36700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhGEEBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 00:01:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AB291063;
        Sun,  4 Jul 2021 20:58:31 -0700 (PDT)
Received: from [10.163.88.246] (unknown [10.163.88.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8ED53F694;
        Sun,  4 Jul 2021 20:58:28 -0700 (PDT)
Subject: Re: [PATCH] mm/debug_vm_pgtable: Fix corrupted PG_arch_1 by
 set_pmd_at()
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com
References: <20210702103225.51448-1-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <33cfab46-3b9b-0088-17b5-bc821c74aefb@arm.com>
Date:   Mon, 5 Jul 2021 09:29:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210702103225.51448-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gavin,

On 7/2/21 4:02 PM, Gavin Shan wrote:
> There are two addresses selected: random virtual address and physical
> address corresponding to kernel symbol @start_kernel. During the PMD
> tests in pmd_advanced_tests(), the physical address is aligned down
> to the starting address of the huge page, whose size is 512MB on ARM64
> when we have 64KB base page size. After that, set_pmd_at() is called
> to populate the PMD entry. PG_arch_1, PG_dcache_clean on ARM64, is
> set to the page flags. Unforunately, the page, corresponding to the
> starting address of the huge page could be owned by buddy. It means
> PG_arch_1 can be unconditionally set to page owned by buddy.
> 
> Afterwards, the page with PG_arch_1 set is fetched from buddy's free
> area list, but fails the checking. It leads to the following warning
> on ARM64:
> 
>    BUG: Bad page state in process memhog  pfn:08000
>    page:0000000015c0a628 refcount:0 mapcount:0 \
>         mapping:0000000000000000 index:0x1 pfn:0x8000
>    flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
>    raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
>    raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>    page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set

Does this problem happen right after the boot ? OR you ran some tests
and workloads to trigger this ? IIRC never seen this before on arm64.
Does this happen on other archs too ?

> 
> This fixes the issue by calling flush_dcache_page() after each call
> to set_{pud, pmd, pte}_at() because PG_arch_1 isn't needed in any case.

This (arm64 specific solution) might cause some side effects on other
platforms ? The solution here needs to be generic enough. I will take
a look into this patch but probably later this week or next week.

- Anshuman
