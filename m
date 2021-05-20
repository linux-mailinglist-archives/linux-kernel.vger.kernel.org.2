Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB86B38A79F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhETKlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 06:41:04 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59737 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236065AbhETKZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:25:48 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fm5RB15MHz9sVj;
        Thu, 20 May 2021 12:23:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MHABFbcuXNWq; Thu, 20 May 2021 12:23:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fm5RB0BhMz9sVM;
        Thu, 20 May 2021 12:23:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A90A38B811;
        Thu, 20 May 2021 12:23:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 70b0Ye7lVSFy; Thu, 20 May 2021 12:23:01 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58BD98B80D;
        Thu, 20 May 2021 12:23:01 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4206E64C44; Thu, 20 May 2021 10:23:01 +0000 (UTC)
Message-Id: <ec34d92b7c2f810622261acfeeed4b0a0f4d01bd.1621506159.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
References: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 02/12] powerpc/opcodes: Add shorter macros for registers
 for use with PPC_RAW_xx()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 10:23:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today we have __REG_Rx macros . They are mainly meant for
internal use by macros __PPC_RA() and friends macros which
allows uses like __PPC_RA(R12).

When used with PPC_RAW_xx() macros, it gives a result which is
not very readable.

Add shorter macros _Rx in order to improve readability when
used with PPC_RAW_xx() macros.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 403067ba170e..efabbeb48f4e 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -76,6 +76,40 @@
 #define	__REGA0_R30	30
 #define	__REGA0_R31	31
 
+/* For use with PPC_RAW_() macros */
+#define	_R0	0
+#define	_R1	1
+#define	_R2	2
+#define	_R3	3
+#define	_R4	4
+#define	_R5	5
+#define	_R6	6
+#define	_R7	7
+#define	_R8	8
+#define	_R9	9
+#define	_R10	10
+#define	_R11	11
+#define	_R12	12
+#define	_R13	13
+#define	_R14	14
+#define	_R15	15
+#define	_R16	16
+#define	_R17	17
+#define	_R18	18
+#define	_R19	19
+#define	_R20	20
+#define	_R21	21
+#define	_R22	22
+#define	_R23	23
+#define	_R24	24
+#define	_R25	25
+#define	_R26	26
+#define	_R27	27
+#define	_R28	28
+#define	_R29	29
+#define	_R30	30
+#define	_R31	31
+
 #define IMM_L(i)               ((uintptr_t)(i) & 0xffff)
 #define IMM_DS(i)              ((uintptr_t)(i) & 0xfffc)
 #define IMM_DQ(i)              ((uintptr_t)(i) & 0xfff0)
-- 
2.25.0

