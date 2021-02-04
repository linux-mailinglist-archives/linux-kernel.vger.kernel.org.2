Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2922531020F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhBEBEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:04:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhBEA7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:59:15 -0500
Message-Id: <20210204211155.214169844@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612486682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SLbWzbzNq9ppfvWEP7ZcRxRy5GM85KbAuBPrLxcZJHI=;
        b=tiwsb44OOnz+HnVJ+etefFPGA4faSXc7KfIf+P2Urtfn2dfDFWYGBEd6RTpKnPwjDFqZB3
        TWkQJEtqll24PPvTgdYwvZKSr0B7YJtUTb4RA23xWWLET7fy0gbamd2uhJVKjt3mxustjn
        qU9qfUzCzNzF6W3fr21XoRuhNswUpj7GiIbdBt9m9VtEKJHB0XtJM5UbamCERB7Tn14qlh
        hJ4bZWZFE155ICzGVe1vOpMuG9s/G0X542a2jN/nWi9CsGSSSt6rcfwoog17auQwCuiSsQ
        lt+WCB5MnK6MeTiJlHeUAKSuS5gBgcnaU5z9tib99xcWcEO/9l+Kf66whi98zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612486682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SLbWzbzNq9ppfvWEP7ZcRxRy5GM85KbAuBPrLxcZJHI=;
        b=YDEztwzslGPRU5xVVjEbCe6AU7mnPSoj2oZR792Na26UXTHaB7HZ+PH4uSgONQduiKhjTX
        +KxOA525WwUTzXDQ==
Date:   Thu, 04 Feb 2021 21:49:14 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 11/12] softirq: Allow inlining do_softirq_own_stack()
References: <20210204204903.350275743@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function to switch to the irq stack on x86 is now minimal and there is
only a single caller. Allow the stack switch to be inlined.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |    2 ++
 kernel/softirq.c          |    4 ++++
 2 files changed, 6 insertions(+)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -570,7 +570,9 @@ asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
 #ifdef __ARCH_HAS_DO_SOFTIRQ
+# ifndef __ARCH_HAS_DO_SOFTIRQ_INLINE
 void do_softirq_own_stack(void);
+# endif
 #else
 static inline void do_softirq_own_stack(void)
 {
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -26,6 +26,10 @@
 #include <linux/tick.h>
 #include <linux/irq.h>
 
+#ifdef __ARCH_HAS_DO_SOFTIRQ_INLINE
+# include <asm/irq_stack.h>
+#endif
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
 

