Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6461644E762
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhKLNfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231553AbhKLNfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636723970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uBWkInz0f1J6G4VWIx0eG6QJ5CEmZf0S6yUp5qm/mCw=;
        b=HjplO5EVPWmVuWT5kuSDWoj05vrFR04oORuMvAKJWEB4IKT+PaSBYIyKet9gOH+3gp5w5F
        m+vijjUv5o0TKcs9fpJBDOmArWI5RuhLxVeX6jTXE0L5vSvJmTUMaaumpn/0IEIyWE+Dx8
        BZY0Np6FttCFV9cC0CfliHoHafbnfYI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-_dBD7HRwNdycdw-7nZZpKA-1; Fri, 12 Nov 2021 08:32:49 -0500
X-MC-Unique: _dBD7HRwNdycdw-7nZZpKA-1
Received: by mail-wm1-f72.google.com with SMTP id b145-20020a1c8097000000b003335872db8dso3655536wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uBWkInz0f1J6G4VWIx0eG6QJ5CEmZf0S6yUp5qm/mCw=;
        b=GzAPvHISV+QOMj4DDRDJpU7YMF/hY8yKCObF5u8v1sdBwfrs+lW7fj1QeDsvdr0aeM
         7yzqr9VCNc0EuI07UAVTbRzPThdmInIs+VjS5+OEOo/bzswrZmLxkGzWkSMfJ1ZrcdCx
         /Wk2ZwmDdYR3e2fUN1d0mCkAQTv2PSOTMRzPiE40h/iML4jF6Ir8ZZ3smX/dmW6/WirB
         iHS8qzhtoAZPY+yHZvWrQPQ1mhd5yBn5zSHmZGhggbUzmB1dTapuj9PVzBxwjy0dLIYe
         6FcqrRNPo+94lVmLI7uVhPlk/gXnqI/K4rw4Jluki4jiLwm2BiW9kYS3kBopBBCqv6Qp
         Sjhg==
X-Gm-Message-State: AOAM531XB6rWkjev953J1kQwDVgHoeapcO2tdc7VfbLzJzu6RQb0l1Vj
        1vVDdd6eO5Ukf2MMnsEIY4YI7sxklSQOqeATPdAoBpRSXhgkV46EA2cNaoQv6rJCQmITyQRlioc
        y+sImPWl3WszhrmQFXkF26EQd84fpbyqCXDU50S2+cTl+fX6OnGX0g7wCD+fQvE/Tu0xlw0yvS1
        0=
X-Received: by 2002:a5d:6151:: with SMTP id y17mr18894069wrt.275.1636723967806;
        Fri, 12 Nov 2021 05:32:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweFQRkr0PyXjrBf8oym4Y4OL7IMWD4cJ/wYupxgVKu0oGzEp1nKDEvel2QElYeV46gqHNjEA==
X-Received: by 2002:a5d:6151:: with SMTP id y17mr18894012wrt.275.1636723967473;
        Fri, 12 Nov 2021 05:32:47 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z12sm5733470wrv.78.2021.11.12.05.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:32:47 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v5 0/6] Cleanups for the nomodeset kernel command line parameter logic
Date:   Fri, 12 Nov 2021 14:32:24 +0100
Message-Id: <20211112133230.1595307-1-javierm@redhat.com>
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

This is a v5 of the patches, that just renames the function used by drivers
to check to drm_firmware_drivers_only(). Other than that is the same as v4.

Patch #1 and #2 are just trivial cleanups.

Patch #3 moves the nomodeset boot option to the DRM subsystem and renames
the variables and functions names.

Patch #4 removes the relationship between the nomodeset parameter and the
CONFIG_VGA_CONSOLE Kconfig symbol.

Patch #5 adds nomodeset to the kernel parameters documentation.

Patch #6 improves the message when nomodeset is enabled to make it more
accurate and less sensational.

Changes in v5:
- Rename drm_get_modeset() to drm_firmware_drivers_only().

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 +---
 drivers/gpu/drm/ast/ast_drv.c                 |  3 +--
 drivers/gpu/drm/drm_nomodeset.c               | 24 +++++++++++++++++++
 drivers/gpu/drm/i915/i915_module.c            |  4 ++--
 drivers/gpu/drm/mgag200/mgag200_drv.c         |  3 +--
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  4 ++--
 drivers/gpu/drm/qxl/qxl_drv.c                 |  3 +--
 drivers/gpu/drm/radeon/radeon_drv.c           |  9 ++-----
 drivers/gpu/drm/tiny/bochs.c                  |  3 +--
 drivers/gpu/drm/tiny/cirrus.c                 |  4 ++--
 drivers/gpu/drm/vboxvideo/vbox_drv.c          |  5 +---
 drivers/gpu/drm/virtio/virtgpu_drv.c          |  3 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |  3 +--
 drivers/video/console/vgacon.c                | 21 ----------------
 include/drm/drm_drv.h                         |  1 +
 include/linux/console.h                       |  6 -----
 19 files changed, 56 insertions(+), 60 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_nomodeset.c

-- 
2.33.1

