Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0D379BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhEKA5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:57:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55531 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKA5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:57:07 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14B0tdw82504247
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 17:55:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14B0tdw82504247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620694550;
        bh=Ckez2BGMzJzZas4BtzTmwHHAtQVyx9WKBJPNFkDqe7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvYTfn+Z+HFq5K73Xl2pnagqYNqyGtsV93J2gw/htJbn48qvClETPS+XNwLEuoUIX
         XYhtPKcUZbfFUf/M9odQrc5rEVH2ayq5HMY0K7JlRVyxiGKhjfbQCf3UN3xbA1hKA3
         mzOjYR7EwXkWWApAVBKxFzmWTSXpTpevlwVFkDVCshUGl9gLjAMWUZwncdquYmjNN6
         2iDJBmGoiXd4v4cJhJfHfuNhEhMyw1bN+N8AfYQktZ3nAi/xNOaywFMJFCCAty7WV+
         dlhjRON0mh5mG7d9mUqqTQknbPfZZO/6njD/6mC5Qyl//IMvWAup7R58VDyNaermT6
         pUrbQ8XZg/6pA==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH 3/6] x86/idt: remove address argument to idt_invalidate()
Date:   Mon, 10 May 2021 17:55:28 -0700
Message-Id: <20210511005531.1065536-4-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511005531.1065536-1-hpa@zytor.com>
References: <20210511005531.1065536-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

There is no reason to specify any specific address to
idt_invalidate(). It looks mostly like an artifact of unifying code
done differently by accident.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/desc.h        | 2 +-
 arch/x86/kernel/idt.c              | 5 ++---
 arch/x86/kernel/machine_kexec_32.c | 4 ++--
 arch/x86/kernel/reboot.c           | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 476082a83d1c..b8429ae50b71 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -427,6 +427,6 @@ static inline void idt_setup_early_pf(void) { }
 static inline void idt_setup_ist_traps(void) { }
 #endif
 
-extern void idt_invalidate(void *addr);
+extern void idt_invalidate(void);
 
 #endif /* _ASM_X86_DESC_H */
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index d552f177eca0..17f824462f5e 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -331,11 +331,10 @@ void __init idt_setup_early_handler(void)
 
 /**
  * idt_invalidate - Invalidate interrupt descriptor table
- * @addr:	The virtual address of the 'invalid' IDT
  */
-void idt_invalidate(void *addr)
+void idt_invalidate(void)
 {
-	struct desc_ptr idt = { .address = (unsigned long) addr, .size = 0 };
+	struct desc_ptr idt = { .address = 0, .size = 0 };
 
 	load_idt(&idt);
 }
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 64b00b0d7fe8..6ba90f47d8c3 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -232,8 +232,8 @@ void machine_kexec(struct kimage *image)
 	 * The gdt & idt are now invalid.
 	 * If you want to load them you must set up your own idt & gdt.
 	 */
-	idt_invalidate(phys_to_virt(0));
-	set_gdt(phys_to_virt(0), 0);
+	idt_invalidate();
+	set_gdt(0, 0);
 
 	/* now call it */
 	image->start = relocate_kernel_ptr((unsigned long)image->head,
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index b29657b76e3f..ebfb91108232 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -669,7 +669,7 @@ static void native_machine_emergency_restart(void)
 			break;
 
 		case BOOT_TRIPLE:
-			idt_invalidate(NULL);
+			idt_invalidate();
 			__asm__ __volatile__("int3");
 
 			/* We're probably dead after this, but... */
-- 
2.31.1

