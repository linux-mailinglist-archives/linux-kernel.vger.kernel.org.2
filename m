Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342CD41C5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbhI2Nrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:47:49 -0400
Received: from m12-11.163.com ([220.181.12.11]:52385 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243959AbhI2Nrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:47:48 -0400
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Sep 2021 09:47:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=SEa26DOreuk50DuLo7
        /JXFySenvdL7ez8pgadwWmGF4=; b=anhrGf5OrD1tRtp+tJeZXcVRcYZV+RmSNW
        MWqzbEXgcl5uHqwQ+38+HX8I/9WiCyD0wVoF2xd4g2EqVF4TdcFSxn+9dBnbonLz
        TbcBLMABajtVMdG3FaG8rO+ZgroDOsflmRmOs0PlTip6cYcs7o286RHVJYHEO1E6
        2LGF/keFc=
Received: from localhost.localdomain (unknown [171.221.149.2])
        by smtp7 (Coremail) with SMTP id C8CowACHfeJ9alRhZSVNzQ--.55562S2;
        Wed, 29 Sep 2021 21:30:44 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chen Lin <chen.lin5@zte.com.cn>
Subject: [PATCH] arm64: traps: add dump instr before BUG in kernel
Date:   Wed, 29 Sep 2021 21:29:46 +0800
Message-Id: <1632922186-3116-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: C8CowACHfeJ9alRhZSVNzQ--.55562S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWfur4DGrW5tFyxGr1xKrg_yoWfXrX_KF
        yS9r48ur1FyF1IvFyjk3yvvFyIkrW8JFW09w10vFZ5Gas8Xrs8Aw45JF909rn5WryrKrnx
        XrnrArnIv3W3JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeJrc7UUUUU==
X-Originating-IP: [171.221.149.2]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/1tbiXQQdnlWBk5vf8wAAsq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Lin <chen.lin5@zte.com.cn>

we should dump the real instructions before BUG in kernel mode, and
compare this to the instructions from objdump.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
---
 arch/arm64/kernel/traps.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b03e383..621a9dd 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -495,7 +495,12 @@ void do_undefinstr(struct pt_regs *regs)
 	if (call_undef_hook(regs) == 0)
 		return;
 
-	BUG_ON(!user_mode(regs));
+	if (!user_mode(regs)) {
+		pr_emerg("Undef instruction in kernel, dump instr:");
+		dump_kernel_instr(KERN_EMERG, regs);
+		BUG();
+	}
+
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
 NOKPROBE_SYMBOL(do_undefinstr);
-- 
1.7.9.5

