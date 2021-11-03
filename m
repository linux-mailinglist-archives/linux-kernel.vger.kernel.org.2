Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25F0444180
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhKCMbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231958AbhKCMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635942510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lDu7V2UPes5WjN4f5IhHpRndmxXdgV1k4QHUorLyZaY=;
        b=ZZhIslobLHOpg9b6NdUfFDY1eHBW3jOwt76dDiOTWhioT7f1IJ7WrqGKCoSXN1zv81Qf/f
        Sdxa83NPmBp8o+a9Bu0H3Y/LCK6pYr6VpUQyLmUCXiy9MpNh1a3VfJaVBkkOWfExvmWAYr
        6iai3YsBO3AXys1amcpBfA2gteJ8K6o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259--VgrHmpfMNyIRVjNv6J0kw-1; Wed, 03 Nov 2021 08:28:29 -0400
X-MC-Unique: -VgrHmpfMNyIRVjNv6J0kw-1
Received: by mail-wm1-f72.google.com with SMTP id o22-20020a1c7516000000b0030d6f9c7f5fso1005914wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 05:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lDu7V2UPes5WjN4f5IhHpRndmxXdgV1k4QHUorLyZaY=;
        b=PGYDo7D7WUkb3wbzGjmTAJeIHuL+eozKLtWQCC7AgeJQ9qh5fg/AZwLwL4bpPPe3iA
         N59yg38p2/jT0XAB4YMht6xacaFHeehPiY99ade4J/a0rP2QDdth0r6vXe1Oz4Cnt2W3
         vdo8C9csL7VbupKydP7B+olRAevuvRkFU0Rno55sBXcQuAEmH2aqC4723JaaOjERohfb
         lQoFzaCw6KgwP5ghPg5EG6Ko0pbRGdJttkIXzzp592SVJXdGJodXfXTPG9nUiq5osmEI
         zMElQtVDecKU223ZyyymbGMWfNNTaF4sg7zSoy+FPrVAllMxY28UUl4+nm04etGvEHOV
         ddXQ==
X-Gm-Message-State: AOAM5302Di2ev8U++bExnd3MxkOIf4wlKymUfAwWbI8kxDuVQwq0ZH81
        4WsZBim5tixYTE8kLM2E3W0eYR+/FnuqZJclYmR4m5EbVd1ZKjp6bUMNBFVL8kMnEzDXqpOEV8x
        TDXJvCgsjrI+2F0h8Wj5vMa6rsPw64SvPL7yUJh8jH3gYBfYu+HMt5XZnY3jxZEUgH1uUwhWQoK
        U=
X-Received: by 2002:adf:a78a:: with SMTP id j10mr56180987wrc.231.1635942507432;
        Wed, 03 Nov 2021 05:28:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoKFRYs4+FwUh+L5HYY422zuSq9cxsugE+p23YKU/J7QO0nbcMQx6cOjsOctL5eIXzrrPWjA==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr56180921wrc.231.1635942507148;
        Wed, 03 Nov 2021 05:28:27 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id w7sm1868400wru.51.2021.11.03.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 05:28:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [RESEND PATCH 0/5] Cleanups for the nomodeset kernel command line parameter logic
Date:   Wed,  3 Nov 2021 13:28:04 +0100
Message-Id: <20211103122809.1040754-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ resend with all relevant people as Cc now, sorry to others for the spam ]

There is a lot of historical baggage on this parameter. It's defined in
the vgacon driver as a "nomodeset" parameter, but it's handler function is
called text_mode() that sets a variable named vgacon_text_mode_force whose
value is queried with a function named vgacon_text_force().

All this implies that it's about forcing text mode for VGA, yet it is not
used in neither vgacon nor other console driver. The only users for these
are DRM drivers, that check for the vgacon_text_force() return value to
determine whether the driver could be loaded or not.

That makes it quite confusing to read the code, because the variables and
function names don't reflect what they actually do and also are not in the
same subsystem as the drivers that make use of them.

This patch-set attempts to cleanup the code by moving the nomodseset param
to the DRM subsystem and do some renaming to make their intention clearer.

There is also another aspect that could be improved, and is the fact that
drivers are checking for the nomodeset being set as an indication if have
to be loaded.

But there may be other reasons why this could be the case, so it is better
to encapsulate the logic in a separate function to make clear what's about.

Patch #1 is just a trivial fix for a comment that isn't referring to the
correct kernel parameter.

Patch #2 moves the nomodeset logic to the DRM subsystem.

Patch #3 renames the vgacon_text_force() function and accompaning logic as
drm_modeset_disabled(), which is what this function is really about.

Patch #4 adds a drm_drv_enabled() function that could be used by drivers
to check if could be enabled.

Patch #5 uses the drm_drv_enabled() function to check this instead of just
checking if nomodeset has been set.


Javier Martinez Canillas (5):
  drm/i915: Fix comment about modeset parameters
  drm: Move nomodeset kernel parameter handler to the DRM subsystem
  drm: Rename vgacon_text_force() function to drm_modeset_disabled()
  drm: Add a drm_drv_enabled() helper function
  drm: Use drm_drv_enabled() instead of drm_modeset_disabled()

 drivers/gpu/drm/Makefile                |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 ++---
 drivers/gpu/drm/ast/ast_drv.c           |  3 +--
 drivers/gpu/drm/drm_drv.c               | 21 ++++++++++++++++++++
 drivers/gpu/drm/drm_nomodeset.c         | 26 +++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_module.c      | 10 +++++-----
 drivers/gpu/drm/mgag200/mgag200_drv.c   |  3 +--
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  3 +--
 drivers/gpu/drm/qxl/qxl_drv.c           |  3 +--
 drivers/gpu/drm/radeon/radeon_drv.c     |  3 +--
 drivers/gpu/drm/tiny/bochs.c            |  3 +--
 drivers/gpu/drm/tiny/cirrus.c           |  3 +--
 drivers/gpu/drm/vboxvideo/vbox_drv.c    |  5 +----
 drivers/gpu/drm/virtio/virtgpu_drv.c    |  3 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  3 +--
 drivers/video/console/vgacon.c          | 21 --------------------
 include/drm/drm_drv.h                   |  1 +
 include/drm/drm_mode_config.h           |  6 ++++++
 include/linux/console.h                 |  6 ------
 19 files changed, 73 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_nomodeset.c

-- 
2.33.1

