Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55B3BB837
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhGEHw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:52:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17856 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhGEHwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:52:55 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GJHsj1wwMzBCjS;
        Mon,  5 Jul 2021 09:50:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9nZ0AOVJ3-51; Mon,  5 Jul 2021 09:50:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GJHsg0qrLzBCjY;
        Mon,  5 Jul 2021 09:50:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CAB398B77B;
        Mon,  5 Jul 2021 09:50:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R8mMqFbrCgbI; Mon,  5 Jul 2021 09:50:14 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9DD998B763;
        Mon,  5 Jul 2021 09:50:14 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8424C663F7; Mon,  5 Jul 2021 07:50:14 +0000 (UTC)
Message-Id: <b864a92693ca8413ef0b19f0c12065c212899b6e.1625471053.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 1/4] powerpc/ptdump: Use DEFINE_SHOW_ATTRIBUTE()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  5 Jul 2021 07:50:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE() instead of open coding
open() and fops.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4: This series is following the partial merge of "Convert powerpc to GENERIC_PTDUMP".
Patches 1 2 and 3 of that series were merged in 5.13. This updated series is a
split of patch 4. The split helps reduce the size of the previous patch by only
keeping in it the actual conversion.

 arch/powerpc/mm/ptdump/bats.c          | 14 ++------------
 arch/powerpc/mm/ptdump/hashpagetable.c | 12 +-----------
 arch/powerpc/mm/ptdump/ptdump.c        | 13 +------------
 arch/powerpc/mm/ptdump/segment_regs.c  | 12 +-----------
 4 files changed, 5 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/bats.c b/arch/powerpc/mm/ptdump/bats.c
index c4c628b03cf8..4ed3418f07d9 100644
--- a/arch/powerpc/mm/ptdump/bats.c
+++ b/arch/powerpc/mm/ptdump/bats.c
@@ -57,7 +57,7 @@ static void bat_show_603(struct seq_file *m, int idx, u32 lower, u32 upper, bool
 
 #define BAT_SHOW_603(_m, _n, _l, _u, _d) bat_show_603(_m, _n, mfspr(_l), mfspr(_u), _d)
 
-static int bats_show_603(struct seq_file *m, void *v)
+static int bats_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "---[ Instruction Block Address Translation ]---\n");
 
@@ -88,17 +88,7 @@ static int bats_show_603(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int bats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, bats_show_603, NULL);
-}
-
-static const struct file_operations bats_fops = {
-	.open		= bats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(bats);
 
 static int __init bats_init(void)
 {
diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
index ad6df9a2e7c8..c7f824d294b2 100644
--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -526,17 +526,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, NULL);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
 static int ptdump_init(void)
 {
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 5062c58b1e5b..349fd8fe173f 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -397,18 +397,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, NULL);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
 static void build_pgtable_complete_mask(void)
 {
diff --git a/arch/powerpc/mm/ptdump/segment_regs.c b/arch/powerpc/mm/ptdump/segment_regs.c
index 565048a0c9be..3054944d3d7e 100644
--- a/arch/powerpc/mm/ptdump/segment_regs.c
+++ b/arch/powerpc/mm/ptdump/segment_regs.c
@@ -41,17 +41,7 @@ static int sr_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int sr_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, sr_show, NULL);
-}
-
-static const struct file_operations sr_fops = {
-	.open		= sr_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(sr);
 
 static int __init sr_init(void)
 {
-- 
2.25.0

