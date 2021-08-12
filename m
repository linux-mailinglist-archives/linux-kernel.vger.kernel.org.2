Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A931A3EADB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbhHLXiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238417AbhHLXi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A10960EE2;
        Thu, 12 Aug 2021 23:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811482;
        bh=t0y1Zd6GQZMYoGFevFFkBQTS73Vy19z+gE09o2JvAIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=luSYuKdNhi/DuXx9297D2f0p5HeU1kvjcfpqOAUjBqzOC056SojDpSuEeMGm+c5Hl
         tc/kj/Q/oeVF3Pm8oBm5gXgDjjQyKveTpxj4vfVEW4HUR7ur8Z4E9Sj66F99vTaKgh
         8hEGmQk6aJ6lZF3gRT7+xVn70njJ6pUKDT01x7Id6OprW1K04FSo2k9gBXRXGEqK5g
         Dabm6safYGwJcxgYUJ6f5i4Rv/2jadNXcg97MnXpN2evl/cbkwcJNplatxAGigNJ1N
         baFT2fEpFwqRarqgI4zuo46i5WN+YwQUzQlR3lHaDzPsJUml14VMqikoaL9g809yzh
         J0u+PNKR+6hrA==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Jose Abreu <joabreu@synopsys.com>
Subject: [PATCH v2 12/19] ARC: mm: move MMU specific bits out of entry code ...
Date:   Thu, 12 Aug 2021 16:37:46 -0700
Message-Id: <20210812233753.104217-13-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... to avoid polluting shared entry code (across three ISA variants)
with ISA/MMU specific code.

Cc: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/mmu.h    | 8 ++++++++
 arch/arc/kernel/entry-arcv2.S | 1 +
 arch/arc/kernel/entry.S       | 7 ++-----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
index 0b117ea07048..414a27e806b6 100644
--- a/arch/arc/include/asm/mmu.h
+++ b/arch/arc/include/asm/mmu.h
@@ -84,6 +84,14 @@ static inline int is_pae40_enabled(void)
 
 extern int pae40_exist_but_not_enab(void);
 
+#else
+
+.macro ARC_MMU_REENABLE reg
+	lr \reg, [ARC_REG_PID]
+	or \reg, \reg, MMU_ENABLE
+	sr \reg, [ARC_REG_PID]
+.endm
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif
diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index 12d5f12d10d2..a7e6a2174187 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -10,6 +10,7 @@
 #include <asm/errno.h>
 #include <asm/arcregs.h>
 #include <asm/irqflags.h>
+#include <asm/mmu.h>
 
 ; A maximum number of supported interrupts in the core interrupt controller.
 ; This number is not equal to the maximum interrupt number (256) because
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 2cb8dfe866b6..dd77a0c8f740 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -101,11 +101,8 @@ ENTRY(EV_MachineCheck)
 	lr  r0, [efa]
 	mov r1, sp
 
-	; hardware auto-disables MMU, re-enable it to allow kernel vaddr
-	; access for say stack unwinding of modules for crash dumps
-	lr	r3, [ARC_REG_PID]
-	or	r3, r3, MMU_ENABLE
-	sr	r3, [ARC_REG_PID]
+	; MC excpetions disable MMU
+	ARC_MMU_REENABLE r3
 
 	lsr  	r3, r2, 8
 	bmsk 	r3, r3, 7
-- 
2.25.1

