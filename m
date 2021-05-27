Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590A5392A62
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbhE0JQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:16:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35286 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235589AbhE0JQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:16:37 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lmC6Y-0006zN-RK; Thu, 27 May 2021 11:15:02 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] drm/rockchip: remove existing generic drivers to take over the device
Date:   Thu, 27 May 2021 11:15:02 +0200
Message-ID: <4006303.q0ZmV6gNhb@diego>
In-Reply-To: <20210516074833.451643-1-javierm@redhat.com>
References: <20210516074833.451643-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 16. Mai 2021, 09:48:33 CEST schrieb Javier Martinez Canillas:
> There are drivers that register framebuffer devices very early in the boot
> process and make use of the existing framebuffer as setup by the firmware.
> 
> If one of those drivers has registered a fbdev, then the fallback fbdev of
> the DRM driver won't be bound to the framebuffer console. To avoid that,
> remove any existing generic driver and take over the graphics device.
> 
> By doing that, the fb mapped to the console is switched correctly from the
> early fbdev to the one registered by the rockchip DRM driver:
> 
>     [   40.752420] fb0: switching to rockchip-drm-fb from EFI VGA
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

fwiw, this looks like the right thing to do. I haven't found time to test
though yet. So anyway

Acked-by: Heiko Stuebner <heiko@sntech.de>


Heiko


> ---
> 
> Changes in v2:
> - Move drm_aperture_remove_framebuffers() call to .bind callback (tzimmermann).
> - Adapt subject line, commit message, etc accordingly.
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 212bd87c0c4..b730b8d5d94 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -16,6 +16,7 @@
>  #include <linux/console.h>
>  #include <linux/iommu.h>
>  
> +#include <drm/drm_aperture.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
> @@ -114,6 +115,15 @@ static int rockchip_drm_bind(struct device *dev)
>  	struct rockchip_drm_private *private;
>  	int ret;
>  
> +	/* Remove existing drivers that may own the framebuffer memory. */
> +	ret = drm_aperture_remove_framebuffers(false, "rockchip-drm-fb");
> +	if (ret) {
> +		DRM_DEV_ERROR(dev,
> +			      "Failed to remove existing framebuffers - %d.\n",
> +			      ret);
> +		return ret;
> +	}
> +
>  	drm_dev = drm_dev_alloc(&rockchip_drm_driver, dev);
>  	if (IS_ERR(drm_dev))
>  		return PTR_ERR(drm_dev);
> 




