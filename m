Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CBE3B2BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhFXJ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhFXJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1CCC061760
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nmzdcEfDE7u/mj5fAucSf7noshay6FEjmz00GaDT+jk=; b=qrNcFRdT293k5qxx+n+Cl072XF
        rdc74NwyH8P5+lOskfdfrTmXdYtnTBXC+Y84hDZ8XyEhvyhcw637TmOuzwtDLaX4UUiQWgpOubAhu
        PnwDDz3HPWZZG09r/41lOdeJq2dJGs1kAPNQGrLZH3aCWI+imRoLGDlr4STCqwPnDoIOmZA92hos9
        +SD+3qW1NNJvMFVHWt3tmIUU0JPESAYS4oQHMOqRZ5aGa9X+6Vt0dvEErMTQCI1JVsqE3GVrZQtKx
        BoFSVM7vuaxU0i5s7WpIKZZCw0PbpXRoy0ILPgMDr98BNSfjaMs1QIk5u3i8RwDEQtNYVvBhxcmuQ
        WzptW+ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM43-00GQOg-AL; Thu, 24 Jun 2021 09:54:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A01D13005BA;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0B1892BC05F3C; Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Message-ID: <20210624095148.563524913@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 15/24] x86/xen: Make write_cr2() noinstr
References: <20210624094059.886075998@infradead.org>
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


