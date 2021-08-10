Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8013E581A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbhHJKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhHJKTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:19:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C408DC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 03:18:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b11so9375731wrx.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ypz43Y7ht5yYPrHsmCF+aueU4gZCkS1cG/1GAPtZPFc=;
        b=R+OW/xFuOkLahmCf4qAPxmhZ0v0kNmMW8QPSLqB83Ihp6rlDsVgu3zCMRpFZdHI8L5
         EO9zUOTjLrZckWIMazJuhc9wx9MUiAHuFJnK5r5irvffTxUcLQw+TscabHn9fkt+Ox6/
         kYCi1+bs1d48eKqq5cXH8sw9Ny5ATK9r62gMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ypz43Y7ht5yYPrHsmCF+aueU4gZCkS1cG/1GAPtZPFc=;
        b=AJCPdd4mw1aYiqxV2+M6oIkxF1PqiE/NdiWpS+RHxXaeSy6rGQlyGmJluR7qcnz5X3
         iBNv9gfxiQVbuW5+Fglh1A5/72nMZwKHMXHjXKsfrVrUq7MYCxjWz909JnaWaCsV5S7T
         caaV98nr7epuToggIudozAB7jULo41aXh8luTZh/DM9JiEi34bBwG9MuysCWgnoTr7aN
         zK5qLdKH+c3R8NI4f0WRGoK68FKvrF79bLyokf5uLHd21LsjIggrcNqfNFDDIkV58VB1
         9wOAeRTG7zmoIgbDn2MDADT7HoX/wiOi02mR80HyPM+PN1+4EVVHTFvkRAi+NAPHSLiE
         SrQQ==
X-Gm-Message-State: AOAM533+WDrJc9N3a8UDFPEJ/ME+n1gt5FtlslT07SNYHagptccE2bP3
        R3cnem6VOWfSnymXmvTwEqnZUg==
X-Google-Smtp-Source: ABdhPJyJynbXqePsNSwEyVY1512w9lGozC+ZnWM7Y5j68AQk7xYtQOTJceaK4TGRZ3ho9pMitB0j/Q==
X-Received: by 2002:a5d:4309:: with SMTP id h9mr15828319wrq.299.1628590720316;
        Tue, 10 Aug 2021 03:18:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j6sm2332384wmq.29.2021.08.10.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 03:18:39 -0700 (PDT)
Date:   Tue, 10 Aug 2021 12:18:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [PATCH v2 1/3] drm/panel: seperate panel power control from
 panel prepare/unprepare
Message-ID: <YRJSfdsAv9gZCO2R@phenom.ffwll.local>
Mail-Followup-To: Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
References: <20210808125218.63029-1-jitao.shi@mediatek.com>
 <20210808125218.63029-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210808125218.63029-2-jitao.shi@mediatek.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 08:52:16PM +0800, Jitao Shi wrote:
> Some dsi panels require the dsi lanes keeping low before panel power
> on. So seperate the panel power control and the communication with panel.
> 
> And put the power control in drm_panel_prepare_power and
> drm_panel_unprepare_power. Put the communication with panel in
> drm_panel_prepare and drm_panel_unprepare.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

This solves your problem, but it breaks the panel standard for everyone
else since you're not converting them over.

There needs to be more thought here in how to make this all compatible.

Also I think we need very precise spec for how this is supposed to work
with DSI panels, and then making sure existing drivers mostly follow this.

Hacking up a shared interface that's used by lots of drivers just to then
fix a bug in one user and one implementation is not good.
-Daniel

> ---
>  drivers/gpu/drm/bridge/panel.c | 17 +++++++++++++++
>  drivers/gpu/drm/drm_panel.c    | 38 ++++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h       |  2 ++
>  include/drm/drm_panel.h        | 17 +++++++++++++++
>  4 files changed, 74 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index c916f4b8907e..3a846ac8e24c 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -137,6 +137,23 @@ static int panel_bridge_get_modes(struct drm_bridge *bridge,
>  	return drm_panel_get_modes(panel_bridge->panel, connector);
>  }
>  
> +int panel_bridge_prepare_power(struct drm_bridge *bridge)
> +{
> +	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> +
> +	return drm_panel_prepare_power(panel_bridge->panel);
> +}
> +EXPORT_SYMBOL(panel_bridge_prepare_power);
> +
> +int panel_bridge_unprepare_power(struct drm_bridge *bridge)
> +{
> +        struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> +
> +        return drm_panel_unprepare_power(panel_bridge->panel);
> +}
> +EXPORT_SYMBOL(panel_bridge_unprepare_power);
> +
> +
>  static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
>  	.attach = panel_bridge_attach,
>  	.detach = panel_bridge_detach,
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f634371c717a..7bb5185db17d 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -115,6 +115,24 @@ int drm_panel_prepare(struct drm_panel *panel)
>  }
>  EXPORT_SYMBOL(drm_panel_prepare);
>  
> +/**
> + * drm_panel_prepare_power - power on a panel's power
> + * @panel: DRM panel
> + *
> + * Calling this function will enable power and deassert any reset signals to
> + * the panel.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int drm_panel_prepare_power(struct drm_panel *panel)
> +{
> +	if (panel && panel->funcs && panel->funcs->prepare_power)
> +		return panel->funcs->prepare_power(panel);
> +
> +	return panel ? -ENOSYS : -EINVAL;
> +}
> +EXPORT_SYMBOL(drm_panel_prepare_power);
> +
>  /**
>   * drm_panel_unprepare - power off a panel
>   * @panel: DRM panel
> @@ -138,6 +156,26 @@ int drm_panel_unprepare(struct drm_panel *panel)
>  }
>  EXPORT_SYMBOL(drm_panel_unprepare);
>  
> +/**
> + * drm_panel_unprepare_power - power off a panel
> + * @panel: DRM panel
> + *
> + * Calling this function will completely power off a panel (assert the panel's
> + * reset, turn off power supplies, ...). After this function has completed, it
> + * is usually no longer possible to communicate with the panel until another
> + * call to drm_panel_prepare_power and drm_panel_prepare().
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int drm_panel_unprepare_power(struct drm_panel *panel)
> +{
> +	if (panel && panel->funcs && panel->funcs->unprepare_power)
> +		return panel->funcs->unprepare_power(panel);
> +
> +	return panel ? -ENOSYS : -EINVAL;
> +}
> +EXPORT_SYMBOL(drm_panel_unprepare_power);
> +
>  /**
>   * drm_panel_enable - enable a panel
>   * @panel: DRM panel
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 2195daa289d2..cc94c9da47d8 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -892,6 +892,8 @@ struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
>  						   struct drm_panel *panel,
>  						   u32 connector_type);
>  struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge);
> +int panel_bridge_prepare_power(struct drm_bridge *bridge);
> +int panel_bridge_unprepare_power(struct drm_bridge *bridge);
>  #endif
>  
>  #endif
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 33605c3f0eba..48e83712ad44 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -68,6 +68,13 @@ enum drm_panel_orientation;
>   * functionality to enable/disable backlight.
>   */
>  struct drm_panel_funcs {
> +	/**
> +	 * @prepare_power:
> +	 *
> +	 * Turn on panel power.
> +	 */
> +	int (*prepare_power)(struct drm_panel *panel);
> +
>  	/**
>  	 * @prepare:
>  	 *
> @@ -115,6 +122,13 @@ struct drm_panel_funcs {
>  	int (*get_modes)(struct drm_panel *panel,
>  			 struct drm_connector *connector);
>  
> +	/**
> +	 * @unprepare_power:
> +	 *
> +	 * Turn off panel_power.
> +	 */
> +	int (*unprepare_power)(struct drm_panel *panel);
> +
>  	/**
>  	 * @get_timings:
>  	 *
> @@ -180,6 +194,9 @@ void drm_panel_init(struct drm_panel *panel, struct device *dev,
>  void drm_panel_add(struct drm_panel *panel);
>  void drm_panel_remove(struct drm_panel *panel);
>  
> +int drm_panel_prepare_power(struct drm_panel *panel);
> +int drm_panel_unprepare_power(struct drm_panel *panel);
> +
>  int drm_panel_prepare(struct drm_panel *panel);
>  int drm_panel_unprepare(struct drm_panel *panel);
>  
> -- 
> 2.25.1

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
