Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805DF3F4D97
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhHWPgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:36:37 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:52827 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhHWPgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:36:36 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GtbtH75CNz9sVN;
        Mon, 23 Aug 2021 17:35:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id izYZZl_Eawbw; Mon, 23 Aug 2021 17:35:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GtbtH6DhNz9sT5;
        Mon, 23 Aug 2021 17:35:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B21DC8B7AF;
        Mon, 23 Aug 2021 17:35:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nmZS4ven9wac; Mon, 23 Aug 2021 17:35:51 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58C6B8B7AD;
        Mon, 23 Aug 2021 17:35:51 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4E4176BC7C; Mon, 23 Aug 2021 15:35:51 +0000 (UTC)
Message-Id: <fd7938d94008711d441551c06b25a033669a0618.1629732940.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/5] powerpc/signal64: Access function descriptor with user
 access block
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Aug 2021 15:35:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access the function descriptor of the handler within a
user access block.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_64.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 1831bba0582e..790c450c2de8 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -936,8 +936,18 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		func_descr_t __user *funct_desc_ptr =
 			(func_descr_t __user *) ksig->ka.sa.sa_handler;
 
-		err |= get_user(regs->ctr, &funct_desc_ptr->entry);
-		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
+		if (user_read_access_begin(funct_desc_ptr, sizeof(func_descr_t))) {
+			unsafe_get_user(regs->ctr, &funct_desc_ptr->entry, bad_funct_desc_block);
+			unsafe_get_user(regs->gpr[2], &funct_desc_ptr->toc, bad_funct_desc_block);
+		} else {
+			goto bad_funct_desc;
+bad_funct_desc_block:
+			user_read_access_end();
+bad_funct_desc:
+			signal_fault(current, regs, __func__, funct_desc_ptr);
+			return 1;
+		}
+		user_read_access_end();
 	}
 
 	/* enter the signal handler in native-endian mode */
-- 
2.25.0

