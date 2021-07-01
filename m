Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D6F3B98BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 00:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhGAXA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 19:00:28 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:46328 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbhGAXA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 19:00:28 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id B6836F40828; Fri,  2 Jul 2021 00:57:54 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] dt-bindings: nintendo-otp: Document the Wii and Wii U OTP support
Date:   Fri,  2 Jul 2021 00:57:40 +0200
Message-Id: <20210701225743.14631-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701225743.14631-1-linkmauve@linkmauve.fr>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210701225743.14631-1-linkmauve@linkmauve.fr>
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
index 000000000000..c39bd64b03b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
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

