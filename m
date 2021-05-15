Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1A381A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhEORWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 13:22:00 -0400
Received: from aliyun-cloud.icoremail.net ([47.90.104.110]:42623 "HELO
        aliyun-sdnproxy-3.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S234101AbhEORVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:21:49 -0400
X-Greylist: delayed 722 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 May 2021 13:21:48 EDT
Received: from laptop (unknown [125.216.246.30])
        by front (Coremail) with SMTP id AWSowACnr_8+_p9goLWaAA--.52335S3;
        Sun, 16 May 2021 01:00:50 +0800 (CST)
Date:   Sun, 16 May 2021 01:01:04 +0800
From:   Hu Weiwen <sehuww@mail.scut.edu.cn>
To:     linux-kernel@vger.kernel.org
Subject: Very slow page fault caused by migrate_pages
Message-ID: <20210515170104.GA469239@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowACnr_8+_p9goLWaAA--.52335S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr43CFykZr4rAw18ZFy8AFb_yoWruw4kpr
        n7Ga45t3yIgw42g3WfXr1qkr1fA3srGw4fG3ZrGry8Cw43Xr9F9wsrJF4DZayrCrnaga95
        Gan0g3yYyFn8KFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
        GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5PpnJUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAQBlepTBOCeAAfsT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We observed our program sometimes running over 1000x slower than normal and
cannot find the root cause. I would be grateful if someone can give me a hint. I
also searched on this mailing list but failed to find anything related.

The affected process spend almost 100% CPU time in kernel. First I ran `perf' to
identify where times are spent. It turns out 99.93% of the time is spent on
do_page_fault, and 98.16% on migrate_pages. And `perf record -e faults -t <tid>`
show 3 seconds per fault, which seems to much to me.

Then I do `perf record -e compaction:*`, and see 12k
compaction:mm_compaction_migratepages events per second. almost all of them has
nr_migrated=0 and nr_failed greater than 0. So it seems a lot of migration
failure is happening. But I cannot understand what causes it. The more
complete perf output is attached below.

This system is used to run machine-learning training programs, with 2 Intel Xeon
CPU, 512GB RAM and 8 NVIDIA GPU attached, running Ubuntu 20.04, with kernel
version 5.4.0-72-generic. Load average is 13, and 367GB of RAM is available when
we observe the problem this time. We have observed the very same problem on
multiple nodes, running different programs, with different models of CPU, GPU.

Currently, only reboot the system can resolve this. When this happens, all
process on the system is affected, and it does not resolve if I restart the
affected process.

Thanks,
Hu Weiwen
SCUT student


`perf report` output, collected with `sudo perf record -F 99 --pid 2413158 -g -- sleep 10`:

Samples: 993  of event 'cycles', Event count (approx.): 36810932529
  Children      Self  Command         Shared Object       Symbol
-   99.93%     0.00%  python          libc-2.31.so        [.] 0x00007ff5fcc78984                                                                                                                          ▒
     0x7ff5fcc78984                                                                                                                                                                                       ▒
     page_fault                                                                                                                                                                                           ▒
     do_page_fault                                                                                                                                                                                        ▒
     __do_page_fault                                                                                                                                                                                      ▒
     do_user_addr_fault                                                                                                                                                                                   ▒
     handle_mm_fault                                                                                                                                                                                      ▒
     __handle_mm_fault                                                                                                                                                                                    ▒
     do_huge_pmd_anonymous_page                                                                                                                                                                           ◆
     alloc_pages_vma                                                                                                                                                                                      ▒
     __alloc_pages_nodemask                                                                                                                                                                               ▒
     __alloc_pages_slowpath                                                                                                                                                                               ▒
     __alloc_pages_direct_compact                                                                                                                                                                         ▒
     try_to_compact_pages                                                                                                                                                                                 ▒
     compact_zone_order                                                                                                                                                                                   ▒
   - compact_zone                                                                                                                                                                                         ▒
      - 98.16% migrate_pages                                                                                                                                                                              ▒
         - 93.30% try_to_unmap                                                                                                                                                                            ▒
            - rmap_walk                                                                                                                                                                                   ▒
               - 92.12% rmap_walk_file                                                                                                                                                                    ▒
                  - 90.45% try_to_unmap_one                                                                                                                                                               ▒
                     - 83.48% ptep_clear_flush                                                                                                                                                            ▒
                        - 76.33% flush_tlb_mm_range                                                                                                                                                       ▒
                           - 74.35% native_flush_tlb_others                                                                                                                                               ▒
                              - 73.75% on_each_cpu_cond_mask                                                                                                                                              ▒
                                 - 70.85% on_each_cpu_mask                                                                                                                                                ▒
                                    - 69.57% smp_call_function_many                                                                                                                                       ▒
                                       - 67.20% smp_call_function_single                                                                                                                                  ▒
                                            4.93% llist_add_batch                                                                                                                                         ▒
                                          + 1.09% generic_exec_single                                                                                                                                     ▒
                                      1.19% smp_call_function_single                                                                                                                                      ▒
                                 + 2.01% zalloc_cpumask_var                                                                                                                                               ▒
                       1.45% page_vma_mapped_walk                                                                                                                                                         ▒
                    0.78% down_read                                                                                                                                                                       ▒
                 0.79% up_read                                                                                                                                                                            ▒
         + 3.29% remove_migration_ptes                                                                                                                                                                    ▒
           0.59% move_to_new_page


`perf report` output, collected with `sudo perf record -e compaction:* -a -- sleep 10`:

Samples: 133K of event 'compaction:mm_compaction_migratepages', Event count (approx.): 133394
Overhead  Trace output
  26.25%  nr_migrated=0 nr_failed=32
   5.00%  nr_migrated=0 nr_failed=2
   4.64%  nr_migrated=0 nr_failed=4
   4.24%  nr_migrated=0 nr_failed=3
   4.20%  nr_migrated=0 nr_failed=6
   3.83%  nr_migrated=0 nr_failed=1
   3.79%  nr_migrated=0 nr_failed=5
   3.62%  nr_migrated=0 nr_failed=7
   3.45%  nr_migrated=0 nr_failed=8
   3.06%  nr_migrated=0 nr_failed=9
   2.68%  nr_migrated=0 nr_failed=10
   2.68%  nr_migrated=0 nr_failed=11
   2.42%  nr_migrated=0 nr_failed=12
   2.35%  nr_migrated=0 nr_failed=13
   2.11%  nr_migrated=0 nr_failed=14
   1.93%  nr_migrated=0 nr_failed=16
   1.90%  nr_migrated=0 nr_failed=15
   1.64%  nr_migrated=0 nr_failed=17
   1.50%  nr_migrated=0 nr_failed=18
   1.25%  nr_migrated=0 nr_failed=19
   1.25%  nr_migrated=0 nr_failed=20
   1.22%  nr_migrated=0 nr_failed=21
   ...
   0.00%  nr_migrated=0 nr_failed=207                                                                                                                                                                     ▒
   0.00%  nr_migrated=0 nr_failed=258                                                                                                                                                                     ▒
   0.00%  nr_migrated=0 nr_failed=273                                                                                                                                                                     ▒
   0.00%  nr_migrated=0 nr_failed=277                                                                                                                                                                     ▒
   0.00%  nr_migrated=10 nr_failed=22                                                                                                                                                                     ▒
   0.00%  nr_migrated=13 nr_failed=19                                                                                                                                                                     ▒
   0.00%  nr_migrated=2 nr_failed=2                                                                                                                                                                       ▒
   0.00%  nr_migrated=3 nr_failed=13                                                                                                                                                                      ▒
   0.00%  nr_migrated=3 nr_failed=17                                                                                                                                                                      ▒
   0.00%  nr_migrated=3 nr_failed=25                                                                                                                                                                      ▒
   0.00%  nr_migrated=3 nr_failed=27                                                                                                                                                                      ▒
   0.00%  nr_migrated=3 nr_failed=28                                                                                                                                                                      ▒
   0.00%  nr_migrated=4 nr_failed=10                                                                                                                                                                      ▒
   0.00%  nr_migrated=4 nr_failed=15                                                                                                                                                                      ▒
   0.00%  nr_migrated=4 nr_failed=24                                                                                                                                                                      ▒
   0.00%  nr_migrated=5 nr_failed=10                                                                                                                                                                      ▒
   0.00%  nr_migrated=5 nr_failed=15                                                                                                                                                                      ▒
   0.00%  nr_migrated=6 nr_failed=20                                                                                                                                                                      ▒
   0.00%  nr_migrated=6 nr_failed=21                                                                                                                                                                      ▒
   0.00%  nr_migrated=6 nr_failed=23                                                                                                                                                                      ▒
   0.00%  nr_migrated=8 nr_failed=19

