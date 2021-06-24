Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5A3B2BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhFXJ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhFXJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8BC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kwXPV8a9F+rakY2Kwk1PvsFauPS9AZC+y+2LMd8vV9c=; b=LW2SBhhpgFy2W25UfXWzahFWDD
        NaIaQwofopqJVWUpMvdrv0c/DjfnEYyTR9EYDz8f+eEQjXVIr3RTXUSv6CGHEP+5wRX/k6m/Gdpz/
        6Qx0hPxCiR0e5gkQ5wmOoyzhm50+IYPope/xutMaEzdBhW6uFh9B9nQXQIt4kv2IApZWycTp8+KhD
        YAjKV80UP57GbkTIq1YOTCCsG7Dnc/HR+OSJLSTegCXgT4JLxSe8LzO2h0xV6/QyLk3ZvqWSlMpEk
        dfB1Gwc0/urCt+H+pLNTPO4UL9sB0MNqj/oqGPR3wFdzjNbe0yTTbILqc+KiJoYAvIJtFXSKhuWea
        ZQAU4a3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM4J-00GQP4-8i; Thu, 24 Jun 2021 09:54:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A10DC3005C7;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1A9162BC05F3E; Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Message-ID: <20210624095148.687755639@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 17/24] x86/xen: Make set_debugreg() noinstr
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: pv_ops[2]: xen_set_debugreg
vmlinux.o: warning: objtool: pv_ops[2]: native_set_debugreg
vmlinux.o: warning: objtool: exc_debug()+0x3b: call to pv_ops[2]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h      |    2 +-
 arch/x86/include/asm/xen/hypercall.h |    2 +-
 arch/x86/kernel/paravirt.c           |    9 ++++++---
 arch/x86/xen/enlighten_pv.c          |    2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -118,7 +118,7 @@ static __always_inline unsigned long par
 	return PVOP_CALL1(unsigned long, cpu.get_debugreg, reg);
 }
 #define get_debugreg(var, reg) var = paravirt_get_debugreg(reg)
-static inline void set_debugreg(unsigned long val, int reg)
+static __always_inline void set_debugreg(unsigned long val, int reg)
 {
 	PVOP_VCALL2(cpu.set_debugreg, reg, val);
 }
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -308,7 +308,7 @@ HYPERVISOR_platform_op(struct xen_platfo
 	return _hypercall1(int, platform_op, op);
 }
 
-static inline int
+static __always_inline int
 HYPERVISOR_set_debugreg(int reg, unsigned long value)
 {
 	return _hypercall2(int, set_debugreg, reg, value);
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -253,6 +253,11 @@ static noinstr unsigned long pv_native_g
 	return native_get_debugreg(regno);
 }
 
+static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
+{
+	native_set_debugreg(regno, val);
+}
+
 struct paravirt_patch_template pv_ops = {
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
@@ -260,7 +265,7 @@ struct paravirt_patch_template pv_ops =
 #ifdef CONFIG_PARAVIRT_XXL
 	.cpu.cpuid		= native_cpuid,
 	.cpu.get_debugreg	= pv_native_get_debugreg,
-	.cpu.set_debugreg	= native_set_debugreg,
+	.cpu.set_debugreg	= pv_native_set_debugreg,
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
@@ -386,8 +391,6 @@ struct paravirt_patch_template pv_ops =
 };
 
 #ifdef CONFIG_PARAVIRT_XXL
-/* At this point, native_get/set_debugreg has real function entries */
-NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 
 void (*paravirt_iret)(void) = native_iret;
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -312,7 +312,7 @@ static void __init xen_init_capabilities
 	}
 }
 
-static void xen_set_debugreg(int reg, unsigned long val)
+static noinstr void xen_set_debugreg(int reg, unsigned long val)
 {
 	HYPERVISOR_set_debugreg(reg, val);
 }


