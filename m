Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E11339113
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhCLPTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:19:36 -0500
Received: from foss.arm.com ([217.140.110.172]:55386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbhCLPTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:19:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9E221FB;
        Fri, 12 Mar 2021 07:19:11 -0800 (PST)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25E93F7D7;
        Fri, 12 Mar 2021 07:19:08 -0800 (PST)
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
Subject: [PATCH v10 0/6] MTE support for KVM guest
Date:   Fri, 12 Mar 2021 15:18:56 +0000
Message-Id: <20210312151902.17853-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for using the Arm Memory Tagging Extensions
(MTE) in a KVM guest.

This version is rebased on v5.12-rc2.

Changes since v9[1]:
 * Check fault_status in user_mem_abort() to avoid unnecessarily
   checking if tags need clearing when handling permission faults.
 * The MTE CPU feature exposed is now 0b10 explicitly rather than the
   host's CPU feature. This prevents problems when a newer MTE version
   is supported by the host CPU.
 * Add a couple of reserved u64s to struct kvm_arm_copy_mte_tags for
   potential future expansion (and check they are 0 for now).
 * Correctly hold slots_lock during the ioctl (rather than
   embarrassingly not do any locking as before...).
 * Add the structure definition to the documentation and some
   improvements suggested by Peter.

[1] https://lore.kernel.org/r/20210301142315.30920-1-steven.price%40arm.com

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
 arch/arm64/kvm/mmu.c                       | 16 +++++
 arch/arm64/kvm/sys_regs.c                  | 28 ++++++--
 include/uapi/linux/kvm.h                   |  2 +
 16 files changed, 313 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_mte.h

-- 
2.20.1

