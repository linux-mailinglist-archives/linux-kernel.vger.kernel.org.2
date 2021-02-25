Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C783252D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 16:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBYP44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 10:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhBYP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 10:56:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C25C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:56:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d11so5734754wrj.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IKK5Sk4xYKEQS6he6oFH14uzFoBWOsLEHulMdGPTh3s=;
        b=Rf7dYtwjQhhovLSRhQ++Yw2wPK4miSxmPQp+4AVUVIksnPY1j4FrbB90Gkfovz3njH
         Twrir59gr01W9OudUEgazdYm0MHK0yiyAid99ozreQuRf/KE6p2NWw/XfA7jRc01lDdW
         KY6kndFd/BSJQdsPnsmqW/2hDWF2/CpsmBnAN4d/Jf2x28RXxEJ79vBIqpGm4IwrVRrT
         Gw3nvPwZdSa6usNGKf3zlgozi6zfBt19Y/oPzakvwhCUPFt7goKzfLb+wuPMoBD4k1UZ
         LdeWizKmUC8988+3SKp5SR4SRVbK1pE3LNaA82fWqOSY9tXswNtu2Q8x59rLS6Kof26p
         x84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IKK5Sk4xYKEQS6he6oFH14uzFoBWOsLEHulMdGPTh3s=;
        b=mMxmI6FyV3TkTA44OGEvzF0/QZBnyvhyP8STyCYujyhPzxC0rzIjd/pYbkygy4Qunx
         sPuLTqKjNTVVLxABl4x0MhSl/OMto8DvtKtVctJRaUz/koEIvAb6AM1qv3bs4uwUPPtG
         mT+NJikUhuXsJ0j8LdW6aQ9HhwJzlJoNy9Sg+L7vgbPclx2AZFwBFfxPcNdoXkRlonJ4
         y93wnnQPOm9CI1CZby1fCDy+6mgteQrbrhTDrJcXr9/ObbhaMYzm2DPMaLDlAUTZYj0/
         rtF0EhX3R+1WqNlphS9X7DpoTzh3j3skn8+ymMTrHYBrcX5nqAhqLZs1+KqI4UrepFGZ
         /urg==
X-Gm-Message-State: AOAM533lRF7D+q2UI9K4Q+gt2GkdyUX2sn0ArcAa5fWiAQhAVm+IlNp4
        hqYZo2NTEgL+MWchvb4NxT51wPXsxWmmqRo1
X-Google-Smtp-Source: ABdhPJw+xUtDhcz+Elc3MHEJH7TS3rs1JsepsMJ+0YIIlvr3DGy2rg/ANGnfX5KSvscV5KGb4yGpXQ==
X-Received: by 2002:adf:8104:: with SMTP id 4mr4193667wrm.265.1614268569651;
        Thu, 25 Feb 2021 07:56:09 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id x18sm8702512wrs.16.2021.02.25.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 07:56:09 -0800 (PST)
Date:   Thu, 25 Feb 2021 15:56:07 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, akpm@linux-foundation.org,
        mhiramat@kernel.org, rostedt@goodmis.org,
        jason.wessel@windriver.com, dianders@chromium.org,
        peterz@infradead.org, stefan.saecherl@fau.de,
        qy15sije@cip.cs.fau.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb: Fix to kill breakpoints on initmem after boot
Message-ID: <20210225155607.634snzzq3w62kpkn@maple.lan>
References: <20210224081652.587785-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224081652.587785-1-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 01:46:52PM +0530, Sumit Garg wrote:
> Currently breakpoints in kernel .init.text section are not handled
> correctly while allowing to remove them even after corresponding pages
> have been freed.
> 
> Fix it via killing .init.text section breakpoints just prior to initmem
> pages being freed.
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I saw Andrew has picked this one up. That's ok for me:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

I already enriched kgdbtest to cover this (and they pass) so I guess
this is also:
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>

BTW this is not Cc:ed to stable and I do wonder if it crosses the
threshold to be considered a fix rather than a feature. Normally I
consider adding safety rails for kgdb to be a new feature but, in this
case, the problem would easily ensnare an inexperienced developer who is
doing nothing more than debugging their own driver (assuming they
correctly marked their probe function as .init) so I think this weighs
in favour of being a fix.


Daniel.


> ---
>  include/linux/kgdb.h      |  2 ++
>  init/main.c               |  1 +
>  kernel/debug/debug_core.c | 11 +++++++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 57b8885708e5..3aa503ef06fc 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -361,9 +361,11 @@ extern atomic_t			kgdb_active;
>  extern bool dbg_is_early;
>  extern void __init dbg_late_init(void);
>  extern void kgdb_panic(const char *msg);
> +extern void kgdb_free_init_mem(void);
>  #else /* ! CONFIG_KGDB */
>  #define in_dbg_master() (0)
>  #define dbg_late_init()
>  static inline void kgdb_panic(const char *msg) {}
> +static inline void kgdb_free_init_mem(void) { }
>  #endif /* ! CONFIG_KGDB */
>  #endif /* _KGDB_H_ */
> diff --git a/init/main.c b/init/main.c
> index c68d784376ca..a446ca3d334e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1417,6 +1417,7 @@ static int __ref kernel_init(void *unused)
>  	async_synchronize_full();
>  	kprobe_free_init_mem();
>  	ftrace_free_init_mem();
> +	kgdb_free_init_mem();
>  	free_initmem();
>  	mark_readonly();
>  
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 229dd119f430..319381e95d1d 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -465,6 +465,17 @@ int dbg_remove_all_break(void)
>  	return 0;
>  }
>  
> +void kgdb_free_init_mem(void)
> +{
> +	int i;
> +
> +	/* Clear init memory breakpoints. */
> +	for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
> +		if (init_section_contains((void *)kgdb_break[i].bpt_addr, 0))
> +			kgdb_break[i].state = BP_UNDEFINED;
> +	}
> +}
> +
>  #ifdef CONFIG_KGDB_KDB
>  void kdb_dump_stack_on_cpu(int cpu)
>  {
> -- 
> 2.25.1
