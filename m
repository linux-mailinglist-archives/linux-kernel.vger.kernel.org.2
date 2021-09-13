Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36E409F55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 23:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbhIMVqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 17:46:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:46232 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238184AbhIMVqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 17:46:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307354772"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307354772"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 14:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="582564938"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2021 14:45:27 -0700
Date:   Mon, 13 Sep 2021 14:45:03 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Marcus =?iso-8859-1?Q?R=FCckert?= <mrueckert@suse.com>
Subject: Re: [PATCH] x86/umip: Add a umip= cmdline switch
Message-ID: <20210913214503.GB10627@ranerica-svr.sc.intel.com>
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
> +})
>  
>  /**
>   * umip_printk() - Print a rate-limited message
> @@ -407,5 +416,23 @@ bool fixup_umip_exception(struct pt_regs *regs)
>  
>  	/* increase IP to let the program keep going */
>  	regs->ip += insn.length;
> +

Strictly, this hunk does not logically belong to this patch. I guess it
is harmless, though. Admittedly, the new line should have been there
since umip.c was added.

>  	return true;
>  }
> +
> +static int __init parse_umip_param(char *str)
> +{
> +	if (!str)
> +		return 0;
> +
> +	if (*str == '=')
> +		str++;
> +
> +	if (!strcmp(str, "warnings_off"))
> +		umip_cfg.warnings_off = 1;
> +	else
> +		return 0;
> +
> +	return 1;
> +}
> +__setup("umip", parse_umip_param);

Wouldn't it be better to use parse_option_str() with __setup("umip=",
parse_umip_param)? This would avoid the first two checks.

Thanks and BR,
Ricardo
