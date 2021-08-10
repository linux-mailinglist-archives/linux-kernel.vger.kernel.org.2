Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6E3E5405
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhHJHCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:02:30 -0400
Received: from foss.arm.com ([217.140.110.172]:48880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhHJHCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:02:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F09CED6E;
        Tue, 10 Aug 2021 00:02:02 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74AB93F718;
        Tue, 10 Aug 2021 00:01:59 -0700 (PDT)
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
Subject: [PATCH 0/5] KVM: arm64: General cleanups
Date:   Tue, 10 Aug 2021 12:32:36 +0530
Message-Id: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains mostly unrelated general cleanups. This series applies
on v5.14-rc5 and has been boot tested with different page sized guests.

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
  KVM: arm64: Drop direct PAGE_[SHIFT|SIZE] usage as page size
  KVM: arm64: Drop init_common_resources()
  KVM: arm64: Drop check_kvm_target_cpu() based percpu probe
  KVM: arm64: Drop unused REQUIRES_VIRT
  KVM: arm64: Define KVM_PHYS_SHIFT_MIN

 arch/arm64/include/asm/kvm_mmu.h |  3 ++-
 arch/arm64/kvm/arm.c             | 25 +------------------------
 arch/arm64/kvm/hyp/pgtable.c     |  6 +++---
 arch/arm64/kvm/reset.c           |  2 +-
 arch/arm64/mm/mmu.c              |  2 +-
 5 files changed, 8 insertions(+), 30 deletions(-)

-- 
2.20.1

