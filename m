Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11404480CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhKHOJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236375AbhKHOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636380425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L2nwJsDDJ6lnOHX9UyuWyUCF2Iwb8/6HJk9X/l7N+jI=;
        b=JXxrDvIj1rLS2jxJuYcbIdykikoMJm5IurOqqgvWSzNhC+Tv1hqXb4wKRAvAQwAoH8Alzn
        aGr41rjfhlSENrjBWcFYZpfJPaZi49uRnaPiy0I0X/nCNA9H8Yu6vzrZATo1Ea+0ttEPF2
        VTx64r+XoF0LNqBmQE4rkLTdITghWxo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Y_XCEEtIP8yr0TrvLW1KkQ-1; Mon, 08 Nov 2021 09:07:04 -0500
X-MC-Unique: Y_XCEEtIP8yr0TrvLW1KkQ-1
Received: by mail-wr1-f71.google.com with SMTP id d7-20020a5d6447000000b00186a113463dso4073510wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 06:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2nwJsDDJ6lnOHX9UyuWyUCF2Iwb8/6HJk9X/l7N+jI=;
        b=hJXDtumH2e5qel87IzMPRWYHiZ2kgnmninXIjGhXWpJffJmvWxhr4WOgqBNNA8c3EJ
         E/i34+efAFlxdHHXdZeZSF0dIA9QcLRmiBpDA6moRk+/WSt8kxU8pfLe9uJsmElJ/KbN
         P0ghOJQ1WT1CRtm4FpAu7cxhNJPsAkgoJ6apaXE8u5B0veN+eWG1RgNREOjk5kO63zip
         quOI/dFRiFGmv3cuU014Xn5jm2BSkaKfHkE3Hc9Bg8GOkM3I+tstcfha8wo3vMjs4Ppu
         MAjMz0jDXEuDTKPDZRy4YeFMvbV+mCSPGUcwiPdzQnylKEGw2+dbvO/dgcNTsG8+jKw+
         hSdw==
X-Gm-Message-State: AOAM532zvZWv8IwarOvAkksL49U4msTw2fq1/Hrl8kc0yYO8QRLbc5s9
        mXa1k4NBS1tLDOKnknaLzzBY95httd2mWAIYATfkcT5YpdzAfv2991FQ8XuM5aGASKEY80jYDzU
        QLpZR4MRKAYVwJzVuqkYPdwvUPyOwKbjG9Fi+R6uswgaD1nhA7Qpy31X8Z0G6q3qEW1pK7UXyp7
        A=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr77422wmg.20.1636380423257;
        Mon, 08 Nov 2021 06:07:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysZB04+wM5KwATDf4oOV/2QZXco8PwMF6dvaPzcuMeSSb3ONesmiTMz17upcy3TYsbmPuz5g==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr77373wmg.20.1636380422912;
        Mon, 08 Nov 2021 06:07:02 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id m14sm10081696wrp.28.2021.11.08.06.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 06:07:02 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 0/6] Cleanups for the nomodeset kernel command line parameter logic
Date:   Mon,  8 Nov 2021 15:06:42 +0100
Message-Id: <20211108140648.795268-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lot of historical baggage on this parameter. It is defined in
the vgacon driver as nomodeset, but its set function is called text_mode()
and the value queried with a function named vgacon_text_force().

All this implies that it's about forcing text mode for VGA, yet it is not
used in neither vgacon nor other console driver. The only users for these
are DRM drivers, that check for the vgacon_text_force() return value to
determine whether the driver should be loaded or not.

That makes it quite confusing to read the code, because the variables and
function names don't reflect what they actually do and also are not in the
same subsystem as the drivers that make use of them.

This patch-set attempts to cleanup the code by moving the nomodseset param
to the DRM subsystem and do some renaming to make their intention clearer.

This is a v4 of the patches, that address issues pointed out by Thomas
Zimmermann in v3: https://lkml.org/lkml/2021/11/8/384

Patch #1 and #2 are just trivial cleanups.

Patch #3 moves the nomodeset boot option to the DRM subsystem and renames
the variables and functions names.

Patch #4 removes the relationship between the nomodeset parameter and the
CONFIG_VGA_CONSOLE Kconfig symbol.

Patch #5 adds nomodeset to the kernel parameters documentation.

Patch #6 improves the message when nomodeset is enabled to make it more
accurate and less sensational.

Changes in v4:
- Don't mention the simpledrm driver and instead explain in high level
  terms what the nomodeset option is about.
- Don't mention DRM drivers in the kernel message and instead explain
  that only the system framebuffer will be available.

Changes in v3:
- Drop the drm_drv_enabled() function and just call to drm_get_modeset().
- Make drm_get_modeset() just a getter function and don't return an error.
- Move independent cleanups in drivers as separate preparatory patches.

Changes in v2:
- Conditionally build drm_nomodeset.o if CONFIG_VGA_CONSOLE is set.
- Squash patches to move nomodeset logic to DRM and do the renaming.
- Name the function drm_check_modeset() and make it return -ENODEV.
- Squash patch to add drm_drv_enabled() and make drivers use it.
- Make the drivers changes before moving nomodeset logic to DRM.
- Make drm_drv_enabled() return an errno and -ENODEV if nomodeset.
- Remove debug and error messages in drivers.

Javier Martinez Canillas (6):
  drm: Don't print messages if drivers are disabled due nomodeset
  drm/vboxvideo: Drop CONFIG_VGA_CONSOLE guard to call
    vgacon_text_force()
  drm: Move nomodeset kernel parameter to the DRM subsystem
  drm: Decouple nomodeset from CONFIG_VGA_CONSOLE
  Documentation/admin-guide: Document nomodeset kernel parameter
  drm: Make the nomodeset message less sensational

 .../admin-guide/kernel-parameters.txt         |  7 ++++++
 drivers/gpu/drm/Kconfig                       |  6 +++++
 drivers/gpu/drm/Makefile                      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  6 ++---
 drivers/gpu/drm/ast/ast_drv.c                 |  4 ++--
 drivers/gpu/drm/drm_nomodeset.c               | 24 +++++++++++++++++++
 drivers/gpu/drm/i915/i915_module.c            |  4 ++--
 drivers/gpu/drm/mgag200/mgag200_drv.c         |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  4 ++--
 drivers/gpu/drm/qxl/qxl_drv.c                 |  4 ++--
 drivers/gpu/drm/radeon/radeon_drv.c           | 10 +++-----
 drivers/gpu/drm/tiny/bochs.c                  |  4 ++--
 drivers/gpu/drm/tiny/cirrus.c                 |  5 ++--
 drivers/gpu/drm/vboxvideo/vbox_drv.c          |  6 ++---
 drivers/gpu/drm/virtio/virtgpu_drv.c          |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |  4 ++--
 drivers/video/console/vgacon.c                | 21 ----------------
 include/drm/drm_mode_config.h                 |  2 ++
 include/linux/console.h                       |  6 -----
 19 files changed, 67 insertions(+), 60 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_nomodeset.c

-- 
2.33.1

