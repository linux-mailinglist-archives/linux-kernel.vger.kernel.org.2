Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0BB3C81E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbhGNJpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbhGNJpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:45:10 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D1EC061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:42:17 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by laurent.telenet-ops.be with bizsmtp
        id UxiF2500Q1ccfby01xiFKs; Wed, 14 Jul 2021 11:42:15 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bPD-0015cg-0F; Wed, 14 Jul 2021 11:42:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bPC-00A3QK-Ca; Wed, 14 Jul 2021 11:42:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: phy: Rename Intel Keem Bay USB PHY bindings
Date:   Wed, 14 Jul 2021 11:42:13 +0200
Message-Id: <91235a64185f7446fc58e638d77691078d3114d1.1626255556.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only file not using the "intel,keembay-*" pattern.
Fortunately the actual compatible value is already following the
standard scheme.

Fixes: 4086afa2a1627939 ("dt-bindings: phy: Add Intel Keem Bay USB PHY bindings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
  - Add Acked-by.
---
 .../{intel,phy-keembay-usb.yaml => intel,keembay-phy-usb.yaml}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/phy/{intel,phy-keembay-usb.yaml => intel,keembay-phy-usb.yaml} (93%)

diff --git a/Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml b/Documentation/devicetree/bindings/phy/intel,keembay-phy-usb.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
rename to Documentation/devicetree/bindings/phy/intel,keembay-phy-usb.yaml
index a217bb8ac5bc0887..52815b6c2b88d019 100644
--- a/Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
+++ b/Documentation/devicetree/bindings/phy/intel,keembay-phy-usb.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/intel,phy-keembay-usb.yaml#
+$id: http://devicetree.org/schemas/phy/intel,keembay-phy-usb.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel Keem Bay USB PHY bindings
-- 
2.25.1

