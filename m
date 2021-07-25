Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0593D4E36
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhGYO0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 10:26:37 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:34422 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhGYO0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 10:26:36 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Jul 2021 10:26:35 EDT
X-QQ-mid: bizesmtp46t1627225276tfkrsdia
Received: from localhost.localdomain (unknown [125.70.163.19])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 25 Jul 2021 23:01:15 +0800 (CST)
X-QQ-SSF: 0100000000800090B000B00A0000000
X-QQ-FEAT: aHJ2PTLZoXduDiSx0SWj5iWJ2RObJkhtK6JCKNqGe2C5FFUhuDMIRPxpDSsDP
        lPG7J8d0bTcccUyCrJa4rcUa3tZoigHgPUYzXldQBbJb1zr4SoitsuhRIRCIC/1rNd5lHyC
        bBIg9BoSz0M5Cv2ZILeQWN4As2uG9D7i1mgMj/3hspTF3XPBG1cRbuOiXXjaUW3dpiqMpru
        E97CP9XI18S5NX53te9eKZy/SC4007pFTCuXC847JmcE0CIf7UQGKU6BBTHNp2w/pa6wNAW
        561GL5vYORjDeRmV5hG9M+EZqDVw5WHtaBEAyFTZU6NKovKZD5y55Ue+EjmnYrTCFOMPqo1
        c2KqO8PLJGb3HWL/NfhcgM9mqBezg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] powerpc/xmon: use ARRAY_SIZE
Date:   Sun, 25 Jul 2021 23:01:07 +0800
Message-Id: <20210725150107.27865-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARRAY_SIZE is the macro definition of sizeof(a)/sizeof(a[0]) and
it is more compact and formal to get a array size.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/xmon/ppc-opc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
index dfb80810b16c..6ca4cd26caef 100644
--- a/arch/powerpc/xmon/ppc-opc.c
+++ b/arch/powerpc/xmon/ppc-opc.c
@@ -954,8 +954,7 @@ const struct powerpc_operand powerpc_operands[] =
   { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
 };
 
-const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
-					   / sizeof (powerpc_operands[0]));
+const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
 
 /* The functions used to insert and extract complicated operands.  */
 
@@ -6968,8 +6967,7 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 {"fcfidu.",	XRC(63,974,1),	XRA_MASK, POWER7|PPCA2,	PPCVLE,		{FRT, FRB}},
 };
 
-const int powerpc_num_opcodes =
-  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
+const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
 
 /* The VLE opcode table.
 
@@ -7207,8 +7205,7 @@ const struct powerpc_opcode vle_opcodes[] = {
 {"se_bl",	BD8(58,0,1),	BD8_MASK,	PPCVLE,	0,		{B8}},
 };
 
-const int vle_num_opcodes =
-  sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
+const int vle_num_opcodes = ARRAY_SIZE(vle_opcodes);
 
 /* The macro table.  This is only used by the assembler.  */
 
@@ -7276,5 +7273,4 @@ const struct powerpc_macro powerpc_macros[] = {
 {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-(%3)"},
 };
 
-const int powerpc_num_macros =
-  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
+const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
-- 
2.32.0

