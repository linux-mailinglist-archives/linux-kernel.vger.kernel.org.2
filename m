Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ABC318421
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 04:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBKD5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 22:57:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:4122 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhBKD5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 22:57:35 -0500
IronPort-SDR: esURHprKRj40CEGRSvkMKG9eawabcF0ke3fVAft9GM4BHly/EDsb+d4Bgco3TBFyE91XrQC9bB
 EyaWhgpSP5eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="201312840"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="201312840"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 19:56:54 -0800
IronPort-SDR: p5y/8oyWQyEJYLwp2trAZV5GK8sDdKqojTmNFm0oGeN3iHjKo9fGhWUnH2beBupiCG68KiamqE
 5pzNBywEWxEg==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="397075297"
Received: from rontiver-mobl.amr.corp.intel.com (HELO intel.com) ([10.212.99.95])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 19:56:52 -0800
Date:   Wed, 10 Feb 2021 22:56:50 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [RFC v4 05/11] drm/i915/dpcd_bl: Cleanup
 intel_dp_aux_vesa_enable_backlight() a bit
Message-ID: <20210211035650.GH82362@intel.com>
References: <20210208233902.1289693-1-lyude@redhat.com>
 <20210208233902.1289693-6-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208233902.1289693-6-lyude@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 06:38:55PM -0500, Lyude Paul wrote:
> Get rid of the extraneous switch case in here, and just open code
> edp_backlight_mode as we only ever use it once.
> 
> v4:
> * Check that backlight mode is DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD, not
>   DP_EDP_BACKLIGHT_CONTROL_MODE_MASK - imirkin
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  .../gpu/drm/i915/display/intel_dp_aux_backlight.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index c37ccc8538cb..57218faed4a3 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -382,7 +382,7 @@ intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
>  	struct intel_dp *intel_dp = intel_attached_dp(connector);
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
>  	struct intel_panel *panel = &connector->panel;
> -	u8 dpcd_buf, new_dpcd_buf, edp_backlight_mode;
> +	u8 dpcd_buf, new_dpcd_buf;
>  	u8 pwmgen_bit_count = panel->backlight.edp.vesa.pwmgen_bit_count;
>  
>  	if (drm_dp_dpcd_readb(&intel_dp->aux,
> @@ -393,12 +393,8 @@ intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
>  	}
>  
>  	new_dpcd_buf = dpcd_buf;
> -	edp_backlight_mode = dpcd_buf & DP_EDP_BACKLIGHT_CONTROL_MODE_MASK;
>  
> -	switch (edp_backlight_mode) {
> -	case DP_EDP_BACKLIGHT_CONTROL_MODE_PWM:
> -	case DP_EDP_BACKLIGHT_CONTROL_MODE_PRESET:
> -	case DP_EDP_BACKLIGHT_CONTROL_MODE_PRODUCT:
> +	if ((dpcd_buf & DP_EDP_BACKLIGHT_CONTROL_MODE_MASK) != DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD) {
>  		new_dpcd_buf &= ~DP_EDP_BACKLIGHT_CONTROL_MODE_MASK;
>  		new_dpcd_buf |= DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD;
>  
> @@ -406,13 +402,6 @@ intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
>  				       pwmgen_bit_count) != 1)
>  			drm_dbg_kms(&i915->drm,
>  				    "Failed to write aux pwmgen bit count\n");
> -
> -		break;
> -
> -	/* Do nothing when it is already DPCD mode */
> -	case DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD:
> -	default:
> -		break;
>  	}
>  
>  	if (panel->backlight.edp.vesa.pwm_freq_pre_divider) {
> -- 
> 2.29.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
