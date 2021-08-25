Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF65F3F7A15
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhHYQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:39 -0400
Received: from foss.arm.com ([217.140.110.172]:54748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240493AbhHYQSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EFA81042;
        Wed, 25 Aug 2021 09:17:33 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B48FB3F66F;
        Wed, 25 Aug 2021 09:17:31 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 13/39] KVM: arm64: Add CONFIG_KVM_ARM_SPE Kconfig option
Date:   Wed, 25 Aug 2021 17:17:49 +0100
Message-Id: <20210825161815.266051-14-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new configuration option that will be used for KVM SPE emulation.
CONFIG_KVM_ARM_SPE depends on the SPE driver being builtin because:

1. The cpumask of physical CPUs that support SPE will be used by KVM to
   emulate SPE on heterogeneous systems.

2. KVM will rely on the SPE driver enabling the SPE interrupt at the GIC
   level.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index a4eba0908bfa..c6ad5a05efb3 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -46,6 +46,14 @@ if KVM
 
 source "virt/kvm/Kconfig"
 
+config KVM_ARM_SPE
+	bool "Virtual Statistical Profiling Extension (SPE) support"
+	depends on ARM_SPE_PMU=y
+	default y
+	help
+	  Adds support for Statistical Profiling Extension (SPE) in virtual
+	  machines.
+
 endif # KVM
 
 endif # VIRTUALIZATION
-- 
2.33.0

