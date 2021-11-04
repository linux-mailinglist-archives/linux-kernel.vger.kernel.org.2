Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF29445ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhKDUAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 16:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhKDUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 16:00:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FD1C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 12:58:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s24so9148636plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBWkkjRPqMeXPNEjqt9BJ94U0PjT5H9NNNIQgB40MVM=;
        b=a2x9EuleW2drl7l/pjpUSdavT/KZndovfdSSElE1ryRwKU5JPktV2MRQwbj8BmTu4C
         NmW/eo5e6QuDnCmkNlKzbRUpfZzDuNIwTUC+udedW1s/sbFUace0h/KVDNEBKfL08Kib
         NnG0SmUhOUOnf18sjn5nufQFuxBELGG8zFcPsN/+rEwfZNPH8/hCCcXzlEqnUzlEWyQV
         mbyMzzKZtXmxizwi+bzdcjWaobNonbG5+vyIuh8XSfhFZQCNcXcfhNsNbHaOkfibfqID
         chPBudZ2NnNYhsrraDY+SdlblEqFmu8iDGJNKTD4W8PaxQt9M7b32Bk+4RVJRR4pQmzt
         3ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBWkkjRPqMeXPNEjqt9BJ94U0PjT5H9NNNIQgB40MVM=;
        b=Ph4WRNc4m/smuIi0pXn4TOTdtGuSnID3Rs/VTFsjbR4GP8IGVVMOpBeWkzW5uYOAC5
         6ez+497TP9pnHR/CIdL7YV3znk4fxB0QH1vnTZtY6DJ9nq+KknsapA/+pBXjr6IZKFko
         kCCb67HT/js4OKhRVCGDTEsQPFBm1s37Yr27jvzQn9Iu6wIsNAyXhSxtTdRHI1KMNKR8
         c4x0ycTHcHtQtJ/4Sf6y3A4Q0GnOX8PNUxK/ob1+O/L+IymhYdSe0pLQk10WTJxwU6bX
         UB9WIfefoInPsTxXlpuo4X/dEaAMlNKkKQR10JN4gGA+7g2W/knZyaiwYjvApzhnLCT8
         HM3g==
X-Gm-Message-State: AOAM5328K1pv73xZub8ppChBfJ2M8eN/TchnLQE1/o/ll7jXR6D8Z6s3
        KyvBVrXNZV2rhSjYfKrRbeQV0A==
X-Google-Smtp-Source: ABdhPJxU/Zh04IJNjVjqFB4KHDqoVWzkRP1Z+nE2vVVuXmQxxsfDfxE4URS+wR9WH73qxSHeun76YA==
X-Received: by 2002:a17:90b:314e:: with SMTP id ip14mr9001668pjb.130.1636055891878;
        Thu, 04 Nov 2021 12:58:11 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id w185sm5487853pfb.38.2021.11.04.12.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 12:58:11 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH v0.8 2/6] mm, x86/uaccess: add userspace atomic helpers
Date:   Thu,  4 Nov 2021 12:58:00 -0700
Message-Id: <20211104195804.83240-3-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104195804.83240-1-posk@google.com>
References: <20211104195804.83240-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to futexes needing to do atomic operations in the userspace,
a second use case is now in the works (UMCG, see
https://lore.kernel.org/all/20210917180323.278250-1-posk@google.com/),
so a generic facility to perform these operations has been called for
(see https://lore.kernel.org/all/87ilyk9xc0.ffs@tglx/).

Add a set of generic helpers to perform 32/64-bit xchg and cmpxchg
operations in the userspace. Also implement the required
architecture-specific support on x86_64.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 arch/x86/include/asm/uaccess_64.h |  93 +++++++++++
 include/linux/uaccess.h           |  46 ++++++
 mm/maccess.c                      | 264 ++++++++++++++++++++++++++++++
 3 files changed, 403 insertions(+)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 45697e04d771..41e2f96d3ec4 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -79,4 +79,97 @@ __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
 	kasan_check_write(dst, size);
 	return __copy_user_flushcache(dst, src, size);
 }
+
+#define ARCH_HAS_ATOMIC_UACCESS_HELPERS 1
+
+static inline int __try_cmpxchg_user_32(u32 *uval, u32 __user *uaddr,
+						u32 oldval, u32 newval)
+{
+	int ret = 0;
+
+	asm volatile("\n"
+		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
+		"2:\n"
+		"\t.section .fixup, \"ax\"\n"
+		"3:\tmov     %3, %0\n"
+		"\tjmp     2b\n"
+		"\t.previous\n"
+		_ASM_EXTABLE_UA(1b, 3b)
+		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
+		: "i" (-EFAULT), "r" (newval), "1" (oldval)
+		: "memory"
+	);
+	*uval = oldval;
+	return ret;
+}
+
+static inline int __try_cmpxchg_user_64(u64 *uval, u64 __user *uaddr,
+						u64 oldval, u64 newval)
+{
+	int ret = 0;
+
+	asm volatile("\n"
+		"1:\t" LOCK_PREFIX "cmpxchgq %4, %2\n"
+		"2:\n"
+		"\t.section .fixup, \"ax\"\n"
+		"3:\tmov     %3, %0\n"
+		"\tjmp     2b\n"
+		"\t.previous\n"
+		_ASM_EXTABLE_UA(1b, 3b)
+		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
+		: "i" (-EFAULT), "r" (newval), "1" (oldval)
+		: "memory"
+	);
+	*uval = oldval;
+	return ret;
+}
+
+static inline int __try_xchg_user_32(u32 *oval, u32 __user *uaddr, u32 newval)
+{
+	u32 oldval = 0;
+	int ret = 0;
+
+	asm volatile("\n"
+		"1:\txchgl %0, %2\n"
+		"2:\n"
+		"\t.section .fixup, \"ax\"\n"
+		"3:\tmov     %3, %1\n"
+		"\tjmp     2b\n"
+		"\t.previous\n"
+		_ASM_EXTABLE_UA(1b, 3b)
+		: "=r" (oldval), "=r" (ret), "+m" (*uaddr)
+		: "i" (-EFAULT), "0" (newval), "1" (0)
+	);
+
+	if (ret)
+		return ret;
+
+	*oval = oldval;
+	return 0;
+}
+
+static inline int __try_xchg_user_64(u64 *oval, u64 __user *uaddr, u64 newval)
+{
+	u64 oldval = 0;
+	int ret = 0;
+
+	asm volatile("\n"
+		"1:\txchgq %0, %2\n"
+		"2:\n"
+		"\t.section .fixup, \"ax\"\n"
+		"3:\tmov     %3, %1\n"
+		"\tjmp     2b\n"
+		"\t.previous\n"
+		_ASM_EXTABLE_UA(1b, 3b)
+		: "=r" (oldval), "=r" (ret), "+m" (*uaddr)
+		: "i" (-EFAULT), "0" (newval), "1" (0)
+	);
+
+	if (ret)
+		return ret;
+
+	*oval = oldval;
+	return 0;
+}
+
 #endif /* _ASM_X86_UACCESS_64_H */
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..dcb3ac093075 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -408,4 +408,50 @@ void __noreturn usercopy_abort(const char *name, const char *detail,
 			       unsigned long len);
 #endif

+#ifdef ARCH_HAS_ATOMIC_UACCESS_HELPERS
+/**
+ * cmpxchg_user_[32|64][_nofault|]() - compare_exchange 32/64-bit values
+ * @uaddr:     Destination address, in user space;
+ * @curr_val:  Source address, in kernel space;
+ * @new_val:   The value to write to the destination address.
+ *
+ * This is the standard cmpxchg: atomically: compare *@uaddr to *@curr_val;
+ * if the values match, write @new_val to @uaddr, return 0; if the values
+ * do not match, write *@uaddr to @curr_val, return -EAGAIN.
+ *
+ * The _nofault versions don't fault and can be used in
+ * atomic/preempt-disabled contexts.
+ *
+ * Return:
+ * 0      : OK/success;
+ * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
+ * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault);
+ * -EAGAIN: @old did not match.
+ */
+int cmpxchg_user_32_nofault(u32 __user *uaddr, u32 *curr_val, u32 new_val);
+int cmpxchg_user_64_nofault(u64 __user *uaddr, u64 *curr_val, u64 new_val);
+int cmpxchg_user_32(u32 __user *uaddr, u32 *curr_val, u32 new_val);
+int cmpxchg_user_64(u64 __user *uaddr, u64 *curr_val, u64 new_val);
+
+/**
+ * xchg_user_[32|64][_nofault|]() - exchange 32/64-bit values
+ * @uaddr:   Destination address, in user space;
+ * @val:     Source address, in kernel space.
+ *
+ * This is the standard atomic xchg: exchange values pointed to by @uaddr and @val.
+ *
+ * The _nofault versions don't fault and can be used in
+ * atomic/preempt-disabled contexts.
+ *
+ * Return:
+ * 0      : OK/success;
+ * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
+ * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault).
+ */
+int xchg_user_32_nofault(u32 __user *uaddr, u32 *val);
+int xchg_user_64_nofault(u64 __user *uaddr, u64 *val);
+int xchg_user_32(u32 __user *uaddr, u32 *val);
+int xchg_user_64(u64 __user *uaddr, u64 *val);
+#endif		/* ARCH_HAS_ATOMIC_UACCESS_HELPERS */
+
 #endif		/* __LINUX_UACCESS_H__ */
diff --git a/mm/maccess.c b/mm/maccess.c
index d3f1a1f0b1c1..620556b11550 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -335,3 +335,267 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count)

 	return ret;
 }
+
+#ifdef ARCH_HAS_ATOMIC_UACCESS_HELPERS
+
+static int fix_pagefault(unsigned long uaddr, bool write_fault, int bytes)
+{
+	struct mm_struct *mm = current->mm;
+	int ret;
+
+	mmap_read_lock(mm);
+	ret = fixup_user_fault(mm, uaddr, write_fault ? FAULT_FLAG_WRITE : 0,
+			NULL);
+	mmap_read_unlock(mm);
+
+	return ret < 0 ? ret : 0;
+}
+
+int cmpxchg_user_32_nofault(u32 __user *uaddr, u32 *curr_val, u32 new_val)
+{
+	int ret = -EFAULT;
+	u32 __old = *curr_val;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
+		pagefault_enable();
+		return -EFAULT;
+	}
+	ret = __try_cmpxchg_user_32(curr_val, uaddr, __old, new_val);
+	user_access_end();
+
+	if (!ret)
+		ret =  *curr_val == __old ? 0 : -EAGAIN;
+
+	pagefault_enable();
+	return ret;
+}
+
+int cmpxchg_user_64_nofault(u64 __user *uaddr, u64 *curr_val, u64 new_val)
+{
+	int ret = -EFAULT;
+	u64 __old = *curr_val;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
+		pagefault_enable();
+		return -EFAULT;
+	}
+	ret = __try_cmpxchg_user_64(curr_val, uaddr, __old, new_val);
+	user_access_end();
+
+	if (!ret)
+		ret =  *curr_val == __old ? 0 : -EAGAIN;
+
+	pagefault_enable();
+
+	return ret;
+}
+
+int cmpxchg_user_32(u32 __user *uaddr, u32 *curr_val, u32 new_val)
+{
+	int ret = -EFAULT;
+	u32 __old = *curr_val;
+
+	/* Validate proper alignment. */
+	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
+			((unsigned long)curr_val % sizeof(*curr_val))))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		ret = -EFAULT;
+		if (!user_access_begin(uaddr, sizeof(*uaddr)))
+			break;
+
+		ret = __try_cmpxchg_user_32(curr_val, uaddr, __old, new_val);
+		user_access_end();
+
+		if (!ret) {
+			ret =  *curr_val == __old ? 0 : -EAGAIN;
+			break;
+		}
+
+		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
+			break;
+	}
+
+	pagefault_enable();
+	return ret;
+}
+
+int cmpxchg_user_64(u64 __user *uaddr, u64 *curr_val, u64 new_val)
+{
+	int ret = -EFAULT;
+	u64 __old = *curr_val;
+
+	/* Validate proper alignment. */
+	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
+			((unsigned long)curr_val % sizeof(*curr_val))))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		ret = -EFAULT;
+		if (!user_access_begin(uaddr, sizeof(*uaddr)))
+			break;
+
+		ret = __try_cmpxchg_user_64(curr_val, uaddr, __old, new_val);
+		user_access_end();
+
+		if (!ret) {
+			ret =  *curr_val == __old ? 0 : -EAGAIN;
+			break;
+		}
+
+		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
+			break;
+	}
+
+	pagefault_enable();
+	return ret;
+}
+
+/**
+ * xchg_user_[32|64][_nofault|]() - exchange 32/64-bit values
+ * @uaddr:   Destination address, in user space;
+ * @val:     Source address, in kernel space.
+ *
+ * This is the standard atomic xchg: exchange values pointed to by @uaddr and @val.
+ *
+ * The _nofault versions don't fault and can be used in
+ * atomic/preempt-disabled contexts.
+ *
+ * Return:
+ * 0      : OK/success;
+ * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
+ * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault).
+ */
+int xchg_user_32_nofault(u32 __user *uaddr, u32 *val)
+{
+	int ret;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
+		pagefault_enable();
+		return -EFAULT;
+	}
+
+	ret = __try_xchg_user_32(val, uaddr, *val);
+	user_access_end();
+
+	pagefault_enable();
+
+	return ret;
+}
+
+int xchg_user_64_nofault(u64 __user *uaddr, u64 *val)
+{
+	int ret;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
+		pagefault_enable();
+		return -EFAULT;
+	}
+
+	ret = __try_xchg_user_64(val, uaddr, *val);
+	user_access_end();
+
+	pagefault_enable();
+
+	return ret;
+}
+
+int xchg_user_32(u32 __user *uaddr, u32 *val)
+{
+	int ret = -EFAULT;
+
+	/* Validate proper alignment. */
+	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
+			((unsigned long)val % sizeof(*val))))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		ret = -EFAULT;
+		if (!user_access_begin(uaddr, sizeof(*uaddr)))
+			break;
+
+		ret = __try_xchg_user_32(val, uaddr, *val);
+		user_access_end();
+
+		if (!ret)
+			break;
+
+		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
+			break;
+	}
+
+	pagefault_enable();
+
+	return ret;
+}
+
+int xchg_user_64(u64 __user *uaddr, u64 *val)
+{
+	int ret = -EFAULT;
+
+	/* Validate proper alignment. */
+	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
+			((unsigned long)val % sizeof(*val))))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		ret = -EFAULT;
+		if (!user_access_begin(uaddr, sizeof(*uaddr)))
+			break;
+
+		ret = __try_xchg_user_64(val, uaddr, *val);
+		user_access_end();
+
+		if (!ret)
+			break;
+
+		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
+			break;
+	}
+
+	pagefault_enable();
+
+	return ret;
+}
+#endif		/* ARCH_HAS_ATOMIC_UACCESS_HELPERS */
--
2.25.1

