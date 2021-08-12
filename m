Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31743E9DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhHLFJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:09:59 -0400
Received: from foss.arm.com ([217.140.110.172]:37690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234287AbhHLFJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:09:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E7521042;
        Wed, 11 Aug 2021 22:09:33 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.68.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B63CC3F40C;
        Wed, 11 Aug 2021 22:09:29 -0700 (PDT)
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
Subject: [PATCH V2 5/5] KVM: arm64: Drop unused REQUIRES_VIRT
Date:   Thu, 12 Aug 2021 10:39:54 +0530
Message-Id: <1628744994-16623-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
References: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems like a residue from the past. REQUIRES_VIRT is no more available
. Hence it can just be dropped along with the related code section.

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
 arch/arm64/kvm/arm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ee9b1166f330..d779a29c5607 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -42,10 +42,6 @@
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_psci.h>
 
-#ifdef REQUIRES_VIRT
-__asm__(".arch_extension	virt");
-#endif
-
 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
 DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 
-- 
2.20.1

