Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C03031121F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhBESen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:34:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:42260 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233130AbhBEPK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:10:59 -0500
IronPort-SDR: r3riH6qbpGIT8vmK6S+qQH7F5sjPUXJcmMDeai4+/lFRuy+exgWAHp9BCJf8CfgDpRvQ4tVwHp
 jClA1osJHBug==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="161198909"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="161198909"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:16:48 -0800
IronPort-SDR: ip/ylsYftPh1by964Vt6XRsLFFDnupzXz4AAXwkNgMxWUql5a/UfNHpLQ3fbqRHXY9bTmZ8eRg
 beCVVvMka19g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="358274760"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Feb 2021 07:16:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E3F0D2C4; Fri,  5 Feb 2021 17:16:40 +0200 (EET)
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
Subject: [RFC 5/9] x86/mm: Provide untagged_addr() helper
Date:   Fri,  5 Feb 2021 18:16:26 +0300
Message-Id: <20210205151631.43511-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper used by the core-mm to strip tag bits and get the address to
the canonical shape. In only handles userspace addresses.

For LAM, the address gets sanitized according to the thread flags.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/page_32.h |  3 +++
 arch/x86/include/asm/page_64.h | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index 94dbd51df58f..a829c46ab977 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -15,6 +15,9 @@ extern unsigned long __phys_addr(unsigned long);
 #define __phys_addr_symbol(x)	__phys_addr(x)
 #define __phys_reloc_hide(x)	RELOC_HIDE((x), 0)
 
+#define untagged_addr(addr)	(addr)
+#define untagged_ptr(ptr)	(ptr)
+
 #ifdef CONFIG_FLATMEM
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #endif /* CONFIG_FLATMEM */
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 939b1cff4a7b..67cb434efdf6 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -56,6 +56,25 @@ static inline void clear_page(void *page)
 
 void copy_page(void *to, void *from);
 
+#define __untagged_addr(addr, n)	\
+	((__force __typeof__(addr))sign_extend64((__force u64)(addr), n))
+
+#define untagged_addr(addr)	({					\
+	u64 __addr = (__force u64)(addr);				\
+	if (__addr >> 63 == 0) {					\
+		if (test_thread_flag(TIF_LAM_U57))			\
+			__addr &= __untagged_addr(__addr, 56);		\
+		else if (test_thread_flag(TIF_LAM_U48))			\
+			__addr &= __untagged_addr(__addr, 47);		\
+	}								\
+	(__force __typeof__(addr))__addr;				\
+})
+
+#define untagged_ptr(ptr)	({					\
+	u64 __ptrval = (__force u64)(ptr);				\
+	__ptrval = untagged_addr(__ptrval);				\
+	(__force __typeof__(*(ptr)) *)__ptrval;				\
+})
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
-- 
2.26.2

