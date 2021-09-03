Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2C83FFEE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349212AbhICLTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:19:52 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:51003 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240932AbhICLTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:19:46 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H1FfS58gHz9sTr;
        Fri,  3 Sep 2021 13:18:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eVOx43PML7-t; Fri,  3 Sep 2021 13:18:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H1FfR41GGz9sT0;
        Fri,  3 Sep 2021 13:18:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 756EA8B8E3;
        Fri,  3 Sep 2021 13:18:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ln7IZKXzGoEC; Fri,  3 Sep 2021 13:18:39 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 480398B764;
        Fri,  3 Sep 2021 13:18:39 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1963B63D74; Fri,  3 Sep 2021 11:18:39 +0000 (UTC)
Message-Id: <c033c3ae489c30ec6c93d26ad713e47d8e0bcd33.1630667612.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1630667612.git.christophe.leroy@csgroup.eu>
References: <cover.1630667612.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 04/11] powerpc/machdep: Make probe_machine() static
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  3 Sep 2021 11:18:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b1923caa6e64 ("powerpc: Merge 32-bit and 64-bit
setup_arch()") probe_machine has only been called from the
file in which it is defined. So it can be static.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/machdep.h | 2 --
 arch/powerpc/kernel/setup-common.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index f6f8344f4a0c..a50aed6170c3 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -230,8 +230,6 @@ extern struct machdep_calls *machine_id;
 		machine_id == &mach_##name; \
 	})
 
-extern void probe_machine(void);
-
 #ifdef CONFIG_PPC_PMAC
 /*
  * Power macintoshes have either a CUDA, PMU or SMU controlling
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 0b7894eed58d..96e88209e605 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -582,7 +582,7 @@ static __init int add_pcspkr(void)
 device_initcall(add_pcspkr);
 #endif	/* CONFIG_PCSPKR_PLATFORM */
 
-void probe_machine(void)
+static void probe_machine(void)
 {
 	extern struct machdep_calls __machine_desc_start;
 	extern struct machdep_calls __machine_desc_end;
-- 
2.25.0

