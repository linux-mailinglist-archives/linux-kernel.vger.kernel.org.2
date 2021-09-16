Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8440D0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhIPA3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:29:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:52887 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233582AbhIPA32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:29:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="222113650"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="222113650"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 17:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545253391"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Sep 2021 17:28:01 -0700
Date:   Wed, 15 Sep 2021 17:27:35 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Marcus =?iso-8859-1?Q?R=FCckert?= <mrueckert@suse.com>
Subject: Re: [PATCH] x86/umip: Downgrade warning messages to debug loglevel
Message-ID: <20210916002735.GA9330@ranerica-svr.sc.intel.com>
References: <20210907200454.30458-1-bp@alien8.de>
 <20210911011459.GA11980@ranerica-svr.sc.intel.com>
 <YTx0+0pfyzHuX80L@zn.tnic>
 <20210913213836.GA10627@ranerica-svr.sc.intel.com>
 <YUDTCgEOZ3JOMSl7@zn.tnic>
 <20210915113410.GA7130@ranerica-svr.sc.intel.com>
 <YUIHPOmSQyZSkMaC@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUIHPOmSQyZSkMaC@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 04:46:20PM +0200, Borislav Petkov wrote:
> On Wed, Sep 15, 2021 at 04:34:10AM -0700, Ricardo Neri wrote:
> > The goal at the time was encourage users to report bugs on the
> > applications and eventually have them fixed. It also meant to warn users
> > about degraded performance due to emulation. To my knowledge, no one has
> > reported the latter thus far.
> 
> Probably because people do not even get to need UMIP a whole lot,
> apparently.
> 
> > Since after almost 4 years, performance degradation does not seem to be a
> > concern, I think it is sensible to remove the warnings.
> 
> Yap.
> 
> > They could also be salvaged by converting them to umiip_pr_debug(), just
> > to err on the cautious side without having to add a new command line
> > argument.
> 
> Yap, that's a good idea too:
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 15 Sep 2021 16:39:18 +0200
> Subject: [PATCH] x86/umip: Downgrade warning messages to debug loglevel
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> After four years in the wild, those have not fullfilled their
> initial purpose of pushing people to fix their software to not use
> UMIP-emulated instructions, and to warn users about the degraded
> emulation performance.
> 
> Yet, the only thing that "degrades" performance is overflowing dmesg
> with those:
> 
>   [Di Sep  7 00:24:05 2021] umip_printk: 1345 callbacks suppressed
>   [Di Sep  7 00:24:05 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b7c0: SIDT instruction cannot be used by applications.
>   [Di Sep  7 00:24:05 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b7c0: For now, expensive software emulation returns the result.
>   ...
>   [Di Sep  7 00:26:06 2021] umip_printk: 2227 callbacks suppressed
>   [Di Sep  7 00:26:06 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b940: SIDT instruction cannot be used by applications.
> 
> and users don't really care about that - they just want to play their
> games in wine.
> 
> So convert those to debug loglevel - in case someone is still interested
> in them, someone can boot with "debug" on the kernel cmdline.
> 
> Reported-by: Marcus Rückert <mrueckert@suse.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/20210907200454.30458-1-bp@alien8.de
> ---
>  arch/x86/kernel/umip.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 576b47e7523d..5a4b21389b1d 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -92,8 +92,8 @@ static const char * const umip_insns[5] = {
>  
>  #define umip_pr_err(regs, fmt, ...) \
>  	umip_printk(regs, KERN_ERR, fmt, ##__VA_ARGS__)
> -#define umip_pr_warn(regs, fmt, ...) \
> -	umip_printk(regs, KERN_WARNING, fmt,  ##__VA_ARGS__)
> +#define umip_pr_debug(regs, fmt, ...) \
> +	umip_printk(regs, KERN_DEBUG, fmt,  ##__VA_ARGS__)
>  
>  /**
>   * umip_printk() - Print a rate-limited message
> @@ -361,10 +361,10 @@ bool fixup_umip_exception(struct pt_regs *regs)
>  	if (umip_inst < 0)
>  		return false;
>  
> -	umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
> +	umip_pr_debug(regs, "%s instruction cannot be used by applications.\n",
>  			umip_insns[umip_inst]);
>  
> -	umip_pr_warn(regs, "For now, expensive software emulation returns the result.\n");
> +	umip_pr_debug(regs, "For now, expensive software emulation returns the result.\n");
>  
>  	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
>  			      user_64bit_mode(regs)))

FWIW, Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thanks and BR,
Ricardo
