Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80DC4591B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbhKVP46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbhKVP45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:56:57 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF5FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:53:49 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e4da:38c:79e9:48bf])
        by xavier.telenet-ops.be with bizsmtp
        id MTtn2600X4yPVd601Ttn1C; Mon, 22 Nov 2021 16:53:47 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBdb-00EL1Y-2c; Mon, 22 Nov 2021 16:53:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBda-00HGjV-Fy; Mon, 22 Nov 2021 16:53:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: ptrace: Use bitfield helpers
Date:   Mon, 22 Nov 2021 16:53:41 +0100
Message-Id: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isa_mode() macro extracts two fields, and recombines them into a
single value.  The shift value of the J-bit may look off-by-one to the
casual reader, as it is the net result of the extraction and
recombination steps.

Make this more obvious by using the FIELD_GET() helper, and shifting the
result into its final resting place.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
No changes in generated assembler code.

See "[PATCH 00/17] Non-const bitfield helper conversions"
(https://lore.kernel.org/r/cover.1637592133.git.geert+renesas@glider.be)
for background and more conversions.
---
 arch/arm/include/asm/ptrace.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 93051e2f402c8452..982514aa83c1f459 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -10,6 +10,7 @@
 #include <uapi/asm/ptrace.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/bitfield.h>
 #include <linux/types.h>
 
 struct pt_regs {
@@ -35,8 +36,8 @@ struct svc_pt_regs {
 
 #ifndef CONFIG_CPU_V7M
 #define isa_mode(regs) \
-	((((regs)->ARM_cpsr & PSR_J_BIT) >> (__ffs(PSR_J_BIT) - 1)) | \
-	 (((regs)->ARM_cpsr & PSR_T_BIT) >> (__ffs(PSR_T_BIT))))
+	((FIELD_GET(PSR_J_BIT, (regs)->ARM_cpsr) << 1) | \
+	 FIELD_GET(PSR_T_BIT, (regs)->ARM_cpsr))
 #else
 #define isa_mode(regs) 1 /* Thumb */
 #endif
-- 
2.25.1

