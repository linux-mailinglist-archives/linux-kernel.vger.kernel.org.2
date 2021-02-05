Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF1311724
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBEXbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:31:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhBEOXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:23:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A7DE650F0;
        Fri,  5 Feb 2021 15:39:22 +0000 (UTC)
Date:   Fri, 5 Feb 2021 15:39:19 +0000
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
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v11 4/5] arm64: mte: Enable async tag check fault
Message-ID: <20210205153918.GA12697@gaia>
References: <20210130165225.54047-1-vincenzo.frascino@arm.com>
 <20210130165225.54047-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130165225.54047-5-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 04:52:24PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 92078e1eb627..7763ac1f2917 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -182,6 +182,37 @@ bool mte_report_once(void)
>  	return READ_ONCE(report_fault_once);
>  }
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +void mte_check_tfsr_el1(void)
> +{
> +	u64 tfsr_el1;
> +
> +	if (!system_supports_mte())
> +		return;
> +
> +	tfsr_el1 = read_sysreg_s(SYS_TFSR_EL1);
> +
> +	/*
> +	 * The kernel should never trigger an asynchronous fault on a
> +	 * TTBR0 address, so we should never see TF0 set.
> +	 * For futexes we disable checks via PSTATE.TCO.
> +	 */
> +	WARN_ONCE(tfsr_el1 & SYS_TFSR_EL1_TF0,
> +		  "Kernel async tag fault on TTBR0 address");

Sorry, I got confused when I suggested this warning. If the user is
running in async mode, the TFSR_EL1.TF0 bit may be set by
copy_mount_options(), strncpy_from_user() which rely on an actual fault
happening (not the case with asynchronous where only a bit is set). With
the user MTE support, we never report asynchronous faults caused by the
kernel on user addresses as we can't easily track them. So this warning
may be triggered on correctly functioning kernel/user.

> +
> +	if (unlikely(tfsr_el1 & SYS_TFSR_EL1_TF1)) {
> +		/*
> +		 * Note: isb() is not required after this direct write
> +		 * because there is no indirect read subsequent to it
> +		 * (per ARM DDI 0487F.c table D13-1).
> +		 */
> +		write_sysreg_s(0, SYS_TFSR_EL1);

Zeroing the whole register is still fine, we don't care about the TF0
bit anyway.

> +
> +		kasan_report_async();
> +	}
> +}
> +#endif

-- 
Catalin
