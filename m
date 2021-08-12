Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2198C3E9DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhHLFJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:09:53 -0400
Received: from foss.arm.com ([217.140.110.172]:37658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234260AbhHLFJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:09:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19231042;
        Wed, 11 Aug 2021 22:09:24 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.68.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C24773F40C;
        Wed, 11 Aug 2021 22:09:21 -0700 (PDT)
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
Subject: [PATCH V2 3/5] KVM: arm64: Drop init_common_resources()
Date:   Thu, 12 Aug 2021 10:39:52 +0530
Message-Id: <1628744994-16623-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
References: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could do without this additional indirection via init_common_resources() by
just calling kvm_set_ipa_limit() directly instead.

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

