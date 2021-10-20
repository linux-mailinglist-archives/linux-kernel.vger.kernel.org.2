Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF44B434B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhJTMmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTMmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:42:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB704C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:39:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso9918630wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfqEwxQ0oeVce6XN/FotGcdbRwWTkZxc+4NzjkrPbLY=;
        b=iLOOkhdfedcjdoYDlO1FDqiD2TfL5IoaiJJDviRSsHgdh2Z029yz03Ca3ocnHGjqlU
         31yNNCtO5Qz3I9r74gYFlgIKegt7gn0s85y3qgeTu+mozyKKVk9E2wlHSTJZkum4fyj+
         R3shv/VMI3B0eapO4GtZOEbyZJnTeqtUNbmJVp8qbU7bP0VMy6IsanpsMaDXO4avwF78
         WUc0THvvukidKtbe7S19w0G/9TnBiozXMVkBaD3X66OHUu70vYMlwZtQkQ8+mB94O5/7
         Y/8MusDe8aeO8Flw1Ef57eEHghtFIDVi1q/r5Yd70riUb7ZKfXLo2tZ4y5nWy6QPyAHs
         t7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfqEwxQ0oeVce6XN/FotGcdbRwWTkZxc+4NzjkrPbLY=;
        b=4YSAVJ9Uaxio4871Hf9Ga9mmIJz2K65TjaM4jaAoZQKSdTyG4ktwpqRprzKKgaC0+G
         KjqcNH8QTppNkn3yrn/FC4Xrkvt4vAdx8Ea7nvjYcX0f6tXHD1FKwh2644GZFe0lVcPZ
         +7BWppK4KOoZFBxtx0RTmFpP51tRn3m8290fIv+W71N3U2hiXzRqJm+dFS7baFTIf8GZ
         dBCLv6O+diIGSoUzgNBZn5XpAOo3bG6uBTeywUQTyN98YCnAEUzd9IZdI2OHdV38Bo3U
         hTtcJ7dsAl1kVdLjpgtBqAUxSg97KAo3lGmMB1F/Z8P9srMMJ4sT/5+rKGu61aONELM1
         NoQg==
X-Gm-Message-State: AOAM530DW2sDuQa6DvPfL5WBjMRrhyLG/qbp/tHg5ys+PqbS/8uHYJHY
        q6AbCQSQnXly1xluZDuxFM7+Vw==
X-Google-Smtp-Source: ABdhPJwl8Ts87hZRgxL1JkpipJUybRCLe/XlIvuoep4YqIHcPr/Gzp/nQxCIUNvKWJD2Q2HqcRVy1g==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr50717247wrc.209.1634733590344;
        Wed, 20 Oct 2021 05:39:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:d31f:1512:8915:e439])
        by smtp.gmail.com with ESMTPSA id b19sm5342680wmj.9.2021.10.20.05.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:39:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org
Cc:     martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 0/6] drm/meson: rework encoders to pass ATTACH_NO_CONNECTOR
Date:   Wed, 20 Oct 2021 14:39:41 +0200
Message-Id: <20211020123947.2585572-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; h=from:subject; bh=cWFwjmC/5GnLgzWGXoT3IdxliBahsmwbo6WyE42OGn4=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhcA31L8TQmWY5npZGtnPH7O5j5oqdb7wVGthRzvCV gB+2cfSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYXAN9QAKCRB33NvayMhJ0eQuD/ 4gGveSkz1ZuRkc55e/MBJloENZ5rwdQTwFyWoCJuxIEdrOHIsJ9vSng549esl2i95cLc9fwTX9T8Gh V8gDYqmJ2O+jdN/4tqEHNBfdXC5rKym0FNNW2gpUltewCoBqwVpl6vxVvUOGuT/Vtn/Sw+atD6ix4j lcgu9Pxr8lXtLGfVJNAoQ69Z0Dt2Sz3AzYc+EGEpOCFZ38iSlwCMNwvo7LhFeQ2t2Kqa7nHAEX0jy3 PMDUrb3d9OOFJhpYnqg3+9S8hBqp+wX7rkdCEXyJueHDUPPenv7DdhPPPp9EH11HQolhBn8O7cm1zP mZKeoI42V4nmK3hsjaq8Sj4ybNyZ2GjiYPJVnm0g6MhRMaj9BUN6Nh4IOQ76JqEVpYapWWRqY6EpVV YEzLNl/NP8ylijWW7Ocxsd2L5IG1xQ+KxKQV5HOGlZgheIfsksftZsU0Ggus81xn+jR1Uzs6/l+v6l 1/RC1jliV7ZzLdRb2ha2tBnwihSfLOve38RntsMmjXNzth6iCoBjBiYdJSDbEFF2foQ59wx5ZS5sPN BG7vEhlXnd/HDHcbuW9dOC3uQ2JgoIygsHG2i6JEFzpmF1Z7Gw+0xTKLySzJo1rbg/eRIjLZAhyePp fTMihTnnuRMgi1kPAIvaAymKLHL236RpPF6+2aybeXTpbdBkOxK563H+yMhQ==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie finnally reworks the drm/meson driver by extracting the encoders
in their own file and moves to bridge-only callbacks.

This permits passing the ATTACH_NO_CONNECTOR bridge attach flag and finally
use the CVBS & HDMI display-connector driver.

This will ease Martin Blumenstingl writing the HDMI transceiver driver for
the older Meson8/8b SoCs, and sets the proper architecture for the work in
progress MIPI-DSI support.

Finally, this serie will path the way to a removal of the device component
and use the drmm memory management.

Changes since v2 at [2]:
 - patch 1: no changes
 - patch 2: added martin's ack
 - patch 3: moved ->enable & ->disable to atomic, added sam's & martin's acks
 - patch 4: added martin's ack
 - patch 5: added martin's ack
 - patch 6: moved ->enable & ->disable to atomic, added martin's ack

Changes since v1 at [1];
 - patch 1: added sam's review tag, fixed include order, fixed doc wording
 - patch 2: added sam's ack tag, switched to dev_dbg()
 - patch 3: moved mode_set to atomic_enable, removed DRM_DEBUG, fixed include order
 - patch 4: added sam's ack tag & applied to drm-misc-next
 - patch 5 & 6: added sam's ack tag
 - patch 7: added sam's review tag, stopped saving connector, moved mode_set to atomic_enable,
 	added missing atomic state callbacks, fixed include order, switched to dev_dbg/dev_err

[1] https://lore.kernel.org/r/20211014152606.2289528-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20211015141107.2430800-1-narmstrong@baylibre.com

Neil Armstrong (6):
  drm/bridge: display-connector: implement bus fmts callbacks
  drm/meson: remove useless recursive components matching
  drm/meson: split out encoder from meson_dw_hdmi
  drm/meson: encoder_hdmi: switch to bridge
    DRM_BRIDGE_ATTACH_NO_CONNECTOR
  drm/meson: rename venc_cvbs to encoder_cvbs
  drm/meson: encoder_cvbs: switch to bridge with ATTACH_NO_CONNECTOR

 drivers/gpu/drm/bridge/display-connector.c    |  86 ++++
 drivers/gpu/drm/meson/Kconfig                 |   2 +
 drivers/gpu/drm/meson/Makefile                |   3 +-
 drivers/gpu/drm/meson/meson_drv.c             |  71 ++-
 drivers/gpu/drm/meson/meson_dw_hdmi.c         | 342 +-------------
 drivers/gpu/drm/meson/meson_encoder_cvbs.c    | 284 +++++++++++
 ...meson_venc_cvbs.h => meson_encoder_cvbs.h} |   2 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c    | 446 ++++++++++++++++++
 drivers/gpu/drm/meson/meson_encoder_hdmi.h    |  12 +
 drivers/gpu/drm/meson/meson_venc_cvbs.c       | 293 ------------
 10 files changed, 881 insertions(+), 660 deletions(-)
 create mode 100644 drivers/gpu/drm/meson/meson_encoder_cvbs.c
 rename drivers/gpu/drm/meson/{meson_venc_cvbs.h => meson_encoder_cvbs.h} (92%)
 create mode 100644 drivers/gpu/drm/meson/meson_encoder_hdmi.c
 create mode 100644 drivers/gpu/drm/meson/meson_encoder_hdmi.h
 delete mode 100644 drivers/gpu/drm/meson/meson_venc_cvbs.c


base-commit: f6632721cd6231e1bf28b5317dcc7543e43359f7
-- 
2.25.1

