Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374463872F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347018AbhERHRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346990AbhERHRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:17:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD83C061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:16:14 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1litxP-0005ND-9F; Tue, 18 May 2021 09:15:59 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1litxN-0002ZH-1O; Tue, 18 May 2021 09:15:57 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v1 0/3] add innolux,g070y2-t02 support for the Protonic VT7 board
Date:   Tue, 18 May 2021 09:15:52 +0200
Message-Id: <20210518071555.9785-1-o.rempel@pengutronix.de>
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

Add Innolux G070Y2-T02 panel support for the Protonic VT7 board.

Oleksij Rempel (3):
  dt-bindings: display: simple: add Innolux G070Y2-T02 panel
  drm: panel-simple: Add support for the Innolux G070Y2-T02 panel
  ARM: dts: imx6dl-prtvt7: Add display and panel nodes

 .../bindings/display/panel/panel-simple.yaml  |  2 +
 arch/arm/boot/dts/imx6dl-prtvt7.dts           | 47 +++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          | 16 +++++++
 3 files changed, 65 insertions(+)

-- 
2.29.2

