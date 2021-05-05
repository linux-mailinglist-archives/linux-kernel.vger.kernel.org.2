Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F94C37340D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 05:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhEEDz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 23:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhEEDzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 23:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620186897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGhwocrA+XReOqnv/iMSZ2bqs4ztftYML6wV48F4OmA=;
        b=aKUUMDQ9N2q4bQnRD6H3S9/9WK+UH493pkCDYeqnDFCLnHgRtG2TrfdQz3DC7r0RXHuI4H
        1jxq3VrAAOEMujY77Edj9BfGUdoA3aNgsvBuiwtM2fNkD+eITLPkdyevI7cU9kH4cL6u0k
        v+LbTNrOqBHVqs8p93oBHsJvIgiFB7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-_dW-VsiFMKyziloKYc39ZQ-1; Tue, 04 May 2021 23:54:53 -0400
X-MC-Unique: _dW-VsiFMKyziloKYc39ZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7AE010066E5;
        Wed,  5 May 2021 03:54:51 +0000 (UTC)
Received: from treble.redhat.com (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C59801002D71;
        Wed,  5 May 2021 03:54:49 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess speculation
Date:   Tue,  4 May 2021 22:54:31 -0500
Message-Id: <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1620186182.git.jpoimboe@redhat.com>
References: <cover.1620186182.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 uaccess code uses barrier_nospec() in various places to prevent
speculative dereferencing of user-controlled pointers (which might be
combined with further gadgets or CPU bugs to leak data).

There are some issues with the current implementation:

- The barrier_nospec() in copy_from_user() was inadvertently removed
  with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
  raw_copy_{to,from}_user()")

- copy_to_user() and friends should also have a speculation barrier,
  because a speculative write to a user-controlled address can still
  populate the cache line with the original data.

- The LFENCE in barrier_nospec() is overkill, when more lightweight user
  pointer masking can be used instead.

Remove existing barrier_nospec() usage, and instead do user pointer
masking, throughout the x86 uaccess code.  This is similar to what arm64
is already doing with uaccess_mask_ptr().

Fixes: 4b842e4e25b1 ("x86: get rid of small constant size cases in raw_copy_{to,from}_user()")
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Documentation/admin-guide/hw-vuln/spectre.rst |  6 +--
 arch/x86/include/asm/futex.h                  |  5 ++
 arch/x86/include/asm/uaccess.h                | 46 +++++++++++++------
 arch/x86/include/asm/uaccess_64.h             | 12 ++---
 arch/x86/kernel/cpu/sgx/virt.c                |  6 ++-
 arch/x86/lib/copy_mc.c                        |  2 +
 arch/x86/lib/csum-wrappers_64.c               |  5 +-
 arch/x86/lib/getuser.S                        | 16 ++-----
 arch/x86/lib/putuser.S                        |  8 ++++
 arch/x86/lib/usercopy_32.c                    |  6 +--
 arch/x86/lib/usercopy_64.c                    |  7 +--
 11 files changed, 76 insertions(+), 43 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index e05e581af5cf..2348d27d61da 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -426,9 +426,9 @@ Spectre variant 1
    <spec_ref2>` to avoid any usable disclosure gadgets. However, it may
    not cover all attack vectors for Spectre variant 1.
 
-   Copy-from-user code has an LFENCE barrier to prevent the access_ok()
-   check from being mis-speculated.  The barrier is done by the
-   barrier_nospec() macro.
+   Usercopy code uses user pointer masking to prevent the access_ok()
+   check from being mis-speculated in the success path with a kernel
+   address.  The masking is done by the mask_user_ptr() macro.
 
    For the swapgs variant of Spectre variant 1, LFENCE barriers are
    added to interrupt, exception and NMI entry where needed.  These
diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index f9c00110a69a..6224b2f15a0f 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -59,6 +59,8 @@ static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *o
 	if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	uaddr = mask_user_ptr(uaddr);
+
 	switch (op) {
 	case FUTEX_OP_SET:
 		unsafe_atomic_op1("xchgl %0, %2", oval, uaddr, oparg, Efault);
@@ -94,6 +96,9 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 
 	if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
+
+	uaddr = mask_user_ptr(uaddr);
+
 	asm volatile("\n"
 		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
 		"2:\n"
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index fb75657b5e56..ebe9ab46b183 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -66,12 +66,35 @@ static inline bool pagefault_disabled(void);
  * Return: true (nonzero) if the memory block may be valid, false (zero)
  * if it is definitely invalid.
  */
-#define access_ok(addr, size)					\
+#define access_ok(addr, size)						\
 ({									\
 	WARN_ON_IN_IRQ();						\
 	likely(!__range_not_ok(addr, size, TASK_SIZE_MAX));		\
 })
 
+/*
+ * Sanitize a user pointer such that it becomes NULL if it's not a valid user
+ * pointer.  This prevents speculatively dereferencing a user-controlled
+ * pointer to kernel space if access_ok() speculatively returns true.  This
+ * should be done *after* access_ok(), to avoid affecting error handling
+ * behavior.
+ */
+#define mask_user_ptr(ptr)						\
+({									\
+	unsigned long _ptr = (__force unsigned long)ptr;		\
+	unsigned long mask;						\
+									\
+	asm volatile("cmp %[max], %[_ptr]\n\t"				\
+		     "sbb %[mask], %[mask]\n\t"				\
+		     : [mask] "=r" (mask)				\
+		     : [_ptr] "r" (_ptr),				\
+		       [max] "r" (TASK_SIZE_MAX)			\
+		     : "cc");						\
+									\
+	mask &= _ptr;							\
+	((typeof(ptr)) mask);						\
+})
+
 extern int __get_user_1(void);
 extern int __get_user_2(void);
 extern int __get_user_4(void);
@@ -84,11 +107,6 @@ extern int __get_user_bad(void);
 
 #define __uaccess_begin() stac()
 #define __uaccess_end()   clac()
-#define __uaccess_begin_nospec()	\
-({					\
-	stac();				\
-	barrier_nospec();		\
-})
 
 /*
  * This is the smallest unsigned integer type that can fit a value
@@ -175,7 +193,7 @@ extern int __get_user_bad(void);
  * Return: zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define __get_user(x,ptr) do_get_user_call(get_user_nocheck,x,ptr)
+#define __get_user(x,ptr) do_get_user_call(get_user_nocheck, x, mask_user_ptr(ptr))
 
 
 #ifdef CONFIG_X86_32
@@ -271,7 +289,7 @@ extern void __put_user_nocheck_8(void);
  *
  * Return: zero on success, or -EFAULT on error.
  */
-#define __put_user(x, ptr) do_put_user_call(put_user_nocheck,x,ptr)
+#define __put_user(x, ptr) do_put_user_call(put_user_nocheck, x, mask_user_ptr(ptr))
 
 #define __put_user_size(x, ptr, size, label)				\
 do {									\
@@ -475,7 +493,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 {
 	if (unlikely(!access_ok(ptr,len)))
 		return 0;
-	__uaccess_begin_nospec();
+	__uaccess_begin();
 	return 1;
 }
 #define user_access_begin(a,b)	user_access_begin(a,b)
@@ -484,14 +502,15 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 #define user_access_save()	smap_save()
 #define user_access_restore(x)	smap_restore(x)
 
-#define unsafe_put_user(x, ptr, label)	\
-	__put_user_size((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)
+#define unsafe_put_user(x, ptr, label)						\
+	__put_user_size((__typeof__(*(ptr)))(x), mask_user_ptr(ptr),		\
+			sizeof(*(ptr)), label)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 #define unsafe_get_user(x, ptr, err_label)					\
 do {										\
 	__inttype(*(ptr)) __gu_val;						\
-	__get_user_size(__gu_val, (ptr), sizeof(*(ptr)), err_label);		\
+	__get_user_size(__gu_val, mask_user_ptr(ptr), sizeof(*(ptr)), err_label);\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 } while (0)
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
@@ -499,7 +518,8 @@ do {										\
 do {										\
 	int __gu_err;								\
 	__inttype(*(ptr)) __gu_val;						\
-	__get_user_size(__gu_val, (ptr), sizeof(*(ptr)), __gu_err);		\
+	__get_user_size(__gu_val, mask_user_ptr(ptr), sizeof(*(ptr)),		\
+			__gu_err);						\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 	if (unlikely(__gu_err)) goto err_label;					\
 } while (0)
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index e7265a552f4f..abd9cb204fde 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -49,20 +49,20 @@ copy_user_generic(void *to, const void *from, unsigned len)
 static __always_inline __must_check unsigned long
 raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
 {
-	return copy_user_generic(dst, (__force void *)src, size);
+	return copy_user_generic(dst, (__force void *)mask_user_ptr(src), size);
 }
 
 static __always_inline __must_check unsigned long
 raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
 {
-	return copy_user_generic((__force void *)dst, src, size);
+	return copy_user_generic((__force void *)mask_user_ptr(dst), src, size);
 }
 
 static __always_inline __must_check
 unsigned long raw_copy_in_user(void __user *dst, const void __user *src, unsigned long size)
 {
-	return copy_user_generic((__force void *)dst,
-				 (__force void *)src, size);
+	return copy_user_generic((__force void *)mask_user_ptr(dst),
+				 (__force void *)mask_user_ptr(src), size);
 }
 
 extern long __copy_user_nocache(void *dst, const void __user *src,
@@ -77,13 +77,13 @@ __copy_from_user_inatomic_nocache(void *dst, const void __user *src,
 				  unsigned size)
 {
 	kasan_check_write(dst, size);
-	return __copy_user_nocache(dst, src, size, 0);
+	return __copy_user_nocache(dst, mask_user_ptr(src), size, 0);
 }
 
 static inline int
 __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
 {
 	kasan_check_write(dst, size);
-	return __copy_user_flushcache(dst, src, size);
+	return __copy_user_flushcache(dst, mask_user_ptr(src), size);
 }
 #endif /* _ASM_X86_UACCESS_64_H */
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 6ad165a5c0cc..1b6606afad36 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -292,7 +292,7 @@ int sgx_virt_ecreate(struct sgx_pageinfo *pageinfo, void __user *secs,
 		return -EINVAL;
 
 	__uaccess_begin();
-	ret = __ecreate(pageinfo, (void *)secs);
+	ret = __ecreate(pageinfo, (void *)mask_user_ptr(secs));
 	__uaccess_end();
 
 	if (encls_faulted(ret)) {
@@ -323,7 +323,9 @@ static int __sgx_virt_einit(void __user *sigstruct, void __user *token,
 		return -EINVAL;
 
 	__uaccess_begin();
-	ret = __einit((void *)sigstruct, (void *)token, (void *)secs);
+	ret = __einit((void *)mask_user_ptr(sigstruct),
+		      (void *)mask_user_ptr(token),
+		      (void *)mask_user_ptr(secs));
 	__uaccess_end();
 
 	return ret;
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 6e8b7e600def..b895bafbe7fe 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -74,6 +74,8 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
 {
 	unsigned long ret;
 
+	dst = mask_user_ptr(dst);
+
 	if (copy_mc_fragile_enabled) {
 		__uaccess_begin();
 		ret = copy_mc_fragile((__force void *)dst, src, len);
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 189344924a2b..b022d34b9c4b 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -28,7 +28,8 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 	might_sleep();
 	if (!user_access_begin(src, len))
 		return 0;
-	sum = csum_partial_copy_generic((__force const void *)src, dst, len);
+	sum = csum_partial_copy_generic((__force const void *)mask_user_ptr(src),
+					dst, len);
 	user_access_end();
 	return sum;
 }
@@ -53,7 +54,7 @@ csum_and_copy_to_user(const void *src, void __user *dst, int len)
 	might_sleep();
 	if (!user_access_begin(dst, len))
 		return 0;
-	sum = csum_partial_copy_generic(src, (void __force *)dst, len);
+	sum = csum_partial_copy_generic(src, (void __force *)mask_user_ptr(dst), len);
 	user_access_end();
 	return sum;
 }
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index fa1bc2104b32..64715a7edb1f 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -35,8 +35,6 @@
 #include <asm/smap.h>
 #include <asm/export.h>
 
-#define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
-
 #ifdef CONFIG_X86_5LEVEL
 #define LOAD_TASK_SIZE_MINUS_N(n) \
 	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
@@ -51,7 +49,7 @@ SYM_FUNC_START(__get_user_1)
 	LOAD_TASK_SIZE_MINUS_N(0)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	sbb %_ASM_DX, %_ASM_DX		/* mask_user_ptr() */
 	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 1:	movzbl (%_ASM_AX),%edx
@@ -65,7 +63,7 @@ SYM_FUNC_START(__get_user_2)
 	LOAD_TASK_SIZE_MINUS_N(1)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	sbb %_ASM_DX, %_ASM_DX		/* mask_user_ptr() */
 	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 2:	movzwl (%_ASM_AX),%edx
@@ -79,7 +77,7 @@ SYM_FUNC_START(__get_user_4)
 	LOAD_TASK_SIZE_MINUS_N(3)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	sbb %_ASM_DX, %_ASM_DX		/* mask_user_ptr() */
 	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 3:	movl (%_ASM_AX),%edx
@@ -94,7 +92,7 @@ SYM_FUNC_START(__get_user_8)
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	sbb %_ASM_DX, %_ASM_DX		/* mask_user_ptr() */
 	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movq (%_ASM_AX),%rdx
@@ -105,7 +103,7 @@ SYM_FUNC_START(__get_user_8)
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user_8
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	sbb %_ASM_DX, %_ASM_DX		/* mask_user_ptr() */
 	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movl (%_ASM_AX),%edx
@@ -120,7 +118,6 @@ EXPORT_SYMBOL(__get_user_8)
 /* .. and the same for __get_user, just without the range checks */
 SYM_FUNC_START(__get_user_nocheck_1)
 	ASM_STAC
-	ASM_BARRIER_NOSPEC
 6:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
@@ -130,7 +127,6 @@ EXPORT_SYMBOL(__get_user_nocheck_1)
 
 SYM_FUNC_START(__get_user_nocheck_2)
 	ASM_STAC
-	ASM_BARRIER_NOSPEC
 7:	movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
@@ -140,7 +136,6 @@ EXPORT_SYMBOL(__get_user_nocheck_2)
 
 SYM_FUNC_START(__get_user_nocheck_4)
 	ASM_STAC
-	ASM_BARRIER_NOSPEC
 8:	movl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
@@ -150,7 +145,6 @@ EXPORT_SYMBOL(__get_user_nocheck_4)
 
 SYM_FUNC_START(__get_user_nocheck_8)
 	ASM_STAC
-	ASM_BARRIER_NOSPEC
 #ifdef CONFIG_X86_64
 9:	movq (%_ASM_AX),%rdx
 #else
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 0ea344c5ea43..afd819459455 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -47,6 +47,8 @@ SYM_FUNC_START(__put_user_1)
 	LOAD_TASK_SIZE_MINUS_N(0)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
+	sbb %_ASM_BX, %_ASM_BX		/* mask_user_ptr() */
+	and %_ASM_BX, %_ASM_CX
 SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
@@ -61,6 +63,8 @@ SYM_FUNC_START(__put_user_2)
 	LOAD_TASK_SIZE_MINUS_N(1)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
+	sbb %_ASM_BX, %_ASM_BX		/* mask_user_ptr() */
+	and %_ASM_BX, %_ASM_CX
 SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
 	ASM_STAC
 2:	movw %ax,(%_ASM_CX)
@@ -75,6 +79,8 @@ SYM_FUNC_START(__put_user_4)
 	LOAD_TASK_SIZE_MINUS_N(3)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
+	sbb %_ASM_BX, %_ASM_BX		/* mask_user_ptr() */
+	and %_ASM_BX, %_ASM_CX
 SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
 	ASM_STAC
 3:	movl %eax,(%_ASM_CX)
@@ -89,6 +95,8 @@ SYM_FUNC_START(__put_user_8)
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
+	sbb %_ASM_BX, %_ASM_BX		/* mask_user_ptr() */
+	and %_ASM_BX, %_ASM_CX
 SYM_INNER_LABEL(__put_user_nocheck_8, SYM_L_GLOBAL)
 	ASM_STAC
 4:	mov %_ASM_AX,(%_ASM_CX)
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 7d290777246d..e4dc3c2790db 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -68,7 +68,7 @@ clear_user(void __user *to, unsigned long n)
 {
 	might_fault();
 	if (access_ok(to, n))
-		__do_clear_user(to, n);
+		__do_clear_user(mask_user_ptr(to), n);
 	return n;
 }
 EXPORT_SYMBOL(clear_user);
@@ -331,7 +331,7 @@ do {									\
 
 unsigned long __copy_user_ll(void *to, const void *from, unsigned long n)
 {
-	__uaccess_begin_nospec();
+	__uaccess_begin();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
@@ -344,7 +344,7 @@ EXPORT_SYMBOL(__copy_user_ll);
 unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
 					unsigned long n)
 {
-	__uaccess_begin_nospec();
+	__uaccess_begin();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && static_cpu_has(X86_FEATURE_XMM2))
 		n = __copy_user_intel_nocache(to, from, n);
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 508c81e97ab1..be0e5efdd142 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -42,7 +42,8 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 		_ASM_EXTABLE_UA(0b, 3b)
 		_ASM_EXTABLE_UA(1b, 2b)
 		: [size8] "=&c"(size), [dst] "=&D" (__d0)
-		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
+		: [size1] "r"(size & 7), "[size8]" (size / 8),
+		  "[dst]" (mask_user_ptr(addr)));
 	clac();
 	return size;
 }
@@ -51,7 +52,7 @@ EXPORT_SYMBOL(__clear_user);
 unsigned long clear_user(void __user *to, unsigned long n)
 {
 	if (access_ok(to, n))
-		return __clear_user(to, n);
+		return __clear_user(mask_user_ptr(to), n);
 	return n;
 }
 EXPORT_SYMBOL(clear_user);
@@ -87,7 +88,7 @@ EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 long __copy_user_flushcache(void *dst, const void __user *src, unsigned size)
 {
 	unsigned long flushed, dest = (unsigned long) dst;
-	long rc = __copy_user_nocache(dst, src, size, 0);
+	long rc = __copy_user_nocache(dst, mask_user_ptr(src), size, 0);
 
 	/*
 	 * __copy_user_nocache() uses non-temporal stores for the bulk
-- 
2.31.1

