Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1393F28CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhHTJEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhHTJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:04:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E2BC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CxUGrUZTvuoDKM5YjVP9F1+8ZkThlJFwg0X1ebAnnWA=; b=GedgTEI6eJNzA4pGqX5ILTuYEX
        cKpoTO7CTroXGpNM8aKDGUWA3l8GO9UHNB9mQC7KUgLeCa9OLT36qBxFMJEe00llRmUBwhYXEuDc8
        Tjpo1le2S6P6dqkxmI2wxeKzV2x9obm4+0ardggW7X/zqsvuTKit7S8EGYG+PdDfdqMGyOQ7DFmlb
        BI5lF6M/Ejx4/iJRVqC68RAZ3GRCzrLlbCg6m8jc77dvPuUQdlRcT0on0HdBojXU8QMHd8/5US34f
        uLAA3bxz15nQaf9zBPqkX3PwHeDFLme/TOvLotWlMZUHUQkXnbsRJ2tLJANhNoxTq9efl9jaepuQY
        KH+sl64A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mH0QY-00BNgq-QQ; Fri, 20 Aug 2021 09:03:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A909C300332;
        Fri, 20 Aug 2021 11:03:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98B42201343D5; Fri, 20 Aug 2021 11:03:00 +0200 (CEST)
Date:   Fri, 20 Aug 2021 11:03:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>, keescook@chromium.org
Subject: Re: [PATCH] mm/rmap: Convert from atomic_t to refcount_t on
 anon_vma->refcount
Message-ID: <YR9vxHlSFalryHi0@hirez.programming.kicks-ass.net>
References: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
 <20210819132131.GA15779@willie-the-truck>
 <YR5ldaQvAnCKMnkk@hirez.programming.kicks-ass.net>
 <YR52igt/lJ7gQqOG@hirez.programming.kicks-ass.net>
 <CAHk-=wh_vEzmYnMufOa=03WAU=DRM5+n6uZy=dVtJERFJm3Q-Q@mail.gmail.com>
 <YR9PHD+pWTelGKVd@hirez.programming.kicks-ass.net>
 <YR9k0hzMJpNF/0qL@hirez.programming.kicks-ass.net>
 <20210820082457.GA16784@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820082457.GA16784@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 09:24:58AM +0100, Will Deacon wrote:

> > gcc-10.2.1, x86_64-defconfig
> > 
> > kernel/event/core.o-inline-ud1:     96454
> > kernel/event/core.o-outofline-ud1:  96604
> > kernel/event/core.o-outofline-call: 97072

    kernel/event/core.o-outofline-saturate-ud2: 96954
    kernel/event/core.o:                97248

> Is that with the saturation moved to the UD handler as well? 

Yep, that's the full function call replaced with an exception.

> I think it would be good to keep that as close to the point at which
> we detect the problem as we can, so perhaps we can inline that part
> and leave the diagnostics to the exception handler?

That's simpler execption code too, we can abuse the existing WARN/UD2
stuff.

---
 arch/x86/include/asm/refcount.h | 31 +++++++++++++++++++++++++++++++
 include/asm-generic/bug.h       |  4 ++++
 include/linux/refcount.h        | 15 +++++++++++----
 lib/bug.c                       | 13 ++++++++++++-
 lib/refcount.c                  |  7 ++-----
 5 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
new file mode 100644
index 000000000000..bed52b95d24c
--- /dev/null
+++ b/arch/x86/include/asm/refcount.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_REFCOUNT_H
+#define _ASM_X86_REFCOUNT_H
+
+#define refcount_warn_saturate refcount_warn_saturate
+static __always_inline void refcount_warn_saturate(refcount_t *r, const enum refcount_saturation_type t)
+{
+	refcount_set(r, REFCOUNT_SATURATED);
+	__WARN_FLAGS(BUGFLAG_ONCE|BUGFLAG_REFCOUNT|BUGFLAG_REFCOUNT_TYPE(t));
+}
+
+#define refcount_dec_and_test refcount_dec_and_test
+static inline bool refcount_dec_and_test(refcount_t *r)
+{
+	asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
+			   "jz %l[cc_zero]\n\t"
+			   "jl %l[cc_error]"
+			   : : [var] "m" (r->refs.counter)
+			   : "memory" : cc_zero, cc_error);
+
+	return false;
+
+cc_zero:
+	return true;
+
+cc_error:
+	refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
+	return false;
+}
+
+#endif /* _ASM_X86_REFCOUNT_H */
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index edb0e2a602a8..9937c70138b8 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -13,6 +13,10 @@
 #define BUGFLAG_ONCE		(1 << 1)
 #define BUGFLAG_DONE		(1 << 2)
 #define BUGFLAG_NO_CUT_HERE	(1 << 3)	/* CUT_HERE already sent */
+
+#define BUGFLAG_REFCOUNT	(1 << 4)
+#define BUGFLAG_REFCOUNT_TYPE(x)((x&3) << 5)
+
 #define BUGFLAG_TAINT(taint)	((taint) << 8)
 #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
 #endif
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b8a6e387f8f9..7db2b024a75d 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -117,14 +117,13 @@ typedef struct refcount_struct {
 #define REFCOUNT_SATURATED	(INT_MIN / 2)
 
 enum refcount_saturation_type {
-	REFCOUNT_ADD_NOT_ZERO_OVF,
-	REFCOUNT_ADD_OVF,
+	REFCOUNT_ADD_OVF = 0,
 	REFCOUNT_ADD_UAF,
 	REFCOUNT_SUB_UAF,
 	REFCOUNT_DEC_LEAK,
 };
 
-void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
+extern void __refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
 
 /**
  * refcount_set - set a refcount's value
@@ -136,6 +135,12 @@ static inline void refcount_set(refcount_t *r, int n)
 	atomic_set(&r->refs, n);
 }
 
+#include <asm/refcount.h>
+
+#ifndef refcount_warn_saturate
+#define refcount_warn_saturate __refcount_warn_saturate
+#endif
+
 /**
  * refcount_read - get a refcount's value
  * @r: the refcount
@@ -160,7 +165,7 @@ static inline __must_check bool __refcount_add_not_zero(int i, refcount_t *r, in
 		*oldp = old;
 
 	if (unlikely(old < 0 || old + i < 0))
-		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
+		refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
 
 	return old;
 }
@@ -328,10 +333,12 @@ static inline __must_check bool __refcount_dec_and_test(refcount_t *r, int *oldp
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
+#ifndef refcount_dec_and_test
 static inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
 	return __refcount_dec_and_test(r, NULL);
 }
+#endif
 
 static inline void __refcount_dec(refcount_t *r, int *oldp)
 {
diff --git a/lib/bug.c b/lib/bug.c
index 45a0584f6541..3878df956143 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -154,11 +154,18 @@ struct bug_entry *find_bug(unsigned long bugaddr)
 	return module_find_bug(bugaddr);
 }
 
+static const char *refstr[] = {
+	"refcount_t: saturated; leaking memory",
+	"refcount_t: addition on 0; use-after-free",
+	"refcount_t: underflow; use-after-free",
+	"refcount_t: decrement hit 0; leaking memory",
+};
+
 enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 {
+	unsigned line, warning, once, done, refcount;
 	struct bug_entry *bug;
 	const char *file;
-	unsigned line, warning, once, done;
 
 	if (!is_valid_bugaddr(bugaddr))
 		return BUG_TRAP_TYPE_NONE;
@@ -174,6 +181,7 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	warning = (bug->flags & BUGFLAG_WARNING) != 0;
 	once = (bug->flags & BUGFLAG_ONCE) != 0;
 	done = (bug->flags & BUGFLAG_DONE) != 0;
+	refcount = (bug->flags & BUGFLAG_REFCOUNT) != 0;
 
 	if (warning && once) {
 		if (done)
@@ -195,6 +203,9 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		printk(KERN_DEFAULT CUT_HERE);
 
 	if (warning) {
+		if (refcount)
+			pr_warn("%s\n", refstr[(bug->flags >> 5) & 3]);
+
 		/* this is a WARN_ON rather than BUG/BUG_ON */
 		__warn(file, line, (void *)bugaddr, BUG_GET_TAINT(bug), regs,
 		       NULL);
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..a36da0611f25 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -10,14 +10,11 @@
 
 #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
 
-void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
+void __refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
 {
 	refcount_set(r, REFCOUNT_SATURATED);
 
 	switch (t) {
-	case REFCOUNT_ADD_NOT_ZERO_OVF:
-		REFCOUNT_WARN("saturated; leaking memory");
-		break;
 	case REFCOUNT_ADD_OVF:
 		REFCOUNT_WARN("saturated; leaking memory");
 		break;
@@ -34,7 +31,7 @@ void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
 		REFCOUNT_WARN("unknown saturation event!?");
 	}
 }
-EXPORT_SYMBOL(refcount_warn_saturate);
+EXPORT_SYMBOL(__refcount_warn_saturate);
 
 /**
  * refcount_dec_if_one - decrement a refcount if it is 1
