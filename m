Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7324181E2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244838AbhIYM0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 08:26:03 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:34783 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233528AbhIYM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 08:26:02 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HGp4B5jXXz9sW8;
        Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GzNMVsLW9fVN; Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HGp4B4YZ7z9sW6;
        Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 889428B76D;
        Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QgY1ogmHywk0; Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.8])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 50A728B763;
        Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18P8VliU1325996
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 25 Sep 2021 10:31:47 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18P8Vikr1325995;
        Sat, 25 Sep 2021 10:31:44 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 1/3] powerpc/code-patching: Improve verification of patchability
Date:   Sat, 25 Sep 2021 10:31:42 +0200
Message-Id: <a7a35416ddab4b42617e2c81fe5816c7f8d0c63f.1632558672.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today, patch_instruction() assumes that is called exclusively on valid
addresses, and only checks that it is not called on an init address
after init section has been freed.

Improve verification by calling kernel_text_address() instead.

kernel_text_address() already includes a verification of
initmem release.

Cc: Michael Neuling <mikey@neuling.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/code-patching.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index f9a3019e37b4..20ec6648aacc 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -190,10 +190,9 @@ static int do_patch_instruction(u32 *addr, struct ppc_inst instr)
 int patch_instruction(u32 *addr, struct ppc_inst instr)
 {
 	/* Make sure we aren't patching a freed init section */
-	if (init_mem_is_free && init_section_contains(addr, 4)) {
-		pr_debug("Skipping init section patching addr: 0x%px\n", addr);
+	if (!kernel_text_address((unsigned long)addr))
 		return 0;
-	}
+
 	return do_patch_instruction(addr, instr);
 }
 NOKPROBE_SYMBOL(patch_instruction);
-- 
2.31.1

