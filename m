Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A2435CAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbhDLQSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbhDLQSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:18:01 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1033FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=GCu6K1s61mntU0Jf7xOJ9b2Fb/es981iZL
        lTesdAjHY=; b=icBNPsZmoBC+m9Pqb/3HJlnwxNeA7Cuc+r60oVnVF807J+hi3F
        WarjbwaFnkG4TNmum/BDUUOmALVYbQAYl3wPUzXZpOHNLTF2oqKrMo92mT6Z3dXl
        afd9deH0wVE80FS8SY71GnQ618/Rf4BNiavYMkOl3wwsIVn8019P8LehY=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDn7EiacnRg9zjLAA--.40703S2;
        Tue, 13 Apr 2021 00:17:30 +0800 (CST)
Date:   Tue, 13 Apr 2021 00:12:28 +0800
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
Subject: [PATCH v3 02/10] riscv: add __init section marker to some functions
Message-ID: <20210413001228.663f9bc3@xhacker>
In-Reply-To: <20210413001110.7209bae6@xhacker>
References: <20210413001110.7209bae6@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDn7EiacnRg9zjLAA--.40703S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryfXrWUJr47GF4rJFyfCrg_yoWrXr48pr
        Z5Ka1kAFWY9ryvga9rArW8uryUJ3Z0k343trsrCa4rXF47urW5A34kW3yjvr1UXFWkuF4r
        C345Cry3Aw48AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkCb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
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
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2znQUU
        UUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

They are not needed after booting, so mark them as __init to move them
to the __init section.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/cpufeature.c | 2 +-
 arch/riscv/kernel/traps.c      | 2 +-
 arch/riscv/mm/init.c           | 4 ++--
 arch/riscv/mm/kasan_init.c     | 6 +++---
 arch/riscv/mm/ptdump.c         | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index ac202f44a670..e4741e1f0add 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -59,7 +59,7 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 
-void riscv_fill_hwcap(void)
+void __init riscv_fill_hwcap(void)
 {
 	struct device_node *node;
 	const char *isa;
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0879b5df11b9..041f4b44262e 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -196,6 +196,6 @@ int is_valid_bugaddr(unsigned long pc)
 #endif /* CONFIG_GENERIC_BUG */
 
 /* stvec & scratch is already set from head.S */
-void trap_init(void)
+void __init trap_init(void)
 {
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index dbeaa4144e4d..ecd485662b07 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -70,7 +70,7 @@ static inline void print_mlm(char *name, unsigned long b, unsigned long t)
 		  (((t) - (b)) >> 20));
 }
 
-static void print_vm_layout(void)
+static void __init print_vm_layout(void)
 {
 	pr_notice("Virtual kernel memory layout:\n");
 	print_mlk("fixmap", (unsigned long)FIXADDR_START,
@@ -553,7 +553,7 @@ static inline void setup_vm_final(void)
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void protect_kernel_text_data(void)
+void __init protect_kernel_text_data(void)
 {
 	unsigned long text_start = (unsigned long)_start;
 	unsigned long init_text_start = (unsigned long)__init_text_begin;
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index ec0029097251..e459290d2629 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -48,7 +48,7 @@ asmlinkage void __init kasan_early_init(void)
 	local_flush_tlb_all();
 }
 
-static void kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
+static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	pte_t *ptep, *base_pte;
@@ -70,7 +70,7 @@ static void kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long en
 	set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(base_pte)), PAGE_TABLE));
 }
 
-static void kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long end)
+static void __init kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	pmd_t *pmdp, *base_pmd;
@@ -105,7 +105,7 @@ static void kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long en
 	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pmd)), PAGE_TABLE));
 }
 
-static void kasan_populate_pgd(unsigned long vaddr, unsigned long end)
+static void __init kasan_populate_pgd(unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	pgd_t *pgdp = pgd_offset_k(vaddr);
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index ace74dec7492..3b7b6e4d025e 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -331,7 +331,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(ptdump);
 
-static int ptdump_init(void)
+static int __init ptdump_init(void)
 {
 	unsigned int i, j;
 
-- 
2.31.0


