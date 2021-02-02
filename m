Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7393E30C8A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhBBR5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:57:05 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:45506 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhBBRyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:54:25 -0500
Received: by mail-oi1-f175.google.com with SMTP id g69so23647144oib.12;
        Tue, 02 Feb 2021 09:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8vDbQmL5iEpetuc73BnBxCM6fFf2Ksz8RzcABWCqFJU=;
        b=FUo0ekdmK4FlBwpmlCjb/VV6Z3P6JRCSI6CSgvOthnPmsA8RKNIWo79CgrNucyIB/m
         r4MBjVKVSkfQivKDUf0YbA6E1+/i50ry0iM9bimwdChxY7SDxkcGfQc0yGb9euRKmbkB
         m3Z7qNMn5HUgsUUu0N8YGHoyyJ8VmGVKJ3xb6X4ZVL2eNsSzki6G2LGAgiAJFYGRvB4a
         NkE1NY/ouV4I1DipHUvaLQp3ZBlhhNUwsOwN9Wp1uRYfXgnXxMUnarRW4nH4cmLBt0t6
         Gp2G6c/HNJTzeYp8FnZYC2Xd401BWuasMMbrbSyKAwNuko7/585Yzv4yhmVYMv6H/mNY
         yHQA==
X-Gm-Message-State: AOAM533CqNlYf/J1RCSyr87wTJAQFPQ1MO3EpoFATNYinXr8tkWRjO6C
        /QrVaOK9rszppgLPnEe7UeYMRuP83w==
X-Google-Smtp-Source: ABdhPJwIYDUyFnb5s/PSk+AdX838p6dxHfZoKOZ+WzBABVXuE4rg9x/AiinJzkyQAz7JTW4NvyEmIQ==
X-Received: by 2002:aca:c64c:: with SMTP id w73mr3685645oif.168.1612288421912;
        Tue, 02 Feb 2021 09:53:41 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a76sm5348460oib.45.2021.02.02.09.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:53:40 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] dt-bindings: mtd: spi-nor: Convert to DT schema format
Date:   Tue,  2 Feb 2021 11:53:39 -0600
Message-Id: <20210202175340.3902494-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the SPI-NOR binding to DT schema format. Like other memory chips,
the compatible strings are a mess with vendor prefixes not being used
consistently and some compatibles not documented. The resulting schema
passes on 'compatible' checks for most in tree users with the exception
of some oddballs.

I dropped the 'm25p.*-nonjedec' compatible strings as these don't appear
to be used anywhere.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/jedec,spi-nor.txt |  91 ----------------
 .../bindings/mtd/jedec,spi-nor.yaml           | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 91 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
deleted file mode 100644
index f03be904d3c2..000000000000
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
+++ /dev/null
@@ -1,91 +0,0 @@
-* SPI NOR flash: ST M25Pxx (and similar) serial flash chips
-
-Required properties:
-- #address-cells, #size-cells : Must be present if the device has sub-nodes
-  representing partitions.
-- compatible : May include a device-specific string consisting of the
-               manufacturer and name of the chip. A list of supported chip
-               names follows.
-               Must also include "jedec,spi-nor" for any SPI NOR flash that can
-               be identified by the JEDEC READ ID opcode (0x9F).
-
-               Supported chip names:
-                 at25df321a
-                 at25df641
-                 at26df081a
-                 mr25h128
-                 mr25h256
-                 mr25h10
-                 mr25h40
-                 mx25l4005a
-                 mx25l1606e
-                 mx25l6405d
-                 mx25l12805d
-                 mx25l25635e
-                 n25q064
-                 n25q128a11
-                 n25q128a13
-                 n25q512a
-                 s25fl256s1
-                 s25fl512s
-                 s25sl12801
-                 s25fl008k
-                 s25fl064k
-                 sst25vf040b
-                 m25p40
-                 m25p80
-                 m25p16
-                 m25p32
-                 m25p64
-                 m25p128
-                 w25x80
-                 w25x32
-                 w25q32
-                 w25q64
-                 w25q32dw
-                 w25q80bl
-                 w25q128
-                 w25q256
-
-               The following chip names have been used historically to
-               designate quirky versions of flash chips that do not support the
-               JEDEC READ ID opcode (0x9F):
-                 m25p05-nonjedec
-                 m25p10-nonjedec
-                 m25p20-nonjedec
-                 m25p40-nonjedec
-                 m25p80-nonjedec
-                 m25p16-nonjedec
-                 m25p32-nonjedec
-                 m25p64-nonjedec
-                 m25p128-nonjedec
-
-- reg : Chip-Select number
-- spi-max-frequency : Maximum frequency of the SPI bus the chip can operate at
-
-Optional properties:
-- m25p,fast-read : Use the "fast read" opcode to read data from the chip instead
-                   of the usual "read" opcode. This opcode is not supported by
-                   all chips and support for it can not be detected at runtime.
-                   Refer to your chips' datasheet to check if this is supported
-                   by your chip.
-- broken-flash-reset : Some flash devices utilize stateful addressing modes
-		   (e.g., for 32-bit addressing) which need to be managed
-		   carefully by a system. Because these sorts of flash don't
-		   have a standardized software reset command, and because some
-		   systems don't toggle the flash RESET# pin upon system reset
-		   (if the pin even exists at all), there are systems which
-		   cannot reboot properly if the flash is left in the "wrong"
-		   state. This boolean flag can be used on such systems, to
-		   denote the absence of a reliable reset mechanism.
-
-Example:
-
-	flash: m25p80@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spansion,m25p80", "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <40000000>;
-		m25p,fast-read;
-	};
diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
new file mode 100644
index 000000000000..5e7e5349f9a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI NOR flash ST M25Pxx (and similar) serial flash chips
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - pattern: "^((((micron|spansion|st),)?\
+              (m25p(40|80|16|32|64|128)|\
+              n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
+              atmel,at25df(321a|641|081a)|\
+              everspin,mr25h(10|40|128|256)|\
+              (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|\
+              (mxicy|macronix),mx25u(4033|4035)|\
+              (spansion,)?s25fl(128s|256s1|512s|008k|064k|164k)|\
+              (sst|microchip),sst25vf(016b|032b|040b)|\
+              (sst,)?sst26wf016b|\
+              (sst,)?sst25wf(040b|080)|\
+              winbond,w25x(80|32)|\
+              (winbond,)?w25q(16|32(w|dw)?|64(dw)?|80bl|128(fw)?|256))$"
+          - const: jedec,spi-nor
+      - items:
+          - enum:
+              - issi,is25lp016d
+              - micron,mt25qu02g
+              - mxicy,mx25r1635f
+              - mxicy,mx25u6435f
+              - mxicy,mx25v8035f
+              - spansion,s25sl12801
+              - spansion,s25fs512s
+          - const: jedec,spi-nor
+      - const: jedec,spi-nor
+    description:
+      Must also include "jedec,spi-nor" for any SPI NOR flash that can be
+      identified by the JEDEC READ ID opcode (0x9F).
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+  spi-rx-bus-width: true
+  spi-tx-bus-width: true
+
+  m25p,fast-read:
+    type: boolean
+    description:
+      Use the "fast read" opcode to read data from the chip instead of the usual
+      "read" opcode. This opcode is not supported by all chips and support for
+      it can not be detected at runtime. Refer to your chips' datasheet to check
+      if this is supported by your chip.
+
+  broken-flash-reset:
+    type: boolean
+    description:
+      Some flash devices utilize stateful addressing modes (e.g., for 32-bit
+      addressing) which need to be managed carefully by a system. Because these
+      sorts of flash don't have a standardized software reset command, and
+      because some systems don't toggle the flash RESET# pin upon system reset
+      (if the pin even exists at all), there are systems which cannot reboot
+      properly if the flash is left in the "wrong" state. This boolean flag can
+      be used on such systems, to denote the absence of a reliable reset
+      mechanism.
+
+  label: true
+
+  partitions:
+    type: object
+
+  '#address-cells': true
+  '#size-cells': true
+
+patternProperties:
+  # Note: use 'partitions' node for new users
+  '^partition@':
+    type: object
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            compatible = "spansion,m25p80", "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <40000000>;
+            m25p,fast-read;
+        };
+    };
+...
-- 
2.27.0

