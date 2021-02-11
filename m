Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA5318414
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 04:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhBKDsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 22:48:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:5145 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhBKDsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 22:48:19 -0500
IronPort-SDR: l0x6GzFZZoJB5k7/iL6mQ/sZU9pKw/6nHTeVJnsaogt1NplWRClS0jhZASYE6P7LFEK3lwIXnr
 NTIRZWCiQQ3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="246255865"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="246255865"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 19:47:38 -0800
IronPort-SDR: D79RmPro2ikoHal05Bqao7dl+nS+OQR55mXgHRmdSUyJ9kwjfiGz8ZoTRBgU6GgVI8dGdaCYIk
 jsgg0Gnq3T2A==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="380436336"
Received: from rontiver-mobl.amr.corp.intel.com (HELO intel.com) ([10.212.99.95])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 19:47:37 -0800
Date:   Wed, 10 Feb 2021 22:47:36 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [Intel-gfx] [RFC v4 09/11] drm/i915/dpcd_bl: Print return codes
 for VESA backlight failures
Message-ID: <20210211034736.GF82362@intel.com>
References: <20210208233902.1289693-1-lyude@redhat.com>
 <20210208233902.1289693-10-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208233902.1289693-10-lyude@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 06:38:59PM -0500, Lyude Paul wrote:
> Also, stop printing the DPCD register that failed, and just describe it
> instead. Saves us from having to look up each register offset when reading
> through kernel logs (plus, DPCD dumping with drm.debug |= 0x100 will give
> us that anyway).
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  .../drm/i915/display/intel_dp_aux_backlight.c | 101 +++++++++---------
>  1 file changed, 52 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index a139f0e08839..a98d9bd4b0ed 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -274,14 +274,12 @@ static bool intel_dp_aux_vesa_backlight_dpcd_mode(struct intel_connector *connec
>  {
>  	struct intel_dp *intel_dp = intel_attached_dp(connector);
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> +	int ret;
>  	u8 mode_reg;
>  
> -	if (drm_dp_dpcd_readb(&intel_dp->aux,
> -			      DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
> -			      &mode_reg) != 1) {
> -		drm_dbg_kms(&i915->drm,
> -			    "Failed to read the DPCD register 0x%x\n",
> -			    DP_EDP_BACKLIGHT_MODE_SET_REGISTER);
> +	ret = drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER, &mode_reg);
> +	if (ret != 1) {
> +		drm_dbg_kms(&i915->drm, "Failed to read backlight mode: %d\n", ret);
>  		return false;
>  	}
>  
> @@ -297,6 +295,7 @@ static u32 intel_dp_aux_vesa_get_backlight(struct intel_connector *connector, en
>  {
>  	struct intel_dp *intel_dp = intel_attached_dp(connector);
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> +	int ret;
>  	u8 read_val[2] = { 0x0 };
>  	u16 level = 0;
>  
> @@ -307,10 +306,10 @@ static u32 intel_dp_aux_vesa_get_backlight(struct intel_connector *connector, en
>  	if (!intel_dp_aux_vesa_backlight_dpcd_mode(connector))
>  		return connector->panel.backlight.max;
>  
> -	if (drm_dp_dpcd_read(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, &read_val,
> -			     sizeof(read_val)) != sizeof(read_val)) {
> -		drm_dbg_kms(&i915->drm, "Failed to read DPCD register 0x%x\n",
> -			    DP_EDP_BACKLIGHT_BRIGHTNESS_MSB);
> +	ret = drm_dp_dpcd_read(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, &read_val,
> +			       sizeof(read_val));
> +	if (ret != sizeof(read_val)) {
> +		drm_dbg_kms(&i915->drm, "Failed to read brightness level: %d\n", ret);
>  		return 0;
>  	}
>  
> @@ -333,6 +332,7 @@ intel_dp_aux_vesa_set_backlight(const struct drm_connector_state *conn_state,
>  	struct intel_connector *connector = to_intel_connector(conn_state->connector);
>  	struct intel_dp *intel_dp = intel_attached_dp(connector);
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> +	int ret;
>  	u8 vals[2] = { 0x0 };
>  
>  	/* Write the MSB and/or LSB */
> @@ -343,10 +343,10 @@ intel_dp_aux_vesa_set_backlight(const struct drm_connector_state *conn_state,
>  		vals[0] = level;
>  	}
>  
> -	if (drm_dp_dpcd_write(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, vals,
> -			      sizeof(vals)) != sizeof(vals)) {
> -		drm_dbg_kms(&i915->drm,
> -			    "Failed to write aux backlight level\n");
> +	ret = drm_dp_dpcd_write(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, vals,
> +				sizeof(vals));
> +	if (ret != sizeof(vals)) {
> +		drm_dbg_kms(&i915->drm, "Failed to write aux backlight level: %d\n", ret);
>  		return;
>  	}
>  }
> @@ -355,26 +355,28 @@ static void set_vesa_backlight_enable(struct intel_connector *connector, bool en
>  {
>  	struct intel_dp *intel_dp = intel_attached_dp(connector);
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> +	int ret;
>  	u8 reg_val = 0;
>  
>  	/* Early return when display use other mechanism to enable backlight. */
>  	if (!connector->panel.backlight.edp.vesa.aux_enable)
>  		return;
>  
> -	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER, &reg_val) != 1) {
> -		drm_dbg_kms(&i915->drm, "Failed to read DPCD register 0x%x\n",
> -			    DP_EDP_DISPLAY_CONTROL_REGISTER);
> +	ret = drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER, &reg_val);
> +	if (ret != 1) {
> +		drm_dbg_kms(&i915->drm, "Failed to read eDP display control register: %d\n", ret);
>  		return;
>  	}
> +
>  	if (enable)
>  		reg_val |= DP_EDP_BACKLIGHT_ENABLE;
>  	else
>  		reg_val &= ~(DP_EDP_BACKLIGHT_ENABLE);
>  
> -	if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER,
> -			       reg_val) != 1) {
> -		drm_dbg_kms(&i915->drm, "Failed to %s aux backlight\n",
> -			    enable ? "enable" : "disable");
> +	ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER, reg_val);
> +	if (ret != 1) {
> +		drm_dbg_kms(&i915->drm, "Failed to %s aux backlight: %d\n",
> +			    enable ? "enable" : "disable", ret);
>  	}
>  }
>  
> @@ -386,13 +388,13 @@ intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
>  	struct intel_dp *intel_dp = intel_attached_dp(connector);
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
>  	struct intel_panel *panel = &connector->panel;
> +	int ret;
>  	u8 dpcd_buf, new_dpcd_buf;
>  	u8 pwmgen_bit_count = panel->backlight.edp.vesa.pwmgen_bit_count;
>  
> -	if (drm_dp_dpcd_readb(&intel_dp->aux,
> -			DP_EDP_BACKLIGHT_MODE_SET_REGISTER, &dpcd_buf) != 1) {
> -		drm_dbg_kms(&i915->drm, "Failed to read DPCD register 0x%x\n",
> -			    DP_EDP_BACKLIGHT_MODE_SET_REGISTER);
> +	ret = drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER, &dpcd_buf);
> +	if (ret != 1) {
> +		drm_dbg_kms(&i915->drm, "Failed to read backlight mode: %d\n", ret);
>  		return;
>  	}
>  
> @@ -402,24 +404,26 @@ intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
>  		new_dpcd_buf &= ~DP_EDP_BACKLIGHT_CONTROL_MODE_MASK;
>  		new_dpcd_buf |= DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD;
>  
> -		if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT,
> -				       pwmgen_bit_count) != 1)
> -			drm_dbg_kms(&i915->drm,
> -				    "Failed to write aux pwmgen bit count\n");
> +		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, pwmgen_bit_count);
> +		if (ret != 1)
> +			drm_dbg_kms(&i915->drm, "Failed to write aux pwmgen bit count: %d\n", ret);
>  	}
>  
>  	if (panel->backlight.edp.vesa.pwm_freq_pre_divider) {
> -		if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_BACKLIGHT_FREQ_SET,
> -				       panel->backlight.edp.vesa.pwm_freq_pre_divider) == 1)
> +		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_BACKLIGHT_FREQ_SET,
> +					 panel->backlight.edp.vesa.pwm_freq_pre_divider);
> +		if (ret == 1)
>  			new_dpcd_buf |= DP_EDP_BACKLIGHT_FREQ_AUX_SET_ENABLE;
>  		else
> -			drm_dbg_kms(&i915->drm, "Failed to write aux backlight frequency\n");
> +			drm_dbg_kms(&i915->drm, "Failed to write aux backlight frequency: %d\n",
> +				    ret);
>  	}
>  
>  	if (new_dpcd_buf != dpcd_buf) {
> -		if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
> -				       new_dpcd_buf) != 1)
> -			drm_dbg_kms(&i915->drm, "Failed to write aux backlight mode\n");
> +		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
> +					 new_dpcd_buf);
> +		if (ret != 1)
> +			drm_dbg_kms(&i915->drm, "Failed to write aux backlight mode: %d\n", ret);
>  	}
>  
>  	intel_dp_aux_vesa_set_backlight(conn_state, level);
> @@ -446,11 +450,12 @@ static u32 intel_dp_aux_vesa_calc_max_backlight(struct intel_connector *connecto
>  	struct intel_dp *intel_dp = intel_attached_dp(connector);
>  	struct intel_panel *panel = &connector->panel;
>  	u32 max_backlight = 0;
> -	int freq, fxp, fxp_min, fxp_max, fxp_actual, f = 1;
> +	int ret, freq, fxp, fxp_min, fxp_max, fxp_actual, f = 1;
>  	u8 pn, pn_min, pn_max;
>  
> -	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, &pn) != 1) {
> -		drm_dbg_kms(&i915->drm, "Failed to read pwmgen bit count cap\n");
> +	ret = drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, &pn);
> +	if (ret != 1) {
> +		drm_dbg_kms(&i915->drm, "Failed to read pwmgen bit count cap: %d\n", ret);
>  		return 0;
>  	}
>  
> @@ -479,16 +484,14 @@ static u32 intel_dp_aux_vesa_calc_max_backlight(struct intel_connector *connecto
>  	 * - FxP is within 25% of desired value.
>  	 *   Note: 25% is arbitrary value and may need some tweak.
>  	 */
> -	if (drm_dp_dpcd_readb(&intel_dp->aux,
> -			      DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) != 1) {
> -		drm_dbg_kms(&i915->drm,
> -			    "Failed to read pwmgen bit count cap min\n");
> +	ret = drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
> +	if (ret != 1) {
> +		drm_dbg_kms(&i915->drm, "Failed to read pwmgen bit count cap min: %d\n", ret);
>  		return max_backlight;
>  	}
> -	if (drm_dp_dpcd_readb(&intel_dp->aux,
> -			      DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) != 1) {
> -		drm_dbg_kms(&i915->drm,
> -			    "Failed to read pwmgen bit count cap max\n");
> +	ret = drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
> +	if (ret != 1) {
> +		drm_dbg_kms(&i915->drm, "Failed to read pwmgen bit count cap max: %d\n", ret);
>  		return max_backlight;
>  	}
>  	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> @@ -512,9 +515,9 @@ static u32 intel_dp_aux_vesa_calc_max_backlight(struct intel_connector *connecto
>  	}
>  
>  	drm_dbg_kms(&i915->drm, "Using eDP pwmgen bit count of %d\n", pn);
> -	if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, pn) != 1) {
> -		drm_dbg_kms(&i915->drm,
> -			    "Failed to write aux pwmgen bit count\n");
> +	ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, pn);
> +	if (ret != 1) {
> +		drm_dbg_kms(&i915->drm, "Failed to write aux pwmgen bit count: %d\n", ret);
>  		return max_backlight;
>  	}
>  
> -- 
> 2.29.2
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
