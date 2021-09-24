Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01CF416CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbhIXHiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 03:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244344AbhIXHiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 03:38:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 964F260E08;
        Fri, 24 Sep 2021 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632469011;
        bh=LpHb8A+wUT0ue+o052SvF/xrnFqr5rMpVkjCEtBXzBg=;
        h=From:To:Cc:Subject:Date:From;
        b=EONxVMBVcJeRE2R02Y+usrP5eWq+D26Y6GvrrJrJSftkXNjp/5qOKVff17PnXtwGe
         qdswHKFQHmSz43b3SZzvKkOEgjhpjGkSxjEJn22FAx3DBEqjtDd7ZRnqnuNmHGwkqE
         VnAsdJQF+frVHQMqIxfoMHkm2hJKTXfzaLFb9OYOk2IfWK5U3VTxjrSACxFwTD6WWV
         5EY1SOzG/MIZkAMG+K+LRzBuI35qcBbB25eYsFTKAke05/Wmq+tPbGoXkJYP083dQn
         UZQjdFYefr/0rA/OaDq+wzpBu9XvXYPV4y5OhgWnxxd/krrWieK6JkVvdgzOr2o21+
         ttgHYiuW0BFKw==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] csky: Fixup regs.sr broken in ptrace
Date:   Fri, 24 Sep 2021 15:36:45 +0800
Message-Id: <20210924073645.1145907-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

gpr_get() return the entire pt_regs (include sr) to userspace, if we
don't restore the C bit in gpr_set, it may break the ALU result in
that context. So the C flag bit is part of gpr context, that's why
riscv totally remove the C bit in the ISA. That makes sr reg clear
from userspace to supervisor privilege.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/csky/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 0105ac81b432..1a5f54e0d272 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -99,7 +99,8 @@ static int gpr_set(struct task_struct *target,
 	if (ret)
 		return ret;
 
-	regs.sr = task_pt_regs(target)->sr;
+	/* BIT(0) of regs.sr is Condition Code/Carry bit */
+	regs.sr = (regs.sr & BIT(0)) | (task_pt_regs(target)->sr & ~BIT(0));
 #ifdef CONFIG_CPU_HAS_HILO
 	regs.dcsr = task_pt_regs(target)->dcsr;
 #endif
-- 
2.25.1

