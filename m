Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7614337701F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 08:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhEHGh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 02:37:27 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:47645 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhEHGhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 02:37:25 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FcczB5JQCz9sbc;
        Sat,  8 May 2021 08:36:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dY9LIrX_eqFv; Sat,  8 May 2021 08:36:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FcczB4NYRz9sbC;
        Sat,  8 May 2021 08:36:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 75EEB8B774;
        Sat,  8 May 2021 08:36:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id P8c3zfm0TPmD; Sat,  8 May 2021 08:36:22 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 36C838B76B;
        Sat,  8 May 2021 08:36:22 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id ED3396492C; Sat,  8 May 2021 06:36:21 +0000 (UTC)
Message-Id: <d5e3c8e66bad3725d7d48d0e45c4b7eb7c02631d.1620455671.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/legacy_serial: Fix UBSAN: array-index-out-of-bounds
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, pmenzel@molgen.mpg.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat,  8 May 2021 06:36:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN complains when a pointer is calculated with invalid
'legacy_serial_console' index, allthough the index is verified
before dereferencing the pointer.

Fix it by checking 'legacy_serial_console' validity before
calculating pointers.

Fixes: 0bd3f9e953bd ("powerpc/legacy_serial: Use early_ioremap()")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/legacy_serial.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 8b2c1a8553a0..1c2e09e1d59b 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -354,15 +354,12 @@ static void __init setup_legacy_serial_console(int console)
 	udbg_uart_setup(info->speed, info->clock);
 }
 
-static int __init ioremap_legacy_serial_console(void)
+static int __init do_ioremap_legacy_serial_console(int console)
 {
-	struct legacy_serial_info *info = &legacy_serial_infos[legacy_serial_console];
-	struct plat_serial8250_port *port = &legacy_serial_ports[legacy_serial_console];
+	struct legacy_serial_info *info = &legacy_serial_infos[console];
+	struct plat_serial8250_port *port = &legacy_serial_ports[console];
 	void __iomem *vaddr;
 
-	if (legacy_serial_console < 0)
-		return 0;
-
 	if (!info->early_addr)
 		return 0;
 
@@ -376,6 +373,13 @@ static int __init ioremap_legacy_serial_console(void)
 
 	return 0;
 }
+
+static int __init ioremap_legacy_serial_console(void)
+{
+	if (legacy_serial_console < 0)
+		return 0;
+	return do_ioremap_legacy_serial_console(legacy_serial_console);
+}
 early_initcall(ioremap_legacy_serial_console);
 
 /*
-- 
2.25.0

