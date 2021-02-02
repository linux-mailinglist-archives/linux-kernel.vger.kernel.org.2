Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB330CAC8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbhBBS7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbhBBS6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:58:19 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798D6C061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:57:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z3so14130753pfj.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tnlVsNI+nZgrGXxdOgd1okV91+LRu9Y5YI7uQwKH0UU=;
        b=Qfq3P/NISj2yjPjKvf7D0cPufC7LxazyawfI7KOQSX3qrmmp9s9IVzwnEvyalBtZmS
         LYV3x94JslciL687Bq480NezmotflkO9DQ4aLeRsHL/CrVTyCo51kXo0n0qbtaqywjs2
         CFOZnmiDplrlVnvX326KT4B4M7M9XDSKLAsSdof8pGsIV57gQ3aLXWgfhFKfLenKWf5C
         8YXF6KelCa+SydvCsSCbOl60Yi0xypbAcv9X6uND9SafIUO5YoKWJIHCpSiS47vph8Jh
         jhp0SXyecvGjWhQhE4POwh7Y8F6BWxsUSY/BrA7f1qgx8oNJ9i6BX0oyiz4aozJPJOid
         jHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tnlVsNI+nZgrGXxdOgd1okV91+LRu9Y5YI7uQwKH0UU=;
        b=jEzUEbmBEpdwIN3mQGPjb4AdhEHH0vI8BeiiXY+rJ8lr17Gv1k9eWkgILIjFL1lN3i
         AtLlETVP84+C6uC2MtJE2cpi/ZWFTg6I2mua6Jbs240ooF2nffYPDPk/sK48bs/otA6U
         EbgoHHA3rdJ5QuODC0QBQh6LB/ABA1FR8O++PnBaAXNo2+ivD2oQk7i9T8BhVhLGNxJV
         NBJhtKfHvFerxWWj8xBKyEcFHAYBIGaqTOcoFAKiL+x8/27eujAzicLHIXvFpENkzWgN
         Ll3oNERGL8Oy5oaLikb/fWnh54c0FmfGsadfcY1cvY9M2ZE2mQDsI9DevwoPnfuNL5/m
         OdqQ==
X-Gm-Message-State: AOAM531dJ0ClaBBpb8Vd8oJyQu+8PyGrtLu/VsrTz8Xh95ArakHdzcwH
        IGFVh835dOt9mdNEg53S9B8CT32cij7rhymZGTOtYso7KQM5MP3pCXE4jEXu5WvJd1qDJbzJjby
        OiUma44xn8M3f29cWhSn09lsuaYG+Cpe0uGgw04UJjKsSa35Yf1AhTa1akJcE7NQnoN9IH9Et
X-Google-Smtp-Source: ABdhPJwt9QdkeZPUjxqfU3W0jnqT4uZJZvJqucaDYAgaVKy+4r7MbT8aMTwpvQUTl37Y7dg13B1RkbiALyQA
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:a17:90a:4b49:: with SMTP id
 o9mr5623083pjl.182.1612292258781; Tue, 02 Feb 2021 10:57:38 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:06 -0800
Message-Id: <20210202185734.1680553-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 00/28] Allow parallel MMU operations with TDP MMU
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TDP MMU was implemented to simplify and improve the performance of
KVM's memory management on modern hardware with TDP (EPT / NPT). To build
on the existing performance improvements of the TDP MMU, add the ability
to handle vCPU page faults, enabling and disabling dirty logging, and
removing mappings, in parallel. In the current implementation,
vCPU page faults (actually EPT/NPT violations/misconfigurations) are the
largest source of MMU lock contention on VMs with many vCPUs. This
contention, and the resulting page fault latency, can soft-lock guests
and degrade performance. Handling page faults in parallel is especially
useful when booting VMs, enabling dirty logging, and handling demand
paging. In all these cases vCPUs are constantly incurring  page faults on
each new page accessed.

Broadly, the following changes were required to allow parallel page
faults (and other MMU operations):
-- Contention detection and yielding added to rwlocks to bring them up to
   feature parity with spin locks, at least as far as the use of the MMU
   lock is concerned.
-- TDP MMU page table memory is protected with RCU and freed in RCU
   callbacks to allow multiple threads to operate on that memory
   concurrently.
-- The MMU lock was changed to an rwlock on x86. This allows the page
   fault handlers to acquire the MMU lock in read mode and handle page
   faults in parallel, and other operations to maintain exclusive use of
   the lock by acquiring it in write mode.
-- An additional lock is added to protect some data structures needed by
   the page fault handlers, for relatively infrequent operations.
-- The page fault handler is modified to use atomic cmpxchgs to set SPTEs
   and some page fault handler operations are modified slightly to work
   concurrently with other threads.

This series also contains a few bug fixes and optimizations, related to
the above, but not strictly part of enabling parallel page fault handling.

Correctness testing:
The following tests were performed with an SMP kernel and DBX kernel on an
Intel Skylake machine. The tests were run both with and without the TDP
MMU enabled.
-- This series introduces no new failures in kvm-unit-tests
SMP + no TDP MMU no new failures
SMP + TDP MMU no new failures
DBX + no TDP MMU no new failures
DBX + TDP MMU no new failures
-- All KVM selftests behave as expected
SMP + no TDP MMU all pass except ./x86_64/vmx_preemption_timer_test
SMP + TDP MMU all pass except ./x86_64/vmx_preemption_timer_test
(./x86_64/vmx_preemption_timer_test also fails without this patch set,
both with the TDP MMU on and off.)
DBX + no TDP MMU all pass
DBX + TDP MMU all pass
-- A VM can be booted running a Debian 9 and all memory accessed
SMP + no TDP MMU works
SMP + TDP MMU works
DBX + no TDP MMU works
DBX + TDP MMU works

This series can be viewed in Gerrit at:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/7172

Changelog v1 -> v2:
- Removed the MMU lock union + using a spinlock when the TDP MMU is disabled
- Merged RCU commits
- Extended additional MMU operations to operate in parallel
- Ammended dirty log perf test to cover newly parallelized code paths
- Misc refactorings (see changelogs for individual commits)
- Big thanks to Sean and Paolo for their thorough review of v1

Ben Gardon (28):
  KVM: x86/mmu: change TDP MMU yield function returns to match
    cond_resched
  KVM: x86/mmu: Add comment on __tdp_mmu_set_spte
  KVM: x86/mmu: Add lockdep when setting a TDP MMU SPTE
  KVM: x86/mmu: Don't redundantly clear TDP MMU pt memory
  KVM: x86/mmu: Factor out handling of removed page tables
  locking/rwlocks: Add contention detection for rwlocks
  sched: Add needbreak for rwlocks
  sched: Add cond_resched_rwlock
  KVM: x86/mmu: Fix braces in kvm_recover_nx_lpages
  KVM: x86/mmu: Fix TDP MMU zap collapsible SPTEs
  KVM: x86/mmu: Merge flush and non-flush tdp_mmu_iter_cond_resched
  KVM: x86/mmu: Rename goal_gfn to next_last_level_gfn
  KVM: x86/mmu: Ensure forward progress when yielding in TDP MMU iter
  KVM: x86/mmu: Yield in TDU MMU iter even if no SPTES changed
  KVM: x86/mmu: Skip no-op changes in TDP MMU functions
  KVM: x86/mmu: Clear dirtied pages mask bit before early break
  KVM: x86/mmu: Protect TDP MMU page table memory with RCU
  KVM: x86/mmu: Use an rwlock for the x86 MMU
  KVM: x86/mmu: Factor out functions to add/remove TDP MMU pages
  KVM: x86/mmu: Use atomic ops to set SPTEs in TDP MMU map
  KVM: x86/mmu: Flush TLBs after zap in TDP MMU PF handler
  KVM: x86/mmu: Mark SPTEs in disconnected pages as removed
  KVM: x86/mmu: Allow parallel page faults for the TDP MMU
  KVM: x86/mmu: Allow zap gfn range to operate under the mmu read lock
  KVM: x86/mmu: Allow zapping collapsible SPTEs to use MMU read lock
  KVM: x86/mmu: Allow enabling / disabling dirty logging under MMU read
    lock
  KVM: selftests: Add backing src parameter to dirty_log_perf_test
  KVM: selftests: Disable dirty logging with vCPUs running

 arch/x86/include/asm/kvm_host.h               |  15 +
 arch/x86/kvm/mmu/mmu.c                        | 120 +--
 arch/x86/kvm/mmu/mmu_internal.h               |   9 +-
 arch/x86/kvm/mmu/page_track.c                 |   8 +-
 arch/x86/kvm/mmu/paging_tmpl.h                |   8 +-
 arch/x86/kvm/mmu/spte.h                       |  21 +-
 arch/x86/kvm/mmu/tdp_iter.c                   |  46 +-
 arch/x86/kvm/mmu/tdp_iter.h                   |  21 +-
 arch/x86/kvm/mmu/tdp_mmu.c                    | 741 ++++++++++++++----
 arch/x86/kvm/mmu/tdp_mmu.h                    |   5 +-
 arch/x86/kvm/x86.c                            |   4 +-
 include/asm-generic/qrwlock.h                 |  24 +-
 include/linux/kvm_host.h                      |   5 +
 include/linux/rwlock.h                        |   7 +
 include/linux/sched.h                         |  29 +
 kernel/sched/core.c                           |  40 +
 .../selftests/kvm/demand_paging_test.c        |   3 +-
 .../selftests/kvm/dirty_log_perf_test.c       |  25 +-
 .../testing/selftests/kvm/include/kvm_util.h  |   6 -
 .../selftests/kvm/include/perf_test_util.h    |   3 +-
 .../testing/selftests/kvm/include/test_util.h |  14 +
 .../selftests/kvm/lib/perf_test_util.c        |   6 +-
 tools/testing/selftests/kvm/lib/test_util.c   |  29 +
 virt/kvm/dirty_ring.c                         |  10 +
 virt/kvm/kvm_main.c                           |  46 +-
 25 files changed, 963 insertions(+), 282 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

