Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0E63A5ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhFNJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:07:44 -0400
Received: from foss.arm.com ([217.140.110.172]:58204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232602AbhFNJHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:07:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C54F61FB;
        Mon, 14 Jun 2021 02:05:40 -0700 (PDT)
Received: from e112269-lin.arm.com (autoplooker.cambridge.arm.com [10.1.194.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 062103F694;
        Mon, 14 Jun 2021 02:05:37 -0700 (PDT)
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
Subject: [PATCH v15 0/7] MTE support for KVM guest
Date:   Mon, 14 Jun 2021 10:05:18 +0100
Message-Id: <20210614090525.4338-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for using the Arm Memory Tagging Extensions
(MTE) in a KVM guest.

I realise there are still open questions[1] around the performance of
this series (the 'big lock', tag_sync_lock, introduced in the first
patch). But there should be no impact on non-MTE workloads and until we
get real MTE-enabled hardware it's hard to know whether there is a need
for something more sophisticated or not. Peter Collingbourne's patch[3]
to clear the tags at page allocation time should hide more of the impact
for non-VM cases. So the remaining concern is around VM startup which
could be effectively serialised through the lock.

Changes since v14[2]:

 * Dropped "Handle MTE tags zeroing" patch in favour of Peter's similar
   patch[3] (now in arm64 tree).

 * Improved documentation following Catalin's review.

[1]: https://lore.kernel.org/r/874ke7z3ng.wl-maz%40kernel.org
[2]: https://lore.kernel.org/r/20210607110816.25762-1-steven.price@arm.com/
[3]: https://lore.kernel.org/r/20210602235230.3928842-4-pcc@google.com/

Steven Price (7):
  arm64: mte: Handle race when synchronising tags
  arm64: mte: Sync tags for pages where PTE is untagged
  KVM: arm64: Introduce MTE VM feature
  KVM: arm64: Save/restore MTE registers
  KVM: arm64: Expose KVM_ARM_CAP_MTE
  KVM: arm64: ioctl to fetch/store tags in a guest
  KVM: arm64: Document MTE capability and ioctl

 Documentation/virt/kvm/api.rst             | 57 +++++++++++++++
 arch/arm64/include/asm/kvm_arm.h           |  3 +-
 arch/arm64/include/asm/kvm_emulate.h       |  3 +
 arch/arm64/include/asm/kvm_host.h          | 12 ++++
 arch/arm64/include/asm/kvm_mte.h           | 66 +++++++++++++++++
 arch/arm64/include/asm/mte-def.h           |  1 +
 arch/arm64/include/asm/mte.h               |  8 ++-
 arch/arm64/include/asm/pgtable.h           | 22 +++++-
 arch/arm64/include/asm/sysreg.h            |  3 +-
 arch/arm64/include/uapi/asm/kvm.h          | 11 +++
 arch/arm64/kernel/asm-offsets.c            |  2 +
 arch/arm64/kernel/mte.c                    | 54 ++++++++++++--
 arch/arm64/kvm/arm.c                       | 16 +++++
 arch/arm64/kvm/guest.c                     | 82 ++++++++++++++++++++++
 arch/arm64/kvm/hyp/entry.S                 |  7 ++
 arch/arm64/kvm/hyp/exception.c             |  3 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 21 ++++++
 arch/arm64/kvm/mmu.c                       | 42 ++++++++++-
 arch/arm64/kvm/reset.c                     |  3 +-
 arch/arm64/kvm/sys_regs.c                  | 32 +++++++--
 include/uapi/linux/kvm.h                   |  2 +
 21 files changed, 429 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_mte.h

-- 
2.20.1

