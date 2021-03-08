Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878BB331589
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhCHSJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:09:30 -0500
Received: from foss.arm.com ([217.140.110.172]:41786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231171AbhCHSJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:09:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8850AD6E;
        Mon,  8 Mar 2021 10:09:16 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2346E3F71B;
        Mon,  8 Mar 2021 10:09:12 -0800 (PST)
Date:   Mon, 8 Mar 2021 18:09:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v14 5/8] arm64: mte: Enable TCO in functions that can
 read beyond buffer limits
Message-ID: <20210308180910.GB17002@C02TD0UTHF1T.local>
References: <20210308161434.33424-1-vincenzo.frascino@arm.com>
 <20210308161434.33424-6-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308161434.33424-6-vincenzo.frascino@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 04:14:31PM +0000, Vincenzo Frascino wrote:
> load_unaligned_zeropad() and __get/put_kernel_nofault() functions can
> read passed some buffer limits which may include some MTE granule with a
> different tag.

s/passed/past/

> When MTE async mode is enable, the load operation crosses the boundaries

s/enabel/enabled/

> and the next granule has a different tag the PE sets the TFSR_EL1.TF1 bit
> as if an asynchronous tag fault is happened.
> 
> Enable Tag Check Override (TCO) in these functions  before the load and
> disable it afterwards to prevent this to happen.
> 
> Note: The same condition can be hit in MTE sync mode but we deal with it
> through the exception handling.
> In the current implementation, mte_async_mode flag is set only at boot
> time but in future kasan might acquire some runtime features that
> that change the mode dynamically, hence we disable it when sync mode is
> selected for future proof.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reported-by: Branislav Rankov <Branislav.Rankov@arm.com>
> Tested-by: Branislav Rankov <Branislav.Rankov@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/uaccess.h        | 24 ++++++++++++++++++++++++
>  arch/arm64/include/asm/word-at-a-time.h |  4 ++++
>  arch/arm64/kernel/mte.c                 | 22 ++++++++++++++++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 0deb88467111..a857f8f82aeb 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -188,6 +188,26 @@ static inline void __uaccess_enable_tco(void)
>  				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
>  }
>  
> +/* Whether the MTE asynchronous mode is enabled. */
> +DECLARE_STATIC_KEY_FALSE(mte_async_mode);

Can we please hide this behind something like:

static inline bool system_uses_mte_async_mode(void)
{
	return IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
		static_branch_unlikely(&mte_async_mode);
}

... like we do for system_uses_ttbr0_pan()?

That way the callers are easier to read, and kernels built without
CONFIG_KASAN_HW_TAGS don't have the static branch at all. I reckon you
can put that in one of hte mte headers and include it where needed.

Thanks,
Mark.

> +
> +/*
> + * These functions disable tag checking only if in MTE async mode
> + * since the sync mode generates exceptions synchronously and the
> + * nofault or load_unaligned_zeropad can handle them.
> + */
> +static inline void __uaccess_disable_tco_async(void)
> +{
> +	if (static_branch_unlikely(&mte_async_mode))
> +		 __uaccess_disable_tco();
> +}
> +
> +static inline void __uaccess_enable_tco_async(void)
> +{
> +	if (static_branch_unlikely(&mte_async_mode))
> +		__uaccess_enable_tco();
> +}
> +
>  static inline void uaccess_disable_privileged(void)
>  {
>  	__uaccess_disable_tco();
> @@ -307,8 +327,10 @@ do {									\
>  do {									\
>  	int __gkn_err = 0;						\
>  									\
> +	__uaccess_enable_tco_async();					\
>  	__raw_get_mem("ldr", *((type *)(dst)),				\
>  		      (__force type *)(src), __gkn_err);		\
> +	__uaccess_disable_tco_async();					\
>  	if (unlikely(__gkn_err))					\
>  		goto err_label;						\
>  } while (0)
> @@ -380,8 +402,10 @@ do {									\
>  do {									\
>  	int __pkn_err = 0;						\
>  									\
> +	__uaccess_enable_tco_async();					\
>  	__raw_put_mem("str", *((type *)(src)),				\
>  		      (__force type *)(dst), __pkn_err);		\
> +	__uaccess_disable_tco_async();					\
>  	if (unlikely(__pkn_err))					\
>  		goto err_label;						\
>  } while(0)
> diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
> index 3333950b5909..c62d9fa791aa 100644
> --- a/arch/arm64/include/asm/word-at-a-time.h
> +++ b/arch/arm64/include/asm/word-at-a-time.h
> @@ -55,6 +55,8 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>  	unsigned long ret, offset;
>  
> +	__uaccess_enable_tco_async();
> +
>  	/* Load word from unaligned pointer addr */
>  	asm(
>  	"1:	ldr	%0, %3\n"
> @@ -76,6 +78,8 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  	: "=&r" (ret), "=&r" (offset)
>  	: "r" (addr), "Q" (*(unsigned long *)addr));
>  
> +	__uaccess_disable_tco_async();
> +
>  	return ret;
>  }
>  
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index fa755cf94e01..1ad9be4c8376 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -26,6 +26,10 @@ u64 gcr_kernel_excl __ro_after_init;
>  
>  static bool report_fault_once = true;
>  
> +/* Whether the MTE asynchronous mode is enabled. */
> +DEFINE_STATIC_KEY_FALSE(mte_async_mode);
> +EXPORT_SYMBOL_GPL(mte_async_mode);
> +
>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>  {
>  	pte_t old_pte = READ_ONCE(*ptep);
> @@ -118,12 +122,30 @@ static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
>  
>  void mte_enable_kernel_sync(void)
>  {
> +	/*
> +	 * Make sure we enter this function when no PE has set
> +	 * async mode previously.
> +	 */
> +	WARN_ONCE(static_key_enabled(&mte_async_mode),
> +			"MTE async mode enabled system wide!");
> +
>  	__mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
>  }
>  
>  void mte_enable_kernel_async(void)
>  {
>  	__mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
> +
> +	/*
> +	 * MTE async mode is set system wide by the first PE that
> +	 * executes this function.
> +	 *
> +	 * Note: If in future KASAN acquires a runtime switching
> +	 * mode in between sync and async, this strategy needs
> +	 * to be reviewed.
> +	 */
> +	if (!static_branch_unlikely(&mte_async_mode))
> +		static_branch_enable(&mte_async_mode);
>  }
>  
>  void mte_set_report_once(bool state)
> -- 
> 2.30.0
> 
