Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AADA3F03C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhHRMe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhHRMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:34:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD591C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 05:33:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u15so1540128wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/kPkZnxCseyNGFYqNVSGcQsVjtVBqcnkc+52Vw1oueY=;
        b=ei1LAdw3Yo9TtmY7ACcZl7HtyCXVHnxV90OCrfV9+MCQa55nqDukstwBZHdMvn4p6K
         MJjq8LEuiuP/E7p5GwIbln2ShfaFJXz7l4S1V702Hm5QTHpz54omjPKiWyqBI0DfrZR+
         BfQ5laKun9WzFn3RPvWhseDZV3bGHSkTln0iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/kPkZnxCseyNGFYqNVSGcQsVjtVBqcnkc+52Vw1oueY=;
        b=qOVhq3bJKUrTqXwMS4Y0cHm3a4jSreESbp8MXbnt09n9+ORmAG5frM/dsf0+8Zd/7d
         Hj1Ia0zbDWyzNNFa1ALs3Yi8f4BVs5Q6V6vdP5V4oHEaP8HLOr98ZZEqsrHvw0XiXrP3
         rN3LiiGM8ZP4yQm9r06da8z36x2iHMXySzE1y0tD631Hc1UdGTFwa5hsMXCRShKFqTpZ
         kkxrzgslLw3UxPB3frfT3mYlJMBp7poJbeeDoiLIdQ+nIyh5YwLwwzd/UrZ9RptdPyEh
         eODsbRVtg0h6IY+Pd3DFpiYiPMS2Eg7DgOTwXZ4My36FPPs4Gh/nV5ANtYGa42ZyvrdG
         tHOg==
X-Gm-Message-State: AOAM531L4+jOlbiXqL2hmtby3gBX1+dTMVSK2ERfzVnJ/cCmtQC4pTSy
        xhM+K0kfJhZac1mnxs36Xi1DcQ==
X-Google-Smtp-Source: ABdhPJy73y4hlWKTsw/rmU3KmuCCnMP+U4B1NZoZBVvFGViLGR2WxoUx2a20UmoD7AtWAFRCZ1xCJw==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr5229827wml.143.1629290023492;
        Wed, 18 Aug 2021 05:33:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h6sm5604992wmq.5.2021.08.18.05.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:33:42 -0700 (PDT)
Date:   Wed, 18 Aug 2021 14:33:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Remove unused code to load the non-existing fbcon.ko
Message-ID: <YRz+JZQqvBRm+L1A@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20210818120948.451896-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818120948.451896-1-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 02:09:48PM +0200, Javier Martinez Canillas wrote:
> Commit 6104c37094e7 ("fbcon: Make fbcon a built-time depency for fbdev")
> changed the FRAMEBUFFER_CONSOLE Kconfig symbol from tristate to bool.
> 
> But the drm_kms_helper_init() function still attempts to load the fbcon
> module, even when this is always built-in since the mentioned change.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Nice catch. Merged to drm-misc-next for 5.16, thanks.
-Daniel

> ---
> 
>  drivers/gpu/drm/drm_kms_helper_common.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
> index f933da1656eb..47e92400548d 100644
> --- a/drivers/gpu/drm/drm_kms_helper_common.c
> +++ b/drivers/gpu/drm/drm_kms_helper_common.c
> @@ -64,17 +64,6 @@ MODULE_PARM_DESC(edid_firmware,
>  
>  static int __init drm_kms_helper_init(void)
>  {
> -	/*
> -	 * The Kconfig DRM_KMS_HELPER selects FRAMEBUFFER_CONSOLE (if !EXPERT)
> -	 * but the module doesn't depend on any fb console symbols.  At least
> -	 * attempt to load fbcon to avoid leaving the system without a usable
> -	 * console.
> -	 */
> -	if (IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION) &&
> -	    IS_MODULE(CONFIG_FRAMEBUFFER_CONSOLE) &&
> -	    !IS_ENABLED(CONFIG_EXPERT))
> -		request_module_nowait("fbcon");
> -
>  	return drm_dp_aux_dev_init();
>  }
>  
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
