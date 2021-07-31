Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7A3DC412
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 08:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbhGaGjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 02:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhGaGjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 02:39:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EBC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:39:42 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id y10-20020a0cd98a0000b029032ca50bbea1so7542871qvj.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xqUeIqZ8Laqm1hjc5SKPZeq+KLOGVogqPJNCfLRzT78=;
        b=ClY3nsfbH/n05/YnjoMbG/qYn5BNCyQMmrF74ixgKDvRAnPSYsJTjDxlmP44IoQsSw
         hfw8gCbNkYYxdASa+fCR3Y253bAcQsoiBr94+xLo1HneAmgr9KQYZbFgoZkwcmq4Nhql
         Nyhs+nRUE8W+hQMrTF2gi1xv/A4B4N6YHf1Flsb9MoYHEHcQQZsKMPeiTddthEBrfVcC
         KQ/D0Xo4vgYODAYM8Pj5xVLyR5A9QwboLvK/lFmE7sD7OkEezJDupwYpSsGqPKYoPuIr
         1t7iE3Kh4a10k135s+tEsV6sqXG3JDHtZhI3DgTnpTs9yQ9NaxM7seLs12CKudUD/c4E
         D6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xqUeIqZ8Laqm1hjc5SKPZeq+KLOGVogqPJNCfLRzT78=;
        b=kbBlgzWerhbsQZ/p+NRlePt4t/rJiZXNbQBMkHi9Rtj9GgNlH0qg4iqoSptMiW0D4G
         vpOqEGDcu9JNc8xsYDHMrJ1dRBTQ2JiDLR543usTOe855xGAgg2TIOus07jUgRENvdXD
         RoVrKoicBNEUQT4oHMF1mrv/3nW8hBzyEJxwaX88vrT7FdY2piF2qoG0HTCW/KlFNWSj
         AVeGdF2/neAzTkf9w6eCxRnrzM4qI+B0EpVg/7dO5jpXehg/eAd4UdEcodi75HyeNvSZ
         9lTODM1plwUUwQ5BTgL1kPghIQetDtgAPbJcsSksmgekoReXyohrcBBX0yp5idnD+Mdr
         PyEA==
X-Gm-Message-State: AOAM533R5KDOipbpVKFEwbnwUhVHtyw2m0eVPu4GMzG1jrIVZQd4JpyN
        BfFJVFAvdujbhSWztAEPQjr7r6fJ00s=
X-Google-Smtp-Source: ABdhPJzL5m4UjbecB/fBMg9vAeXnswEYCl2l2UqB/0Gqow4tu/XQMVb9YRr7DA/K6lY49DfANaZtcMqOlF8=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:2b92:c131:b08a:84c7])
 (user=yuzhao job=sendgmr) by 2002:a0c:be8e:: with SMTP id n14mr6679960qvi.16.1627713581663;
 Fri, 30 Jul 2021 23:39:41 -0700 (PDT)
Date:   Sat, 31 Jul 2021 00:39:35 -0600
Message-Id: <20210731063938.1391602-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH 0/3] mm: optimize thp for reclaim and migration
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems using /sys/kernel/mm/transparent_hugepage/enabled=always can
experience memory pressure due to internal fragmentation from a large
number of thp. Userspace can leave many subpages untouched but reclaim
can't identify them based on the dirty bit (and drop them like what it
does to clean pages).

However, it's still possible to know whether a subpage is equivalent
to being clean by checking its content. When splitting a thp for
reclaim or migration, we can drop subpages that contain only zeros
and therefore avoid writing them back or duplicating them.

benchmark
=========
The best case scenario is only the first byte of head is non zero.
The worse case scenario is only the last byte of every subpage is non
zero.

zram 10GB
~~~~~~~~~
  best case   7.170s  3.559s  -50.36%
  worst case  8.216s  8.94s   +8.81%

swap 10GB
~~~~~~~~~
  best case   70.466s  3.544s   -94.97%
  worst case  67.014s  65.521s  -2.22% (noise)

(CONFIG_THP_SWAP=n)

zram (before)
=============
best case
~~~~~~~~~
  time    7.170s

  21.78%  clear_page_erms
  16.47%  zram_bvec_rw
   2.90%  clear_huge_page
   2.74%  _raw_spin_lock
   2.65%  page_vma_mapped_walk
   2.41%  flush_tlb_func
   2.21%  shrink_page_list
   1.55%  try_to_unmap_one
   1.29%  _raw_spin_lock_irqsave
   1.25%  page_counter_cancel
   1.21%  __mod_node_page_state
   1.17%  __mod_lruvec_page_state
   1.10%  add_to_swap_cache
   1.08%  xas_create
   1.07%  xas_store

worst case
~~~~~~~~~~
  time    8.216s

  17.27%  clear_page_erms
  13.25%  lzo1x_1_do_compress
   4.35%  zram_bvec_rw
   3.41%  memset_erms
   3.23%  _raw_spin_lock
   2.88%  page_vma_mapped_walk
   2.75%  clear_huge_page
   2.28%  flush_tlb_func
   1.92%  shrink_page_list
   1.39%  try_to_unmap_one
   1.21%  page_counter_cancel
   1.20%  zs_free
   1.14%  _raw_spin_lock_irqsave
   1.13%  xas_create
   1.02%  __mod_lruvec_page_state

zram (after)
============
best case
~~~~~~~~~
  time    3.559s

  44.55%  clear_page_erms
  27.74%  memchr_inv
   6.43%  clear_huge_page
   2.71%  split_huge_page_to_list
   1.79%  page_vma_mapped_walk
   1.31%  __split_huge_pmd
   1.21%  remove_migration_pte
   1.12%  __free_one_page

worst case
~~~~~~~~~~
  time    8.94s

  16.08%  clear_page_erms
  11.81%  memchr_inv
   9.62%  lzo1x_1_do_compress
   3.51%  memset_erms
   3.17%  zram_bvec_rw
   2.76%  _raw_spin_lock
   2.70%  clear_huge_page
   2.34%  flush_tlb_func
   2.25%  page_vma_mapped_walk
   1.56%  shrink_page_list
   1.33%  try_to_unmap_one
   1.07%  _raw_spin_lock_irqsave
   1.04%  xas_create
   1.01%  zs_free

disk (before)
============
best case
~~~~~~~~~
  time   70.466s

  23.38%  clear_page_erms
   3.91%  clear_huge_page
   3.32%  _raw_spin_lock
   2.95%  page_vma_mapped_walk
   2.43%  shrink_page_list
   2.25%  flush_tlb_func
   1.84%  try_to_unmap_one
   1.53%  _raw_spin_lock_irqsave
   1.45%  __mod_memcg_lruvec_state
   1.37%  page_counter_cancel
   1.17%  _raw_spin_lock_irq
   1.16%  xas_create
   1.12%  _find_next_bit
   1.11%  xas_store
   1.11%  add_to_swap_cache
   1.10%  __mod_node_page_state
   1.04%  __mod_lruvec_page_state
   1.04%  __free_one_page

worst case
~~~~~~~~~~
  time   67.014s

  25.54%  clear_page_erms
   4.36%  clear_huge_page
   3.51%  _raw_spin_lock
   2.97%  page_vma_mapped_walk
   2.85%  flush_tlb_func
   1.84%  try_to_unmap_one
   1.52%  shrink_page_list
   1.47%  __mod_memcg_lruvec_state
   1.42%  page_counter_cancel
   1.38%  _raw_spin_lock_irq
   1.28%  __mod_lruvec_page_state
   1.15%  _raw_spin_lock_irqsave
   1.13%  xas_load
   1.10%  add_to_swap_cache
   1.05%  __mod_node_page_state

disk (after)
============
best case
~~~~~~~~~
  time   3.544s

  42.58%  clear_page_erms
  27.44%  memchr_inv
   6.15%  clear_huge_page
   2.60%  split_huge_page_to_list
   1.74%  page_vma_mapped_walk
   1.26%  __free_one_page
   1.11%  remove_migration_pte
   1.10%  __split_huge_pmd
   1.08%  __list_del_entry_valid

worst case
~~~~~~~~~~
  time   65.521s

  21.83%  clear_page_erms
  14.39%  memchr_inv
   3.66%  clear_huge_page
   3.17%  _raw_spin_lock
   2.38%  page_vma_mapped_walk
   2.32%  flush_tlb_func
   1.59%  try_to_unmap_one
   1.39%  shrink_page_list
   1.26%  page_counter_cancel
   1.16%  __mod_memcg_lruvec_state
   1.11%  add_to_swap_cache
   1.05%  _raw_spin_lock_irq

test.c
======

  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/mman.h>
  #include <unistd.h>
  
  #define handle_error(msg) \
    do { perror(msg); exit(EXIT_FAILURE); } while (0)
  
  int main(int argc, char **argv)
  {
    char *addr;
    size_t size;
    int offset, num_dirty;
    int ret;
  
    if (argc != 4) {
      printf("Usage: ./a.out SIZE OFFSET NUM_DIRTY\n"
             "SIZE: Size of mmap region in MB\n"
             "OFFSET: Offset of (first) dirty byte in each 4KB page, 0 ~ 4095\n"
             "NUM_DIRTY: Number of dirty 4KB pages in each 2MB region, 0 ~ 512\n");
      return -1;
    }
    
    size = (size_t)(((size_t)atoi(argv[1])) << 20);
    offset = atoi(argv[2]);
    num_dirty = atoi(argv[3]);
  
    addr = (char *)mmap(NULL, size , PROT_READ | PROT_WRITE,
                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    
    if (addr == MAP_FAILED)
      handle_error("mmap");
  
    ret = madvise(addr, size, MADV_HUGEPAGE);
  
    if (ret == -1)
      handle_error("mmap hugepage");
  
    for (size_t i = 0; i < size; i += (1 << 21))
      for (size_t j = 0; j < (num_dirty << 12); j += (1 << 12))
        memset(addr + i + j + offset, 0xff, 1);
  
    ret = madvise(addr, size, MADV_PAGEOUT);
    if (ret == -1)
      handle_error("mmap pageout");
  
    ret = munmap(addr, size);
    if (ret == -1)
      handle_error("munmap");
  
    return 0;
  }

Yu Zhao (3):
  mm: don't take lru lock when splitting isolated thp
  mm: free zapped tail pages when splitting isolated thp
  mm: don't remap clean subpages when splitting isolated thp

 include/linux/rmap.h          |  2 +-
 include/linux/vm_event_item.h |  2 ++
 mm/huge_memory.c              | 63 ++++++++++++++++++++++++---------
 mm/migrate.c                  | 65 ++++++++++++++++++++++++++++++-----
 mm/vmstat.c                   |  2 ++
 5 files changed, 107 insertions(+), 27 deletions(-)

-- 
2.32.0.554.ge1b32706d8-goog

