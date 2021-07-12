Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7543C6606
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 00:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhGLWLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 18:11:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:22385 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhGLWK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 18:10:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="210105070"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="210105070"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:08:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="464374173"
Received: from jzloch-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.136.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:08:04 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     x86@kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH 04/14] dt-bindings: Add bindings for peci-aspeed
Date:   Tue, 13 Jul 2021 00:04:37 +0200
Message-Id: <20210712220447.957418-5-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712220447.957418-1-iwona.winiarska@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the peci-aspeed controller driver.

Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 .../devicetree/bindings/peci/peci-aspeed.yaml | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.yaml

diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.yaml b/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
new file mode 100644
index 000000000000..6061e06009fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/peci/peci-aspeed.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed PECI Bus Device Tree Bindings
+
+maintainers:
+  - Iwona Winiarska <iwona.winiarska@intel.com>
+  - Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+
+allOf:
+  - $ref: peci-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-peci
+      - aspeed,ast2500-peci
+      - aspeed,ast2600-peci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: |
+      Clock source for PECI controller. Should reference the external
+      oscillator clock.
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clock-divider:
+    description: This value determines PECI controller internal clock
+      dividing rate. The divider will be calculated as 2 raised to the
+      power of the given value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    default: 0
+
+  msg-timing:
+    description: |
+      Message timing negotiation period. This value will determine the period
+      of message timing negotiation to be issued by PECI controller. The unit
+      of the programmed value is four times of PECI clock period.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 255
+    default: 1
+
+  addr-timing:
+    description: |
+      Address timing negotiation period. This value will determine the period
+      of address timing negotiation to be issued by PECI controller. The unit
+      of the programmed value is four times of PECI clock period.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 255
+    default: 1
+
+  rd-sampling-point:
+    description: |
+      Read sampling point selection. The whole period of a bit time will be
+      divided into 16 time frames. This value will determine the time frame
+      in which the controller will sample PECI signal for data read back.
+      Usually in the middle of a bit time is the best.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    default: 8
+
+  cmd-timeout-ms:
+    description: |
+      Command timeout in units of ms.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 1000
+    default: 1000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+    peci-controller@1e78b000 {
+      compatible = "aspeed,ast2600-peci";
+      reg = <0x1e78b000 0x100>;
+      interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
+      resets = <&syscon ASPEED_RESET_PECI>;
+      clock-divider = <0>;
+      msg-timing = <1>;
+      addr-timing = <1>;
+      rd-sampling-point = <8>;
+      cmd-timeout-ms = <1000>;
+    };
+...
-- 
2.31.1

