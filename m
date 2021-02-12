Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90EA31A37C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBLRWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhBLRWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:22:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34C1964E42;
        Fri, 12 Feb 2021 17:21:31 +0000 (UTC)
Date:   Fri, 12 Feb 2021 17:21:28 +0000
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
Subject: Re: [PATCH v13 4/7] arm64: mte: Enable TCO in functions that can
 read beyond buffer limits
Message-ID: <20210212172128.GE7718@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211153353.29094-5-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 03:33:50PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 706b7ab75f31..65ecb86dd886 100644
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
> @@ -119,12 +123,24 @@ static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
>  void mte_enable_kernel_sync(void)
>  {
>  	__mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
> +
> +	/*
> +	 * This function is called on each active smp core at boot
> +	 * time, hence we do not need to take cpu_hotplug_lock again.
> +	 */
> +	static_branch_disable_cpuslocked(&mte_async_mode);
>  }
>  EXPORT_SYMBOL_GPL(mte_enable_kernel_sync);
>  
>  void mte_enable_kernel_async(void)
>  {
>  	__mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
> +
> +	/*
> +	 * This function is called on each active smp core at boot
> +	 * time, hence we do not need to take cpu_hotplug_lock again.
> +	 */
> +	static_branch_enable_cpuslocked(&mte_async_mode);
>  }

Sorry, I missed the cpuslocked aspect before. Is there any reason you
need to use this API here? I suggested to add it to the
mte_enable_kernel_sync() because kasan may at some point do this
dynamically at run-time, so the boot-time argument doesn't hold. But
it's also incorrect as this function will be called for hot-plugged
CPUs as well after boot.

The only reason for static_branch_*_cpuslocked() is if it's called from
a region that already invoked cpus_read_lock() which I don't think is
the case here.

-- 
Catalin
