Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D23245D629
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 09:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349952AbhKYIbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:31:03 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:45887 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347264AbhKYI3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:29:02 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J09rN1c9Zz9sT5;
        Thu, 25 Nov 2021 09:23:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SvoNutEsxv6g; Thu, 25 Nov 2021 09:23:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J09rM512Mz9sSC;
        Thu, 25 Nov 2021 09:23:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9BE2C8B763;
        Thu, 25 Nov 2021 09:23:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hgYAwRbVIHjL; Thu, 25 Nov 2021 09:23:47 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.227])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0C478B77A;
        Thu, 25 Nov 2021 09:23:46 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1AP8NcUV086368
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 09:23:38 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1AP8NcnG086367;
        Thu, 25 Nov 2021 09:23:38 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: [PATCH v2 6/9] mm: Allow arch specific arch_randomize_brk() with CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
Date:   Thu, 25 Nov 2021 09:23:28 +0100
Message-Id: <e059e83c12b01ba7c3352162828046504e586c0c.1637828367.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637828367.git.christophe.leroy@csgroup.eu>
References: <cover.1637828367.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637828609; l=1197; s=20211009; h=from:subject:message-id; bh=RT3kMLUaGZCsXKmi+EcLtq6XwPH2sPocS4v2Vp1A0vA=; b=sl19ucwFzGp0j16OWEjxyflhsKvZBwagHWWPtT2TVowZvFnjzhqRfNrjCVrka42IN7XPBTPqJcQv JNvc9Q/BBUfQtuQikop/Dh6bfVGsQSmXqet+wtBeRSkJA3cwXgjr
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e7142bf5d231 ("arm64, mm: make randomization selected by
generic topdown mmap layout") introduced a default version of
arch_randomize_brk() provided when
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT is selected.

powerpc could select CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
but needs to provide its own arch_randomize_brk().

In order to allow that, define generic version of arch_randomize_brk()
as a __weak symbol.

Cc: Alexandre Ghiti <alex@ghiti.fr>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Make the generic version of it a __weak symbol instead of a messy play with CONFIG_ items.
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index e58151a61255..7eb69f697b38 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -344,7 +344,7 @@ unsigned long randomize_stack_top(unsigned long stack_top)
 }
 
 #ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
-unsigned long arch_randomize_brk(struct mm_struct *mm)
+unsigned long __weak arch_randomize_brk(struct mm_struct *mm)
 {
 	/* Is the current task 32bit ? */
 	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
-- 
2.33.1

