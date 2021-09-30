Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA841D7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350041AbhI3KgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:36:06 -0400
Received: from foss.arm.com ([217.140.110.172]:52018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350027AbhI3Kf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:35:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0419106F;
        Thu, 30 Sep 2021 03:34:15 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C291D3F793;
        Thu, 30 Sep 2021 03:34:12 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        steven.price@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V3 00/13] arm64/mm: Enable FEAT_LPA2 (52 bits PA support on 4K|16K pages)
Date:   Thu, 30 Sep 2021 16:05:03 +0530
Message-Id: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables 52 bits PA support for 4K and 16K page configs via
existing CONFIG_ARM64_PA_BITS_52, utilizing a new arch feature FEAT_LPA2
which is available from ARM v8.7. IDMAP needs changes to accommodate two
new level of page tables in certain scenarios like (4K|39VA|52PA) but the
same problem also exists for (16K|36VA|48PA) which needs fixing. I have
sent a fix for 16K case [1] and later will enable it for FEAT_LPA2 as well.

This series applies on v5.15-rc3.

Testing:

Build and boot tested (individual patches) on all existing and new
FEAT_LPA2 enabled config combinations.

Pending:

- Enable IDMAP for FEAT_LPA2
- Enable 52 bit VA range on 4K/16K page sizes
- Evaluate KVM and SMMU impacts from FEAT_LPA2

[1] https://lore.kernel.org/all/1632807225-20189-1-git-send-email-anshuman.khandual@arm.com/

Changes in RFC V3:

- protection_map[] gets reinitialized in platform to avoid build failure per Catalin
- Added __cpu_secondary_check52bitpa()
- Added FEAT_LPA2 support during KVM stage-2 translation
- Updated description for ARM64_PA_BITS_52 per Catalin
- Added tags from last version

Changes in RFC V2:

https://lore.kernel.org/all/1627281445-12445-1-git-send-email-anshuman.khandual@arm.com/

- Changed FEAT_LPA2 presence qualifying criteria wrt ID_AA64MMFR0_TGRAN_LPA2
- Changed FEAT_LPA2 specific encoding which drops the additional tmp variable
- Fixed [phys|pte]_to_[pte|phys]() helpers when FEAT_LPA2 is implemented

Changes in RFC V1:

https://lore.kernel.org/lkml/1626229291-6569-1-git-send-email-anshuman.khandual@arm.com/


Anshuman Khandual (13):
  arm64/mm: Dynamically initialize protection_map[]
  arm64/mm: Consolidate TCR_EL1 fields
  arm64/mm: Add FEAT_LPA2 specific TCR_EL1.DS field
  arm64/mm: Add FEAT_LPA2 specific VTCR_EL2.DS field
  arm64/mm: Add FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2]
  arm64/mm: Add CONFIG_ARM64_PA_BITS_52_[LPA|LPA2]
  arm64/mm: Add FEAT_LPA2 specific encoding
  arm64/mm: Detect and enable FEAT_LPA2
  arm64/mm: Add __cpu_secondary_check52bitpa()
  arm64/mm: Add FEAT_LPA2 specific PTE_SHARED and PMD_SECT_S
  arm64/mm: Add FEAT_LPA2 specific fallback (48 bits PA) when not implemented
  arm64/mm: Enable CONFIG_ARM64_PA_BITS_52 on CONFIG_ARM64_[4K|16K]_PAGES
  KVM: arm64: Enable FEAT_LPA2 based 52 bits IPA size on 4K and 16K

 arch/arm64/Kconfig                      | 17 +++++++----
 arch/arm64/include/asm/assembler.h      | 42 +++++++++++++++++++++------
 arch/arm64/include/asm/kernel-pgtable.h |  4 +--
 arch/arm64/include/asm/kvm_arm.h        |  1 +
 arch/arm64/include/asm/kvm_pgtable.h    | 10 ++++++-
 arch/arm64/include/asm/memory.h         |  1 +
 arch/arm64/include/asm/pgtable-hwdef.h  | 28 ++++++++++++++----
 arch/arm64/include/asm/pgtable-prot.h   | 34 +++++++++++-----------
 arch/arm64/include/asm/pgtable.h        | 18 ++++++++++--
 arch/arm64/include/asm/smp.h            |  1 +
 arch/arm64/include/asm/sysreg.h         |  9 +++---
 arch/arm64/kernel/head.S                | 51 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/smp.c                 |  2 ++
 arch/arm64/kvm/hyp/pgtable.c            | 25 ++++++++++++++--
 arch/arm64/kvm/reset.c                  | 14 ++++++---
 arch/arm64/mm/init.c                    | 22 ++++++++++++++
 arch/arm64/mm/mmu.c                     |  3 ++
 arch/arm64/mm/pgd.c                     |  2 +-
 arch/arm64/mm/proc.S                    | 11 ++++++-
 arch/arm64/mm/ptdump.c                  | 26 +++++++++++++++--
 20 files changed, 265 insertions(+), 56 deletions(-)

-- 
2.7.4

