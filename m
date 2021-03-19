Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0D341B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCSLHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:07:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38596 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhCSLGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:06:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F21LN3qsZz9tx8w;
        Fri, 19 Mar 2021 12:06:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Dq8PeRF8qLwU; Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F21LN2vnRz9tx8s;
        Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 099188B976;
        Fri, 19 Mar 2021 12:06:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rRIrLIL4Vubt; Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D5D78B975;
        Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B0CA1675FB; Fri, 19 Mar 2021 11:06:51 +0000 (UTC)
Message-Id: <308e65d9237a14e8c0e3b22919fcf0b5e5592608.1616151715.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616151715.git.christophe.leroy@csgroup.eu>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 02/10] powerpc/uaccess: Also perform 64 bits copies in
 unsafe_copy_from_user() on ppc32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Mar 2021 11:06:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to commit 5cf773fc8f37 ("powerpc/uaccess: Also perform
64 bits copies in unsafe_copy_to_user() on ppc32")

ppc32 has an efficiant 64 bits unsafe_get_user(), so also use it in
order to unroll loops more.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 77d837b16e4d..a4e791bcd3fe 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -432,9 +432,9 @@ do {											\
 	size_t _len = (l);								\
 	int _i;										\
 											\
-	for (_i = 0; _i < (_len & ~(sizeof(long) - 1)); _i += sizeof(long))		\
-		unsafe_get_user(*(long *)(_dst + _i), (long __user *)(_src + _i), e);	\
-	if (IS_ENABLED(CONFIG_PPC64) && (_len & 4)) {					\
+	for (_i = 0; _i < (_len & ~(sizeof(u64) - 1)); _i += sizeof(u64))		\
+		unsafe_get_user(*(u64 *)(_dst + _i), (u64 __user *)(_src + _i), e);	\
+	if (_len & 4) {									\
 		unsafe_get_user(*(u32 *)(_dst + _i), (u32 __user *)(_src + _i), e);	\
 		_i += 4;								\
 	}										\
-- 
2.25.0

