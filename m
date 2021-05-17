Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A29382C27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhEQMe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:34:26 -0400
Received: from foss.arm.com ([217.140.110.172]:50034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhEQMeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:34:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF98F113E;
        Mon, 17 May 2021 05:33:08 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0111E3F73B;
        Mon, 17 May 2021 05:33:05 -0700 (PDT)
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
Subject: [PATCH v12 0/8] MTE support for KVM guest
Date:   Mon, 17 May 2021 13:32:31 +0100
Message-Id: <20210517123239.8025-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for using the Arm Memory Tagging Extensions
(MTE) in a KVM guest.

Changes since v11[1]:

 * Series is prefixed with a bug fix for a potential race synchronising
   tags. This is basically race as was recently[2] fixed for
   PG_dcache_clean where the update of the page flag cannot be done
   atomically with the work that flag represents.

   For the PG_dcache_clean case the problem is easier because extra
   cache maintenance isn't a problem, but here restoring the tags twice
   could cause data loss.

   The current solution is a global spinlock for mte_sync_page_tags().
   If we hit scalability problems that other solutions such as
   potentially using another page flag as a lock will need to be
   investigated.

 * The second patch is from Catalin to mitigate the performance impact
   of the first - by handling the page zeroing case explicitly we can
   avoid entering mte_sync_page_tags() at all in most cases. Peter
   Collingbourne has a patch which similarly improves this case using
   the DC GZVA instruction. So this patch may be dropped in favour of
   Peter's, however Catalin's is likely easier to backport.

 * Use pte_access_permitted() in set_pte_at() to identify pages which
   may be accessed by the user rather than open-coding a check for
   PTE_USER. Also add a comment documenting what's going on.
   There's also some short-cuts added in mte_sync_tags() compared to the
   previous post, to again mitigate the performance impact of the first
   patch.

 * Move the code to sanitise tags out of user_mem_abort() into its own
   function. Also call this new function from kvm_set_spte_gfn() as that
   path was missing the sanitising.

   Originally I was going to move the code all the way down to
   kvm_pgtable_stage2_map(). Sadly as that also part of the EL2
   hypervisor this breaks nVHE as the code needs to perform actions in
   the host.

 * Drop the union in struct kvm_vcpu_events - it served no purpose and
   was confusing.

 * Update CAP number (again) and other minor conflict resolutions.

[1] https://lore.kernel.org/r/20210416154309.22129-1-steven.price@arm.com/
[2] https://lore.kernel.org/r/20210514095001.13236-1-catalin.marinas@arm.com/
[3] https://lore.kernel.org/r/de812a02fd94a0dba07d43606bd893c564aa4528.1620849613.git.pcc@google.com/

Catalin Marinas (1):
  arm64: Handle MTE tags zeroing in __alloc_zeroed_user_highpage()

Steven Price (7):
  arm64: mte: Handle race when synchronising tags
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
 arch/arm64/include/asm/page.h              |  6 +-
 arch/arm64/include/asm/pgtable.h           |  9 ++-
 arch/arm64/include/asm/sysreg.h            |  3 +-
 arch/arm64/include/uapi/asm/kvm.h          | 11 +++
 arch/arm64/kernel/asm-offsets.c            |  3 +
 arch/arm64/kernel/mte.c                    | 37 ++++++++--
 arch/arm64/kvm/arm.c                       | 78 ++++++++++++++++++++++
 arch/arm64/kvm/hyp/entry.S                 |  7 ++
 arch/arm64/kvm/hyp/exception.c             |  3 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 21 ++++++
 arch/arm64/kvm/mmu.c                       | 37 +++++++++-
 arch/arm64/kvm/sys_regs.c                  | 28 ++++++--
 arch/arm64/mm/fault.c                      | 21 ++++++
 include/uapi/linux/kvm.h                   |  2 +
 18 files changed, 381 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_mte.h

-- 
2.20.1

