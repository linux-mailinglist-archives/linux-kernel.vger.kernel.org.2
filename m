Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C240338CE84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhEUUFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:05:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:54862 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhEUUFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:05:19 -0400
IronPort-SDR: TX+Iw0ypzHXamczdbxzXCI1g0jYNgrHF012KxEku7yZEX8mMLJzsNDnhdWGL+vbx7p2nAGznaM
 m85lIUGCSc/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="188959064"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188959064"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 13:03:55 -0700
IronPort-SDR: IBeM0IXzsqaI1CpzPRHvUZf09sgZZ3x6P0C6+btIARsA706T4V2CZVqO1t+ue1xEEs8vi3dRkp
 90W5LjXicbJw==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="613363289"
Received: from dweeratu-mobl1.amr.corp.intel.com (HELO intel.com) ([10.254.1.200])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 13:03:52 -0700
Date:   Fri, 21 May 2021 16:03:51 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lyude Paul <lyude@redhat.com>, Jani Nikula <jani.nikula@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        Rajeev Nandan <rajeevny@codeaurora.org>,
        greg.depoire@gmail.com, David Airlie <airlied@linux.ie>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Dave Airlie <airlied@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Subject: Re: [PATCH v6 1/9] drm/i915/dpcd_bl: Remove redundant AUX backlight
 frequency calculations
Message-ID: <YKgSJ+0YtLYQnOQB@intel.com>
References: <20210514181504.565252-1-lyude@redhat.com>
 <20210514181504.565252-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514181504.565252-2-lyude@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 02:14:55PM -0400, Lyude Paul wrote:
> Noticed this while moving all of the VESA backlight code in i915 over to
> DRM helpers: it would appear that we calculate the frequency value we want
> to write to DP_EDP_BACKLIGHT_FREQ_SET twice even though this value never
> actually changes during runtime. So, let's simplify things by just caching
> this value in intel_panel.backlight, and re-writing it as-needed.
> 
> Changes since v1:
> * Wrap panel->backlight.edp.vesa.pwm_freq_pre_divider in
>   DP_EDP_BACKLIGHT_FREQ_AUX_SET_CAP check - Jani

This looks okay to me now... Jani, agree?

> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: greg.depoire@gmail.com
> ---
>  .../drm/i915/display/intel_display_types.h    |  1 +
>  .../drm/i915/display/intel_dp_aux_backlight.c | 65 ++++++-------------
>  2 files changed, 20 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 9c0adfc60c6f..7054a37363fb 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -311,6 +311,7 @@ struct intel_panel {
>  		union {
>  			struct {
>  				u8 pwmgen_bit_count;
> +				u8 pwm_freq_pre_divider;
>  			} vesa;
>  			struct {
>  				bool sdr_uses_aux;
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 8e9ac9ba1d38..68bfe50ada59 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -373,50 +373,6 @@ intel_dp_aux_vesa_set_backlight(const struct drm_connector_state *conn_state,
>  	}
>  }
>  
> -/*
> - * Set PWM Frequency divider to match desired frequency in vbt.
> - * The PWM Frequency is calculated as 27Mhz / (F x P).
> - * - Where F = PWM Frequency Pre-Divider value programmed by field 7:0 of the
> - *             EDP_BACKLIGHT_FREQ_SET register (DPCD Address 00728h)
> - * - Where P = 2^Pn, where Pn is the value programmed by field 4:0 of the
> - *             EDP_PWMGEN_BIT_COUNT register (DPCD Address 00724h)
> - */
> -static bool intel_dp_aux_vesa_set_pwm_freq(struct intel_connector *connector)
> -{
> -	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
> -	struct intel_dp *intel_dp = intel_attached_dp(connector);
> -	const u8 pn = connector->panel.backlight.edp.vesa.pwmgen_bit_count;
> -	int freq, fxp, f, fxp_actual, fxp_min, fxp_max;
> -
> -	freq = dev_priv->vbt.backlight.pwm_freq_hz;
> -	if (!freq) {
> -		drm_dbg_kms(&dev_priv->drm,
> -			    "Use panel default backlight frequency\n");
> -		return false;
> -	}
> -
> -	fxp = DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
> -	f = clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
> -	fxp_actual = f << pn;
> -
> -	/* Ensure frequency is within 25% of desired value */
> -	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
> -	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
> -
> -	if (fxp_min > fxp_actual || fxp_actual > fxp_max) {
> -		drm_dbg_kms(&dev_priv->drm, "Actual frequency out of range\n");
> -		return false;
> -	}
> -
> -	if (drm_dp_dpcd_writeb(&intel_dp->aux,
> -			       DP_EDP_BACKLIGHT_FREQ_SET, (u8) f) < 0) {
> -		drm_dbg_kms(&dev_priv->drm,
> -			    "Failed to write aux backlight freq\n");
> -		return false;
> -	}
> -	return true;
> -}
> -
>  static void
>  intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
>  				   const struct drm_connector_state *conn_state, u32 level)
> @@ -459,9 +415,13 @@ intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
>  		break;
>  	}
>  
> -	if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_FREQ_AUX_SET_CAP)
> -		if (intel_dp_aux_vesa_set_pwm_freq(connector))
> +	if (panel->backlight.edp.vesa.pwm_freq_pre_divider) {
> +		if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_BACKLIGHT_FREQ_SET,
> +				       panel->backlight.edp.vesa.pwm_freq_pre_divider) == 1)
>  			new_dpcd_buf |= DP_EDP_BACKLIGHT_FREQ_AUX_SET_ENABLE;
> +		else
> +			drm_dbg_kms(&i915->drm, "Failed to write aux backlight frequency\n");
> +	}
>  
>  	if (new_dpcd_buf != dpcd_buf) {
>  		if (drm_dp_dpcd_writeb(&intel_dp->aux,
> @@ -482,6 +442,14 @@ static void intel_dp_aux_vesa_disable_backlight(const struct drm_connector_state
>  				  false);
>  }
>  
> +/*
> + * Compute PWM frequency divider value based off the frequency provided to us by the vbt.
> + * The PWM Frequency is calculated as 27Mhz / (F x P).
> + * - Where F = PWM Frequency Pre-Divider value programmed by field 7:0 of the
> + *             EDP_BACKLIGHT_FREQ_SET register (DPCD Address 00728h)
> + * - Where P = 2^Pn, where Pn is the value programmed by field 4:0 of the
> + *             EDP_PWMGEN_BIT_COUNT register (DPCD Address 00724h)
> + */
>  static u32 intel_dp_aux_vesa_calc_max_backlight(struct intel_connector *connector)
>  {
>  	struct drm_i915_private *i915 = to_i915(connector->base.dev);
> @@ -533,8 +501,10 @@ static u32 intel_dp_aux_vesa_calc_max_backlight(struct intel_connector *connecto
>  	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>  	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>  
> +	/* Ensure frequency is within 25% of desired value */
>  	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
>  	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
> +
>  	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
>  		drm_dbg_kms(&i915->drm,
>  			    "VBT defined backlight frequency out of range\n");
> @@ -555,7 +525,10 @@ static u32 intel_dp_aux_vesa_calc_max_backlight(struct intel_connector *connecto
>  			    "Failed to write aux pwmgen bit count\n");
>  		return max_backlight;
>  	}
> +
>  	panel->backlight.edp.vesa.pwmgen_bit_count = pn;
> +	if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_FREQ_AUX_SET_CAP)
> +		panel->backlight.edp.vesa.pwm_freq_pre_divider = f;
>  
>  	max_backlight = (1 << pn) - 1;
>  
> -- 
> 2.31.1
> 
