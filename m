Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948183F8466
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbhHZJUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbhHZJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:19:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E45EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:19:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so2195330wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMJBcmq1ZbF4M7qvQIwnmFbcPOdYmPNTJCyQyrP/K4I=;
        b=HYMxJKmJI6lkK9oRwabJkJvg4BmknVTOZc6kLrTHzRnJGXKHNy8FEqyc/pVEv7AI7v
         FzXm9+8wsENdDtneykOm5Kwv7Wkqek7pHpSFvoGSt9UThVfJDY/Xjr3I8M3VHEHX0PUo
         DoWF7H0mo9TXaFpvpSbb9W/3UlLv8RvHPMGyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=KMJBcmq1ZbF4M7qvQIwnmFbcPOdYmPNTJCyQyrP/K4I=;
        b=q2wOhXcgYJCrXBtRQuF/7D0aREktntehvrCqcfB5TMJYcmWQ4H33V9TdNVOGhJIqYD
         uPKB9Is9E4DAQd/nJQBRW5SSgtei44w/9aY6Cw252zaIpl3kVhIvuDJ2ahkXUsJAn9eH
         0aJhCkQlVEPFWz5R+M9p4n76i8xzyFw0XHtvVHDgzCkmKa71782yYNaF/UVdoEVAHQN1
         L+u4+8cgKJXwViv4+ujRW7IMHhDbk1g+L2oq19Rj9hlxBtpr3aoViW42PnlRzZRJBEg/
         oszTBo5JkOT3RMzJkQeh8RzkmXm0bdkHQ4jUfk8E8fY0sLjp6axXVRCvGYEZgmt9SvAG
         YlnA==
X-Gm-Message-State: AOAM530CJ0ON+DLf+bJuHeBquaIF/ciD7tdy/S26FNL/a7MUm4B+wMcv
        wUViChReJFv94CwMt0AViE/3yg==
X-Google-Smtp-Source: ABdhPJyRLhnVn7qZJ+4BuVfziyV2sSG5HJDNYqpREM4DjFqEBEWHewXDa8dbxtyIY5O9FmU4npDFrA==
X-Received: by 2002:a05:600c:4fc7:: with SMTP id o7mr12963274wmq.55.1629969538974;
        Thu, 26 Aug 2021 02:18:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u5sm2417412wrr.94.2021.08.26.02.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:18:58 -0700 (PDT)
Date:   Thu, 26 Aug 2021 11:18:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Emma Anholt <emma@anholt.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] drm: omap: remove obsolete selection of OMAP2_DSS
 in config DRM_OMAP
Message-ID: <YSdcgLcD2hOZks6l@phenom.ffwll.local>
Mail-Followup-To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Emma Anholt <emma@anholt.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210819112253.16484-1-lukas.bulwahn@gmail.com>
 <20210819112253.16484-6-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819112253.16484-6-lukas.bulwahn@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 01:22:53PM +0200, Lukas Bulwahn wrote:
> Commit 55b68fb856b5 ("drm/omap: squash omapdrm sub-modules into one")
> removes the config OMAP2_DSS in ./drivers/gpu/drm/omapdrm/dss/Kconfig,
> while moving the other configs into./drivers/gpu/drm/omapdrm/Kconfig, but
> misses to remove an obsolete selection of OMAP2_DSS in config DRM_OMAP.
> 
> Hence, ./scripts/checkkconfigsymbols.py warns:
> 
> OMAP2_DSS
> Referencing files: drivers/gpu/drm/omapdrm/Kconfig
> 
> Remove this reference in an obsolete selection.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Except the amdgpu patch all merged to drm-misc-next. amdgpu should get
picked up by Alex.
-Daniel

> ---
>  drivers/gpu/drm/omapdrm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/Kconfig b/drivers/gpu/drm/omapdrm/Kconfig
> index e7281da5bc6a..d6e4df291d6f 100644
> --- a/drivers/gpu/drm/omapdrm/Kconfig
> +++ b/drivers/gpu/drm/omapdrm/Kconfig
> @@ -3,7 +3,6 @@ config DRM_OMAP
>  	tristate "OMAP DRM"
>  	depends on DRM
>  	depends on ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM
> -	select OMAP2_DSS
>  	select DRM_KMS_HELPER
>  	select VIDEOMODE_HELPERS
>  	select HDMI
> -- 
> 2.26.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
