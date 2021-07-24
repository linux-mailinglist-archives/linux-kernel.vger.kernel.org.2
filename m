Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5660B3D4836
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 16:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhGXORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 10:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGXORw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 10:17:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79D1B60E9C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627138704;
        bh=NbqjL70DokqVvV19hzj4hiRcYchamdVrDx6kJEYgsgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IqSXjpLTIn6PxzBXLoGz2wvI8STZMkUsHdjULHm/QAiDJCK+FFPSya+ZsEpV67SUs
         kgR1JNugBg+D2Qks7kJFatUrRasJVjUvGcik3Ul3RShflNDK0dr7wg8/jEltdYTZ9R
         ha3JphNjP26TV/QlbYJu9yCxHPcg6mrWnQlVQeJfq5rvpDave68y1YC8Z/nZbOBwe2
         sGCkJxS/4ayx4GTKbEXZIqu5+6/IFD6WYPTW0gPzq/++Gp73sGAXgc2HFa2MWc10rR
         O1BcDMmAHJQxOAhIKWEFDFMV27tSa/mrPNvB8yJbIvHNelvgaNBeFr3BVXMZnIaKUx
         /GqLkL2h2B3sA==
Received: by mail-wm1-f41.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so2425941wmq.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 07:58:24 -0700 (PDT)
X-Gm-Message-State: AOAM530zzikl8nXnLAYMkkckqVlAYOzu9gysQAzW1T9A2RRPUQQ2hW+z
        kOcsjc7IwZdKhSXY0SzqBxgw2/AQGYn+J04z5Sw=
X-Google-Smtp-Source: ABdhPJwltPl/wWX13/CxEFCAvNsrOMzwCqFUDp745ygruk3669M6BQP+fmfDf7Z3x+vjqYFjPYCieuVIF4EIc3uZU8w=
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr18758940wmh.120.1627138703148;
 Sat, 24 Jul 2021 07:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210723224617.3088886-1-kherbst@redhat.com> <CAK8P3a3u_jsxQW4dPXtsdKkw1mjKXL-h=qN1SGHytvUMPf3fPw@mail.gmail.com>
 <CACO55tuNWk6emjnnukgv9h-9jbpVP564Ogmi7TGbybc9n5v+ZQ@mail.gmail.com>
 <CAK8P3a1BceSaiqkTf+9Pr4Br-G3kgqD4ztwiaS7fxNiUg9t7Dg@mail.gmail.com>
 <CACO55tsoi2akTKvFdz3p48UHRjFXDW7dUnOM8qVePBFWet-3UQ@mail.gmail.com>
 <CACO55tuceMUz2pgOM23wvcmtaTqbo6S6rCB+mfLptqJRt=fMWA@mail.gmail.com>
 <CAK8P3a3+AD02-8nbULMdae2Hc=hJ+-Zb_CL+bHF-9oGieYiZWQ@mail.gmail.com> <CACO55tswMuDE9u3asU2Ls7BhA0uKGGarLk+E-WTD6MVnLwc3tw@mail.gmail.com>
In-Reply-To: <CACO55tswMuDE9u3asU2Ls7BhA0uKGGarLk+E-WTD6MVnLwc3tw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 24 Jul 2021 16:58:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0i0WP24Z0TScmPqKxmM2ovtKnmm+qZq6+Tc1ju+hma0w@mail.gmail.com>
Message-ID: <CAK8P3a0i0WP24Z0TScmPqKxmM2ovtKnmm+qZq6+Tc1ju+hma0w@mail.gmail.com>
Subject: Re: [PATCH] nouveau: make backlight support non optional
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 4:14 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> we use the MXM_WMI in code. We also have to keep arm in mind and not
> break stuff there. So I will try to play around with your changes and
> see how that goes.

Ok, should find any randconfig build failures for arm, arm64 or x86 over the
weekend. I also this on linux-next today

ld: drivers/gpu/drm/i915/display/intel_panel.o: in function
`intel_backlight_device_register':
intel_panel.c:(.text+0x2804): undefined reference to `backlight_device_register'
ld: intel_panel.c:(.text+0x284e): undefined reference to
`backlight_device_register'
ld: drivers/gpu/drm/i915/display/intel_panel.o: in function
`intel_backlight_device_unregister':
intel_panel.c:(.text+0x28b1): undefined reference to
`backlight_device_unregister'

and I added this same thing there to see how it goes:

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 87825d36335b..69c6b7aec49e 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -3,6 +3,8 @@ config DRM_I915
        tristate "Intel 8xx/9xx/G3x/G4x/HD Graphics"
        depends on DRM
        depends on X86 && PCI
+       depends on ACPI_VIDEO || !ACPI
+       depends on BACKLIGHT_CLASS_DEVICE
        select INTEL_GTT
        select INTERVAL_TREE
        # we need shmfs for the swappable backing store, and in particular
@@ -16,10 +18,6 @@ config DRM_I915
        select IRQ_WORK
        # i915 depends on ACPI_VIDEO when ACPI is enabled
        # but for select to work, need to select ACPI_VIDEO's dependencies, ick
-       select DRM_I915_BACKLIGHT if ACPI
-       select INPUT if ACPI
-       select ACPI_VIDEO if ACPI
-       select ACPI_BUTTON if ACPI
        select SYNC_FILE
        select IOSF_MBI
        select CRC32
@@ -64,13 +62,7 @@ config DRM_I915_FORCE_PROBE
          Use "*" to force probe the driver for all known devices.

 config DRM_I915_BACKLIGHT
-       tristate "Control backlight support"
-       depends on DRM_I915
-       default DRM_I915
-       select BACKLIGHT_CLASS_DEVICE
-       help
-          Say Y here if you want to control the backlight of your display
-          (e.g. a laptop panel).
+       def_tristate DRM_I915

 config DRM_I915_CAPTURE_ERROR
        bool "Enable capturing GPU state following a hang"
