Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A9A41128A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhITKGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234414AbhITKGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:06:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DCB760F21;
        Mon, 20 Sep 2021 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632132320;
        bh=BQ/pJEAhwojVoXtwSmRnTJ5Rlh46slyFWdQtV+Ah9rk=;
        h=From:To:Cc:Subject:Date:From;
        b=QsMHE9cHRVHvL8TUDwOHjUyfsYxJwqNDZmA2zBcwiVPnbOZ25NxJ4zdovMO4c1oRk
         R0hnaa7WcCV7cJ8mVF5oZoNinUu4YmkzZyiASj/ni+NkMWrleyFV7+No5ltYAyW5gp
         rEcwqCdSa+5Ao6D2nyS/YuxlvrGSZSjBewJ9tLB8pDAeIsVN/+lg5O4vBrCT6tw25t
         BTW/yDARFOjM7AAF1RpeKx/tOIB9azMOXWktc5+WSAa7eBy4fCr64Vs9htrdPUwDs3
         zRSSGQNHt1og8bbBuW8ySHKOsejbT8uOgyXKXm+D+ObD65slQOFAFbKd46WrGH0Zvz
         C5m5PWMxh0Ilw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        David Brazdil <dbrazdil@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Quentin Perret <qperret@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm: add Kbuild FORCE prerequisite for hyp-reloc
Date:   Mon, 20 Sep 2021 12:05:10 +0200
Message-Id: <20210920100515.1554788-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Commit e1f86d7b4b2a ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule)
and filechk") added a helpful check for Kbuild, which now notices
that a problem with the hyp-reloc rule:

arch/arm64/kvm/hyp/nvhe/Makefile:58: FORCE prerequisite is missing

Do as suggested and add FORCE here.

Fixes: 8c49b5d43d4c ("KVM: arm64: Generate hyp relocation data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 5df6193fc430..8d741f71377f 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -54,7 +54,7 @@ $(obj)/kvm_nvhe.tmp.o: $(obj)/hyp.lds $(addprefix $(obj)/,$(hyp-obj)) FORCE
 #    runtime. Because the hypervisor is part of the kernel binary, relocations
 #    produce a kernel VA. We enumerate relocations targeting hyp at build time
 #    and convert the kernel VAs at those positions to hyp VAs.
-$(obj)/hyp-reloc.S: $(obj)/kvm_nvhe.tmp.o $(obj)/gen-hyprel
+$(obj)/hyp-reloc.S: $(obj)/kvm_nvhe.tmp.o $(obj)/gen-hyprel FORCE
 	$(call if_changed,hyprel)
 
 # 5) Compile hyp-reloc.S and link it into the existing partially linked object.
-- 
2.29.2

