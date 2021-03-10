Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436AC3345F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhCJR6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhCJR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:57:55 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D100C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:57:55 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id b78so13382420qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jj+aiphSo+AXqJgVWt4mf7B9yKscmt0lnZkVIf+CV3k=;
        b=mHwRiP4lYDBYfeHIoLuWdw9U1vHVSUNcwHmi8BlljbDMUhfLUMnoo4r5wbpjm1+DCS
         tVHJHNPD9on0Bcv4y5Ib9c/M4Nb+CpXthOeUU3XB2m11Km5rC3XfZx7nLz/hTIfhpVvD
         bRXKtM8DlbBidAf/tSKgKd06osTmcjzPvj8xeBhtEjFkZM+FUpk/E6NynBcWXBEt3zVM
         tJ8nfpuDXo0U47N8MdD643W0eVRMefcn0U6MxFAOc4GMQ5QI01MmAWN+rGOqg/hVKeBa
         V+UTRwhWHn32Un+A1H7v1RmJUEYVY2Va7rt30tF7cygl3LVsTtmES8lbCGfQW+PBxhPz
         JSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jj+aiphSo+AXqJgVWt4mf7B9yKscmt0lnZkVIf+CV3k=;
        b=psZuEBC8wJsmf3Ndru+DN40JLOgj9Tij5y2p+c3NjSeDK482mudBE4XNrgAo+wkwZ2
         kuEfVHoDO8IuGB4aXJN7SErCyS8+1X1hULX0RUnIJBsacYz2vnzoRkcndBavixqpy54w
         WwuP6iBRe3Bo93hQDdsPq19CEUL4RCdoEBq+JtUxAwc91G1cOdgZ/jHo4g2xl2ojQGak
         V/br0kQxGwPp4kzojDVPkcZNyYrXlOP+/nRyDvPWjib+SSahbgh1SitHczdVyqF4z66x
         DtHNt5xJnq6NjqD8Is4xJjDY3xFXKxTBovVMkS5KtGda0RTabk/EoRy/vgg05RJURXpw
         lOlg==
X-Gm-Message-State: AOAM532TUps9PI2YKAffCpYqTUGZulC+CxnxNIalJThv1bMT3doGli7C
        XFsqMBbPQT8eqMMJFtXfuTn1Nd6YQuR0
X-Google-Smtp-Source: ABdhPJyYcTieuq7H7psjFFzHqtTdADfo1wF7B9LWV4x5FP1NaJlQm/jiL2SQ3CgLTt5Il1xJ6P2JijHpGnv8
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:5629:: with SMTP id
 cb9mr4180748qvb.62.1615399074517; Wed, 10 Mar 2021 09:57:54 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:17 +0000
Message-Id: <20210310175751.3320106-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 00/34] KVM: arm64: A stage 2 for the host
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is the v4 of the series previously posted here:

  https://lore.kernel.org/lkml/20210302150002.3685113-1-qperret@google.com/

This basically allows us to wrap the host with a stage 2 when running in
nVHE, hence paving the way for protecting guest memory from the host in
the future (among other use-cases). For more details about the
motivation and the design angle taken here, I would recommend to have a
look at the cover letter of v1, and/or to watch these presentations at
LPC [1] and KVM forum 2020 [2].

Changes since v3:

 - removed the PROT_NONE concept in favor of tracking page owners in
   the topmost bits of invalid mappings;

 - split up the *idmap_greedy() function in two parts, and refactored the
   reduce_range part to simplify it, and make the loop bound more obvious;

 - fixed two bugs that could lead to -ERANGE in the host memory abort
   path;

 - added the set_sctlr_el2 macro based on its el1 counterpart;

 - cosmetic changes, added comments, and small improvements all over;

 - rebased on v5.12-rc2.

Big thanks to Will for the review.

This series depends on Will's vCPU context fix ([3]) and Marc's PMU
fixes ([4]). And here's a branch with all the goodies applied:

  https://android-kvm.googlesource.com/linux qperret/host-stage2-v4

Thanks,
Quentin

[1] https://youtu.be/54q6RzS9BpQ?t=10859
[2] https://youtu.be/wY-u6n75iXc
[3] https://lore.kernel.org/kvmarm/20210226181211.14542-1-will@kernel.org/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/pmu-undef-NV

Quentin Perret (31):
  KVM: arm64: Initialize kvm_nvhe_init_params early
  KVM: arm64: Avoid free_page() in page-table allocator
  KVM: arm64: Factor memory allocation out of pgtable.c
  KVM: arm64: Introduce a BSS section for use at Hyp
  KVM: arm64: Make kvm_call_hyp() a function call at Hyp
  KVM: arm64: Allow using kvm_nvhe_sym() in hyp code
  KVM: arm64: Introduce an early Hyp page allocator
  KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
  KVM: arm64: Introduce a Hyp buddy page allocator
  KVM: arm64: Enable access to sanitized CPU features at EL2
  KVM: arm64: Factor out vector address calculation
  arm64: asm: Provide set_sctlr_el2 macro
  KVM: arm64: Prepare the creation of s1 mappings at EL2
  KVM: arm64: Elevate hypervisor mappings creation at EL2
  KVM: arm64: Use kvm_arch for stage 2 pgtable
  KVM: arm64: Use kvm_arch in kvm_s2_mmu
  KVM: arm64: Set host stage 2 using kvm_nvhe_init_params
  KVM: arm64: Refactor kvm_arm_setup_stage2()
  KVM: arm64: Refactor __load_guest_stage2()
  KVM: arm64: Refactor __populate_fault_info()
  KVM: arm64: Make memcache anonymous in pgtable allocator
  KVM: arm64: Reserve memory for host stage 2
  KVM: arm64: Sort the hypervisor memblocks
  KVM: arm64: Always zero invalid PTEs
  KVM: arm64: Use page-table to track page ownership
  KVM: arm64: Refactor stage2_map_set_prot_attr()
  KVM: arm64: Add kvm_pgtable_stage2_find_range()
  KVM: arm64: Wrap the host with a stage 2
  KVM: arm64: Page-align the .hyp sections
  KVM: arm64: Disable PMU support in protected mode
  KVM: arm64: Protect the .hyp sections from the host

Will Deacon (3):
  arm64: lib: Annotate {clear,copy}_page() as position-independent
  KVM: arm64: Link position-independent string routines into .hyp.text
  arm64: kvm: Add standalone ticket spinlock implementation for use at
    hyp

 arch/arm64/include/asm/assembler.h            |  14 +-
 arch/arm64/include/asm/cpufeature.h           |   1 +
 arch/arm64/include/asm/hyp_image.h            |   7 +
 arch/arm64/include/asm/kvm_asm.h              |   9 +
 arch/arm64/include/asm/kvm_cpufeature.h       |  19 +
 arch/arm64/include/asm/kvm_host.h             |  19 +-
 arch/arm64/include/asm/kvm_hyp.h              |   8 +
 arch/arm64/include/asm/kvm_mmu.h              |  23 +-
 arch/arm64/include/asm/kvm_pgtable.h          | 129 ++++++-
 arch/arm64/include/asm/sections.h             |   1 +
 arch/arm64/kernel/asm-offsets.c               |   3 +
 arch/arm64/kernel/cpufeature.c                |  13 +
 arch/arm64/kernel/image-vars.h                |  30 ++
 arch/arm64/kernel/vmlinux.lds.S               |  74 ++--
 arch/arm64/kvm/arm.c                          | 199 ++++++++--
 arch/arm64/kvm/hyp/Makefile                   |   2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |  34 +-
 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h |  14 +
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  68 ++++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  36 ++
 arch/arm64/kvm/hyp/include/nvhe/memory.h      |  52 +++
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |  96 +++++
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h    |  92 +++++
 arch/arm64/kvm/hyp/nvhe/Makefile              |   9 +-
 arch/arm64/kvm/hyp/nvhe/cache.S               |  13 +
 arch/arm64/kvm/hyp/nvhe/cpufeature.c          |   8 +
 arch/arm64/kvm/hyp/nvhe/early_alloc.c         |  54 +++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S            |  42 ++-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  69 ++++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 279 ++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mm.c                  | 173 +++++++++
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          | 195 ++++++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c          |   4 +-
 arch/arm64/kvm/hyp/nvhe/setup.c               | 214 +++++++++++
 arch/arm64/kvm/hyp/nvhe/stub.c                |  22 ++
 arch/arm64/kvm/hyp/nvhe/switch.c              |  12 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                 |   4 +-
 arch/arm64/kvm/hyp/pgtable.c                  | 350 ++++++++++++++----
 arch/arm64/kvm/hyp/reserved_mem.c             | 113 ++++++
 arch/arm64/kvm/mmu.c                          | 115 +++++-
 arch/arm64/kvm/perf.c                         |   3 +-
 arch/arm64/kvm/pmu.c                          |   8 +-
 arch/arm64/kvm/reset.c                        |  42 +--
 arch/arm64/kvm/sys_regs.c                     |  21 ++
 arch/arm64/lib/clear_page.S                   |   4 +-
 arch/arm64/lib/copy_page.S                    |   4 +-
 arch/arm64/mm/init.c                          |   3 +
 48 files changed, 2471 insertions(+), 234 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_cpufeature.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/gfp.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/memory.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mm.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/spinlock.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cpufeature.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/early_alloc.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/mem_protect.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/mm.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/page_alloc.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/setup.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/stub.c
 create mode 100644 arch/arm64/kvm/hyp/reserved_mem.c

-- 
2.30.1.766.gb4fecdf3b7-goog

