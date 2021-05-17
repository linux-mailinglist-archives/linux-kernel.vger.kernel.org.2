Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27058382BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhEQMRL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 May 2021 08:17:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:11399 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234754AbhEQMRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:17:05 -0400
IronPort-SDR: A4TtZ6VucI87sMggHQJHXSgmWLICemkZQtcHUF2sa17PTXpmmPY/Zye/PVtujDChoJlxdBJBKC
 9fOQiiPL6SFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="187854159"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="187854159"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:15:45 -0700
IronPort-SDR: 7Ht9fR84yA4Rq8Y8w3Q2gXOI2V6j3777dycbyy09H98pxYDgPaGBbYFG66HJ8MS8XTvkcZkwbY
 lnxhCVCbYQ5Q==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="472382788"
Received: from sudhirk1-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.50.192])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:15:39 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ville =?utf-8?B?U3lyasOk?= =?utf-8?B?bMOk?= 
        <ville.syrjala@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Takashi Iwai <tiwai@suse.de>,
        Manasi Navare <manasi.d.navare@intel.com>,
        =?utf-8?Q?Jos=C3=A9?= Roberto de Souza <jose.souza@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Karthik B S <karthik.b.s@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list\:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/i915: Invoke another _DSM to enable MUX on HP Workstation laptops
In-Reply-To: <CAAd53p7kFD-PrdeONF8-c=JG5rtHXpz1sxTbPkwg8YY4ZcCYWg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210426152420.359402-1-kai.heng.feng@canonical.com> <YJrKnHppE5FnaZ72@intel.com> <CAAd53p7kFD-PrdeONF8-c=JG5rtHXpz1sxTbPkwg8YY4ZcCYWg@mail.gmail.com>
Date:   Mon, 17 May 2021 15:15:36 +0300
Message-ID: <87fsylh7yv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> On Wed, May 12, 2021 at 2:19 AM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
>>
>> On Mon, Apr 26, 2021 at 11:24:10PM +0800, Kai-Heng Feng wrote:
>> > On HP Fury G7 Workstations, graphics output is re-routed from Intel GFX
>> > to discrete GFX after S3. This is not desirable, because userspace will
>> > treat connected display as a new one, losing display settings.
>> >
>> > The expected behavior is to let discrete GFX drives all external
>> > displays.
>> >
>> > The platform in question uses ACPI method \_SB.PCI0.HGME to enable MUX.
>> > The method is inside the another _DSM, so add the _DSM and call it
>> > accordingly.
>> >
>> > I also tested some MUX-less and iGPU only laptops with that _DSM, no
>> > regression was found.
>> >
>> > v3:
>> >  - Remove BXT from names.
>> >  - Change the parameter type.
>> >  - Fold the function into intel_modeset_init_hw().
>> >
>> > v2:
>> >  - Forward declare struct pci_dev.
>> >
>> > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3113
>> > References: https://lore.kernel.org/intel-gfx/1460040732-31417-4-git-send-email-animesh.manna@intel.com/
>> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> > ---
>> >  drivers/gpu/drm/i915/display/intel_acpi.c    | 18 ++++++++++++++++++
>> >  drivers/gpu/drm/i915/display/intel_acpi.h    |  3 +++
>> >  drivers/gpu/drm/i915/display/intel_display.c |  2 ++
>> >  3 files changed, 23 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
>> > index 833d0c1be4f1..d008d3976261 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_acpi.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
>> > @@ -13,12 +13,17 @@
>> >  #include "intel_display_types.h"
>> >
>> >  #define INTEL_DSM_REVISION_ID 1 /* For Calpella anyway... */
>> > +#define INTEL_DSM_FN_PLATFORM_MUX_ENABLE 0 /* No args */
>>
>> This block of defines is for the other DSM. We don't want to
>> mix these up. We also want to name it according to the spec,
>> so something like GET_BIOS_DATA_FUNCS_SUPPORTED. Similarly
>> for the intel_dsm_enable_mux() wrapper function. + it needs
>> a comment to document that some BIOSes abuse it to do MUX
>> initialization and whatnot.
>
> Will do.
>
>
>>
>> We should perhaps rename all the old DSM stuff to
>> something a bit less generic as well...
>
> I can rename them as well. But what's the naming scheme you prefer?
>
>>
>> >  #define INTEL_DSM_FN_PLATFORM_MUX_INFO 1 /* No args */
>> >
>> >  static const guid_t intel_dsm_guid =
>> >       GUID_INIT(0x7ed873d3, 0xc2d0, 0x4e4f,
>> >                 0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
>> >
>> > +static const guid_t intel_dsm_guid2 =
>> > +     GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
>> > +               0x9d, 0x15, 0xc7, 0x1f, 0xba, 0xda, 0xe4, 0x14);
>> > +
>> >  static char *intel_dsm_port_name(u8 id)
>> >  {
>> >       switch (id) {
>> > @@ -176,6 +181,19 @@ void intel_unregister_dsm_handler(void)
>> >  {
>> >  }
>> >
>> > +void intel_dsm_enable_mux(struct drm_i915_private *i915)
>> > +{
>> > +     struct pci_dev *pdev = i915->drm.pdev;
>> > +     acpi_handle dhandle;
>> > +
>> > +     dhandle = ACPI_HANDLE(&pdev->dev);
>> > +     if (!dhandle)
>> > +             return;
>> > +
>> > +     acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
>> > +                       INTEL_DSM_FN_PLATFORM_MUX_ENABLE, NULL);
>> > +}
>> > +
>> >  /*
>> >   * ACPI Specification, Revision 5.0, Appendix B.3.2 _DOD (Enumerate All Devices
>> >   * Attached to the Display Adapter).
>> > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.h b/drivers/gpu/drm/i915/display/intel_acpi.h
>> > index e8b068661d22..def013cf6308 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_acpi.h
>> > +++ b/drivers/gpu/drm/i915/display/intel_acpi.h
>> > @@ -11,11 +11,14 @@ struct drm_i915_private;
>> >  #ifdef CONFIG_ACPI
>> >  void intel_register_dsm_handler(void);
>> >  void intel_unregister_dsm_handler(void);
>> > +void intel_dsm_enable_mux(struct drm_i915_private *i915);
>> >  void intel_acpi_device_id_update(struct drm_i915_private *i915);
>> >  #else
>> >  static inline void intel_register_dsm_handler(void) { return; }
>> >  static inline void intel_unregister_dsm_handler(void) { return; }
>> >  static inline
>> > +void intel_dsm_enable_mux(struct drm_i915_private *i915) { return; }
>> > +static inline
>> >  void intel_acpi_device_id_update(struct drm_i915_private *i915) { return; }
>> >  #endif /* CONFIG_ACPI */
>> >
>> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
>> > index a10e26380ef3..d79dae370b20 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_display.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
>> > @@ -11472,6 +11472,8 @@ void intel_modeset_init_hw(struct drm_i915_private *i915)
>> >  {
>> >       struct intel_cdclk_state *cdclk_state;
>> >
>> > +     intel_dsm_enable_mux(i915);
>> > +
>>
>> This should probably be somewhere around where we do all the other
>> semi ACPI related init (OpRegion/etc.).
>
> Hmm, but Jani prefers to put it inside intel_modeset_*() helpers. But
> I don't see any opregion related functions are being called by
> intel_modeset_*() helpers. Any suggestion?

I think I mainly wanted it in intel_display.c instead of at the driver
top level.

BR,
Jani.


>
> Kai-Heng
>
>>
>> >       if (!HAS_DISPLAY(i915))
>> >               return;
>> >
>> > --
>> > 2.30.2
>>
>> --
>> Ville Syrjälä
>> Intel

-- 
Jani Nikula, Intel Open Source Graphics Center
