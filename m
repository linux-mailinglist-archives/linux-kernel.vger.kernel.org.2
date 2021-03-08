Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EF0330AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhCHKOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:14:20 -0500
Received: from foss.arm.com ([217.140.110.172]:35374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231866AbhCHKNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:13:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4642531B;
        Mon,  8 Mar 2021 02:13:51 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201D53F73C;
        Mon,  8 Mar 2021 02:13:49 -0800 (PST)
Date:   Mon, 8 Mar 2021 10:13:47 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 08/11] entry: Make CONFIG_DEBUG_ENTRY available
 outside x86
Message-ID: <20210308101347.GD7951@C02TD0UTHF1T.local>
References: <cover.1614884673.git.luto@kernel.org>
 <d5b13da88adf4e732a07fe709263e572cb5ca8de.1614884673.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b13da88adf4e732a07fe709263e572cb5ca8de.1614884673.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:06:01AM -0800, Andy Lutomirski wrote:
> In principle, the generic entry code is generic, and the goal is to use it
> in many architectures once it settles down more.  Move CONFIG_DEBUG_ENTRY
> to the generic config so that it can be used in the generic entry code and
> not just in arch/x86.
> 
> Disable it on arm64.  arm64 uses some but not all of the kentry
> code, and trying to debug the resulting state machine will be painful.
> arm64 can turn it back on when it starts using the entire generic
> path.

Can we make this depend on CONFIG_GENERIC_ENTRY instead of !ARM64?
That'd be more in line with "use the generic entry code, get the generic
functionality". Note that arm64 doesn't select CONFIG_GENERIC_ENTRY
today.

I see that s390 selects CONFIG_GENERIC_ENTRY, and either way this will
enable DEBUG_ENTRY for them, so it'd ve worth checking whether this is
ok for them.

Sven, thoughts?

Thanks,
Mark.

> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/Kconfig.debug | 10 ----------
>  lib/Kconfig.debug      | 11 +++++++++++
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index 80b57e7f4947..a5a52133730c 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -170,16 +170,6 @@ config CPA_DEBUG
>  	help
>  	  Do change_page_attr() self-tests every 30 seconds.
>  
> -config DEBUG_ENTRY
> -	bool "Debug low-level entry code"
> -	depends on DEBUG_KERNEL
> -	help
> -	  This option enables sanity checks in x86's low-level entry code.
> -	  Some of these sanity checks may slow down kernel entries and
> -	  exits or otherwise impact performance.
> -
> -	  If unsure, say N.
> -
>  config DEBUG_NMI_SELFTEST
>  	bool "NMI Selftest"
>  	depends on DEBUG_KERNEL && X86_LOCAL_APIC
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7937265ef879..76549c8afa8a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1411,6 +1411,17 @@ config CSD_LOCK_WAIT_DEBUG
>  
>  endmenu # lock debugging
>  
> +config DEBUG_ENTRY
> +	bool "Debug low-level entry code"
> +	depends on DEBUG_KERNEL
> +	depends on !ARM64
> +	help
> +	  This option enables sanity checks in the low-level entry code.
> +	  Some of these sanity checks may slow down kernel entries and
> +	  exits or otherwise impact performance.
> +
> +	  If unsure, say N.
> +
>  config TRACE_IRQFLAGS
>  	depends on TRACE_IRQFLAGS_SUPPORT
>  	bool
> -- 
> 2.29.2
> 
