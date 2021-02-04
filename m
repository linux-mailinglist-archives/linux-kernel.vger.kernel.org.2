Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C3830FEA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBDUmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBDUlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:41:06 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27AC061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:40:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DFF2F427D5;
        Thu,  4 Feb 2021 20:40:16 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 03/18] dt-bindings: arm: AAPL: Add bindings for Apple ARM platforms
Date:   Fri,  5 Feb 2021 05:39:36 +0900
Message-Id: <20210204203951.52105-4-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204203951.52105-1-marcan@marcan.st>
References: <20210204203951.52105-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces bindings for all three 2020 Apple M1 devices:

* AAPL,j274 - Mac mini (M1, 2020)
* AAPL,j293 - MacBook Pro (13-inch, M1, 2020)
* AAPL,j313 - MacBook Air (M1, 2020)

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/arm/AAPL.yaml         | 36 +++++++++++++++++++
 MAINTAINERS                                   | 10 ++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/AAPL.yaml

diff --git a/Documentation/devicetree/bindings/arm/AAPL.yaml b/Documentation/devicetree/bindings/arm/AAPL.yaml
new file mode 100644
index 000000000000..145b184e4a24
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/AAPL.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/AAPL.yaml#
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
+  - AAPL,j274 (board/device ID)
+  - AAPL,m1 (SoC name)
+  - AAPL,arm-platform (used for all Apple ARM devices)
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - description: Apple M1 SoC based platforms
+        items:
+          - enum:
+              - AAPL,j274 # Mac mini (M1, 2020)
+              - AAPL,j293 # MacBook Pro (13-inch, M1, 2020)
+              - AAPL,j313 # MacBook Air (M1, 2020)
+          - const: AAPL,m1
+          - const: AAPL,arm-platform
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d3e847f7f3dc..91a7b33834ac 100644
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
+F:	Documentation/devicetree/bindings/arm/AAPL.yaml
+
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>
-- 
2.30.0

