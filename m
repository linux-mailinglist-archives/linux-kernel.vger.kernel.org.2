Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ADB3B2BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhFXJ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhFXJ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:57:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=EbFMZZWvWFpevup/fMCVyZ2BaXHqDvhOUAoiXAhawbY=; b=mM0s+IhsyBQYNB1ub7FaCKHiw0
        RLDJ/kgj9dn0EhtmP49jS825ogphuzXV1y21AJsUTU3BvtxKSuFTdfTINarkn6gA3G0hfH6MWBk4p
        s7sjBbAhU+6n71i3pKgAmIVDi7do6Ux0bdwHk6kAKT3wIjZFiqAlk74H+epnX5jke9tgFNZessExG
        NqZ7ioqBURJotKx4Nx3uuMOMvGhlMf66PNnsx0BR6c/V7Kk/7hOKGiq4TONK9KSjze4vDz/KcYu99
        1tym58Fn4aSedfApLe69bVf+tKh9LKo5A6dL4uJ5/V4DaaYVucBeMa5rhT7+d89WAjo/lG6MzLqh3
        Q2zkSuOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM3v-00BCD6-Tj; Thu, 24 Jun 2021 09:54:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F9DC300327;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B164C2BC05F31; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095148.003928226@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 06/24] x86: Always inline context_tracking_guest_enter()
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it really did out-of-line this....

vmlinux.o: warning: objtool: vmx_vcpu_enter_exit()+0x31: call to context_tracking_guest_enter() leaves .noinstr.text section

000000000019f660 <context_tracking_guest_enter>:
  19f660:	e8 00 00 00 00       	callq  19f665 <context_tracking_guest_enter+0x5>	19f661: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
  19f665:	31 c0                	xor    %eax,%eax
  19f667:	c3                   	retq   

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/context_tracking.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -105,7 +105,7 @@ static inline void user_exit_irqoff(void
 static inline enum ctx_state exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
-static inline bool context_tracking_guest_enter(void) { return false; }
+static __always_inline bool context_tracking_guest_enter(void) { return false; }
 static inline void context_tracking_guest_exit(void) { }
 
 #endif /* !CONFIG_CONTEXT_TRACKING */


