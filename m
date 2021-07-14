Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24653C7DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 06:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbhGNE4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 00:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhGNE4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 00:56:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97E9C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 21:54:02 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m3Wu8-0001DU-DG; Wed, 14 Jul 2021 06:53:52 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m3Wu6-0002sE-KW; Wed, 14 Jul 2021 06:53:50 +0200
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
Subject: [PATCH v2 3/4] dt-bindings: arm: fsl: add SKOV imx6q and imx6dl based boards
Date:   Wed, 14 Jul 2021 06:53:48 +0200
Message-Id: <20210714045349.10963-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714045349.10963-1-o.rempel@pengutronix.de>
References: <20210714045349.10963-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SKOV imx6q/dl LT2, LT6 and mi1010ait-1cp1 boards.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1c827c1954dc..7520af510f06 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -221,6 +221,9 @@ properties:
               - prt,prti6q                # Protonic PRTI6Q board
               - prt,prtwd2                # Protonic WD2 board
               - rex,imx6q-rex-pro         # Rex Pro i.MX6 Quad Board
+              - skov,imx6q-skov-revc-lt2  # SKOV IMX6 CPU QuadCore lt2
+              - skov,imx6q-skov-revc-lt6  # SKOV IMX6 CPU QuadCore lt6
+              - skov,imx6q-skov-reve-mi1010ait-1cp1 # SKOV IMX6 CPU QuadCore mi1010ait-1cp1
               - solidrun,cubox-i/q        # SolidRun Cubox-i Dual/Quad
               - solidrun,hummingboard/q
               - solidrun,hummingboard2/q
@@ -377,6 +380,8 @@ properties:
               - prt,prtvt7                # Protonic VT7 board
               - rex,imx6dl-rex-basic      # Rex Basic i.MX6 Dual Lite Board
               - riot,imx6s-riotboard      # RIoTboard i.MX6S
+              - skov,imx6dl-skov-revc-lt2 # SKOV IMX6 CPU SoloCore lt2
+              - skov,imx6dl-skov-revc-lt6 # SKOV IMX6 CPU SoloCore lt6
               - solidrun,cubox-i/dl            # SolidRun Cubox-i Solo/DualLite
               - solidrun,hummingboard/dl
               - solidrun,hummingboard2/dl      # SolidRun HummingBoard2 Solo/DualLite
-- 
2.30.2

