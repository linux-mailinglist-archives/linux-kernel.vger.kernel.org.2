Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30CD40B0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhINOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:33:22 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:53425 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233562AbhINOdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:33:20 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H85QV3nsrz9sTY;
        Tue, 14 Sep 2021 16:32:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pt6qTs5ExPd3; Tue, 14 Sep 2021 16:32:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H85QS4x93z9sTV;
        Tue, 14 Sep 2021 16:32:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 94D6A8B778;
        Tue, 14 Sep 2021 16:32:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uaaL3fq-P0KO; Tue, 14 Sep 2021 16:32:00 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.207])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 35F958B776;
        Tue, 14 Sep 2021 16:32:00 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18EEVnnb336568
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 16:31:49 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18EEViFm336564;
        Tue, 14 Sep 2021 16:31:44 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ebiederm@xmission.com,
        hch@infradead.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/5] powerpc/signal64: Access function descriptor with user access block
Date:   Tue, 14 Sep 2021 16:31:23 +0200
Message-Id: <1718f38859d5366f82d5bef531f255cedf537b5d.1631629700.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access the function descriptor of the handler within a
user access block.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Flatten the change to avoid nested gotos.
---
 arch/powerpc/kernel/signal_64.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 1831bba0582e..7b1cd50bc4fb 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -936,8 +936,13 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		func_descr_t __user *funct_desc_ptr =
 			(func_descr_t __user *) ksig->ka.sa.sa_handler;
 
-		err |= get_user(regs->ctr, &funct_desc_ptr->entry);
-		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
+		if (!user_read_access_begin(funct_desc_ptr, sizeof(func_descr_t)))
+			goto badfunc;
+
+		unsafe_get_user(regs->ctr, &funct_desc_ptr->entry, badfunc_block);
+		unsafe_get_user(regs->gpr[2], &funct_desc_ptr->toc, badfunc_block);
+
+		user_read_access_end();
 	}
 
 	/* enter the signal handler in native-endian mode */
@@ -962,5 +967,12 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 badframe:
 	signal_fault(current, regs, "handle_rt_signal64", frame);
 
+	return 1;
+
+badfunc_block:
+	user_read_access_end();
+badfunc:
+	signal_fault(current, regs, __func__, (void __user *)ksig->ka.sa.sa_handler);
+
 	return 1;
 }
-- 
2.31.1

