Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7648410BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 14:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhISM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 08:58:02 -0400
Received: from mout.perfora.net ([74.208.4.196]:49833 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232231AbhISM54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:57:56 -0400
Received: from localhost.localdomain ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MbB1Y-1n3U6q1rBI-00bYCZ;
 Sun, 19 Sep 2021 14:56:16 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] dt-bindings: arm: fsl: add toradex,colibri-imx6ull-emmc
Date:   Sun, 19 Sep 2021 14:55:36 +0200
Message-Id: <20210919125536.117743-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210919125536.117743-1-marcel@ziswiler.com>
References: <20210919125536.117743-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kJQTiLoy6F8KE5OWlRnJXlt84f5B/dEyvQJMv8gxAkhvrvUfC+F
 2xhfocdn7x91w1cWD3e+JXhv0v3UO5/8KkZ+ARi+80LzIZ3CQLwjCMgq85PkJ9k0LsVLQbM
 LXhlPhS/T2USnu+qE2sqbXex+sYiEJSI/0O0oDrwNQUbuzGsQh/7jnyhMrFCq89K/i4cSit
 xypNnRbwrHYtEwa+0QuPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dqh92kmVwbs=:JW6IcQhVY2OfM+q+LIkDlo
 PmlJtWInSqX5++d75jvDwVPhPd0NzUldyhC+Co03a/hdphmhon+wAayMY4oEIZboGdUU3uwdK
 3uj+fcDRx8/e5hITswKjt9FNZOFydKJGR1UamDYWcz4Pld7JotiVhaRCacH9A3mFXZN9JJWm+
 FPktRgpl6K2n688LZJPnCRx0sFY0ROzmgBq4qamYUlw9JWF8aeI4Oobfm+qSdEg+hE3+Q0xBL
 hSgU0DS4jq3mQiKCqsN0Ex1ZYqndPE+z9Vd0Ap/OEFE9+lg8h6NwkgzCltFPbGI7ll5h19XG7
 6P7S7e3PMXWsvNb1NSDVlTAC4INE1CtCpzmFSYGdqzp9Kr7Wg8dWYZSCqiVbkLblH+i4gj3QJ
 yZU7IVwBqg7cFf0x1eu4Z8aQ5PZrcmali0IJuHSmsozBVh/dybinIy+FCtmZ+MV0mhX3X5L/6
 iLiJjr4wjNISbzGHsUrWfNDwP++Ghnsm+DjBOl9B9jBT1f4CD3sLXoTGTIge4rqPiT6aChbQe
 LYVjF3PRjdBI0BMYzGoqZ0AQOhg64HRtjbE12TQPzrZlJIkjczML758jRmPg7HLzoDg4YoUt/
 KPgS7W1fZZhL+9zrubKXEAQklTd26NG7MUgnWbgC137+WheuwQ9JoqpT0nh8Q+Hqw9q0y6kAD
 h+i7fEAfPWZRKFLVdScZajXO6TH7fiFur4Fgy+d0lXbsOoCWM2GAhuyDYklyKbX6ou7TsZZdn
 YLm9WW6q8CYTjYXHBsQgOQbxbNt1avuCPmS/gQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add toradex,colibri-imx6ull-emmc for our new Colibri iMX6ULL 1GB (eMMC)
Module and the carrier boards (so far only Colibri Evaluation Board) it
may be mated in.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes in v3:
- Add Rob's ack. Thanks!
- Add Fabio's reviewed-by. Thanks!

Changes in v2:
- New patch documenting dt-bindings.

 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a95314bd271c7..32e2d5537210b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -581,6 +581,7 @@ properties:
               - kontron,imx6ull-n6411-som # Kontron N6411 SOM
               - myir,imx6ull-mys-6ulx-eval # MYiR Tech iMX6ULL Evaluation Board
               - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
+              - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC) Module
               - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / BT Modules
           - const: fsl,imx6ull
 
@@ -606,6 +607,13 @@ properties:
           - const: toradex,colibri-imx6ull        # Colibri iMX6ULL Module
           - const: fsl,imx6dl
 
+      - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL 1GB (eMMC) Module
+        items:
+          - enum:
+              - toradex,colibri-imx6ull-emmc-eval # Colibri iMX6ULL 1GB (eMMC) Module on Colibri Evaluation Board
+          - const: toradex,colibri-imx6ull-emmc   # Colibri iMX6ULL 1GB (eMMC) Module
+          - const: fsl,imx6dl
+
       - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL Wi-Fi / BT Modules
         items:
           - enum:
-- 
2.26.2

