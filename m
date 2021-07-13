Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE83C6B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhGMHa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:30:58 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:48103 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMHaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:30:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626161286; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Y8eLr8kxHQ/y0L4H+qJvJ5sC7Y47v/NJfTSygVD67Zg=;
 b=ly0XDDTC1V0ObFA8EjOQ2MQvkb7mUaASy7UuQilZehlG5G6r+h+NtnNnh/vaxfh2BHt1fZEc
 P1tOCQ0LNVbaK5K04/+/+Z/7J0t3two2+cGwBUN8VG3Yre90EUABN/7tnNud+0IlEc6Y6Hxb
 t3DUZtcTd5Wo7i+0QWEOLrWyqxs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60ed40735e3e57240ba02db5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 13 Jul 2021 07:27:47
 GMT
Sender: rajeevny=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D11AC43144; Tue, 13 Jul 2021 07:27:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rajeevny)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D496CC433F1;
        Tue, 13 Jul 2021 07:27:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 13 Jul 2021 12:57:42 +0530
From:   rajeevny@codeaurora.org
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Lyude Paul <lyude@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        ville.syrjala@linux.intel.com,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/dp: Move panel DP AUX backlight support to
 drm_dp_helper
In-Reply-To: <20210712075933.v2.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid>
References: <20210712075933.v2.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid>
Message-ID: <b6a9fd7eb6068eb7d3bfa4e9b75cc07f@codeaurora.org>
X-Sender: rajeevny@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 12-07-2021 20:30, Douglas Anderson wrote:
> We were getting a depmod error:
>   depmod: ERROR: Cycle detected: drm_kms_helper -> drm -> 
> drm_kms_helper
> 
> It looks like the rule is that drm_kms_helper can call into drm, but
> drm can't call into drm_kms_helper. That means we've got to move the
> DP AUX backlight support into drm_dp_helper.
> 
> NOTE: as part of this, I didn't try to do any renames of the main
> registration function. Even though it's in the drm_dp_helper, it still
> feels very parallel to drm_panel_of_backlight().
> 
> Fixes: 10f7b40e4f30 ("drm/panel: add basic DP AUX backlight support")
> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Note that I've compile tested this, but I don't have a device setup
> yet that uses this code. Since the code is basically the same as it
> was this should be OK, but if Rajeev could confirm that nothing is
> broken that'd be nice.
> 

Reviewed-by: Rajeev Nandan <rajeevny@codeaurora.org>

Thanks,
Rajeev


> Changes in v2:
> - Guard new functions by the proper configs.
> 
>  drivers/gpu/drm/drm_dp_helper.c | 113 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_panel.c     | 108 ------------------------------
>  include/drm/drm_dp_helper.h     |  16 +++++
>  include/drm/drm_panel.h         |   8 ---
>  4 files changed, 129 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c 
> b/drivers/gpu/drm/drm_dp_helper.c
> index 24bbc710c825..e8eec20ab364 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -33,9 +33,17 @@
>  #include <drm/drm_print.h>
>  #include <drm/drm_vblank.h>
>  #include <drm/drm_dp_mst_helper.h>
> +#include <drm/drm_panel.h>
> 
>  #include "drm_crtc_helper_internal.h"
> 
> +struct dp_aux_backlight {
> +	struct backlight_device *base;
> +	struct drm_dp_aux *aux;
> +	struct drm_edp_backlight_info info;
> +	bool enabled;
> +};
> +
>  /**
>   * DOC: dp helpers
>   *
> @@ -3462,3 +3470,108 @@ drm_edp_backlight_init(struct drm_dp_aux *aux,
> struct drm_edp_backlight_info *bl
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_edp_backlight_init);
> +
> +#if IS_BUILTIN(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
> +	(IS_MODULE(CONFIG_DRM_KMS_HELPER) && 
> IS_MODULE(CONFIG_BACKLIGHT_CLASS_DEVICE))
> +
> +static int dp_aux_backlight_update_status(struct backlight_device *bd)
> +{
> +	struct dp_aux_backlight *bl = bl_get_data(bd);
> +	u16 brightness = backlight_get_brightness(bd);
> +	int ret = 0;
> +
> +	if (!backlight_is_blank(bd)) {
> +		if (!bl->enabled) {
> +			drm_edp_backlight_enable(bl->aux, &bl->info, brightness);
> +			bl->enabled = true;
> +			return 0;
> +		}
> +		ret = drm_edp_backlight_set_level(bl->aux, &bl->info, brightness);
> +	} else {
> +		if (bl->enabled) {
> +			drm_edp_backlight_disable(bl->aux, &bl->info);
> +			bl->enabled = false;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct backlight_ops dp_aux_bl_ops = {
> +	.update_status = dp_aux_backlight_update_status,
> +};
> +
> +/**
> + * drm_panel_dp_aux_backlight - create and use DP AUX backlight
> + * @panel: DRM panel
> + * @aux: The DP AUX channel to use
> + *
> + * Use this function to create and handle backlight if your panel
> + * supports backlight control over DP AUX channel using DPCD
> + * registers as per VESA's standard backlight control interface.
> + *
> + * When the panel is enabled backlight will be enabled after a
> + * successful call to &drm_panel_funcs.enable()
> + *
> + * When the panel is disabled backlight will be disabled before the
> + * call to &drm_panel_funcs.disable().
> + *
> + * A typical implementation for a panel driver supporting backlight
> + * control over DP AUX will call this function at probe time.
> + * Backlight will then be handled transparently without requiring
> + * any intervention from the driver.
> + *
> + * drm_panel_dp_aux_backlight() must be called after the call to
> drm_panel_init().
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct 
> drm_dp_aux *aux)
> +{
> +	struct dp_aux_backlight *bl;
> +	struct backlight_properties props = { 0 };
> +	u16 current_level;
> +	u8 current_mode;
> +	u8 edp_dpcd[EDP_DISPLAY_CTL_CAP_SIZE];
> +	int ret;
> +
> +	if (!panel || !panel->dev || !aux)
> +		return -EINVAL;
> +
> +	ret = drm_dp_dpcd_read(aux, DP_EDP_DPCD_REV, edp_dpcd,
> +			       EDP_DISPLAY_CTL_CAP_SIZE);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!drm_edp_backlight_supported(edp_dpcd)) {
> +		DRM_DEV_INFO(panel->dev, "DP AUX backlight is not supported\n");
> +		return 0;
> +	}
> +
> +	bl = devm_kzalloc(panel->dev, sizeof(*bl), GFP_KERNEL);
> +	if (!bl)
> +		return -ENOMEM;
> +
> +	bl->aux = aux;
> +
> +	ret = drm_edp_backlight_init(aux, &bl->info, 0, edp_dpcd,
> +				     &current_level, &current_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	props.type = BACKLIGHT_RAW;
> +	props.brightness = current_level;
> +	props.max_brightness = bl->info.max;
> +
> +	bl->base = devm_backlight_device_register(panel->dev, 
> "dp_aux_backlight",
> +						  panel->dev, bl,
> +						  &dp_aux_bl_ops, &props);
> +	if (IS_ERR(bl->base))
> +		return PTR_ERR(bl->base);
> +
> +	panel->backlight = bl->base;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_panel_dp_aux_backlight);
> +
> +#endif
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 4fa1e3bb1b78..f634371c717a 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -26,20 +26,12 @@
>  #include <linux/module.h>
> 
>  #include <drm/drm_crtc.h>
> -#include <drm/drm_dp_helper.h>
>  #include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
> 
>  static DEFINE_MUTEX(panel_lock);
>  static LIST_HEAD(panel_list);
> 
> -struct dp_aux_backlight {
> -	struct backlight_device *base;
> -	struct drm_dp_aux *aux;
> -	struct drm_edp_backlight_info info;
> -	bool enabled;
> -};
> -
>  /**
>   * DOC: drm panel
>   *
> @@ -350,106 +342,6 @@ int drm_panel_of_backlight(struct drm_panel 
> *panel)
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_panel_of_backlight);
> -
> -static int dp_aux_backlight_update_status(struct backlight_device *bd)
> -{
> -	struct dp_aux_backlight *bl = bl_get_data(bd);
> -	u16 brightness = backlight_get_brightness(bd);
> -	int ret = 0;
> -
> -	if (!backlight_is_blank(bd)) {
> -		if (!bl->enabled) {
> -			drm_edp_backlight_enable(bl->aux, &bl->info, brightness);
> -			bl->enabled = true;
> -			return 0;
> -		}
> -		ret = drm_edp_backlight_set_level(bl->aux, &bl->info, brightness);
> -	} else {
> -		if (bl->enabled) {
> -			drm_edp_backlight_disable(bl->aux, &bl->info);
> -			bl->enabled = false;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -static const struct backlight_ops dp_aux_bl_ops = {
> -	.update_status = dp_aux_backlight_update_status,
> -};
> -
> -/**
> - * drm_panel_dp_aux_backlight - create and use DP AUX backlight
> - * @panel: DRM panel
> - * @aux: The DP AUX channel to use
> - *
> - * Use this function to create and handle backlight if your panel
> - * supports backlight control over DP AUX channel using DPCD
> - * registers as per VESA's standard backlight control interface.
> - *
> - * When the panel is enabled backlight will be enabled after a
> - * successful call to &drm_panel_funcs.enable()
> - *
> - * When the panel is disabled backlight will be disabled before the
> - * call to &drm_panel_funcs.disable().
> - *
> - * A typical implementation for a panel driver supporting backlight
> - * control over DP AUX will call this function at probe time.
> - * Backlight will then be handled transparently without requiring
> - * any intervention from the driver.
> - *
> - * drm_panel_dp_aux_backlight() must be called after the call to
> drm_panel_init().
> - *
> - * Return: 0 on success or a negative error code on failure.
> - */
> -int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct 
> drm_dp_aux *aux)
> -{
> -	struct dp_aux_backlight *bl;
> -	struct backlight_properties props = { 0 };
> -	u16 current_level;
> -	u8 current_mode;
> -	u8 edp_dpcd[EDP_DISPLAY_CTL_CAP_SIZE];
> -	int ret;
> -
> -	if (!panel || !panel->dev || !aux)
> -		return -EINVAL;
> -
> -	ret = drm_dp_dpcd_read(aux, DP_EDP_DPCD_REV, edp_dpcd,
> -			       EDP_DISPLAY_CTL_CAP_SIZE);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (!drm_edp_backlight_supported(edp_dpcd)) {
> -		DRM_DEV_INFO(panel->dev, "DP AUX backlight is not supported\n");
> -		return 0;
> -	}
> -
> -	bl = devm_kzalloc(panel->dev, sizeof(*bl), GFP_KERNEL);
> -	if (!bl)
> -		return -ENOMEM;
> -
> -	bl->aux = aux;
> -
> -	ret = drm_edp_backlight_init(aux, &bl->info, 0, edp_dpcd,
> -				     &current_level, &current_mode);
> -	if (ret < 0)
> -		return ret;
> -
> -	props.type = BACKLIGHT_RAW;
> -	props.brightness = current_level;
> -	props.max_brightness = bl->info.max;
> -
> -	bl->base = devm_backlight_device_register(panel->dev, 
> "dp_aux_backlight",
> -						  panel->dev, bl,
> -						  &dp_aux_bl_ops, &props);
> -	if (IS_ERR(bl->base))
> -		return PTR_ERR(bl->base);
> -
> -	panel->backlight = bl->base;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(drm_panel_dp_aux_backlight);
>  #endif
> 
>  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 729d5d82475e..a1b2d945def6 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -30,6 +30,7 @@
> 
>  struct drm_device;
>  struct drm_dp_aux;
> +struct drm_panel;
> 
>  /*
>   * Unless otherwise noted, all values are from the DP 1.1a spec.  Note 
> that
> @@ -2200,6 +2201,21 @@ int drm_edp_backlight_enable(struct drm_dp_aux
> *aux, const struct drm_edp_backli
>  			     u16 level);
>  int drm_edp_backlight_disable(struct drm_dp_aux *aux, const struct
> drm_edp_backlight_info *bl);
> 
> +#if IS_ENABLED(CONFIG_DRM_KMS_HELPER) &&
> (IS_BUILTIN(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
> +	(IS_MODULE(CONFIG_DRM_KMS_HELPER) &&
> IS_MODULE(CONFIG_BACKLIGHT_CLASS_DEVICE)))
> +
> +int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct
> drm_dp_aux *aux);
> +
> +#else
> +
> +static inline int drm_panel_dp_aux_backlight(struct drm_panel *panel,
> +					     struct drm_dp_aux *aux)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_DRM_DP_CEC
>  void drm_dp_cec_irq(struct drm_dp_aux *aux);
>  void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 71aac751a032..4602f833eb51 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -32,7 +32,6 @@ struct backlight_device;
>  struct device_node;
>  struct drm_connector;
>  struct drm_device;
> -struct drm_dp_aux;
>  struct drm_panel;
>  struct display_timing;
> 
> @@ -209,18 +208,11 @@ static inline int
> of_drm_get_panel_orientation(const struct device_node *np,
>  #if IS_ENABLED(CONFIG_DRM_PANEL) &&
> (IS_BUILTIN(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
>  	(IS_MODULE(CONFIG_DRM) && IS_MODULE(CONFIG_BACKLIGHT_CLASS_DEVICE)))
>  int drm_panel_of_backlight(struct drm_panel *panel);
> -int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct
> drm_dp_aux *aux);
>  #else
>  static inline int drm_panel_of_backlight(struct drm_panel *panel)
>  {
>  	return 0;
>  }
> -
> -static inline int drm_panel_dp_aux_backlight(struct drm_panel *panel,
> -					     struct drm_dp_aux *aux)
> -{
> -	return 0;
> -}
>  #endif
> 
>  #endif
