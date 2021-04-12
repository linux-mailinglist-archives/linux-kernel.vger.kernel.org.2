Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9ED35CA53
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbhDLPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbhDLPrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:47:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AA1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:46:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c15so4492368wro.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNnT1wU3EztqEa0KgoIYGkDLkF+wcg0kGpW7wqA3C04=;
        b=dOg9Zm65CqwzxIJILxx2hj+5zmmKAKeoklIBIC9UeAtaB3gAlNYS5IeyNkOhinnGGr
         sUEwayAB3k8DSJIGArYMWrcymNg2km5k/jzQ+0kYvxBeoLEjRzsCdPgjEPH5jLbDTR7P
         mF3lEVY1ft+wvy4grQsuMxr0A5zveq1Jee9jrIfdjbxWkRi+LbkRT7QPwX8PcMuVtTtX
         oClxp7OuI2y5FsXR1GuTBFyC8nHL/jUrCy9R6w1xQAFuu7lJ83SdR+q3QIRMcUXvv+L2
         R33HryN8PQFhu2G4QGz9eZDDqOHhloXNOkckhuKPCDaFpJlunJREhgmHKh9dEbuWrvt1
         uRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNnT1wU3EztqEa0KgoIYGkDLkF+wcg0kGpW7wqA3C04=;
        b=sxWS1eS0XmQeuvGcwQJjgaGkQLUGIQVwbtv9WPGrL5b7KvYamCuGW/WCTla/MojYOZ
         fZbVEjYlr3ZcPnoNnEx1wHo5KqJnzTtoUwe/1BjuokmYn+bex7yfH6009x86+4z/NMIi
         /tV2cHP0CDlZR7QCRrR7YtT6GDKoBAqzEbHjYon3BRXdgDOnwZljKYUojtkcZyYJN+YJ
         hTtkat/dDfmy47y7TozuY8F0JVVKctVhnxut42rS8XWJc8wNIgz8+Y6UUyuQD0ffTvnA
         qS35dVD4DuoK1gZEQ08B3X7f4bVdb7gKCAWaSKNo0Gr6zaaXcmRLtDCRhE2sh+I6hlzq
         N2SA==
X-Gm-Message-State: AOAM5303tWPjbfqmLP2G6yjrIPpmiX60OHqH0qtE/HgSW4+OQibt9Kr1
        QNDWzAT+S7iIkg8E0KlJAUVyyw==
X-Google-Smtp-Source: ABdhPJwRTm+eLU0pLV+Z9TThpW1iNGpKRcYqQXGh/eW9nkPio0nKcFzCorf0k6MSk4x5owNVKcrEVA==
X-Received: by 2002:a05:6000:1c7:: with SMTP id t7mr32440897wrx.313.1618242413207;
        Mon, 12 Apr 2021 08:46:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id u3sm12647332wmg.48.2021.04.12.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:46:52 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        paul@crapouillou.net, robert.foss@linaro.org
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 0/3] drm/bridge: Add it66121 driver
Date:   Mon, 12 Apr 2021 17:46:45 +0200
Message-Id: <20210412154648.3719153-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IT66121 is a high-performance and low-power single channel HDMI
transmitter, fully compliant with HDMI 1.3a, HDCP 1.2 and backward
compatible to DVI 1.0 specifications.
It supports pixel rates from 25MHz to 165MHz.

This series contains document bindings, add vendor prefix, Kconfig to
enable or not.
For now, the driver handles only RGB without color conversion.
Audio, CEC and HDCP are not implemented yet.

Changes since v2 at [1]:
- fixed DT bindings by:
  - adding bus-width property to input port
  - correctly defining ports
  - other minor fixes
- fixed bridge driver by:
  - general cleanup following Andy's comments
  - implemented support for NO_CONNECTOR
  - makes basic usage of the bus width property
  - add support for bus format negociation
  - other minor fixes
- fixed order of MAINTAINERS entries

[1] https://lore.kernel.org/r/20200311125135.30832-1-ple@baylibre.com

Phong LE (3):
  dt-bindings: display: bridge: add it66121 bindings
  drm: bridge: add it66121 driver
  MAINTAINERS: add it66121 HDMI bridge driver entry

 .../bindings/display/bridge/ite,it66121.yaml  |  123 ++
 MAINTAINERS                                   |    8 +
 drivers/gpu/drm/bridge/Kconfig                |    8 +
 drivers/gpu/drm/bridge/Makefile               |    1 +
 drivers/gpu/drm/bridge/ite-it66121.c          | 1081 +++++++++++++++++
 5 files changed, 1221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
 create mode 100644 drivers/gpu/drm/bridge/ite-it66121.c

-- 
2.25.1

