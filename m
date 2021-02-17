Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2604831D60F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 09:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhBQIDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 03:03:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:8720 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231673AbhBQIDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 03:03:45 -0500
IronPort-SDR: 1GWvZuOMRLcbHYgAwTaEb8XBVU2ggi4ToR5KKORdj0guUbPvVlvFflmsKneXGC3OQ3MTB3r0ln
 dGcF6vn9pewg==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="247201990"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="247201990"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 00:03:03 -0800
IronPort-SDR: UKqGDNe3ApTc4vL9NDJJ2dXUkrXizsRjRUhmn+4+Zr1HRzoyiXtKzGvT6kS6z01wa8jMxRIjfs
 C8yAnitX75/Q==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="439270368"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 00:03:00 -0800
Date:   Wed, 17 Feb 2021 10:02:57 +0200
From:   Imre Deak <imre.deak@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] drm/i915/gen9bc: Handle TGP PCH during
 suspend/resume
Message-ID: <20210217080257.GB443835@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20210217025337.1929015-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217025337.1929015-1-lyude@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 09:53:36PM -0500, Lyude Paul wrote:
> From: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> 
> For Legacy S3 suspend/resume GEN9 BC needs to enable and
> setup TGP PCH.
> 
> v2:
> * Move Wa_14010685332 into it's own function - vsyrjala
> * Add TODO comment about figuring out if we can move this workaround - imre
> v3:
> * Rename cnp_irq_post_reset() to cnp_display_clock_wa()
> * Add TODO item mentioning we need to clarify which platforms this
>   workaround applies to
> * Just use ibx_irq_reset() in gen8_irq_reset(). This code should be
>   functionally equivalent on gen9 bc to the code v2 added
> * Drop icp_hpd_irq_setup() call in spt_hpd_irq_setup(), this looks to be
>   more or less identical to spt_hpd_irq_setup() minus additionally enabling
>   one port. Will update i915 to use icp_hpd_irq_setup() for ICP in a
>   separate patch.
> 
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/i915/i915_irq.c | 52 +++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
> index 98145a7f28a4..f86b147f588f 100644
> --- a/drivers/gpu/drm/i915/i915_irq.c
> +++ b/drivers/gpu/drm/i915/i915_irq.c
> @@ -3040,6 +3040,24 @@ static void valleyview_irq_reset(struct drm_i915_private *dev_priv)
>  	spin_unlock_irq(&dev_priv->irq_lock);
>  }
>  
> +static void cnp_display_clock_wa(struct drm_i915_private *dev_priv)
> +{
> +	struct intel_uncore *uncore = &dev_priv->uncore;
> +
> +	/*
> +	 * Wa_14010685332:icl+

For now let's keep this matching the code:
	   Wa_14010685332:cnp/cmp,tgp,adp

> +	 * TODO: Clarify which platforms this applies to
> +	 * TODO: Figure out if this workaround can be applied in the s0ix suspend/resume handlers as
> +	 * on earlier platforms and whether the workaround is also needed for runtime suspend/resume
> +	 */
> +	if (INTEL_PCH_TYPE(dev_priv) == PCH_CNP ||
> +	    (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP && INTEL_PCH_TYPE(dev_priv) < PCH_DG1)) {
> +		intel_uncore_rmw(uncore, SOUTH_CHICKEN1, SBCLK_RUN_REFCLK_DIS,
> +				 SBCLK_RUN_REFCLK_DIS);
> +		intel_uncore_rmw(uncore, SOUTH_CHICKEN1, SBCLK_RUN_REFCLK_DIS, 0);
> +	}
> +}
> +
>  static void gen8_irq_reset(struct drm_i915_private *dev_priv)
>  {
>  	struct intel_uncore *uncore = &dev_priv->uncore;
> @@ -3061,8 +3079,9 @@ static void gen8_irq_reset(struct drm_i915_private *dev_priv)
>  	GEN3_IRQ_RESET(uncore, GEN8_DE_MISC_);
>  	GEN3_IRQ_RESET(uncore, GEN8_PCU_);
>  
> -	if (HAS_PCH_SPLIT(dev_priv))
> -		ibx_irq_reset(dev_priv);
> +	ibx_irq_reset(dev_priv);

The above shouldn't be changed to account for !PCH platforms as well.

> +
> +	cnp_display_clock_wa(dev_priv);
>  }
>  
>  static void gen11_display_irq_reset(struct drm_i915_private *dev_priv)
> @@ -3104,15 +3123,7 @@ static void gen11_display_irq_reset(struct drm_i915_private *dev_priv)
>  	if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
>  		GEN3_IRQ_RESET(uncore, SDE);
>  
> -	/* Wa_14010685332:cnp/cmp,tgp,adp */
> -	if (INTEL_PCH_TYPE(dev_priv) == PCH_CNP ||
> -	    (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP &&
> -	     INTEL_PCH_TYPE(dev_priv) < PCH_DG1)) {
> -		intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
> -				 SBCLK_RUN_REFCLK_DIS, SBCLK_RUN_REFCLK_DIS);
> -		intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
> -				 SBCLK_RUN_REFCLK_DIS, 0);
> -	}
> +	cnp_display_clock_wa(dev_priv);
>  }
>  
>  static void gen11_irq_reset(struct drm_i915_private *dev_priv)
> @@ -3764,9 +3775,19 @@ static void gen8_de_irq_postinstall(struct drm_i915_private *dev_priv)
>  	}
>  }
>  
> +static void icp_irq_postinstall(struct drm_i915_private *dev_priv)
> +{
> +	struct intel_uncore *uncore = &dev_priv->uncore;
> +	u32 mask = SDE_GMBUS_ICP;
> +
> +	GEN3_IRQ_INIT(uncore, SDE, ~mask, 0xffffffff);
> +}
> +
>  static void gen8_irq_postinstall(struct drm_i915_private *dev_priv)
>  {
> -	if (HAS_PCH_SPLIT(dev_priv))
> +	if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> +		icp_irq_postinstall(dev_priv);
> +	else if (HAS_PCH_SPLIT(dev_priv))
>  		ibx_irq_postinstall(dev_priv);
>  
>  	gen8_gt_irq_postinstall(&dev_priv->gt);
> @@ -3775,13 +3796,6 @@ static void gen8_irq_postinstall(struct drm_i915_private *dev_priv)
>  	gen8_master_intr_enable(dev_priv->uncore.regs);
>  }
>  
> -static void icp_irq_postinstall(struct drm_i915_private *dev_priv)
> -{
> -	struct intel_uncore *uncore = &dev_priv->uncore;
> -	u32 mask = SDE_GMBUS_ICP;
> -
> -	GEN3_IRQ_INIT(uncore, SDE, ~mask, 0xffffffff);
> -}
>  
>  static void gen11_irq_postinstall(struct drm_i915_private *dev_priv)
>  {
> -- 
> 2.29.2
> 
