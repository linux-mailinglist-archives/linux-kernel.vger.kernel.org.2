Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4687A44980E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbhKHPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbhKHPWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:22:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4932CC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 07:19:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d24so27540189wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 07:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBDq0sQlKFrrSYxj5AVhyU7t/OG7fPr3ZqBHcxsyosI=;
        b=Q6psTiLH794DsfuP91SljLhNGPIhXFPgSalvlmYpbMuSNYV0HFmbYR1qNHGL0l/jr9
         tyByf3SUvBm97dez78W1x+oSFCvIQk674FPaHvQh32lyo94wUYUttJvA0ie1rNfbw+41
         fhBx+bLyuR+vMjS2YSoXFxOMFXheEKiXTuU8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GBDq0sQlKFrrSYxj5AVhyU7t/OG7fPr3ZqBHcxsyosI=;
        b=XLjZMEGOA2d+C3r6I8WXbj1EuGd3HRK8rytjxN+2BWHEMo5Bii/hS6z6b08/w1FYlZ
         IsYZ1ImUsd4llDSGBvxAqQSK2DXlBB6CUdrP4cyezIKE8tfWFAAq/rpFPAHpo3mN3A/D
         lgbpU3B25NJyBiBieYW7BVVLldfio7fBYrdOs8DKuT7BMyO2cS4ClyohPe5000z6YcMy
         vmPNv/Fpevv3yWjkocx1hlEyACq96ymw8Xso0CQuoF1/mojsDr5hVHWl176WVMH90Pf5
         TFYhY94jZhsaKylGM+ZRgI0oWM6f6bPRJKPpj31tGXCsXRlyJrTuz0itW3cXzDRMW9xF
         wmwg==
X-Gm-Message-State: AOAM532tamycoPzPmKbMrf9sWAvUL60pEDau+aNmF1hnrK4lrIVmdbl6
        M4IwNeRGejbJ+eBeApvRDKLyoK9XcenlOtm8
X-Google-Smtp-Source: ABdhPJzpLm4EBrqPSncrAFfGe2yoefmn5H8Jb7dnyaUbsc+/2KKD43RWp8oIUO2Lpm7Vsm4Co/zTUQ==
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr546392wrv.331.1636384797916;
        Mon, 08 Nov 2021 07:19:57 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o4sm20359562wry.80.2021.11.08.07.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:19:57 -0800 (PST)
Date:   Mon, 8 Nov 2021 16:19:55 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, 15330273260@189.cn,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/drm_plane.h: fix a typo: not -> note
Message-ID: <YYlAGwVnVJewwKER@phenom.ffwll.local>
Mail-Followup-To: suijingfeng <suijingfeng@loongson.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, 15330273260@189.cn,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211108051625.47207-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108051625.47207-1-suijingfeng@loongson.cn>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 01:16:25PM +0800, suijingfeng wrote:
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>

Merged into drm-misc-next-fixes for 5.16 merge window.
-Daniel

> ---
>  include/drm/drm_plane.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index fed97e35626f..0c1102dc4d88 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -43,7 +43,7 @@ enum drm_scaling_filter {
>  /**
>   * struct drm_plane_state - mutable plane state
>   *
> - * Please not that the destination coordinates @crtc_x, @crtc_y, @crtc_h and
> + * Please note that the destination coordinates @crtc_x, @crtc_y, @crtc_h and
>   * @crtc_w and the source coordinates @src_x, @src_y, @src_h and @src_w are the
>   * raw coordinates provided by userspace. Drivers should use
>   * drm_atomic_helper_check_plane_state() and only use the derived rectangles in
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
