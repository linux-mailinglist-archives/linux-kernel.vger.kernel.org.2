Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F5A31158E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhBEWeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:34:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:12377 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232884AbhBEO4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:56:19 -0500
IronPort-SDR: bD8V6DYZcyHn5IgTzAk8ZPKHsFStGaBPUt51CiZLVVkCfklvVmhyzALzmz9RfZM95eHVAj4Yn/
 NC8ZieZZSwIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168561533"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="168561533"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:16:48 -0800
IronPort-SDR: iduseYam2qoeOo3j6NdDBWiD0Fn1gcerCd0wPAzSQUrrbq4J5dm7Azk3wNhvGbImTcW8SrkrnQ
 p9knQzBdFYTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="373422224"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Feb 2021 07:16:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id F057E314; Fri,  5 Feb 2021 17:16:40 +0200 (EET)
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
Subject: [RFC 6/9] x86/uaccess: Remove tags from the address before checking
Date:   Fri,  5 Feb 2021 18:16:27 +0300
Message-Id: <20210205151631.43511-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tags must not be included into check whether it's okay to access the
userspace address.

__chk_range_not_ok() is at the core or access_ok() and it's handly to
strip tags there.

get_user() and put_user() don't use access_ok(), but check access
against TASK_SIZE direcly in assembly. Strip tags, before calling into
the assembly helper.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/uaccess.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c9fa7be3df82..ee0a482b2f1f 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -18,6 +18,9 @@
  */
 static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, unsigned long limit)
 {
+	/* Remove tags from the address before comparing to the limit */
+	addr = untagged_addr(addr);
+
 	/*
 	 * If we have used "sizeof()" for the size,
 	 * we know it won't overflow the limit (but
@@ -152,7 +155,12 @@ extern int __get_user_bad(void);
  * Return: zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define get_user(x,ptr) ({ might_fault(); do_get_user_call(get_user,x,ptr); })
+#define get_user(x,ptr)							\
+({									\
+	__typeof__(*(ptr)) *__ptr_clean = untagged_ptr(ptr);		\
+	might_fault();							\
+	do_get_user_call(get_user,x,__ptr_clean);			\
+})
 
 /**
  * __get_user - Get a simple variable from user space, with less checking.
@@ -249,7 +257,11 @@ extern void __put_user_nocheck_8(void);
  *
  * Return: zero on success, or -EFAULT on error.
  */
-#define put_user(x, ptr) ({ might_fault(); do_put_user_call(put_user,x,ptr); })
+#define put_user(x, ptr) ({						\
+	__typeof__(*(ptr)) *__ptr_clean = untagged_ptr(ptr);		\
+	might_fault();							\
+	do_put_user_call(put_user,x,__ptr_clean);			\
+})
 
 /**
  * __put_user - Write a simple value into user space, with less checking.
-- 
2.26.2

