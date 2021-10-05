Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A3A42317A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhJEUTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhJEUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:19:02 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6433FC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:17:11 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r1so299837qta.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlaLhBwrKQHqRpficZi+S5MunK5Nu4oR4wDiTqmlmSA=;
        b=KLSOi67/N0aPhbIh7UtgCb+Jvk7gPIC/DiVmq56UAdpq47BIzFMU5A6N54ySFOpKNZ
         auZEEINrxbW1WkX1lqmkau0THaXOnd/oJTwTfszBWg9QokyIjeV1HNl3NQZHWMgeCtjb
         de6dT/5LzzCeIt+e/zohTI+ReOMCAvmbJnuGucC/Yf84lNaT8HAVte5Fgch05Lr6HxCq
         lz+mlHZlVVP5ao/1UcRajxyaAgRzCAb4acmqTvXFxC81Vx8bRbqjuJ4GLbd4DRrh/3GI
         SNLUHeH/t6OMi0bK0EK/PyYPFfmsEj4NsdIkqzoek6cpElwQSaggiEEbsE1/xGfzan99
         1Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlaLhBwrKQHqRpficZi+S5MunK5Nu4oR4wDiTqmlmSA=;
        b=OHcNbzq7QsoMp9okaAN/Ei/xbHRjjiWgX2OU2s4ZXRJNRAsqXSlxfRMJCSO6FIar4G
         J13/vljO8qsiQtqf655NcF+0xK3HI6MTNaaBCpJJoBdUOGPI+/C+FtALyAtjNxWiqeSc
         CniFWla3lTa4h+sHbwT17CSczjKcCpQw70iDCcQCB9CgFFcapBQP/zy7QCh/Vqda+cAN
         Hge2WwvNUrVFdZEfUFoP4hioD3QXuTTjKtYO93kH0sR8XIVjVx20BDM4JcCf2HhQG/zv
         NGvi60s06us+Iap8VJ4Lc7imb7gQvvzZADtlUp0iCVQDOTdaB8OCdhyLNliS7j6kXCEu
         cTEA==
X-Gm-Message-State: AOAM530iJ9LZg56BlUhptUHwteAsINKcRxt/NYXS0ldD3eR+ajNkenzo
        dF/qDV803gkv+zeJl2HCiHh/h29Rfi4QOA==
X-Google-Smtp-Source: ABdhPJwfBQvpkZaKoH7otomEjvO/noihg7/lMkBVjw3OrtzjuCIlknrAS2lVamCDfqo0H2SbU4DKCQ==
X-Received: by 2002:ac8:106:: with SMTP id e6mr21742037qtg.406.1633465030560;
        Tue, 05 Oct 2021 13:17:10 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:9b98::1007])
        by smtp.googlemail.com with ESMTPSA id j2sm13056905qta.84.2021.10.05.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:17:10 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        contact@emersion.fr, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH 0/6] Refactor the vkms to accept new formats
Date:   Tue,  5 Oct 2021 17:16:31 -0300
Message-Id: <20211005201637.58563-1-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary
=======
This series of patches refactor some vkms components in order to introduce
new formats to the planes and writeback connector.

Now in the blend function, the plane's pixels are converted to ARGB16161616
and then blended together.

The CRC is calculated based on the ARGB1616161616 buffer. And if required,
this buffer is copied/converted to the writeback buffer format.

And to handle the pixel conversion, new functions were added to convert
from a specific format to ARGB16161616 (the reciprocal is also true).

Tests
=====
This patch series was tested using the following igt tests:
-t ".*kms_plane.*"
-t ".*kms_writeback.*"
-t ".*kms_cursor_crc*"

New tests passing
-------------------
- pipe-A-cursor-size-change
- pipe-A-cursor-alpha-transparent

Tests and Performance Regressions
-------------------------------------
This pack of tests is failing:
- pipe-A-cursor-*-rapid-movement

This is expected since there are more operations per pixel than before.
And consequently, the compositing is way slower than before.

My micro-profiling shows these ranges to the completion of each
compositing in the .*kms_cursor_crc.* tests:

|      Frametime     |
|:-------:|:--------:|
|  before |   after  |
| 8~20 ms | 32~56 ms |

Hence, further optimizations will be required.

Writeback test
---------------
During the development of this patch series, I discovered that the
writeback-check-output test wasn't filling the plane correctly.

So, currently, this patch series is failing in this test. But I sent a
patch to igt to fix it[1].

XRGB to ARGB behavior
=================
During the development, I decided to always fill the alpha channel of
the output pixel whenever the conversion from a format without an alpha
channel to ARGB16161616 is necessary. Therefore, I ignore the value
received from the XRGB and overwrite the value with 0xFFFF.

My question is, is this behavior acceptable?

[1] https://lists.freedesktop.org/archives/igt-dev/2021-October/036125.html

Igor Matheus Andrade Torrente (6):
  drm: vkms: Replace the deprecated drm_mode_config_init
  drm: vkms: Alloc the compose frame using vzalloc
  drm: vkms: Replace hardcoded value of `vkms_composer.map` to
    DRM_FORMAT_MAX_PLANES
  drm: vkms: Add fb information to `vkms_writeback_job`
  drm: vkms: Prepare `vkms_wb_encoder_atomic_check` to accept multiple
    formats
  drm: vkms: Refactor the plane composer to accept new formats

 drivers/gpu/drm/vkms/vkms_composer.c  | 275 ++++++++++++++------------
 drivers/gpu/drm/vkms/vkms_drv.c       |   5 +-
 drivers/gpu/drm/vkms/vkms_drv.h       |  12 +-
 drivers/gpu/drm/vkms/vkms_formats.h   | 125 ++++++++++++
 drivers/gpu/drm/vkms/vkms_writeback.c |  27 ++-
 5 files changed, 304 insertions(+), 140 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_formats.h

-- 
2.30.2

