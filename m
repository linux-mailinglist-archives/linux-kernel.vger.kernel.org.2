Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9090363C45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbhDSHM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbhDSHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:12:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C6EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:12:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so17403632wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bnc7rry0yOyWImFy7btWR/TymYu644iNqXg07l+AwQ=;
        b=ySFYuMzYjYVOF6rfkPbiYz7f93FrrVz7nI9LKI2FzGb5kgpcKWc7qMVVkToh6fEKdS
         7yN7z9thId+RvAJpnpFAML3t7WqLCa6qWg1hX1l5C+BIJMUQQqWNDx53NPkq09XPOeK9
         vnCvxOPn1l8VAlwEeT+4luERBdVLnYBsIAYBrkfSLwYhJE1NmvSuxjbUZPOoaIAPyv/d
         I4MsHAf/fx2PIufpnhf6DvL71NDcRXGPJnotJCf/2odAzpYSvy+sAm7sJnbhUb75/BWc
         V41KvmT2q14zv7yk8KcK9iUK9aKMVh9+ZQGlWTABIBQ+47ou3u7ZSx3jOHzcPU/nilkz
         MkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bnc7rry0yOyWImFy7btWR/TymYu644iNqXg07l+AwQ=;
        b=evHpGZduaGZI+G3iBbUFas2X9XPtHZmlRw/dbTlu8VTII2wYWqubp58vScTNgH38hc
         qV5aK0/hOh8gGZgTXX4gLslod9wTScM9yyR+T77d/kNoUtPrTWz8YgwFEnDORH6ER5vh
         RHijQ+5vFngrxG49Ys0hc8qKOmQAfNsyV4B3oo51DENzSwa3Y5jecxwNam4xzM+c72b5
         xqHF+CCAHg7DdrjBlyB7kj+UShUTJwJ6OIiBLkW+pkCSDtB0NF5JxZ5Um3kCLBCmW4i/
         J3Qh01d4yi3T5BeKDgqeo26NqEhp60j8CtGmXGFk0pfZUWZuFqIxvXdmNZX/ZNPqq5zi
         qD3w==
X-Gm-Message-State: AOAM531LXpFwy0jQpZoQkx2FxJ5xZzS4gTjHAmL6MSLOh1ALZF/8kRNp
        GAqFt5NVBPfG7l3oIyEi/hnpDw==
X-Google-Smtp-Source: ABdhPJwhzCnAjrbkqq5544zQvttf6CrDIWzEg2TPcaRFRFH4LgCn5P6qeUu+4CX85qNzjzxRXwOAYA==
X-Received: by 2002:a7b:cbc1:: with SMTP id n1mr20107628wmi.50.1618816343239;
        Mon, 19 Apr 2021 00:12:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:2e82:31e6:67f1:4f33])
        by smtp.gmail.com with ESMTPSA id i9sm10447922wmg.2.2021.04.19.00.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:12:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        paul@crapouillou.net, robert.foss@linaro.org
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 0/3] drm/bridge: Add it66121 driver
Date:   Mon, 19 Apr 2021 09:12:20 +0200
Message-Id: <20210419071223.2673533-1-narmstrong@baylibre.com>
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

Changes since v3 at [2]:
- DT
 - removed i2c reg description
 - used 4 spaces indent in example
 - added review tags
- driver
 - added missing includes
 - added missing atomic bridge callbacks
 - dropped connector creation completely, only supports NO_CONNECTOR
 - moved single line helpers to inline
 - some more indentation cleanups
- MAINTAINER
 - fixed order
 - added review tags

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
[2] https://lore.kernel.org/r/20210412154648.3719153-1-narmstrong@baylibre.com

Phong LE (3):
  dt-bindings: display: bridge: add it66121 bindings
  drm: bridge: add it66121 driver
  MAINTAINERS: add it66121 HDMI bridge driver entry

 .../bindings/display/bridge/ite,it66121.yaml  |  124 ++
 MAINTAINERS                                   |    8 +
 drivers/gpu/drm/bridge/Kconfig                |    8 +
 drivers/gpu/drm/bridge/Makefile               |    1 +
 drivers/gpu/drm/bridge/ite-it66121.c          | 1021 +++++++++++++++++
 5 files changed, 1162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
 create mode 100644 drivers/gpu/drm/bridge/ite-it66121.c

-- 
2.25.1

