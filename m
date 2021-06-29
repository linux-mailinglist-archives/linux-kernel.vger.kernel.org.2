Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBE3B7603
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhF2P6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:58:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:7434 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233754AbhF2P6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:58:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208213869"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="208213869"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 08:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="489297301"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga001.jf.intel.com with SMTP; 29 Jun 2021 08:55:28 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 29 Jun 2021 18:55:27 +0300
Date:   Tue, 29 Jun 2021 18:55:27 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Manasi Navare <manasi.d.navare@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Imre Deak <imre.deak@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Karthik B S <karthik.b.s@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/i915/display: replace boilerplate code with
 helper macros
Message-ID: <YNtCbxjgIrwT1/gH@intel.com>
References: <20210626073230.41803-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210626073230.41803-1-someguy@effective-light.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 03:32:27AM -0400, Hamza Mahfooz wrote:
> As per commit 22be87401289 ("drm: TODO: Add DRM_MODESET_LOCK_ALL*
> conversion to todo.rst"),
> drm_modeset_lock_all()/drm_modeset_unlock_all() and boilerplate code
> surrounding instances of drm_modeset_lock_all_ctx() with a local acquire
> context should be replaced with the relevant helper macros.
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 64e9107d70f7..e8cb2881d2b4 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -40,6 +40,7 @@
>  #include <drm/drm_dp_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_fourcc.h>
> +#include "drm/drm_modeset_lock.h"
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_rect.h>
> @@ -11836,6 +11837,7 @@ int intel_modeset_init_nogem(struct drm_i915_private *i915)
>  	struct drm_device *dev = &i915->drm;
>  	enum pipe pipe;
>  	struct intel_crtc *crtc;
> +	struct drm_modeset_acquire_ctx ctx;
>  	int ret;
>  
>  	intel_init_pm(i915);
> @@ -11884,9 +11886,9 @@ int intel_modeset_init_nogem(struct drm_i915_private *i915)
>  	intel_vga_disable(i915);
>  	intel_setup_outputs(i915);
>  
> -	drm_modeset_lock_all(dev);
> +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>  	intel_modeset_setup_hw_state(dev, dev->mode_config.acquire_ctx);
> -	drm_modeset_unlock_all(dev);
> +	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);

That looks wrong. You're using a private ctx here, but still
passing dev->mode_config.acquire_ctx to the lower level stuff.

Also DRM_MODESET_LOCK_ALL_{BEGIN,END}() do not seem to be
equivalent to drm_modeset_{lock,unlock}_all() when it comes to 
mode_config.mutex. So would need a proper review whether we
actually need that lock or not.

-- 
Ville Syrjälä
Intel
