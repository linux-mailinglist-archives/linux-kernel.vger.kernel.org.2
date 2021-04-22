Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40B6368344
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbhDVP0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237431AbhDVP0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:26:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C73B61450;
        Thu, 22 Apr 2021 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619105173;
        bh=xX6LHIsRNYix3onntFIfW+HfRKfpkeI2B6kAC3uJGjo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NL/wD7kcp0LWQl8BHPTRtH4K8sjhyKxz8dKu6JJ9zex8W02AVjrKwc5oGH2wjR5Ft
         V963FDtSwb1VGuEUtLls82/088eRox+90An9FjfNvkS7cRXfmO5OCtgIXcz0yivw34
         xsv0pms4da82pN0nCDee+PRiM6J/sNMWp7XJ/Nmitq5KztZWojtLacg9DCQUzylJnW
         4d1XR5X8B1YxODY0iCMTdUPJhb0uEnVHEZHc9S0U/9j/FMHGX1vRpVvW1dWu3BU5Yg
         7GfPfdUrnmlLb0XUE+0lhUgmcIQBvVpnv+fgmyWuQLw/9ZRiG/UbHJFgHswa2yzZT3
         IJv7sjAqo/Xug==
Date:   Thu, 22 Apr 2021 08:26:12 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Juergen Gross <jgross@suse.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] xen: check required Xen features
In-Reply-To: <20210422151007.2205-2-jgross@suse.com>
Message-ID: <alpine.DEB.2.21.2104220823160.5018@sstabellini-ThinkPad-T480s>
References: <20210422151007.2205-1-jgross@suse.com> <20210422151007.2205-2-jgross@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021, Juergen Gross wrote:
> Linux kernel is not supported to run on Xen versions older than 4.0.
> 
> Add tests for required Xen features always being present in Xen 4.0
> and newer.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/xen/features.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/xen/features.c b/drivers/xen/features.c
> index 25c053b09605..60503299c9bc 100644
> --- a/drivers/xen/features.c
> +++ b/drivers/xen/features.c
> @@ -9,13 +9,26 @@
>  #include <linux/types.h>
>  #include <linux/cache.h>
>  #include <linux/export.h>
> +#include <linux/printk.h>
>  
>  #include <asm/xen/hypercall.h>
>  
> +#include <xen/xen.h>
>  #include <xen/interface/xen.h>
>  #include <xen/interface/version.h>
>  #include <xen/features.h>
>  
> +/*
> + * Linux kernel expects at least Xen 4.0.
> + *
> + * Assume some features to be available for that reason (depending on guest
> + * mode, of course).
> + */
> +#define chk_feature(f) {						\
> +		if (!xen_feature(f))					\
> +			pr_err("Xen: feature %s not available!\n", #f);	\
> +	}

I think this could be done as a static inline function in
include/xen/features.h. That way it would be available everywhere. Also,
static inlines are better than macro when it is possible to use them in
terms of code safety.


>  u8 xen_features[XENFEAT_NR_SUBMAPS * 32] __read_mostly;
>  EXPORT_SYMBOL_GPL(xen_features);
>  
> @@ -31,4 +44,9 @@ void xen_setup_features(void)
>  		for (j = 0; j < 32; j++)
>  			xen_features[i * 32 + j] = !!(fi.submap & 1<<j);
>  	}
> +
> +	if (xen_pv_domain()) {
> +		chk_feature(XENFEAT_mmu_pt_update_preserve_ad);
> +		chk_feature(XENFEAT_gnttab_map_avail_bits);
> +	}
>  }
> -- 
> 2.26.2
> 
