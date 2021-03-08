Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4759330D18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCHMGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCHMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:06:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DA3C06174A;
        Mon,  8 Mar 2021 04:06:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n22so5896702wmc.2;
        Mon, 08 Mar 2021 04:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iOFCAy30+hiqnUf4WFGNwRQ7loEwL1IKES//VoWfeRc=;
        b=OS6fdtLFf28FMBuEz7RzKgcVieehzMpNI89ZzTbO8djWN0jHZEt4s08XHp9fO0dBsD
         GumP4t6fsmbOWGwO5t9+UCB0mZN5qV5XMOAANGSKvzCiMx054chr2n86TdyH5QKszSpJ
         Ic4lIrNygkVxme5QCIqxP+/PAotVoWkkRQdhklUWDDYDnZNMARdTki6MFIgbOlblVOjk
         KKjE/c/099j/AzO6z287BgvXMl68YIwytaAIe5Vyyd4jmtR55DvlGukfSy+EexNtAF+H
         5sP40L743KcllyoZgWT4dTHCkRhaSnlDI1YRobSKcqgAbxjgxe+3h85x2pZf4nO2AV+W
         ATjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iOFCAy30+hiqnUf4WFGNwRQ7loEwL1IKES//VoWfeRc=;
        b=ugidH/b4vczlQg3rnk2RtPZ6+d9CJwSyE8tXkzSTLPPbiMQx1pQkbVXj1WpbprZMU5
         qA+pknOhrTjYInxhY0Bnwp/YrFKOOzCynUMLsQ2cZDFXc+PiU24/hfZkRaDv2jSZ5ILz
         wh013sb5JgnssjY/tIyn807z2D1/7I6JLjtH8LQyH6PQ/8cOMF+Vg9VgVQD3xPPLLV8Q
         oboEqTYSVic50SgZRy1u8Afs7ucT0Djl57M5nlBod0JKqOlBlAvzBtosh6Vp6cyW46hX
         92h1FTCL1z4NcM7H0xZuUUX6VJFOb+orwr4EHq43kGIfo6aWlHQ9vacvLl3mKKgcSXoc
         B9JQ==
X-Gm-Message-State: AOAM53256TkJHzR+hYNzlZANU82VxiGPt65p3tTemgXqYlVWg490VFMQ
        zmr6MgUoGOC4/5J+rmTJEIU=
X-Google-Smtp-Source: ABdhPJxa1eQWt2HdCMg4PMcsmn5l2Hfzos3rfB4FLAAl9nhOIY6CxiJPmuc4tC8oyR2MENr1SvtORA==
X-Received: by 2002:a05:600c:22c7:: with SMTP id 7mr22285365wmg.85.1615205158733;
        Mon, 08 Mar 2021 04:05:58 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270095bc7625808eade0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:95bc:7625:808e:ade0])
        by smtp.gmail.com with ESMTPSA id r7sm19031803wre.25.2021.03.08.04.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:05:58 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        a.hajda@samsung.com, robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v7 0/2] Add support of Lontium lt8912 MIPI to HDMI bridge
Date:   Mon,  8 Mar 2021 13:05:53 +0100
Message-Id: <20210308120555.252524-1-adrien.grassein@gmail.com>
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

Thanks,

Adrien Grassein (2):
  dt-bindings: display: bridge: Add documentation for LT8912B
  drm/bridge: Introduce LT8912B DSI to HDMI bridge

 .../display/bridge/lontium,lt8912b.yaml       | 102 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/bridge/Kconfig                |  14 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt8912b.c      | 836 ++++++++++++++++++
 5 files changed, 959 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt8912b.c

-- 
2.25.1

