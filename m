Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41CD326D15
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 14:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhB0NEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 08:04:30 -0500
Received: from mout01.posteo.de ([185.67.36.65]:40680 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhB0NE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 08:04:28 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 757AC16005C
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1614431010; bh=hI52LnpwZ+UpKwAaj2jKRoZyEeG1sesQOUWq5gC4WEY=;
        h=Date:From:To:Cc:Subject:From;
        b=pulr4slhXuPfRLDRVbgX0at9s+dBvOalxTtqn9CXDQOV5UKy7aL+hQ9lUXvLijsuP
         UI8XpluM/l47nwBYxg0kTUjePkl2le49Fp3lfNphONGsLVtSf5GMmyK/EJCJEyIZO0
         cbDxKIzXl82EdpyhvEzxULvSSeLV5803hT+dta9g7sUarpO0Vf8XTIPEe6XVjesWFb
         qFtwWUcQjNH/62LCjHxV1xxo5YcZjR3NfP3jyMduJHQ66XixqBnODIDMCS5aNXlJbI
         NGPK+y3snGWL6V1yzdTvVhQwSsaBn3sW0VHaE7VfcdNEDHnwHtEJVlIjNedtHzw3mI
         Spr+P7+DXTBIQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Dnmt95NDTz9rxD;
        Sat, 27 Feb 2021 14:03:29 +0100 (CET)
Date:   Sat, 27 Feb 2021 14:03:28 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v6 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <98f75101bbd7d6637aa596a9f43d0ea6372e57c8.1614430467.git.wilken.gottwalt@posteo.net>
References: <cover.1614430467.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1614430467.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
compatible series SoCs.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
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
 .../hwlock/allwinner,sun6i-hwspinlock.yaml    | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml
new file mode 100644
index 000000000000..733c3d01e56c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml
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
2.30.1

