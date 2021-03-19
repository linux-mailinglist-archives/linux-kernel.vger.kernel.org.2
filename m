Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C5434192E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCSKCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhCSKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:01:51 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBCC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:01:51 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id 9so5997079wrb.16
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3QDnIsBA07wwAzgg5TO4XGmB7sKe+yZP+OaMryxlg+Q=;
        b=ZrHfZmMDTHHEmneNNuVrm7hsEcOzX/Z9lC9739PsWDzbJi0Q/CykCbo1GiYqeVDBjr
         F655DhlwWJer9lasns1waxQ+rPr5/aUXS9IxFTlqHn/cOvUtZIBrv22gs3G+e33P7co0
         JF64cqqifaBb3a2//PSQcyxEgGFFvywR8rvHTs8m7BBKLXuTfcdQl0IudiZYPRKPvSOb
         PxQY+voTDr6KiVAvnqcfOpCA3ND1rTL68gDas05YidugmCqEX2oALaKQjfaBw47iG9xd
         mVg+k38o6Az/qcJJ4eg65X8iQAotzEqIJlmCl3bhzsyKURiyM1mAdlQ8QyG3ebaJujyx
         ycLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3QDnIsBA07wwAzgg5TO4XGmB7sKe+yZP+OaMryxlg+Q=;
        b=cZSjn71E7Ef6oJzMgrES1F7u89jfBio7kTLfvGOLUGUY9IYJ6ASOLgQBMzG6UiuwMC
         /PBuQuMSELpSntprVg+uml5LGPQqmylT1ZgpnuA7gbxjHfK6uCbEYPX3Zelb2yrI8DxG
         zVrLosSIiRH3tLpBc1Dkimv/5m41ZukP2xE3JuKhOzyLIW9m9bUB+Fqd9gaq5uOOIMWu
         xYwUqRZv5HA4TScUbkk0WA25I4ehm2I/QUFUGGrs+0DO+rTg7/P0NhtiFu+5v7Pnw4KI
         VpUEP7bexlczQaYDa5cvyJiW58gZl8EYeillfYpUxQBIKRjvs4EHaRErnocczScrCgeW
         z/Ig==
X-Gm-Message-State: AOAM533he/Za2XcACu2J3e3lQtyiTR8gV+LSLhIfl32DuHO740yJEec9
        IN/hbVIOT7wIOghZUcfwJTCrYs1oFPUv
X-Google-Smtp-Source: ABdhPJzaLN/E3+6nsmzfsg7cTZw1feIULu33SvLO8FR0nxSCs9ZaYvrSQ0zXXpn6G59m8MDkOhgIizEPiI4j
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a5d:6a86:: with SMTP id
 s6mr3731430wru.307.1616148110187; Fri, 19 Mar 2021 03:01:50 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:08 +0000
Message-Id: <20210319100146.1149909-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 00/38] KVM: arm64: Stage-2 for the host
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is the v6 of the series previously posted here:

  https://lore.kernel.org/r/20210315143536.214621-1-qperret@google.com/

This basically allows us to wrap the host with a stage 2 when running in
nVHE, hence paving the way for protecting guest memory from the host in
the future (among other use-cases). For more details about the
motivation and the design angle taken here, I would recommend to have a
look at the cover letter of v1, and/or to watch these presentations at
LPC [1] and KVM forum 2020 [2].

Changes since v5:

 - disabled FWB for the host even when the CPUs support it using stage-2
   config flags;

 - added a stage-2 config flag to enfore identity mappings for the host;

 - refactored/simplified the cpu feature register copy;

 - removed unecessary ISB() from the set_ownership() path, and improved
   kerneldoc;

 - rebased on kvmarm/next to fix (trivial) conflicts with Marc's SVE
   series [3].

And as usual, there is a branch available here:

  https://android-kvm.googlesource.com/linux qperret/host-stage2-v6

Thanks,
Quentin

[1] https://youtu.be/54q6RzS9BpQ?t=10859
[2] https://youtu.be/wY-u6n75iXc
[3] https://lore.kernel.org/r/20210318122532.505263-1-maz@kernel.org/

Quentin Perret (35):
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
  KVM: arm64: Provide __flush_dcache_area at EL2
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
  KVM: arm64: Refactor the *_map_set_prot_attr() helpers
  KVM: arm64: Add kvm_pgtable_stage2_find_range()
  KVM: arm64: Introduce KVM_PGTABLE_S2_NOFWB stage 2 flag
  KVM: arm64: Introduce KVM_PGTABLE_S2_IDMAP stage 2 flag
  KVM: arm64: Provide sanitized mmfr* registers at EL2
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
 arch/arm64/include/asm/kvm_cpufeature.h       |  26 ++
 arch/arm64/include/asm/kvm_host.h             |  19 +-
 arch/arm64/include/asm/kvm_hyp.h              |   8 +
 arch/arm64/include/asm/kvm_mmu.h              |  23 +-
 arch/arm64/include/asm/kvm_pgtable.h          | 164 ++++++-
 arch/arm64/include/asm/pgtable-prot.h         |   4 +-
 arch/arm64/include/asm/sections.h             |   1 +
 arch/arm64/kernel/asm-offsets.c               |   3 +
 arch/arm64/kernel/cpufeature.c                |  13 +
 arch/arm64/kernel/image-vars.h                |  30 ++
 arch/arm64/kernel/vmlinux.lds.S               |  74 ++--
 arch/arm64/kvm/arm.c                          | 199 +++++++--
 arch/arm64/kvm/hyp/Makefile                   |   2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |  28 +-
 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h |  14 +
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  68 +++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  36 ++
 arch/arm64/kvm/hyp/include/nvhe/memory.h      |  52 +++
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |  96 ++++
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h    |  92 ++++
 arch/arm64/kvm/hyp/nvhe/Makefile              |   9 +-
 arch/arm64/kvm/hyp/nvhe/cache.S               |  13 +
 arch/arm64/kvm/hyp/nvhe/early_alloc.c         |  54 +++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S            |  42 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  68 +++
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c             |   8 +
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 279 ++++++++++++
 arch/arm64/kvm/hyp/nvhe/mm.c                  | 173 ++++++++
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          | 195 +++++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c          |   4 +-
 arch/arm64/kvm/hyp/nvhe/setup.c               | 214 +++++++++
 arch/arm64/kvm/hyp/nvhe/stub.c                |  22 +
 arch/arm64/kvm/hyp/nvhe/switch.c              |  12 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                 |   4 +-
 arch/arm64/kvm/hyp/pgtable.c                  | 410 ++++++++++++++----
 arch/arm64/kvm/hyp/reserved_mem.c             | 113 +++++
 arch/arm64/kvm/mmu.c                          | 115 ++++-
 arch/arm64/kvm/perf.c                         |   3 +-
 arch/arm64/kvm/pmu.c                          |   8 +-
 arch/arm64/kvm/reset.c                        |  42 +-
 arch/arm64/kvm/sys_regs.c                     |  22 +
 arch/arm64/lib/clear_page.S                   |   4 +-
 arch/arm64/lib/copy_page.S                    |   4 +-
 arch/arm64/mm/init.c                          |   3 +
 49 files changed, 2542 insertions(+), 263 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_cpufeature.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/gfp.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/memory.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mm.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/spinlock.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S
 create mode 100644 arch/arm64/kvm/hyp/nvhe/early_alloc.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/mem_protect.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/mm.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/page_alloc.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/setup.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/stub.c
 create mode 100644 arch/arm64/kvm/hyp/reserved_mem.c

-- 
2.31.0.rc2.261.g7f71774620-goog

