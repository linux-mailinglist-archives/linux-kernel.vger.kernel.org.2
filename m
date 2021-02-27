Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEAB326ECD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 20:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhB0Ttm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 14:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhB0TtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 14:49:24 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC91C06174A;
        Sat, 27 Feb 2021 11:48:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id n4so11917226wrx.1;
        Sat, 27 Feb 2021 11:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pCdXkUGdbXxFWrdiSKZfKK1y/JajvMt7IrRHviPqOz0=;
        b=onzxmnsTlNeB9dC9J7rdV7ptcwlxHTIBpgpxZXjv8/FHudXcYgeeqiaBgZeiXDYntz
         vtRuUCw8Yo8ZOQhAVuYYzkz3umOci/qSK+wIek+5kAvYwOLvtKS0vcC+Z5CQgNvFHo0e
         v2JfZndjJ+mSuEuvtQPfl3k1Ii/rnF3UYEM7ltFUBL9NEoyqRUxm8tNPjffJ1LTNqzf0
         iIq26tFMBbv4DWdCMeRhVlQ95dWSoX8ODnvi0OlY6ZkxMuLbdIDMcmIUU/BCIuITa7YZ
         3ZFSTY4qgET0VGxV5YwXmPLLBs/l643AQrLs56q+/+vBdbvU+FD98Db9W6F8pCulibhi
         CQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pCdXkUGdbXxFWrdiSKZfKK1y/JajvMt7IrRHviPqOz0=;
        b=UyUQZQK1+0hbVjdE3Y0376IDRLvgrJUsQJ3GJy4VHw8L02XJMbOgu9e3CmcMd5T+t2
         Lo0ErB4GUKx0TC1+g2CkI/xDBCTJOIKQoUYrHSk85IJVHfampm6Gf/6IARnDGq25GSCa
         cnTooDxiksetoXgy5rxKjPLAoK9ZbZYCDdbNpmLpBGZBkpWni6BgaU1B4gWf27AowCVf
         sFBk1NVQq5jtBIi/soUDYU0WjBLD34x/rX7m301vLbYp7p13QnrwNCFxG//LUNTASQuS
         ixe0f9awZBOcaQzS+15s2BS9k7f/M5vTr7iT0mtohX/JYUMtqAXRqMaCYavQiID2ie0Y
         8o1g==
X-Gm-Message-State: AOAM531+Lr8j1CbhVUN7WkvNu3zlSzBN4Ci2SdJAfbhmxhhFlsf8TAEM
        uHSHXXDqck4g6v7W3k9bZZo=
X-Google-Smtp-Source: ABdhPJyz/QGbhv7EhcO+Hxa4/UEfYcnXP98xYulRVfFLCIJ7Ph1hsXUKcPtLBABP0YsS9pvfFtcwzQ==
X-Received: by 2002:a5d:640b:: with SMTP id z11mr9027206wru.327.1614455322140;
        Sat, 27 Feb 2021 11:48:42 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700289c166d32b9da85.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:289c:166d:32b9:da85])
        by smtp.gmail.com with ESMTPSA id f9sm12453123wro.77.2021.02.27.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 11:48:41 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        a.hajda@samsung.com, robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v6 0/2] Add support of Lontium lt8912 MIPI to HDMI bridge
Date:   Sat, 27 Feb 2021 20:48:34 +0100
Message-Id: <20210227194836.1848753-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this patch set adds the support of the Lontium lt8912 MIPI to HDMI
bridge in the kernel.

It's only support the video part, not the audio part yet
since I don't have the datasheet of this component.
I get the current i2c configuration from Digi and
Boundary drivers.
Developed using the DB_DSIHD board from BoundaryDevices.

Update in v2
  - Use standard data-lanes instead of a custom prop;
  - Use hdmi-connector node.

Update in v3
  - Fix indentation;
  - Implement missing bridge functions;
  - Add some comments.

Update in v4
  - Fix bridge ops;
  - Fix i2c error detection.

Update in v5
  - Fix lt8912 name (lt8912b instead of lt8912);
  - Implement HPD via a workaround. In fact I don't have the datasheet
    of this component yet so I can't say if the configuration of the
registers is correct or if I have an HW issue on my board. So, I choose
to implement a fake version of HPD using a workqueue and polling the
status regularly.

Update in v6
  - Fix a warning found by "kernel test robot"

Thanks,

Adrien Grassein (2):
  dt-bindings: display: bridge: Add documentation for LT8912B
  drm/bridge: Introduce LT8912B DSI to HDMI bridge

 .../display/bridge/lontium,lt8912b.yaml       | 102 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/bridge/Kconfig                |  14 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt8912b.c      | 818 ++++++++++++++++++
 5 files changed, 941 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt8912b.c

-- 
2.25.1

