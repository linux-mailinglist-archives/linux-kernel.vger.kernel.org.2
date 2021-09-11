Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DFC407456
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 03:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhIKBQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 21:16:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:55831 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234989AbhIKBQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 21:16:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="219349208"
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="219349208"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 18:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="467538684"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 10 Sep 2021 18:15:20 -0700
Date:   Fri, 10 Sep 2021 18:14:59 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Marcus =?iso-8859-1?Q?R=FCckert?= <mrueckert@suse.com>
Subject: Re: [PATCH] x86/umip: Add a umip= cmdline switch
Message-ID: <20210911011459.GA11980@ranerica-svr.sc.intel.com>
References: <20210907200454.30458-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210907200454.30458-1-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 10:04:54PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> And add the first control option
> 
>   umip=warnings_off
> 
> which disables warnings resulting from emulating UMIP-enabled insns.
> 
> The actual use case is for users playing games in wine, games like
> Overwatch, for example, which go nuts with SIDT:
> 
>   [Di Sep  7 00:24:05 2021] umip_printk: 1345 callbacks suppressed
>   [Di Sep  7 00:24:05 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b7c0: SIDT instruction cannot be used by applications.
>   [Di Sep  7 00:24:05 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b7c0: For now, expensive software emulation returns the result.
>   ...
>   [Di Sep  7 00:26:06 2021] umip_printk: 2227 callbacks suppressed
>   [Di Sep  7 00:26:06 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b940: SIDT instruction cannot be used by applications.
> 
> filling up the kernel log unnecessarily with the same info over and over
> again which doesn't mean a whit to the users - they just wanna play.
> 
> So add a boot-time control switch for those warning messages.
> 
> Reported-by: Marcus Rückert <mrueckert@suse.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++
>  arch/x86/kernel/umip.c                        | 33 +++++++++++++++++--
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 828d11441ebf..815d022c3e87 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5887,6 +5887,11 @@
>  	unknown_nmi_panic
>  			[X86] Cause panic on unknown NMI.
>  
> +	umip=warnings_off
> +			[X86]
> +			* warnings_off - do not issue warnings when emulating
> +			  UMIP-enabled instructions.
> +
>  	usbcore.authorized_default=
>  			[USB] Default USB device authorization:
>  			(default -1 = authorized except for wireless USB,
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 576b47e7523d..1d37dc626011 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -90,10 +90,19 @@ static const char * const umip_insns[5] = {
>  	[UMIP_INST_STR] = "STR",
>  };
>  
> -#define umip_pr_err(regs, fmt, ...) \
> +static struct umip_config {
> +	__u64 warnings_off	: 1,
> +	      __reserved	: 63;
> +} umip_cfg;
> +
> +#define umip_pr_err(regs, fmt, ...)				\
>  	umip_printk(regs, KERN_ERR, fmt, ##__VA_ARGS__)
> -#define umip_pr_warn(regs, fmt, ...) \
> -	umip_printk(regs, KERN_WARNING, fmt,  ##__VA_ARGS__)
> +
> +#define umip_pr_warn(regs, fmt, ...)					\
> +({									\
> +	if (!umip_cfg.warnings_off)					\
> +		umip_printk(regs, KERN_WARNING, fmt,  ##__VA_ARGS__);	\

If it is printing the same information again and again, wouldn't it be
simpler to have a umip_pr_warn_once()?

Thanks and BR,
Ricardo
