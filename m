Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C2432A912
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbhCBSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578849AbhCBP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:27:38 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1C6C061A32
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:08 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 73so1275479wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8cdx2cy8bS1Yk1hOvoxJoIxgvMKS4vuWA9cIA1RP624=;
        b=YjzVe3TPmAvkQCDj/HWux0EV0FszWglzZrY/X7sQ4PP1pehQ7BRIGiVyN3MLlMr3li
         huvMmx5Y3nArbKhf91/o25rYsgIu4x+kp2oJMolgK94RuxqGkONc30xK6IKkPeKdw+az
         7Vctx4VxHYaXaENho0mlZ7QiMu85gh+Sh420ulaF3seaMGn2jIvBd8X8e+MqGmxTd2M6
         1X5vt1fRx59Pb9zdTuS+WO8mkN0JUh4Cwzw9IM1gJ8xOhx9fWpOVEMqhRoA6KH8bDNf6
         983WHMNuHeka5//hhYLYRrnsFZTkhhkGTnt5avmFO0K6/pTikDHYzM+l7KGykdTBPC8e
         FkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8cdx2cy8bS1Yk1hOvoxJoIxgvMKS4vuWA9cIA1RP624=;
        b=GOKwUoxNYWZm8cq5AOefMVzx+X+6LjwB2Zya75OsS+ETHy7mukrcclLnEat/0iqVjM
         awdae0Lcf+QwBFmRpgasIc7mufnHtN1vngEBjg5SO8KqKb3J0WqC3YSoUwSl15iXoYzy
         5MfjD11DD771fH6yfu/xmkivGRkM134WiDwhxuctn+a2zeJcD28A5IuJ0iX5XAlWPUiT
         3ZVu95kjgPmO6Qa/7h/T4Ly0GvqbToKL+HnBy6Xilbl/pyhCBbZETufl+7bgIGaMRV3a
         FryUYPiP5/LxH5twh3B1p4faXbzOtwjlPKDTEpT1Rs8KhJLXnIo70A2fQcE1pJtsC1gl
         C0cA==
X-Gm-Message-State: AOAM5334LM7keJO1zzJsmK8iuVlZE7CAWLgx1NOyFNtIxvUF3KvABrkP
        LddhgT+h8yr9laKUqggD6TPU5FIQcrOD
X-Google-Smtp-Source: ABdhPJwDCkMLeCoT4sUtiPOZrUAgJEKZ4OzzcKOcwzE3U3mmOILtARNPs12yHIt3Rzw7l59VN19/YF8Gf5Xv
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:f006:: with SMTP id
 a6mr4583157wmb.166.1614697206272; Tue, 02 Mar 2021 07:00:06 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:30 +0000
Message-Id: <20210302150002.3685113-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 00/32] KVM: arm64: A stage 2 for the host
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is the v3 of the series previously posted here:

  https://lore.kernel.org/kvmarm/20201117181607.1761516-1-qperret@google.com/

This basically allows us to wrap the host with a stage 2 when running in
nVHE, hence paving the way for protecting guest memory from the host in
the future (among other use-cases). For more details about the
motivation and the design angle taken here, I would recommend to have a
look at the cover letter of v1, and/or to watch these presentations at
LPC [1] and KVM forum 2020 [2].

V3 includes a bunch of clean-ups and small refactorings all over the
place as well as a few new features. Specifically, this now allows us to
remove memory pages from the host stage 2 cleanly, and this series does
so for all the .hyp memory sections (which has uncovered existing bugs
upstream and in v2 of this series -- see [3] and [4]). This also now
makes good use of block mappings whenever that is possible, and has
gotten a bit more testing on real hardware (which helped uncover other
bugs [5]).

The other changes to v3 include:

 - clean-ups, refactoring and extra comments all over the place (Will);

 - dropped fdt hook in favor of memblock API now that the relevant
   patches ([6]) are merged (Rob);

 - moved the CPU feature copy stuff to __init/__initdata (Marc);

 - fixed FWB support (Mate);

 - rebased on v5.12-rc1.

This series depends on Will's vCPU context fix ([5]) and Marc's PMU
fixes ([7]). And here's a branch with all the goodies applied:

  https://android-kvm.googlesource.com/linux qperret/host-stage2-v3

Thanks,
Quentin

[1] https://youtu.be/54q6RzS9BpQ?t=10859
[2] https://youtu.be/wY-u6n75iXc
[3] https://lore.kernel.org/kvmarm/20210203141931.615898-1-qperret@google.com/
[4] https://lore.kernel.org/kvmarm/20210128173850.2478161-1-qperret@google.com/
[5] https://lore.kernel.org/kvmarm/20210226181211.14542-1-will@kernel.org/
[6] https://lore.kernel.org/lkml/20210115114544.1830068-1-qperret@google.com/
[7] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/pmu-undef-NV


Quentin Perret (29):
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
  KVM: arm64: Introduce PROT_NONE mappings for stage 2
  KVM: arm64: Refactor stage2_map_set_prot_attr()
  KVM: arm64: Add kvm_pgtable_stage2_idmap_greedy()
  KVM: arm64: Wrap the host with a stage 2
  KVM: arm64: Page-align the .hyp sections
  KVM: arm64: Disable PMU support in protected mode
  KVM: arm64: Protect the .hyp sections from the host

Will Deacon (3):
  arm64: lib: Annotate {clear,copy}_page() as position-independent
  KVM: arm64: Link position-independent string routines into .hyp.text
  arm64: kvm: Add standalone ticket spinlock implementation for use at
    hyp

 arch/arm64/include/asm/cpufeature.h           |   1 +
 arch/arm64/include/asm/hyp_image.h            |   7 +
 arch/arm64/include/asm/kvm_asm.h              |   9 +
 arch/arm64/include/asm/kvm_cpufeature.h       |  19 ++
 arch/arm64/include/asm/kvm_host.h             |  19 +-
 arch/arm64/include/asm/kvm_hyp.h              |   8 +
 arch/arm64/include/asm/kvm_mmu.h              |  23 +-
 arch/arm64/include/asm/kvm_pgtable.h          | 117 ++++++-
 arch/arm64/include/asm/sections.h             |   1 +
 arch/arm64/kernel/asm-offsets.c               |   3 +
 arch/arm64/kernel/cpufeature.c                |  13 +
 arch/arm64/kernel/image-vars.h                |  30 ++
 arch/arm64/kernel/vmlinux.lds.S               |  74 +++--
 arch/arm64/kvm/arm.c                          | 199 ++++++++++--
 arch/arm64/kvm/hyp/Makefile                   |   2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |  37 ++-
 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h |  14 +
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  55 ++++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  36 +++
 arch/arm64/kvm/hyp/include/nvhe/memory.h      |  52 +++
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |  92 ++++++
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h    |  92 ++++++
 arch/arm64/kvm/hyp/nvhe/Makefile              |   9 +-
 arch/arm64/kvm/hyp/nvhe/cache.S               |  13 +
 arch/arm64/kvm/hyp/nvhe/cpufeature.c          |   8 +
 arch/arm64/kvm/hyp/nvhe/early_alloc.c         |  54 ++++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S            |  46 ++-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  69 ++++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 235 ++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mm.c                  | 173 ++++++++++
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          | 195 ++++++++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c          |   4 +-
 arch/arm64/kvm/hyp/nvhe/setup.c               | 212 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/stub.c                |  22 ++
 arch/arm64/kvm/hyp/nvhe/switch.c              |  12 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                 |   4 +-
 arch/arm64/kvm/hyp/pgtable.c                  | 298 ++++++++++++++----
 arch/arm64/kvm/hyp/reserved_mem.c             | 113 +++++++
 arch/arm64/kvm/mmu.c                          | 115 ++++++-
 arch/arm64/kvm/perf.c                         |   3 +-
 arch/arm64/kvm/pmu.c                          |   8 +-
 arch/arm64/kvm/reset.c                        |  42 +--
 arch/arm64/kvm/sys_regs.c                     |  21 ++
 arch/arm64/lib/clear_page.S                   |   4 +-
 arch/arm64/lib/copy_page.S                    |   4 +-
 arch/arm64/mm/init.c                          |   3 +
 47 files changed, 2356 insertions(+), 215 deletions(-)
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

