Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136683C825F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhGNKHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbhGNKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:07:10 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4703CC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:04:18 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by albert.telenet-ops.be with bizsmtp
        id Uy4F2500C1ccfby06y4FhN; Wed, 14 Jul 2021 12:04:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bkU-0016Et-SX; Wed, 14 Jul 2021 12:04:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bkU-00A4KL-H5; Wed, 14 Jul 2021 12:04:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/3] ARM: unified: Remove check for gcc < 4
Date:   Wed, 14 Jul 2021 12:04:09 +0200
Message-Id: <e99e9cce8fbf3ca59e04e22e9a4830c3911347eb.1626256876.git.geert+renesas@glider.be>
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
Hence this condition is never true, and the check can thus be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 arch/arm/include/asm/unified.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index 1e2c3eb043535f7b..ce9689118dbb945b 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -24,10 +24,6 @@ __asm__(".syntax unified");
 
 #ifdef CONFIG_THUMB2_KERNEL
 
-#if __GNUC__ < 4
-#error Thumb-2 kernel requires gcc >= 4
-#endif
-
 /* The CPSR bit describing the instruction set (Thumb) */
 #define PSR_ISETSTATE	PSR_T_BIT
 
-- 
2.25.1

