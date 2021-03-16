Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20B33CC4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhCPDuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhCPDuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:50:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59245C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:50:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 30so11754924ple.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jiuyang-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2lFb3NlHRv7hqARNNWsy6IMEcW9PVZ0/ldwfddpDSQ=;
        b=jg51Lw8jX8BJFhOiGXWD0ErK9oIl+rvbVi/MpDdPX8ZBjpsksZ1tWiMOCt7KeUGEIK
         HUbY83E5Ll8FCnwtYHFHg5IAsUrwkdHRQD6ow2bh8BJbuwUHJTdlenKOaO4P7i+CyEuA
         YVQQdp/AMNP+BV6AWOOyLdGDe+cYimWfgOWw0fnLI28oZveAj3TuoYdo1boMZR+6No7G
         m2/GnVGi6H2Jxs8DYPu0MUwWXkVml+SLT9B/Lx8DpCe9D9MkmMXOW1Kp9uGYN2KPDdMY
         R1kbs7b7/uS0w9n2dztm4nCavl7PLGjvPPtfo7OPbcZ6HiTdbQd4yW+Oo1FZidLrfy6M
         bHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2lFb3NlHRv7hqARNNWsy6IMEcW9PVZ0/ldwfddpDSQ=;
        b=UQGwQTg6tEoQAsL29fZ2y1yiT+/p6IKE0/gPrGvMifvo5f3ag1mmczkhy8sTodhB6L
         3oTDLMoAvT67Q0YbP0f/5OZ9LG+O8gOblQXBEZyRCF20ciEwMHY3WWUACFJdscoSeE9h
         TVVba4lNaJuMrnI/yhnYUPrWBA/wFJs+upvcGXqroyNCT9g6PzYjBBEJaSMkkZ0sifB8
         JkXq15fJg5cZJ7VWlAJRJ2tn0hL8QFtUHWhtzsNlPjQLKUB5h2dud4UHOxfYZe3xR6RR
         /YAdERsQ0fVqymkEe9G3dgSgXCEUqTICTUUy6VyuJfy0NyRRwN+zcaHuk1bkYWP0b6Qk
         RGYw==
X-Gm-Message-State: AOAM531ZjkSR7LzYmtxqyIQmcryVJasDHXI+7yvA8sAjeOS23QgLn7p6
        e03kRsueW3KmeudcQUKHGaVU+Q==
X-Google-Smtp-Source: ABdhPJyXkQwYpNmJRSj8fa6IZGSK0bVZdkNEbEw3wc7gJTjdHz9Kmavfup39JIG87l9kAONH+xny/Q==
X-Received: by 2002:a17:90a:598e:: with SMTP id l14mr2467137pji.187.1615866631767;
        Mon, 15 Mar 2021 20:50:31 -0700 (PDT)
Received: from localhost.localdomain ([193.110.201.196])
        by smtp.gmail.com with ESMTPSA id s19sm14522122pfh.168.2021.03.15.20.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 20:50:31 -0700 (PDT)
From:   Jiuyang Liu <liu@jiuyang.me>
Cc:     Andrew Waterman <waterman@eecs.berkeley.edu>,
        Jiuyang Liu <liu@jiuyang.me>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Insert SFENCE.VMA in function set_pte_at for RISCV
Date:   Tue, 16 Mar 2021 03:46:36 +0000
Message-Id: <20210316034638.16276-1-liu@jiuyang.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316015328.13516-1-liu@jiuyang.me>
References: <20210316015328.13516-1-liu@jiuyang.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch inserts SFENCE.VMA after modifying PTE based on RISC-V
specification.

arch/riscv/include/asm/pgtable.h:
1. implement pte_user, pte_global and pte_leaf to check correspond
attribute of a pte_t.

2. insert SFENCE.VMA in set_pte_at based on RISC-V Volume 2, Privileged
Spec v. 20190608 page 66 and 67:
If software modifies a non-leaf PTE, it should execute SFENCE.VMA with
rs1=x0. If any PTE along the traversal path had its G bit set, rs2 must
be x0; otherwise, rs2 should be set to the ASID for which the
translation is being modified.
If software modifies a leaf PTE, it should execute SFENCE.VMA with rs1
set to a virtual address within the page. If any PTE along the traversal
path had its G bit set, rs2 must be x0; otherwise, rs2 should be set to
the ASID for which the translation is being modified.

arch/riscv/include/asm/tlbflush.h:
1. implement get_current_asid to get current program asid.
2. implement local_flush_tlb_asid to flush tlb with asid.

Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
---
 arch/riscv/include/asm/pgtable.h  | 27 +++++++++++++++++++++++++++
 arch/riscv/include/asm/tlbflush.h | 12 ++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ebf817c1bdf4..5a47c60372c1 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -222,6 +222,16 @@ static inline int pte_write(pte_t pte)
 	return pte_val(pte) & _PAGE_WRITE;
 }
 
+static inline int pte_user(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_USER;
+}
+
+static inline int pte_global(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_GLOBAL;
+}
+
 static inline int pte_exec(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_EXEC;
@@ -248,6 +258,11 @@ static inline int pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
+static inline int pte_leaf(pte_t pte)
+{
+	return pte_val(pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC);
+}
+
 /* static inline pte_t pte_rdprotect(pte_t pte) */
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -358,6 +373,18 @@ static inline void set_pte_at(struct mm_struct *mm,
 		flush_icache_pte(pteval);
 
 	set_pte(ptep, pteval);
+
+	if (pte_present(pteval)) {
+		if (pte_leaf(pteval)) {
+			local_flush_tlb_page(addr);
+		} else {
+			if (pte_global(pteval))
+				local_flush_tlb_all();
+			else
+				local_flush_tlb_asid();
+
+		}
+	}
 }
 
 static inline void pte_clear(struct mm_struct *mm,
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 394cfbccdcd9..1f9b62b3670b 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -21,6 +21,18 @@ static inline void local_flush_tlb_page(unsigned long addr)
 {
 	__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
 }
+
+static inline unsigned long get_current_asid(void)
+{
+	return (csr_read(CSR_SATP) >> SATP_ASID_SHIFT) & SATP_ASID_MASK;
+}
+
+static inline void local_flush_tlb_asid(void)
+{
+	unsigned long asid = get_current_asid();
+	__asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
+}
+
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
 #define local_flush_tlb_page(addr)		do { } while (0)
-- 
2.30.2

