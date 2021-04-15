Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4FB360F67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhDOPvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:51:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:36388 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233052AbhDOPvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:51:09 -0400
IronPort-SDR: qfDxdRRWlHEDuZKMHpVifT1jRu0JvRBWnpG6UoM3sMD7KgBsF7QpNDbGJdoddn4NNgKzWlfWjh
 ktZ5VgtA7MxA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="280192772"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="280192772"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 08:50:43 -0700
IronPort-SDR: lhluqeXrSSgzmFMmrkJm9YGQF6Ah1BYE/QTlAHpmuvIDMXRnpQoJV872zukMofZbYqmeIddV2D
 7MvpaAqiXWDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="384053803"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga006.jf.intel.com with SMTP; 15 Apr 2021 08:50:38 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 15 Apr 2021 18:50:37 +0300
Date:   Thu, 15 Apr 2021 18:50:37 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jon Bloomfield <jon.bloomfield@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915: Fix "mitigations" parsing if i915 is builtin
Message-ID: <YHhgzVkSDDkm95FJ@intel.com>
References: <20210414140643.620c3adb@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210414140643.620c3adb@xhacker.debian>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:06:43PM +0800, Jisheng Zhang wrote:
> I met below error during boot with i915 builtin if pass
> "i915.mitigations=off":
> [    0.015589] Booting kernel: `off' invalid for parameter `i915.mitigations'
> 
> The reason is slab subsystem isn't ready at that time, so kstrdup()
> returns NULL. Fix this issue by using stack var instead of kstrdup().
> 
> Fixes: 984cadea032b ("drm/i915: Allow the sysadmin to override security mitigations")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> Since v1:
>  - Ensure "str" is properly terminated. Thanks Ville for pointing this out.
> 
>  drivers/gpu/drm/i915/i915_mitigations.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_mitigations.c b/drivers/gpu/drm/i915/i915_mitigations.c
> index 84f12598d145..231aad5ff46c 100644
> --- a/drivers/gpu/drm/i915/i915_mitigations.c
> +++ b/drivers/gpu/drm/i915/i915_mitigations.c
> @@ -29,15 +29,14 @@ bool i915_mitigate_clear_residuals(void)
>  static int mitigations_set(const char *val, const struct kernel_param *kp)
>  {
>  	unsigned long new = ~0UL;
> -	char *str, *sep, *tok;
> +	char str[64], *sep, *tok;
>  	bool first = true;
>  	int err = 0;
>  
>  	BUILD_BUG_ON(ARRAY_SIZE(names) >= BITS_PER_TYPE(mitigations));
>  
> -	str = kstrdup(val, GFP_KERNEL);
> -	if (!str)
> -		return -ENOMEM;
> +	strncpy(str, val, sizeof(str) - 1);
> +	str[sizeof(str) - 1] = '\0';

Looks correct, however strscpy() seems to be the thing we should
be using these days.

>  
>  	for (sep = str; (tok = strsep(&sep, ","));) {
>  		bool enable = true;
> @@ -86,7 +85,6 @@ static int mitigations_set(const char *val, const struct kernel_param *kp)
>  			break;
>  		}
>  	}
> -	kfree(str);
>  	if (err)
>  		return err;
>  
> -- 
> 2.31.0

-- 
Ville Syrjälä
Intel
