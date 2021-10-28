Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248BF43E290
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJ1NwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:52:08 -0400
Received: from foss.arm.com ([217.140.110.172]:55180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhJ1Nvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:51:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBF7C13A1;
        Thu, 28 Oct 2021 06:49:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C61E43F70D;
        Thu, 28 Oct 2021 06:49:20 -0700 (PDT)
Date:   Thu, 28 Oct 2021 14:49:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arch/Kconfig: Make CONFIG_CPU_SPECTRE available
 for all architectures
Message-ID: <20211028134918.GB48435@lakrids.cambridge.arm.com>
References: <cover.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <232b692cd79e4f6e4c3ee7055b5f02792a28d2c4.1635383031.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <232b692cd79e4f6e4c3ee7055b5f02792a28d2c4.1635383031.git.pawan.kumar.gupta@linux.intel.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 06:33:22PM -0700, Pawan Gupta wrote:
> Borrow CONFIG_CPU_SPECTRE from ARM to be available for all
> architectures. This will help in configuration of features that depend
> on CPU being affected by spectre class of vulnerabilities.
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Given that spectre isn't one specific issue, biut rather a blanket term
for a bunch of things that can have variable overlap, I don't think this
makes much sense unless we're going to add finer-grained options for all
the variants, and IMO it'd make more sene for the architectures to
directly select the things that'd otherwise be dependent on this.

Thanks,
Mark.

> ---
>  arch/Kconfig        | 3 +++
>  arch/arm/mm/Kconfig | 3 ---
>  arch/x86/Kconfig    | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8df1c7102643..6aa856d51cb7 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1091,6 +1091,9 @@ config ARCH_SUPPORTS_RT
>  config CPU_NO_EFFICIENT_FFS
>  	def_bool n
>  
> +config CPU_SPECTRE
> +	bool
> +
>  config HAVE_ARCH_VMAP_STACK
>  	def_bool n
>  	help
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 8355c3895894..44551465fd03 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -828,9 +828,6 @@ config CPU_BPREDICT_DISABLE
>  	help
>  	  Say Y here to disable branch prediction.  If unsure, say N.
>  
> -config CPU_SPECTRE
> -	bool
> -
>  config HARDEN_BRANCH_PREDICTOR
>  	bool "Harden the branch predictor against aliasing attacks" if EXPERT
>  	depends on CPU_SPECTRE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d9830e7e1060..769739da67c6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -124,6 +124,7 @@ config X86
>  	select CLKEVT_I8253
>  	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
>  	select CLOCKSOURCE_WATCHDOG
> +	select CPU_SPECTRE
>  	select DCACHE_WORD_ACCESS
>  	select EDAC_ATOMIC_SCRUB
>  	select EDAC_SUPPORT
> -- 
> 2.31.1
> 
