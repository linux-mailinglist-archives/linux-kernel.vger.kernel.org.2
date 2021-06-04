Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F1D39B64B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDKAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:00:07 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]:39428 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFDKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:00:06 -0400
Received: by mail-qv1-f44.google.com with SMTP id u14so1734054qvq.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=p62GDAxTOYvAFgFgLebKY9zfd90qlS2PCRW/KXSEFvE=;
        b=XInNjm08LIZFxY172kH12zI7gRXKbNMsLFVcVn3+GGs3wNFr5D0SxHBJ7kytmW+bcO
         jLb8S9AcJ0/nEgVIu8Wyv26Jb8L+fS+AySLBlHIzWB11yJynIHer7KdB8HNEZ3w+tmZY
         FMmBjlQ2mShedHeydoRUQ7wJKgJa809Lj/fO3wt+JbSCBqAEF0oG9wkeTo8YcPCV9qXz
         FYoC9xKCMUPpe6kBSjlLvYQpPeTaQj+xNt9szACIZbxvmucMosXB2iGjI7vg+Zipw7fj
         HAAiEPoigYVqtvO0EILA55I/O/UNVQ4jHkK7yfC3OLz/88SuAO1E40qgt8wkeh1vik0l
         0oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=p62GDAxTOYvAFgFgLebKY9zfd90qlS2PCRW/KXSEFvE=;
        b=BkYthq856Eo0YxkGCdYnIUoZAEDeIR2W9PcohUrDt2ByQo9pBLFN+avBkoRygvjYuE
         xhlH8Zdd5J2wY6e5RBxsDQFBS95UhiW1Ev51QjYQ+wFKlXaoPeQLRBFBm9TRFagqs4gM
         QzuQyx34kV4RUqZpMyFXMvgobXY5lNZsaGZp1MfoP5e2sqAWEDh4swZXpTjXK0SZcGCK
         61DPuHUpyd5KC6lmlBvbFQjnTj25fut4BHrAS8alVw197h9nMIyKQ65BqS615hOxnZaM
         +hx54dc5xvaCxo9E8x5xai/JeIB4u5M7zo8m+zkSadBUpleTTdLu34YBLDFfrfgx9IyE
         TBdg==
X-Gm-Message-State: AOAM533f9Q7vwmNqEPViuc6YiaBtfpHqZMxvYB8RwTaurFOLpqKNNy3e
        BO1u2rZNY84ndVeRn4YiA6DJEDQIZacHMWVr7t8=
X-Google-Smtp-Source: ABdhPJw8Ccckw0iX6AFGPspoELbNl6Ujbk6mftR7YZzEAohRkYzPVAwfZacvRcCItgXWGcQUw9k6AVs/YoigbtD5DjA=
X-Received: by 2002:a05:6214:2125:: with SMTP id r5mr3912708qvc.28.1622800625416;
 Fri, 04 Jun 2021 02:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACuRN0NjftJDUAsF2pkXbx0jnJ=bba9+j-hJA8Mjj0r4RVicLA@mail.gmail.com>
In-Reply-To: <CACuRN0NjftJDUAsF2pkXbx0jnJ=bba9+j-hJA8Mjj0r4RVicLA@mail.gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Date:   Fri, 4 Jun 2021 18:56:54 +0900
Message-ID: <CACuRN0Pd8VFTz55qzXvJeqOEt2ZGi--j1wDyqnAt=q_42ES++w@mail.gmail.com>
Subject: [PATCH 1/1] riscv: prevent pipeline stall in __asm_to/copy_from_user
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Nick Hu <nickhu@andestech.com>,
        Nylon Chen <nylon7@andestech.com>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        linux-riscv@lists.infradead.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reducing pipeline stall of read after write (RAW).

These are the results from combination of the speedup with
Gary's misalign fix. Speeds up from 680Mbps to 900Mbps.

Before applying these two patches.
---
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 192.168.1.153, port 45972
[  5] local 192.168.1.112 port 5201 connected to 192.168.1.153 port 45974
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  80.8 MBytes   678 Mbits/sec
[  5]   1.00-2.00   sec  82.1 MBytes   689 Mbits/sec
[  5]   2.00-3.00   sec  82.1 MBytes   688 Mbits/sec
[  5]   3.00-4.00   sec  81.7 MBytes   685 Mbits/sec
[  5]   4.00-5.00   sec  82.1 MBytes   689 Mbits/sec
[  5]   5.00-6.00   sec  82.0 MBytes   687 Mbits/sec
[  5]   6.00-7.00   sec  82.4 MBytes   691 Mbits/sec
[  5]   7.00-8.00   sec  82.2 MBytes   689 Mbits/sec
[  5]   8.00-9.00   sec  82.2 MBytes   690 Mbits/sec
[  5]   9.00-10.00  sec  82.2 MBytes   690 Mbits/sec
[  5]  10.00-10.01  sec   486 KBytes   682 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.01  sec   820 MBytes   688 Mbits/sec                  receiver
-----------------------------------------------------------
---

Afer.
---
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 192.168.1.153, port 44612
[  5] local 192.168.1.112 port 5201 connected to 192.168.1.153 port 44614
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   105 MBytes   879 Mbits/sec
[  5]   1.00-2.00   sec   108 MBytes   904 Mbits/sec
[  5]   2.00-3.00   sec   107 MBytes   901 Mbits/sec
[  5]   3.00-4.00   sec   108 MBytes   902 Mbits/sec
[  5]   4.00-5.00   sec   108 MBytes   906 Mbits/sec
[  5]   5.00-6.00   sec   107 MBytes   900 Mbits/sec
[  5]   6.00-7.00   sec   108 MBytes   906 Mbits/sec
[  5]   7.00-8.00   sec   108 MBytes   904 Mbits/sec
[  5]   8.00-9.00   sec   108 MBytes   902 Mbits/sec
[  5]   9.00-10.00  sec   108 MBytes   905 Mbits/sec
[  5]  10.00-10.01  sec   612 KBytes   902 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.01  sec  1.05 GBytes   901 Mbits/sec                  receiver
-----------------------------------------------------------
---

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 106 +++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 33 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index fceaeb18cc64..2528a77709e1 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -19,50 +19,90 @@ ENTRY(__asm_copy_from_user)
     li t6, SR_SUM
     csrs CSR_STATUS, t6

-    add a3, a1, a2
+    move t5, a0  /* Preserve return value */
+
+    /* Defer to byte-oriented copy for small sizes */
+    sltiu a3, a2, 64
+    bnez a3, 4f
     /* Use word-oriented copy only if low-order bits match */
-    andi t0, a0, SZREG-1
-    andi t1, a1, SZREG-1
-    bne t0, t1, 2f
+    andi a3, t5, SZREG-1
+    andi a4, a1, SZREG-1
+    bne a3, a4, 4f

-    addi t0, a1, SZREG-1
-    andi t1, a3, ~(SZREG-1)
-    andi t0, t0, ~(SZREG-1)
+    beqz a3, 2f  /* Skip if already aligned */
     /*
-     * a3: terminal address of source region
-     * t0: lowest XLEN-aligned address in source
-     * t1: highest XLEN-aligned address in source
+     * Round to nearest double word-aligned address
+     * greater than or equal to start address
      */
-    bgeu t0, t1, 2f
-    bltu a1, t0, 4f
+    andi a3, a1, ~(SZREG-1)
+    addi a3, a3, SZREG
+    /* Handle initial misalignment */
+    sub a4, a3, a1
 1:
-    fixup REG_L, t2, (a1), 10f
-    fixup REG_S, t2, (a0), 10f
-    addi a1, a1, SZREG
-    addi a0, a0, SZREG
-    bltu a1, t1, 1b
-2:
-    bltu a1, a3, 5f
+    lb a5, 0(a1)
+    addi a1, a1, 1
+    sb a5, 0(t5)
+    addi t5, t5, 1
+    bltu a1, a3, 1b
+    sub a2, a2, a4  /* Update count */

+2:
+    andi a4, a2, ~((8*SZREG)-1)
+    beqz a4, 4f
+    add a3, a1, a4
 3:
+    fixup REG_L a4,       0(a1), 10f
+    fixup REG_L a5,   SZREG(a1), 10f
+    fixup REG_L a6, 2*SZREG(a1), 10f
+    fixup REG_L a7, 3*SZREG(a1), 10f
+    fixup REG_L t0, 4*SZREG(a1), 10f
+    fixup REG_L t1, 5*SZREG(a1), 10f
+    fixup REG_L t2, 6*SZREG(a1), 10f
+    fixup REG_L t3, 7*SZREG(a1), 10f
+    fixup REG_S a4,       0(t5), 10f
+    fixup REG_S a5,   SZREG(t5), 10f
+    fixup REG_S a6, 2*SZREG(t5), 10f
+    fixup REG_S a7, 3*SZREG(t5), 10f
+    fixup REG_S t0, 4*SZREG(t5), 10f
+    fixup REG_S t1, 5*SZREG(t5), 10f
+    fixup REG_S t2, 6*SZREG(t5), 10f
+    fixup REG_S t3, 7*SZREG(t5), 10f
+    addi a1, a1, 8*SZREG
+    addi t5, t5, 8*SZREG
+    bltu a1, a3, 3b
+    andi a2, a2, (8*SZREG)-1  /* Update count */
+
+4:
+    /* Handle trailing misalignment */
+    beqz a2, 6f
+    add a3, a1, a2
+
+    /* Use word-oriented copy if co-aligned to word boundary */
+    or a5, a1, t5
+    or a5, a5, a3
+    andi a5, a5, 3
+    bnez a5, 5f
+7:
+    fixup lw a4, 0(a1), 10f
+    addi a1, a1, 4
+    fixup sw a4, 0(t5), 10f
+    addi t5, t5, 4
+    bltu a1, a3, 7b
+
+    j 6f
+
+5:
+    fixup lb a4, 0(a1), 10f
+    addi a1, a1, 1
+    fixup sb a4, 0(t5), 10f
+    addi t5, t5, 1
+    bltu a1, a3, 5b
+
+6:
     /* Disable access to user memory */
     csrc CSR_STATUS, t6
     li a0, 0
     ret
-4: /* Edge case: unalignment */
-    fixup lbu, t2, (a1), 10f
-    fixup sb, t2, (a0), 10f
-    addi a1, a1, 1
-    addi a0, a0, 1
-    bltu a1, t0, 4b
-    j 1b
-5: /* Edge case: remainder */
-    fixup lbu, t2, (a1), 10f
-    fixup sb, t2, (a0), 10f
-    addi a1, a1, 1
-    addi a0, a0, 1
-    bltu a1, a3, 5b
-    j 3b
 ENDPROC(__asm_copy_to_user)
 ENDPROC(__asm_copy_from_user)
 EXPORT_SYMBOL(__asm_copy_to_user)
-- 
2.17.1
