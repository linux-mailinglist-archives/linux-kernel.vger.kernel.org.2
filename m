Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3AF3814F9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhEOBpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:45:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38985 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234796AbhEOBpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:45:34 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14F1i7ak3212185
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 May 2021 18:44:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14F1i7ak3212185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621043056;
        bh=Fv2QZebBu0cB2A2tFYMv61TmrgL0THnLSibpPqynPjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ax1kIa+CQuhKdk64r/NGBr2YGyyWUm6QGTCeUyZl4yS6eQHcfqIjlANHjRjBVnyi+
         ZG16DaEo5WIBk3HB67SL23IrvwHFyd7bczpHRE5SMxN36F4PvMztRPBb7u6Xd6T/sV
         t1pIiTdCudD5ehdhm8bK1d/+c2ztzJp0dFnhOUKHcb2eSI5jHg2uvxzZjExT5iA91z
         k8yWcoyeekfbg8jQ0EUxz/jOreVzBDM+fANDSxJR4QL37+6ud3q1jRFTtR8qhnQJ19
         +1D5XIEDwFduMce2aizUDdlOS8OYUZAopNhhVbSILL4aD3MDBBWD2VycJV3pV6lWwl
         rEdx/DFg+eshw==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/9] x86/idt: remove address argument to idt_invalidate()
Date:   Fri, 14 May 2021 18:43:56 -0700
Message-Id: <20210515014400.2999028-5-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515014400.2999028-1-hpa@zytor.com>
References: <20210515014400.2999028-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

There is no reason to specify any specific address to
idt_invalidate(). It looks mostly like an artifact of unifying code
done differently by accident. The most "sensible" address to set here
is a NULL pointer - virtual address zero, just as a visual marker.

This also makes it possible to mark the struct desc_ptr in
idt_invalidate() as static const.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/desc.h        | 2 +-
 arch/x86/kernel/idt.c              | 5 ++---
 arch/x86/kernel/machine_kexec_32.c | 2 +-
 arch/x86/kernel/reboot.c           | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

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
index d552f177eca0..2779f5226dc2 100644
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
+	static const struct desc_ptr idt = { .address = 0, .size = 0 };
 
 	load_idt(&idt);
 }
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 64b00b0d7fe8..1e34feebcd5d 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -232,7 +232,7 @@ void machine_kexec(struct kimage *image)
 	 * The gdt & idt are now invalid.
 	 * If you want to load them you must set up your own idt & gdt.
 	 */
-	idt_invalidate(phys_to_virt(0));
+	idt_invalidate();
 	set_gdt(phys_to_virt(0), 0);
 
 	/* now call it */
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

