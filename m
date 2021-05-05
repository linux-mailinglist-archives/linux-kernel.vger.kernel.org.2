Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20E373796
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 11:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhEEJdG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 May 2021 05:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhEEJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 05:33:04 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CACC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 02:32:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id BD54BC800B7;
        Wed,  5 May 2021 11:32:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id YlBRfrwkfAw1; Wed,  5 May 2021 11:32:04 +0200 (CEST)
Received: from [IPv6:2003:e3:7f39:8600:6e35:22:d0af:f0c] (p200300e37f3986006E350022d0af0f0C.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:8600:6e35:22:d0af:f0c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 6D59FC800B6;
        Wed,  5 May 2021 11:32:04 +0200 (CEST)
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210503182148.851790-1-wse@tuxedocomputers.com>
 <20210503182148.851790-3-wse@tuxedocomputers.com>
 <YJEW3J0+RQPo22AD@intel.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH 2/4] Add missing check
Message-ID: <559ca7d0-f68d-32c8-d2d9-37f57d2ecdcd@tuxedocomputers.com>
Date:   Wed, 5 May 2021 11:32:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJEW3J0+RQPo22AD@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.05.21 um 11:41 schrieb Ville Syrjälä:

> On Mon, May 03, 2021 at 08:21:46PM +0200, Werner Sembach wrote:
>> Add a missing check that could potentially lead to an unarchivable mode being
>> validated.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>
>> >From 54fa706f0a5f260a32af5d18b9622ceebb94c12e Mon Sep 17 00:00:00 2001
>> From: Werner Sembach <wse@tuxedocomputers.com>
>> Date: Mon, 3 May 2021 14:42:36 +0200
>> Subject: [PATCH 2/4] Add missing check
> I guess you did something a bit wonky with git format-patch/send-mail?
I have no idea how that timestamp happened, I will check when sending my next patch ^^.
>> ---
>>  drivers/gpu/drm/i915/display/intel_hdmi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
>> index 576d3d910d06..ce165ef28e88 100644
>> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
>> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
>> @@ -1913,7 +1913,7 @@ intel_hdmi_mode_valid(struct drm_connector *connector,
>>  		clock *= 2;
>>  	}
>>  
>> -	if (drm_mode_is_420_only(&connector->display_info, mode))
>> +	if (connector->ycbcr_420_allowed && drm_mode_is_420_only(&connector->display_info, mode))
> This one shouldn't be necessary. drm_mode_validate_ycbcr420() has
> already checked it for us.
I wasn't aware of drm_mode_validate_ycbcr420, thanks for the hint. In the "420_also"-patch I change drm_mode_is_420_only to drm_mode_is_420 (helper function: _only + _also), which is not checked by drm_mode_validate_ycbcr420. I can add this check to that patch, since its only required then.
>>  		clock /= 2;
>>  
>>  	status = intel_hdmi_mode_clock_valid(hdmi, clock, has_hdmi_sink);
>> -- 
>> 2.25.1

