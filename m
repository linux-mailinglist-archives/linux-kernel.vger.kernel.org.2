Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F3F444025
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhKCKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhKCKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635936503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5nnQvoR88UMGCMcxDC9P8XE4qBHCB+Z6Z1Z1vfSe2kU=;
        b=IRumgA09Psu3czb4cGWa6gCazhuCvZQIBg/FiI/Kkt9r3G3mZyBbkeJZORmI5IJuHrN6bk
        QfeoLux544ACzScQHpIkQZUlTq4FQUPSAY0jjEIamDM/4UUhOGD+jaTyKTYu8ZEb62MHir
        ZI38QuM4Z6JzBXnx88t1fLGR7U5UKtU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-CvZTxaB4OXODC1_-tWYvDA-1; Wed, 03 Nov 2021 06:48:22 -0400
X-MC-Unique: CvZTxaB4OXODC1_-tWYvDA-1
Received: by mail-wm1-f72.google.com with SMTP id r6-20020a1c4406000000b0033119c22fdbso865295wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 03:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5nnQvoR88UMGCMcxDC9P8XE4qBHCB+Z6Z1Z1vfSe2kU=;
        b=DSjYX9xeks4mlL27yPllena8RelnTAjqnwqtRcuJWrX35nTmGZnXcMY7glvSRy2ZlN
         VjhbNLbjszLRvDGzBOJXgy9szkUOzMQbWiGl/1Weg1Z4q7up5lDpAA2BSSsUWpPehNCI
         SNRt79EKD2ubaBqjGSG5QmLSshB1c95vZRyltTo9VeSiEk4AQ3aJ94roJvCt//It7BDW
         Bo0a8BxbX6W+Iy/qfUB0wdTig0tIjg/Z85htWeOgleWlACXxYYQpPTw+tC6F/dxGp1+9
         Y9DbklgK0Gl3gFHhW8+ifIiXW0JLKlJxKFUYQ9b9MtJte4VCAdW5vyq1O0zw+8WBaUOy
         9b5g==
X-Gm-Message-State: AOAM532es/TfOhOmAfR1KBtzzsdXwyIdx33xNqU7RdzS0qOZmYv68A3r
        BcrCPcjLQdj+WxYfpBEyu6gomrTE9n5/qmOQA0prVlb7UfHlcRxhh6L4P4PgH0+li3hXnkuiPGC
        ssw7xnamgnyJU9zunUPCVpmKcRNYpp/0Pptqokg9AMNm3B4P2wsByJ0wJpTbieWBjB+DRUb2ghV
        E=
X-Received: by 2002:a1c:f319:: with SMTP id q25mr14279424wmq.33.1635936501447;
        Wed, 03 Nov 2021 03:48:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxGjLBuXZnXoaRjGFA6cORX0hlIDXBinZMAPHiZnnYmwPFjE80fWf+Prp8e/kvhCD9ChqhxQ==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr14279384wmq.33.1635936501111;
        Wed, 03 Nov 2021 03:48:21 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id f15sm1651555wmg.30.2021.11.03.03.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 03:48:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 0/5] Cleanups for the nomodeset kernel command line parameter logic
Date:   Wed,  3 Nov 2021 11:48:07 +0100
Message-Id: <20211103104812.1022936-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

