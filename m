Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8686A445805
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhKDRMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232134AbhKDRMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:12:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A544B610D0;
        Thu,  4 Nov 2021 17:10:02 +0000 (UTC)
Date:   Thu, 4 Nov 2021 17:09:59 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Track no early_pgtable_alloc() for kmemleak
Message-ID: <YYQT50hRmXb/amVp@arm.com>
References: <20211104155623.11158-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104155623.11158-1-quic_qiancai@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 11:56:23AM -0400, Qian Cai wrote:
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

Looks fine to me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
