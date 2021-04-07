Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C76356D69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344647AbhDGNih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:38:37 -0400
Received: from foss.arm.com ([217.140.110.172]:57314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233071AbhDGNig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:38:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D58911063;
        Wed,  7 Apr 2021 06:38:26 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D35933F792;
        Wed,  7 Apr 2021 06:38:25 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Derrick McKee <derrick.mckee@gmail.com>
Subject: [PATCH] arm64: mte: Remove unused mte_assign_mem_tag_range()
Date:   Wed,  7 Apr 2021 14:38:17 +0100
Message-Id: <20210407133817.23053-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mte_assign_mem_tag_range() was added in commit 85f49cae4dfc
("arm64: mte: add in-kernel MTE helpers") in 5.11 but moved out of
mte.S by commit 2cb34276427a ("arm64: kasan: simplify and inline
MTE functions") in 5.12 and renamed to mte_set_mem_tag_range().
2cb34276427a did not delete the old function prototypes in mte.h.

Remove the unused prototype from mte.h.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reported-by: Derrick McKee <derrick.mckee@gmail.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/mte.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 9b557a457f24..387279540139 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -47,8 +47,6 @@ long get_mte_ctrl(struct task_struct *task);
 int mte_ptrace_copy_tags(struct task_struct *child, long request,
 			 unsigned long addr, unsigned long data);
 
-void mte_assign_mem_tag_range(void *addr, size_t size);
-
 #else /* CONFIG_ARM64_MTE */
 
 /* unused if !CONFIG_ARM64_MTE, silence the compiler */
@@ -84,10 +82,6 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
 	return -EIO;
 }
 
-static inline void mte_assign_mem_tag_range(void *addr, size_t size)
-{
-}
-
 #endif /* CONFIG_ARM64_MTE */
 
 #endif /* __ASSEMBLY__ */
-- 
2.30.2

