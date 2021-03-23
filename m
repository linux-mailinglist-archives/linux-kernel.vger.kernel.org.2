Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66E534675E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhCWSPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhCWSOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:14:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F234CC061574;
        Tue, 23 Mar 2021 11:14:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id 61so21746105wrm.12;
        Tue, 23 Mar 2021 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GbZwWLO0faxizLlS0pXkd1V339UXzvG9Fjo6U6vn6Os=;
        b=Sfk5P279OI/pPHXLqgtMXrT6powvmwN6JmE5PSEApOadabisNP5IVlZQcJgBSv+dwI
         TmgCkpJVV75udTNNRZjCOy9dl6wbnw6anXomtpxTFKzLORtpMvZvFoFMn5G5VtWi8IQV
         /t9bI8KPuSC/gw3OjINDpaxlkBKYf4iPld24xMeL6wzqN65y98IEHvFofmqDeOq443eT
         XDWg71n8tQnSlnSLumMWASQzFLCi4XrOcufaushgFYAjsHsaBzv32o8MufCOupoBzAmc
         MnkMfYtHE2V3JlAVPrmnXcSi1oer0NOZxdmS3VkIPDJ1Q3pCwSGmPNGT99VlpTbsQCxR
         3J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GbZwWLO0faxizLlS0pXkd1V339UXzvG9Fjo6U6vn6Os=;
        b=M6i4p0Yr+jtKePQ7IbYuYeoZaWfy96vwCEGBzWSJW6y3XsR1EfVDPkmLSuHrxI751j
         9SBpHdqolhBbfA1RS3AszImK+4PVrsDzOLirwtgGW9Eo0HU2KMMe1tVGK0WR3f854/zG
         Zmkbw7V6z2/CTkCgjKrEqQU3OHkWTRBTIGh4vIKwoSUJLFE1msMj1S25oQsEe17UetL6
         Ym5hyPwp6iXWnZoLKa0e+Iq59XP5zf43NN7Wf4WVpMdMY00ofqmD/WbufWDELsbukyp8
         z4oaIM4oYIRenC632OPeM4SIlfqfg1ID8/zbtcZn+gEg9A+mkbnKi1DEypF+gBnv9IoY
         l+AQ==
X-Gm-Message-State: AOAM533XiC2IqHf6Z30TPXyKbQ+dXfFFL/VKzgx+fer812lnvQTRgy8F
        Mx9F8wzOqTJvmOwU4j7TMi0=
X-Google-Smtp-Source: ABdhPJy8YxTzXv70Rx/RXpuiBZyu4/JukCqPPoa/KiVMfInWD559h7X/+rMUmDf2A1kViF0dxaVpxQ==
X-Received: by 2002:a5d:640b:: with SMTP id z11mr5162914wru.327.1616523269575;
        Tue, 23 Mar 2021 11:14:29 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700f54ecdc9d152bb4f.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:f54e:cdc9:d152:bb4f])
        by smtp.gmail.com with ESMTPSA id 21sm3484734wme.6.2021.03.23.11.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:14:29 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        a.hajda@samsung.com, robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v8 0/2] Add support of Lontium lt8912 MIPI to HDMI bridge
Date:   Tue, 23 Mar 2021 19:14:21 +0100
Message-Id: <20210323181423.657926-1-adrien.grassein@gmail.com>
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

Update in v7
  - Fix HPD logic (via an HW emulation);
  - HPD from chip is still not working.

Update in v8
  - Remove HPD logic (will be added later when HW bug qill be fixed).

Thanks,

Adrien Grassein (2):
  dt-bindings: display: bridge: Add documentation for LT8912B
  drm/bridge: Introduce LT8912B DSI to HDMI bridge

 .../display/bridge/lontium,lt8912b.yaml       | 102 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/bridge/Kconfig                |  14 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt8912b.c      | 765 ++++++++++++++++++
 5 files changed, 888 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt8912b.c

-- 
2.25.1

