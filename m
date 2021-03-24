Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48C0347BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbhCXPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbhCXPGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:06:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD64C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hVxZXX/ZU/3XdwG31rSSlYrNlBfhoK+5PYvevGCxNoM=; b=YkXU1cN7hCBsBij95SU20l3a5c
        mKZGgceOPFOc4TikwTUErQVfXX90kOGHTrO2lrEjsoy0DPidFCk78dO+3T34Yx0j+BCWBr6n/nfMn
        5mdDmm1eeHgxH4dQgfIlNdM2LYSZ4ObkdPrpg51c5YiEW864AXC0Dn+4FYzva72Zybn1mJUFywB9L
        cBQYMM9968oAqMF5P7nas9hmdcMPuMNv/YyPk9uW7OIE3PF+X1GSnvBu2/pKUwMr0numszjLrfhLB
        YvowrlrzWxvt5gAzVP36Yjn0DtsCZpBWkrqiLorRIoBUtTxLBd0ysFblcnK0GFGxfJceSJfvv4U8T
        GBzzwe9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lP54R-00BTOu-Vw; Wed, 24 Mar 2021 15:05:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/4] vmalloc: Improve vmalloc(4MB) performance
Date:   Wed, 24 Mar 2021 15:05:14 +0000
Message-Id: <20210324150518.2734402-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I may have gone a little too far with the first patch.  It turns out we
have a lot of code using the vmalloc caller functionality, and I decided
to convert it all to unsigned long instead of leaving some paths as void *
and casting later.

I can redo that if necessary.  I've tested arm32, sh4 and powerpc32 builds
as well as x86, but I wouldn't be surprised if the buildbots tell me I
missed something.

Matthew Wilcox (Oracle) (4):
  mm/vmalloc: Change the 'caller' type to unsigned long
  mm/util: Add kvmalloc_node_caller
  mm/vmalloc: Use kvmalloc to allocate the table of pages
  MAINTAINERS: Add Vlad Rezki as vmalloc maintainer

 MAINTAINERS                               |  7 +++
 arch/arm/include/asm/io.h                 |  6 +--
 arch/arm/include/asm/mach/map.h           |  3 --
 arch/arm/kernel/module.c                  |  4 +-
 arch/arm/mach-imx/mm-imx3.c               |  2 +-
 arch/arm/mach-ixp4xx/common.c             |  2 +-
 arch/arm/mach-mvebu/coherency.c           |  2 +-
 arch/arm/mm/ioremap.c                     | 27 +++++------
 arch/arm/mm/mmu.c                         | 10 ++--
 arch/arm/mm/nommu.c                       | 16 +++---
 arch/arm64/include/asm/vmap_stack.h       |  2 +-
 arch/arm64/kernel/module.c                |  5 +-
 arch/arm64/kernel/probes/kprobes.c        |  2 +-
 arch/arm64/mm/ioremap.c                   |  7 ++-
 arch/arm64/mm/mmu.c                       |  2 +-
 arch/arm64/net/bpf_jit_comp.c             |  3 +-
 arch/mips/kernel/module.c                 |  2 +-
 arch/nds32/kernel/module.c                |  2 +-
 arch/parisc/kernel/module.c               |  5 +-
 arch/powerpc/include/asm/io-workarounds.h |  2 +-
 arch/powerpc/include/asm/io.h             |  6 +--
 arch/powerpc/kernel/io-workarounds.c      |  2 +-
 arch/powerpc/kernel/irq.c                 |  2 +-
 arch/powerpc/kernel/module.c              |  3 +-
 arch/powerpc/kernel/pci_64.c              |  3 +-
 arch/powerpc/mm/ioremap.c                 | 10 ++--
 arch/powerpc/mm/ioremap_32.c              |  8 +--
 arch/powerpc/mm/ioremap_64.c              |  4 +-
 arch/riscv/kernel/module.c                |  2 +-
 arch/riscv/net/bpf_jit_comp64.c           |  2 +-
 arch/s390/kernel/module.c                 |  2 +-
 arch/s390/kernel/setup.c                  |  3 +-
 arch/sh/include/asm/io.h                  | 11 ++---
 arch/sh/kernel/cpu/sh4/sq.c               |  2 +-
 arch/sh/mm/ioremap.c                      |  2 +-
 arch/sh/mm/pmb.c                          |  2 +-
 arch/sparc/kernel/module.c                |  2 +-
 arch/x86/hyperv/hv_init.c                 |  3 +-
 arch/x86/kernel/module.c                  |  3 +-
 arch/x86/mm/ioremap.c                     | 20 ++++----
 include/linux/mm.h                        |  4 +-
 include/linux/slab.h                      |  2 +
 include/linux/vmalloc.h                   | 22 ++++-----
 kernel/bpf/syscall.c                      |  2 +-
 kernel/fork.c                             |  2 +-
 kernel/module.c                           |  2 +-
 kernel/scs.c                              |  3 +-
 lib/test_vmalloc.c                        |  7 ++-
 mm/ioremap.c                              |  3 +-
 mm/kasan/shadow.c                         |  5 +-
 mm/nommu.c                                |  4 +-
 mm/util.c                                 | 52 +++++++++++---------
 mm/vmalloc.c                              | 59 +++++++++--------------
 53 files changed, 172 insertions(+), 198 deletions(-)

-- 
2.30.2

