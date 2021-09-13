Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2940971B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbhIMPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:21:38 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:35321 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245730AbhIMPVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:21:03 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H7VWj1s4Wz9sV3;
        Mon, 13 Sep 2021 17:19:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5bF0VdZWtzxz; Mon, 13 Sep 2021 17:19:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H7VWh3Kmtz9sVX;
        Mon, 13 Sep 2021 17:19:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 586628B778;
        Mon, 13 Sep 2021 17:19:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vIh885jvAX6q; Mon, 13 Sep 2021 17:19:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 21C908B76E;
        Mon, 13 Sep 2021 17:19:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18DFJIVX157758
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 17:19:18 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18DFJItC157754;
        Mon, 13 Sep 2021 17:19:18 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ebiederm@xmission.com,
        hch@infradead.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RESEND v3 1/6] powerpc/signal64: Access function descriptor with user access block
Date:   Mon, 13 Sep 2021 17:19:05 +0200
Message-Id: <1718f38859d5366f82d5bef531f255cedf537b5d.1631537060.git.christophe.leroy@csgroup.eu>
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
Resending with correct date, sorry for the noise, my new PC seems to have used the fake date from Git instead of adding proper Date: from current date/time.


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

