Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34665372878
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 12:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhEDKJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 06:09:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:58562 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhEDKJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 06:09:43 -0400
IronPort-SDR: lH1WxhZCvEY8rfmIxjund282cphtX6uw7sPovab+QotJTjB5U2IueqNcvqOi/bPJM5PcHDEOYj
 suVo6grfrLjg==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="178155494"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178155494"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 03:08:48 -0700
IronPort-SDR: FUqnMRWgvRXRQYs3FzsQuFrazFO/ZVAWQcVuQ+ry4ms1nCReGwYNKDEQ6ogxTpmj6tFlnlQiUN
 4yZ8JKi3VSkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="530955511"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga001.fm.intel.com with SMTP; 04 May 2021 03:08:45 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 04 May 2021 13:08:45 +0300
Date:   Tue, 4 May 2021 13:08:45 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Use YCbCr420 as fallback when RGB fails
Message-ID: <YJEdLbE5EOQv+Nib@intel.com>
References: <20210503182148.851790-1-wse@tuxedocomputers.com>
 <20210503182148.851790-5-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210503182148.851790-5-wse@tuxedocomputers.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 08:21:48PM +0200, Werner Sembach wrote:
> When encoder validation of a display mode fails, retry with less bandwidth
> heavy YCbCr420 color mode, if available. This enables some HDMI 1.4 setups
> to support 4k60Hz output, which previously failed silently.
> 
> AMDGPU had nearly the exact same issue. This problem description is
> therefore copied from my commit message of the AMDGPU patch.
> 
> On some setups, while the monitor and the gpu support display modes with
> pixel clocks of up to 600MHz, the link encoder might not. This prevents
> YCbCr444 and RGB encoding for 4k60Hz, but YCbCr420 encoding might still be
> possible. However, which color mode is used is decided before the link
> encoder capabilities are checked. This patch fixes the problem by retrying
> to find a display mode with YCbCr420 enforced and using it, if it is
> valid.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
> 
> >From 4ea0c8839b47e846d46c613e38af475231994f0f Mon Sep 17 00:00:00 2001
> From: Werner Sembach <wse@tuxedocomputers.com>
> Date: Mon, 3 May 2021 16:23:17 +0200
> Subject: [PATCH 4/4] Use YCbCr420 as fallback when RGB fails
> 
> ---
>  drivers/gpu/drm/i915/display/intel_hdmi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index e2553ac6fd13..20c800f2ed60 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -1913,7 +1913,7 @@ intel_hdmi_mode_valid(struct drm_connector *connector,
>  		clock *= 2;
>  	}
>  
> -	if (connector->ycbcr_420_allowed && drm_mode_is_420_only(&connector->display_info, mode))
> +	if (connector->ycbcr_420_allowed && drm_mode_is_420(&connector->display_info, mode))
>  		clock /= 2;

This is too early. We want to keep clock as is for checking whether RGB
output is possible with 420_also modes.

So the structure you had in your original patch was the correct way to
go about it. Which I think was something along the lines of:

if (420_only)
	clock /= 2;

status = intel_hdmi_mode_clock_valid()
if (status != OK) {
	if (420_only || !420_also || !420_allowed)
		return status;
	
	clock /= 2;
	status = intel_hdmi_mode_clock_valid()
}


>  
>  	status = intel_hdmi_mode_clock_valid(hdmi, clock, has_hdmi_sink);
> @@ -2119,6 +2119,14 @@ int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
>  		crtc_state->output_format = INTEL_OUTPUT_FORMAT_RGB;
>  
>  	ret = intel_hdmi_compute_clock(encoder, crtc_state);
> +	if (ret) {
> +		if (crtc_state->output_format != INTEL_OUTPUT_FORMAT_YCBCR420 ||
> +				connector->ycbcr_420_allowed ||
> +				drm_mode_is_420_also(&connector->display_info, adjusted_mode)) {

That needs s/||/&&/ or we flip the conditions around to:

if (ret) {
	if (output_format == 420 || !420_allowed || !420_also)
		return ret;

	output_format = 420;
	...
}

which would have the benefit of avoiding the extra indent level.

> +			crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
> +			ret = intel_hdmi_compute_clock(encoder, crtc_state);
> +		}
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.25.1

-- 
Ville Syrjälä
Intel
