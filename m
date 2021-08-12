Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C144D3E9DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhHLFJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:09:40 -0400
Received: from foss.arm.com ([217.140.110.172]:37624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhHLFJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:09:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC32C1042;
        Wed, 11 Aug 2021 22:09:13 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.68.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4FF073F40C;
        Wed, 11 Aug 2021 22:09:10 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/5] KVM: arm64: General cleanups
Date:   Thu, 12 Aug 2021 10:39:49 +0530
Message-Id: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains mostly unrelated general cleanups. This series applies
on v5.14-rc5 and has been boot tested with different page sized guests.

Changes in V2:

- Dropped the first patch regarding PAGE_[SHIFT|SIZE] per Marc
- Added remaining ID_AA64MMFR0_PARANGE_ macros and ARM64_MIN_PARANGE_BITS per Marc
- Dropped memory and cycle reference from commit message in [PATCH 3/5]
- Changed return value as u32 in kvm_target_cpu() per Will

Changes in V1:

https://lore.kernel.org/lkml/1628578961-29097-1-git-send-email-anshuman.khandual@arm.com/

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (5):
  arm64/mm: Add remaining ID_AA64MMFR0_PARANGE_ macros
  KVM: arm64: Use ARM64_MIN_PARANGE_BITS as the minimum supported IPA
  KVM: arm64: Drop init_common_resources()
  KVM: arm64: Drop check_kvm_target_cpu() based percpu probe
  KVM: arm64: Drop unused REQUIRES_VIRT

 arch/arm64/include/asm/cpufeature.h | 14 +++++++-------
 arch/arm64/include/asm/kvm_host.h   |  2 +-
 arch/arm64/include/asm/sysreg.h     |  7 +++++++
 arch/arm64/kvm/arm.c                | 27 ++-------------------------
 arch/arm64/kvm/guest.c              |  4 ++--
 arch/arm64/kvm/reset.c              |  2 +-
 6 files changed, 20 insertions(+), 36 deletions(-)

-- 
2.20.1

