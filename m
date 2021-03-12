Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F73390EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhCLPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhCLPNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:13:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5C7964FD9;
        Fri, 12 Mar 2021 15:13:02 +0000 (UTC)
Date:   Fri, 12 Mar 2021 15:13:00 +0000
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
Subject: Re: [PATCH v15 5/8] arm64: mte: Enable TCO in functions that can
 read beyond buffer limits
Message-ID: <20210312151259.GB24210@arm.com>
References: <20210312142210.21326-1-vincenzo.frascino@arm.com>
 <20210312142210.21326-6-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312142210.21326-6-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 02:22:07PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 9b557a457f24..8603c6636a7d 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -90,5 +90,20 @@ static inline void mte_assign_mem_tag_range(void *addr, size_t size)
>  
>  #endif /* CONFIG_ARM64_MTE */
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +/* Whether the MTE asynchronous mode is enabled. */
> +DECLARE_STATIC_KEY_FALSE(mte_async_mode);
> +
> +static inline bool system_uses_mte_async_mode(void)
> +{
> +	return static_branch_unlikely(&mte_async_mode);
> +}
> +#else
> +static inline bool system_uses_mte_async_mode(void)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_KASAN_HW_TAGS */

You can write this with fewer lines:

DECLARE_STATIC_KEY_FALSE(mte_async_mode);

static inline bool system_uses_mte_async_mode(void)
{
	return IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
		static_branch_unlikely(&mte_async_mode);
}

The compiler will ensure that mte_async_mode is not referred when
!CONFIG_KASAN_HW_TAGS and therefore doesn't need to be defined.

> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index fa755cf94e01..9362928ba0d5 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -26,6 +26,10 @@ u64 gcr_kernel_excl __ro_after_init;
>  
>  static bool report_fault_once = true;
>  
> +/* Whether the MTE asynchronous mode is enabled. */
> +DEFINE_STATIC_KEY_FALSE(mte_async_mode);
> +EXPORT_SYMBOL_GPL(mte_async_mode);

Maybe keep these bracketed by #ifdef CONFIG_KASAN_HW_TAGS. I think the
mte_enable_kernel_*() aren't needed either if KASAN_HW is disabled (you
can do it with an additional patch).

With these, you can add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
