Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA73CE89A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354610AbhGSQoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 12:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349121AbhGSPZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:25:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3525E60FD7;
        Mon, 19 Jul 2021 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626710782;
        bh=0YPOTlGAevRTrCYvMVP6goKkOJ4HD5gtpQFiIRIXX6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvPPaIzEYofvWUxSmHlHEInOIRoEz7t4VnaVqqfOyVlCYgPMD9BomQynPVFkQH2Q5
         5fh/cowL+MJcrcoBfn/S3abxObxPlMJIGvIKpTUsORQdr9odhoarYnpJBbcZf+Z0EN
         V4IWcXg4xGagOl4pwsEJ7XRYBnF/t4AJsF4EixVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.13 107/351] powerpc/inst: Fix sparse detection on get_user_instr()
Date:   Mon, 19 Jul 2021 16:50:53 +0200
Message-Id: <20210719144948.029851331@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719144944.537151528@linuxfoundation.org>
References: <20210719144944.537151528@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit b3a9e523237013477bea914b7fbfbe420428b988 ]

get_user_instr() lacks sparse detection for the __user tag.

This is because __gui_ptr is assigned with a cast.

Fix that by adding a __chk_user_ptr()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/0320e5b41a794fd456ab8c5993bbfadcf9e1d8b4.1621516826.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/inst.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 268d3bd073c8..887ef150fdda 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -12,6 +12,8 @@
 	unsigned long __gui_ptr = (unsigned long)ptr;			\
 	struct ppc_inst __gui_inst;					\
 	unsigned int __prefix, __suffix;				\
+									\
+	__chk_user_ptr(ptr);						\
 	__gui_ret = gu_op(__prefix, (unsigned int __user *)__gui_ptr);	\
 	if (__gui_ret == 0) {						\
 		if ((__prefix >> 26) == OP_PREFIX) {			\
@@ -29,7 +31,10 @@
 })
 #else /* !CONFIG_PPC64 */
 #define ___get_user_instr(gu_op, dest, ptr)				\
-	gu_op((dest).val, (u32 __user *)(ptr))
+({									\
+	__chk_user_ptr(ptr);						\
+	gu_op((dest).val, (u32 __user *)(ptr));				\
+})
 #endif /* CONFIG_PPC64 */
 
 #define get_user_instr(x, ptr) \
-- 
2.30.2



