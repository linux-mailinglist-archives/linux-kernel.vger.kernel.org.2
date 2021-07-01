Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D943B9696
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 21:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhGATdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 15:33:49 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51527 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGATdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 15:33:49 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id F0ED4240009;
        Thu,  1 Jul 2021 19:31:13 +0000 (UTC)
Subject: Re: [PATCH v8 0/2] Map the kernel with correct permissions the first
 time
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        jszhang@kernel.org, Christoph Hellwig <hch@infradead.org>,
        zong.li@sifive.com, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-0f00c990-c928-4a9d-ab2c-5036b29b2861@palmerdabbelt-glaptop>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <62e6dfc9-8d8d-d1df-1847-d6b8ad681eab@ghiti.fr>
Date:   Thu, 1 Jul 2021 21:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <mhng-0f00c990-c928-4a9d-ab2c-5036b29b2861@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 1/07/2021 à 07:37, Palmer Dabbelt a écrit :
> On Thu, 24 Jun 2021 05:00:39 PDT (-0700), alex@ghiti.fr wrote:
>> The kernel permissions are fixed after the kernel page table is created:
>> avoid that by mapping the kernel 'correctly' the first time.
>>
>> Patch 1 introduces a new helper to set kernel mapping permissions while
>> avoiding all the casts when using set_memory_* API.
>>
>> Patch 2  is the bulk of this work and deals with mapping the kernel with
>> the right permissions.
>>
>> Changes in v8:
>> * Move set_kernel_memory inline function into set_memory.h header as 
>> suggested
>>   by Jisheng
>> * Make set_kernel_memory arguments name consistent
>>
>> Changes in v7:
>> * Split long lines and reintroduce parameters names of set_kernel_memory
>>   callback, as suggested by Christoph
>> * Make set_kernel_memory __always_inline as suggested by Christoph
>> * Change 64b spelling into 64-bit, as suggested by Christoph
>>
>> Changes in v6:
>> * load_sz was placed in init section but is now used in kernel address
>>   conversions macros, so remove this attribute.
>>
>> Changes in v5:
>> * Remove non-relevant commits to this patchset that raised issues
>> * Make load_sz non-static as it is used in kernel address conversions
>>   macros
>> * Rebased on top for-next
>>
>> Changes in v4:
>> * Add patch 1 as noted by Jisheng
>> * Changes patch 2 title as suggested by Anup
>> * Add Reviewed-by from Anup
>>
>> Changes in v3:
>> * Add a patch that factorizes kernel address conversions
>> * Add a helper called set_kernel_memory in its own patch, as suggested by
>>   Christoph
>> * Prefer IS_ENABLED over #ifdef, as suggested by Christoph
>> * Split overly long lines, as suggested by Christoph
>> * Simplify kernel mapping by mapping ALL text as readonly and taking 
>> advantage
>>   of already present code that enables write for init text before
>>   free_initmem_default.
>>
>> Changes in v2:
>> * Rebased on top of for-next (and "riscv: mm: fix build errors caused by
>>   mk_pmd()")
>> * Get rid of protect_kernel_linear_mapping_text_rodata as suggested by
>>   Jisheng
>> * Improve code in general compared to previous RFC
>>
>> Alexandre Ghiti (2):
>>   riscv: Introduce set_kernel_memory helper
>>   riscv: Map the kernel with correct permissions the first time
>>
>>  arch/riscv/include/asm/page.h       |  13 +++-
>>  arch/riscv/include/asm/sections.h   |  17 +++++
>>  arch/riscv/include/asm/set_memory.h |  24 ++++--
>>  arch/riscv/kernel/setup.c           |  12 +--
>>  arch/riscv/mm/init.c                | 112 ++++++++++++----------------
>>  5 files changed, 97 insertions(+), 81 deletions(-)
> 
> I had what looks to be two earlier versions of these patches on 
> for-next.  I've fixed that up, but there were some merge conflicts. Let 
> me know if there were any issues, but it's really getting too late in 
> the cycle to be rebasing so I'd prefer just a fixup.
> 

The first 2 patches:

riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED
riscv: Simplify xip and !xip kernel address conversion macros

should *not* be merged as they assume the DRAM physical base address is 
0x8000_0000 for *all* rv64 chips. I have another patchset coming to 
replace those 2 patches.

Alex

> Thanks!
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
