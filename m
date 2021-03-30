Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C814C34E6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhC3L6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:58:43 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:10458 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhC3L6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:58:18 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id C10A840038F;
        Tue, 30 Mar 2021 19:58:11 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>,
        zhouchuangao <zhouchuangao@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/kernel/probes: Use BUG_ON instead of if condition followed by BUG.
Date:   Tue, 30 Mar 2021 04:57:50 -0700
Message-Id: <1617105472-6081-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSUkfS04eH01JQ0NPVkpNSkxKS05PQklLQktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6PRw6Nz8IMDcyHxE0DEw9
        HxYKCTFVSlVKTUpMSktOT0JJSElPVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpCQ0M3Bg++
X-HM-Tid: 0a7882ff982ed991kuwsc10a840038f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be optimized at compile time.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 arch/arm64/kernel/probes/kprobes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 66aac28..ecf0f61 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -264,8 +264,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		 * normal page fault.
 		 */
 		instruction_pointer_set(regs, (unsigned long) cur->addr);
-		if (!instruction_pointer(regs))
-			BUG();
+		BUG_ON(!instruction_pointer(regs));
 
 		if (kcb->kprobe_status == KPROBE_REENTER)
 			restore_previous_kprobe(kcb);
-- 
2.7.4

