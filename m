Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807FE310C72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBEODO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:03:14 -0500
Received: from foss.arm.com ([217.140.110.172]:60344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231575AbhBEN7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:59:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE27331B;
        Fri,  5 Feb 2021 05:58:21 -0800 (PST)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 076A83F719;
        Fri,  5 Feb 2021 05:58:18 -0800 (PST)
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
Subject: [PATCH v8 0/5] MTE support for KVM guest
Date:   Fri,  5 Feb 2021 13:57:58 +0000
Message-Id: <20210205135803.48321-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another round of updates following review comments from Marc (thanks!).
This is rather late for v5.12, so I'll rebase again after -rc1 is out.

This series adds support for using the Arm Memory Tagging Extensions
(MTE) in a KVM guest.

This version splits the change to the tag synchronisation out to it's
own patch (patch 1), and also separates the introduction and exposing of
KVM_ARM_CAP_MTE into two patches (2 and 4) to avoid a dependency problem
with the save/restore patch (3). As before patch 5 is an RFC for adding
a new ioctl for reading/writing tags (I would appreciate feedback!).

Changes since v7[1]:
 * Split into hopefully more logic patches.
 * Save/restore of TFSRE0_EL1 is now done in C code.
 * Make save/restore of TFSR_EL1 conditional on the VM having MTE
   enabled.
 * Replaced register descriptions boilerplate in sys_regs.c with a new
   MTE_REG() macro.

[1] https://lore.kernel.org/r/20210115152811.8398-1-steven.price%40arm.com

Steven Price (5):
  arm64: mte: Sync tags for pages where PTE is untagged
  arm64: kvm: Introduce MTE VM feature
  arm64: kvm: Save/restore MTE registers
  arm64: kvm: Expose KVM_ARM_CAP_MTE
  KVM: arm64: ioctl to fetch/store tags in a guest

 arch/arm64/include/asm/kvm_emulate.h       |  3 +
 arch/arm64/include/asm/kvm_host.h          |  9 +++
 arch/arm64/include/asm/kvm_mte.h           | 66 ++++++++++++++++++++++
 arch/arm64/include/asm/pgtable.h           |  2 +-
 arch/arm64/include/asm/sysreg.h            |  3 +-
 arch/arm64/include/uapi/asm/kvm.h          | 13 +++++
 arch/arm64/kernel/asm-offsets.c            |  3 +
 arch/arm64/kernel/mte.c                    | 16 ++++--
 arch/arm64/kvm/arm.c                       | 66 ++++++++++++++++++++++
 arch/arm64/kvm/hyp/entry.S                 |  7 +++
 arch/arm64/kvm/hyp/exception.c             |  3 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 21 +++++++
 arch/arm64/kvm/mmu.c                       | 16 ++++++
 arch/arm64/kvm/sys_regs.c                  | 28 +++++++--
 include/uapi/linux/kvm.h                   |  2 +
 15 files changed, 246 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_mte.h

-- 
2.20.1

