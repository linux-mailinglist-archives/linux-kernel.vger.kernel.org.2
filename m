Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657E9396C65
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 06:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhFAEhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 00:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhFAEhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 00:37:52 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCAEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 21:36:11 -0700 (PDT)
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 53F9F82EA1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 06:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1622522170;
        bh=EHsCHku6r+HkI5oirppWFnWhJBUYvp8UUKRBFQGYFto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7t+U3LiiQc/v2xCqJXg2sm4Y81xOgj8fMZ/dOAEs/da+LdgtwW5XDAoLlh6ZCduZ
         kwc2ml5ObdOpqkzeJ4HsJr887OL7ueENjO3qMuhT15tQmptdckZHFZV1OSRAtKL/h4
         vbkPmeOyEnLdOYZGrY7GnqwlPBxwxgc7cvpNzy5M23G4iVWLggDCfjEWds3RmX3Gki
         cPqI7Xvr6FNriht7f778698QLpqzjGogaNBOQSKF+oxyLz2FpPDS8yw7R4g8E0nvcz
         geQnU7vTEeunSGEHrwtKRlregyVJ5Y1jNn6l5Pnb7DjVA3YTMJAdlfwh8JA5gW3gQ2
         EkkEx3ryAjxog==
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 5EA4A184CD1;
        Tue,  1 Jun 2021 06:35:50 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 2CFDD1A8BC6; Tue,  1 Jun 2021 06:35:48 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-mtd@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mtd: devices: add devicetree documentation for microchip 48l640
Date:   Tue,  1 Jun 2021 06:35:45 +0200
Message-Id: <20210601043546.1345704-2-hs@denx.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601043546.1345704-1-hs@denx.de>
References: <20210601043546.1345704-1-hs@denx.de>
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

Changes in v3:
Add Fabio to cc

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
2.31.1

