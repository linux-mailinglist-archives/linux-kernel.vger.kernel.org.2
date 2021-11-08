Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98E4497FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbhKHPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbhKHPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:20:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778ECC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 07:17:37 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso53004wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 07:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=hBEGhoX5YuNLFtwj0iZldxCPL/IU1JHW309UHcbi6N0=;
        b=L8/zB7BSBqyEz55VvZb2onr/HFN94h4kOWeL7YKHsOsT6aNM9jUhR/4oD9HwZJ4vNL
         CrsZGGjPrY/EtdG2BuMc6FD6fiT05/iN3LeAelAyxYKbBQigeQTjqjw9wGhX+50L0qz1
         MpjojiscjFDkUXddHTcuRAa2J1CAvkLAJWlMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=hBEGhoX5YuNLFtwj0iZldxCPL/IU1JHW309UHcbi6N0=;
        b=Zd8BoyZaSMPScZJcMFWUet75LJET6z7y0WtE1SeFIZiHxuB74ecdIQjjK1HXmau5SH
         S7URTJ1rk+n0NmmsylFqC6cqlY9c4XmVezqdF5n4edlQkVkIVOAbqeZiAS4YUTgRUyPK
         ViuScLU5WHN2RXhFiivO8XsVsD71FRv0B4qjZsB+KPoOY0rgx1iC6PcHtKu6EJ4sLkAl
         1J8QEwux2OaumwFRH6o0Z7XFNwE0gr2SnFYuFlk22CHgdL3an6Qm7iFmizAr7ozpkEvE
         SVGmvCnuekiEHhBWYXB8L4CiM1kybwzhbLjTS+Vpzkx65UBvGOjnZIoPOS5IfgKoqRKq
         JgFg==
X-Gm-Message-State: AOAM5320emTjrH4DwFlBNKCA8FP7j37lLv7Gc0fViV8NyHpdXGHSfKmo
        KRZVgJFR8pzEcLn+j/ECAjdK4A==
X-Google-Smtp-Source: ABdhPJyp7OwRHBxwCBRfEWA+tElkasv2jnP+G3zoYuHxViLc/uz2nRtyKPxBmH9BvrPQOAu7OmBUOw==
X-Received: by 2002:a1c:1fcf:: with SMTP id f198mr93457wmf.66.1636384656073;
        Mon, 08 Nov 2021 07:17:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l8sm22202895wmc.40.2021.11.08.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:17:35 -0800 (PST)
Date:   Mon, 8 Nov 2021 16:17:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/tegra: Use drm_dp_aux_register_ddc/chardev()
 helpers
Message-ID: <YYk/jfcceun/Qleq@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211107230821.13511-1-digetx@gmail.com>
 <20211107230821.13511-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107230821.13511-2-digetx@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 02:08:21AM +0300, Dmitry Osipenko wrote:
> Use drm_dp_aux_register_ddc/chardev() helpers that allow to register I2C
> adapter separately from the character device. This fixes broken display
> panel driver of Acer Chromebook CB5-311 that fails to probe starting with
> v5.13 kernel when DP AUX registration order was changed. Tegra SOR driver
> is never probed now using the new registration order because tegra-output
> always fails with -EPROBE_DEFER due to missing display panel that requires
> DP AUX DDC to be registered first. The offending commit made DDC to be
> registered after SOR's output, which can't ever happen. Use new helpers
> to restore the registration order and revive display panel.

This feels a bit backward, I think the clean solution would be to untangle
the SOR loading from the panel driver loading, and then only block
registering the overall drm_device on both drivers having loaded.

This here at least feels like a game of whack-a-mole, if like every driver
needs its own careful staging of everything.
-Daniel

> 
> Cc: <stable@vger.kernel.org> # 5.13+
> Fixes: 39c17ae60ea9 ("drm/tegra: Don't register DP AUX channels before connectors")
> Reported-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
> Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dpaux.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
> index 1f96e416fa08..e0d675c7c2e5 100644
> --- a/drivers/gpu/drm/tegra/dpaux.c
> +++ b/drivers/gpu/drm/tegra/dpaux.c
> @@ -532,7 +532,9 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
>  	dpaux->aux.transfer = tegra_dpaux_transfer;
>  	dpaux->aux.dev = &pdev->dev;
>  
> -	drm_dp_aux_init(&dpaux->aux);
> +	err = drm_dp_aux_register_ddc(&dpaux->aux);
> +	if (err < 0)
> +		return err;
>  
>  	/*
>  	 * Assume that by default the DPAUX/I2C pads will be used for HDMI,
> @@ -585,6 +587,8 @@ static int tegra_dpaux_remove(struct platform_device *pdev)
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> +	drm_dp_aux_unregister_ddc(&dpaux->aux);
> +
>  	mutex_lock(&dpaux_lock);
>  	list_del(&dpaux->list);
>  	mutex_unlock(&dpaux_lock);
> @@ -718,7 +722,7 @@ int drm_dp_aux_attach(struct drm_dp_aux *aux, struct tegra_output *output)
>  	int err;
>  
>  	aux->drm_dev = output->connector.dev;
> -	err = drm_dp_aux_register(aux);
> +	err = drm_dp_aux_register_chardev(aux);
>  	if (err < 0)
>  		return err;
>  
> @@ -759,7 +763,7 @@ int drm_dp_aux_detach(struct drm_dp_aux *aux)
>  	unsigned long timeout;
>  	int err;
>  
> -	drm_dp_aux_unregister(aux);
> +	drm_dp_aux_unregister_chardev(aux);
>  	disable_irq(dpaux->irq);
>  
>  	if (dpaux->output->panel) {
> -- 
> 2.33.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
