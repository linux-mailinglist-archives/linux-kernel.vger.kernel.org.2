Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A41336DD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbhD1Qe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:34:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240929AbhD1Qe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:34:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5DD8B122;
        Wed, 28 Apr 2021 16:33:40 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: ata: Add device tree binding fir Mikrotik RB532 PATA controller
Date:   Wed, 28 Apr 2021 18:33:36 +0200
Message-Id: <20210428163336.73125-3-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210428163336.73125-1-tsbogend@alpha.franken.de>
References: <20210428163336.73125-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for Mikrotik RB532 PATA controller.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 .../bindings/ata/mikrotek,rb532-pata.yaml     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml

diff --git a/Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml b/Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml
new file mode 100644
index 000000000000..f74880c4fd82
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/mikrotek,rb532-pata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mikrotek RB532 PATA Controller bindings
+
+maintainers:
+  - Thomas Bogendoerfer <tsbogend@alpha.franken.de>
+
+properties:
+  compatible:
+    const: mikrotik,rb532-pata
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - gpio
+
+additionalProperties: false
+
+examples:
+  - |
+    cf@18a10000 {
+        compatible = "mikrotik,rb532-pata";
+        reg = <0x18a10000 0xc04>;
+
+        gpio = <&gpio0 13 0>;
+
+        interrupt-parent = <&gpio0>;
+        interrupts = <13 0>;
+    };
-- 
2.29.2

