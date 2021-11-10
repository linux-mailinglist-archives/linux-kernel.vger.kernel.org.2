Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFD344BF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhKJK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhKJK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:57:27 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFEDC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:54:40 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id o14so2664036plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/UIyi2eJnbBswQCTGuCTS0LM6W4YfTsCnVJtEHRzCs=;
        b=U73ccdfuDEsEMpM8L6n049Ot81bYGq02czX9Hqxe85JwfCGxR7q/ttdAXTd17yIPvD
         a4a27VEaS6HqO0Ikrpz9oz4BYgsRfEuUEJISsauTOieEBZbeCE+yjecEUWJwU75o7w8J
         V0b72UMWoULNwTD9JXyt3x6dshaFp4aPvDIBQ+CmaibDTxFxhzL1JX8lN1oC1YIUtVUI
         daGuPHo9kMaRLLnMiaB2c35Fw9KIXfeopnd4eDshfoiSDx5XX2rPtToDsm6CY6xcvkgi
         EQ7z+hLgFppx1cuq8i85jPggLDmn1Zs/W190KaIw9vRruLpjx4jXVEYLytTOlPiBmOXW
         cz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/UIyi2eJnbBswQCTGuCTS0LM6W4YfTsCnVJtEHRzCs=;
        b=rziKt5hYEwYRtJLDqtF/9UTFrd9glWzlv5l4XplQ0QdzLBam2PRofDom+DpqFqqJqj
         QKlR7ho3gflBAx1Fi+ECW6f+sCN3uE1+R1agBhAKhFCQg7kw1/ywf72MVEK/GTNhdrZg
         2mUrHzUfP7y0xsDlvAQH4o6IiozdkuPFJFCsMI5XlnbCQS7XUd/puRUE3qchkyUmuiBo
         FSzBUkbdwXD4//P8AxmBIDdHtsYWce1GvATlbYn8PiO73Z/kvVEEtNPpzA11eiU8TO7O
         sGPhGnFbrMEn1SI5xI+1s+EvJGpn6QKP1V5qZx6FXipIiFjWBNzfHjBPT1qEv6vTiAHA
         NhOg==
X-Gm-Message-State: AOAM531FM3ck6Yc+aVebdnAXFV94uIAV575Xq1qHgj7GmZKkL358etIC
        LwVkVK6Bt99lcO/rUnEMoWfEnQ==
X-Google-Smtp-Source: ABdhPJxTLXiijd/xTunvn0tdt3uMrsZe5eQHkgxm/a/TpzIc6/vTeft799MpYo40V9j6VSdTmbSk1w==
X-Received: by 2002:a17:902:d488:b0:141:f3a3:d2f4 with SMTP id c8-20020a170902d48800b00141f3a3d2f4mr14903254plg.86.1636541679735;
        Wed, 10 Nov 2021 02:54:39 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5865829pgl.38.2021.11.10.02.54.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:54:39 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 00/15] Free user PTE page table pages
Date:   Wed, 10 Nov 2021 18:54:13 +0800
Message-Id: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
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

                        before                          after
VIRT                   50.0 GB                        50.0 GB
RES                     3.1 MB                         3.6 MB
VmPTE                102640 kB                         248 kB

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

And there are no obvious changes in perf hot spots:

before:
  19.29%  [kernel]  [k] clear_page_rep
  16.12%  [kernel]  [k] do_user_addr_fault
   9.57%  [kernel]  [k] _raw_spin_unlock_irqrestore
   6.16%  [kernel]  [k] get_page_from_freelist
   5.03%  [kernel]  [k] __handle_mm_fault
   3.53%  [kernel]  [k] __rcu_read_unlock
   3.45%  [kernel]  [k] handle_mm_fault
   3.38%  [kernel]  [k] down_read_trylock
   2.74%  [kernel]  [k] free_unref_page_list
   2.17%  [kernel]  [k] up_read
   1.93%  [kernel]  [k] charge_memcg
   1.73%  [kernel]  [k] try_charge_memcg
   1.71%  [kernel]  [k] __alloc_pages
   1.69%  [kernel]  [k] ___perf_sw_event
   1.44%  [kernel]  [k] get_mem_cgroup_from_mm

after:
  18.19%  [kernel]  [k] clear_page_rep
  16.28%  [kernel]  [k] do_user_addr_fault
   8.39%  [kernel]  [k] _raw_spin_unlock_irqrestore
   5.12%  [kernel]  [k] get_page_from_freelist
   4.81%  [kernel]  [k] __handle_mm_fault
   4.68%  [kernel]  [k] down_read_trylock
   3.80%  [kernel]  [k] handle_mm_fault
   3.59%  [kernel]  [k] get_mem_cgroup_from_mm
   2.49%  [kernel]  [k] free_unref_page_list
   2.41%  [kernel]  [k] up_read
   2.16%  [kernel]  [k] charge_memcg
   1.92%  [kernel]  [k] __rcu_read_unlock
   1.88%  [kernel]  [k] ___perf_sw_event
   1.70%  [kernel]  [k] pte_get_unless_zero

This series is based on next-20211108.

Comments and suggestions are welcome.

Thanks,
Qi.

[1] https://github.com/linux-test-project/ltp
[2] https://lore.kernel.org/lkml/20100106160614.ff756f82.kamezawa.hiroyu@jp.fujitsu.com/2-multi-fault-all.c

Changelog in v2 -> v3:
 - Refactored this patch series:
        - [PATCH v3 6/15]: Introduce the new dummy helpers first
        - [PATCH v3 7-12/15]: Convert each subsystem individually
        - [PATCH v3 13/15]: Implement the actual logic to the dummy helpers
   And thanks for the advice from David and Jason.
 - Add a document.

Changelog in v1 -> v2:
 - Change pte_install() to pmd_install().
 - Fix some typo and code style problems.
 - Split [PATCH v1 5/7] into [PATCH v2 4/9], [PATCH v2 5/9]，[PATCH v2 6/9]
   and [PATCH v2 7/9].

Qi Zheng (15):
  mm: do code cleanups to filemap_map_pmd()
  mm: introduce is_huge_pmd() helper
  mm: move pte_offset_map_lock() to pgtable.h
  mm: rework the parameter of lock_page_or_retry()
  mm: add pmd_installed_type return for __pte_alloc() and other friends
  mm: introduce refcount for user PTE page table page
  mm/pte_ref: add support for user PTE page table page allocation
  mm/pte_ref: initialize the refcount of the withdrawn PTE page table
    page
  mm/pte_ref: add support for the map/unmap of user PTE page table page
  mm/pte_ref: add support for page fault path
  mm/pte_ref: take a refcount before accessing the PTE page table page
  mm/pte_ref: update the pmd entry in move_normal_pmd()
  mm/pte_ref: free user PTE page table pages
  Documentation: add document for pte_ref
  mm/pte_ref: use mmu_gather to free PTE page table pages

 Documentation/vm/pte_ref.rst | 216 ++++++++++++++++++++++++++++++++++++
 arch/x86/Kconfig             |   2 +-
 fs/proc/task_mmu.c           |  24 +++-
 fs/userfaultfd.c             |   9 +-
 include/linux/huge_mm.h      |  10 +-
 include/linux/mm.h           | 170 ++++-------------------------
 include/linux/mm_types.h     |   6 +-
 include/linux/pagemap.h      |   8 +-
 include/linux/pgtable.h      | 152 +++++++++++++++++++++++++-
 include/linux/pte_ref.h      | 146 +++++++++++++++++++++++++
 include/linux/rmap.h         |   2 +
 kernel/events/uprobes.c      |   2 +
 mm/Kconfig                   |   4 +
 mm/Makefile                  |   4 +-
 mm/damon/vaddr.c             |  12 +-
 mm/debug_vm_pgtable.c        |   5 +-
 mm/filemap.c                 |  45 +++++---
 mm/gup.c                     |  25 ++++-
 mm/hmm.c                     |   5 +-
 mm/huge_memory.c             |   3 +-
 mm/internal.h                |   4 +-
 mm/khugepaged.c              |  21 +++-
 mm/ksm.c                     |   6 +-
 mm/madvise.c                 |  21 +++-
 mm/memcontrol.c              |  12 +-
 mm/memory-failure.c          |  11 +-
 mm/memory.c                  | 254 ++++++++++++++++++++++++++++++++-----------
 mm/mempolicy.c               |   6 +-
 mm/migrate.c                 |  54 ++++-----
 mm/mincore.c                 |   7 +-
 mm/mlock.c                   |   1 +
 mm/mmu_gather.c              |  40 +++----
 mm/mprotect.c                |  11 +-
 mm/mremap.c                  |  14 ++-
 mm/page_vma_mapped.c         |   4 +
 mm/pagewalk.c                |  15 ++-
 mm/pgtable-generic.c         |   1 +
 mm/pte_ref.c                 | 141 ++++++++++++++++++++++++
 mm/rmap.c                    |  10 ++
 mm/swapfile.c                |   3 +
 mm/userfaultfd.c             |  40 +++++--
 41 files changed, 1186 insertions(+), 340 deletions(-)
 create mode 100644 Documentation/vm/pte_ref.rst
 create mode 100644 include/linux/pte_ref.h
 create mode 100644 mm/pte_ref.c

-- 
2.11.0

