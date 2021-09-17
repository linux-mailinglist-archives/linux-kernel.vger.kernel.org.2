Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1D740F1CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 07:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbhIQF7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 01:59:45 -0400
Received: from foss.arm.com ([217.140.110.172]:48300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230133AbhIQF7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 01:59:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 738F331B;
        Thu, 16 Sep 2021 22:58:22 -0700 (PDT)
Received: from a077416.arm.com (unknown [10.163.42.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 595343F5A1;
        Thu, 16 Sep 2021 22:58:19 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2] arm64/traps: Avoid unnecessary kernel/user pointer conversion
Date:   Fri, 17 Sep 2021 11:28:11 +0530
Message-Id: <20210917055811.22341-1-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotating a pointer from kernel to __user and then back again requires
an extra __force annotation to silent sparse warning. In call_undef_hook()
this unnecessary complexity can be avoided by modifying the intermediate
user pointer to unsigned long.

This way there is no inter-changeable use of user and kernel pointers
and the code is consistent.

Note: This patch adds no functional changes to code.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
Changes from v1:
* Instead of directly using instruction_pointer() for kernel pointers,
  modified the pc type from void __user * to unsigned long as suggested
  by Mark Rutland.

 arch/arm64/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b03e383d944a..09236751283e 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -400,11 +400,11 @@ static int call_undef_hook(struct pt_regs *regs)
 	unsigned long flags;
 	u32 instr;
 	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
-	void __user *pc = (void __user *)instruction_pointer(regs);
+	unsigned long pc = instruction_pointer(regs);
 
 	if (!user_mode(regs)) {
 		__le32 instr_le;
-		if (get_kernel_nofault(instr_le, (__force __le32 *)pc))
+		if (get_kernel_nofault(instr_le, (__le32 *)pc))
 			goto exit;
 		instr = le32_to_cpu(instr_le);
 	} else if (compat_thumb_mode(regs)) {
-- 
2.17.1

