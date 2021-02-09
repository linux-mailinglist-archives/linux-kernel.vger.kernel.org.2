Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A8314E53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhBILm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhBILfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:35:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2DBB64E6C;
        Tue,  9 Feb 2021 11:35:08 +0000 (UTC)
Date:   Tue, 9 Feb 2021 11:35:06 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v12 4/7] arm64: mte: Enable TCO in functions that can
 read beyond buffer limits
Message-ID: <20210209113505.GD1435@arm.com>
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208165617.9977-5-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 04:56:14PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 0deb88467111..f43d78aee593 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -188,6 +188,21 @@ static inline void __uaccess_enable_tco(void)
>  				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
>  }
>  
> +/* Whether the MTE asynchronous mode is enabled. */
> +DECLARE_STATIC_KEY_FALSE(mte_async_mode);
> +
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

I would add a comment here along the lines of what's in the commit log:
these functions disable tag checking only if in MTE async mode since the
sync mode generates exceptions synchronously and the nofault or
load_unaligned_zeropad can handle them.

> +
>  static inline void uaccess_disable_privileged(void)
>  {
>  	__uaccess_disable_tco();
> @@ -307,8 +322,10 @@ do {									\
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
> @@ -379,9 +396,11 @@ do {									\
>  #define __put_kernel_nofault(dst, src, type, err_label)			\
>  do {									\
>  	int __pkn_err = 0;						\
> +	__uaccess_enable_tco_async();					\
>  									\

Nitpick: for consistency with the __get_kernel_nofault() function,
please move the empty line above __uaccess_enable_tco_async().

>  	__raw_put_mem("str", *((type *)(src)),				\
>  		      (__force type *)(dst), __pkn_err);		\
> +	__uaccess_disable_tco_async();					\
>  	if (unlikely(__pkn_err))					\
>  		goto err_label;						\
>  } while(0)

[...]

> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 92078e1eb627..60531afc706e 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -27,6 +27,10 @@ u64 gcr_kernel_excl __ro_after_init;
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
> @@ -170,6 +174,12 @@ void mte_enable_kernel_sync(void)
>  void mte_enable_kernel_async(void)
>  {
>  	__mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
> +
> +	/*
> +	 * This function is called on each active smp core, we do not
> +	 * to take cpu_hotplug_lock again.
> +	 */
> +	static_branch_enable_cpuslocked(&mte_async_mode);
>  }

Do we need to disable mte_async_mode in mte_enable_kernel_sync()? I
think currently that's only done at boot time but kasan may gain some
run-time features and change the mode dynamically.

-- 
Catalin
