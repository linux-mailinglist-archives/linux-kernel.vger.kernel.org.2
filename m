Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82A23DCA94
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhHAHiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 03:38:51 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:60462 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhHAHim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 03:38:42 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 31F91F409C8; Sun,  1 Aug 2021 09:38:29 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] dt-bindings: nintendo-otp: Document the Wii and Wii U OTP support
Date:   Sun,  1 Aug 2021 09:38:19 +0200
Message-Id: <20210801073822.12452-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801073822.12452-1-linkmauve@linkmauve.fr>
References: <20210701225743.14631-1-linkmauve@linkmauve.fr>
 <20210801073822.12452-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of these consoles use the exact same two registers, even at the
same address, but the Wii U has eight banks of 128 bytes memory while
the Wii only has one, hence the two compatible strings.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 .../bindings/nvmem/nintendo-otp.yaml          | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
new file mode 100644
index 000000000000..dbe4ffdd644c
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nintendo-otp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii and Wii U OTP Device Tree Bindings
+
+description: |
+  This binding represents the OTP memory as found on a Nintendo Wii or Wii U,
+  which contains common and per-console keys, signatures and related data
+  required to access peripherals.
+
+  See https://wiiubrew.org/wiki/Hardware/OTP
+
+maintainers:
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - nintendo,hollywood-otp
+      - nintendo,latte-otp
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    otp@d8001ec {
+        compatible = "nintendo,latte-otp";
+        reg = <0x0d8001ec 0x8>;
+    };
+
+...
-- 
2.32.0

