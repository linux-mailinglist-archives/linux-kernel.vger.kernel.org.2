Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059F63C825D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhGNKHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbhGNKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:07:07 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0BDC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:04:16 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by michel.telenet-ops.be with bizsmtp
        id Uy4E2500Q1ccfby06y4ETC; Wed, 14 Jul 2021 12:04:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bkU-0016Eo-AW; Wed, 14 Jul 2021 12:04:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bkT-00A4K9-UO; Wed, 14 Jul 2021 12:04:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/3] ARM: div64: Remove always-true __div64_const32_is_OK() duplicate
Date:   Wed, 14 Jul 2021 12:04:08 +0200
Message-Id: <3212709f56973b4e4d543d6c30a040fe8a525585.1626256876.git.geert+renesas@glider.be>
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
Hence __div64_const32_is_OK() is always true.

Moreover, __div64_const32_is_OK() is defined in the same way in
include/asm-generic/div64.h, so the ARM-specific definition can be
removed regardless.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 arch/arm/include/asm/div64.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 595e538f5bfb5055..4b69cf850451b076 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -52,17 +52,6 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
 
 #else
 
-/*
- * gcc versions earlier than 4.0 are simply too problematic for the
- * __div64_const32() code in asm-generic/div64.h. First there is
- * gcc PR 15089 that tend to trig on more complex constructs, spurious
- * .global __udivsi3 are inserted even if none of those symbols are
- * referenced in the generated code, and those gcc versions are not able
- * to do constant propagation on long long values anyway.
- */
-
-#define __div64_const32_is_OK (__GNUC__ >= 4)
-
 static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
 {
 	unsigned long long res;
-- 
2.25.1

