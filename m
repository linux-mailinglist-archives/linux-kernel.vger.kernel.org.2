Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E934417207
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbhIXMkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:40:14 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:54665 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343605AbhIXMkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:40:12 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HGBQl1rj2z9sVL;
        Fri, 24 Sep 2021 14:38:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7DhOk8juKUV9; Fri, 24 Sep 2021 14:38:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HGBQj43w6z9sVR;
        Fri, 24 Sep 2021 14:38:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B0528B783;
        Fri, 24 Sep 2021 14:38:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mQ1YRQwvPb8x; Fri, 24 Sep 2021 14:38:21 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.215])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 296D48B77E;
        Fri, 24 Sep 2021 14:38:21 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18OCcAVt1268633
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 14:38:10 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18OCcA331268632;
        Fri, 24 Sep 2021 14:38:10 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Neuling <mikey@neuling.org>
Subject: [PATCH v1 2/3] powerpc: Stop using init_mem_is_free
Date:   Fri, 24 Sep 2021 14:38:03 +0200
Message-Id: <269dc4fa0c6b0639688190c983e681bcc692ffc7.1632487071.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a7a35416ddab4b42617e2c81fe5816c7f8d0c63f.1632487071.git.christophe.leroy@csgroup.eu>
References: <a7a35416ddab4b42617e2c81fe5816c7f8d0c63f.1632487071.git.christophe.leroy@csgroup.eu>
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
 arch/powerpc/include/asm/sections.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 6e4af4492a14..dff55421f76b 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -14,7 +14,7 @@ extern bool init_mem_is_free;
 
 static inline int arch_is_kernel_initmem_freed(unsigned long addr)
 {
-	if (!init_mem_is_free)
+	if (system_state < SYSTEM_RUNNING)
 		return 0;
 
 	return addr >= (unsigned long)__init_begin &&
-- 
2.31.1

