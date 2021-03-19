Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB84341B19
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCSLHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:07:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43855 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhCSLGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:06:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F21LN5yXyz9tx8v;
        Fri, 19 Mar 2021 12:06:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tnfqdHMtUISF; Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F21LN4TLpz9tx8s;
        Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A39568B972;
        Fri, 19 Mar 2021 12:06:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rblkNPUr3rg3; Fri, 19 Mar 2021 12:06:53 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BE1B8B978;
        Fri, 19 Mar 2021 12:06:53 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BA18A675FB; Fri, 19 Mar 2021 11:06:52 +0000 (UTC)
Message-Id: <1040687aa27553d19f749f7fb48f0c07af98ee2d.1616151715.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616151715.git.christophe.leroy@csgroup.eu>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 03/10] powerpc/signal: Add unsafe_copy_ck{fpr/vsx}_from_user
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Mar 2021 11:06:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add unsafe_copy_ckfpr_from_user() and unsafe_copy_ckvsx_from_user()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index 1393876f3814..a5152ff3c52f 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -100,6 +100,26 @@ unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user *from);
 		unsafe_put_user(__t->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET], \
 				&buf[i], label);\
 } while (0)
+
+#define unsafe_copy_ckfpr_from_user(task, from, label)	do {		\
+	struct task_struct *__t = task;					\
+	u64 __user *buf = (u64 __user *)from;				\
+	int i;								\
+									\
+	for (i = 0; i < ELF_NFPREG - 1 ; i++)				\
+		unsafe_get_user(__t->thread.TS_CKFPR(i), &buf[i], label);\
+	unsafe_get_user(__t->thread.ckfp_state.fpscr, &buf[i], failed);	\
+} while (0)
+
+#define unsafe_copy_ckvsx_from_user(task, from, label)	do {		\
+	struct task_struct *__t = task;					\
+	u64 __user *buf = (u64 __user *)from;				\
+	int i;								\
+									\
+	for (i = 0; i < ELF_NVSRHALFREG ; i++)				\
+		unsafe_get_user(__t->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET], \
+				&buf[i], label);			\
+} while (0)
 #endif
 #elif defined(CONFIG_PPC_FPU_REGS)
 
-- 
2.25.0

