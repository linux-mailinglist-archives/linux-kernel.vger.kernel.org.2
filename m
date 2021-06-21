Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB80C3AE8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFUMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhFUMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZEj2cK1Nv+ZnZXR9WZKDpl6uYUwS6wUGgqQXzMal1CU=; b=qtscN9u2p8E9WTQdvTKdxZp3rW
        qoHcQ5nWcf22ZJxuLtE97yLpFYqOYszvdsJ9FflbPRLFCt+qBddHgxxI8C+Zk01uhQ5FdT4f9+TQu
        HoFqOw1OCne1g+DHaAEwaMNFELd3n/D8qwlf7PkksgZjLGj9X9OO4dgE5EjeHYEVOF9FvPaHd7kAf
        YlVyXdqeUZ5Bc0i+S7cebHg5qJtNDTg5LJ0qfZEClYgndt8xowQkTQZmF7sb4VWtduGqBK6ZMrQ18
        dExo8jT2EufwsJs9LOB9W6W1NBKIkcwYke0nZdBiKbN5Bm4MssWZBxS34IvaEdakMf7v5kDwuGzxP
        GwtqtcNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdW-00D3hw-4R; Mon, 21 Jun 2021 12:02:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6294300325;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 071D9235EE384; Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Message-ID: <20210621120120.863523024@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [RFC][PATCH 06/18] x86/paravirt: Mark arch_local_irq_*() __always_inline
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: lockdep_hardirqs_on()+0x72: call to arch_local_save_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: lockdep_hardirqs_off()+0x73: call to arch_local_save_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: match_held_lock()+0x11f: call to arch_local_save_flags() leaves .noinstr.text section

vmlinux.o: warning: objtool: lock_is_held_type()+0x4e: call to arch_local_irq_save() leaves .noinstr.text section

vmlinux.o: warning: objtool: lock_is_held_type()+0x65: call to arch_local_irq_disable() leaves .noinstr.text section

vmlinux.o: warning: objtool: lock_is_held_type()+0xfe: call to arch_local_irq_enable() leaves .noinstr.text section

It makes no sense to not inline these things.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -681,23 +681,23 @@ bool __raw_callee_save___native_vcpu_is_
 	((struct paravirt_callee_save) { func })
 
 #ifdef CONFIG_PARAVIRT_XXL
-static inline notrace unsigned long arch_local_save_flags(void)
+static __always_inline unsigned long arch_local_save_flags(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax;",
 				ALT_NOT(X86_FEATURE_XENPV));
 }
 
-static inline notrace void arch_local_irq_disable(void)
+static __always_inline void arch_local_irq_disable(void)
 {
 	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT(X86_FEATURE_XENPV));
 }
 
-static inline notrace void arch_local_irq_enable(void)
+static __always_inline void arch_local_irq_enable(void)
 {
 	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT(X86_FEATURE_XENPV));
 }
 
-static inline notrace unsigned long arch_local_irq_save(void)
+static __always_inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long f;
 


