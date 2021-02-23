Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57085323015
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhBWR5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhBWR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:56:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2C7C061574;
        Tue, 23 Feb 2021 09:56:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so23473014wrd.6;
        Tue, 23 Feb 2021 09:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IyVloWl8unt/KJdcuJNibhs/5zk/r6+x/gImwnrP5BY=;
        b=phNHgeK7u4URixcCSxPiOM4PlwQEivyaW25MMjIQ/WRO1Kv2FmLXiPJzH+ATy5sDM+
         925T7p2zQfHlXbjqhN9Sn7Ll0AhmckOe/eViW3tXxxoPz6Gkmm5nj60GaovK5P79NBBG
         PWJSp+ePAH2x8sLD8Wg5lZKHjR7mkY7k8hp9mShWcFqwPk8rhHYf+sukraSmCpkV1op6
         9fUh784mU1EPHUhRpyPaBoN6vXq6C9DI/zotWdlhjXkkhN/3+dSblEAaunAgKcbCAnvl
         Ixpn6xv6uf+QLHnGv0HpbhO7ryYpvzQWYckTYLrDcnRPkj1WtIGdh2CWdriVnW7zI9aS
         ZVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IyVloWl8unt/KJdcuJNibhs/5zk/r6+x/gImwnrP5BY=;
        b=n3bjm+zvrpLPtdOMqar+HheGQZprRyXvdNKFL+Xn/+ZJ1Mf2h0j9kLwjHU0AG8oDeg
         6NyISoR37mL4bcSfFl/PN4djhPi8u+zNx6K/DrYtwyG/SS8cKCzZ97k/EZQ5xdaw+UE5
         zzd07tJ3rWZ1g7elMLOZXppErkfAi8zgpTPPAq2upL03gzYt+gLhs/Fl7u6//bqfvGwx
         1i3Uhi0We9B3C1rp77k2z5LQ241NJDn+z+5/PpzYwXQI94Uln0WJQMn+pvKMpo13Z2Uw
         FjqUazoPxj0k9yDwHmrBdXQiHnmbAlktHaHZgmz3Cj9qvMKGwD1qYlHAPbZmbU5Qov0T
         kAvQ==
X-Gm-Message-State: AOAM533PYzxbRqA+0eUNxw9+ZtT+Bqy5L43dw+O49zTSnI9lXO+YmyHX
        +KTCn1YNBddPxYOefCM959A=
X-Google-Smtp-Source: ABdhPJxlIIBZlxOVilXG9G6Ys2oj/GvN9y7crj7+v46Tpl9b475B5UF5MmwmVp8JCTgW/Iy43toVvA==
X-Received: by 2002:adf:e84d:: with SMTP id d13mr10674015wrn.247.1614102973195;
        Tue, 23 Feb 2021 09:56:13 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id g9sm2779815wrp.14.2021.02.23.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:56:12 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        a.hajda@samsung.com, robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 0/2] Add support of Lontium lt8912 MIPI to HDMI bridge
Date:   Tue, 23 Feb 2021 18:56:05 +0100
Message-Id: <20210223175607.431796-1-adrien.grassein@gmail.com>
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

Adrien Grassein (2):
  dt-bindings: display: bridge: Add documentation for LT8912
  drm/bridge: Introduce LT8912 DSI to HDMI bridge

 .../display/bridge/lontium,lt8912.yaml        | 102 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/bridge/Kconfig                |  14 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt8912.c       | 764 ++++++++++++++++++
 5 files changed, 887 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt8912.c

-- 
2.25.1

