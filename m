Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A350C3153B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhBIQT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhBIQTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:19:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FYsM1K6OwYju0VC35C+1ECBzo2gy1/ASpk1pAe2+ysE=; b=2JShNvNyVYY/tWDr5BkNCrwlr3
        h4sk465V3vn8MJoce+GVrKcaW/bZ5ZNliKMAwpjuxaeaTE0PFkz22aDuKreQimOaZd98DlOkMad8U
        adwjsqrGLnoPLgd3OPoUxvnlMcG348/qVGSCsdGdL1D8MHCV9F6/6/PpHQ/WycJhEpvOGS88zBPLG
        0l8GMtfOOOclzaqpqnCxcX8hxtJC7ejgJwm2+xaznGqdnM43KMtfU3E2pQH8v32Wgsm16mUY2MP1w
        bAQpbQYQ+qzpEE+p/YA+JkzIDPTjlJcV17vMKDgz8caSzf+N1BvxR/u0VIZwpoUEwncskfumNbY2k
        lZV2ORFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9VjF-0006NC-L8; Tue, 09 Feb 2021 16:19:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C96F3012DF;
        Tue,  9 Feb 2021 17:19:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68FB12010B6C7; Tue,  9 Feb 2021 17:19:04 +0100 (CET)
Date:   Tue, 9 Feb 2021 17:19:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] preempt: select PREEMPT_DYNAMIC under PREEMPTION instead
 of PREEMPT
Message-ID: <YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net>
References: <7d129a84b0858fd7fbc3e38ede62a848fbec536e.camel@gmx.de>
 <YCKmhnoSKgdYqxOL@hirez.programming.kicks-ass.net>
 <269ee10aac93d819e48dc81f09a01d01fcd44fb1.camel@gmx.de>
 <YCK0m8FD9kp8QZWJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCK0m8FD9kp8QZWJ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:13:15PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 09, 2021 at 05:05:14PM +0100, Mike Galbraith wrote:
> 
> > ld: init/main.o: in function `trace_initcall_start':
> > /backup/usr/local/src/kernel/linux-tip-rt/./include/trace/events/initcall.h:27: undefined reference to `__SCT__preempt_schedule_notrace'
> 
> Ooohh... this is because x86 can't build PREEMPT without PREEMPT_DYNAMIC
> anymore. Maybe I should fix that. Lemme see what that would take.

Does this work?

---
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 0aa96f824af1..f8cb8af4de5c 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -110,6 +110,13 @@ extern asmlinkage void preempt_schedule_thunk(void);
 
 #define __preempt_schedule_func preempt_schedule_thunk
 
+extern asmlinkage void preempt_schedule_notrace(void);
+extern asmlinkage void preempt_schedule_notrace_thunk(void);
+
+#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
 DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
 
 #define __preempt_schedule() \
@@ -118,11 +125,6 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
-extern asmlinkage void preempt_schedule_notrace(void);
-extern asmlinkage void preempt_schedule_notrace_thunk(void);
-
-#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
-
 DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 
 #define __preempt_schedule_notrace() \
@@ -131,6 +133,16 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
-#endif
+#else /* PREEMPT_DYNAMIC */
+
+#define __preempt_schedule() \
+	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT);
+
+#define __preempt_schedule_notrace() \
+	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAINT);
+
+#endif /* PREEMPT_DYNAMIC */
+
+#endif /* PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
