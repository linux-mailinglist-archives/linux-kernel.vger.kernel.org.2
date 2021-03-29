Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1862534D6DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhC2SS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhC2SR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:17:56 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3EC5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=8AEiwnSsasg6gLp5dzgvHy4Ekf+YglgM5SFsq1PHSp4=; b=MytSx5WYdNAIS
        raZizWn3fBGBzqGuCU8LEm7rANsdZA2U6+ZjrFVx2zVFowB/SvEox+M+j1hZiKR7
        0PzbYC571M5H54l4M+t8RZ4v2YbIlnEAtGwZnvEBKPnESue73FYaTt6dEfPgNvCh
        lVZ5EqqDukM+TZq7JTqjSzWVvQNcHQ=
Received: from xhacker (unknown [101.86.19.180])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAnLkqxGWJgMuZpAA--.42274S2;
        Tue, 30 Mar 2021 02:17:22 +0800 (CST)
Date:   Tue, 30 Mar 2021 02:12:26 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: add do_page_fault and do_trap_break into the kprobes
 blacklist
Message-ID: <20210330021226.2fc7b2ec@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygAnLkqxGWJgMuZpAA--.42274S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyxKw47Gw4UXFy7JFW7XFb_yoWDKrg_C3
        Z2k3yfWrWrJa109F97tws3GF40y3sYkF93G3ZFvrWrCFyYgr18Kw45ta15tr1DX34fua97
        Zr9xXr93G3WIqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbFxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1VbkUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

These two functions are used to implement the kprobes feature so they
can't be kprobed.

Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/traps.c | 1 +
 arch/riscv/mm/fault.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0879b5df11b9..1357abf79570 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -178,6 +178,7 @@ asmlinkage __visible void do_trap_break(struct pt_regs *regs)
 	else
 		die(regs, "Kernel BUG");
 }
+NOKPROBE_SYMBOL(do_trap_break);
 
 #ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long pc)
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 8f17519208c7..c5dbd55cbf7c 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -328,3 +328,4 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	}
 	return;
 }
+NOKPROBE_SYMBOL(do_page_fault);
-- 
2.31.0


