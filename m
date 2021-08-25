Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DBC3F7A41
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhHYQUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:20:14 -0400
Received: from foss.arm.com ([217.140.110.172]:54778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240935AbhHYQS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABECD1042;
        Wed, 25 Aug 2021 09:18:13 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B7E43F66F;
        Wed, 25 Aug 2021 09:18:12 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 38/39] KVM: arm64: Make CONFIG_KVM_ARM_SPE depend on !CONFIG_NUMA_BALANCING
Date:   Wed, 25 Aug 2021 17:18:14 +0100
Message-Id: <20210825161815.266051-39-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Automatic NUMA balancing is a performance strategy that Linux uses to
reduce the cost associated with memory accesses by having a task use
the memory closest to the NUMA node where the task is executing. This is
accomplished by triggering periodic page faults to examine the memory
location that a task uses, and decide if page migration is necessary.

The periodic page faults that drive automatic NUMA balancing are triggered
by clearing permissions on certain pages from the task's address space.
Clearing the permissions invokes mmu_notifier_invalidate_range_start(),
which causes guest memory from being unmapped from stage 2. As a result,
SPE can start reporting stage 2 faults, which KVM has no way of handling.

Make CONFIG_KVM_ARM_SPE depend on !CONFIG_NUMA_BALANCING to keep SPE usable
for a guest.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index c6ad5a05efb3..1ea34eb29fb4 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -48,7 +48,7 @@ source "virt/kvm/Kconfig"
 
 config KVM_ARM_SPE
 	bool "Virtual Statistical Profiling Extension (SPE) support"
-	depends on ARM_SPE_PMU=y
+	depends on ARM_SPE_PMU=y && !NUMA_BALANCING
 	default y
 	help
 	  Adds support for Statistical Profiling Extension (SPE) in virtual
-- 
2.33.0

