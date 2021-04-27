Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4934036C083
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhD0IEZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Apr 2021 04:04:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:20092 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhD0IEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:04:23 -0400
IronPort-SDR: lJd17ZRMJsra3lx6sxf2A1JNAPsLTSDudSB1FClwAuvBD25TIdWvzw9kwnxsNrfLGR0EzC4lvc
 RhroZG97asUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="194351965"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="194351965"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 01:03:40 -0700
IronPort-SDR: uLSXj0EdQtmdIW8C+zJUYeRb5TCTvPoVqeHWDsN4Sc0vwYGNFSJgVpsJw2m4Agpf5QiIWRG69j
 +BwbPNqlLoeg==
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="429720252"
Received: from aalbarra-mobl.ger.corp.intel.com (HELO localhost) ([10.249.41.45])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 01:03:36 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Damien Lespiau <damien.lespiau@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: i915: fix build when ACPI is disabled and BACKLIGHT=m
In-Reply-To: <20210426183516.18957-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210426183516.18957-1-rdunlap@infradead.org>
Date:   Tue, 27 Apr 2021 11:03:34 +0300
Message-ID: <874kfs5f3d.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021, Randy Dunlap <rdunlap@infradead.org> wrote:
> When CONFIG_DRM_I915=y, CONFIG_ACPI is not set, and
> CONFIG_BACKLIGHT_CLASS_DEVICE=m, not due to I915 config,
> there are build errors trying to reference backlight_device_{un}register().
>
> Changing the use of IS_ENABLED() to IS_REACHABLE() in intel_panel.[ch]
> fixes this.

I feel like a broken record...

CONFIG_DRM_I915=y and CONFIG_BACKLIGHT_CLASS_DEVICE=m is an invalid
configuration. The patch at hand just silently hides the problem,
leaving you without backlight.

i915 should *depend* on backlight, not select it. It would express the
dependency without chances for invalid configuration.

However, i915 alone can't depend on backlight, all users of backlight
should depend on backlight, not select it. Otherwise, you end up with
other configuration problems, circular dependencies and
whatnot. Everyone should change. See also (*) why select is not a good
idea here.

I've sent patches to this effect before, got rejected, and the same
thing gets repeated ad infinitum.

Accepting this patch would stop the inflow of these reports and similar
patches, but it does not fix the root cause. It just sweeps the problem
under the rug.


BR,
Jani.

(*) Documentation/kbuild/kconfig-language.rst:

	select should be used with care. select will force
	a symbol to a value without visiting the dependencies.
	By abusing select you are able to select a symbol FOO even
	if FOO depends on BAR that is not set.
	In general use select only for non-visible symbols
	(no prompts anywhere) and for symbols with no dependencies.
	That will limit the usefulness but on the other hand avoid
	the illegal configurations all over.


>
> ld: drivers/gpu/drm/i915/display/intel_panel.o: in function `intel_backlight_device_register':
> intel_panel.c:(.text+0x2ec1): undefined reference to `backlight_device_register'
> ld: drivers/gpu/drm/i915/display/intel_panel.o: in function `intel_backlight_device_unregister':
> intel_panel.c:(.text+0x2f93): undefined reference to `backlight_device_unregister'
>
> ld: drivers/gpu/drm/i915/display/intel_panel.o: in function `intel_backlight_device_register':
> intel_panel.c:(.text+0x2ec1): undefined reference to `backlight_device_register'
> ld: drivers/gpu/drm/i915/display/intel_panel.o: in function `intel_backlight_device_unregister':
> intel_panel.c:(.text+0x2f93): undefined reference to `backlight_device_unregister'
>
> Fixes: 912e8b12eedb ("drm/i915: register backlight device also when backlight class is a module")
> Fixes: 44c1220a441c ("drm/i915: extract intel_panel.h from intel_drv.h")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Damien Lespiau <damien.lespiau@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
> Found in linux-next but applies to mainline (5.12).
>
>  drivers/gpu/drm/i915/display/intel_panel.c |    2 +-
>  drivers/gpu/drm/i915/display/intel_panel.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20210426.orig/drivers/gpu/drm/i915/display/intel_panel.c
> +++ linux-next-20210426/drivers/gpu/drm/i915/display/intel_panel.c
> @@ -1254,7 +1254,7 @@ void intel_panel_enable_backlight(const
>  	mutex_unlock(&dev_priv->backlight_lock);
>  }
>  
> -#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>  static u32 intel_panel_get_backlight(struct intel_connector *connector)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
> --- linux-next-20210426.orig/drivers/gpu/drm/i915/display/intel_panel.h
> +++ linux-next-20210426/drivers/gpu/drm/i915/display/intel_panel.h
> @@ -54,7 +54,7 @@ u32 intel_panel_invert_pwm_level(struct
>  u32 intel_panel_backlight_level_to_pwm(struct intel_connector *connector, u32 level);
>  u32 intel_panel_backlight_level_from_pwm(struct intel_connector *connector, u32 val);
>  
> -#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>  int intel_backlight_device_register(struct intel_connector *connector);
>  void intel_backlight_device_unregister(struct intel_connector *connector);
>  #else /* CONFIG_BACKLIGHT_CLASS_DEVICE */

-- 
Jani Nikula, Intel Open Source Graphics Center
