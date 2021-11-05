Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACAD44688B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhKESlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232730AbhKESli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:41:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAB9F61131;
        Fri,  5 Nov 2021 18:38:55 +0000 (UTC)
Date:   Fri, 5 Nov 2021 18:38:52 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Track no early_pgtable_alloc() for kmemleak
Message-ID: <YYV6PPpH6Y+APfsm@arm.com>
References: <20211105150509.7826-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105150509.7826-1-quic_qiancai@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 11:05:09AM -0400, Qian Cai wrote:
> After switched page size from 64KB to 4KB on several arm64 servers here,
> kmemleak starts to run out of early memory pool due to a huge number of
> those early_pgtable_alloc() calls:
> 
>   kmemleak_alloc_phys()
>   memblock_alloc_range_nid()
>   memblock_phys_alloc_range()
>   early_pgtable_alloc()
>   init_pmd()
>   alloc_init_pud()
>   __create_pgd_mapping()
>   __map_memblock()
>   paging_init()
>   setup_arch()
>   start_kernel()
> 
> Increased the default value of DEBUG_KMEMLEAK_MEM_POOL_SIZE by 4 times
> won't be enough for a server with 200GB+ memory. There isn't much
> interesting to check memory leaks for those early page tables and those
> early memory mappings should not reference to other memory. Hence, no
> kmemleak false positives, and we can safely skip tracking those early
> allocations from kmemleak like we did in the commit fed84c785270
> ("mm/memblock.c: skip kmemleak for kasan_init()") without needing to
> introduce complications to automatically scale the value depends on the
> runtime memory size etc. After the patch, the default value of
> DEBUG_KMEMLEAK_MEM_POOL_SIZE becomes sufficient again.
> 
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
