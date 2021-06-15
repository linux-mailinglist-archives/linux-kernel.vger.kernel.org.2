Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957C13A7CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhFOLKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:10:05 -0400
Received: from foss.arm.com ([217.140.110.172]:60634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhFOLJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:09:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB054113E;
        Tue, 15 Jun 2021 04:07:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 542D43F719;
        Tue, 15 Jun 2021 04:07:21 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v7 10/19] dt-bindings: usb: Add H616 compatible string
Date:   Tue, 15 Jun 2021 12:06:27 +0100
Message-Id: <20210615110636.23403-11-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210615110636.23403-1-andre.przywara@arm.com>
References: <20210615110636.23403-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H616 has four PHYs as the H3, along with their respective clock
gates and resets, so the property description is identical.

However the PHYs itself need some special bits, so we need a new
compatible string for it.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml
index f80431060803..e288450e0844 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml
@@ -15,7 +15,9 @@ properties:
     const: 1
 
   compatible:
-    const: allwinner,sun8i-h3-usb-phy
+    enum:
+      - allwinner,sun8i-h3-usb-phy
+      - allwinner,sun50i-h616-usb-phy
 
   reg:
     items:
-- 
2.17.5

