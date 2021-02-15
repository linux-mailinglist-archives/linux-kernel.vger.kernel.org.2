Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF08A31B8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBOMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBOMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:18:29 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEC0C0613D6;
        Mon, 15 Feb 2021 04:17:49 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5899E4249A;
        Mon, 15 Feb 2021 12:17:43 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/25] dt-bindings: arm: apple: Add bindings for Apple ARM platforms
Date:   Mon, 15 Feb 2021 21:16:50 +0900
Message-Id: <20210215121713.57687-3-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces bindings for all three 2020 Apple M1 devices:

* apple,j274 - Mac mini (M1, 2020)
* apple,j293 - MacBook Pro (13-inch, M1, 2020)
* apple,j313 - MacBook Air (M1, 2020)

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/arm/apple.yaml        | 36 +++++++++++++++++++
 MAINTAINERS                                   | 10 ++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/apple.yaml

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
new file mode 100644
index 000000000000..e44d308d6bde
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/apple.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple ARM Machine Device Tree Bindings
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  Apple ARM ("Apple Silicon") platforms should contain compatible strings
+  in the following format:
+
+  - apple,j274 (board/device ID)
+  - apple,m1 (SoC name)
+  - apple,arm-platform (Apple Silicon)
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - description: Apple M1 SoC based platforms
+        items:
+          - enum:
+              - apple,j274 # Mac mini (M1, 2020)
+              - apple,j293 # MacBook Pro (13-inch, M1, 2020)
+              - apple,j313 # MacBook Air (M1, 2020)
+          - const: apple,m1
+          - const: apple,arm-platform
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d3e847f7f3dc..4eba6ab16bd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1625,6 +1625,16 @@ F:	arch/arm/mach-alpine/
 F:	arch/arm64/boot/dts/amazon/
 F:	drivers/*/*alpine*
 
+ARM/APPLE MACHINE SUPPORT
+M:	Hector Martin <marcan@marcan.st>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+W:	https://asahilinux.org
+B:	https://github.com/AsahiLinux/linux/issues
+C:	irc://chat.freenode.net/asahi-dev
+T:	git https://github.com/AsahiLinux/linux.git
+F:	Documentation/devicetree/bindings/arm/apple.yaml
+
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>
-- 
2.30.0

