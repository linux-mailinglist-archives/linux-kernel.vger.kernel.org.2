Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B798F3AE50E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFUIke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:40:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36733 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhFUIkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:40:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624264699; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=zkZFX1WS+/7fa88RZ+e2bW+9prmrxb8QWu3yvtkdX7c=;
 b=SpvoXBU0MSbDB0gJ/hyYVZkyyyGhjzYFB2t5aAv7Vsj6O/gyXNJBWP6+I3QQApCsC+cNUGtd
 pzsfIELIKMtDmKol0qbmysbAfrFn6AU2RpOvhMrge+nHjMNl1F30emBHTk6vxQhvH+1u+h2g
 Scdi3UZPiQYG+BdjGAI8Mzkw1xI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60d04ffb8491191eb3505eda (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Jun 2021 08:38:19
 GMT
Sender: rajeevny=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4E3CFC4360C; Mon, 21 Jun 2021 08:38:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rajeevny)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B591AC433F1;
        Mon, 21 Jun 2021 08:38:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Jun 2021 14:08:17 +0530
From:   rajeevny@codeaurora.org
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        robdclark@gmail.com, dianders@chromium.org, lyude@redhat.com,
        jani.nikula@intel.com, robh@kernel.org,
        laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        daniel.thompson@linaro.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, mkrishn@codeaurora.org,
        lee.jones@linaro.org, jingoohan1@gmail.com,
        linux-fbdev@vger.kernel.org
Subject: Re: [v7 1/5] drm/panel: add basic DP AUX backlight support
In-Reply-To: <20210620093141.GA703072@ravnborg.org>
References: <1624099230-20899-1-git-send-email-rajeevny@codeaurora.org>
 <1624099230-20899-2-git-send-email-rajeevny@codeaurora.org>
 <20210620093141.GA703072@ravnborg.org>
Message-ID: <ebf5581759daee9596c2f092ca836ecb@codeaurora.org>
X-Sender: rajeevny@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 20-06-2021 15:01, Sam Ravnborg wrote:
> Hi Rajeev
> 
> On Sat, Jun 19, 2021 at 04:10:26PM +0530, Rajeev Nandan wrote:
>> Some panels support backlight control over DP AUX channel using
>> VESA's standard backlight control interface.
>> Using new DRM eDP backlight helpers, add support to create and
>> register a backlight for those panels in drm_panel to simplify
>> the panel drivers.
>> 
>> The panel driver with access to "struct drm_dp_aux" can create and
>> register a backlight device using following code snippet in its
>> probe() function:
>> 
>> 	err = drm_panel_dp_aux_backlight(panel, aux);
>> 	if (err)
>> 		return err;
> 
> IT very good to have this supported by drm_panel, so we avoid
> bolierplate in various drivers.
> 
>> 
>> Then drm_panel will handle backlight_(enable|disable) calls
>> similar to the case when drm_panel_of_backlight() is used.
>> 
>> Currently, we are not supporting one feature where the source
>> device can combine the backlight brightness levels set through
>> DP AUX and the BL_PWM_DIM eDP connector pin. Since it's not
>> required for the basic backlight controls, it can be added later.
>> 
>> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>> ---
>> 
>> (no changes since v6)
>> 
>> Changes in v5:
>> - New
>> 
>> Changes in v6:
>> - Fixed ordering of memory allocation (Douglas)
>> - Updated word wrapping in a comment (Douglas)
>> 
>>  drivers/gpu/drm/drm_panel.c | 108 
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  include/drm/drm_panel.h     |  15 ++++--
>>  2 files changed, 119 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
>> index f634371..9e65342 100644
>> --- a/drivers/gpu/drm/drm_panel.c
>> +++ b/drivers/gpu/drm/drm_panel.c
>> @@ -26,12 +26,20 @@
>>  #include <linux/module.h>
>> 
>>  #include <drm/drm_crtc.h>
>> +#include <drm/drm_dp_helper.h>
>>  #include <drm/drm_panel.h>
>>  #include <drm/drm_print.h>
>> 
>>  static DEFINE_MUTEX(panel_lock);
>>  static LIST_HEAD(panel_list);
>> 
>> +struct dp_aux_backlight {
>> +	struct backlight_device *base;
>> +	struct drm_dp_aux *aux;
>> +	struct drm_edp_backlight_info info;
>> +	bool enabled;
>> +};
>> +
>>  /**
>>   * DOC: drm panel
>>   *
>> @@ -342,6 +350,106 @@ int drm_panel_of_backlight(struct drm_panel 
>> *panel)
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(drm_panel_of_backlight);
>> +
>> +static int dp_aux_backlight_update_status(struct backlight_device 
>> *bd)
>> +{
>> +	struct dp_aux_backlight *bl = bl_get_data(bd);
>> +	u16 brightness = backlight_get_brightness(bd);
> backlight_get_brightness() returns an int, so using u16 seems wrong.
> But then drm_edp_backlight_enable() uses u16 for level - so I guess it
> is OK.
> We use unsigned long, int, u16 for brightness. Looks like something one
> could look at one day, but today is not that day.
> 
>> +	int ret = 0;
>> +
>> +	if (brightness > 0) {
> Use backlight_is_blank(bd) here, as this is really what you test for.

The backlight_get_brightness() used above has the backlight_is_blank() 
check and returns brightness 0 when the backlight_is_blank(bd) is true.
So, instead of calling backlight_is_blank(bd), we are checking 
brightness value here.
I took the reference from pwm_backlight_update_status() of the PWM 
backlight driver (drivers/video/backlight/pwm_bl.c)

Yes, we can change this _if_ condition to use backlight_is_blank(bd), as 
this is an inline function, and is more meaningful.
With this, there would be one change in the behavior of 
_backlight_update_status function in the following case:

- Setting brightness=0 when the backlight is not blank:
In the current case setting brightness=0 is disabling the backlight.
In the new case, setting brightness=0 will set the brightness to 0 and 
will do nothing to backlight disable.

I think that should not be a problem?

> 
> I cannot see why you need the extra check on ->enabled?
> Would it be sufficient to check backlight_is_blank() only?

This extra check on bl->enabled flag is added to avoid 
enabling/disabling backlight again if it is already enabled/disabled.
Using this flag way can know the transition between backlight blank and 
un-blank, and decide when to enable/disable the backlight.

> 
>> +		if (!bl->enabled) {
>> +			drm_edp_backlight_enable(bl->aux, &bl->info, brightness);
>> +			bl->enabled = true;
>> +			return 0;
>> +		}
>> +		ret = drm_edp_backlight_set_level(bl->aux, &bl->info, brightness);
>> +	} else {
>> +		if (bl->enabled) {
>> +			drm_edp_backlight_disable(bl->aux, &bl->info);
>> +			bl->enabled = false;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
> 
> 	Sam

Thanks,
Rajeev
