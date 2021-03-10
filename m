Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6537A3338E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhCJJgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhCJJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:35:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59600C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fS92/SayxYcq9t1xajK4FEyusnePWvjmyVY072Js2Zo=; b=biSaWX8FhBHebgcrj1iFgvmaaz
        Cx2McIGZ+GQPrRhLnLXovWygwXKwowJmT1rkJ3XhJ5ca6i5wbYdcCIYrgU4nEwFqHhjEpeE6TqEzY
        jzi0P/DEqSteKdn5EhBpQJOwxne+OH9gEFogTeK0J5vKI6j+RDlaqAa3q7eXB8FvM+oaWHTzr9jd4
        UPGglrkT9YGkkR2e+lr8lqj7C9lZVmzI4IB7fYsxGN/SkSGI9bql/238NFvdtjMj9nkMb6nTFkqIm
        eViD/4vLDO09DrSg752ZY/UaXKafJ/xJXQi3UbttW5oqqOdrwmuXk4t0emrE77nRvmPiBvjBO0nQh
        s4sLCEBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJvFq-0031sP-Tq; Wed, 10 Mar 2021 09:35:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDEDF300455;
        Wed, 10 Mar 2021 10:35:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 885382B7F3E97; Wed, 10 Mar 2021 10:35:45 +0100 (CET)
Date:   Wed, 10 Mar 2021 10:35:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: The killing of ideal_nops[]
Message-ID: <YEiS8Xws0tTFmMJp@hirez.programming.kicks-ass.net>
References: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
 <20210309120519.7c6bbb97@gandalf.local.home>
 <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
 <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com>
 <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:14:35AM +0100, Peter Zijlstra wrote:
> Sure, but we can have one set on 32bit and another set on 64bit.

> Although I would use DS prefix nops for 32bit nop5/nop8 to keep them
> single instructions.
> 
> Then we can do away with runtime nop selection and special atomic nops
> and simplify things.
> 
> All this runtime faffing about nops is tedious and causes complications
> we can do without.

Something like so, except I think there's more cleanups possible.

(*completely* untested)

---
 arch/x86/include/asm/nops.h    | 176 ++++++++++++------------------------
 arch/x86/kernel/alternative.c  | 199 +++++------------------------------------
 arch/x86/kernel/ftrace.c       |   4 +-
 arch/x86/kernel/jump_label.c   |  21 +----
 arch/x86/kernel/kprobes/core.c |   2 +-
 arch/x86/kernel/setup.c        |   1 -
 arch/x86/kernel/static_call.c  |   4 +-
 arch/x86/net/bpf_jit_comp.c    |   8 +-
 8 files changed, 88 insertions(+), 327 deletions(-)

diff --git a/arch/x86/include/asm/nops.h b/arch/x86/include/asm/nops.h
index 12f12b5cf2ca..aec7b092d3dc 100644
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -4,89 +4,58 @@
 
 /*
  * Define nops for use with alternative() and for tracing.
- *
- * *_NOP5_ATOMIC must be a single instruction.
  */
 
-#define NOP_DS_PREFIX 0x3e
+#ifndef CONFIG_64BIT
 
-/* generic versions from gas
-   1: nop
-   the following instructions are NOT nops in 64-bit mode,
-   for 64-bit mode use K8 or P6 nops instead
-   2: movl %esi,%esi
-   3: leal 0x00(%esi),%esi
-   4: leal 0x00(,%esi,1),%esi
-   6: leal 0x00000000(%esi),%esi
-   7: leal 0x00000000(,%esi,1),%esi
-*/
-#define GENERIC_NOP1 0x90
-#define GENERIC_NOP2 0x89,0xf6
-#define GENERIC_NOP3 0x8d,0x76,0x00
-#define GENERIC_NOP4 0x8d,0x74,0x26,0x00
-#define GENERIC_NOP5 GENERIC_NOP1,GENERIC_NOP4
-#define GENERIC_NOP6 0x8d,0xb6,0x00,0x00,0x00,0x00
-#define GENERIC_NOP7 0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
-#define GENERIC_NOP8 GENERIC_NOP1,GENERIC_NOP7
-#define GENERIC_NOP5_ATOMIC NOP_DS_PREFIX,GENERIC_NOP4
+/*
+ * Generic 32bit nops from GAS:
+ *
+ * 1: nop
+ * 2: movl %esi,%esi
+ * 3: leal 0x00(%esi),%esi
+ * 4: leal 0x00(,%esi,1),%esi
+ * 5: leal %ds:0x00(,%esi,1),%esi
+ * 6: leal 0x00000000(%esi),%esi
+ * 7: leal 0x00000000(,%esi,1),%esi
+ * 8: leal %ds:0x00000000(,%esi,1),%esi
+ *
+ * Except 5 and 8, which are DS prefixed 4 and 7 resp, where GAS would emit 2
+ * nop instructions.
+ */
+#define BYTES_NOP1	0x90
+#define BYTES_NOP2	0x89,0xf6
+#define BYTES_NOP3	0x8d,0x76,0x00
+#define BYTES_NOP4	0x8d,0x74,0x26,0x00
+#define BYTES_NOP5	0x3e,BYTES_NOP4
+#define BYTES_NOP6	0x8d,0xb6,0x00,0x00,0x00,0x00
+#define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
+#define BYTES_NOP8	0x3e,BYTES_NOP7
 
-/* Opteron 64bit nops
-   1: nop
-   2: osp nop
-   3: osp osp nop
-   4: osp osp osp nop
-*/
-#define K8_NOP1 GENERIC_NOP1
-#define K8_NOP2	0x66,K8_NOP1
-#define K8_NOP3	0x66,K8_NOP2
-#define K8_NOP4	0x66,K8_NOP3
-#define K8_NOP5	K8_NOP3,K8_NOP2
-#define K8_NOP6	K8_NOP3,K8_NOP3
-#define K8_NOP7	K8_NOP4,K8_NOP3
-#define K8_NOP8	K8_NOP4,K8_NOP4
-#define K8_NOP5_ATOMIC 0x66,K8_NOP4
+#else
 
-/* K7 nops
-   uses eax dependencies (arbitrary choice)
-   1: nop
-   2: movl %eax,%eax
-   3: leal (,%eax,1),%eax
-   4: leal 0x00(,%eax,1),%eax
-   6: leal 0x00000000(%eax),%eax
-   7: leal 0x00000000(,%eax,1),%eax
-*/
-#define K7_NOP1	GENERIC_NOP1
-#define K7_NOP2	0x8b,0xc0
-#define K7_NOP3	0x8d,0x04,0x20
-#define K7_NOP4	0x8d,0x44,0x20,0x00
-#define K7_NOP5	K7_NOP4,K7_NOP1
-#define K7_NOP6	0x8d,0x80,0,0,0,0
-#define K7_NOP7	0x8D,0x04,0x05,0,0,0,0
-#define K7_NOP8	K7_NOP7,K7_NOP1
-#define K7_NOP5_ATOMIC NOP_DS_PREFIX,K7_NOP4
+/*
+ * Generic 64bit nops from GAS:
+ *
+ * 1: nop
+ * 2: osp nop
+ * 3: nopl (%eax)
+ * 4: nopl 0x00(%eax)
+ * 5: nopl 0x00(%eax,%eax,1)
+ * 6: osp nopl 0x00(%eax,%eax,1)
+ * 7: nopl 0x00000000(%eax)
+ * 8: nopl 0x00000000(%eax,%eax,1)
+ */
+#define BYTES_NOP1	0x90
+#define BYTES_NOP2	0x66,0x90
+#define BYTES_NOP3	0x0f,0x1f,0x00
+#define BYTES_NOP4	0x0f,0x1f,0x40,0
+#define BYTES_NOP5	0x0f,0x1f,0x44,0x00,0
+#define BYTES_NOP6	0x66,0x0f,0x1f,0x44,0x00,0
+#define BYTES_NOP7	0x0f,0x1f,0x80,0,0,0,0
+#define BYTES_NOP8	0x0f,0x1f,0x84,0x00,0,0,0,0
 
-/* P6 nops
-   uses eax dependencies (Intel-recommended choice)
-   1: nop
-   2: osp nop
-   3: nopl (%eax)
-   4: nopl 0x00(%eax)
-   5: nopl 0x00(%eax,%eax,1)
-   6: osp nopl 0x00(%eax,%eax,1)
-   7: nopl 0x00000000(%eax)
-   8: nopl 0x00000000(%eax,%eax,1)
-   Note: All the above are assumed to be a single instruction.
-	There is kernel code that depends on this.
-*/
-#define P6_NOP1	GENERIC_NOP1
-#define P6_NOP2	0x66,0x90
-#define P6_NOP3	0x0f,0x1f,0x00
-#define P6_NOP4	0x0f,0x1f,0x40,0
-#define P6_NOP5	0x0f,0x1f,0x44,0x00,0
-#define P6_NOP6	0x66,0x0f,0x1f,0x44,0x00,0
-#define P6_NOP7	0x0f,0x1f,0x80,0,0,0,0
-#define P6_NOP8	0x0f,0x1f,0x84,0x00,0,0,0,0
-#define P6_NOP5_ATOMIC P6_NOP5
+#endif /* CONFIG_64BIT */
 
 #ifdef __ASSEMBLY__
 #define _ASM_MK_NOP(x) .byte x
@@ -94,54 +63,19 @@
 #define _ASM_MK_NOP(x) ".byte " __stringify(x) "\n"
 #endif
 
-#if defined(CONFIG_MK7)
-#define ASM_NOP1 _ASM_MK_NOP(K7_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(K7_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(K7_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(K7_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(K7_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(K7_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(K7_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(K7_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(K7_NOP5_ATOMIC)
-#elif defined(CONFIG_X86_P6_NOP)
-#define ASM_NOP1 _ASM_MK_NOP(P6_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(P6_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(P6_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(P6_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(P6_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(P6_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(P6_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(P6_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(P6_NOP5_ATOMIC)
-#elif defined(CONFIG_X86_64)
-#define ASM_NOP1 _ASM_MK_NOP(K8_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(K8_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(K8_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(K8_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(K8_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(K8_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(K8_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(K8_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(K8_NOP5_ATOMIC)
-#else
-#define ASM_NOP1 _ASM_MK_NOP(GENERIC_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(GENERIC_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(GENERIC_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(GENERIC_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(GENERIC_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(GENERIC_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(GENERIC_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(GENERIC_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(GENERIC_NOP5_ATOMIC)
-#endif
+#define ASM_NOP1 _ASM_MK_NOP(BYTES_NOP1)
+#define ASM_NOP2 _ASM_MK_NOP(BYTES_NOP2)
+#define ASM_NOP3 _ASM_MK_NOP(BYTES_NOP3)
+#define ASM_NOP4 _ASM_MK_NOP(BYTES_NOP4)
+#define ASM_NOP5 _ASM_MK_NOP(BYTES_NOP5)
+#define ASM_NOP6 _ASM_MK_NOP(BYTES_NOP6)
+#define ASM_NOP7 _ASM_MK_NOP(BYTES_NOP7)
+#define ASM_NOP8 _ASM_MK_NOP(BYTES_NOP8)
 
 #define ASM_NOP_MAX 8
-#define NOP_ATOMIC5 (ASM_NOP_MAX+1)	/* Entry for the 5-byte atomic NOP */
 
 #ifndef __ASSEMBLY__
-extern const unsigned char * const *ideal_nops;
-extern void arch_init_ideal_nops(void);
+extern const unsigned char * const *x86_nops;
 #endif
 
 #endif /* _ASM_X86_NOPS_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 94649f86d653..7667ec9aa7eb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -74,186 +74,31 @@ do {									\
 	}								\
 } while (0)
 
-/*
- * Each GENERIC_NOPX is of X bytes, and defined as an array of bytes
- * that correspond to that nop. Getting from one nop to the next, we
- * add to the array the offset that is equal to the sum of all sizes of
- * nops preceding the one we are after.
- *
- * Note: The GENERIC_NOP5_ATOMIC is at the end, as it breaks the
- * nice symmetry of sizes of the previous nops.
- */
-#if defined(GENERIC_NOP1) && !defined(CONFIG_X86_64)
-static const unsigned char intelnops[] =
+const unsigned char x86nops[] =
 {
-	GENERIC_NOP1,
-	GENERIC_NOP2,
-	GENERIC_NOP3,
-	GENERIC_NOP4,
-	GENERIC_NOP5,
-	GENERIC_NOP6,
-	GENERIC_NOP7,
-	GENERIC_NOP8,
-	GENERIC_NOP5_ATOMIC
-};
-static const unsigned char * const intel_nops[ASM_NOP_MAX+2] =
-{
-	NULL,
-	intelnops,
-	intelnops + 1,
-	intelnops + 1 + 2,
-	intelnops + 1 + 2 + 3,
-	intelnops + 1 + 2 + 3 + 4,
-	intelnops + 1 + 2 + 3 + 4 + 5,
-	intelnops + 1 + 2 + 3 + 4 + 5 + 6,
-	intelnops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	intelnops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
+	BYTES_NOP1,
+	BYTES_NOP2,
+	BYTES_NOP3,
+	BYTES_NOP4,
+	BYTES_NOP5,
+	BYTES_NOP6,
+	BYTES_NOP7,
+	BYTES_NOP8,
 };
-#endif
 
-#ifdef K8_NOP1
-static const unsigned char k8nops[] =
-{
-	K8_NOP1,
-	K8_NOP2,
-	K8_NOP3,
-	K8_NOP4,
-	K8_NOP5,
-	K8_NOP6,
-	K8_NOP7,
-	K8_NOP8,
-	K8_NOP5_ATOMIC
-};
-static const unsigned char * const k8_nops[ASM_NOP_MAX+2] =
-{
-	NULL,
-	k8nops,
-	k8nops + 1,
-	k8nops + 1 + 2,
-	k8nops + 1 + 2 + 3,
-	k8nops + 1 + 2 + 3 + 4,
-	k8nops + 1 + 2 + 3 + 4 + 5,
-	k8nops + 1 + 2 + 3 + 4 + 5 + 6,
-	k8nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	k8nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
-};
-#endif
-
-#if defined(K7_NOP1) && !defined(CONFIG_X86_64)
-static const unsigned char k7nops[] =
-{
-	K7_NOP1,
-	K7_NOP2,
-	K7_NOP3,
-	K7_NOP4,
-	K7_NOP5,
-	K7_NOP6,
-	K7_NOP7,
-	K7_NOP8,
-	K7_NOP5_ATOMIC
-};
-static const unsigned char * const k7_nops[ASM_NOP_MAX+2] =
-{
-	NULL,
-	k7nops,
-	k7nops + 1,
-	k7nops + 1 + 2,
-	k7nops + 1 + 2 + 3,
-	k7nops + 1 + 2 + 3 + 4,
-	k7nops + 1 + 2 + 3 + 4 + 5,
-	k7nops + 1 + 2 + 3 + 4 + 5 + 6,
-	k7nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	k7nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
-};
-#endif
-
-#ifdef P6_NOP1
-static const unsigned char p6nops[] =
-{
-	P6_NOP1,
-	P6_NOP2,
-	P6_NOP3,
-	P6_NOP4,
-	P6_NOP5,
-	P6_NOP6,
-	P6_NOP7,
-	P6_NOP8,
-	P6_NOP5_ATOMIC
-};
-static const unsigned char * const p6_nops[ASM_NOP_MAX+2] =
+const unsigned char * const x86_nops[ASM_NOP_MAX+2] =
 {
 	NULL,
-	p6nops,
-	p6nops + 1,
-	p6nops + 1 + 2,
-	p6nops + 1 + 2 + 3,
-	p6nops + 1 + 2 + 3 + 4,
-	p6nops + 1 + 2 + 3 + 4 + 5,
-	p6nops + 1 + 2 + 3 + 4 + 5 + 6,
-	p6nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	p6nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
+	x86nops,
+	x86nops + 1,
+	x86nops + 1 + 2,
+	x86nops + 1 + 2 + 3,
+	x86nops + 1 + 2 + 3 + 4,
+	x86nops + 1 + 2 + 3 + 4 + 5,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
 };
-#endif
-
-/* Initialize these to a safe default */
-#ifdef CONFIG_X86_64
-const unsigned char * const *ideal_nops = p6_nops;
-#else
-const unsigned char * const *ideal_nops = intel_nops;
-#endif
-
-void __init arch_init_ideal_nops(void)
-{
-	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_INTEL:
-		/*
-		 * Due to a decoder implementation quirk, some
-		 * specific Intel CPUs actually perform better with
-		 * the "k8_nops" than with the SDM-recommended NOPs.
-		 */
-		if (boot_cpu_data.x86 == 6 &&
-		    boot_cpu_data.x86_model >= 0x0f &&
-		    boot_cpu_data.x86_model != 0x1c &&
-		    boot_cpu_data.x86_model != 0x26 &&
-		    boot_cpu_data.x86_model != 0x27 &&
-		    boot_cpu_data.x86_model < 0x30) {
-			ideal_nops = k8_nops;
-		} else if (boot_cpu_has(X86_FEATURE_NOPL)) {
-			   ideal_nops = p6_nops;
-		} else {
-#ifdef CONFIG_X86_64
-			ideal_nops = k8_nops;
-#else
-			ideal_nops = intel_nops;
-#endif
-		}
-		break;
-
-	case X86_VENDOR_HYGON:
-		ideal_nops = p6_nops;
-		return;
-
-	case X86_VENDOR_AMD:
-		if (boot_cpu_data.x86 > 0xf) {
-			ideal_nops = p6_nops;
-			return;
-		}
-
-		fallthrough;
-
-	default:
-#ifdef CONFIG_X86_64
-		ideal_nops = k8_nops;
-#else
-		if (boot_cpu_has(X86_FEATURE_K8))
-			ideal_nops = k8_nops;
-		else if (boot_cpu_has(X86_FEATURE_K7))
-			ideal_nops = k7_nops;
-		else
-			ideal_nops = intel_nops;
-#endif
-	}
-}
 
 /* Use this to add nops to a buffer, then text_poke the whole buffer. */
 static void __init_or_module add_nops(void *insns, unsigned int len)
@@ -262,7 +107,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
 		unsigned int noplen = len;
 		if (noplen > ASM_NOP_MAX)
 			noplen = ASM_NOP_MAX;
-		memcpy(insns, ideal_nops[noplen], noplen);
+		memcpy(insns, x86_nops[noplen], noplen);
 		insns += noplen;
 		len -= noplen;
 	}
@@ -1302,13 +1147,13 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	default: /* assume NOP */
 		switch (len) {
 		case 2: /* NOP2 -- emulate as JMP8+0 */
-			BUG_ON(memcmp(emulate, ideal_nops[len], len));
+			BUG_ON(memcmp(emulate, x86_nops[len], len));
 			tp->opcode = JMP8_INSN_OPCODE;
 			tp->rel32 = 0;
 			break;
 
 		case 5: /* NOP5 -- emulate as JMP32+0 */
-			BUG_ON(memcmp(emulate, ideal_nops[NOP_ATOMIC5], len));
+			BUG_ON(memcmp(emulate, x86_nops[len], len));
 			tp->opcode = JMP32_INSN_OPCODE;
 			tp->rel32 = 0;
 			break;
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7edbd5ee5ed4..1b3ce3b4a2a2 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -66,7 +66,7 @@ int ftrace_arch_code_modify_post_process(void)
 
 static const char *ftrace_nop_replace(void)
 {
-	return ideal_nops[NOP_ATOMIC5];
+	return x86_nops[5];
 }
 
 static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
@@ -377,7 +377,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		ip = trampoline + (jmp_offset - start_offset);
 		if (WARN_ON(*(char *)ip != 0x75))
 			goto fail;
-		ret = copy_from_kernel_nofault(ip, ideal_nops[2], 2);
+		ret = copy_from_kernel_nofault(ip, x86_nops[2], 2);
 		if (ret < 0)
 			goto fail;
 	}
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 5ba8477c2cb7..b728cdd47081 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -31,7 +31,6 @@ static const void *
 __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
 {
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 	const void *expect, *code;
 	const void *addr, *dest;
 	int line;
@@ -44,7 +43,7 @@ __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type,
 	if (init) {
 		expect = default_nop; line = __LINE__;
 	} else if (type == JUMP_LABEL_JMP) {
-		expect = ideal_nop; line = __LINE__;
+		expect = x86_nops[5]; line = __LINE__;
 	} else {
 		expect = code; line = __LINE__;
 	}
@@ -53,7 +52,7 @@ __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type,
 		bug_at(addr, line);
 
 	if (type == JUMP_LABEL_NOP)
-		code = ideal_nop;
+		code = x86_nops[5];
 
 	return code;
 }
@@ -136,22 +135,6 @@ static enum {
 __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 				      enum jump_label_type type)
 {
-	/*
-	 * This function is called at boot up and when modules are
-	 * first loaded. Check if the default nop, the one that is
-	 * inserted at compile time, is the ideal nop. If it is, then
-	 * we do not need to update the nop, and we can leave it as is.
-	 * If it is not, then we need to update the nop to the ideal nop.
-	 */
-	if (jlstate == JL_STATE_START) {
-		const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-		const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-
-		if (memcmp(ideal_nop, default_nop, 5) != 0)
-			jlstate = JL_STATE_UPDATE;
-		else
-			jlstate = JL_STATE_NO_UPDATE;
-	}
 	if (jlstate == JL_STATE_UPDATE)
 		jump_label_transform(entry, type, 1);
 }
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index df776cdca327..6356834928b9 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -229,7 +229,7 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 		return 0UL;
 
 	if (faddr)
-		memcpy(buf, ideal_nops[NOP_ATOMIC5], 5);
+		memcpy(buf, x86_nops[5], 5);
 	else
 		buf[0] = kp->opcode;
 	return (unsigned long)buf;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176ef2ce..3b4b9b281545 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -822,7 +822,6 @@ void __init setup_arch(char **cmdline_p)
 
 	idt_setup_early_traps();
 	early_cpu_init();
-	arch_init_ideal_nops();
 	jump_label_init();
 	static_call_init();
 	early_ioremap_init();
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 9442c4136c38..ea028e736831 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -34,7 +34,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void
 		break;
 
 	case NOP:
-		code = ideal_nops[NOP_ATOMIC5];
+		code = x86_nops[5];
 		break;
 
 	case JMP:
@@ -66,7 +66,7 @@ static void __static_call_validate(void *insn, bool tail)
 			return;
 	} else {
 		if (opcode == CALL_INSN_OPCODE ||
-		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5) ||
+		    !memcmp(insn, x86_nops[5], 5) ||
 		    !memcmp(insn, xor5rax, 5))
 			return;
 	}
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 79e7a0ec1da5..6aa29c45c3f9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -282,7 +282,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
-	memcpy(prog, ideal_nops[NOP_ATOMIC5], cnt);
+	memcpy(prog, x86_nops[5], cnt);
 	prog += cnt;
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
@@ -330,7 +330,7 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 				void *old_addr, void *new_addr,
 				const bool text_live)
 {
-	const u8 *nop_insn = ideal_nops[NOP_ATOMIC5];
+	const u8 *nop_insn = x86_nops[5];
 	u8 old_insn[X86_PATCH_SIZE];
 	u8 new_insn[X86_PATCH_SIZE];
 	u8 *prog;
@@ -560,7 +560,7 @@ static void emit_bpf_tail_call_direct(struct bpf_jit_poke_descriptor *poke,
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
 
-	memcpy(prog, ideal_nops[NOP_ATOMIC5], X86_PATCH_SIZE);
+	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 	prog += X86_PATCH_SIZE;
 	/* out: */
 
@@ -881,7 +881,7 @@ static int emit_nops(u8 **pprog, int len)
 			noplen = ASM_NOP_MAX;
 
 		for (i = 0; i < noplen; i++)
-			EMIT1(ideal_nops[noplen][i]);
+			EMIT1(x86_nops[noplen][i]);
 		len -= noplen;
 	}
 
