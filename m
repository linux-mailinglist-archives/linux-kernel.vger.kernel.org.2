Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF77F3AB346
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhFQMKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:10:43 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33743 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhFQMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:10:41 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C9012C0013;
        Thu, 17 Jun 2021 12:08:28 +0000 (UTC)
Subject: Re: [PATCH v5 0/2] riscv: Map the kernel with correct permissions the
 first time
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210617120124.1752541-1-alex@ghiti.fr>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <3dbfd72c-6d51-5ae6-3e91-49ee52eed5bd@ghiti.fr>
Date:   Thu, 17 Jun 2021 14:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617120124.1752541-1-alex@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/06/2021 à 14:01, Alexandre Ghiti a écrit :
> The kernel permissions are fixed after the kernel page table is created:
> avoid that by mapping the kernel 'correctly' the first time.
>       
> Patch 1 introduces a new helper to set kernel mapping permissions while
> avoiding all the casts when using set_memory_* API.
>                                                                                   
> Patch 2  is the bulk of this work and deals with mapping the kernel with
> the right permissions.
> 
> Changes in v5:
> * Remove non-relevant commits to this patchset that raised issues
> * Make load_sz non-static as it is used in kernel address conversions
>    macros
> * Rebased on top for-next
> 
> Changes in v4:
> * Add patch 1 as noted by Jisheng
> * Changes patch 2 title as suggested by Anup
> * Add Reviewed-by from Anup
>                                                                                   
> Changes in v3:
> * Add a patch that factorizes kernel address conversions
> * Add a helper called set_kernel_memory in its own patch, as suggested by
>    Christoph
> * Prefer IS_ENABLED over #ifdef, as suggested by Christoph
> * Split overly long lines, as suggested by Christoph
> * Simplify kernel mapping by mapping ALL text as readonly and taking advantage
>    of already present code that enables write for init text before
>    free_initmem_default.
>                                                                                   
> Changes in v2:
> * Rebased on top of for-next (and "riscv: mm: fix build errors caused by
>    mk_pmd()")
> * Get rid of protect_kernel_linear_mapping_text_rodata as suggested by
>    Jisheng
> * Improve code in general compared to previous RFC
> 
> Alexandre Ghiti (2):
>    riscv: Introduce set_kernel_memory helper
>    riscv: Map the kernel with correct permissions the first time
> 
>   arch/riscv/include/asm/page.h       |  13 +++-
>   arch/riscv/include/asm/sections.h   |  17 +++++
>   arch/riscv/include/asm/set_memory.h |  13 ++--
>   arch/riscv/kernel/setup.c           |  11 +--
>   arch/riscv/mm/init.c                | 108 ++++++++++++----------------
>   arch/riscv/mm/pageattr.c            |  10 +++
>   6 files changed, 91 insertions(+), 81 deletions(-)
> 

@Palmer: I removed the previous patchset (v4) you took in for-next and 
cherry-picked those 2 while fixing conflicts, so if you do that in that 
order, you should not have any problem :)

Thanks,
