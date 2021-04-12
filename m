Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6747B35CAE9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbhDLQSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbhDLQSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:18:31 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DFEFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=gABszv65hXyrR9T++2wE6P6w2hlXD28zTs
        O/Pu7I2iY=; b=RR6YXcR/iVqwX123PdrB50tAp7eTh2c5mPumKgYweEV42IYv7M
        fLHgBTu4YQxyJ8sXaI+me8KGqtQKyP/QiCaFI6W3MJf7FeynopqcG3LRFqwcUF+O
        oGrqN+tOPrCnmWkwyLrK2RG4Ke2un02/iH9rLNMscUYW1+3harlw3YR54=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDX3Ei5cnRgnjnLAA--.24257S2;
        Tue, 13 Apr 2021 00:18:01 +0800 (CST)
Date:   Tue, 13 Apr 2021 00:12:59 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        " =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, Anup Patel <anup@brainfault.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/10] riscv: Mark some global variables __ro_after_init
Message-ID: <20210413001259.77676f62@xhacker>
In-Reply-To: <20210413001110.7209bae6@xhacker>
References: <20210413001110.7209bae6@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDX3Ei5cnRgnjnLAA--.24257S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryfJFW7urW3uF4rKw47XFb_yoWrJryxpF
        4UCF1DWrWrZanrKayayrykury7Jr1DWw13tF42ka4rAa1jqry5X395X3ZrZr1YqFWDW3WS
        kFy5Gw1Yka1UXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkCb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
        c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HUDDU
        UUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

All of these are never modified after init, so they can be
__ro_after_init.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/sbi.c  | 8 ++++----
 arch/riscv/kernel/smp.c  | 4 ++--
 arch/riscv/kernel/time.c | 2 +-
 arch/riscv/kernel/vdso.c | 4 ++--
 arch/riscv/mm/init.c     | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 7fbf044d9593..6ebffd579379 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -11,14 +11,14 @@
 #include <asm/smp.h>
 
 /* default SBI version is 0.1 */
-unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
+unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
 
-static void (*__sbi_set_timer)(uint64_t stime);
-static int (*__sbi_send_ipi)(const unsigned long *hart_mask);
+static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
+static int (*__sbi_send_ipi)(const unsigned long *hart_mask) __ro_after_init;
 static int (*__sbi_rfence)(int fid, const unsigned long *hart_mask,
 			   unsigned long start, unsigned long size,
-			   unsigned long arg4, unsigned long arg5);
+			   unsigned long arg4, unsigned long arg5) __ro_after_init;
 
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8325d33411d8..476e2e4bc5c5 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -32,7 +32,7 @@ enum ipi_message_type {
 	IPI_MAX
 };
 
-unsigned long __cpuid_to_hartid_map[NR_CPUS] = {
+unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
 
@@ -87,7 +87,7 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
-static struct riscv_ipi_ops *ipi_ops;
+static struct riscv_ipi_ops *ipi_ops __ro_after_init;
 
 void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
 {
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 1b432264f7ef..8217b0f67c6c 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -11,7 +11,7 @@
 #include <asm/processor.h>
 #include <asm/timex.h>
 
-unsigned long riscv_timebase;
+unsigned long riscv_timebase __ro_after_init;
 EXPORT_SYMBOL_GPL(riscv_timebase);
 
 void __init time_init(void)
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 3f1d35e7c98a..25a3b8849599 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -20,8 +20,8 @@
 
 extern char vdso_start[], vdso_end[];
 
-static unsigned int vdso_pages;
-static struct page **vdso_pagelist;
+static unsigned int vdso_pages __ro_after_init;
+static struct page **vdso_pagelist __ro_after_init;
 
 /*
  * The vDSO data page.
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ecd485662b07..bccf1b81af24 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -145,11 +145,11 @@ void __init setup_bootmem(void)
 }
 
 #ifdef CONFIG_MMU
-static struct pt_alloc_ops pt_ops;
+static struct pt_alloc_ops pt_ops __ro_after_init;
 
-unsigned long va_pa_offset;
+unsigned long va_pa_offset __ro_after_init;
 EXPORT_SYMBOL(va_pa_offset);
-unsigned long pfn_base;
+unsigned long pfn_base __ro_after_init;
 EXPORT_SYMBOL(pfn_base);
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
-- 
2.31.0


