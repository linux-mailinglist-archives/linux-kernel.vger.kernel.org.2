Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE94447F59
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbhKHMSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:18:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239438AbhKHMSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636373763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dRa/l3qZgGwxylRM7oW/sBPMPgMJXegt0r8c50WFAdQ=;
        b=WTkZNBYTBvZlsdeEKk/ceWISAipuM1TdXt9TYJlPMNLLEgifI3e2Eke+B/cu+mcp9aQsA2
        450bbGqzDdd4QvPsx4EzciFjapKUwf/8c3SWyU95oLQuSRfM6XVcf3SGbu7cSV2ztS4c23
        8N6bSuXjSWnUpSPfa5R1Wd7T0Jrd8es=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-6y3OmvTwOb-7G-p65n9Plg-1; Mon, 08 Nov 2021 07:16:02 -0500
X-MC-Unique: 6y3OmvTwOb-7G-p65n9Plg-1
Received: by mail-wm1-f71.google.com with SMTP id a186-20020a1c7fc3000000b00332f1a308e7so10069557wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 04:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRa/l3qZgGwxylRM7oW/sBPMPgMJXegt0r8c50WFAdQ=;
        b=cOS6gHH6sK/23QtVDyI1vEGu/lDp/Ph4t8XSNODB5DJIntzAMhANpw3PlKHE3A2jMi
         IZCdvTD9pkLwVve/BUgFFBbPoIs7ZE14nKJPB8FRr0BM+6JD4fyOfUoaoEviUk7B4er7
         oooNnbMsiv6WRtt/RG6sfj5ttBHRjobCySiWCUPkqlsuNgrpPF6iNIvYRD19p0WZUxFT
         I3YSJDFhvOynIslTMIy1ZkOt7RUHBwKmD3SjmCw76SOKIPxEgXEEyH382lrJcMh+KLWR
         WX54HS2pXuqhnHjoI1+XCNXcvarIr30KQkdFu5+wBovYNN0Kr1J32HYGAVNFt/RH3wOm
         3MFg==
X-Gm-Message-State: AOAM532MQBHMeaf4ZYrdBeAPdLYliDIYzzPfQWpspdem4BVAwoYMCwtE
        fInKDUXfaBTyq/fC80EF/hhYid2kywhB/U0KKneI4U9sdY7UNF4im+psL+qCSwEhhYRqiaJpdHT
        fE3FU8ed8MzvZsapwvhuFM/nT2mBqeQHf3rp24bqa6C6PZfUhyL9TAX4xnLtRP/zmqahAA+EuDA
        8=
X-Received: by 2002:a7b:c04b:: with SMTP id u11mr51879252wmc.127.1636373761182;
        Mon, 08 Nov 2021 04:16:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPX4ITT3MIil14REYLQATye65t+SSWzbrpaBbeyG/34N3doWNLeQKLhqLWUn2g69sbZ2Zabw==
X-Received: by 2002:a7b:c04b:: with SMTP id u11mr51879189wmc.127.1636373760752;
        Mon, 08 Nov 2021 04:16:00 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q4sm16866866wrs.56.2021.11.08.04.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 04:16:00 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 0/6] Cleanups for the nomodeset kernel command line parameter logic
Date:   Mon,  8 Nov 2021 13:15:38 +0100
Message-Id: <20211108121544.776590-1-javierm@redhat.com>
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

This is a v3 of the patches, that address issues pointed out by Jani Nikula
in v2: https://lkml.org/lkml/2021/11/4/594

Patch #1 and #2 are just trivial cleanups.

Patch #3 moves the nomodeset boot option to the DRM subsystem and renames
the variables and functions names.

Patch #4 removes the relationship between the nomodeset parameter and the
CONFIG_VGA_CONSOLE Kconfig symbol.

Patch #5 adds nomodeset to the kernel parameters documentation.

Patch #6 improves the message when nomodeset is enabled to make it more
accurate and less sensational.

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

 .../admin-guide/kernel-parameters.txt         |  4 ++++
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
 19 files changed, 64 insertions(+), 60 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_nomodeset.c

-- 
2.33.1

