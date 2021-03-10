Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9143335CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 07:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhCJGYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 01:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhCJGXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:23:47 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50108C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 22:23:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id l7so11382948pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 22:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jiuyang-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdObe57su8xWHYEXhsxkrNxyAPh3DbqM32syLxOl1vk=;
        b=NllT/NACDMzFsEk3Hzskh2TZBUFdSBO3iLOfYaXrVQ8Bi8N/F1MRL343M+r02fmowl
         HmVKGM5YA33uWkK09suxlHp6BmenKYSbL8qqQ94tLbIYUWmXVQ/PFzuZPgBVg0wkDutB
         pLDj/8QZ87OBNCKAgWP9fXk6vKcUwuswTDMET+ogV9LIHa6L29LteOIM4xWcs1DHSIJa
         jN9HGGjZNV8lE2gz2+8KZPNcRr5Jb0pT/F2si4wZIAvAFePqM4xebE8FLR5SH0ttCmv9
         VUwojsr8xb5tRi2rtUayc05Wq3A+St9L6zvEQX5vOC+6PFNS2tj53JoTQgi1AYCzB/HD
         9nAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdObe57su8xWHYEXhsxkrNxyAPh3DbqM32syLxOl1vk=;
        b=t5fvCtnaEmK3XqEiKLb0QhZDDCDiWHM9Ki0IlnycHg0BGG0cInIELSin725BEgqNib
         Rz/Tu3KwHIMM/2ZvFElOLh3vTPnJf3vMVNUHGB/F0sloDp83zHto2SWA2MW8Pj7zS6HW
         IYO90P9zXEb1VjaL8RNtKTkfGPQQ0Lq0jQ3wvb7C9IIAfknXVdnNB/pW2y8l12RZWi4F
         TIhKuYjJHu7af4M13SS/OX2dfzZbSWsdL03ItmrNBoZEEDDuZVfNYFsJkNh2MHiKh9vW
         lvgsfh5MtufPL/rsz9Rqh84hVib5rusXDVXabXOvCf0QZZwF0AIIfv9Nv4HpRsi2+xjW
         Y5Xg==
X-Gm-Message-State: AOAM530bVtnVenrO50Jq0ZOlqtin2YjV0SAsebZsL3zfKWD+n9vVAeZx
        FC1Kynhp556OvxxeE/axYS4i/g==
X-Google-Smtp-Source: ABdhPJy8IqbvJ8+yH2KVTgI3FD35hwJPvy7alCO7fbQKvwYfNHQBsbzNtNacjHi/zXD0ZeUFEAhDeQ==
X-Received: by 2002:a05:6a00:16cd:b029:1c9:6f5b:3d8c with SMTP id l13-20020a056a0016cdb02901c96f5b3d8cmr1586965pfc.1.1615357413716;
        Tue, 09 Mar 2021 22:23:33 -0800 (PST)
Received: from localhost.localdomain ([193.110.201.196])
        by smtp.gmail.com with ESMTPSA id bb24sm5013795pjb.5.2021.03.09.22.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 22:23:33 -0800 (PST)
From:   Jiuyang <liu@jiuyang.me>
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
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Insert SFENCE.VMA in function set_pte_at for RISCV
Date:   Wed, 10 Mar 2021 06:22:46 +0000
Message-Id: <20210310062250.74583-1-liu@jiuyang.me>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiuyang Liu <liu@jiuyang.me>

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
1. implement local_flush_tlb_asid to flush tlb with asid.

Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
---
 arch/riscv/include/asm/pgtable.h  | 28 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/tlbflush.h |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ebf817c1bdf4..95f6546ddb5b 100644
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
@@ -358,6 +370,18 @@ static inline void set_pte_at(struct mm_struct *mm,
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
index 394cfbccdcd9..4b25f51f163d 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -21,6 +21,14 @@ static inline void local_flush_tlb_page(unsigned long addr)
 {
 	__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
 }
+
+static unsigned long asid;
+static inline void local_flush_tlb_asid(void)
+{
+	asid = csr_read(CSR_SATP) | (SATP_ASID_MASK << SATP_ASID_SHIFT);
+	__asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
+}
+
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
 #define local_flush_tlb_page(addr)		do { } while (0)
-- 
2.30.1

