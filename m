Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2085373BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhEENDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhEENDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:03:54 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57ADC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:02:57 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id B279BC800B3;
        Wed,  5 May 2021 15:02:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id y27sT_HL8J-Z; Wed,  5 May 2021 15:02:55 +0200 (CEST)
Received: from [IPv6:2003:e3:7f39:8600:6e35:22:d0af:f0c] (p200300e37F3986006e350022d0aF0F0C.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:8600:6e35:22:d0af:f0c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 593BCC800B2;
        Wed,  5 May 2021 15:02:55 +0200 (CEST)
Subject: Re: [PATCH 3/4] Restructure output format computation for better
 expandability
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210503182148.851790-1-wse@tuxedocomputers.com>
 <20210503182148.851790-4-wse@tuxedocomputers.com>
 <YJEZzhhQzmYxi8Gp@intel.com>
 <41aca960-7595-8fed-228c-3b9347c64dc6@tuxedocomputers.com>
 <YJKMXC8Wd+T34rNg@intel.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <1820519f-b84c-e0cf-0851-d520fd379eaa@tuxedocomputers.com>
Date:   Wed, 5 May 2021 15:02:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJKMXC8Wd+T34rNg@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 05.05.21 um 14:15 schrieb Ville Syrjälä:
> On Wed, May 05, 2021 at 11:54:35AM +0200, Werner Sembach wrote:
>> Am 04.05.21 um 11:54 schrieb Ville Syrjälä:
>>
>>> On Mon, May 03, 2021 at 08:21:47PM +0200, Werner Sembach wrote:
>>>> Couples the decission between RGB and YCbCr420 mode and the check if the port
>>>> clock can archive the required frequency. Other checks and configuration steps
>>>> that where previously done in between can also be done before or after.
>>>>
>>>> This allows for are cleaner implementation of retrying different color
>>>> encodings.
>>>>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> ---
>>>>
>>>> >From 57e42ec6e34ac32da29eb7bc3c691cbeb2534396 Mon Sep 17 00:00:00 2001
>>>> From: Werner Sembach <wse@tuxedocomputers.com>
>>>> Date: Mon, 3 May 2021 15:30:40 +0200
>>>> Subject: [PATCH 3/4] Restructure output format computation for better
>>>>  expandability
>>>>
>>>> ---
>>>>  drivers/gpu/drm/i915/display/intel_hdmi.c | 57 +++++++++++------------
>>>>  1 file changed, 26 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
>>>> index ce165ef28e88..e2553ac6fd13 100644
>>>> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
>>>> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
>>>> @@ -1999,29 +1999,6 @@ static bool hdmi_deep_color_possible(const struct intel_crtc_state *crtc_state,
>>>>  					      INTEL_OUTPUT_FORMAT_YCBCR420);
>>>>  }
>>>>  
>>>> -static int
>>>> -intel_hdmi_ycbcr420_config(struct intel_crtc_state *crtc_state,
>>>> -			   const struct drm_connector_state *conn_state)
>>>> -{
>>>> -	struct drm_connector *connector = conn_state->connector;
>>>> -	struct drm_i915_private *i915 = to_i915(connector->dev);
>>>> -	const struct drm_display_mode *adjusted_mode =
>>>> -		&crtc_state->hw.adjusted_mode;
>>>> -
>>>> -	if (!drm_mode_is_420_only(&connector->display_info, adjusted_mode))
>>>> -		return 0;
>>>> -
>>>> -	if (!connector->ycbcr_420_allowed) {
>>>> -		drm_err(&i915->drm,
>>>> -			"Platform doesn't support YCBCR420 output\n");
>>>> -		return -EINVAL;
>>>> -	}
>>>> -
>>>> -	crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
>>>> -
>>>> -	return intel_pch_panel_fitting(crtc_state, conn_state);
>>>> -}
>>>> -
>>>>  static int intel_hdmi_compute_bpc(struct intel_encoder *encoder,
>>>>  				  struct intel_crtc_state *crtc_state,
>>>>  				  int clock)
>>>> @@ -2128,6 +2105,24 @@ static bool intel_hdmi_has_audio(struct intel_encoder *encoder,
>>>>  		return intel_conn_state->force_audio == HDMI_AUDIO_ON;
>>>>  }
>>>>  
>>>> +int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
>>>> +				     struct intel_crtc_state *crtc_state,
>>>> +				     const struct drm_connector_state *conn_state)
>>>> +{
>>>> +	const struct drm_connector *connector = conn_state->connector;
>>>> +	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
>>>> +	int ret;
>>>> +
>>>> +	if (connector->ycbcr_420_allowed && drm_mode_is_420_only(&connector->display_info, adjusted_mode))
>>>> +		crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
>>>> +	else
>>>> +		crtc_state->output_format = INTEL_OUTPUT_FORMAT_RGB;
>>> Slight change in behaviour here since we used to reject 420_only modes
>>> if ycbcr_420_allowed wasn't set. But I think this should be OK, and in
>>> fact I believe the DP counterpart code always used an RGB fallback
>>> rather than failing. So this lines up better with that.
>> That was actually an oversight on my side and not intended. Does a RGB fallback make sense?
>>
>> Now that I think of it get to 2 scenarios:
>>
>> - The screen is really 420_only, which causes a silent fail and a black screen I guess? Where before at least a log message was written.
>>
>> - The screen falsely reports as 420_only and using RGB regardless makes it magically work
>>
>> I think at least warning should be printed to the logs. Something along the lines of: "Display reports as 420 only, but port does not support 420, try forcing RGB, but this is likely to fail."
> I would just put it into the "user has decided to override the mode and
> gets to keep both pieces if it breaks". Typical users would not hit that
> since they will only use modes reported by the connector as supported.
>
> So I think the RGB fallback is totally in line with existing behaviour
> of the driver. We have other cases where we just ignore the reported
> limits of the display if the user overrides the mode manually.
>
Did I get you right that "connector->ycbcr_420_allowed" is a user setting and not automatically filled configuration depending on hardware capabilities?
