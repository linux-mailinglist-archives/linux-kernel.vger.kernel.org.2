Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE232550A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhBYSAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:00:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:32382 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233043AbhBYRwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:52:42 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DmgLV74Y4z9v1BG;
        Thu, 25 Feb 2021 18:50:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Nbs45xOKHs7u; Thu, 25 Feb 2021 18:50:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DmgLV6BK3z9v19y;
        Thu, 25 Feb 2021 18:50:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B04B58B895;
        Thu, 25 Feb 2021 18:50:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uWEk6KeL33cy; Thu, 25 Feb 2021 18:50:44 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A4F68B88B;
        Thu, 25 Feb 2021 18:50:44 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4444567442; Thu, 25 Feb 2021 17:50:44 +0000 (UTC)
Message-Id: <ac83ef352de8618606fe57126b14ff0b611275ad.1614275314.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 14/15] powerpc/uaccess: Also perform 64 bits copies in
 unsafe_copy_to_user() on ppc32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Feb 2021 17:50:44 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppc32 has an efficiant 64 bits __put_user(), so also use it in
order to unroll loops more.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index b3bd1fb42242..e831653db51a 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -371,9 +371,9 @@ do {									\
 	size_t _len = (l);						\
 	int _i;								\
 									\
-	for (_i = 0; _i < (_len & ~(sizeof(long) - 1)); _i += sizeof(long))		\
-		unsafe_put_user(*(long*)(_src + _i), (long __user *)(_dst + _i), e); \
-	if (IS_ENABLED(CONFIG_PPC64) && (_len & 4)) {			\
+	for (_i = 0; _i < (_len & ~(sizeof(u64) - 1)); _i += sizeof(u64))	\
+		unsafe_put_user(*(u64 *)(_src + _i), (u64 __user *)(_dst + _i), e); \
+	if (_len & 4) {							\
 		unsafe_put_user(*(u32*)(_src + _i), (u32 __user *)(_dst + _i), e); \
 		_i += 4;						\
 	}								\
-- 
2.25.0

