Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003EC3F116A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhHSDUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhHSDUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:20:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A29C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:19:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c17so3125273plz.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u16iA5+owOG8vnM7VIDZOY9VYSsCqqEpRvLkiJHowJM=;
        b=TVwWpKoMKTB6tvz0kTGMhVMV4ci7WhwCOo3+J56GdY/MhqDwcDqBdErARKHiMgmVAi
         q46xwGumQRIhwwWleGasRyEDIv8Q+AITHHeDalA3BBbH6wY2u+9V65YR8eO3YYh7o0/0
         sIec4mbMQZ6SsvWA6oWjqr91sxF/oieELjhTP+fOfgzuPbEQIKzZh+4t26FLOzr7iwd8
         Dov3xd1Gb31Lxb0WUyOZgL8hHgNCdL9VZKErStf+XgktfV0W/8M/lF9Cw9DIH8huCdyA
         QDa2Ptv2boSa3Sy67vZla0vYJ3F9i/ip0Q4O3kvPQPGBDPVJIWxiXh6Vh9mvTUgr962+
         KOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u16iA5+owOG8vnM7VIDZOY9VYSsCqqEpRvLkiJHowJM=;
        b=VoSE3n7VDyPWOSEXNiXkqO6NyGOdPuJSoSvM8dYNpifYZ0ZyMq/9FrPfSzo0Nx2mJt
         n5kdIHDT6w6uYm4nPZT1+rF/vEjj61XuLS088GSnd1w5kBIvGKOA48dJdzoSGbIl2XAS
         fi/1JAwL73IIWBn1kbtAw/ycN0OWiqu/Me0fucQlAG0VgnkRGl+ZCiLXCSQswsaNz6kw
         GjkXsq4bLYT9LGS07QjZvwRf+FfZQk368r52DpCHS8ARIKAJ1+8VBWkHlBumyzjk1Ed7
         6clXldmjTX+fQNFaXw+jLXaTaWiuWcSW3/P9ziRFhvN1qDzG0uqkw3bcUvqqhhyQn3Xd
         FmqQ==
X-Gm-Message-State: AOAM531UcYtWTRqqTUD4439eu/6nqKH+qRLsg4FXL+/mEn17CiKRCi/F
        pjp54EjoBAM4QWuDYpUwgdPp2w==
X-Google-Smtp-Source: ABdhPJxMfD1wT2G89D25CGwS7u4ooQKwkTepp8xoAKuviQqL6trtAYnR+VMydQdzLzgERm8TXNzviQ==
X-Received: by 2002:a17:90a:a581:: with SMTP id b1mr9508225pjq.146.1629343194024;
        Wed, 18 Aug 2021 20:19:54 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id k3sm1261276pfc.16.2021.08.18.20.19.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 20:19:53 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 0/9] Free user PTE page table pages
Date:   Thu, 19 Aug 2021 11:18:49 +0800
Message-Id: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series is based on next-20210812.

Comments and suggestions are welcome.

Thanks,
Qi.

[1] https://github.com/linux-test-project/ltp
[2] https://lore.kernel.org/patchwork/comment/296794/

Changelog in v1 -> v2:
 - Change pte_install() to pmd_install().
 - Fix some typo and code style problems.
 - Split [PATCH v1 5/7] into [PATCH v2 4/9], [PATCH v2 5/9]，[PATCH v2 6/9]
   and [PATCH v2 7/9].

Qi Zheng (9):
  mm: introduce pmd_install() helper
  mm: remove redundant smp_wmb()
  mm: rework the parameter of lock_page_or_retry()
  mm: move pte_alloc{,_map,_map_lock}() to a separate file
  mm: pte_refcount infrastructure
  mm: free user PTE page table pages
  mm: add THP support for pte_ref
  mm: free PTE page table by using rcu mechanism
  mm: use mmu_gather to free PTE page table

 arch/arm/mm/pgd.c             |   1 +
 arch/arm64/mm/hugetlbpage.c   |   1 +
 arch/ia64/mm/hugetlbpage.c    |   1 +
 arch/parisc/mm/hugetlbpage.c  |   1 +
 arch/powerpc/mm/hugetlbpage.c |   1 +
 arch/s390/mm/gmap.c           |   1 +
 arch/s390/mm/pgtable.c        |   1 +
 arch/sh/mm/hugetlbpage.c      |   1 +
 arch/sparc/mm/hugetlbpage.c   |   1 +
 arch/x86/Kconfig              |   2 +-
 fs/proc/task_mmu.c            |  22 +++-
 fs/userfaultfd.c              |   2 +
 include/linux/mm.h            |  12 +-
 include/linux/mm_types.h      |   8 +-
 include/linux/pagemap.h       |   8 +-
 include/linux/pgtable.h       |   3 +-
 include/linux/pte_ref.h       | 300 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/rmap.h          |   4 +-
 kernel/events/uprobes.c       |   3 +
 mm/Kconfig                    |   4 +
 mm/Makefile                   |   3 +-
 mm/filemap.c                  |  57 ++++----
 mm/gup.c                      |   7 +
 mm/hmm.c                      |   4 +
 mm/internal.h                 |   2 +
 mm/khugepaged.c               |   9 ++
 mm/ksm.c                      |   4 +
 mm/madvise.c                  |  18 ++-
 mm/memcontrol.c               |  11 +-
 mm/memory.c                   | 276 ++++++++++++++++++++++++--------------
 mm/mempolicy.c                |   4 +-
 mm/migrate.c                  |  18 +--
 mm/mincore.c                  |   5 +-
 mm/mlock.c                    |   1 +
 mm/mmu_gather.c               |  40 +++---
 mm/mprotect.c                 |  10 +-
 mm/mremap.c                   |  12 +-
 mm/page_vma_mapped.c          |   4 +
 mm/pagewalk.c                 |  16 ++-
 mm/pgtable-generic.c          |   2 +
 mm/pte_ref.c                  | 143 ++++++++++++++++++++
 mm/rmap.c                     |  13 ++
 mm/sparse-vmemmap.c           |   2 +-
 mm/swapfile.c                 |   3 +-
 mm/userfaultfd.c              |  18 ++-
 45 files changed, 849 insertions(+), 210 deletions(-)
 create mode 100644 include/linux/pte_ref.h
 create mode 100644 mm/pte_ref.c

-- 
2.11.0

