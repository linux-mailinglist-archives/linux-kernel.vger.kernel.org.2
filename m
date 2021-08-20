Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0762E3F2662
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 07:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhHTFQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 01:16:52 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:60915 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234483AbhHTFQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 01:16:50 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GrVGh41Bsz9sW5;
        Fri, 20 Aug 2021 07:16:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d0JcmznpassH; Fri, 20 Aug 2021 07:16:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GrVGh36tLz9sVv;
        Fri, 20 Aug 2021 07:16:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D6F08B773;
        Fri, 20 Aug 2021 07:16:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XdDsgs3q4-jV; Fri, 20 Aug 2021 07:16:12 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 032FB8B76A;
        Fri, 20 Aug 2021 07:16:12 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B285566977; Fri, 20 Aug 2021 05:16:11 +0000 (UTC)
Message-Id: <ad031afa4b884c7dee5cddbdf3093c796fe126eb.1629436491.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Avoid link stack corruption in {add_}reloc_offset
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 20 Aug 2021 05:16:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reloc_offset() / add_reloc_offset() used bl;mflr to get code
position.

Use bcl 20,31,+4 instead of bl in order to preserve link stack.

See commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
in __get_datapage()") for details.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/misc.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 5be96feccb55..acd557637a3c 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -29,7 +29,7 @@ _GLOBAL(reloc_offset)
 	li	r3, 0
 _GLOBAL(add_reloc_offset)
 	mflr	r0
-	bl	1f
+	bcl	20,31,1f
 1:	mflr	r5
 	PPC_LL	r4,(2f-1b)(r5)
 	subf	r5,r4,r5
-- 
2.25.0

