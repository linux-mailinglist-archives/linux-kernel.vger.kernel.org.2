Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1C39DC08
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhFGMQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:16:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:4140 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhFGMQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:16:21 -0400
IronPort-SDR: eTNVbHi+3BN3ottUzkKXCIaMh3SHFWpXCr6p0XmNn8fra/OAR/4Zo5H1N6oUijOn+cXOR2QIVi
 kuiM7EPtZDIg==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="225943378"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="225943378"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 05:14:30 -0700
IronPort-SDR: 6YUEijo5gp57lt5Wt+3kLuXFJqA6hXtBsVkUnYyZhnmxNcGteF8UHyL9pRBjGi/ebyYyFJwU3j
 rLumhES3Cgfw==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="449064384"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 05:14:26 -0700
Date:   Mon, 7 Jun 2021 15:14:23 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/display: remove duplicated argument
Message-ID: <20210607121423.GB3787465@ideak-desk.fi.intel.com>
References: <20210605032209.16111-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605032209.16111-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 11:22:07AM +0800, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/gpu/drm/i915/display/intel_display_power.c:3081:1-28:
>  duplicated argument to & or |
> 
> This commit fixes duplicate argument. It might be a typo.
> But what I can do is to remove it now.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Thanks, pushed to drm-intel-next.

> ---
>  drivers/gpu/drm/i915/display/intel_display_power.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
> index 3e1f6ec61514..4298ae684d7d 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_power.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_power.c
> @@ -3078,7 +3078,6 @@ intel_display_power_put_mask_in_set(struct drm_i915_private *i915,
>  	BIT_ULL(POWER_DOMAIN_PORT_DDI_C_LANES) |	\
>  	BIT_ULL(POWER_DOMAIN_PORT_DDI_LANES_D_XELPD) |	\
>  	BIT_ULL(POWER_DOMAIN_PORT_DDI_LANES_E_XELPD) |	\
> -	BIT_ULL(POWER_DOMAIN_AUX_C) |			\
>  	BIT_ULL(POWER_DOMAIN_PORT_DDI_LANES_TC1) |	\
>  	BIT_ULL(POWER_DOMAIN_PORT_DDI_LANES_TC2) |	\
>  	BIT_ULL(POWER_DOMAIN_PORT_DDI_LANES_TC3) |	\
> -- 
> 2.20.1
> 
