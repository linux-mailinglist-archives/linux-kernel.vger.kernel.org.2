Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0FE39D38C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 05:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFGDla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 23:41:30 -0400
Received: from phobos.denx.de ([85.214.62.61]:59264 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhFGDl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:41:27 -0400
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2F94182D2D;
        Mon,  7 Jun 2021 05:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623037175;
        bh=1pmwLBLgzqrDGqGyCCkjvGO4IpT1lSu/igKeua8K7X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JbmtyNfj5ArtcjmhDVNYrQTUnE83Z4xbfH+J35+QaNGd6txU4I6M6d5g8ZZLRzbir
         KMlUR8hfCeFmx0HzFDwl/8OKoVIqTKTrXJYfcAGAB96oQcLs7pWXnRQZRuIt+gW5tH
         dWs1VU9Zlp+bOcGkYhGv0qehrjh18jgnqZYvkWwJdl+TxKQ0RFqfyHEQxOWqSV4/v/
         bRwlcIK/b7XBlX+TTCFRMKVer2epfQROmJsgGeabm/BxsuqUdeFCc93lyvwknAaNui
         4xAxGcuK+k3zo5GSCNyKGOSfDp7JTN/ICHa9kK6qObZraCw6zcYBOrBsj9zzrCfXO2
         1GZAD4ONdh4MQ==
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id D663A182B91;
        Mon,  7 Jun 2021 05:39:14 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id A50731A8BB3; Mon,  7 Jun 2021 05:39:12 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-mtd@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>, Rob Herring <robh@kernel.org>,
        Fabio Estevam <festevam@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mtd: devices: add devicetree documentation for microchip 48l640
Date:   Mon,  7 Jun 2021 05:39:08 +0200
Message-Id: <20210607033909.1424605-2-hs@denx.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607033909.1424605-1-hs@denx.de>
References: <20210607033909.1424605-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip 48l640 is a 8KByte EERAM connected via SPI.
Add devicetree bindings documentation.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

Changes in v4:
- work in comments from Rob:
  - change title to
    Microchip 48l640 (and similar) serial EERAM bindings
  - rename spi-eeram to eeram
- Add Reviewed-by tag from Rob

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
index 0000000000000..2cdf6bf3dc4ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mtd/microchip,mchp48l640.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Microchip 48l640 (and similar) serial EERAM bindings
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
+      eeram@0 {
+        compatible = "microchip,48l640";
+        reg = <0>;
+        spi-max-frequency = <20000000>;
+      };
+    };
+...
-- 
2.31.1

