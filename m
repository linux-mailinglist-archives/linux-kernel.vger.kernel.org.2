Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4728540C727
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbhIOOOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:14:00 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50049 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237845AbhIOON7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:13:59 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H8hxg4d5vz9sTD;
        Wed, 15 Sep 2021 16:12:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s7i1wJ0LF9qy; Wed, 15 Sep 2021 16:12:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H8hxg3k5Dz9sT4;
        Wed, 15 Sep 2021 16:12:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E4398B77B;
        Wed, 15 Sep 2021 16:12:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rBxWki4HbjZi; Wed, 15 Sep 2021 16:12:39 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 562828B763;
        Wed, 15 Sep 2021 16:12:39 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18FECPxG375762
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 16:12:25 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18FECPPO375759;
        Wed, 15 Sep 2021 16:12:25 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] powerpc/32s: Fix kuap_kernel_restore()
Date:   Wed, 15 Sep 2021 16:12:24 +0200
Message-Id: <0d0c4d0f050a637052287c09ba521bad960a2790.1631715131.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At interrupt exit, kuap_kernel_restore() calls kuap_unclok() with the
value contained in regs->kuap. However, when regs->kuap contains
0xffffffff it means that KUAP was not unlocked so calling
kuap_unlock() is unrelevant and results in jeopardising the contents
of kernel space segment registers.

So check that regs->kuap doesn't contain KUAP_NONE before calling
kuap_unlock(). In the meantime it also means that if KUAP has not
been correcly locked back at interrupt exit, it must be locked
before continuing. This is done by checking the content of
current->thread.kuap which was returned by kuap_get_and_assert_locked()

Fixes: 16132529cee5 ("powerpc/32s: Rework Kernel Userspace Access Protection")
Reported-by: Stan Johnson <userm57@yahoo.com>
Cc: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index d4b145b279f6..9f38040f0641 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -136,6 +136,14 @@ static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
 	if (kuap_is_disabled())
 		return;
 
+	if (unlikely(kuap != KUAP_NONE)) {
+		current->thread.kuap = KUAP_NONE;
+		kuap_lock(kuap, false);
+	}
+
+	if (likely(regs->kuap == KUAP_NONE))
+		return;
+
 	current->thread.kuap = regs->kuap;
 
 	kuap_unlock(regs->kuap, false);
-- 
2.31.1

