Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49113AE89C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUMFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFUMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:05:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A328DC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nmzdcEfDE7u/mj5fAucSf7noshay6FEjmz00GaDT+jk=; b=NY3s0To1zeaLts3h+rxYvFUgjW
        rVdBeZMm79u8jMLXhn1lhPmHCbO9mZkAN0P/R/xFQNS3/L2+/EoyfHN3VnlUxRNpIVj249s1wLMSu
        xj4bKqvOCA0Yu6yvZCjm/pbMUp19F5XbCjXvytIqnuAoPzrIcAiWD+3zehBIeinJROeF7R89XVbmc
        Bf2YX5hoW7vzt7dl78wevN7vUuTY2rLyvVEMacyeZdYZJCtjhiIiuM2Awu7P5asHp/PoLpqOiiiVV
        lKCNMB+ak9H0XS1AAxF1rmzPCPl8kWuiph0JvIReschBQQiG4lHhu3ChjR6swFy/gKPV6h0/j9vrs
        OurymV8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdP-00AEJd-CU; Mon, 21 Jun 2021 12:02:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A62C430059E;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1E22E235EE387; Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Message-ID: <20210621120121.127655715@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [RFC][PATCH 09/18] x86/xen: Make write_cr2() noinstr
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: pv_ops[42]: native_write_cr2
vmlinux.o: warning: objtool: pv_ops[42]: xen_write_cr2
vmlinux.o: warning: objtool: exc_nmi()+0x127: call to pv_ops[42]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h |    2 +-
 arch/x86/kernel/paravirt.c      |    7 ++++++-
 arch/x86/xen/mmu_pv.c           |    3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -140,7 +140,7 @@ static __always_inline unsigned long rea
 				ALT_NOT(X86_FEATURE_XENPV));
 }
 
-static inline void write_cr2(unsigned long x)
+static __always_inline void write_cr2(unsigned long x)
 {
 	PVOP_VCALL1(mmu.write_cr2, x);
 }
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -243,6 +243,11 @@ static noinstr unsigned long pv_native_r
 	return native_read_cr2();
 }
 
+static noinstr void pv_native_write_cr2(unsigned long val)
+{
+	native_write_cr2(val);
+}
+
 struct paravirt_patch_template pv_ops = {
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
@@ -304,7 +309,7 @@ struct paravirt_patch_template pv_ops =
 
 #ifdef CONFIG_PARAVIRT_XXL
 	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(pv_native_read_cr2),
-	.mmu.write_cr2		= native_write_cr2,
+	.mmu.write_cr2		= pv_native_write_cr2,
 	.mmu.read_cr3		= __native_read_cr3,
 	.mmu.write_cr3		= native_write_cr3,
 
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1204,7 +1204,8 @@ static void __init xen_pagetable_init(vo
 	xen_remap_memory();
 	xen_setup_mfn_list_list();
 }
-static void xen_write_cr2(unsigned long cr2)
+
+static noinstr void xen_write_cr2(unsigned long cr2)
 {
 	this_cpu_read(xen_vcpu)->arch.cr2 = cr2;
 }


