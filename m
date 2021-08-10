Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074AF3E5409
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbhHJHCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:02:34 -0400
Received: from foss.arm.com ([217.140.110.172]:48906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237242AbhHJHCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:02:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22D0FD6E;
        Tue, 10 Aug 2021 00:02:11 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7158B3F718;
        Tue, 10 Aug 2021 00:02:07 -0700 (PDT)
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
Subject: [PATCH 2/5] KVM: arm64: Drop init_common_resources()
Date:   Tue, 10 Aug 2021 12:32:38 +0530
Message-Id: <1628578961-29097-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could do without this additional indirection via init_common_resources() by
just calling kvm_set_ipa_limit() directly instead. This change saves memory
and cycles.

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kvm/arm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..19560e457c11 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1696,11 +1696,6 @@ static bool init_psci_relay(void)
 	return true;
 }
 
-static int init_common_resources(void)
-{
-	return kvm_set_ipa_limit();
-}
-
 static int init_subsystems(void)
 {
 	int err = 0;
@@ -2102,7 +2097,7 @@ int kvm_arch_init(void *opaque)
 		}
 	}
 
-	err = init_common_resources();
+	err = kvm_set_ipa_limit();
 	if (err)
 		return err;
 
-- 
2.20.1

