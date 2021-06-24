Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD853B2BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhFXJ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhFXJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3E8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zu4hWCv2hg8QcziEyTdXe6mB9O/jygKWqlWXGeKc0IE=; b=juuf1QIIEL7CRtDrfXZ4rCVxHv
        cQnwBIKiVY9mGrEixqWr6FItmzPtzYyiXm/Zjyf/muhXG3Km6/QR3oCmHKdLa3CDB3L51zuofp2+r
        Q4RI2xGf4/5jeSL+wJjNyjWIjeyYqg30XvBjL2YqGBBBJLUpXsefV0f9MGwiJYYf6h6AFSS54lUww
        jnAIuo4LV0Fk+kLmbNKl17M7ekUjTsFHG4nV8yU82lSYUdE9hr7bbq3Xj6gLslpW5zxkH9ImPgoHq
        QGTejezf25KAMBkUyr3Lobqvz3yS0eaV87dUPzPtfFgucZ7RkBoCgwb9/CWNDZG8puGlRXYjfsZFu
        61u3VObA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM42-00GQOc-2A; Thu, 24 Jun 2021 09:54:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FACC30059E;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CB1082BC05F35; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095148.188166492@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 09/24] x86: Always inline ip_within_syscall_gap()
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: vc_switch_off_ist()+0x20: call to ip_within_syscall_gap.isra.0() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/ptrace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -181,7 +181,7 @@ static inline bool any_64bit_mode(struct
 #define current_user_stack_pointer()	current_pt_regs()->sp
 #define compat_user_stack_pointer()	current_pt_regs()->sp
 
-static inline bool ip_within_syscall_gap(struct pt_regs *regs)
+static __always_inline bool ip_within_syscall_gap(struct pt_regs *regs)
 {
 	bool ret = (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
 		    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack);


