Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132CE4181E3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbhIYM0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 08:26:06 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46137 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244846AbhIYM0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 08:26:04 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HGp4C0qcGz9sW9;
        Sat, 25 Sep 2021 14:24:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 17h4qlarqDac; Sat, 25 Sep 2021 14:24:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HGp4B75d8z9sW6;
        Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DF4FC8B76D;
        Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FSeUYn7msvyu; Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.8])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A860D8B763;
        Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18P8VmC81326000
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 25 Sep 2021 10:31:48 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18P8Vmtv1325999;
        Sat, 25 Sep 2021 10:31:48 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 2/3] powerpc: Stop using init_mem_is_free
Date:   Sat, 25 Sep 2021 10:31:43 +0200
Message-Id: <4abb3611309bf7b31520d990f426e5941b562b67.1632558672.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a7a35416ddab4b42617e2c81fe5816c7f8d0c63f.1632558672.git.christophe.leroy@csgroup.eu>
References: <a7a35416ddab4b42617e2c81fe5816c7f8d0c63f.1632558672.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic parts of the kernel for instance core_kernel_text()
use 'system_state' to check whether init memory has been
freed.

Do the same and stop using init_mem_is_free.

Cc: Michael Neuling <mikey@neuling.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
arch_is_kernel_initmem_freed() is likely going to go away via the mm tree, in that case this patch will void.

v2: Also remove declaration of init_mem_is_free.
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/sections.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 6e4af4492a14..454b8434bfc4 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -10,11 +10,9 @@
 
 #include <asm-generic/sections.h>
 
-extern bool init_mem_is_free;
-
 static inline int arch_is_kernel_initmem_freed(unsigned long addr)
 {
-	if (!init_mem_is_free)
+	if (system_state < SYSTEM_RUNNING)
 		return 0;
 
 	return addr >= (unsigned long)__init_begin &&
-- 
2.31.1

