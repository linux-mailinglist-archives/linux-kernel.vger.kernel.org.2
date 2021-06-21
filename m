Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595C23AE40C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFUH0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhFUH0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:26:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D260C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:24:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v7so13440697pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Mz90SrmvetiiKOz2FA2/q5WPVb/5Mateql9uC1osYI=;
        b=LH6roB4QN50Ss3fd6q+CBK16FfSLRV/++biPwO3AeQTv8PFz5YsC987Yl5PrPtbQUR
         grYaD4IXKWdJJOg4dF6BckzRXAb951oI2Olp611oMhF3JgfviD5I5Jhy/q+gsRLvIMqk
         koZVmpZYLZherETZSArj4lMgsAiX7fGYNfJ8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Mz90SrmvetiiKOz2FA2/q5WPVb/5Mateql9uC1osYI=;
        b=i/mXKIFunxAnC+UTeEmPO1yiZZAX7+vvh6rQvo2vM68AdqGB1xFKFz19zDrnS+6SlM
         0fxUoyb+avKH94HKpPy+ihdiz2vAhmY2Zlppg4NM+SmNbzq1PlyWJdXkyNxq+HQoGdyx
         0SgNB6PvV8kWLXrWQXr0nsASBFloj6gJCGeJgflGvYKHdPR2r8P9gdcH5IxnytSfx1Rs
         BfZnOMrn6rHZ+kXSTrfkGUsj0QUk4yrRNbkrR5WF8lNuPT1wRtVFNiU48wfrIYmCyLiN
         46J2b600Fpt0jf8OYySQGQwk9ibyXMJrv5rtK2bNO77Mscni/5y2EnxPt2h/NQ6GxICZ
         I+Jw==
X-Gm-Message-State: AOAM530GXC791462wI+cJSnn7c2uPatXDX6dbv/0xc2bVa4w1/P9S7Ws
        6yd2k3a9TxN0P+7dJHV3swzurg==
X-Google-Smtp-Source: ABdhPJxiCxvGt4Lvg95BHdbOmEwOZrpqM6XZznMkEdEE3H9U0aYNeyTH/9EQGYu7BduM/FJvQrX1Kg==
X-Received: by 2002:a63:ef04:: with SMTP id u4mr22267854pgh.429.1624260278855;
        Mon, 21 Jun 2021 00:24:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:139:e97f:a55d:7f66])
        by smtp.gmail.com with ESMTPSA id 21sm13951294pfh.103.2021.06.21.00.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 00:24:38 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz Figa <t.figa@samsung.com>,
        Fancy Fang <chen.fang@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [RFC PATCH 0/9] arm64: imx8mm: Add MIPI DSI support
Date:   Mon, 21 Jun 2021 12:54:15 +0530
Message-Id: <20210621072424.111733-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series support MIPI DSI on i.MX8MM.

It worked directly with existing mxsfb driver but the SEC DSIM
timings has to be validate and tested through all platforms, 
ie reason I'm sending it as RFC.

Tested on Engicam i.Core MX8M Mini SoM.

patch 1: dt-bindings for SEC MIPI DSIM

patch 2: SEC MIPI DSIM bridge driver

patch 3: dt-bindings for SEC DSIM DPHY

patch 4: SEC DSIM DPHY driver

patch 5: MIPI DPHY reset enable in blk-ctl

patch 6: display mix blk ctl node

patch 7: eLCDIF node

patch 8: MIPI DSI pipeline nodes

patch 9: Enable LVDS panel on EDIMM2.2

Note:
- all these patches on top of Peng Fan's blk-ctl driver.
- anyone interest, please have a look on this repo
  https://github.com/openedev/linux/commits/imx8mm

Any inputs?
Jagan.

Jagan Teki (9):
  dt-bindings: display: bridge: Add Samsung SEC MIPI DSIM bindings
  drm: bridge: Add Samsung SEC MIPI DSIM bridge driver
  dt-bindings: phy: Add SEC DSIM DPHY bindings
  phy: samsung: Add SEC DSIM DPHY driver
  soc: imx8mm: blk-ctl: Add MIPI DPHY reset enable
  arm64: dts: imx8mm: Add display mix blk ctl
  arm64: dts: imx8mm: Add eLCDIF node support
  arm64: dts: imx8mm: Add MIPI DSI pipeline
  arm64: dts: imx8mm-icore: Enable LVDS panel for EDIMM2.2

 .../display/bridge/samsung,sec-dsim.yaml      |  184 ++
 .../bindings/phy/samsung,sec-dsim-dphy.yaml   |   56 +
 .../freescale/imx8mm-icore-mx8mm-edimm2.2.dts |   90 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  104 ++
 drivers/gpu/drm/bridge/Kconfig                |   15 +
 drivers/gpu/drm/bridge/Makefile               |    1 +
 drivers/gpu/drm/bridge/sec-dsim.c             | 1535 +++++++++++++++++
 drivers/phy/samsung/Kconfig                   |    9 +
 drivers/phy/samsung/Makefile                  |    1 +
 drivers/phy/samsung/phy-sec-dsim-dphy.c       |  236 +++
 drivers/soc/imx/blk-ctl-imx8mm.c              |    4 +
 include/dt-bindings/power/imx8mm-power.h      |    5 +-
 12 files changed, 2238 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/samsung,sec-dsim.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,sec-dsim-dphy.yaml
 create mode 100644 drivers/gpu/drm/bridge/sec-dsim.c
 create mode 100644 drivers/phy/samsung/phy-sec-dsim-dphy.c

-- 
2.25.1

