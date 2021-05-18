Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CCE38740E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347487AbhERIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347450AbhERIaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:30:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E33AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 01:29:07 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1liv5x-00074a-4E; Tue, 18 May 2021 10:28:53 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1liv5v-0006nC-Gv; Tue, 18 May 2021 10:28:51 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v1 0/9] ARM: dts: fixes for Protonic boards
Date:   Tue, 18 May 2021 10:28:41 +0200
Message-Id: <20210518082850.26048-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provide different fixes for Protonic boards.

Oleksij Rempel (6):
  ARM: dts: imx6dl-prtvt7: add TSC2046 touchscreen node
  ARM: dts: imx6dl-prtvt7: Remove backlight enable gpio
  ARM: dts: imx6dl-prtvt7: fix PWM cell count for the backlight node.
  ARM: dts: imx6dl-plym2m: remove touchscreen-size-* properties
  ARM: dts: imx6dl: enable touchscreen debounce filter on PLYM2M and
    PRTVT7 boards
  ARM: dts: imx6qdl-vicut1: add interrupt-counter nodes

Robin van der Gracht (3):
  ARM: dts: imx6dl-prtvt7: Enable the VPU
  ARM: dts: imx6dl-prtvt7: The sgtl5000 uses i2s not ac97
  ARM: dts: imx6dl-prtvt7: Remove unused 'sound-dai-cells' from ssi1
    node

 arch/arm/boot/dts/imx6dl-plym2m.dts   |  6 ++--
 arch/arm/boot/dts/imx6dl-prtvt7.dts   | 36 ++++++++++++-----------
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 41 ++++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 21 deletions(-)

-- 
2.29.2

