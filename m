Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9B4326DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 17:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhB0QQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 11:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhB0QNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 11:13:19 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F86C061786;
        Sat, 27 Feb 2021 08:12:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h98so11526735wrh.11;
        Sat, 27 Feb 2021 08:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8L0fMvr8Juw0+FWxKzR0WBqNrhDEw2SqgZ9h6QXSd3Q=;
        b=AZ+ESH47UAIy15YfmnXCJv76yqNmSE8RlW1IRN8RuQdo4NZ+TnDKm2x6lpOUvMNGV1
         vVkqgjRFLEkF9LEx9DCEI91PfFI1NwanByQuTe9n2nbN8SgcONx/lYAFMzW+FJ+YfsSE
         Kmzho365fT8/KPSL6BtCE+q+wZl0zeAu5+k1N9npbVdulFj2i94HQIElrJTmC1ZpGLTp
         WcIU8mNRN124t1836WAGRG69dh63hq5GTH6Xqf6UCAJ2B3aYFxlw4vgNkpbSpuBxbMQ0
         4wBE994x+yevPKAWPA0ZGnN+7brEyImFQUhSlUzjh8bVEP8ExjjASErTOau8FCErSasr
         LaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8L0fMvr8Juw0+FWxKzR0WBqNrhDEw2SqgZ9h6QXSd3Q=;
        b=pQRmWIsszpmqVllzoOYDKkFlMiq4EvGNqU6Yyl2S33sFtWDMBtDjGIhgZTdQ+qv6wY
         /xdtEd9rerxUys2OJqdkkpq8pLVdhxud88cImAQrvenWPQJV36Gi5WUposaxCtMtdf2o
         ztwmQNTpliexw4LkxI0mJRAmwMMctxjmcLucBbkzqKlWV4s8+xX1iveEZCXDIP8AsZ4k
         raqx8CTQ/BP4IXbcKX3x6bgd4oZgP77ch7LRRHGeTMwx3Mnnjm3vXVL2XW/VXlsQttb7
         L5g/32USjx/oEZgloN6PCed3Tx9zcFw3LOLKT7t14/z3B5RwN0tdIiRvclXGBhdfPlvV
         YF7g==
X-Gm-Message-State: AOAM531e8Vagn9pkrEcUjYFU1sufmTPhWy3sKGfUWt8DnVjwIg6Q4AMn
        hRxY4n8BKx3xHz23BavKf3Y=
X-Google-Smtp-Source: ABdhPJyNjitvPkhLUbSk9Ff/vTlgnbbp6Ci60uCSjhqVnFNPtK11zA5i95/I8RDW1Ny9ZNglG+58xA==
X-Received: by 2002:a5d:6809:: with SMTP id w9mr8155024wru.376.1614442353238;
        Sat, 27 Feb 2021 08:12:33 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700289c166d32b9da85.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:289c:166d:32b9:da85])
        by smtp.gmail.com with ESMTPSA id b15sm18390027wmd.41.2021.02.27.08.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 08:12:32 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        a.hajda@samsung.com, robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v5 0/2] Add support of Lontium lt8912 MIPI to HDMI bridge
Date:   Sat, 27 Feb 2021 17:12:26 +0100
Message-Id: <20210227161228.1632521-1-adrien.grassein@gmail.com>
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

Thanks,

Adrien Grassein (2):
  dt-bindings: display: bridge: Add documentation for LT8912B
  drm/bridge: Introduce LT8912B DSI to HDMI bridge

 .../display/bridge/lontium,lt8912b.yaml       | 102 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/bridge/Kconfig                |  14 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt8912b.c      | 817 ++++++++++++++++++
 5 files changed, 940 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt8912b.c

-- 
2.25.1

