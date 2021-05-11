Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6AE37AE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhEKSU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:20:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:55786 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231551AbhEKSUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:20:23 -0400
IronPort-SDR: bur6ACEVKuYMfClqq0hrcRCUMkoX8/EsGeqbZwAq/GhAG7s6vA8J2tKrxJeTubuMr4hiWw/Iz0
 89sq1dgdmG8A==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="196417350"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="196417350"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:19:15 -0700
IronPort-SDR: iN+f4I11Q/hkuc8yNaysellLHlMpvGwmVCLubF8s0hsWp6D/va/93j/M+XpPocnyMwSgBXne1y
 UhUYa0yVAONA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="399484513"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga007.fm.intel.com with SMTP; 11 May 2021 11:19:09 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 11 May 2021 21:19:08 +0300
Date:   Tue, 11 May 2021 21:19:08 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Takashi Iwai <tiwai@suse.de>,
        Manasi Navare <manasi.d.navare@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Karthik B S <karthik.b.s@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/i915: Invoke another _DSM to enable MUX on HP
 Workstation laptops
Message-ID: <YJrKnHppE5FnaZ72@intel.com>
References: <20210426152420.359402-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210426152420.359402-1-kai.heng.feng@canonical.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:24:10PM +0800, Kai-Heng Feng wrote:
> On HP Fury G7 Workstations, graphics output is re-routed from Intel GFX
> to discrete GFX after S3. This is not desirable, because userspace will
> treat connected display as a new one, losing display settings.
> 
> The expected behavior is to let discrete GFX drives all external
> displays.
> 
> The platform in question uses ACPI method \_SB.PCI0.HGME to enable MUX.
> The method is inside the another _DSM, so add the _DSM and call it
> accordingly.
> 
> I also tested some MUX-less and iGPU only laptops with that _DSM, no
> regression was found.
> 
> v3:
>  - Remove BXT from names.
>  - Change the parameter type.
>  - Fold the function into intel_modeset_init_hw().
> 
> v2:
>  - Forward declare struct pci_dev.
> 
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3113
> References: https://lore.kernel.org/intel-gfx/1460040732-31417-4-git-send-email-animesh.manna@intel.com/
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/i915/display/intel_acpi.c    | 18 ++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_acpi.h    |  3 +++
>  drivers/gpu/drm/i915/display/intel_display.c |  2 ++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> index 833d0c1be4f1..d008d3976261 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> @@ -13,12 +13,17 @@
>  #include "intel_display_types.h"
>  
>  #define INTEL_DSM_REVISION_ID 1 /* For Calpella anyway... */
> +#define INTEL_DSM_FN_PLATFORM_MUX_ENABLE 0 /* No args */

This block of defines is for the other DSM. We don't want to
mix these up. We also want to name it according to the spec,
so something like GET_BIOS_DATA_FUNCS_SUPPORTED. Similarly
for the intel_dsm_enable_mux() wrapper function. + it needs
a comment to document that some BIOSes abuse it to do MUX
initialization and whatnot.

We should perhaps rename all the old DSM stuff to
something a bit less generic as well...

>  #define INTEL_DSM_FN_PLATFORM_MUX_INFO 1 /* No args */
>  
>  static const guid_t intel_dsm_guid =
>  	GUID_INIT(0x7ed873d3, 0xc2d0, 0x4e4f,
>  		  0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
>  
> +static const guid_t intel_dsm_guid2 =
> +	GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> +		  0x9d, 0x15, 0xc7, 0x1f, 0xba, 0xda, 0xe4, 0x14);
> +
>  static char *intel_dsm_port_name(u8 id)
>  {
>  	switch (id) {
> @@ -176,6 +181,19 @@ void intel_unregister_dsm_handler(void)
>  {
>  }
>  
> +void intel_dsm_enable_mux(struct drm_i915_private *i915)
> +{
> +	struct pci_dev *pdev = i915->drm.pdev;
> +	acpi_handle dhandle;
> +
> +	dhandle = ACPI_HANDLE(&pdev->dev);
> +	if (!dhandle)
> +		return;
> +
> +	acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> +			  INTEL_DSM_FN_PLATFORM_MUX_ENABLE, NULL);
> +}
> +
>  /*
>   * ACPI Specification, Revision 5.0, Appendix B.3.2 _DOD (Enumerate All Devices
>   * Attached to the Display Adapter).
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.h b/drivers/gpu/drm/i915/display/intel_acpi.h
> index e8b068661d22..def013cf6308 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.h
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.h
> @@ -11,11 +11,14 @@ struct drm_i915_private;
>  #ifdef CONFIG_ACPI
>  void intel_register_dsm_handler(void);
>  void intel_unregister_dsm_handler(void);
> +void intel_dsm_enable_mux(struct drm_i915_private *i915);
>  void intel_acpi_device_id_update(struct drm_i915_private *i915);
>  #else
>  static inline void intel_register_dsm_handler(void) { return; }
>  static inline void intel_unregister_dsm_handler(void) { return; }
>  static inline
> +void intel_dsm_enable_mux(struct drm_i915_private *i915) { return; }
> +static inline
>  void intel_acpi_device_id_update(struct drm_i915_private *i915) { return; }
>  #endif /* CONFIG_ACPI */
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index a10e26380ef3..d79dae370b20 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -11472,6 +11472,8 @@ void intel_modeset_init_hw(struct drm_i915_private *i915)
>  {
>  	struct intel_cdclk_state *cdclk_state;
>  
> +	intel_dsm_enable_mux(i915);
> +

This should probably be somewhere around where we do all the other
semi ACPI related init (OpRegion/etc.).

>  	if (!HAS_DISPLAY(i915))
>  		return;
>  
> -- 
> 2.30.2

-- 
Ville Syrjälä
Intel
