Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A06C379DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhEKDeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:34:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36510 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKDea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:34:30 -0400
Received: from mail-lj1-f197.google.com ([209.85.208.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lgJ99-0006FH-Lb
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 03:33:23 +0000
Received: by mail-lj1-f197.google.com with SMTP id a23-20020a05651c2117b02900e9751e7410so5063337ljq.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ip8+k4Q+8oYoZf8LzKq65TnS2j8rrqsqavYRFDb50M4=;
        b=VE1xIlO0kVzrn9KYckI0IxHwAnEkfcTMwwblljNJi2CoO2z9qI7PVcI8+cbBZMEqXz
         Hv0JmO7VNkjUsEg5kUpXaS7oYW2J2iFGJ5+aj3XS/mtuNeD9WRmN4S49s/PgwtBzBttA
         R0AHbGBpUl9dZkRlgmWbsT6kKpcg/xgBO/+EJj2an6+MdESRQHR/OqDtP2iRzG7NOihi
         1qi5V1Y+rvQkTQx/D+g1fFPObLuSwaDyO22kTsu3vmczT+5iX9TBsadVfuGN0S+otxdv
         XRMF1Yc9BNcrhdtwChEV0zk39eyRCfERnzF9q3GK0Khown5oSBr2WrQsGG82kYmbAc1z
         R+0Q==
X-Gm-Message-State: AOAM5329b3ofv0M5WZ9QC9yQbfZ78SlCxzjf3sRd8Qai6iVaydGKjXHf
        zylDKNID2FEGD/uJIjzLeMov88m10IazvohdI8y714RX6QSpyA+5aUtN9XPgOlN1/O1vDJvIrkR
        qXo9mgvzytNAv9x5E3/4LfRaSccUljQjMLfPLDRy6WhOpDYTzdwcJTtZvqA==
X-Received: by 2002:a05:6512:3f8c:: with SMTP id x12mr18725336lfa.622.1620704002974;
        Mon, 10 May 2021 20:33:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEqfE/8NOyvDUHxwlkXYRjY0rz57HVuO6OnwojyPBP7+xcHUEkXqdEf4uDx5MJW2t2UDMEgCnyGFvlCRTu3WQ=
X-Received: by 2002:a05:6512:3f8c:: with SMTP id x12mr18725318lfa.622.1620704002705;
 Mon, 10 May 2021 20:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210426152420.359402-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210426152420.359402-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 11 May 2021 11:33:09 +0800
Message-ID: <CAAd53p4JgjAkHnBkGz20HM2uL8rCJUD6p0bZj+MLd7sbcq5=8A@mail.gmail.com>
Subject: Re: [PATCH v3] drm/i915: Invoke another _DSM to enable MUX on HP
 Workstation laptops
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Takashi Iwai <tiwai@suse.de>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:24 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
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

A gentle ping...

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
>  #define INTEL_DSM_FN_PLATFORM_MUX_INFO 1 /* No args */
>
>  static const guid_t intel_dsm_guid =
>         GUID_INIT(0x7ed873d3, 0xc2d0, 0x4e4f,
>                   0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
>
> +static const guid_t intel_dsm_guid2 =
> +       GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> +                 0x9d, 0x15, 0xc7, 0x1f, 0xba, 0xda, 0xe4, 0x14);
> +
>  static char *intel_dsm_port_name(u8 id)
>  {
>         switch (id) {
> @@ -176,6 +181,19 @@ void intel_unregister_dsm_handler(void)
>  {
>  }
>
> +void intel_dsm_enable_mux(struct drm_i915_private *i915)
> +{
> +       struct pci_dev *pdev = i915->drm.pdev;
> +       acpi_handle dhandle;
> +
> +       dhandle = ACPI_HANDLE(&pdev->dev);
> +       if (!dhandle)
> +               return;
> +
> +       acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> +                         INTEL_DSM_FN_PLATFORM_MUX_ENABLE, NULL);
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
>         struct intel_cdclk_state *cdclk_state;
>
> +       intel_dsm_enable_mux(i915);
> +
>         if (!HAS_DISPLAY(i915))
>                 return;
>
> --
> 2.30.2
>
