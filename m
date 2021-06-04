Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC8D39BC61
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhFDP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:59:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51712 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDP7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:59:21 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lpCCT-0003gk-LB
        for linux-kernel@vger.kernel.org; Fri, 04 Jun 2021 15:57:33 +0000
Received: by mail-lf1-f69.google.com with SMTP id k10-20020a05651239cab02902cf19c03142so3878769lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGq4avvIVWegafatbNa6UBi514qHC/jm/FZxbji4fuY=;
        b=HqRu7ykbT9XkQbiSgoMwZv90k36U38vHvYVtl4ARMlvYv1yBalfvgEjaw+fmFnpGD+
         dauT/cmZRvS4m5dB8y97xKZLQhljAulDa8Ev67vZYbNa/g7mX4+Lret/pL0gP2YRjq4v
         ygKmXUZ+pA7VSRFQEJC8lj2T8NKjcxTTY4rjFvuAOQRBupCRzIftbLSfh7hq09R/15LG
         4+hArZ6dr3j5C1gSqv60T7u8dKmY2K/JsvZdhEXR3xDDn+oSiG0SQQd3mf1RlRBqxaOj
         maAy8vAdsx4ltq/ZOhKkvLJKmN0Et96Qq+UXvIhRAPYVTQ2M+RDyt1H49vJmyyx0EjFu
         lVaA==
X-Gm-Message-State: AOAM530EaXllxQr1EZTXtpyRerkIwCbkh1pa1teksJUgPYLYarrTmfFL
        4F72lZSEDc61JXmz8rv/8V75EGFt4jhZiofSGReI2SImPZQFFwFgBzbSYDbG3DPjFTtFl3numRp
        +Tv8yV55OabAgGK9+wAUUBKUQ+xluBc0q9jAEfvytRcPFGMx6R+uPgqDmfQ==
X-Received: by 2002:a05:6512:783:: with SMTP id x3mr3249720lfr.194.1622822253095;
        Fri, 04 Jun 2021 08:57:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf0pbNJN8s9JVcukdsXoJlzXZmyZwtjQMbAKvrUvXdWu38bAzXJdYOwhloCK39lZ2Fv1wTcmDi+ZQOT9keKpQ=
X-Received: by 2002:a05:6512:783:: with SMTP id x3mr3249703lfr.194.1622822252817;
 Fri, 04 Jun 2021 08:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210520065832.614245-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210520065832.614245-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 4 Jun 2021 23:57:20 +0800
Message-ID: <CAAd53p4mYybfBsSpd497jOTKwE+aiCvTD9OEvMtROkgjdRHp=g@mail.gmail.com>
Subject: Re: [PATCH v4] drm/i915: Invoke another _DSM to enable MUX on HP
 Workstation laptops
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Takashi Iwai <tiwai@suse.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 2:58 PM Kai-Heng Feng
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
> v4:
>  - Rebase.
>  - Change the DSM name to avoid confusion.
>  - Move the function call to intel_opregion.
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
>  drivers/gpu/drm/i915/display/intel_acpi.c     | 19 +++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_acpi.h     |  3 +++
>  drivers/gpu/drm/i915/display/intel_opregion.c |  3 +++
>  3 files changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> index 833d0c1be4f1..7cfe91fc05f2 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> @@ -19,6 +19,12 @@ static const guid_t intel_dsm_guid =
>         GUID_INIT(0x7ed873d3, 0xc2d0, 0x4e4f,
>                   0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
>
> +#define INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED 0 /* No args */
> +
> +static const guid_t intel_dsm_guid2 =
> +       GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> +                 0x9d, 0x15, 0xc7, 0x1f, 0xba, 0xda, 0xe4, 0x14);
> +
>  static char *intel_dsm_port_name(u8 id)
>  {
>         switch (id) {
> @@ -176,6 +182,19 @@ void intel_unregister_dsm_handler(void)
>  {
>  }
>
> +void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> +{
> +       struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> +       acpi_handle dhandle;
> +
> +       dhandle = ACPI_HANDLE(&pdev->dev);
> +       if (!dhandle)
> +               return;
> +
> +       acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> +                         INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
> +}
> +
>  /*
>   * ACPI Specification, Revision 5.0, Appendix B.3.2 _DOD (Enumerate All Devices
>   * Attached to the Display Adapter).
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.h b/drivers/gpu/drm/i915/display/intel_acpi.h
> index e8b068661d22..9f197401c313 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.h
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.h
> @@ -11,11 +11,14 @@ struct drm_i915_private;
>  #ifdef CONFIG_ACPI
>  void intel_register_dsm_handler(void);
>  void intel_unregister_dsm_handler(void);
> +void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915);
>  void intel_acpi_device_id_update(struct drm_i915_private *i915);
>  #else
>  static inline void intel_register_dsm_handler(void) { return; }
>  static inline void intel_unregister_dsm_handler(void) { return; }
>  static inline
> +void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915) { return; }
> +static inline
>  void intel_acpi_device_id_update(struct drm_i915_private *i915) { return; }
>  #endif /* CONFIG_ACPI */
>
> diff --git a/drivers/gpu/drm/i915/display/intel_opregion.c b/drivers/gpu/drm/i915/display/intel_opregion.c
> index dfd724e506b5..3855fba70980 100644
> --- a/drivers/gpu/drm/i915/display/intel_opregion.c
> +++ b/drivers/gpu/drm/i915/display/intel_opregion.c
> @@ -1078,6 +1078,9 @@ void intel_opregion_resume(struct drm_i915_private *i915)
>                 opregion->asle->ardy = ASLE_ARDY_READY;
>         }
>
> +       /* Some platforms abuse the _DSM to enable MUX */
> +       intel_dsm_get_bios_data_funcs_supported(i915);
> +
>         intel_opregion_notify_adapter(i915, PCI_D0);
>  }
>
> --
> 2.31.1
>
