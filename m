Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4847E3B26B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhFXFWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229723AbhFXFWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624512020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=zjK5FrfS56jBAE7tD+2yhphsprITvBTbxytF6Btlfas=;
        b=N1xn4+602+f8toyvTDUb4dpiFCOSEDFDri3sGdZHY88bi6Zttppjqax6DHsLp5PLxEHHdp
        ft/RuRGWLkISQZzufUOom31YPWuSOnEyGy98fpDtp+G9lG1ILbtbV/cNjVooucrosmuJ5/
        FNTlmOJskYu2XAfzkeL1rY6LfiFAiQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-O-HYd86sOH2_4LDrXix-Pw-1; Thu, 24 Jun 2021 01:20:16 -0400
X-MC-Unique: O-HYd86sOH2_4LDrXix-Pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C85FD1835AC2;
        Thu, 24 Jun 2021 05:20:14 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A431519711;
        Thu, 24 Jun 2021 05:20:11 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org, rientjes@google.com,
        rppt@linux.ibm.com, thomas.lendacky@amd.com, brijesh.singh@amd.com,
        kexec@lists.infradead.org, bhe@redhat.com
Subject: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Date:   Thu, 24 Jun 2021 13:20:08 +0800
Message-Id: <20210624052010.5676-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, when crash triggered, an OOM can always be observed in kdump
kernel as below:

~~~~~~~~~
 DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
 swapper/0: page allocation failure: order:5, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-0.rc5.20210611git929d931f2b40.42.fc35.x86_64 #1
 Hardware name: Dell Inc. PowerEdge R910/0P658H, BIOS 2.12.0 06/04/2018
 Call Trace:
  dump_stack+0x7f/0xa1
  warn_alloc.cold+0x72/0xd6
  ? _raw_spin_unlock_irq+0x24/0x40
  ? __alloc_pages_direct_compact+0x90/0x1b0
  __alloc_pages_slowpath.constprop.0+0xf29/0xf50
  ? __cond_resched+0x16/0x50
  ? prepare_alloc_pages.constprop.0+0x19d/0x1b0
  __alloc_pages+0x24d/0x2c0
  ? __dma_atomic_pool_init+0x93/0x93
  alloc_page_interleave+0x13/0xb0
  atomic_pool_expand+0x118/0x210
  ? __dma_atomic_pool_init+0x93/0x93
  __dma_atomic_pool_init+0x45/0x93
  dma_atomic_pool_init+0xdb/0x176
  do_one_initcall+0x67/0x320
  ? rcu_read_lock_sched_held+0x3f/0x80
  kernel_init_freeable+0x290/0x2dc
  ? rest_init+0x24f/0x24f
  kernel_init+0xa/0x111
  ret_from_fork+0x22/0x30
 Mem-Info:
 ......
 DMA: failed to allocate 128 KiB GFP_KERNEL|GFP_DMA pool for atomic allocation
 DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
~~~~~~~~~~~

This OOM can be noticed since commit f1d4d47c5851 ("x86/setup: Always
reserve the first 1M of RAM") is merged. The root cause is there's no
available memory in DMA zone in kdump kernel after commit f1d4d47c5851.

In the current atomic pool implementation, there are three atomic mem
pools: atomic_pool_kernel, atomic_pool_dma, atomic_pool_dma32, initialized
with flag GFP_KERNEL, GFP_KERNEL|GFP_DMA, GFP_KERNEL|GFP_DMA32. On x86_64,
normal kernel can allocate all three of them. While, kdump kernel can't
satisfy atomic_pool_dma initialization because there's only low-1M present
for DMA zone, and locked in commit f1d4d47c5851 so that the low-1M won't be
put in buddy allocator.

The atomic pool is generic, and enabled always no matter if
coherent_pool is specify in kernel cmdline or not. Seems the always enabling
of atomic pool is required by AMD MEM ENCRYPTION if CONFIG_DMA_DIRECT_REMAP
is not set, even though the system is non-AMD cpu, or non-x86 ARCHes.
AFAIK, SME requires swiotlb by default. Not sure if atomic has to be
provided, can we disable it in some cases, e.g in kdump kernel?

In this RFC patch, I change the current coherent_pool kernel parameter
to make it allow user to disable atomic pool if not needed with
coherent_pool=0.

If enabling atomic pool is mandatory for SME, maybe we can adjust and
add kernel parameter like, coherent_pool= to specify which pool is
needed, coherent_pool_size= to specify the initialization size: 
coherent_pool= (bit0:kernel, bit1: dma,  bit2:dma32, 
coherent_pool_size= size (range from 128K to 4M).

Any comment or suggestion is appreciated.

Baoquan He (2):
  docs: kernel-parameters: Update to reflect the current default size of
    atomic pool
  dma-pool: allow user to disable atomic pool

 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 kernel/dma/pool.c                               | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.17.2

