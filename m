Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAE63DD3ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhHBKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhHBKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:36:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E8BC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 03:36:29 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mAVIk-000238-KJ; Mon, 02 Aug 2021 12:36:06 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mAVIj-0007TR-0i; Mon, 02 Aug 2021 12:36:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, soc@kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 0/3] Mainline imx6 based SKOV boards
Date:   Mon,  2 Aug 2021 12:36:00 +0200
Message-Id: <20210802103603.28607-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v3:
- drop panel bindings patches, it is already in drm-misc-next
- remove some new lines
- reorder compatibles at the start of the nodes
- use lowercase for hex value
- add enable-active-high to the regulator-vcc-mmc-io and fix MMC voltage
  configuration.

changes v2:
- remove unnecessary newlines.
- change linux,wakeup to wakeup-source
- change switch@3 unit-address to @0
- sort aliases alphabetically

Mainline imx6 based DTs for SKOV A/S boards

Oleksij Rempel (2):
  dt-bindings: vendor-prefixes: Add an entry for SKOV A/S
  dt-bindings: arm: fsl: add SKOV imx6q and imx6dl based boards

Sam Ravnborg (1):
  ARM: dts: add SKOV imx6q and imx6dl based boards

 .../devicetree/bindings/arm/fsl.yaml          |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   5 +
 arch/arm/boot/dts/imx6dl-skov-revc-lt2.dts    |  13 +
 arch/arm/boot/dts/imx6dl-skov-revc-lt6.dts    | 106 ++++
 arch/arm/boot/dts/imx6q-skov-revc-lt2.dts     |  36 ++
 arch/arm/boot/dts/imx6q-skov-revc-lt6.dts     | 128 +++++
 .../dts/imx6q-skov-reve-mi1010ait-1cp1.dts    | 127 +++++
 arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi  |  54 ++
 arch/arm/boot/dts/imx6qdl-skov-cpu.dtsi       | 476 ++++++++++++++++++
 10 files changed, 952 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-skov-revc-lt2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-skov-revc-lt6.dts
 create mode 100644 arch/arm/boot/dts/imx6q-skov-revc-lt2.dts
 create mode 100644 arch/arm/boot/dts/imx6q-skov-revc-lt6.dts
 create mode 100644 arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-skov-cpu.dtsi

-- 
2.30.2

