Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE927397A17
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhFAS34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233853AbhFAS3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622572093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOsIlqxl6eH239Kciu24BWgBMb9sBjim1wXteqsp/Pc=;
        b=HZ3yXu4vl+mmEw4av1ETywTfPSps3P8HA/RgNUhdx22KdpKY4gAzcdBjzLBtMvqbxqfK1v
        Z/z1oh8sy4HNbmjjxD7nDmRWzQzIlj/pblPr+MTXin6IF4/3qNtegA+NbiZZ2V3zwro/Jd
        OpRvHWXKt3NaMh8GasiZKuBR6pYF7BQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-gGoXMNqBMb-eekYrOArzkw-1; Tue, 01 Jun 2021 14:28:12 -0400
X-MC-Unique: gGoXMNqBMb-eekYrOArzkw-1
Received: by mail-qt1-f198.google.com with SMTP id b19-20020ac84f130000b02901d543c52248so5158658qte.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=NOsIlqxl6eH239Kciu24BWgBMb9sBjim1wXteqsp/Pc=;
        b=Nv5MTuP812SjfRPcOEDT9d8R8l065j6mOVJWNo0xv9YvJG+ZKbU7N3lD4vct9Ohxud
         rplduP6IF9il+5+1wXt53mgnX1sF7xNRwdwv9AUzl9F5pvdIWMNzlztL+adgP+9aw0A3
         Z6/FKi/xJn8IKRBH4QbbNAWz29akroodmkYMpE6AFZof7XNQHcpcCG/fRzvxPDlCSi9H
         H/RzfW4oLinwhFx0gZh/kmsBLpmtNw7UHdslV5UXz7nYGaXju0wBe5PT+wESUbK6YoUw
         RrMN5Zg8w9vDTj1ah/+PaI5D2BbQpmfFJ/6mvPzwZ+ILYvgBwYmQeNwUIFi7uz/wcHMY
         Od3A==
X-Gm-Message-State: AOAM533C0OyzQ7gbAwIEE/ZaHCfFYlxMqfJra5nfUdY0KVEYuWc/xByT
        FoWeJFxdWDoizx+33bxTBhPikPGblDiUG3Tu+uzCrKyluIdf0HolsTgtIyTGIlvriVSXhuAsZlT
        R11B3XSWJoLBtKGN8qJQYa1Wi
X-Received: by 2002:a0c:e148:: with SMTP id c8mr9666333qvl.18.1622572091668;
        Tue, 01 Jun 2021 11:28:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytSZnefoM3XSTSKdxOIOsXny4+VC2C+Z/p3WaHhH0IWvNmokJ6MGvgRHfSYxb86PPeGka/Rg==
X-Received: by 2002:a0c:e148:: with SMTP id c8mr9666307qvl.18.1622572091422;
        Tue, 01 Jun 2021 11:28:11 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id e19sm10809288qtr.45.2021.06.01.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 11:28:11 -0700 (PDT)
Message-ID: <366f2fe575003487da4c2bd63c70abc16051dcb2.camel@redhat.com>
Subject: Re: [v4 1/4] drm/panel-simple: Add basic DPCD backlight support
From:   Lyude Paul <lyude@redhat.com>
To:     Rajeev Nandan <rajeevny@codeaurora.org>, y@qualcomm.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        sam@ravnborg.org, robdclark@gmail.com, dianders@chromium.org,
        jani.nikula@intel.com, robh@kernel.org,
        laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        daniel.thompson@linaro.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, mkrishn@codeaurora.org
Date:   Tue, 01 Jun 2021 14:28:09 -0400
In-Reply-To: <1621927831-29471-2-git-send-email-rajeevny@codeaurora.org>
References: <1621927831-29471-1-git-send-email-rajeevny@codeaurora.org>
         <1621927831-29471-2-git-send-email-rajeevny@codeaurora.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry-I've been waiting to review this, but the DPCD backlight support helper
series is -still- blocked on getting reviews upstream :\

On Tue, 2021-05-25 at 13:00 +0530, Rajeev Nandan wrote:
> Add basic support of panel backlight control over eDP aux channel
> using VESA's standard backlight control interface.
> 
> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> ---
> 
> This patch depends on [1] (drm/panel: panel-simple: Stash DP AUX bus; 
> allow using it for DDC) 
> 
> Changes in v4:
> - New
> 
> [1]
> https://lore.kernel.org/dri-devel/20210524165920.v8.7.I18e60221f6d048d14d6c50a770b15f356fa75092@changeid/
> 
>  drivers/gpu/drm/panel/panel-simple.c | 99
> ++++++++++++++++++++++++++++++++++--
>  1 file changed, 96 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c
> b/drivers/gpu/drm/panel/panel-simple.c
> index b09be6e..f9e4e60 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -21,6 +21,7 @@
>   * DEALINGS IN THE SOFTWARE.
>   */
>  
> +#include <linux/backlight.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/iopoll.h>
> @@ -171,6 +172,19 @@ struct panel_desc {
>  
>         /** @connector_type: LVDS, eDP, DSI, DPI, etc. */
>         int connector_type;
> +
> +       /**
> +        * @uses_dpcd_backlight: Panel supports eDP dpcd backlight control.
> +        *
> +        * Set true, if the panel supports backlight control over eDP AUX
> channel
> +        * using DPCD registers as per VESA's standard.
> +        */
> +       bool uses_dpcd_backlight;
> +};
> +
> +struct edp_backlight {
> +       struct backlight_device *dev;
> +       struct drm_edp_backlight_info info;
>  };
>  
>  struct panel_simple {
> @@ -194,6 +208,8 @@ struct panel_simple {
>  
>         struct edid *edid;
>  
> +       struct edp_backlight *edp_bl;
> +
>         struct drm_display_mode override_mode;
>  
>         enum drm_panel_orientation orientation;
> @@ -330,10 +346,14 @@ static void panel_simple_wait(ktime_t start_ktime,
> unsigned int min_ms)
>  static int panel_simple_disable(struct drm_panel *panel)
>  {
>         struct panel_simple *p = to_panel_simple(panel);
> +       struct edp_backlight *bl = p->edp_bl;
>  
>         if (!p->enabled)
>                 return 0;
>  
> +       if (p->desc->uses_dpcd_backlight && bl)
> +               drm_edp_backlight_disable(p->aux, &bl->info);
> +
>         if (p->desc->delay.disable)
>                 msleep(p->desc->delay.disable);
>  
> @@ -496,6 +516,7 @@ static int panel_simple_prepare(struct drm_panel *panel)
>  static int panel_simple_enable(struct drm_panel *panel)
>  {
>         struct panel_simple *p = to_panel_simple(panel);
> +       struct edp_backlight *bl = p->edp_bl;
>  
>         if (p->enabled)
>                 return 0;
> @@ -505,6 +526,10 @@ static int panel_simple_enable(struct drm_panel *panel)
>  
>         panel_simple_wait(p->prepared_time, p->desc-
> >delay.prepare_to_enable);
>  
> +       if (p->desc->uses_dpcd_backlight && bl)
> +               drm_edp_backlight_enable(p->aux, &bl->info,
> +                                        bl->dev->props.brightness);
> +
>         p->enabled = true;
>  
>         return 0;
> @@ -565,6 +590,59 @@ static const struct drm_panel_funcs panel_simple_funcs
> = {
>         .get_timings = panel_simple_get_timings,
>  };
>  
> +static int edp_backlight_update_status(struct backlight_device *bd)
> +{
> +       struct panel_simple *p = bl_get_data(bd);
> +       struct edp_backlight *bl = p->edp_bl;
> +
> +       if (!p->enabled)
> +               return 0;
> +
> +       return drm_edp_backlight_set_level(p->aux, &bl->info, bd-
> >props.brightness);
> +}
> +
> +static const struct backlight_ops edp_backlight_ops = {
> +       .update_status = edp_backlight_update_status,
> +};
> +
> +static int edp_backlight_register(struct device *dev, struct panel_simple
> *panel)
> +{
> +       struct edp_backlight *bl;
> +       struct backlight_properties props = { 0 };
> +       u16 current_level;
> +       u8 current_mode;
> +       u8 edp_dpcd[EDP_DISPLAY_CTL_CAP_SIZE];
> +       int ret;
> +
> +       bl = devm_kzalloc(dev, sizeof(*bl), GFP_KERNEL);
> +       if (!bl)
> +               return -ENOMEM;
> +
> +       ret = drm_dp_dpcd_read(panel->aux, DP_EDP_DPCD_REV, edp_dpcd,
> +                              EDP_DISPLAY_CTL_CAP_SIZE);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = drm_edp_backlight_init(panel->aux, &bl->info, 0, edp_dpcd,
> +                                    &current_level, &current_mode);
> +       if (ret < 0)
> +               return ret;
> +
> +       props.type = BACKLIGHT_RAW;
> +       props.brightness = current_level;
> +       props.max_brightness = bl->info.max;
> +
> +       bl->dev = devm_backlight_device_register(dev, "edp_backlight",
> +                                               dev, panel,
> +                                               &edp_backlight_ops, &props);
> +       if (IS_ERR(bl->dev))
> +               return PTR_ERR(bl->dev);
> +
> +       panel->edp_bl = bl;
> +
> +       return 0;
> +}
> +
>  static struct panel_desc panel_dpi;
>  
>  static int panel_dpi_probe(struct device *dev,
> @@ -796,9 +874,24 @@ static int panel_simple_probe(struct device *dev, const
> struct panel_desc *desc,
>  
>         drm_panel_init(&panel->base, dev, &panel_simple_funcs,
> connector_type);
>  
> -       err = drm_panel_of_backlight(&panel->base);
> -       if (err)
> -               goto disable_pm_runtime;
> +       if (panel->desc->uses_dpcd_backlight) {
> +               if (!panel->aux) {
> +                       dev_err(dev, "edp backlight needs DP aux\n");
> +                       err = -EINVAL;
> +                       goto disable_pm_runtime;
> +               }
> +
> +               err = edp_backlight_register(dev, panel);
> +               if (err) {
> +                       dev_err(dev, "failed to register edp backlight
> %d\n", err);
> +                       goto disable_pm_runtime;
> +               }
> +
> +       } else {
> +               err = drm_panel_of_backlight(&panel->base);
> +               if (err)
> +                       goto disable_pm_runtime;
> +       }
>  
>         drm_panel_add(&panel->base);
>  

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

