Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8468B37382A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 11:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhEEJze convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 May 2021 05:55:34 -0400
Received: from srv6.fidu.org ([159.69.62.71]:45556 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhEEJzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 05:55:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 2BDFAC800B6;
        Wed,  5 May 2021 11:54:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id MM2mOfkRZDQz; Wed,  5 May 2021 11:54:35 +0200 (CEST)
Received: from [IPv6:2003:e3:7f39:8600:6e35:22:d0af:f0c] (p200300e37f3986006E350022d0af0f0C.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:8600:6e35:22:d0af:f0c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id CB857C800AB;
        Wed,  5 May 2021 11:54:35 +0200 (CEST)
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210503182148.851790-1-wse@tuxedocomputers.com>
 <20210503182148.851790-4-wse@tuxedocomputers.com>
 <YJEZzhhQzmYxi8Gp@intel.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH 3/4] Restructure output format computation for better
 expandability
Message-ID: <41aca960-7595-8fed-228c-3b9347c64dc6@tuxedocomputers.com>
Date:   Wed, 5 May 2021 11:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJEZzhhQzmYxi8Gp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.05.21 um 11:54 schrieb Ville Syrjälä:

> On Mon, May 03, 2021 at 08:21:47PM +0200, Werner Sembach wrote:
>> Couples the decission between RGB and YCbCr420 mode and the check if the port
>> clock can archive the required frequency. Other checks and configuration steps
>> that where previously done in between can also be done before or after.
>>
>> This allows for are cleaner implementation of retrying different color
>> encodings.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>
>> >From 57e42ec6e34ac32da29eb7bc3c691cbeb2534396 Mon Sep 17 00:00:00 2001
>> From: Werner Sembach <wse@tuxedocomputers.com>
>> Date: Mon, 3 May 2021 15:30:40 +0200
>> Subject: [PATCH 3/4] Restructure output format computation for better
>>  expandability
>>
>> ---
>>  drivers/gpu/drm/i915/display/intel_hdmi.c | 57 +++++++++++------------
>>  1 file changed, 26 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
>> index ce165ef28e88..e2553ac6fd13 100644
>> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
>> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
>> @@ -1999,29 +1999,6 @@ static bool hdmi_deep_color_possible(const struct intel_crtc_state *crtc_state,
>>  					      INTEL_OUTPUT_FORMAT_YCBCR420);
>>  }
>>  
>> -static int
>> -intel_hdmi_ycbcr420_config(struct intel_crtc_state *crtc_state,
>> -			   const struct drm_connector_state *conn_state)
>> -{
>> -	struct drm_connector *connector = conn_state->connector;
>> -	struct drm_i915_private *i915 = to_i915(connector->dev);
>> -	const struct drm_display_mode *adjusted_mode =
>> -		&crtc_state->hw.adjusted_mode;
>> -
>> -	if (!drm_mode_is_420_only(&connector->display_info, adjusted_mode))
>> -		return 0;
>> -
>> -	if (!connector->ycbcr_420_allowed) {
>> -		drm_err(&i915->drm,
>> -			"Platform doesn't support YCBCR420 output\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
>> -
>> -	return intel_pch_panel_fitting(crtc_state, conn_state);
>> -}
>> -
>>  static int intel_hdmi_compute_bpc(struct intel_encoder *encoder,
>>  				  struct intel_crtc_state *crtc_state,
>>  				  int clock)
>> @@ -2128,6 +2105,24 @@ static bool intel_hdmi_has_audio(struct intel_encoder *encoder,
>>  		return intel_conn_state->force_audio == HDMI_AUDIO_ON;
>>  }
>>  
>> +int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
>> +				     struct intel_crtc_state *crtc_state,
>> +				     const struct drm_connector_state *conn_state)
>> +{
>> +	const struct drm_connector *connector = conn_state->connector;
>> +	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
>> +	int ret;
>> +
>> +	if (connector->ycbcr_420_allowed && drm_mode_is_420_only(&connector->display_info, adjusted_mode))
>> +		crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
>> +	else
>> +		crtc_state->output_format = INTEL_OUTPUT_FORMAT_RGB;
> Slight change in behaviour here since we used to reject 420_only modes
> if ycbcr_420_allowed wasn't set. But I think this should be OK, and in
> fact I believe the DP counterpart code always used an RGB fallback
> rather than failing. So this lines up better with that.

That was actually an oversight on my side and not intended. Does a RGB fallback make sense?

Now that I think of it get to 2 scenarios:

- The screen is really 420_only, which causes a silent fail and a black screen I guess? Where before at least a log message was written.

- The screen falsely reports as 420_only and using RGB regardless makes it magically work

I think at least warning should be printed to the logs. Something along the lines of: "Display reports as 420 only, but port does not support 420, try forcing RGB, but this is likely to fail."
> Needs at least a note in the commit message to indicate that
> there is a functional change buried within. Though it would be
> better to split this functional change into a separate prep patch.
>
>> +
>> +	ret = intel_hdmi_compute_clock(encoder, crtc_state);
>> +
>> +	return ret;
>> +}
>> +
>>  int intel_hdmi_compute_config(struct intel_encoder *encoder,
>>  			      struct intel_crtc_state *pipe_config,
>>  			      struct drm_connector_state *conn_state)
>> @@ -2152,23 +2147,23 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
>>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLCLK)
>>  		pipe_config->pixel_multiplier = 2;
>>  
>> -	ret = intel_hdmi_ycbcr420_config(pipe_config, conn_state);
>> -	if (ret)
>> -		return ret;
>> -
>> -	pipe_config->limited_color_range =
>> -		intel_hdmi_limited_color_range(pipe_config, conn_state);
>> -
>>  	if (HAS_PCH_SPLIT(dev_priv) && !HAS_DDI(dev_priv))
>>  		pipe_config->has_pch_encoder = true;
>>  
>>  	pipe_config->has_audio =
>>  		intel_hdmi_has_audio(encoder, pipe_config, conn_state);
>>  
>> -	ret = intel_hdmi_compute_clock(encoder, pipe_config);
>> +	ret = intel_hdmi_compute_output_format(encoder, pipe_config, conn_state);
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = intel_pch_panel_fitting(pipe_config, conn_state);
>> +	if (ret)
>> +		return ret;
> We probably want to still wrap this call in a
> if (crtc_state->output_format == INTEL_OUTPUT_FORMAT_YCBCR420) {...}
>
> In theory calling intel_pch_panel_fitting() should be a nop for
> the !420 case, but I think we have some issues there at least when
> it comes to bigjoiner. So the 420 check is probably needed to avoid
> mistakenly turning on the panel fitter when not needed.
>
>
>> +
>> +	pipe_config->limited_color_range =
>> +		intel_hdmi_limited_color_range(pipe_config, conn_state);
>> +
>>  	if (conn_state->picture_aspect_ratio)
>>  		adjusted_mode->picture_aspect_ratio =
>>  			conn_state->picture_aspect_ratio;
>> -- 
>> 2.25.1

