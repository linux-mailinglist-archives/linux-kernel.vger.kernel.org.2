Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F9C39D039
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFFRpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 13:45:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65150 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFFRpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 13:45:16 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FykPD5sk3zBBbP;
        Sun,  6 Jun 2021 19:43:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PCk2U_ulrj21; Sun,  6 Jun 2021 19:43:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FykPD4wNxzBBZn;
        Sun,  6 Jun 2021 19:43:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 987C28B770;
        Sun,  6 Jun 2021 19:43:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9H6RTjQbUkHE; Sun,  6 Jun 2021 19:43:12 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B1C98B763;
        Sun,  6 Jun 2021 19:43:12 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 15B9B64C49; Sun,  6 Jun 2021 17:43:11 +0000 (UTC)
Message-Id: <b175c35ce1596603bf321a5193e89400ae180057.1623001343.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] Fixup for "[v2] powerpc/8xx: Allow disabling KUAP at boot
 time"
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun,  6 Jun 2021 17:43:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot reported:

>> ERROR: modpost: "disable_kuap_key" [net/phonet/pn_pep.ko] undefined!
>> ERROR: modpost: "disable_kuap_key" [net/phonet/phonet.ko] undefined!
>> ERROR: modpost: "disable_kuap_key" [net/decnet/decnet.ko] undefined!
>> ERROR: modpost: "disable_kuap_key" [drivers/tee/tee.ko] undefined!
>> ERROR: modpost: "disable_kuap_key" [drivers/input/evdev.ko] undefined!
>> ERROR: modpost: "disable_kuap_key" [drivers/input/joydev.ko] undefined!
>> ERROR: modpost: "disable_kuap_key" [drivers/input/mousedev.ko] undefined!
>> ERROR: modpost: "disable_kuap_key" [drivers/input/serio/serio_raw.ko] undefined!
>> ERROR: modpost: "disable_kuap_key" [drivers/fsi/fsi-scom.ko] undefined!
>> ERROR: modpost: "disable_kuap_key" [drivers/watchdog/mv64x60_wdt.ko] undefined!
WARNING: modpost: suppressed 13 unresolved symbol warnings because there were too many)

disable_kuap_key has to be exported. Use EXPORT_SYMBOL() as userspace
access function are not exported as GPL today.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index a8d44e9342f3..fc663322ba58 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -257,6 +257,7 @@ void __init setup_kuep(bool disabled)
 
 #ifdef CONFIG_PPC_KUAP
 struct static_key_false disable_kuap_key;
+EXPORT_SYMBOL(disable_kuap_key);
 
 void __init setup_kuap(bool disabled)
 {
-- 
2.25.0

