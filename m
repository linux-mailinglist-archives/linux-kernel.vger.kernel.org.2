Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465493C7BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbhGNCX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:23:56 -0400
Received: from foss.arm.com ([217.140.110.172]:55708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237397AbhGNCXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:23:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5BD61FB;
        Tue, 13 Jul 2021 19:21:04 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51EE53F7D8;
        Tue, 13 Jul 2021 19:21:01 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 00/10] arm64/mm: Enable FEAT_LPA2 (52 bits PA support on 4K|16K pages)
Date:   Wed, 14 Jul 2021 07:51:21 +0530
Message-Id: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables 52 bits PA support for 4K and 16K page configs via
existing CONFIG_ARM64_PA_BITS_52, utilizing a new arch feature FEAT_LPA2
which is available from ARM v8.7. IDMAP needs changes to accommodate two
new level of page tables in certain scenarios like (4K|39VA|52PA) but the
same problem also exists for (16K|36VA|48PA) which needs fixing. I am
currently working on the IDMAP fix for 16K and later will enable it for
FEAT_LPA2 as well.

This series applies on v5.14-rc1.

Testing:

Build and boot tested (individual patches) on all existing and new
FEAT_LPA2 enabled config combinations.

Pending:

- Enable IDMAP for FEAT_LPA2
- Enable 52 bit VA range on 4K/16K page sizes
- Evaluate KVM and SMMU impacts from FEAT_LPA2

Anshuman Khandual (10):
  mm/mmap: Dynamically initialize protection_map[]
  arm64/mm: Consolidate TCR_EL1 fields
  arm64/mm: Add FEAT_LPA2 specific TCR_EL1.DS field
  arm64/mm: Add FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2]
  arm64/mm: Add CONFIG_ARM64_PA_BITS_52_[LPA|LPA2]
  arm64/mm: Add FEAT_LPA2 specific encoding
  arm64/mm: Detect and enable FEAT_LPA2
  arm64/mm: Add FEAT_LPA2 specific PTE_SHARED and PMD_SECT_S
  arm64/mm: Add FEAT_LPA2 specific fallback (48 bits PA) when not implemented
  arm64/mm: Enable CONFIG_ARM64_PA_BITS_52 on CONFIG_ARM64_[4K|16K]_PAGES

 arch/arm64/Kconfig                      |  9 +++++-
 arch/arm64/include/asm/assembler.h      | 48 ++++++++++++++++++++++------
 arch/arm64/include/asm/kernel-pgtable.h |  4 +--
 arch/arm64/include/asm/memory.h         |  1 +
 arch/arm64/include/asm/pgtable-hwdef.h  | 28 ++++++++++++++---
 arch/arm64/include/asm/pgtable.h        | 18 +++++++++--
 arch/arm64/include/asm/sysreg.h         |  9 +++---
 arch/arm64/kernel/head.S                | 55 ++++++++++++++++++++++++++-------
 arch/arm64/mm/mmu.c                     |  3 ++
 arch/arm64/mm/pgd.c                     |  2 +-
 arch/arm64/mm/proc.S                    | 11 ++++++-
 arch/arm64/mm/ptdump.c                  | 26 ++++++++++++++--
 mm/mmap.c                               | 26 +++++++++++++---
 13 files changed, 195 insertions(+), 45 deletions(-)

-- 
2.7.4

