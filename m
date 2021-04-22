Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF5367CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhDVIsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhDVIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:48:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467C9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:47:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so31936531wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=vhe86cA9Lih/Xt94SXw0z79g/E1uDPv2HAfY3KSx+U8=;
        b=QVQ0oK3P9q5+OKlOxd2cm20f+Pe+5e1RcMSaxC+9Gh0mXJKMsYMm7TE9eBkDByCvJk
         z0t0VbWjfYIHDAGtcSzpLvKSkPXl/BV6E9PlCvPXDiKVnASbaWpqxRa49TmfmEiHGPhO
         y0vxBUIf7EKTCWvPJvWApPxrMKOr8qz8XVCNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=vhe86cA9Lih/Xt94SXw0z79g/E1uDPv2HAfY3KSx+U8=;
        b=YRN5ADe3dHjnO4mqusaCXmKG1mNHQYLRJ2xIT7wfJSha75ym31ZQ5RLGXKag3Ji7DC
         ulHkueYAVm0NmDZS52NhgSUDHkEO8b9jKry+y0CGwmKjRxT3Lh6O2nSsZ6wFOm7GUGbM
         jwU1Fm9+93cD/OG+I7qW1O1DlrNmzMHac+FkptvksnfuHdTy1cs1ke+EMT/OMborxDF1
         ffKnIzXexWsRycd8Z64QSUzAcdV+RNBuc7tJpRCfkSMeJSqeYsxdUTa49QQeBjkvMVXF
         VZgp76mr+ECt0RSDb3+hf5GdL8FQACyRF8KG7QmHKTa4wC8gp72Kw7f6FQSdzBWRmGi8
         Xw6w==
X-Gm-Message-State: AOAM5320d9MPlG99KktlTakM+4y3ttrknSopCz9T2ItboIEfpyl2HQ28
        IVDPs4l2IcYhwHTD1MwkZokeOQ==
X-Google-Smtp-Source: ABdhPJzcm6kE7NQZCOW9L9xzUGFvRn8tmUaI48ZbsK+VB9ct0DWTuMUMU2ZRLQNrm2Aj2yX3VTR6QA==
X-Received: by 2002:adf:fb43:: with SMTP id c3mr2731711wrs.360.1619081272055;
        Thu, 22 Apr 2021 01:47:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o62sm5253687wme.5.2021.04.22.01.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 01:47:51 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:47:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        melissa.srw@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH 3/3] drm: drm_connector.c: Use tabs for code indents
Message-ID: <YIE4HTjVGbBPaRQG@phenom.ffwll.local>
Mail-Followup-To: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, melissa.srw@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
 <0200474fbdb1149856308bccb8e467415f0b3d99.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0200474fbdb1149856308bccb8e467415f0b3d99.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 08:42:49PM +0100, Beatriz Martins de Carvalho wrote:
> Remove space and use tabs for indent the code to follow the
> Linux kernel coding conventions.
> Problem found by checkpatch
> 
> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>

Both of your patch sets applied to drm-misc-next for 5.14, thanks a lot.
-Daniel

> ---
>  drivers/gpu/drm/drm_connector.c | 38 ++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 7631f76e7f34..38600c3a6ab2 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1958,11 +1958,11 @@ int drm_connector_set_path_property(struct drm_connector *connector,
>  	int ret;
>  
>  	ret = drm_property_replace_global_blob(dev,
> -	                                       &connector->path_blob_ptr,
> -	                                       strlen(path) + 1,
> -	                                       path,
> -	                                       &connector->base,
> -	                                       dev->mode_config.path_property);
> +					       &connector->path_blob_ptr,
> +					       strlen(path) + 1,
> +					       path,
> +					       &connector->base,
> +					       dev->mode_config.path_property);
>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_connector_set_path_property);
> @@ -1988,11 +1988,11 @@ int drm_connector_set_tile_property(struct drm_connector *connector)
>  
>  	if (!connector->has_tile) {
>  		ret  = drm_property_replace_global_blob(dev,
> -		                                        &connector->tile_blob_ptr,
> -		                                        0,
> -		                                        NULL,
> -		                                        &connector->base,
> -		                                        dev->mode_config.tile_property);
> +							&connector->tile_blob_ptr,
> +							0,
> +							NULL,
> +							&connector->base,
> +							dev->mode_config.tile_property);
>  		return ret;
>  	}
>  
> @@ -2003,11 +2003,11 @@ int drm_connector_set_tile_property(struct drm_connector *connector)
>  		 connector->tile_h_size, connector->tile_v_size);
>  
>  	ret = drm_property_replace_global_blob(dev,
> -	                                       &connector->tile_blob_ptr,
> -	                                       strlen(tile) + 1,
> -	                                       tile,
> -	                                       &connector->base,
> -	                                       dev->mode_config.tile_property);
> +					       &connector->tile_blob_ptr,
> +					       strlen(tile) + 1,
> +					       tile,
> +					       &connector->base,
> +					       dev->mode_config.tile_property);
>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_connector_set_tile_property);
> @@ -2076,10 +2076,10 @@ int drm_connector_update_edid_property(struct drm_connector *connector,
>  
>  	ret = drm_property_replace_global_blob(dev,
>  					       &connector->edid_blob_ptr,
> -	                                       size,
> -	                                       edid,
> -	                                       &connector->base,
> -	                                       dev->mode_config.edid_property);
> +					       size,
> +					       edid,
> +					       &connector->base,
> +					       dev->mode_config.edid_property);
>  	if (ret)
>  		return ret;
>  	return drm_connector_set_tile_property(connector);
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
