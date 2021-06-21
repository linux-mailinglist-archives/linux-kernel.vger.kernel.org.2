Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4717D3AE8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFUMGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhFUMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE3C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=sVr5G4z8tBtZuuo2qiQ64mKMm0yfEnp8cM5a7uGz4+k=; b=BpuEKLdl5WdFBsuXK5c8DUyQNA
        Xu81UgwXRZJOXfjynYWJEUwjvhziOgWvfQR+T8VI3GjhsCJpEJnNJy17tudyTQ3v3+3HyPv5qc0z/
        qqenp00XLC/ExdE4b2T6deMpnZmvYhv1HHGvbtBrtygyFIK099AQVctzYZU5OUu0n4bfw8JfYhWbs
        uQFAzelXjDthOMUDjcD+nX6OwLer9eD2xkTKj6077I3brBvP6IB8LzNRzZvcnfTiFdGiD+FQvekCc
        Y2k796ElAFfygyIED/8C/6W020jpq6wcgvAeBqgmtxfHkLaF4Cal8zeWzI6ZrmcMLwye3kzaVx8Lf
        kSiuDzww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdW-00D3hx-Ps; Mon, 21 Jun 2021 12:02:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A62FD3005A3;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 17B77235EE386; Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Message-ID: <20210621120121.048244731@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [RFC][PATCH 08/18] x86/xen: Make read_cr2() noinstr
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: pv_ops[41]: native_read_cr2
vmlinux.o: warning: objtool: pv_ops[41]: xen_read_cr2
vmlinux.o: warning: objtool: pv_ops[41]: xen_read_cr2_direct
vmlinux.o: warning: objtool: exc_double_fault()+0x15: call to pv_ops[41]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h |    2 +-
 arch/x86/kernel/paravirt.c      |    7 ++++++-
 arch/x86/xen/xen-asm.S          |    2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -133,7 +133,7 @@ static inline void write_cr0(unsigned lo
 	PVOP_VCALL1(cpu.write_cr0, x);
 }
 
-static inline unsigned long read_cr2(void)
+static __always_inline unsigned long read_cr2(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
 				"mov %%cr2, %%rax;",
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -238,6 +238,11 @@ struct pv_info pv_info = {
 /* 64-bit pagetable entries */
 #define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_64)
 
+static noinstr unsigned long pv_native_read_cr2(void)
+{
+	return native_read_cr2();
+}
+
 struct paravirt_patch_template pv_ops = {
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
@@ -298,7 +303,7 @@ struct paravirt_patch_template pv_ops =
 	.mmu.exit_mmap		= paravirt_nop,
 
 #ifdef CONFIG_PARAVIRT_XXL
-	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(native_read_cr2),
+	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(pv_native_read_cr2),
 	.mmu.write_cr2		= native_write_cr2,
 	.mmu.read_cr3		= __native_read_cr3,
 	.mmu.write_cr3		= native_write_cr3,
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -102,6 +102,7 @@ SYM_FUNC_START(check_events)
 	ret
 SYM_FUNC_END(check_events)
 
+.pushsection .noinstr.text, "ax"
 SYM_FUNC_START(xen_read_cr2)
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
@@ -116,6 +117,7 @@ SYM_FUNC_START(xen_read_cr2_direct)
 	FRAME_END
 	ret
 SYM_FUNC_END(xen_read_cr2_direct);
+.popsection
 
 .macro xen_pv_trap name
 SYM_CODE_START(xen_\name)


