Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADEF45EBA9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377214AbhKZKff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:35:35 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:43223 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376870AbhKZKdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:33:33 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J0rbw0WYFz9sSK;
        Fri, 26 Nov 2021 11:30:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4OKSvaBjIrZ7; Fri, 26 Nov 2021 11:30:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J0rbq6HHBz9sSM;
        Fri, 26 Nov 2021 11:30:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C7E8B8B77D;
        Fri, 26 Nov 2021 11:30:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nAkmsh7gvHE0; Fri, 26 Nov 2021 11:30:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 847A28B763;
        Fri, 26 Nov 2021 11:30:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1AQAU57D504683
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 11:30:06 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1AQAU3WF504682;
        Fri, 26 Nov 2021 11:30:03 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/ptdump: Fix display a BAT's size unit
Date:   Fri, 26 Nov 2021 11:30:03 +0100
Message-Id: <f16c30f5c9185a63335322cf1a8b22f189d335ef.1637922595.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637922602; l=1821; s=20211009; h=from:subject:message-id; bh=X4Z/h5lCmSkaoSNNKudG03g/q0IKuhd3sChnOkiRvec=; b=umXbLRtps+H9lC6tI8eTrQqgPDTfHdeI3cAeUw7UZZMnxCO9O06orwtmnPqNCDPo752UT9Xsuxdw ybYNX0tPCvPeqLqQd31L031Km4rSmpwpnOvOmCBvselWlv4jOh7k
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have wrong units on BAT's sizes (G instead of M, M instead of ...)

	---[ Instruction Block Address Translation ]---
	0: 0xc0000000-0xc03fffff 0x00000000         4G Kernel   x     m
	1: 0xc0400000-0xc05fffff 0x00400000         2G Kernel   x     m
	2: 0xc0600000-0xc06fffff 0x00600000         1G Kernel   x     m
	3: 0xc0700000-0xc077ffff 0x00700000       512M Kernel   x     m
	4: 0xc0780000-0xc079ffff 0x00780000       128M Kernel   x     m
	5: 0xc07a0000-0xc07bffff 0x007a0000       128M Kernel   x     m
	6:         -
	7:         -

This is because pt_dump_size() expects a size in Kbytes but
bat_show_603() gives the size in bytes.

To avoid risk of confusion, change pt_dump_size() to take bytes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ptdump/ptdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index bf251191e78d..031956d0ee84 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -123,7 +123,7 @@ static struct ptdump_range ptdump_range[] __ro_after_init = {
 
 void pt_dump_size(struct seq_file *m, unsigned long size)
 {
-	static const char units[] = "KMGTPE";
+	static const char units[] = " KMGTPE";
 	const char *unit = units;
 
 	/* Work out what appropriate unit to use */
@@ -176,7 +176,7 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 
 	pt_dump_seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);
 	pt_dump_seq_printf(st->seq, " " REG " ", st->start_pa);
-	pt_dump_size(st->seq, (addr - st->start_address) >> 10);
+	pt_dump_size(st->seq, addr - st->start_address);
 }
 
 static void note_prot_wx(struct pg_state *st, unsigned long addr)
-- 
2.33.1

