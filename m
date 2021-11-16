Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A091452CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhKPIfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:35:14 -0500
Received: from smtpbgsg1.qq.com ([54.254.200.92]:37892 "EHLO smtpbgsg1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232125AbhKPIdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:33:04 -0500
X-QQ-mid: bizesmtp50t1637051384tfqas7we
Received: from pcl66.. (unknown [218.17.115.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 16 Nov 2021 16:29:35 +0800 (CST)
X-QQ-SSF: 01400000002000F0O000000D0000000
X-QQ-FEAT: HEz0dkdU2P7e7x/qI53ZB25Rr7JcMk37Nf931KEIz8JTt0m9F+fH8TXmyusDB
        3PDVyrF2bd4HByaOR6X7vmCgB9fib0dwOdIbenEQbIEGptJSB4CkID+CcVIQxb5hE86uNLs
        lXPH9gQ59SnsVP6csFU4Es7UiGl2954eevV7qED4jjNnY/pzQV/9QHThHDzJU8q9MHokuWf
        gSfMAfGcpsHVfZ7EYjgBAocJ0UrHICSlr2M1CL+dR7ePMkNo0KQ+XcaLSSTp2tt/Qi1RuJs
        SZ6SmQP7qZzYPFzI5ccuUqSvEOv+pM5jgLoY9j3mH+jX0Xe4C1bl7QIMMmRfrxAPonO8e17
        UU+r88nxi5pYpW95XHAlutknFg3qo1zHQmkue/s
X-QQ-GoodBg: 2
From:   Chen Lu <181250012@smail.nju.edu.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     nickhu@andestech.com, nylon7@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        yuzihao@ict.ac.cn, Chen Lu <181250012@smail.nju.edu.cn>
Subject: [PATCH] riscv: fix misaligned memory access in memmove
Date:   Tue, 16 Nov 2021 16:29:35 +0800
Message-Id: <20211116082935.3343692-1-181250012@smail.nju.edu.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:smail.nju.edu.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 04091d6c0535("riscv: provide memmove implementation")

Signed-off-by: Chen Lu <181250012@smail.nju.edu.cn>
---
 arch/riscv/lib/memmove.S | 89 +++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
index 07d1d2152ba5..8029bc6caeb8 100644
--- a/arch/riscv/lib/memmove.S
+++ b/arch/riscv/lib/memmove.S
@@ -5,60 +5,55 @@
 
 ENTRY(__memmove)
 WEAK(memmove)
-        move    t0, a0
-        move    t1, a1
+        bltu    a0, a1, __memcpy
 
-        beq     a0, a1, exit_memcpy
-        beqz    a2, exit_memcpy
-        srli    t2, a2, 0x2
-
-        slt     t3, a0, a1
-        beqz    t3, do_reverse
-
-        andi    a2, a2, 0x3
-        li      t4, 1
-        beqz    t2, byte_copy
+        add     t1, a1, a2
+        bleu    t1, a0, __memcpy
 
-word_copy:
-        lw      t3, 0(a1)
-        addi    t2, t2, -1
-        addi    a1, a1, 4
-        sw      t3, 0(a0)
-        addi    a0, a0, 4
-        bnez    t2, word_copy
+        beq     a0, a1, exit_memcpy
         beqz    a2, exit_memcpy
-        j       byte_copy
-
-do_reverse:
-        add     a0, a0, a2
-        add     a1, a1, a2
-        andi    a2, a2, 0x3
-        li      t4, -1
-        beqz    t2, reverse_byte_copy
 
-reverse_word_copy:
-        addi    a1, a1, -4
-        addi    t2, t2, -1
-        lw      t3, 0(a1)
-        addi    a0, a0, -4
-        sw      t3, 0(a0)
-        bnez    t2, reverse_word_copy
+        /* reverse src and dst */
+        add     t0, a0, a2
+        /* check low-order bits match */
+        andi    a3, t0, SZREG-1
+        andi    a4, t1, SZREG-1
+        bne     a3, a4, copy_tail_loop
+        beqz    a4, copy_body
+
+copy_head:
+        /* head misalignment */
+        addi    t1, t1, -1
+        lb      t3, 0(t1)
+        addi    t0, t0, -1
+        addi    a4, a4, -1
+        sb      t3, 0(t0)
+        bnez    a4, copy_head
+        sub     a2, a2, a3
+
+copy_body:
+        andi    a4, a2, ~(SZREG-1)
+        andi    a2, a2, (SZREG-1)
+        beqz    a4, copy_tail
+copy_body_loop:
+        addi    t1, t1, -SZREG
+        REG_L   t3, 0(t1)
+        addi    t0, t0, -SZREG
+        addi    a4, a4, -SZREG
+        REG_S   t3, 0(t0)
+        bnez    a4, copy_body_loop
+
+copy_tail:
+        /* tail misalignment */
         beqz    a2, exit_memcpy
-
-reverse_byte_copy:
-        addi    a0, a0, -1
-        addi    a1, a1, -1
-
-byte_copy:
-        lb      t3, 0(a1)
+copy_tail_loop:
+        addi    t1, t1, -1
+        lb      t3, 0(t1)
+        addi    t0, t0, -1
         addi    a2, a2, -1
-        sb      t3, 0(a0)
-        add     a1, a1, t4
-        add     a0, a0, t4
-        bnez    a2, byte_copy
+        sb      t3, 0(t0)
+        bnez    a2, copy_tail_loop
 
 exit_memcpy:
-        move a0, t0
-        move a1, t1
         ret
 END(__memmove)
-- 
2.30.2



