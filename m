Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8CF3093A1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhA3Jov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:44:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:31007 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233426AbhA3DJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 22:09:59 -0500
IronPort-SDR: WFCVZ8bkVxX2rV7ZXWyGOT31zMtCZDEAixmC6safSDO/CWkAZCd6F/xm6BwkF6WFNL0GFvf6PJ
 b/+szHD7KhEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="167606735"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="167606735"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:29 -0800
IronPort-SDR: 9yAX6PF42RjE85V4GgyiIN5zmZY4UzI4ao/CQKlj5WZYQjjWTJ2Z9uocLpKA8F4C8gEkD2wOP0
 TR0jPBFHuWIQ==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="404733824"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:29 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 29D776378;
        Fri, 29 Jan 2021 18:21:29 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 1D6AF363649; Fri, 29 Jan 2021 18:21:29 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
Subject: [PATCH v3 32/34] dt-bindings: misc: hddl_dev: Add hddl device management documentation
Date:   Fri, 29 Jan 2021 18:20:47 -0800
Message-Id: <20210130022124.65083-33-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130022124.65083-1-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "C, Udhayakumar" <udhayakumar.c@intel.com>

Add hddl device management documentation

The HDDL client driver acts as an software RTC to sync with network time.
It abstracts xlink protocol to communicate with remote IA host.
This driver exports the details about sensors available in the platform
to remote IA host as xlink packets.
This driver also handles device connect/disconnect events and identifies
board id and soc id using gpio's based on platform configuration.

Signed-off-by: C, Udhayakumar <udhayakumar.c@intel.com>
---
 .../bindings/misc/intel,hddl-client.yaml      | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,hddl-client.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,hddl-client.yaml b/Documentation/devicetree/bindings/misc/intel,hddl-client.yaml
new file mode 100644
index 000000000000..c1d121c35fc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,hddl-client.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/intel,hddl-client.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel hddl client device to handle platform management in Bay series
+
+maintainers:
+  - Udhayakumar C <udhayakumar.c@intel.com>
+
+description: |
+  The HDDL client driver acts as an software RTC to sync with network time.
+  It abstracts xlink protocol to communicate with remote host. This driver
+  exports the details about sensors available in the platform to remote
+  host as xlink packets.
+  This driver also handles device connect/disconnect events and identifies
+  board id and soc id using gpio's based on platform configuration.
+
+select: false
+
+properties:
+  compatible:
+    items:
+      - const: intel,hddl-client
+
+  reg:
+    minItems: 4
+    maxItems: 4
+
+  xlink_chan:
+    minItems: 1
+    maxItems: 1
+    description: xlink channel number used for communication
+                 with remote host for time sync and sharing sensor
+                 details available in platform.
+
+  i2c_xlink_chan:
+    minItems: 1
+    maxItems: 1
+    description: xlink channel number used for communication
+                 with remote host for xlink i2c smbus.
+
+  sensor_name:
+    type: object
+    description:
+      Details about sensors and its configuration on local host and remote
+      host.
+
+    properties:
+      compatible:
+        items:
+          - const: intel_tsens
+
+      reg:
+        description: i2c slave address for sensor.
+
+      local-host:
+        minItems: 1
+        maxItems: 1
+        description: enable bit 0 to register sensor as i2c slave
+                     in local host (normal i2c client)
+                     enable bit 1 to mimic sensor as i2c slave
+                     in local host (onchip sensors as i2c slave)
+                     enable bit 2 to register i2c slave as xlink smbus slave
+                     in local host.
+      remote-host:
+        minItems: 1
+        maxItems: 1
+        description: enable bit 0 to register sensor as i2c slave
+                     in remote host (normal i2c client)
+                     enable bit 1 to mimic sensor as i2c slave
+                     in remote host (onchip sensors as i2c slave)
+                     enable bit 2 to register i2c slave as xlink smbus slave
+                     in remote host.
+
+      bus:
+        minItems: 1
+        maxItems: 1
+        description: i2c bus number for the i2c client device.
+
+    required:
+      - compatible
+      - reg
+      - local-host
+      - remote-host
+      - bus
+
+required:
+  - compatible
+  - reg
+  - xlink_chan
+  - i2c_xlink_chan
+
+additionalProperties: false
+
+examples:
+  - |
+    hddl_dev: hddl@20320000 {
+       compatible = "intel,hddl-client";
+       #address-cells = <2>;
+       #size-cells = <2>;
+       status = "disabled";
+       reg = <0x0 0x20320000 0x0 0x800>;
+       xlink_chan = <1080>;
+       i2c_xlink_chan = <1081>;
+       kmb_xlink_tj {
+         status = "okay";
+         compatible = "intel_tsens";
+         local-host = <0x3>;
+         remote-host = <0x3>;
+         bus = <0x1>;
+      };
+    };
-- 
2.17.1

