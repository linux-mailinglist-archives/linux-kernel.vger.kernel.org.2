Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7398434A705
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCZMUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCZMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:20:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA50C0613AA;
        Fri, 26 Mar 2021 05:20:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z2so5450726wrl.5;
        Fri, 26 Mar 2021 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kg1U2pASZJh61Qap78Y/WB4kOKba5GuYu7Xequ9TovM=;
        b=ApDLceLYrjN3KcZ8KGrUq7h5LqtlXdms3kCHUwf5LKOWChju9s8UbzZdFT00sHBWji
         fxDtaruRNz7u5jRqT0p9wT15uDg9gQRDTa640vTdCrogo15MYfUNjXfIgkwMys9VuTTc
         qBJvSQ2PB3HNIZ085nzvowSGsCTH8Lsg6+0CNfYVsaggIuJHUXWdwr6/2DMuS4vFZuHB
         k9KV7vx31lQD89yiMQFDLRw32tMhe/uiDA1ZU8hnm/+BKv3D8CzX3hW0bRGfl/g9q6Df
         Exw0MELumNmpzMIfwIuiwO9rArhA54V6WDXNkHdcL5bwP9LN4rAePu7MoTGenANMX7dQ
         N0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kg1U2pASZJh61Qap78Y/WB4kOKba5GuYu7Xequ9TovM=;
        b=PWUs9BDO65Zf30bv6XasxOR0/M+5XV2CgJHTBDBCVEz1basLF7m9sfQca9ABO5wYsW
         8t6l8CSBxTdZ3fcreaAQYd2TwGFssv0EQL5QgdfiOk2zRjNKRdw0pzbE018B4lCuQwqG
         Nfdgu5x+MydgBHWI4Akkxz14rqKu5DqcWooJAFE51e8Rj2cB3p0z/ZP7q0gZZcEq0r1/
         SapA0+zkTe9tmtDcrSjeHYdFWDOUebj89DnxzwN4nb6irNFdkosoVIk6mGHzKdhV7+hJ
         lO2f3upWtX450tm5RPg77u0v3PYBtELk8botemMe7dVpjAdbZ8WFqYiDFDGcltQgnxdV
         FjPQ==
X-Gm-Message-State: AOAM533cJS7jZmI8tf5c+I44Gph9qjYwrL8SF/lG0tg35AIehO+U4R8K
        O3Ae4fjarMosdrUES3/2luw=
X-Google-Smtp-Source: ABdhPJyVXeITO6E5oyD1KdyzgwwiHT1pwD6OdpuDL3xMdY9Gk8FkQbcfYiCdNpBHrQP2N4FX8ZhDvQ==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr14247608wru.214.1616761200589;
        Fri, 26 Mar 2021 05:20:00 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700f1419764c24345e5.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:f141:9764:c243:45e5])
        by smtp.gmail.com with ESMTPSA id l6sm11150102wrt.56.2021.03.26.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 05:20:00 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        a.hajda@samsung.com, robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v9 0/2] Add support of Lontium lt8912 MIPI to HDMI bridge
Date:   Fri, 26 Mar 2021 13:19:53 +0100
Message-Id: <20210326121955.1266230-1-adrien.grassein@gmail.com>
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

Update in v9
  - Fix errors found in scripts/checkpatch.pl --strict

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

