Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093AC37285A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 11:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhEDJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 05:55:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:50681 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhEDJzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 05:55:20 -0400
IronPort-SDR: D/GLM75nih2F26qWPHaoDu/QFJzewRgZNlxssrX349sqRPByz1OYdPvOdxqsbHIrD0BafVuYCI
 HAA/RTWh/U8g==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="218747499"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="218747499"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 02:54:26 -0700
IronPort-SDR: KwK79X15gOcdKq9tofz6DCFmiDDHp7RmoDm/kw4+LhHhaqcC3aL+sXQRmFTw2Fxjn/H8+qHo65
 NNKJJDGapQaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="396071354"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga007.fm.intel.com with SMTP; 04 May 2021 02:54:23 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 04 May 2021 12:54:22 +0300
Date:   Tue, 4 May 2021 12:54:22 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Restructure output format computation for better
 expandability
Message-ID: <YJEZzhhQzmYxi8Gp@intel.com>
References: <20210503182148.851790-1-wse@tuxedocomputers.com>
 <20210503182148.851790-4-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210503182148.851790-4-wse@tuxedocomputers.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 08:21:47PM +0200, Werner Sembach wrote:
> Couples the decission between RGB and YCbCr420 mode and the check if the port
> clock can archive the required frequency. Other checks and configuration steps
> that where previously done in between can also be done before or after.
> 
> This allows for are cleaner implementation of retrying different color
> encodings.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
> 
> >From 57e42ec6e34ac32da29eb7bc3c691cbeb2534396 Mon Sep 17 00:00:00 2001
> From: Werner Sembach <wse@tuxedocomputers.com>
> Date: Mon, 3 May 2021 15:30:40 +0200
> Subject: [PATCH 3/4] Restructure output format computation for better
>  expandability
> 
> ---
>  drivers/gpu/drm/i915/display/intel_hdmi.c | 57 +++++++++++------------
>  1 file changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index ce165ef28e88..e2553ac6fd13 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -1999,29 +1999,6 @@ static bool hdmi_deep_color_possible(const struct intel_crtc_state *crtc_state,
>  					      INTEL_OUTPUT_FORMAT_YCBCR420);
>  }
>  
> -static int
> -intel_hdmi_ycbcr420_config(struct intel_crtc_state *crtc_state,
> -			   const struct drm_connector_state *conn_state)
> -{
> -	struct drm_connector *connector = conn_state->connector;
> -	struct drm_i915_private *i915 = to_i915(connector->dev);
> -	const struct drm_display_mode *adjusted_mode =
> -		&crtc_state->hw.adjusted_mode;
> -
> -	if (!drm_mode_is_420_only(&connector->display_info, adjusted_mode))
> -		return 0;
> -
> -	if (!connector->ycbcr_420_allowed) {
> -		drm_err(&i915->drm,
> -			"Platform doesn't support YCBCR420 output\n");
> -		return -EINVAL;
> -	}
> -
> -	crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
> -
> -	return intel_pch_panel_fitting(crtc_state, conn_state);
> -}
> -
>  static int intel_hdmi_compute_bpc(struct intel_encoder *encoder,
>  				  struct intel_crtc_state *crtc_state,
>  				  int clock)
> @@ -2128,6 +2105,24 @@ static bool intel_hdmi_has_audio(struct intel_encoder *encoder,
>  		return intel_conn_state->force_audio == HDMI_AUDIO_ON;
>  }
>  
> +int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
> +				     struct intel_crtc_state *crtc_state,
> +				     const struct drm_connector_state *conn_state)
> +{
> +	const struct drm_connector *connector = conn_state->connector;
> +	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
> +	int ret;
> +
> +	if (connector->ycbcr_420_allowed && drm_mode_is_420_only(&connector->display_info, adjusted_mode))
> +		crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
> +	else
> +		crtc_state->output_format = INTEL_OUTPUT_FORMAT_RGB;

Slight change in behaviour here since we used to reject 420_only modes
if ycbcr_420_allowed wasn't set. But I think this should be OK, and in
fact I believe the DP counterpart code always used an RGB fallback
rather than failing. So this lines up better with that.

Needs at least a note in the commit message to indicate that
there is a functional change buried within. Though it would be
better to split this functional change into a separate prep patch.

> +
> +	ret = intel_hdmi_compute_clock(encoder, crtc_state);
> +
> +	return ret;
> +}
> +
>  int intel_hdmi_compute_config(struct intel_encoder *encoder,
>  			      struct intel_crtc_state *pipe_config,
>  			      struct drm_connector_state *conn_state)
> @@ -2152,23 +2147,23 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLCLK)
>  		pipe_config->pixel_multiplier = 2;
>  
> -	ret = intel_hdmi_ycbcr420_config(pipe_config, conn_state);
> -	if (ret)
> -		return ret;
> -
> -	pipe_config->limited_color_range =
> -		intel_hdmi_limited_color_range(pipe_config, conn_state);
> -
>  	if (HAS_PCH_SPLIT(dev_priv) && !HAS_DDI(dev_priv))
>  		pipe_config->has_pch_encoder = true;
>  
>  	pipe_config->has_audio =
>  		intel_hdmi_has_audio(encoder, pipe_config, conn_state);
>  
> -	ret = intel_hdmi_compute_clock(encoder, pipe_config);
> +	ret = intel_hdmi_compute_output_format(encoder, pipe_config, conn_state);
>  	if (ret)
>  		return ret;
>  
> +	ret = intel_pch_panel_fitting(pipe_config, conn_state);
> +	if (ret)
> +		return ret;

We probably want to still wrap this call in a
if (crtc_state->output_format == INTEL_OUTPUT_FORMAT_YCBCR420) {...}

In theory calling intel_pch_panel_fitting() should be a nop for
the !420 case, but I think we have some issues there at least when
it comes to bigjoiner. So the 420 check is probably needed to avoid
mistakenly turning on the panel fitter when not needed.


> +
> +	pipe_config->limited_color_range =
> +		intel_hdmi_limited_color_range(pipe_config, conn_state);
> +
>  	if (conn_state->picture_aspect_ratio)
>  		adjusted_mode->picture_aspect_ratio =
>  			conn_state->picture_aspect_ratio;
> -- 
> 2.25.1

-- 
Ville Syrjälä
Intel
