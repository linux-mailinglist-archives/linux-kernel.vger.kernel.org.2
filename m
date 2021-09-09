Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC2405A65
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhIIPvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhIIPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:51:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B6C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 08:50:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i24so2109561pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ccOcs8iBHJVAAqs60NeIUiu4ZxBLFQEliRnS3en5X58=;
        b=lxRXYgQmqVK5ANKfYJsFTga6OHIZyWAvTSJc+T3OCdM5t2tzGCVusH0zrc6rKu/GSj
         oOBDX1R9qF/CVEADuAEBZ3CdkOtpUIH4XF5ahOe4ubwYS7U2s6LQmHDg5BtCtMPvfVRd
         mq48ESscoLRHzWrfjmAuc2kM4s4CLjaCBx3Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ccOcs8iBHJVAAqs60NeIUiu4ZxBLFQEliRnS3en5X58=;
        b=QCQ1wmNATQO8B5BkGKoeU7eCMAthhO+oHI8n4MDSGA37bEI4GcYq/OJ2cqzR+QIbyo
         S7quuB4V3Y+aiu/2WfVF+VJyYCI5IZGmjuHGzdlIysmDTK/dIea1r//onLTsJgJL+YQD
         DBrtlHv58h6d+i0DXPFldyASvIZFfDvebac8RDeA9B+gnzPHK9PL+NSgTHUvpHdxW4WE
         /AOO/qN3BOA7BMqepHfOrEVTEpzIbRNuSk7biakpZ5pjWcs8+NmT/P/YNE0v11ypxuIT
         AiOuTAgRcIqGw2BbVo23Y83G07d2Ss8yelRQ5rEgPHTccx2jJhryZ6byFuG8O6P4d9vA
         dgiA==
X-Gm-Message-State: AOAM532QdrdI/8ZN4PP7iccBKPPvaNKtU3L3tiEcWCm1UXgjlI/SpNUx
        SLYcTwnf4fs7okNdwA4tP359/226SeDCqA==
X-Google-Smtp-Source: ABdhPJwO0jwD30CKKYCudS1Q+gjBcvBfbtEioGoP63vHyGYU5FLrehOZO/Fn/ODlq5u9Jb9P4L5Qhw==
X-Received: by 2002:a63:7404:: with SMTP id p4mr3245964pgc.222.1631202599515;
        Thu, 09 Sep 2021 08:49:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k190sm2821106pgc.11.2021.09.09.08.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 08:49:58 -0700 (PDT)
Date:   Thu, 9 Sep 2021 08:49:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm: Use init_uts_ns.name instead of macros
Message-ID: <202109090848.129A49E8BD@keescook>
References: <20210901233406.2571643-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901233406.2571643-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 04:34:06PM -0700, Kees Cook wrote:
> Using generated/compile.h triggered a full LKDTM rebuild with every
> build. Avoid this by using the exported strings instead.
> 
> Fixes: b8661450bc7f ("lkdtm: Add kernel version to failure hints")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi Greg,

Your bot said "please wait, the merge window is open", but it'd be really
nice to get this into -rc1 to avoid annoying people doing rebuilds...

:)

-Kees

> ---
>  drivers/misc/lkdtm/core.c  | 10 ++++++++++
>  drivers/misc/lkdtm/lkdtm.h | 28 +++++++++++++++++-----------
>  2 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index 95b1c6800a22..fe6fd34b8caf 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -26,6 +26,7 @@
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/debugfs.h>
> +#include <linux/utsname.h>
>  
>  #define DEFAULT_COUNT 10
>  
> @@ -210,6 +211,8 @@ module_param(cpoint_count, int, 0644);
>  MODULE_PARM_DESC(cpoint_count, " Crash Point Count, number of times the "\
>  				"crash point is to be hit to trigger action");
>  
> +/* For test debug reporting. */
> +char *lkdtm_kernel_info;
>  
>  /* Return the crashtype number or NULL if the name is invalid */
>  static const struct crashtype *find_crashtype(const char *name)
> @@ -490,6 +493,11 @@ static int __init lkdtm_module_init(void)
>  	crash_count = cpoint_count;
>  #endif
>  
> +	/* Common initialization. */
> +	lkdtm_kernel_info = kasprintf(GFP_KERNEL, "kernel (%s %s)",
> +				      init_uts_ns.name.release,
> +				      init_uts_ns.name.machine);
> +
>  	/* Handle test-specific initialization. */
>  	lkdtm_bugs_init(&recur_count);
>  	lkdtm_perms_init();
> @@ -538,6 +546,8 @@ static void __exit lkdtm_module_exit(void)
>  	if (lkdtm_kprobe != NULL)
>  		unregister_kprobe(lkdtm_kprobe);
>  
> +	kfree(lkdtm_kernel_info);
> +
>  	pr_info("Crash point unregistered\n");
>  }
>  
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index d7d64d9765eb..c212a253edde 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -5,17 +5,17 @@
>  #define pr_fmt(fmt) "lkdtm: " fmt
>  
>  #include <linux/kernel.h>
> -#include <generated/compile.h>
> -#include <generated/utsrelease.h>
>  
> -#define LKDTM_KERNEL "kernel (" UTS_RELEASE " " UTS_MACHINE ")"
> +extern char *lkdtm_kernel_info;
>  
>  #define pr_expected_config(kconfig)				\
>  {								\
>  	if (IS_ENABLED(kconfig)) 				\
> -		pr_err("Unexpected! This " LKDTM_KERNEL " was built with " #kconfig "=y\n"); \
> +		pr_err("Unexpected! This %s was built with " #kconfig "=y\n", \
> +			lkdtm_kernel_info);			\
>  	else							\
> -		pr_warn("This is probably expected, since this " LKDTM_KERNEL " was built *without* " #kconfig "=y\n"); \
> +		pr_warn("This is probably expected, since this %s was built *without* " #kconfig "=y\n", \
> +			lkdtm_kernel_info);			\
>  }
>  
>  #ifndef MODULE
> @@ -25,24 +25,30 @@ int lkdtm_check_bool_cmdline(const char *param);
>  	if (IS_ENABLED(kconfig)) {				\
>  		switch (lkdtm_check_bool_cmdline(param)) {	\
>  		case 0:						\
> -			pr_warn("This is probably expected, since this " LKDTM_KERNEL " was built with " #kconfig "=y but booted with '" param "=N'\n"); \
> +			pr_warn("This is probably expected, since this %s was built with " #kconfig "=y but booted with '" param "=N'\n", \
> +				lkdtm_kernel_info);		\
>  			break;					\
>  		case 1:						\
> -			pr_err("Unexpected! This " LKDTM_KERNEL " was built with " #kconfig "=y and booted with '" param "=Y'\n"); \
> +			pr_err("Unexpected! This %s was built with " #kconfig "=y and booted with '" param "=Y'\n", \
> +				lkdtm_kernel_info);		\
>  			break;					\
>  		default:					\
> -			pr_err("Unexpected! This " LKDTM_KERNEL " was built with " #kconfig "=y (and booted without '" param "' specified)\n"); \
> +			pr_err("Unexpected! This %s was built with " #kconfig "=y (and booted without '" param "' specified)\n", \
> +				lkdtm_kernel_info);		\
>  		}						\
>  	} else {						\
>  		switch (lkdtm_check_bool_cmdline(param)) {	\
>  		case 0:						\
> -			pr_warn("This is probably expected, as this " LKDTM_KERNEL " was built *without* " #kconfig "=y and booted with '" param "=N'\n"); \
> +			pr_warn("This is probably expected, as this %s was built *without* " #kconfig "=y and booted with '" param "=N'\n", \
> +				lkdtm_kernel_info);		\
>  			break;					\
>  		case 1:						\
> -			pr_err("Unexpected! This " LKDTM_KERNEL " was built *without* " #kconfig "=y but booted with '" param "=Y'\n"); \
> +			pr_err("Unexpected! This %s was built *without* " #kconfig "=y but booted with '" param "=Y'\n", \
> +				lkdtm_kernel_info);		\
>  			break;					\
>  		default:					\
> -			pr_err("This is probably expected, since this " LKDTM_KERNEL " was built *without* " #kconfig "=y (and booted without '" param "' specified)\n"); \
> +			pr_err("This is probably expected, since this %s was built *without* " #kconfig "=y (and booted without '" param "' specified)\n", \
> +				lkdtm_kernel_info);		\
>  			break;					\
>  		}						\
>  	}							\
> -- 
> 2.30.2
> 

-- 
Kees Cook
