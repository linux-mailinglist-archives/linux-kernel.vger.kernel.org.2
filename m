Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6322C389888
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhESVXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:23:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51785 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhESVXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:23:42 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14JLM1Ee4187848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 19 May 2021 14:22:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14JLM1Ee4187848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621459333;
        bh=owjrk77YDvMSdwtSYw/kbhFLq6C9oQtawBgMefYnrSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0BETT/oQ0xeMKRCxSBi4uit0kJ4RzfEgE3GeNIxS+IgA28dldWe+MhqXVE32NgAT
         +Wftvj64qwN2BNwFTFG7Un46PEIBpOzJJ8NT90r4xmMYtzScYwjVd6Vu0BGx1Eze/L
         TE2+nVZ79zDEusNIwAZhmH4CS3FOh6EN0PZ0KNaMa/3RRRppQsENL+Ep1lvZofOiiQ
         ZDQXQSNvX1PlYa7DR37qucf3aG6CyZArnqB5DzPZOyUSfOsHfdkykG1UJ/GRYYPK2y
         gWMVHAscMit6BQzsIvLWUJb3zMYAweO2gaJmakK3HPzuY9EwHAuMQCN/lDzhk+DysO
         24b2Zx8yzsc5g==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/8] x86/kexec: set_[gi]dt() -> native_[gi]dt_invalidate() in machine_kexec_*.c
Date:   Wed, 19 May 2021 14:21:52 -0700
Message-Id: <20210519212154.511983-7-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519212154.511983-1-hpa@zytor.com>
References: <20210519212154.511983-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

These files contain private set_gdt() functions which are only used to
invalid the gdt; machine_kexec_64.c also contains a set_idt()
function to invalidate the idt.

phys_to_virt(0) *really* doesn't make any sense for creating an
invalid GDT. A NULL pointer (virtual 0) makes a lot more sense;
although neither will allow any actual memory reference, a NULL
pointer stands out more.

Replace these calls with native_[gi]dt_invalidate().

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/kernel/machine_kexec_32.c | 15 ++------------
 arch/x86/kernel/machine_kexec_64.c | 33 ++----------------------------
 2 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 1e34feebcd5d..1b373d79cedc 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -23,17 +23,6 @@
 #include <asm/set_memory.h>
 #include <asm/debugreg.h>
 
-static void set_gdt(void *newgdt, __u16 limit)
-{
-	struct desc_ptr curgdt;
-
-	/* ia32 supports unaligned loads & stores */
-	curgdt.size    = limit;
-	curgdt.address = (unsigned long)newgdt;
-
-	load_gdt(&curgdt);
-}
-
 static void load_segments(void)
 {
 #define __STR(X) #X
@@ -232,8 +221,8 @@ void machine_kexec(struct kimage *image)
 	 * The gdt & idt are now invalid.
 	 * If you want to load them you must set up your own idt & gdt.
 	 */
-	idt_invalidate();
-	set_gdt(phys_to_virt(0), 0);
+	native_idt_invalidate();
+	native_gdt_invalidate();
 
 	/* now call it */
 	image->start = relocate_kernel_ptr((unsigned long)image->head,
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c078b0d3ab0e..131f30fdcfbd 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -256,35 +256,6 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	return init_transition_pgtable(image, level4p);
 }
 
-static void set_idt(void *newidt, u16 limit)
-{
-	struct desc_ptr curidt;
-
-	/* x86-64 supports unaligned loads & stores */
-	curidt.size    = limit;
-	curidt.address = (unsigned long)newidt;
-
-	__asm__ __volatile__ (
-		"lidtq %0\n"
-		: : "m" (curidt)
-		);
-};
-
-
-static void set_gdt(void *newgdt, u16 limit)
-{
-	struct desc_ptr curgdt;
-
-	/* x86-64 supports unaligned loads & stores */
-	curgdt.size    = limit;
-	curgdt.address = (unsigned long)newgdt;
-
-	__asm__ __volatile__ (
-		"lgdtq %0\n"
-		: : "m" (curgdt)
-		);
-};
-
 static void load_segments(void)
 {
 	__asm__ __volatile__ (
@@ -379,8 +350,8 @@ void machine_kexec(struct kimage *image)
 	 * The gdt & idt are now invalid.
 	 * If you want to load them you must set up your own idt & gdt.
 	 */
-	set_gdt(phys_to_virt(0), 0);
-	set_idt(phys_to_virt(0), 0);
+	native_idt_invalidate();
+	native_gdt_invalidate();
 
 	/* now call it */
 	image->start = relocate_kernel((unsigned long)image->head,
-- 
2.31.1

