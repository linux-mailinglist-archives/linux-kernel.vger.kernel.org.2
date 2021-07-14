Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567BD3C825E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbhGNKHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbhGNKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:07:09 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57629C061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:04:18 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by albert.telenet-ops.be with bizsmtp
        id Uy4G2500V1ccfby06y4Ghi; Wed, 14 Jul 2021 12:04:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bkW-0016F5-E9; Wed, 14 Jul 2021 12:04:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bkV-00A4KZ-Tc; Wed, 14 Jul 2021 12:04:15 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/3] asm-generic: div64: Remove always-true __div64_const32_is_OK()
Date:   Wed, 14 Jul 2021 12:04:10 +0200
Message-Id: <1dd0ba5c9021f30bbce413c667370f53fdbfa150.1626256876.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626256876.git.geert+renesas@glider.be>
References: <cover.1626256876.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cafa0010cd51fb71 ("Raise the minimum required gcc version
to 4.6"), the kernel can no longer be compiled using gcc-3.
Hence __div64_const32_is_OK() is always true, and the corresponding
check can thus be removed.

While at it, remove the whitespace error that hurts my eyes, and add the
missing curly braces for the final else statement, as per coding style.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 include/asm-generic/div64.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index cd905b44a6300bf7..13f5aa68a4552a09 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -57,17 +57,11 @@
 /*
  * If the divisor happens to be constant, we determine the appropriate
  * inverse at compile time to turn the division into a few inline
- * multiplications which ought to be much faster. And yet only if compiling
- * with a sufficiently recent gcc version to perform proper 64-bit constant
- * propagation.
+ * multiplications which ought to be much faster.
  *
  * (It is unfortunate that gcc doesn't perform all this internally.)
  */
 
-#ifndef __div64_const32_is_OK
-#define __div64_const32_is_OK (__GNUC__ >= 4)
-#endif
-
 #define __div64_const32(n, ___b)					\
 ({									\
 	/*								\
@@ -230,8 +224,7 @@ extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 	    is_power_of_2(__base)) {			\
 		__rem = (n) & (__base - 1);		\
 		(n) >>= ilog2(__base);			\
-	} else if (__div64_const32_is_OK &&		\
-		   __builtin_constant_p(__base) &&	\
+	} else if (__builtin_constant_p(__base) &&	\
 		   __base != 0) {			\
 		uint32_t __res_lo, __n_lo = (n);	\
 		(n) = __div64_const32(n, __base);	\
@@ -241,8 +234,9 @@ extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 	} else if (likely(((n) >> 32) == 0)) {		\
 		__rem = (uint32_t)(n) % __base;		\
 		(n) = (uint32_t)(n) / __base;		\
-	} else 						\
+	} else {					\
 		__rem = __div64_32(&(n), __base);	\
+	}						\
 	__rem;						\
  })
 
-- 
2.25.1

