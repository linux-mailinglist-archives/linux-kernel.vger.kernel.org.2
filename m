Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4E3F7A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbhHYQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:19:04 -0400
Received: from foss.arm.com ([217.140.110.172]:54768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240932AbhHYQSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A36DD1042;
        Wed, 25 Aug 2021 09:17:49 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1AA3F66F;
        Wed, 25 Aug 2021 09:17:48 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: [RFC PATCH v4 23/39] KVM: arm64: VHE: Clear MDCR_EL2.E2PB in vcpu_put()
Date:   Wed, 25 Aug 2021 17:17:59 +0100
Message-Id: <20210825161815.266051-24-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

On VHE systems, the kernel executes at EL2 and configures the profiling
buffer to use the EL2&0 translation regime and to trap accesses from the
guest by clearing MDCR_EL2.E2PB. In vcpu_put(), KVM does a bitwise or with
the E2PB mask, preserving its value. This has been correct so far, since
MDCR_EL2.E2B has the same value (0b00) for all VMs, as set by
kvm_arm_setup_mdcr_el2().

However, this will change when KVM enables support for SPE in guests. For
such guests KVM will configure the profiling buffer to use the EL1&0
translation regime, a setting that is obviously undesirable to be preserved
for the host running at EL2. Let's avoid this situation by explicitly
clearing E2PB in vcpu_put().

[ Alexandru E: Reworded commit ]

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/hyp/vhe/switch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index b3229924d243..86d4c8c33f3e 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -95,9 +95,7 @@ void deactivate_traps_vhe_put(void)
 {
 	u64 mdcr_el2 = read_sysreg(mdcr_el2);
 
-	mdcr_el2 &= MDCR_EL2_HPMN_MASK |
-		    MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT |
-		    MDCR_EL2_TPMS;
+	mdcr_el2 &= MDCR_EL2_HPMN_MASK | MDCR_EL2_TPMS;
 
 	write_sysreg(mdcr_el2, mdcr_el2);
 
-- 
2.33.0

