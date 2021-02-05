Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131D63114FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhBEWU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:20:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:12586 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232898AbhBEO4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:56:19 -0500
IronPort-SDR: ca9WQI2MTjghxo+QMRusvlevDRIFayjUv6gdoJVhzBR+ufasY3lHS8rAc7dC1XpxkLdoCmJwnZ
 KRNOqaUh/zGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168561523"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="168561523"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:16:45 -0800
IronPort-SDR: 3eANWtqascL8MdqUIK8RZ6Xvx57XDRQlibPw9uDAxt0iOqF2cUfi6kOP4+Qdm1ncQcV/APWJNP
 L1a3oC5SBZKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="397474638"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Feb 2021 07:16:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A6D56108; Fri,  5 Feb 2021 17:16:40 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 1/9] mm, arm64: Update PR_SET/GET_TAGGED_ADDR_CTRL interface
Date:   Fri,  5 Feb 2021 18:16:21 +0300
Message-Id: <20210205151631.43511-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interface for enabling tagged addresses is very inflexible. It
implies tag size and tag shift implemented by ARM TBI.

Rework the interface to accommodate different shifts and tag sizes.

PR_SET_TAGGED_ADDR_CTRL now accepts two new arguments:

 - nr_bits is pointer to int. The caller specifies the tag size it
   wants. Kernel updates the value of actual tag size that can be
   larger.

 - offset is pointer to int. Kernel returns there a shift of tag in the
   address.

The change doesn't break existing users of the interface: if any of
these pointers are NULL (as we had before the change), the user expects
ARM TBI implementation: nr_bits == 8 && offset == 56 as it was implied
before.

The initial implementation checked that these argument are NULL and the
change wouldn't not break any legacy users.

If tagging is enabled, GET_TAGGED_ADDR_CTRL would return size of tags
and offset in the additional arguments.

If tagging is disable, GET_TAGGED_ADDR_CTRL would return the maximum tag
size in nr_bits.

The selftest is updated accordingly and moved out of arm64-specific
directory as we going to enable the interface on x86.

As alternative to this approach we could introduce a totally new API and
leave the legacy one as is. But it would slow down adoption: new
prctl(2) flag wound need to propogate to the userspace headers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/arm64/include/asm/processor.h            | 12 ++--
 arch/arm64/kernel/process.c                   | 45 ++++++++++++---
 arch/arm64/kernel/ptrace.c                    |  4 +-
 kernel/sys.c                                  | 14 +++--
 .../testing/selftests/arm64/tags/tags_test.c  | 31 ----------
 .../selftests/{arm64 => vm}/tags/.gitignore   |  0
 .../selftests/{arm64 => vm}/tags/Makefile     |  0
 .../{arm64 => vm}/tags/run_tags_test.sh       |  0
 tools/testing/selftests/vm/tags/tags_test.c   | 57 +++++++++++++++++++
 9 files changed, 113 insertions(+), 50 deletions(-)
 delete mode 100644 tools/testing/selftests/arm64/tags/tags_test.c
 rename tools/testing/selftests/{arm64 => vm}/tags/.gitignore (100%)
 rename tools/testing/selftests/{arm64 => vm}/tags/Makefile (100%)
 rename tools/testing/selftests/{arm64 => vm}/tags/run_tags_test.sh (100%)
 create mode 100644 tools/testing/selftests/vm/tags/tags_test.c

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fce8cbecd6bc..77b91e6d3c85 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -305,10 +305,14 @@ extern void __init minsigstksz_setup(void);
 
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
 /* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
-long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
-long get_tagged_addr_ctrl(struct task_struct *task);
-#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(current, arg)
-#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl(current)
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long flags,
+			  int __user *nr_bits, int __user *offset);
+long get_tagged_addr_ctrl(struct task_struct *task,
+			  int __user *nr_bits, int __user *offset);
+#define SET_TAGGED_ADDR_CTRL(flags, nr_bits, offset)	\
+	set_tagged_addr_ctrl(current, flags, nr_bits, offset)
+#define GET_TAGGED_ADDR_CTRL(nr_bits, offset)		\
+	get_tagged_addr_ctrl(current, nr_bits, offset)
 #endif
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index ed919f633ed8..a3007f80e889 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -630,15 +630,21 @@ void arch_setup_new_exec(void)
 }
 
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
+
+#define TBI_TAG_BITS	8
+#define TBI_TAG_SHIFT	56
+
 /*
  * Control the relaxed ABI allowing tagged user addresses into the kernel.
  */
 static unsigned int tagged_addr_disabled;
 
-long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long flags,
+			  int __user *nr_bits, int __user *offset)
 {
 	unsigned long valid_mask = PR_TAGGED_ADDR_ENABLE;
 	struct thread_info *ti = task_thread_info(task);
+	int val;
 
 	if (is_compat_thread(ti))
 		return -EINVAL;
@@ -646,25 +652,41 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 	if (system_supports_mte())
 		valid_mask |= PR_MTE_TCF_MASK | PR_MTE_TAG_MASK;
 
-	if (arg & ~valid_mask)
+	if (flags & ~valid_mask)
 		return -EINVAL;
 
+	if (nr_bits) {
+		if (get_user(val, nr_bits))
+			return -EFAULT;
+		if (val > TBI_TAG_BITS || val < 1)
+			return -EINVAL;
+	}
+
 	/*
 	 * Do not allow the enabling of the tagged address ABI if globally
 	 * disabled via sysctl abi.tagged_addr_disabled.
 	 */
-	if (arg & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
+	if (flags & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
 		return -EINVAL;
 
-	if (set_mte_ctrl(task, arg) != 0)
+	if (set_mte_ctrl(task, flags) != 0)
 		return -EINVAL;
 
-	update_ti_thread_flag(ti, TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
+	if (flags & PR_TAGGED_ADDR_ENABLE) {
+		if (nr_bits && put_user(TBI_TAG_BITS, nr_bits))
+			return -EFAULT;
+		if (offset && put_user(TBI_TAG_SHIFT, offset))
+			return -EFAULT;
+	}
+
+	update_ti_thread_flag(ti, TIF_TAGGED_ADDR,
+			      flags & PR_TAGGED_ADDR_ENABLE);
 
 	return 0;
 }
 
-long get_tagged_addr_ctrl(struct task_struct *task)
+long get_tagged_addr_ctrl(struct task_struct *task,
+			  int __user *nr_bits, int __user *offset)
 {
 	long ret = 0;
 	struct thread_info *ti = task_thread_info(task);
@@ -672,8 +694,17 @@ long get_tagged_addr_ctrl(struct task_struct *task)
 	if (is_compat_thread(ti))
 		return -EINVAL;
 
-	if (test_ti_thread_flag(ti, TIF_TAGGED_ADDR))
+	if (test_ti_thread_flag(ti, TIF_TAGGED_ADDR)) {
 		ret = PR_TAGGED_ADDR_ENABLE;
+		if (nr_bits && put_user(TBI_TAG_BITS, nr_bits))
+			return -EFAULT;
+		if (offset && put_user(TBI_TAG_SHIFT, offset))
+			return -EFAULT;
+	} else {
+		/* Report maximum tag size */
+		if (nr_bits && put_user(TBI_TAG_BITS, nr_bits))
+		    return -EFAULT;
+	}
 
 	ret |= get_mte_ctrl(task);
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f49b349e16a3..3010db7ef93e 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1038,7 +1038,7 @@ static int tagged_addr_ctrl_get(struct task_struct *target,
 				const struct user_regset *regset,
 				struct membuf to)
 {
-	long ctrl = get_tagged_addr_ctrl(target);
+	long ctrl = get_tagged_addr_ctrl(target, NULL, NULL);
 
 	if (IS_ERR_VALUE(ctrl))
 		return ctrl;
@@ -1058,7 +1058,7 @@ static int tagged_addr_ctrl_set(struct task_struct *target, const struct
 	if (ret)
 		return ret;
 
-	return set_tagged_addr_ctrl(target, ctrl);
+	return set_tagged_addr_ctrl(target, ctrl, NULL, NULL);
 }
 #endif
 
diff --git a/kernel/sys.c b/kernel/sys.c
index a730c03ee607..7e968d8331cc 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -120,10 +120,10 @@
 # define PAC_RESET_KEYS(a, b)	(-EINVAL)
 #endif
 #ifndef SET_TAGGED_ADDR_CTRL
-# define SET_TAGGED_ADDR_CTRL(a)	(-EINVAL)
+# define SET_TAGGED_ADDR_CTRL(a, b, c)	(-EINVAL)
 #endif
 #ifndef GET_TAGGED_ADDR_CTRL
-# define GET_TAGGED_ADDR_CTRL()		(-EINVAL)
+# define GET_TAGGED_ADDR_CTRL(a, b)	(-EINVAL)
 #endif
 
 /*
@@ -2498,14 +2498,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = PAC_RESET_KEYS(me, arg2);
 		break;
 	case PR_SET_TAGGED_ADDR_CTRL:
-		if (arg3 || arg4 || arg5)
+		if (arg5)
 			return -EINVAL;
-		error = SET_TAGGED_ADDR_CTRL(arg2);
+		error = SET_TAGGED_ADDR_CTRL(arg2, (int __user *)arg3,
+					     (int __user *)arg4);
 		break;
 	case PR_GET_TAGGED_ADDR_CTRL:
-		if (arg2 || arg3 || arg4 || arg5)
+		if (arg4 || arg5)
 			return -EINVAL;
-		error = GET_TAGGED_ADDR_CTRL();
+		error = GET_TAGGED_ADDR_CTRL((int __user *)arg2,
+					     (int __user *)arg3);
 		break;
 	case PR_SET_IO_FLUSHER:
 		if (!capable(CAP_SYS_RESOURCE))
diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
deleted file mode 100644
index 5701163460ef..000000000000
--- a/tools/testing/selftests/arm64/tags/tags_test.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <stdint.h>
-#include <sys/prctl.h>
-#include <sys/utsname.h>
-
-#define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
-#define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
-					SHIFT_TAG(tag))
-
-int main(void)
-{
-	static int tbi_enabled = 0;
-	unsigned long tag = 0;
-	struct utsname *ptr;
-	int err;
-
-	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
-		tbi_enabled = 1;
-	ptr = (struct utsname *)malloc(sizeof(*ptr));
-	if (tbi_enabled)
-		tag = 0x42;
-	ptr = (struct utsname *)SET_TAG(ptr, tag);
-	err = uname(ptr);
-	free(ptr);
-
-	return err;
-}
diff --git a/tools/testing/selftests/arm64/tags/.gitignore b/tools/testing/selftests/vm/tags/.gitignore
similarity index 100%
rename from tools/testing/selftests/arm64/tags/.gitignore
rename to tools/testing/selftests/vm/tags/.gitignore
diff --git a/tools/testing/selftests/arm64/tags/Makefile b/tools/testing/selftests/vm/tags/Makefile
similarity index 100%
rename from tools/testing/selftests/arm64/tags/Makefile
rename to tools/testing/selftests/vm/tags/Makefile
diff --git a/tools/testing/selftests/arm64/tags/run_tags_test.sh b/tools/testing/selftests/vm/tags/run_tags_test.sh
similarity index 100%
rename from tools/testing/selftests/arm64/tags/run_tags_test.sh
rename to tools/testing/selftests/vm/tags/run_tags_test.sh
diff --git a/tools/testing/selftests/vm/tags/tags_test.c b/tools/testing/selftests/vm/tags/tags_test.c
new file mode 100644
index 000000000000..ec10a409388d
--- /dev/null
+++ b/tools/testing/selftests/vm/tags/tags_test.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/prctl.h>
+#include <sys/utsname.h>
+
+static int tag_bits;
+static int tag_offset;
+
+#define SHIFT_TAG(tag)		((uint64_t)(tag) << tag_offset)
+#define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG((1 << tag_bits) - 1)) | SHIFT_TAG(tag))
+
+static int max_tag_bits(void)
+{
+	int nr;
+
+	if (prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0) < 0)
+		return 0;
+
+	if (prctl(PR_GET_TAGGED_ADDR_CTRL, &nr, 0, 0) < 0)
+		return 8; /* Assume ARM TBI */
+
+	return nr;
+}
+
+int main(void)
+{
+	static int tags_enabled = 0;
+	unsigned long tag = 0;
+	struct utsname *ptr;
+	int err;
+
+	tag_bits = max_tag_bits();
+
+	if (tag_bits && !prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE,
+			       &tag_bits, &tag_offset, 0)) {
+		tags_enabled = 1;
+	} else if (tag_bits == 8 && !prctl(PR_SET_TAGGED_ADDR_CTRL,
+					   PR_TAGGED_ADDR_ENABLE, 0, 0)) {
+		/* ARM TBI with legacy interface*/
+		tags_enabled = 1;
+		tag_offset = 56;
+	}
+
+	ptr = (struct utsname *)malloc(sizeof(*ptr));
+	if (tags_enabled)
+		tag = (1UL << tag_bits) - 1;
+	ptr = (struct utsname *)SET_TAG(ptr, tag);
+	err = uname(ptr);
+	printf("Sysname: %s\n", ptr->sysname);
+	free(ptr);
+
+	return err;
+}
-- 
2.26.2

