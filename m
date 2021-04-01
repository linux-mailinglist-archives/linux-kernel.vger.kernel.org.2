Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E480E352187
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhDAVUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:20:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13036 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234643AbhDAVUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:20:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FB3wM1j4Dz9twjW;
        Thu,  1 Apr 2021 15:30:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id orJzLC6qpMu6; Thu,  1 Apr 2021 15:30:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FB3wL6NvHz9twjT;
        Thu,  1 Apr 2021 15:30:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E035D8B99D;
        Thu,  1 Apr 2021 15:30:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iVfC5c5VWB6i; Thu,  1 Apr 2021 15:30:42 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 929A38B991;
        Thu,  1 Apr 2021 15:30:42 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6F70A67646; Thu,  1 Apr 2021 13:30:42 +0000 (UTC)
Message-Id: <a225606d5b3a8bc53fe612ad52c855c60b0a0a58.1617283827.git.christophe.leroy@csgroup.eu>
In-Reply-To: <0c3d5cb8a4dfdf6ca1b8aeb385c01470d6628d55.1617283827.git.christophe.leroy@csgroup.eu>
References: <0c3d5cb8a4dfdf6ca1b8aeb385c01470d6628d55.1617283827.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/3] powerpc/8xx: Define a MODULE area below kernel text
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  1 Apr 2021 13:30:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the 8xx, TASK_SIZE is 0x80000000. The space between TASK_SIZE
and PAGE_OFFSET is not used.

In order to benefit from the powerpc specific module_alloc()
function which allocate modules with 32 Mbytes from
end of kernel text, define MODULES_VADDR and MODULES_END.

Set a 256Mb area just below PAGE_OFFSET, like book3s/32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 478249959baa..6e4faa0a9b35 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -172,6 +172,9 @@
 
 #define mmu_linear_psize	MMU_PAGE_8M
 
+#define MODULES_VADDR	(PAGE_OFFSET - SZ_256M)
+#define MODULES_END	PAGE_OFFSET
+
 #ifndef __ASSEMBLY__
 
 #include <linux/mmdebug.h>
-- 
2.25.0

