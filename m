Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0F7373C36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhEENTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhEENTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:19:18 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3FBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:18:22 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 0E7ECC800B4;
        Wed,  5 May 2021 15:18:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1Qag4sH1Yh9M; Wed,  5 May 2021 15:18:20 +0200 (CEST)
Received: from [IPv6:2003:e3:7f39:8600:6e35:22:d0af:f0c] (p200300e37F3986006e350022d0aF0F0C.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:8600:6e35:22:d0af:f0c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 469BFC800B3;
        Wed,  5 May 2021 15:18:19 +0200 (CEST)
Subject: Re: [PATCH 4/4] Use YCbCr420 as fallback when RGB fails
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210503182148.851790-1-wse@tuxedocomputers.com>
 <20210503182148.851790-5-wse@tuxedocomputers.com>
 <YJEdLbE5EOQv+Nib@intel.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <733f307c-9c39-e3a4-e1d9-fc238286ecc6@tuxedocomputers.com>
Date:   Wed, 5 May 2021 15:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJEdLbE5EOQv+Nib@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 04.05.21 um 12:08 schrieb Ville Syrjälä:
> On Mon, May 03, 2021 at 08:21:48PM +0200, Werner Sembach wrote:
>> When encoder validation of a display mode fails, retry with less bandwidth
>> heavy YCbCr420 color mode, if available. This enables some HDMI 1.4 setups
>> to support 4k60Hz output, which previously failed silently.
>>
>> AMDGPU had nearly the exact same issue. This problem description is
>> therefore copied from my commit message of the AMDGPU patch.
>>
>> On some setups, while the monitor and the gpu support display modes with
>> pixel clocks of up to 600MHz, the link encoder might not. This prevents
>> YCbCr444 and RGB encoding for 4k60Hz, but YCbCr420 encoding might still be
>> possible. However, which color mode is used is decided before the link
>> encoder capabilities are checked. This patch fixes the problem by retrying
>> to find a display mode with YCbCr420 enforced and using it, if it is
>> valid.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>
>> >From 4ea0c8839b47e846d46c613e38af475231994f0f Mon Sep 17 00:00:00 2001
>> From: Werner Sembach <wse@tuxedocomputers.com>
>> Date: Mon, 3 May 2021 16:23:17 +0200
>> Subject: [PATCH 4/4] Use YCbCr420 as fallback when RGB fails
>>
>> ---
>>  drivers/gpu/drm/i915/display/intel_hdmi.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
>> index e2553ac6fd13..20c800f2ed60 100644
>> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
>> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
>> @@ -1913,7 +1913,7 @@ intel_hdmi_mode_valid(struct drm_connector *connector,
>>  		clock *= 2;
>>  	}
>>  
>> -	if (connector->ycbcr_420_allowed && drm_mode_is_420_only(&connector->display_info, mode))
>> +	if (connector->ycbcr_420_allowed && drm_mode_is_420(&connector->display_info, mode))
>>  		clock /= 2;
> This is too early. We want to keep clock as is for checking whether RGB
> output is possible with 420_also modes.
>
> So the structure you had in your original patch was the correct way to
> go about it. Which I think was something along the lines of:
>
> if (420_only)
> 	clock /= 2;
>
> status = intel_hdmi_mode_clock_valid()
> if (status != OK) {
> 	if (420_only || !420_also || !420_allowed)
> 		return status;
> 	
> 	clock /= 2;
> 	status = intel_hdmi_mode_clock_valid()
> }
Does it make a difference?

In case !420_allowed only rgb is ever tested
In case 420_allowed && 420_only only 420 is ever tested
In case 420_allowed && 420_also the return value of the rgb test is discarded anyways
>
>>  
>>  	status = intel_hdmi_mode_clock_valid(hdmi, clock, has_hdmi_sink);
>> @@ -2119,6 +2119,14 @@ int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
>>  		crtc_state->output_format = INTEL_OUTPUT_FORMAT_RGB;
>>  
>>  	ret = intel_hdmi_compute_clock(encoder, crtc_state);
>> +	if (ret) {
>> +		if (crtc_state->output_format != INTEL_OUTPUT_FORMAT_YCBCR420 ||
>> +				connector->ycbcr_420_allowed ||
>> +				drm_mode_is_420_also(&connector->display_info, adjusted_mode)) {
> That needs s/||/&&/ or we flip the conditions around to:
>
> if (ret) {
> 	if (output_format == 420 || !420_allowed || !420_also)
> 		return ret;
>
> 	output_format = 420;
> 	...
> }
>
> which would have the benefit of avoiding the extra indent level.
>
>> +			crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
>> +			ret = intel_hdmi_compute_clock(encoder, crtc_state);
>> +		}
>> +	}
>>  
>>  	return ret;
>>  }
>> -- 
>> 2.25.1
