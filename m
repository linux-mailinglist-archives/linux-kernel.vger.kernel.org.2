Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C638420912
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhJDKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhJDKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:11:45 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3F2C061746
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 03:09:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:9ca4:a53a:9ffa:e003])
        by baptiste.telenet-ops.be with bizsmtp
        id 1m9t2600811933301m9ttw; Mon, 04 Oct 2021 12:09:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mXKks-001pGa-BT; Mon, 04 Oct 2021 11:59:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mXHzc-00CLiU-GE; Mon, 04 Oct 2021 09:02:32 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68knommu: Remove MCPU32 config symbol
Date:   Mon,  4 Oct 2021 09:02:31 +0200
Message-Id: <20211004070231.2943362-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit a3595962d82495f5 ("m68knommu: remove obsolete 68360
support"), nothing selects MCPU32 anymore.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/Kconfig.cpu          | 11 -----------
 arch/m68k/include/asm/bitops.h |  2 +-
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 277d61a094637ce3..0d00ef5117dceed9 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -53,17 +53,6 @@ config M68000
 	  System-On-Chip devices (eg 68328, 68302, etc). It does not contain
 	  a paging MMU.
 
-config MCPU32
-	bool
-	select CPU_HAS_NO_BITFIELDS
-	select CPU_HAS_NO_CAS
-	select CPU_HAS_NO_UNALIGNED
-	select CPU_NO_EFFICIENT_FFS
-	help
-	  The Freescale (was then Motorola) CPU32 is a CPU core that is
-	  based on the 68020 processor. For the most part it is used in
-	  System-On-Chip parts, and does not contain a paging MMU.
-
 config M68020
 	bool "68020 support"
 	depends on MMU
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 7b414099e5fc20fa..7b93e1fd8ffa902f 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -451,7 +451,7 @@ static inline unsigned long ffz(unsigned long word)
  *	generic functions for those.
  */
 #if (defined(__mcfisaaplus__) || defined(__mcfisac__)) && \
-	!defined(CONFIG_M68000) && !defined(CONFIG_MCPU32)
+	!defined(CONFIG_M68000)
 static inline unsigned long __ffs(unsigned long x)
 {
 	__asm__ __volatile__ ("bitrev %0; ff1 %0"
-- 
2.25.1

