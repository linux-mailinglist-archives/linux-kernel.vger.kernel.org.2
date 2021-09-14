Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED49640B306
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhINP3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:29:20 -0400
Received: from foss.arm.com ([217.140.110.172]:46260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233202AbhINP3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:29:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C66D101E;
        Tue, 14 Sep 2021 08:28:02 -0700 (PDT)
Received: from a077416.arm.com (unknown [10.163.44.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82DAB3F5A1;
        Tue, 14 Sep 2021 08:27:59 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] arm64/traps: Avoid unnecessary kernel/user pointer conversion
Date:   Tue, 14 Sep 2021 20:57:42 +0530
Message-Id: <20210914152742.27047-1-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotating a pointer from kernel to __user and then back again might
confuse sparse. In call_undef_hook() it can be avoided by not using the
intermediate user pointer variable.

Note: This patch adds no functional changes to code.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/arm64/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b03e383d944a..357d10a8bbf5 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -404,7 +404,8 @@ static int call_undef_hook(struct pt_regs *regs)
 
 	if (!user_mode(regs)) {
 		__le32 instr_le;
-		if (get_kernel_nofault(instr_le, (__force __le32 *)pc))
+		if (get_kernel_nofault(instr_le,
+				       (__le32 *)instruction_pointer(regs)))
 			goto exit;
 		instr = le32_to_cpu(instr_le);
 	} else if (compat_thumb_mode(regs)) {
-- 
2.17.1

