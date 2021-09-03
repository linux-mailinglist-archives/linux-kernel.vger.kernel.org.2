Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998423FFD2D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbhICJcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348819AbhICJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:32:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C180DC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 02:31:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me10so10770969ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=+2zVhYW2JhNFC6ivmbY+NMg91kMXNKRAFmGUAVihMLE=;
        b=egJYq0hTL6e9zJ4V7sjc1cKL1hklggrK8sGHWrY5YYrrs9k9qB1aZGHCaGN2QE1qRE
         pfXwPcTs5GPZATJtSx/1BOg8pyR+/tDUrGKuA72LMtQD+EHdPlT3fUlCw9LHoMxWXQmV
         /+A6/pEfvoidDXhA5wbd6OTrVot0ls7umSqbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=+2zVhYW2JhNFC6ivmbY+NMg91kMXNKRAFmGUAVihMLE=;
        b=RXex01mJTYCZp0YLkWmeZSm3moM/Lvyozpy4RLfU0j2ESEp3PlR5jsXT1dIsErzBgs
         DsyXsVAQ3Wy7KtFJNi3Ms/82kPn5Vfh9m8GAWZN6tFI1cOTZgiyLY1YDfhVZ5IxAC4za
         rUu+g7ocTAdyu1eZjGCunVRm5jFSUBS4pEHs100xjs79OYIZ9ajMTnXwFJiEjX7op5l4
         M8/MArdjsRZUvVFA89Iehw1HXenmWneeV3zahdy275FMjAAT46QD/uGH4XbOl3P3QCyG
         STh/vycpSGPKbJNmfDPi2YiX6itRAqyFkXegn8aEm31JoYHPVlr7OK4tK4wUpwKB8Rvp
         ytkw==
X-Gm-Message-State: AOAM531vjDZWe4RBherD1JukPoHlAnxnfuxYKmTznNCaVFi+jJ2U+BLe
        2R5ir0tHUwSTBOc+KI7sYAqzNg==
X-Google-Smtp-Source: ABdhPJzFpo09Q80gAB68CXx6sks4KJyMaFKDKHqvNnWOaO9PAqGjgbMtfoIU6oM1fGsBi54AIg/AjA==
X-Received: by 2002:a17:906:354a:: with SMTP id s10mr3182477eja.357.1630661493357;
        Fri, 03 Sep 2021 02:31:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p8sm2415031ejo.2.2021.09.03.02.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 02:31:32 -0700 (PDT)
Date:   Fri, 3 Sep 2021 11:31:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "ZhiJie.Zhang" <zhangzhijie@loongson.cn>
Cc:     daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        botton_zhang@163.com
Subject: Re: [PATCH v4] drm: Improve the output_poll_changed description
Message-ID: <YTHrcvAXxoVgV0/9@phenom.ffwll.local>
Mail-Followup-To: "ZhiJie.Zhang" <zhangzhijie@loongson.cn>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        botton_zhang@163.com
References: <20210903032402.11935-1-zhangzhijie@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903032402.11935-1-zhangzhijie@loongson.cn>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 11:24:02AM +0800, ZhiJie.Zhang wrote:
> From: zhangzhijie <zhangzhijie@loongson.cn>
> 
> this callback was used by drm_kms_helper_hotplug_event()
> 
> V2: (Thanks for Daniel's suggestions)
> - remove the FIXME below.since with the drm_client
> - infrastructure and the generic fbdev emulation we've
> - resolved this all very neatly now.
> 
> V3: Add comments that This hook is deprecated
> - new implementation methods instead of this hook
> 
> v4: used by drm_kms_helper_hotplug_event()
> - drm_fb_helper_hotplug_changed() is not found
> instead by drm_kms_helper_hotplug_event()
> 
> Signed-off-by: ZhiJie.Zhang <zhangzhijie@loongson.cn>

Applied to drm-misc-next, thanks for the patch.
-Daniel

> ---
>  include/drm/drm_mode_config.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 1ddf7783fdf7..48b7de80daf5 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -103,14 +103,13 @@ struct drm_mode_config_funcs {
>  	 * Callback used by helpers to inform the driver of output configuration
>  	 * changes.
>  	 *
> -	 * Drivers implementing fbdev emulation with the helpers can call
> -	 * drm_fb_helper_hotplug_changed from this hook to inform the fbdev
> -	 * helper of output changes.
> +	 * Drivers implementing fbdev emulation use drm_kms_helper_hotplug_event()
> +	 * to call this hook to inform the fbdev helper of output changes.
>  	 *
> -	 * FIXME:
> -	 *
> -	 * Except that there's no vtable for device-level helper callbacks
> -	 * there's no reason this is a core function.
> +	 * This hook is deprecated, drivers should instead use
> +	 * drm_fbdev_generic_setup() which takes care of any necessary
> +	 * hotplug event forwarding already without further involvement by
> +	 * the driver.
>  	 */
>  	void (*output_poll_changed)(struct drm_device *dev);
>  
> -- 
> 2.33.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
