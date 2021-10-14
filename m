Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82BB42DE13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhJNP2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhJNP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:28:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF42CC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:26:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o20so20753324wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vtNHoIxmbj/7YDvxGdvf8UnRLBtAOJ59R6fKnUV3dK4=;
        b=cZBtYzDwo24ybcZenK01f8LACa8nU2oln55UYRWGSq9wlUcuoTIWMvyZl23g70lWpA
         KlhT9ebBQNQtD5LSvFa4Rl7D8AE2R0NTicOI6EEs7DxApezBOWljjZnk+XS+csiY90Ng
         oPAi2Rr0eujFY9rmIykOgxXOFD+zlt94KCz4cq258jfzKXwGlmlXgKzD6wMPjlYnSk9k
         5a8MmDQ2mfQB1an9Kw9wCu2u6BtJv8uQdAFSRty9fvltXMkQ55Y4DFeD9xBGvaIx2pg+
         m/PwnuRpYWpjJ/7QH0zSVxsvD856qvTGeGE+qT6gP/+Rl46FG9SJXkYetCIAR65jQJL9
         dWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vtNHoIxmbj/7YDvxGdvf8UnRLBtAOJ59R6fKnUV3dK4=;
        b=m8aD5+kayR26UKy/e5m6z/Bw76fdRBtIsM0/UDXvylfrB2+speM4+xe3nNsY7aaJ5m
         gDRKTv5zIb2y3dS4YRXMPczTLOK67StrJ/zcB4wmAJSkVz38vg8AlT5qVHHnsMfPqV9g
         SS9Byw6HDsc2/v+6XAsW9o7cP1JZV/6s4bkgUreQa8LPR0/hBd65gbFq5ieG+FbDCHft
         2N2ffnqcqlehmxC+0Gp2U7pbMVef+eRUcQEsh4VFCi9u+kX3Ha2P9S8ClxPxa47uTcrQ
         qbVgwaK0aRhZLeX49E0aDxWfUQB9n4jqi8jAlc0nD6esDhz38b7V1N2JCc9lDKPDEXCy
         iJHg==
X-Gm-Message-State: AOAM532gT8sMdQVQoSy/bzVbZz4pd6VvPiS15rie6sZigTDxaO7Zm9Yu
        nWE620NXYcpA7ikYGpnDy5+Wng==
X-Google-Smtp-Source: ABdhPJzASIqrQfvo9ajIKTAsQPp5MeFQvU/qWqa+T2hNix34pWnoqdCT/ncVqQAQdsslTsBRf5+9bA==
X-Received: by 2002:adf:cf04:: with SMTP id o4mr7498455wrj.129.1634225172185;
        Thu, 14 Oct 2021 08:26:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:209b:8400:2b80:b4ae])
        by smtp.gmail.com with ESMTPSA id k22sm2626790wrd.59.2021.10.14.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:26:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com
Cc:     martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/7] drm/meson: rework encoders to pass ATTACH_NO_CONNECTOR
Date:   Thu, 14 Oct 2021 17:25:59 +0200
Message-Id: <20211014152606.2289528-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039; h=from:subject; bh=tqvgfg0RoYJxjcu7H6VRSRZ/iXD37Rql9lvX/6yu3P8=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhaEt9Cw6cshz+RwHFIN4X1WnWFtkszZAXlrQ6ZyBc t/zKeJCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYWhLfQAKCRB33NvayMhJ0V2dD/ oDU2tsprYEbhRvVhpew7mxpO3qSBGSoHOjBRNRiDV0OnJEaEp0k8VpO5a2t3xgJsBUAm7f3Rsut35C KEROqGXo6M4IjHUIj0QkWjPPMwn9kBQsNSrK8+M6wxYn3r/CI8UX86MGJKXFpcoJurLM25Mu/knaH2 y4sNuvDHvFIt39BoQQEe9OYJIZLmFCCrb3dTtmWCgG9r8BQqPGZ6Dcu61Cw8jjq200lW2Ws3E1rVfC fJyVpzfwP18G7W3TI1SXsX6b8/RA22S7LHemc7JG8j32M4AgQVU9vKeK8CcLlhR1YutSAnCbtXAdIv 0HWkPRTcqlISimSZrmwMe48UPR+I0XYXL1pbFQYvMqSdFdU8cW3qQaVtkqqpppQAeQdYvAUPF2aOZN UyyjkZiYBQebgUHmgbHAeTA5bm23NDw4W5mJg3PPIeQFEF6mggT0FQoKrd9U1MqSgm/uwH9f47JSVD KF+Sb77Tw0rbiN6bB1ezWGifD26Lrcv63Aafv4+7dw2yX/i7DQqciuLG+OcVabb5h4sDitdL6J4886 um+3245e9KJ8W+zWlrHPCV5mYGzpjeiZAlY2koI7LJeq8Xp6EVWsrtrMFmgnS8meglyULA+A2oZxPT VmpqGrlqi7TQVXDrvDm8O7zFtHndr06E6h79MPllyXf6Y9I2vgnjO+Garlaw==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie finnally reworks the drm/meson driver by extracting the encoders
in their own file and moves to bridge-only callbacks.

This permits passing the ATTACH_NO_CONNECTOR bridge attach flag and finally
use the CVBS & HDMI display-connector driver.

This will ease Martin Blumenstingl writting the HDMI transceiver driver for
the older Meson8/8b SoCs, and sets the proper architecture for the work in
progress MIPI-DSI support.

Finally, this serie will path the way to a removal of the device component
and use the drmm memory management.

Neil Armstrong (7):
  drm/bridge: display-connector: implement bus fmts callbacks
  drm/meson: remove useless recursive components matching
  drm/meson: split out encoder from meson_dw_hdmi
  drm/bridge: synopsys: dw-hdmi: also allow interlace on bridge
  drm/meson: encoder_hdmi: switch to bridge
    DRM_BRIDGE_ATTACH_NO_CONNECTOR
  drm/meson: rename venc_cvbs to encoder_cvbs
  drm/meson: encoder_cvbs: switch to bridge with ATTACH_NO_CONNECTOR

 drivers/gpu/drm/bridge/display-connector.c    |  88 ++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |   1 +
 drivers/gpu/drm/meson/Kconfig                 |   2 +
 drivers/gpu/drm/meson/Makefile                |   3 +-
 drivers/gpu/drm/meson/meson_drv.c             |  71 ++-
 drivers/gpu/drm/meson/meson_dw_hdmi.c         | 342 +-------------
 ...meson_venc_cvbs.c => meson_encoder_cvbs.c} | 198 ++++----
 ...meson_venc_cvbs.h => meson_encoder_cvbs.h} |   2 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c    | 436 ++++++++++++++++++
 drivers/gpu/drm/meson/meson_encoder_hdmi.h    |  12 +
 10 files changed, 679 insertions(+), 476 deletions(-)
 rename drivers/gpu/drm/meson/{meson_venc_cvbs.c => meson_encoder_cvbs.c} (51%)
 rename drivers/gpu/drm/meson/{meson_venc_cvbs.h => meson_encoder_cvbs.h} (92%)
 create mode 100644 drivers/gpu/drm/meson/meson_encoder_hdmi.c
 create mode 100644 drivers/gpu/drm/meson/meson_encoder_hdmi.h


base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
-- 
2.25.1

