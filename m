Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0675837F4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhEMJJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:09:08 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:44027 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhEMJJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:09:04 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fgm5h6qWPz9sbR;
        Thu, 13 May 2021 11:07:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IKc8HArddjH8; Thu, 13 May 2021 11:07:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fgm5h5tl6z9sbQ;
        Thu, 13 May 2021 11:07:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A59CF8B7F3;
        Thu, 13 May 2021 11:07:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NDVGIVfb4mfx; Thu, 13 May 2021 11:07:52 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 561978B76C;
        Thu, 13 May 2021 11:07:52 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1C7BB64185; Thu, 13 May 2021 09:07:51 +0000 (UTC)
Message-Id: <40a43d6df1fdf41ade36e9a46e60a4df774ca9f6.1620896780.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/2] kprobes: Allow architectures to override optinsn page
 allocation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        clang-built-linux@googlegroups.com
Date:   Thu, 13 May 2021 09:07:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures like powerpc require a non standard
allocation of optinsn page, because module pages are
too far from the kernel for direct branches.

Define weak alloc_optinsn_page() and free_optinsn_page(), that
fall back on alloc_insn_page() and free_insn_page() when not
overriden by the architecture.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
v2: Added missing prototypes in linux/kprobes.h
---
 include/linux/kprobes.h |  3 +++
 kernel/kprobes.c        | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 1883a4a9f16a..02d4020615a7 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -409,6 +409,9 @@ void dump_kprobe(struct kprobe *kp);
 void *alloc_insn_page(void);
 void free_insn_page(void *page);
 
+void *alloc_optinsn_page(void);
+void free_optinsn_page(void *page);
+
 int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		       char *sym);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08fdd7a6..8c0a6fdef771 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -321,11 +321,21 @@ int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
 }
 
 #ifdef CONFIG_OPTPROBES
+void __weak *alloc_optinsn_page(void)
+{
+	return alloc_insn_page();
+}
+
+void __weak free_optinsn_page(void *page)
+{
+	free_insn_page(page);
+}
+
 /* For optimized_kprobe buffer */
 struct kprobe_insn_cache kprobe_optinsn_slots = {
 	.mutex = __MUTEX_INITIALIZER(kprobe_optinsn_slots.mutex),
-	.alloc = alloc_insn_page,
-	.free = free_insn_page,
+	.alloc = alloc_optinsn_page,
+	.free = free_optinsn_page,
 	.sym = KPROBE_OPTINSN_PAGE_SYM,
 	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
 	/* .insn_size is initialized later */
-- 
2.25.0

