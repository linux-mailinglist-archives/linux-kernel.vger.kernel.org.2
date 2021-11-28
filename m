Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81736460668
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357631AbhK1NYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352642AbhK1NWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:22:32 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A391C061748;
        Sun, 28 Nov 2021 05:19:16 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id v23so17508177iom.12;
        Sun, 28 Nov 2021 05:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgH6bDvZzbG8b8t+1LLRo1oRPHaeFK2CSFYLS3VI3Ak=;
        b=llDkk7kaNIFNgZZvbTKAZRmDr4SPfRqb/3DUU8c+ES5LXxNLZhox2Eqyyte2epBWyP
         az9XGNDrP9UtfmLPNAhVe4FpJFNHA8ED/i2J+3uahaNz1Li9mb4r6gwPeXGB19YsZHyJ
         suhVunEEq2DkxKxHMcY9pxgj5wiKAY00rE7xAF2qi7Den+9i0viMVQi3ClssFbIz9EC5
         cgyLQpFbz98vxasr9HFscuYIoHLaJZ4/s5IjiYocgOWVX5Wowq+xADdVcBKz+FHvz1Qq
         bJkENBOEeuOJbexvb7JqDyPTKqgoU8W6E9pgYKHBZIAxFzjuFFvzAPbmdCocJfjb+S+A
         CUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgH6bDvZzbG8b8t+1LLRo1oRPHaeFK2CSFYLS3VI3Ak=;
        b=rKRze46vWqnuvzqtkVPbsAyq8xp5TVmzcJJbl7S0cQeMH/ss07Ohz+CYNPVIO7V5ZE
         xIdRvv0tWXjlq34T9RCGB8Dgm6MYV4N4ZsN7mx5aMASvgOZKVf62bues8ZPPhhwYvfKV
         L8XQm6FqhFjpyPRQPWXoepC0eOXHb1WMXpLXe5z0e4ACmhDqvFLIfjFlHGMdobmaE/z0
         lOtecQIlxbcz7Vcz9jIY47k/mn8y5q1EtHM7PUhlALBTG+NGNJpdmjV+G4u1LUS9N6OE
         xfjGR4ey/9H8N1moQKCx15ltP9kNtmz7WaaxXsG0m+2iqVRzUWdtpfyv85PzrTzRuWMt
         1TGw==
X-Gm-Message-State: AOAM5337CwVQDUY2L6QDzKLtubwrQCHwXyDSlICLN2AS11LHUO0D+vMs
        fOWvcuFWdpeCN5mHin0OUS8N86ArD7DIow==
X-Google-Smtp-Source: ABdhPJy/IdK3EwHgNszHnLIx5GT3XZ8aG2lh43dN8vG+3jVJtIFrB5omHokIpsvev9y1/0lD2R+K3g==
X-Received: by 2002:a02:ccb3:: with SMTP id t19mr57646053jap.145.1638105555709;
        Sun, 28 Nov 2021 05:19:15 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id q12sm6990413ile.77.2021.11.28.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:19:15 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/9] arm64: imx8mn: Enable more imx8m Nano functions
Date:   Sun, 28 Nov 2021 07:18:43 -0600
Message-Id: <20211128131853.15125-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano is similar to the i.MX8M Mini in some ways, but very
different in others.  With the blk-ctrl driver for Mini in place,
this series expands the blk-ctrl driver to support the Nano which
opens the door for additional functions in the future.  As part of
this series, it also addresses some issues in the GPCv2 driver and
finally adds support for enabling USB and GPU.

V4:  Rebase on top of [1] which fixes hangs caused from CSI and DSI reset
     and add the same fixes for CSI and DSI to the Nano
V3:  Fixes an the yaml example
V2:  Fixes the clock count in the blk-ctrl

[1] - https://www.spinics.net/lists/arm-kernel/msg936266.html

Adam Ford (9):
  soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
  soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
  dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
  dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
  soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
  arm64: dts: imx8mn: add GPC node
  arm64: dts: imx8mn: put USB controller into power-domains
  arm64: dts: imx8mn: add DISP blk-ctrl
  arm64: dts: imx8mn: Enable GPU

 .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     |  97 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 103 ++++++++++++++++++
 drivers/soc/imx/gpcv2.c                       |  26 +++++
 drivers/soc/imx/imx8m-blk-ctrl.c              |  77 ++++++++++++-
 include/dt-bindings/power/imx8mn-power.h      |   5 +
 5 files changed, 307 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml

--
2.32.0

