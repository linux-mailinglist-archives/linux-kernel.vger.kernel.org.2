Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4AE3C1765
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGHQwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:52:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35858 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhGHQwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:52:31 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GLMhk62lJzBF3P;
        Thu,  8 Jul 2021 18:49:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bmw1aYb6biQj; Thu,  8 Jul 2021 18:49:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GLMhk57TRzBF3J;
        Thu,  8 Jul 2021 18:49:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A37788B801;
        Thu,  8 Jul 2021 18:49:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id f6n3LzTP5Unu; Thu,  8 Jul 2021 18:49:42 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6307E8B7E3;
        Thu,  8 Jul 2021 18:49:42 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 42D686640E; Thu,  8 Jul 2021 16:49:42 +0000 (UTC)
Message-Id: <d76495c574132b197b445a1f133755cca4b912a4.1625762906.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b864a92693ca8413ef0b19f0c12065c212899b6e.1625762905.git.christophe.leroy@csgroup.eu>
References: <b864a92693ca8413ef0b19f0c12065c212899b6e.1625762905.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 3/4] powerpc/ptdump: Reduce level numbers by 1 in
 note_page() and add p4d level
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  8 Jul 2021 16:49:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do the same as commit f8f0d0b6fa20 ("mm: ptdump: reduce level numbers
by 1 in note_page()") and add missing p4d level.

This will align powerpc to the users of generic ptdump.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ptdump/8xx.c      |  6 ++++--
 arch/powerpc/mm/ptdump/book3s64.c |  6 ++++--
 arch/powerpc/mm/ptdump/ptdump.c   | 17 +++++++++--------
 arch/powerpc/mm/ptdump/shared.c   |  6 ++++--
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
index 86da2a669680..fac932eb8f9a 100644
--- a/arch/powerpc/mm/ptdump/8xx.c
+++ b/arch/powerpc/mm/ptdump/8xx.c
@@ -75,8 +75,10 @@ static const struct flag_info flag_array[] = {
 };
 
 struct pgtable_level pg_level[5] = {
-	{
-	}, { /* pgd */
+	{ /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* p4d */
 		.flag	= flag_array,
 		.num	= ARRAY_SIZE(flag_array),
 	}, { /* pud */
diff --git a/arch/powerpc/mm/ptdump/book3s64.c b/arch/powerpc/mm/ptdump/book3s64.c
index 14f73868db66..5ad92d9dc5d1 100644
--- a/arch/powerpc/mm/ptdump/book3s64.c
+++ b/arch/powerpc/mm/ptdump/book3s64.c
@@ -103,8 +103,10 @@ static const struct flag_info flag_array[] = {
 };
 
 struct pgtable_level pg_level[5] = {
-	{
-	}, { /* pgd */
+	{ /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* p4d */
 		.flag	= flag_array,
 		.num	= ARRAY_SIZE(flag_array),
 	}, { /* pud */
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 3eb8732641da..fb531bc64fc5 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -58,7 +58,7 @@ struct pg_state {
 	const struct addr_marker *marker;
 	unsigned long start_address;
 	unsigned long start_pa;
-	unsigned int level;
+	int level;
 	u64 current_flags;
 	bool check_wx;
 	unsigned long wx_pages;
@@ -188,10 +188,9 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
 }
 
-static void note_page_update_state(struct pg_state *st, unsigned long addr,
-				   unsigned int level, u64 val)
+static void note_page_update_state(struct pg_state *st, unsigned long addr, int level, u64 val)
 {
-	u64 flag = val & pg_level[level].mask;
+	u64 flag = level >= 0 ? val & pg_level[level].mask : 0;
 	u64 pa = val & PTE_RPN_MASK;
 
 	st->level = level;
@@ -206,12 +205,12 @@ static void note_page_update_state(struct pg_state *st, unsigned long addr,
 }
 
 static void note_page(struct pg_state *st, unsigned long addr,
-	       unsigned int level, u64 val, unsigned long page_size)
+		      int level, u64 val, unsigned long page_size)
 {
-	u64 flag = val & pg_level[level].mask;
+	u64 flag = level >= 0 ? val & pg_level[level].mask : 0;
 
 	/* At first no level is set */
-	if (!st->level) {
+	if (st->level == -1) {
 		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
 		note_page_update_state(st, addr, level, val);
 	/*
@@ -383,6 +382,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	struct pg_state st = {
 		.seq = m,
 		.marker = address_markers,
+		.level = -1,
 		.start_address = IS_ENABLED(CONFIG_PPC64) ? PAGE_OFFSET : TASK_SIZE,
 	};
 
@@ -393,7 +393,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 
 	/* Traverse kernel page tables */
 	walk_pagetables(&st);
-	note_page(&st, 0, 0, 0, 0);
+	note_page(&st, 0, -1, 0, 0);
 	return 0;
 }
 
@@ -415,6 +415,7 @@ void ptdump_check_wx(void)
 	struct pg_state st = {
 		.seq = NULL,
 		.marker = address_markers,
+		.level = -1,
 		.check_wx = true,
 		.start_address = IS_ENABLED(CONFIG_PPC64) ? PAGE_OFFSET : TASK_SIZE,
 	};
diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
index c005fe041c18..03607ab90c66 100644
--- a/arch/powerpc/mm/ptdump/shared.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -68,8 +68,10 @@ static const struct flag_info flag_array[] = {
 };
 
 struct pgtable_level pg_level[5] = {
-	{
-	}, { /* pgd */
+	{ /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* p4d */
 		.flag	= flag_array,
 		.num	= ARRAY_SIZE(flag_array),
 	}, { /* pud */
-- 
2.25.0

