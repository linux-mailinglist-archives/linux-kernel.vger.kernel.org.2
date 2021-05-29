Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A129B394BAA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 12:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhE2K3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 06:29:40 -0400
Received: from phobos.denx.de ([85.214.62.61]:60960 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhE2K3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 06:29:37 -0400
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id ACE9681895
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 12:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1622284080;
        bh=B5KI7ifeeOuKGZWeMhm6fI1KYhbpiukyN7ZgTTDJmkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t81N/y2aPhVC6MzhzBPMf03CqOiy20EgNMNNHEv1bRUxx/EEOj3r/eJ2rfcNLfdIV
         WuZVwZ+YFi4GjL6620GmaBUQPdOUNmKvVozkDaEoaMwt+pBVbbUCZ7jIiGgs4sRLAb
         kwhgjuXG27M7J1mi0Q1C2dDupQiz7w/fQ73MSCS9TIpNaqXXsBHDnLD8bMjEf0p5ah
         J08nNGIeGb8T8cBDrnlvDjqR0gp4F7jtr8GJq1v1Bk81eq/IkSTt4kfUHnBPyWYNDT
         KIsbhNZmDTttXFQjIU+lP99ZrrkvGP974LLVnbLSqHXM7Z6cxj5+Lz5fYdzqDE+J68
         lKGho7bB3mf4g==
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 9A0CD182BA4;
        Sat, 29 May 2021 12:27:46 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 8EC501A8BC5; Sat, 29 May 2021 12:27:46 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-mtd@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mtd: devices: add devicetree documentation for microchip 48l640
Date:   Sat, 29 May 2021 12:27:43 +0200
Message-Id: <20210529102744.1251220-2-hs@denx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529102744.1251220-1-hs@denx.de>
References: <20210529102744.1251220-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip 48l640 is a 8KByte EERAM connected via SPI.
Add devicetree bindings documentation.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

Changes in v2:
as Rob helped, fix warnings from running command
'make DT_CHECKER_FLAGS=-m dt_binding_check'

 .../bindings/mtd/microchip,mchp48l640.yaml    | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml

diff --git a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
new file mode 100644
index 0000000000000..08089f2db0761
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mtd/microchip,mchp48l640.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MTD SPI driver for Microchip 48l640 (and similar) serial EERAM
+
+maintainers:
+  - Heiko Schocher <hs@denx.de>
+
+description: |
+  The Microchip 48l640 is a 8KByte EERAM connected via SPI.
+
+  datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/20006055B.pdf
+
+properties:
+  compatible:
+    items:
+      - const: microchip,48l640
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      spi-eeram@0 {
+        compatible = "microchip,48l640";
+        reg = <0>;
+        spi-max-frequency = <20000000>;
+      };
+    };
+...
-- 
2.30.2

