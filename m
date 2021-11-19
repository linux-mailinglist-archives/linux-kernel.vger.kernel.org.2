Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1767456F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhKSNH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:07:59 -0500
Received: from foss.arm.com ([217.140.110.172]:51448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234547AbhKSNH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:07:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F26A6D;
        Fri, 19 Nov 2021 05:04:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2809D3F70D;
        Fri, 19 Nov 2021 05:04:55 -0800 (PST)
Date:   Fri, 19 Nov 2021 13:04:50 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: uaccess: fix put_user() with TTBR0 PAN
Message-ID: <20211119130419.GA25912@lakrids.cambridge.arm.com>
References: <20211118163417.21617-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118163417.21617-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Thu, Nov 18, 2021 at 05:34:17PM +0100, Vincent Whitchurch wrote:
> The value argument to put_user() must be evaluated before the TTBR0
> switch is done.  Otherwise, if it is a function and the function sleeps,
> the reserved TTBR0 will be restored when the process is switched in
> again and the process will end up in an infinite loop of faults.

> This problem was seen with the put_user() in schedule_tail().  A similar
> fix was done for RISC-V in commit 285a76bb2cf51b0c74c634 ("riscv:
> evaluate put_user() arg before enabling user access").
> 
> Fixes: f253d827f33cb5a5990 ("arm64: uaccess: refactor __{get,put}_user")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/arm64/include/asm/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 6e2e0b7031ab..96b26fa9d3d0 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -362,10 +362,11 @@ do {									\
>  #define __put_user_error(x, ptr, err)					\
>  do {									\
>  	__typeof__(*(ptr)) __user *__p = (ptr);				\
> +	__typeof__(*(__p)) __val = (x);					\
>  	might_fault();							\
>  	if (access_ok(__p, sizeof(*__p))) {				\
>  		__p = uaccess_mask_ptr(__p);				\
> -		__raw_put_user((x), __p, (err));			\
> +		__raw_put_user(__val, __p, (err));			\
>  	} else	{							\
>  		(err) = -EFAULT;					\
>  	}								\
> -- 
> 2.33.1
> 

Thanks for this, and apolgoies for introducing this issue in the first
place. The patch looks correct to me.

There's a similar problem in __get_kernel_nofault() with TCO, and that
will need similar treatement.

I think it would be better to use temporaries in __raw_put_user(), along
with a comment there, so that the requirement is documented and dealt
with in once place. Example diff at the end of this mail; I'm happy for
you to pick that for v2, or I can send it out as a patch if your prefer.

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 6e2e0b7031ab..7c0d7a7a9a50 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -351,11 +351,19 @@ do {									\
 	}								\
 } while (0)
 
+/*
+ * We must not call into the scheduler between uaccess_ttbr0_enable() and
+ * uaccess_ttbr0_disable(). As `x` and `ptr` could contain blocking functions,
+ * we must evaluate these first.
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
 
@@ -380,14 +388,22 @@ do {									\
 
 #define put_user	__put_user
 
+/*
+ * We must not call into the scheduler between __uaccess_enable_tco_async() and
+ * __uaccess_disable_tco_async(). As `dst` and `src` may contain blocking
+ * functions, we must evaluate these first.
+ */
 #define __put_kernel_nofault(dst, src, type, err_label)			\
 do {									\
 	int __pkn_err = 0;						\
+	__typeof__(dst) __pkn_dst = (dst);				\
+	__typeof__(src) __pkn_src = (src);				\
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
