Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A440640DD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 16:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbhIPOzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 10:55:48 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:43059 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231793AbhIPOzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:55:47 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H9KqP4rkzz9sTp;
        Thu, 16 Sep 2021 16:54:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kPwgY1cGo74P; Thu, 16 Sep 2021 16:54:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H9KqN4RfGz9sT4;
        Thu, 16 Sep 2021 16:54:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 848028B796;
        Thu, 16 Sep 2021 16:54:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0Ejw6vR0cpbV; Thu, 16 Sep 2021 16:54:24 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.29])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E3C48B783;
        Thu, 16 Sep 2021 16:54:24 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18GEqKte426544
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 16:52:20 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18GEqHcu426537;
        Thu, 16 Sep 2021 16:52:17 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2] powerpc: warn on emulation of dcbz instruction in kernel mode
Date:   Thu, 16 Sep 2021 16:52:09 +0200
Message-Id: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dcbz instruction shouldn't be used on non-cached memory. Using
it on non-cached memory can result in alignment exception and
implies a heavy handling.

Instead of silentely emulating the instruction and resulting in high
performance degradation, warn whenever an alignment exception is
taken in kernel mode due to dcbz, so that the user is made aware that
dcbz instruction has been used unexpectedly by the kernel.

Reported-by: Stan Johnson <userm57@yahoo.com>
Cc: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Warn only when emulating kernel mode
---
 arch/powerpc/kernel/align.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index bbb4181621dd..bf96b954a4eb 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -349,6 +349,7 @@ int fix_alignment(struct pt_regs *regs)
 		if (op.type != CACHEOP + DCBZ)
 			return -EINVAL;
 		PPC_WARN_ALIGNMENT(dcbz, regs);
+		WARN_ON_ONCE(!user_mode(regs));
 		r = emulate_dcbz(op.ea, regs);
 	} else {
 		if (type == LARX || type == STCX)
-- 
2.31.1

