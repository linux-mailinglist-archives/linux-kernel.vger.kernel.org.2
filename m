Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198AB3625E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhDPQnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbhDPQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:43:07 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D129C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=V43aKoKjJB1GJ8L7DevKb0+AH+9zmQ4aFsOcNjBKj8s=; b=lzmx+h887qjx7
        O0htMlV0I1+BsqSCqTegZP4WtLOZkUTUyye/MuHnceRA7RhAunqWF42YwuPUyZxU
        sLX0tJr7Db9mu0GK9EhJHlELFjAYj9JcLEa61JvYojRYztWTH/KVh5ZIeJRTRbtK
        NOeB81WkiWOQy+m0u1CUin2hyGghKo=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAnLkpyvnlgag7tAA--.45092S2;
        Sat, 17 Apr 2021 00:42:28 +0800 (CST)
Date:   Sat, 17 Apr 2021 00:37:22 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH] riscv: mremap speedup - enable HAVE_MOVE_PUD and
 HAVE_MOVE_PMD
Message-ID: <20210417003539.5bceabc2@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygAnLkpyvnlgag7tAA--.45092S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy3tw1rZw4rXw1rXrWrXwb_yoW8Zw4kpr
        ZIkF9akrZxWF1Ik3yayry8W3yru3Z3WaySqryxGa48ZrW5trWDZrn2qw45JryUGFyvv3s3
        Wa13Kry5G3y7u37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2Iq
        xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
        xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcVWlDUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

HAVE_MOVE_PUD enables remapping pages at the PUD level if both the source
and destination addresses are PUD-aligned.
HAVE_MOVE_PMD does similar speedup on the PMD level.

With HAVE_MOVE_PUD enabled, there is about a 143x improvement on qemu
With HAVE_MOVE_PMD enabled, there is about a 5x improvement on qemu

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
Hi all,

After reading the risc-v privileged spec, I think it's safe to support
the HAVE_MOVE_PUD and HAVE_MOVE_PMD optimization on riscv. The patch passed
the mremap_test on QEMU. However this can't be tested on real HW due to lack
of HW boards, this is the reason why I mark this patch as RFT. I hope I can
buy a sipeed Allwiner D1 SoC powered SBC soon, at least I can test
HAVE_MOVE_PMD. Helping me to test on real HW is appreciated!

Thanks

 arch/riscv/Kconfig               |  2 ++
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e8074d248457..37660de68b00 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -80,6 +80,8 @@ config RISCV
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
+	select HAVE_MOVE_PMD
+	select HAVE_MOVE_PUD
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ebf817c1bdf4..287733b95d10 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -360,6 +360,18 @@ static inline void set_pte_at(struct mm_struct *mm,
 	set_pte(ptep, pteval);
 }
 
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+			      pmd_t *pmdp, pmd_t pmd)
+{
+	set_pmd(pmdp, pmd);
+}
+
+static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
+			      pud_t *pudp, pud_t pud)
+{
+	set_pud(pudp, pud);
+}
+
 static inline void pte_clear(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep)
 {
-- 
2.31.0


