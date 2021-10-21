Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EACB435CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhJUIb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhJUIbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:31:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9654860FC0;
        Thu, 21 Oct 2021 08:29:38 +0000 (UTC)
Date:   Thu, 21 Oct 2021 09:29:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Revert "memblock: exclude NOMAP regions from
 kmemleak"
Message-ID: <YXEk7zWSIDbzYSTs@arm.com>
References: <20211021070929.23272-1-rppt@kernel.org>
 <20211021070929.23272-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021070929.23272-2-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 10:09:28AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Commit 6e44bd6d34d6 ("memblock: exclude NOMAP regions from kmemleak")
> breaks boot on EFI systems with kmemleak and VM_DEBUG enabled:
> 
> efi: Processing EFI memory map:
> efi:   0x000090000000-0x000091ffffff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> efi:   0x000092000000-0x0000928fffff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> ------------[ cut here ]------------
> kernel BUG at mm/kmemleak.c:1140!
> Internal error: Oops - BUG: 0 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc6-next-20211019+ #104
> pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : kmemleak_free_part_phys+0x64/0x8c
> lr : kmemleak_free_part_phys+0x38/0x8c
> sp : ffff800011eafbc0
> x29: ffff800011eafbc0 x28: 1fffff7fffb41c0d x27: fffffbfffda0e068
> x26: 0000000092000000 x25: 1ffff000023d5f94 x24: ffff800011ed84d0
> x23: ffff800011ed84c0 x22: ffff800011ed83d8 x21: 0000000000900000
> x20: ffff800011782000 x19: 0000000092000000 x18: ffff800011ee0730
> x17: 0000000000000000 x16: 0000000000000000 x15: 1ffff0000233252c
> x14: ffff800019a905a0 x13: 0000000000000001 x12: ffff7000023d5ed7
> x11: 1ffff000023d5ed6 x10: ffff7000023d5ed6 x9 : dfff800000000000
> x8 : ffff800011eaf6b7 x7 : 0000000000000001 x6 : ffff800011eaf6b0
> x5 : 00008ffffdc2a12a x4 : ffff7000023d5ed7 x3 : 1ffff000023dbf99
> x2 : 1ffff000022f0463 x1 : 0000000000000000 x0 : ffffffffffffffff
> Call trace:
>  kmemleak_free_part_phys+0x64/0x8c
>  memblock_mark_nomap+0x5c/0x78
>  reserve_regions+0x294/0x33c
>  efi_init+0x2d0/0x490
>  setup_arch+0x80/0x138
>  start_kernel+0xa0/0x3ec
>  __primary_switched+0xc0/0xc8
> Code: 34000041 97d526e7 f9418e80 36000040 (d4210000)
> random: get_random_bytes called from print_oops_end_marker+0x34/0x80 with crng_init=0
> ---[ end trace 0000000000000000 ]---
> 
> The crash happens because kmemleak_free_part_phys() tries to use __va()
> before memstart_addr is initialized and this triggers a VM_BUG_ON() in
> arch/arm64/include/asm/memory.h:
> 
> Revert 6e44bd6d34d6 ("memblock: exclude NOMAP regions from kmemleak"), the
> issue it is fixing will be fixed differently.
> 
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
