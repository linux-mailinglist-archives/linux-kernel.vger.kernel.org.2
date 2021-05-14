Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2863D38065B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhENJkQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 May 2021 05:40:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36628 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhENJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:40:15 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lhUHf-0007Hi-FL
        for linux-kernel@vger.kernel.org; Fri, 14 May 2021 09:39:03 +0000
Received: by mail-lf1-f69.google.com with SMTP id z11-20020a19504b0000b02901dd6ba9b417so1794610lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 02:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BOeJR7+8V9SrfRJ7P6Px6DDdP07HsZ2AaHT/i8QQJDk=;
        b=ul/hz/NV/5XZgTx4nepVPXBhRQCxqqB/JFR7V5G6mVmuQmo6gHiWHY3x9o2RdECrM0
         PHFgOU9psQR9bkWbgkgGujN92h9ZqUJ4YTaUgCnux5rKSBl1XLOoODtjN7i7QKj4ukHn
         0Y1wBmb/V2/kwiaMzxO2ufF7xwDBSCoSfum/8UHFXHotE4n2K599qrDzVlrbh0fHBJBG
         W2sOAUEUJ2wmU80SLS5Fhv9H2pA6MiCXagz6z8FcRyJEa5HzCzYwQtwOdteENfvAAynL
         sBzRaHixpR0zol09dRV0nzxdgrPN2msVmNeeXmmUv5d2Kpq6/156j/6Rm6BH023SbI17
         wSkw==
X-Gm-Message-State: AOAM530etTm/5X7Jqfihny0GZd2XDENFgzm0jWKtlANvDnkX4YREOQVT
        RhZQ0jBL3+9ilNCghTBcgb5wJZmwZQymPau2RC9L+IOtr/bocUFTww7CO+Rm4/wvZN6dz+puaup
        /IpkQ10RB7YW/2q7gEBojqL5S7WHZgPd+GDrplPB/7QDVjdUwLfhAZvMzzw==
X-Received: by 2002:a2e:b531:: with SMTP id z17mr37029645ljm.126.1620985142833;
        Fri, 14 May 2021 02:39:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKHIuUDJuL9g4ZUwIgFtHu6cFFNFFSmfs/psYlO3CunDrkKG6ZwseHlgQ0qyUpzLJKZXyqO3GC7Wei/JHqA9E=
X-Received: by 2002:a2e:b531:: with SMTP id z17mr37029623ljm.126.1620985142551;
 Fri, 14 May 2021 02:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210426152420.359402-1-kai.heng.feng@canonical.com> <YJrKnHppE5FnaZ72@intel.com>
In-Reply-To: <YJrKnHppE5FnaZ72@intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 14 May 2021 17:38:51 +0800
Message-ID: <CAAd53p7kFD-PrdeONF8-c=JG5rtHXpz1sxTbPkwg8YY4ZcCYWg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/i915: Invoke another _DSM to enable MUX on HP
 Workstation laptops
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Takashi Iwai <tiwai@suse.de>,
        Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Karthik B S <karthik.b.s@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 2:19 AM Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
>
> On Mon, Apr 26, 2021 at 11:24:10PM +0800, Kai-Heng Feng wrote:
> > On HP Fury G7 Workstations, graphics output is re-routed from Intel GFX
> > to discrete GFX after S3. This is not desirable, because userspace will
> > treat connected display as a new one, losing display settings.
> >
> > The expected behavior is to let discrete GFX drives all external
> > displays.
> >
> > The platform in question uses ACPI method \_SB.PCI0.HGME to enable MUX.
> > The method is inside the another _DSM, so add the _DSM and call it
> > accordingly.
> >
> > I also tested some MUX-less and iGPU only laptops with that _DSM, no
> > regression was found.
> >
> > v3:
> >  - Remove BXT from names.
> >  - Change the parameter type.
> >  - Fold the function into intel_modeset_init_hw().
> >
> > v2:
> >  - Forward declare struct pci_dev.
> >
> > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3113
> > References: https://lore.kernel.org/intel-gfx/1460040732-31417-4-git-send-email-animesh.manna@intel.com/
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_acpi.c    | 18 ++++++++++++++++++
> >  drivers/gpu/drm/i915/display/intel_acpi.h    |  3 +++
> >  drivers/gpu/drm/i915/display/intel_display.c |  2 ++
> >  3 files changed, 23 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> > index 833d0c1be4f1..d008d3976261 100644
> > --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> > +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> > @@ -13,12 +13,17 @@
> >  #include "intel_display_types.h"
> >
> >  #define INTEL_DSM_REVISION_ID 1 /* For Calpella anyway... */
> > +#define INTEL_DSM_FN_PLATFORM_MUX_ENABLE 0 /* No args */
>
> This block of defines is for the other DSM. We don't want to
> mix these up. We also want to name it according to the spec,
> so something like GET_BIOS_DATA_FUNCS_SUPPORTED. Similarly
> for the intel_dsm_enable_mux() wrapper function. + it needs
> a comment to document that some BIOSes abuse it to do MUX
> initialization and whatnot.

Will do.


>
> We should perhaps rename all the old DSM stuff to
> something a bit less generic as well...

I can rename them as well. But what's the naming scheme you prefer?

>
> >  #define INTEL_DSM_FN_PLATFORM_MUX_INFO 1 /* No args */
> >
> >  static const guid_t intel_dsm_guid =
> >       GUID_INIT(0x7ed873d3, 0xc2d0, 0x4e4f,
> >                 0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
> >
> > +static const guid_t intel_dsm_guid2 =
> > +     GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> > +               0x9d, 0x15, 0xc7, 0x1f, 0xba, 0xda, 0xe4, 0x14);
> > +
> >  static char *intel_dsm_port_name(u8 id)
> >  {
> >       switch (id) {
> > @@ -176,6 +181,19 @@ void intel_unregister_dsm_handler(void)
> >  {
> >  }
> >
> > +void intel_dsm_enable_mux(struct drm_i915_private *i915)
> > +{
> > +     struct pci_dev *pdev = i915->drm.pdev;
> > +     acpi_handle dhandle;
> > +
> > +     dhandle = ACPI_HANDLE(&pdev->dev);
> > +     if (!dhandle)
> > +             return;
> > +
> > +     acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> > +                       INTEL_DSM_FN_PLATFORM_MUX_ENABLE, NULL);
> > +}
> > +
> >  /*
> >   * ACPI Specification, Revision 5.0, Appendix B.3.2 _DOD (Enumerate All Devices
> >   * Attached to the Display Adapter).
> > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.h b/drivers/gpu/drm/i915/display/intel_acpi.h
> > index e8b068661d22..def013cf6308 100644
> > --- a/drivers/gpu/drm/i915/display/intel_acpi.h
> > +++ b/drivers/gpu/drm/i915/display/intel_acpi.h
> > @@ -11,11 +11,14 @@ struct drm_i915_private;
> >  #ifdef CONFIG_ACPI
> >  void intel_register_dsm_handler(void);
> >  void intel_unregister_dsm_handler(void);
> > +void intel_dsm_enable_mux(struct drm_i915_private *i915);
> >  void intel_acpi_device_id_update(struct drm_i915_private *i915);
> >  #else
> >  static inline void intel_register_dsm_handler(void) { return; }
> >  static inline void intel_unregister_dsm_handler(void) { return; }
> >  static inline
> > +void intel_dsm_enable_mux(struct drm_i915_private *i915) { return; }
> > +static inline
> >  void intel_acpi_device_id_update(struct drm_i915_private *i915) { return; }
> >  #endif /* CONFIG_ACPI */
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> > index a10e26380ef3..d79dae370b20 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -11472,6 +11472,8 @@ void intel_modeset_init_hw(struct drm_i915_private *i915)
> >  {
> >       struct intel_cdclk_state *cdclk_state;
> >
> > +     intel_dsm_enable_mux(i915);
> > +
>
> This should probably be somewhere around where we do all the other
> semi ACPI related init (OpRegion/etc.).

Hmm, but Jani prefers to put it inside intel_modeset_*() helpers. But
I don't see any opregion related functions are being called by
intel_modeset_*() helpers. Any suggestion?

Kai-Heng

>
> >       if (!HAS_DISPLAY(i915))
> >               return;
> >
> > --
> > 2.30.2
>
> --
> Ville Syrjälä
> Intel
