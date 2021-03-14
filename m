Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E5A33A3E8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 10:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhCNJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 05:31:20 -0400
Received: from mout01.posteo.de ([185.67.36.65]:47673 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235042AbhCNJaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 05:30:55 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id DDACB160062
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 10:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1615714251; bh=3pjyhWK9LV12j2dh8/yXJjVRu1veQGVWhyNK7myeutU=;
        h=Date:From:To:Cc:Subject:From;
        b=NfiuZtKqvrLtYg47RA+uPAzX0CIaTU133tvmj8VOaaf5m1snTVuM2rPpHLRQCVDso
         cd5FbghlEjfCM4aPoZ/WJjzVvwOdqyXhUuft2y2QJjOE/3C7TgT+jSFp2EEkzKFTzD
         SZk9I+jPn56QqCtg4LlmqMYr/Qj2K879KbKEiUydY4f9qRzX/hIzpgyTB2aNA9fAg7
         rSkXFnzzsJCLFl0tYtxASpcp3BRc1drBq5CyEP5RWA87Ko9JFveUe4VhtrOfmGTgCw
         fxrZ7OjiGIuGPCysbfO2xHZKhl5lV1LoaWhavn+F0wNFKqMhvEhFRWrvHEV8MRRkkA
         qkbXSAgN3+mUw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DyvRt493Hz6tmW;
        Sun, 14 Mar 2021 10:30:50 +0100 (CET)
Date:   Sun, 14 Mar 2021 10:30:49 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v7 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <b7a1f5532e0ae474473858055fd9bbabff9e1449.1615713499.git.wilken.gottwalt@posteo.net>
References: <cover.1615713499.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615713499.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
compatible series SoCs.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
Changes in v7:
  - changed dt documentation to the name of the compatible string

Changes in v6:
  - fixed formating and name issues in dt documentation

Changes in v5:
  - changed binding to earliest known supported SoC sun6i-a31
  - dropped unnecessary entries

Changes in v4:
  - changed binding to sun8i-a33-hwpinlock
  - added changes suggested by Maxime Ripard

Changes in v3:
  - changed symbols from sunxi to sun8i

Changes in v2:
  - fixed memory ranges
---
 .../allwinner,sun6i-a31-hwspinlock.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
new file mode 100644
index 000000000000..733c3d01e56c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/allwinner,sun6i-hwspinlock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SUN6I hardware spinlock driver for Allwinner sun6i compatible SoCs
+
+maintainers:
+  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
+
+description:
+  The hardware unit provides semaphores between the ARM cores and the embedded
+  companion core on the SoC.
+
+properties:
+  compatible:
+    const: allwinner,sun6i-a31-hwspinlock
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    hwlock@1c18000 {
+        compatible = "allwinner,sun6i-a31-hwspinlock";
+        reg = <0x01c18000 0x1000>;
+        clocks = <&ccu CLK_BUS_SPINLOCK>;
+        resets = <&ccu RST_BUS_SPINLOCK>;
+    };
+...
-- 
2.30.2

