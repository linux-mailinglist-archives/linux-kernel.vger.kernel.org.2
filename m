Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D583CC784
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 06:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhGREdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 00:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGREdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 00:33:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE7C061764
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:30:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id my10so9248847pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYfpy1YnQDgIKqUyoAlZjkkXkJfZl99UdKpX40ZPhZE=;
        b=sLFKx5LtsrRys7pm2ElDRTbDpCdEM0vmi4Anhs6u6WTm+XbJDGSWE5YcIP1uy93k7b
         66I/MXSiii109dMlSJEfl1lxd94owKDCsaGO2hfukRkKg/kccCsL3Yj1Ivm7Ql9/MYL8
         X0GUCNlgWTadG7BAeSyUXW+IsW4BFV9vpCSOmz7j1/Gx1kZlHs08/YbXhox7XnFN8Msf
         lddOQ5tzoC512hMHrKR4MWVRlwDtGLygFrjE43PRQjVG0i1NoFz7besUtEVTZgj4IfJJ
         9ClUoM7SRcMM4/evBYNVwbQ6rcACj9ZXwEWFsM3kdX5/XlNLZG0POVQX1xelYQvD+wM1
         XLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYfpy1YnQDgIKqUyoAlZjkkXkJfZl99UdKpX40ZPhZE=;
        b=sOmm9rliMFVDloHvG7ZH1/ewEE16T9RdUWSxqGqCrAmbNdxyWvv97io4qmxI+jRJKL
         4Tn0/ruWVOoEIMz74iBSRPK/6QvC3/kh+aN9tzCshGIKX0Myz6UJ9EqOkozE59EuuKuQ
         l9LOFb9Bs/lq0C4NLfN+2IIhWU6jSQzYfqHWkxBJdCoa9vDj4VWRtIsqcbRUDkwtmRez
         ykfVHanZ09rGO/5GuKAJ+N5lwZ1rYkFG1py1Oo0vdOUMQcPiYwfGpdq6++SGiTPUuPfh
         r9kZ0HkGEqXq4WAE+qv5ooco5v2s3iSaQBQLoNLgDyJY0qAJGRlwnmOz3qJ2PlcojV90
         AZ+Q==
X-Gm-Message-State: AOAM5306weIxC8xJWr5+kI0b6iAnRLNOo3nxd8xrNESUhYf/r0RFI/bI
        I8YQJ/Uk1h1QjsajepQrMaNltQ==
X-Google-Smtp-Source: ABdhPJxe1Eu8phqsjGtA5z+wPbjpY7A6/eJCvQlAlDHhZIEkQI3OvRldFW8ebhvYvn/b+sLJYFZ2/w==
X-Received: by 2002:a17:902:968a:b029:11d:6448:1352 with SMTP id n10-20020a170902968ab029011d64481352mr13937205plp.59.1626582651254;
        Sat, 17 Jul 2021 21:30:51 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a22sm16263217pgv.84.2021.07.17.21.30.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 21:30:50 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 0/7] Free user PTE page table pages
Date:   Sun, 18 Jul 2021 12:30:26 +0800
Message-Id: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series aims to free user PTE page table pages when all PTE entries
are empty.

The beginning of this story is that some malloc libraries(e.g. jemalloc or
tcmalloc) usually allocate the amount of VAs by mmap() and do not unmap those VAs.
They will use madvise(MADV_DONTNEED) to free physical memory if they want.
But the page tables do not be freed by madvise(), so it can produce many
page tables when the process touches an enormous virtual address space.

The following figures are a memory usage snapshot of one process which actually
happened on our server:

	VIRT:  55t
	RES:   590g
	VmPTE: 110g

As we can see, the PTE page tables size is 110g, while the RES is 590g. In
theory, the process only need 1.2g PTE page tables to map those physical
memory. The reason why PTE page tables occupy a lot of memory is that
madvise(MADV_DONTNEED) only empty the PTE and free physical memory but
doesn't free the PTE page table pages. So we can free those empty PTE page
tables to save memory. In the above cases, we can save memory about 108g(best
case). And the larger the difference between the size of VIRT and RES, the
more memory we save.

In this patch series, we add a pte_refcount field to the struct page of page
table to track how many users of PTE page table. Similar to the mechanism of
page refcount, the user of PTE page table should hold a refcount to it before
accessing. The PTE page table page will be freed when the last refcount is
dropped.

Testing:

The following code snippet can show the effect of optimization:

	mmap 50G
	while (1) {
		for (; i < 1024 * 25; i++) {
			touch 2M memory
			madvise MADV_DONTNEED 2M
		}
	}

As we can see, the memory usage of VmPTE is reduced:

			before		                after
VIRT		       50.0 GB			      50.0 GB
RES		        3.1 MB			       3.6 MB
VmPTE		     102640 kB			       248 kB

I also have tested the stability by LTP[1] for several weeks. I have not seen
any crash so far.

The performance of page fault can be affected because of the allocation/freeing
of PTE page table pages. The following is the test result by using a micro
benchmark[2]:

root@~# perf stat -e page-faults --repeat 5 ./multi-fault $threads:

threads         before (pf/min)                     after (pf/min)
    1                32,085,255                         31,880,833 (-0.64%)
    8               101,674,967                        100,588,311 (-1.17%)
   16               113,207,000                        112,801,832 (-0.36%)

(The "pfn/min" means how many page faults in one minute.)

The performance of page fault is ~1% slower than before.

This series is based on next-20210708.

Patch 1 is a bug fix.
Patch 2-4 are code simplification.
Patch 5 free user PTE page tables dynamically.
Patch 6 defer freeing PTE page tables for a grace period.
Patch 7 uses mmu_gather to free PTE page tables.

Comments and suggestions are welcome.

Thanks,
Qi.

[1] https://github.com/linux-test-project/ltp
[2] https://lore.kernel.org/patchwork/comment/296794/

Qi Zheng (7):
	mm: fix the deadlock in finish_fault()
	mm: introduce pte_install() helper
	mm: remove redundant smp_wmb()
	mm: rework the parameter of lock_page_or_retry()
	mm: free user PTE page table pages
	mm: defer freeing PTE page table for a grace period
	mm: use mmu_gather to free PTE page table

 Documentation/vm/split_page_table_lock.rst |   2 +-
 arch/arm/mm/pgd.c                          |   2 +-
 arch/arm64/mm/hugetlbpage.c                |   4 +-
 arch/ia64/mm/hugetlbpage.c                 |   2 +-
 arch/parisc/mm/hugetlbpage.c               |   2 +-
 arch/powerpc/mm/hugetlbpage.c              |   2 +-
 arch/s390/mm/gmap.c                        |   8 +-
 arch/s390/mm/pgtable.c                     |   6 +-
 arch/sh/mm/hugetlbpage.c                   |   2 +-
 arch/sparc/mm/hugetlbpage.c                |   2 +-
 arch/x86/Kconfig                           |   2 +-
 arch/x86/kernel/tboot.c                    |   2 +-
 fs/proc/task_mmu.c                         |  23 ++-
 fs/userfaultfd.c                           |   2 +
 include/linux/mm.h                         |  12 +-
 include/linux/mm_types.h                   |   8 +-
 include/linux/pagemap.h                    |   8 +-
 include/linux/pgtable.h                    |   3 +-
 include/linux/pte_ref.h                    | 241 +++++++++++++++++++++++++
 include/linux/rmap.h                       |   3 +
 kernel/events/uprobes.c                    |   3 +
 mm/Kconfig                                 |   4 +
 mm/Makefile                                |   3 +-
 mm/debug_vm_pgtable.c                      |   3 +-
 mm/filemap.c                               |  56 +++---
 mm/gup.c                                   |  10 +-
 mm/hmm.c                                   |   4 +
 mm/internal.h                              |   2 +
 mm/khugepaged.c                            |  10 ++
 mm/ksm.c                                   |   4 +
 mm/madvise.c                               |  20 ++-
 mm/memcontrol.c                            |  11 +-
 mm/memory.c                                | 279 +++++++++++++++++++----------
 mm/mempolicy.c                             |   5 +-
 mm/migrate.c                               |  21 ++-
 mm/mincore.c                               |   6 +-
 mm/mlock.c                                 |   1 +
 mm/mmu_gather.c                            |  40 ++---
 mm/mprotect.c                              |  10 +-
 mm/mremap.c                                |  12 +-
 mm/page_vma_mapped.c                       |   4 +
 mm/pagewalk.c                              |  19 +-
 mm/pgtable-generic.c                       |   2 +
 mm/pte_ref.c                               | 146 +++++++++++++++
 mm/rmap.c                                  |  13 +-
 mm/sparse-vmemmap.c                        |   2 +-
 mm/swapfile.c                              |   6 +-
 mm/userfaultfd.c                           |  15 +-
 48 files changed, 825 insertions(+), 222 deletions(-)
 create mode 100644 include/linux/pte_ref.h
 create mode 100644 mm/pte_ref.c

-- 
2.11.0

