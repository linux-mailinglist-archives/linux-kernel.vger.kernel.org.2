Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F874310E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhJRG6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:58:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:25893 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhJRG6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:58:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="228131545"
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="228131545"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 23:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="489304579"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga007.fm.intel.com with SMTP; 17 Oct 2021 23:56:00 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 18 Oct 2021 09:55:59 +0300
Date:   Mon, 18 Oct 2021 09:55:59 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ser Olmy <ser.olmy@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YW0af/LXlfi36HZt@intel.com>
References: <YWg+O1AXrWLO3Sf9@zn.tnic>
 <YWg/5h3OcQKE94Nz@intel.com>
 <YWhCAqDxAuTh1YwE@intel.com>
 <YWhFOJCF1pxIBANv@zn.tnic>
 <YWhG0kv/d/hddf+t@intel.com>
 <YWhsvSM5tAvwqprN@intel.com>
 <YWhwdDI5ECoMZQzU@zn.tnic>
 <YWh7GgCgdtwRj3GU@intel.com>
 <YWiAPQCRm4RnOiCd@zn.tnic>
 <YWlgPJwxmFL5nX4c@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWlgPJwxmFL5nX4c@zn.tnic>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 01:04:28PM +0200, Borislav Petkov wrote:
> Ok, here it is.

Thanks. I got distracted by other shiny objects anyway, so
wouldn't even have gotten to cooking up a proper patch until
now.

> 
> Ser, I'd appreciate you running it too, to make sure your box is still
> ok.
> 
> Thx.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Fri, 15 Oct 2021 12:46:25 +0200
> Subject: [PATCH] x86/fpu: Mask out the invalid MXCSR bits properly
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This is a fix for the fix (yeah, /facepalm).
> 
> The correct mask to use is not the negation of the MXCSR_MASK but the
> actual mask which contains the supported bits in the MXCSR register.
> 
> Reported and debugged by Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Fixes: d298b03506d3 ("x86/fpu: Restore the masking out of reserved MXCSR bits")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/YWgYIYXLriayyezv@intel.com
> ---
>  arch/x86/kernel/fpu/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index fa17a27390ab..831b25c5e705 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -385,7 +385,7 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
>  				return -EINVAL;
>  		} else {
>  			/* Mask invalid bits out for historical reasons (broken hardware). */
> -			fpu->state.fxsave.mxcsr &= ~mxcsr_feature_mask;
> +			fpu->state.fxsave.mxcsr &= mxcsr_feature_mask;
>  		}
>  
>  		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
> -- 
> 2.29.2
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Ville Syrjälä
Intel
