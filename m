Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9FD3B2BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhFXJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhFXJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:57:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3536C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=uCq3zJkz80tiLncwwTSVCdorgTOoiaAOzQxN+mU1uow=; b=KzuvNU4/3thOfcVDqwUxYeY9Zk
        jnJl9D2AEfkaPOI+DaF7cU+0McUftqCHxauP2eBC9RAvDVxbCjEx4nahbHEnULq772LPpLH5ZehUb
        x5g/amuojPljV5k4NxpXYpMI0A+xbps6Pxs93sy+CQo8ajmBrBrY7WBviTurTfcIXsQ7mmwysfCRU
        qDeKPfRJZWm5vACZNJ+oTm1EVRC2SQoWbN7svX7h03PElIht1UxLoh9aW5vr6U1RJvUcUgV90yCgP
        Dhwbe6qnVSL56Ykr6RC1fRxiWRyVXFueuGNgqDr8lZDKgZAt08dE/qvSIi0kiKgMyGYoShDZXAzTG
        Uus3Zmxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM4C-00BCEK-GK; Thu, 24 Jun 2021 09:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A05833005C1;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 12AF12BC05F3D; Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Message-ID: <20210624095148.625523645@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 16/24] x86/xen: Make get_debugreg() noinstr
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: pv_ops[1]: xen_get_debugreg
vmlinux.o: warning: objtool: pv_ops[1]: native_get_debugreg
vmlinux.o: warning: objtool: exc_debug()+0x25: call to pv_ops[1]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h      |    2 +-
 arch/x86/include/asm/xen/hypercall.h |    2 +-
 arch/x86/kernel/paravirt.c           |    8 ++++++--
 arch/x86/xen/enlighten_pv.c          |    2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -113,7 +113,7 @@ static inline void __cpuid(unsigned int
 /*
  * These special macros can be used to get or set a debugging register
  */
-static inline unsigned long paravirt_get_debugreg(int reg)
+static __always_inline unsigned long paravirt_get_debugreg(int reg)
 {
 	return PVOP_CALL1(unsigned long, cpu.get_debugreg, reg);
 }
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -314,7 +314,7 @@ HYPERVISOR_set_debugreg(int reg, unsigne
 	return _hypercall2(int, set_debugreg, reg, value);
 }
 
-static inline unsigned long
+static __always_inline unsigned long
 HYPERVISOR_get_debugreg(int reg)
 {
 	return _hypercall1(unsigned long, get_debugreg, reg);
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -248,13 +248,18 @@ static noinstr void pv_native_write_cr2(
 	native_write_cr2(val);
 }
 
+static noinstr unsigned long pv_native_get_debugreg(int regno)
+{
+	return native_get_debugreg(regno);
+}
+
 struct paravirt_patch_template pv_ops = {
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
 
 #ifdef CONFIG_PARAVIRT_XXL
 	.cpu.cpuid		= native_cpuid,
-	.cpu.get_debugreg	= native_get_debugreg,
+	.cpu.get_debugreg	= pv_native_get_debugreg,
 	.cpu.set_debugreg	= native_set_debugreg,
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
@@ -382,7 +387,6 @@ struct paravirt_patch_template pv_ops =
 
 #ifdef CONFIG_PARAVIRT_XXL
 /* At this point, native_get/set_debugreg has real function entries */
-NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -317,7 +317,7 @@ static void xen_set_debugreg(int reg, un
 	HYPERVISOR_set_debugreg(reg, val);
 }
 
-static unsigned long xen_get_debugreg(int reg)
+static noinstr unsigned long xen_get_debugreg(int reg)
 {
 	return HYPERVISOR_get_debugreg(reg);
 }


