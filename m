Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD83311210
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhBESc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:32:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:42608 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233143AbhBEPL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:11:28 -0500
IronPort-SDR: NkLN0s19u8Q/8hvsgluBacSZ5pKfWvLOmlIKslq1VYpPAV+KToHycNgAG4kX28mm8ziEqRIJVL
 X2N0xHWGF6ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="161198910"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="161198910"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:16:48 -0800
IronPort-SDR: L6EeRbz108IYTNk9eBnTyBrwHatHHod7ZI3K9FukzPCs+cX2c3y9djaf9hX7BzNKfU83xCVG+5
 gmDjzeP2MZlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="358274762"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Feb 2021 07:16:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2207C411; Fri,  5 Feb 2021 17:16:41 +0200 (EET)
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
Subject: [RFC 9/9] x86/mm: Implement PR_SET/GET_TAGGED_ADDR_CTRL with LAM
Date:   Fri,  5 Feb 2021 18:16:30 +0300
Message-Id: <20210205151631.43511-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide prctl() interface to enabled LAM for user addresses. Depending
how many tag bits requested it may result in enabling LAM_U57 or
LAM_U48.

If LAM_U48 is enabled, the process is no longer able to use full address
space on 5-level paging machine and gets limited to 47-bit VA.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/processor.h |  10 +++
 arch/x86/kernel/process_64.c     | 145 +++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 82a08b585818..49fac2cc4329 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -810,6 +810,16 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
 extern int get_tsc_mode(unsigned long adr);
 extern int set_tsc_mode(unsigned int val);
 
+#ifdef CONFIG_X86_64
+long set_tagged_addr_ctrl(unsigned long flags,
+			  int __user *nr_bits, int __user *offset);
+long get_tagged_addr_ctrl(int __user *nr_bits, int __user *offset);
+#define SET_TAGGED_ADDR_CTRL(flags, nr_bits, offset)	\
+	set_tagged_addr_ctrl(flags, nr_bits, offset)
+#define GET_TAGGED_ADDR_CTRL(nr_bits, offset)		\
+	get_tagged_addr_ctrl(nr_bits, offset)
+#endif
+
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
 #ifdef CONFIG_CPU_SUP_AMD
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index df342bedea88..99b87f0e1bc7 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -837,3 +837,148 @@ unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
 }
+
+/*
+ * Control the relaxed ABI allowing tagged user addresses into the kernel.
+ */
+static unsigned int tagged_addr_disabled;
+
+static bool lam_u48_allowed(void)
+{
+	struct mm_struct *mm = current->mm;
+
+	if (!full_va_allowed(mm))
+		return true;
+
+	return find_vma(mm, DEFAULT_MAP_WINDOW) == NULL;
+}
+
+#define LAM_U48_BITS 15
+#define LAM_U57_BITS 6
+
+long set_tagged_addr_ctrl(unsigned long flags,
+			  int __user *nr_bits, int __user *offset)
+{
+	int val;
+
+	if (in_32bit_syscall())
+		return -EINVAL;
+	if (flags & ~PR_TAGGED_ADDR_ENABLE)
+		return -EINVAL;
+	if (!boot_cpu_has(X86_FEATURE_LAM))
+		return -ENOTSUPP;
+
+	/* Disable LAM */
+	if (!(flags & PR_TAGGED_ADDR_ENABLE)) {
+		clear_thread_flag(TIF_LAM_U48);
+		clear_thread_flag(TIF_LAM_U57);
+
+		/* Update CR3 */
+		switch_mm(current->mm, current->mm, current);
+
+		return 0;
+	}
+
+	/*
+	 * nr_bits == NULL || offset == NULL assumes ARM TBI (nr_bits == 8,
+	 * offset == 56). LAM cannot provide this.
+	 */
+	if (!nr_bits || !offset)
+		return -EINVAL;
+
+	/*
+	 * Do not allow the enabling of the tagged address ABI if globally
+	 * disabled via sysctl abi.tagged_addr_disabled.
+	 */
+	if (tagged_addr_disabled)
+		return -EINVAL;
+
+	if (get_user(val, nr_bits))
+		return -EFAULT;
+	if (val > LAM_U48_BITS || val < 1)
+		return -EINVAL;
+	if (val > LAM_U57_BITS && !lam_u48_allowed())
+		return -EINVAL;
+
+	val = val > LAM_U57_BITS ? LAM_U48_BITS : LAM_U57_BITS;
+	if (put_user(val, nr_bits) || put_user(63 - val, offset))
+		return -EFAULT;
+
+	if (val == LAM_U57_BITS) {
+		clear_thread_flag(TIF_LAM_U48);
+		set_thread_flag(TIF_LAM_U57);
+		if (current->mm->context.lam == LAM_NONE)
+			current->mm->context.lam = LAM_U57;
+	} else {
+		clear_thread_flag(TIF_LAM_U57);
+		set_thread_flag(TIF_LAM_U48);
+
+		/*
+		 * Do not allow to create a mapping above 47 bit.
+		 *
+		 * It's one way road: once a thread of the process enabled
+		 * LAM_U48, no thread can ever create mapping above 47 bit.
+		 * Even the LAM got disabled later.
+		 */
+		current->mm->context.lam = LAM_U48;
+	}
+
+	/* Update CR3 */
+	switch_mm(current->mm, current->mm, current);
+
+	return 0;
+}
+
+long get_tagged_addr_ctrl(int __user *nr_bits, int __user *offset)
+{
+	if (in_32bit_syscall())
+		return -EINVAL;
+
+	if (test_thread_flag(TIF_LAM_U57)) {
+		if (nr_bits && put_user(LAM_U57_BITS, nr_bits))
+			return -EFAULT;
+		if (offset && put_user(63 - LAM_U57_BITS, offset))
+			return -EFAULT;
+	} else if (test_thread_flag(TIF_LAM_U48)) {
+		if (nr_bits && put_user(LAM_U48_BITS, nr_bits))
+			return -EFAULT;
+		if (offset && put_user(63 - LAM_U48_BITS, offset))
+			return -EFAULT;
+	} else {
+		int max_bits = lam_u48_allowed() ? LAM_U48_BITS : LAM_U57_BITS;
+
+		/* Report maximum tag size */
+		if (nr_bits && put_user(max_bits, nr_bits))
+		    return -EFAULT;
+		return 0;
+	}
+
+	return PR_TAGGED_ADDR_ENABLE;
+}
+
+/*
+ * Global sysctl to disable the tagged user addresses support. This control
+ * only prevents the tagged address ABI enabling via prctl() and does not
+ * disable it for tasks that already opted in to the relaxed ABI.
+ */
+
+static struct ctl_table tagged_addr_sysctl_table[] = {
+	{
+		.procname	= "tagged_addr_disabled",
+		.mode		= 0644,
+		.data		= &tagged_addr_disabled,
+		.maxlen		= sizeof(int),
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
+static int __init tagged_addr_init(void)
+{
+	if (!register_sysctl("abi", tagged_addr_sysctl_table))
+		return -EINVAL;
+	return 0;
+}
+core_initcall(tagged_addr_init);
-- 
2.26.2

