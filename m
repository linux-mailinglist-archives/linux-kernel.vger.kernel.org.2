Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D18454233
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhKQIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:01:47 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:41261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhKQIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:01:47 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MSbt9-1nGAiH0NfV-00SypG for <linux-kernel@vger.kernel.org>; Wed, 17 Nov
 2021 08:58:48 +0100
Received: by mail-wm1-f49.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so1382222wmz.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:58:48 -0800 (PST)
X-Gm-Message-State: AOAM530t25fZEmNkI/H/YnIJw0T3W3NecUFtvgpOq/P53F+p+BEaBMx5
        BjL6Pl04fHfzXTCM2CGkR1uoLMuvvJgS1yU2iRM=
X-Google-Smtp-Source: ABdhPJxQ+x4Y1Ck1Hf5j/rHJ6qKfOAzp3wcdUpbV+b0x9HS0VH1nbg7XR0thXzSRbQKN9uAm9cLnpA/Gc9tUBUrm4hA=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr74998462wmi.173.1637135927739;
 Tue, 16 Nov 2021 23:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20211117062704.14671-1-rdunlap@infradead.org>
In-Reply-To: <20211117062704.14671-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Nov 2021 08:58:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1cayrsR9J+G6bAkZjK-hGaNzqSQAxB5LS4pvJm_rtpHQ@mail.gmail.com>
Message-ID: <CAK8P3a1cayrsR9J+G6bAkZjK-hGaNzqSQAxB5LS4pvJm_rtpHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: modify Kconfig to prevent build error
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ho0SuGXaCxBvyluHQ2ecZ6//rBgmJLatCGwjGgf+PasW8Q6YG1h
 OEZUUqN9sZmvB5O/x+W30ni/rfQXKD30zBlEmzh02FT+YVGL2DKekOdqD4baALMm/5Dxdb3
 5U3avLo1NAiSKZ/P0MYHZVHiesG5xpyF59g8tYlnSSTWq+1xuS+5/3Jo2M2y58gqFyMn3za
 Rpu8+VOCf6/0TwDe2gsmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7RskXWcKVns=:t+GdEGhGB8MQpUHeYGjwzw
 ES3IV/hce9Q0RTdY6Pi3TIgDbOMR35jGBjqZVb79J2yOdTshDOA/p7329C6IYyKh8u4gbU+ON
 kN6FEZeUIKtTyLhKUK6Elnfr6nVT+ARzrsQ94tNfsB19ku/rqpqC8YfJxyd/dRSGNLB5yM8RY
 Xv+UERbHH1KmYfJga6hkLDTLcwtCMMRoLbXoi4NPU2hbxTaJCFPnfjXn5snVk9ATuvxegx4/Q
 +WbFYaharQq5LaOuLnVCvejUc+9c8TxaNTqx2RJqNJssXR2TwvgLJx7UiVFxZnNVFuHs6XkQj
 m/nIRcNp1dTiNukoQanfEgr0GsvJO5Q5oiQBsaEKTGJwo/oL8hWQ2qPYOTxLo7OnJKe4s7H09
 iN96g1L5mzfG/WCkciWFMKJ66oi4fRKleudOu4U9H8WWzh9m7SQg8iTHW5xkLF1urdWUDjTIV
 l3SBEWhiXsOrCCLDFlJcgUuAL2hBDLLDzAiYF8eNV4jxYpp97bCu4TWqm8zRZkd5C5Qy5o+6x
 VLUwI7DJmMo5OpRwSgcnTgLeAxeuWHRQWI3HzVF/OOKp+u1rfeoqi71lwFmXeg9k887EH3d0y
 XDiOBBZnizItVW+1M/D09tojLKUKrdXB8IEib7yp9EZLaMTk6DPo9u5hqlWIyexecsenWIjtU
 kSqNNUkK6xYgqATPbF2NJ7gJiqbozcon6fQ4jfOYRz/KkoZIXt5CbbFC+1YzRqDtE7dMcIXRQ
 HtTHNZG25y20wH6DizjD5gY+wSYo6WzhSDCsfvMSzLIENS+ppnazgk4vpn9V+9Dlfix1gZD4V
 uhQPDkhhsiOLAEw5TlABklhipiJM3cT4eafjyh3+rQE/SjJrJI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 7:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> When CONFIG_DRM_KMS_HELPER=m and CONFIG_DRM_PANEL_EDP=y,
> there is a build error in gpu/drm/panel/panel-edp.o:
>
> arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-edp.o: in function `panel_edp_probe':
> panel-edp.c:(.text+0xf38): undefined reference to `drm_panel_dp_aux_backlight'
>
> Fix this by limiting DRM_PANEL_DEP by the value of the DRM_KMS_HELPER
> symbol.

I think the analysis is correct, but this is not the correct fix since
DRM_KMS_HELPER
is not user-selectable. (Almost) all other drivers that rely on DRM_KMS_HELPER
use 'select' for this, and mixing the two risks running into circular
dependencies.

I see that there are already some 'depends on DRM_KMS_HELPER' in bridge
and panel drivers, so it's possible that we have to fix them all at the same to
do this right. I ran into another problem like this the other day and
I'm currently
testing with the patch below, but I have not posted that yet since I am not
fully convinced that this is the correct fix either.

        Arnd
---
commit a836092fedaac66af03ea9ed7cb13214fd2ab8a2
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Nov 15 16:54:04 2021 +0100

    drm/mipi-dbi: select CONFIG_DRM_KMS_HELPER

    The driver fails to build when the KMS helpers are disabled:

    ld.lld: error: undefined symbol: drm_gem_fb_get_obj
    >>> referenced by drm_mipi_dbi.c
    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in
archive drivers/built-in.a
    >>> referenced by drm_mipi_dbi.c
    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_fb_dirty) in
archive drivers/built-in.a

    ld.lld: error: undefined symbol: drm_gem_fb_begin_cpu_access
    >>> referenced by drm_mipi_dbi.c
    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in
archive drivers/built-in.a

    ld.lld: error: undefined symbol: drm_fb_swab
    >>> referenced by drm_mipi_dbi.c
    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in
archive drivers/built-in.a

    ld.lld: error: undefined symbol: drm_fb_xrgb8888_to_rgb565
    >>> referenced by drm_mipi_dbi.c
    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in
archive drivers/built-in.a

    ld.lld: error: undefined symbol: drm_fb_memcpy
    >>> referenced by drm_mipi_dbi.c
    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in
archive drivers/built-in.a

    This is fairly hard to hit in randconfig drivers, but it eventually
    did trigger for me in a configuration where all other DRM drivers
    are loadable modules, but DRM_PANEL_WIDECHIPS_WS2401 was built-in.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 0039df26854b..a03c2761c5f9 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -29,6 +29,7 @@ menuconfig DRM

 config DRM_MIPI_DBI
        tristate
+       select DRM_KMS_HELPER
        depends on DRM

 config DRM_MIPI_DSI
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 431b6e12a81f..17a8d603e7d8 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -8,7 +8,6 @@ config DRM_BRIDGE
 config DRM_PANEL_BRIDGE
        def_bool y
        depends on DRM_BRIDGE
-       depends on DRM_KMS_HELPER
        select DRM_PANEL
        help
          DRM bridge wrapper of DRM panels
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index cfc8d644cedf..40ec20f3552d 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -140,9 +140,8 @@ config DRM_PANEL_ILITEK_IL9322
 config DRM_PANEL_ILITEK_ILI9341
        tristate "Ilitek ILI9341 240x320 QVGA panels"
        depends on OF && SPI
-       depends on DRM_KMS_HELPER
-       depends on DRM_KMS_CMA_HELPER
        depends on BACKLIGHT_CLASS_DEVICE
+       select DRM_KMS_CMA_HELPER
        select DRM_MIPI_DBI
        help
          Say Y here if you want to enable support for Ilitek IL9341
