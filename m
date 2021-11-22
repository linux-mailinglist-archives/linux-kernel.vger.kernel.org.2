Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF05458C00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbhKVKFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:05:33 -0500
Received: from foss.arm.com ([217.140.110.172]:39356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232675AbhKVKFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:05:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AE8C1042;
        Mon, 22 Nov 2021 02:02:25 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.58.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CA483F73B;
        Mon, 22 Nov 2021 02:02:24 -0800 (PST)
Date:   Mon, 22 Nov 2021 10:01:58 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: uaccess: fix put_user() with TTBR0 PAN
Message-ID: <YZtqluBcA1mjzb17@FVFF77S0Q05N>
References: <20211118163417.21617-1-vincent.whitchurch@axis.com>
 <20211119130419.GA25912@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119130419.GA25912@lakrids.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 01:04:50PM +0000, Mark Rutland wrote:
> I think it would be better to use temporaries in __raw_put_user(), along
> with a comment there, so that the requirement is documented and dealt
> with in once place. Example diff at the end of this mail; I'm happy for
> you to pick that for v2, or I can send it out as a patch if your prefer.

Looking at this again, it's easier than I thought to fix up the get_*() cases;
the only real pain point iss `err` in get_user_error() and put_user_error(),
but as those are only used externally in the architectural signal code, we can
sort that out as a follow-up.

With that in mind, I reckon we should so something like the below.

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 6e2e0b7031ab..3a5ff5e20586 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -281,12 +281,22 @@ do {									\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)
 
+/*
+ * We must not call into the scheduler between uaccess_ttbr0_enable() and
+ * uaccess_ttbr0_disable(). As `x` and `ptr` could contain blocking functions,
+ * we must evaluate these outside of the critical section.
+ */
 #define __raw_get_user(x, ptr, err)					\
 do {									\
+	__typeof__(*(ptr)) __user *__rgu_ptr = (ptr);			\
+	__typeof__(x) __rgu_val;					\
 	__chk_user_ptr(ptr);						\
+									\
 	uaccess_ttbr0_enable();						\
-	__raw_get_mem("ldtr", x, ptr, err);				\
+	__raw_get_mem("ldtr", __rgu_val, __rgu_ptr, err);		\
 	uaccess_ttbr0_disable();					\
+									\
+	(x) = __rgu_val;						\
 } while (0)
 
 #define __get_user_error(x, ptr, err)					\
@@ -310,14 +320,22 @@ do {									\
 
 #define get_user	__get_user
 
+/*
+ * We must not call into the scheduler between __uaccess_enable_tco_async() and
+ * __uaccess_disable_tco_async(). As `dst` and `src` may contain blocking
+ * functions, we must evaluate these outside of the critical section.
+ */
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
+	__typeof__(dst) __gkn_dst = (dst);				\
+	__typeof__(src) __gkn_src = (src);				\
 	int __gkn_err = 0;						\
 									\
 	__uaccess_enable_tco_async();					\
-	__raw_get_mem("ldr", *((type *)(dst)),				\
-		      (__force type *)(src), __gkn_err);		\
+	__raw_get_mem("ldr", *((type *)(__gkn_dst)),			\
+		      (__force type *)(__gkn_src), __gkn_err);		\
 	__uaccess_disable_tco_async();					\
+									\
 	if (unlikely(__gkn_err))					\
 		goto err_label;						\
 } while (0)
@@ -351,11 +369,19 @@ do {									\
 	}								\
 } while (0)
 
+/*
+ * We must not call into the scheduler between uaccess_ttbr0_enable() and
+ * uaccess_ttbr0_disable(). As `x` and `ptr` could contain blocking functions,
+ * we must evaluate these outside of the critical section.
+ */
 #define __raw_put_user(x, ptr, err)					\
 do {									\
-	__chk_user_ptr(ptr);						\
+	__typeof__(*(ptr)) __user *__rpu_ptr = (ptr);			\
+	__typeof__(*(ptr)) __rpu_val = (x);				\
+	__chk_user_ptr(__rpu_ptr);					\
+									\
 	uaccess_ttbr0_enable();						\
-	__raw_put_mem("sttr", x, ptr, err);				\
+	__raw_put_mem("sttr", __rpu_val, __rpu_ptr, err);		\
 	uaccess_ttbr0_disable();					\
 } while (0)
 
@@ -380,14 +406,22 @@ do {									\
 
 #define put_user	__put_user
 
+/*
+ * We must not call into the scheduler between __uaccess_enable_tco_async() and
+ * __uaccess_disable_tco_async(). As `dst` and `src` may contain blocking
+ * functions, we must evaluate these outside of the critical section.
+ */
 #define __put_kernel_nofault(dst, src, type, err_label)			\
 do {									\
+	__typeof__(dst) __pkn_dst = (dst);				\
+	__typeof__(src) __pkn_src = (src);				\
 	int __pkn_err = 0;						\
 									\
 	__uaccess_enable_tco_async();					\
-	__raw_put_mem("str", *((type *)(src)),				\
-		      (__force type *)(dst), __pkn_err);		\
+	__raw_put_mem("str", *((type *)(__pkn_src)),			\
+		      (__force type *)(__pkn_dst), __pkn_err);		\
 	__uaccess_disable_tco_async();					\
+									\
 	if (unlikely(__pkn_err))					\
 		goto err_label;						\
 } while(0)
-- 
2.11.0

