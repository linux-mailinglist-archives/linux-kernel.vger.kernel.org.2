Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F927362455
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhDPPny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:43:54 -0400
Received: from foss.arm.com ([217.140.110.172]:44518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234654AbhDPPnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:43:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AAD311B3;
        Fri, 16 Apr 2021 08:43:22 -0700 (PDT)
Received: from e112269-lin.arm.com (autoplooker.cambridge.arm.com [10.1.194.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F0DD3F99C;
        Fri, 16 Apr 2021 08:43:19 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v11 0/6] MTE support for KVM guest
Date:   Fri, 16 Apr 2021 16:43:03 +0100
Message-Id: <20210416154309.22129-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know it's likely to be the merge window next week, but since there
were a couple of changes from Catalin's review I thought I'd send
another version out - there are some minor conflicts with what's
currently in -next so I'll rebase after -rc1.

This series adds support for using the Arm Memory Tagging Extensions
(MTE) in a KVM guest.

This version is rebased on v5.12-rc2.

Changes since v10[1]:

 * Replace pte_valid_user() with (pte_val(pte) & PTE_USER) in
   set_pte_at() as the former has been removed with the EPAN patches.
 * Don't attempt to check tags on memory which is going to be mapped in
   stage 2 as DEVICE as the guest won't be able to see the tags.
 * Use pfn_to_online_page() instead of pfn_to_page() in user_mem_abort()
   to prevent ZONE_DEVICE memory being populated in stage 2 if tags are
   enabled.

[1] https://lore.kernel.org/r/20210312151902.17853-1-steven.price%40arm.com

Steven Price (6):
  arm64: mte: Sync tags for pages where PTE is untagged
  arm64: kvm: Introduce MTE VM feature
  arm64: kvm: Save/restore MTE registers
  arm64: kvm: Expose KVM_ARM_CAP_MTE
  KVM: arm64: ioctl to fetch/store tags in a guest
  KVM: arm64: Document MTE capability and ioctl

 Documentation/virt/kvm/api.rst             | 53 +++++++++++++++
 arch/arm64/include/asm/kvm_emulate.h       |  3 +
 arch/arm64/include/asm/kvm_host.h          |  9 +++
 arch/arm64/include/asm/kvm_mte.h           | 66 ++++++++++++++++++
 arch/arm64/include/asm/pgtable.h           |  2 +-
 arch/arm64/include/asm/sysreg.h            |  3 +-
 arch/arm64/include/uapi/asm/kvm.h          | 14 ++++
 arch/arm64/kernel/asm-offsets.c            |  3 +
 arch/arm64/kernel/mte.c                    | 16 +++--
 arch/arm64/kvm/arm.c                       | 78 ++++++++++++++++++++++
 arch/arm64/kvm/hyp/entry.S                 |  7 ++
 arch/arm64/kvm/hyp/exception.c             |  3 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 21 ++++++
 arch/arm64/kvm/mmu.c                       | 20 ++++++
 arch/arm64/kvm/sys_regs.c                  | 28 ++++++--
 include/uapi/linux/kvm.h                   |  2 +
 16 files changed, 317 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_mte.h

-- 
2.20.1

