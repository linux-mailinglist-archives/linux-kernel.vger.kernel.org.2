Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956B644E81D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhKLOJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:09:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:13791 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231718AbhKLOI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:08:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="293960316"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="293960316"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 06:05:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="504900797"
Received: from sbacanu-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.217.145])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 06:05:53 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v5 4/6] drm: Decouple nomodeset from CONFIG_VGA_CONSOLE
In-Reply-To: <20211112133230.1595307-5-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211112133230.1595307-1-javierm@redhat.com> <20211112133230.1595307-5-javierm@redhat.com>
Date:   Fri, 12 Nov 2021 16:05:50 +0200
Message-ID: <87zgq931vl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
> This relationship was only for historical reasons and the nomodeset option
> should be available even on platforms that don't enable CONFIG_VGA_CONSOLE.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/Kconfig  | 6 ++++++
>  drivers/gpu/drm/Makefile | 2 +-
>  include/drm/drm_drv.h    | 4 ----
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git drivers/gpu/drm/Kconfig drivers/gpu/drm/Kconfig
> index fb144617055b..483d534eb074 100644
> --- drivers/gpu/drm/Kconfig
> +++ drivers/gpu/drm/Kconfig
> @@ -8,6 +8,7 @@
>  menuconfig DRM
>  	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
>  	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
> +	select DRM_NOMODESET
>  	select DRM_PANEL_ORIENTATION_QUIRKS
>  	select HDMI
>  	select FB_CMDLINE
> @@ -493,6 +494,11 @@ config DRM_EXPORT_FOR_TESTS
>  config DRM_PANEL_ORIENTATION_QUIRKS
>  	tristate
>  
> +# Separate option because nomodeset parameter is global and expected built-in
> +config DRM_NOMODESET
> +	bool
> +	default n
> +
>  config DRM_LIB_RANDOM
>  	bool
>  	default n
> diff --git drivers/gpu/drm/Makefile drivers/gpu/drm/Makefile
> index c74810c285af..fa16d3e0bbdc 100644
> --- drivers/gpu/drm/Makefile
> +++ drivers/gpu/drm/Makefile
> @@ -33,7 +33,7 @@ drm-$(CONFIG_DRM_PRIVACY_SCREEN) += drm_privacy_screen.o drm_privacy_screen_x86.
>  
>  obj-$(CONFIG_DRM_DP_AUX_BUS) += drm_dp_aux_bus.o
>  
> -obj-$(CONFIG_VGA_CONSOLE) += drm_nomodeset.o
> +obj-$(CONFIG_DRM_NOMODESET) += drm_nomodeset.o
>  
>  drm_cma_helper-y := drm_gem_cma_helper.o
>  obj-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_cma_helper.o
> diff --git include/drm/drm_drv.h include/drm/drm_drv.h
> index 89e26a732175..da0c836fe8e1 100644
> --- include/drm/drm_drv.h
> +++ include/drm/drm_drv.h
> @@ -601,10 +601,6 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
>  
>  int drm_dev_set_unique(struct drm_device *dev, const char *name);
>  
> -#ifdef CONFIG_VGA_CONSOLE
>  extern bool drm_firmware_drivers_only(void);

I'm not bikeshedding this series anymore, but please follow up with a
patch removing the extern keyword. It's useless.

BR,
Jani.


> -#else
> -static inline bool drm_firmware_drivers_only(void) { return false; }
> -#endif
>  
>  #endif

-- 
Jani Nikula, Intel Open Source Graphics Center
