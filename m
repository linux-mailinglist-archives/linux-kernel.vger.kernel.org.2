Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742FA3ACD1C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhFROKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFROKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:10:17 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ECB8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=6URVM7kwZFYoTQ0Jt4HvPCFsmhETjeMSlkHESOmiSxc=; b=KfvNmLF8rwEXo
        cWOT41SqhY1jGblyAPA7iScVIy6QG+c3DgJpp86miXZcOLjCZtG3jC02pi5+qJzz
        t1efEvqOjm2FDF/UTmfwjLTuevCQ0qrXe7f+b4oirNxMmpPcQhcMAp5bxv9IjyfN
        f60WG9X846ZeliA1rLzYXnCi2RX5KA=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHj1uTqMxgX_3+AA--.51710S2;
        Fri, 18 Jun 2021 22:07:15 +0800 (CST)
Date:   Fri, 18 Jun 2021 22:01:36 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: kasan: Fix MODULES_VADDR evaluation due to local
 variables' name
Message-ID: <20210618220136.21f32b98@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCHj1uTqMxgX_3+AA--.51710S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyxtr18WFW5Kw17Cw18Grg_yoW8Wry3pr
        WDtF4rJrW5ZrsYgasrK34j9F1UJ3Z2ya4fJr1UAan8Aa98Crs0qrn8uFZ8ZryjgFWxu3WF
        yw4Fyry7Wr12y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2xR6UUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

commit 2bfc6cd81bd1 ("riscv: Move kernel mapping outside of linear
mapping") makes use of MODULES_VADDR to populate kernel, BPF, modules
mapping. Currently, MODULES_VADDR is defined as below for RV64:

| #define MODULES_VADDR   (PFN_ALIGN((unsigned long)&_end) - SZ_2G)

But kasan_init() has two local variables which are also named as _start,
_end, so MODULES_VADDR is evaluated with the local variable _end
rather than the global "_end" as we expected. Fix this issue by
renaming the two local variables.

Fixes: 2bfc6cd81bd1 ("riscv: Move kernel mapping outside of linear mapping")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/kasan_init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 55c113345460..d7189c8714a9 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -169,7 +169,7 @@ static void __init kasan_shallow_populate(void *start, void *end)
 
 void __init kasan_init(void)
 {
-	phys_addr_t _start, _end;
+	phys_addr_t p_start, p_end;
 	u64 i;
 
 	/*
@@ -189,9 +189,9 @@ void __init kasan_init(void)
 			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
 
 	/* Populate the linear mapping */
-	for_each_mem_range(i, &_start, &_end) {
-		void *start = (void *)__va(_start);
-		void *end = (void *)__va(_end);
+	for_each_mem_range(i, &p_start, &p_end) {
+		void *start = (void *)__va(p_start);
+		void *end = (void *)__va(p_end);
 
 		if (start >= end)
 			break;
-- 
2.32.0


