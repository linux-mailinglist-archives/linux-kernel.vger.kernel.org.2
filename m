Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8444052D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 23:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJ2V50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231504AbhJ2V5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635544493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0y+js0xn4d9o0dcNrtOtPbAxb1UW1ZkQOz94yRpKQ10=;
        b=R4nsTKeCsVzLmZW5wI5jQ1vbc7HII3zknhWYalo+YtT1xtVcbcdB9VR1LEnL4hER5kQ6Cu
        YRs/QWGMhFzEi/GuL+y6tI1mjcRIUw+smrNVyXokDndeoZ5IRcgmNT8enmJbonRPLBWlnW
        EyfKieiHLV+J8v4FzjhJAY5e9fhZwzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-7IRzyhJ8NwehXcWCwbuXTQ-1; Fri, 29 Oct 2021 17:54:50 -0400
X-MC-Unique: 7IRzyhJ8NwehXcWCwbuXTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB13D8018AC;
        Fri, 29 Oct 2021 21:54:48 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A30FC18351;
        Fri, 29 Oct 2021 21:54:46 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH 4/5] Documentation: bindings/mfd: sensehat: Raspberry Pi Sense HAT device tree binding
Date:   Fri, 29 Oct 2021 17:55:15 -0400
Message-Id: <20211029215516.801593-5-cmirabil@redhat.com>
In-Reply-To: <20211029215516.801593-1-cmirabil@redhat.com>
References: <20211029215516.801593-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree binding
for the Sense HAT in yaml form.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 .../bindings/mfd/raspberrypi,sensehat.yaml    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml

diff --git a/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
new file mode 100644
index 000000000000..e00cd02a3752
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+$id: http://devicetree.org/schemas/mfd/raspberrypi,sensehat.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi Sensehat
+
+maintainers:
+  - Charles Mirabile <cmirabil@redhat.com>
+  - Mwesigwa Guma <mguma@redhat.com>
+  - Joel Savitz <jsavitz@redhat.com>
+
+description: |
+  The Raspberry Pi Sensehat is an addon board originally developed
+  for the Raspberry Pi that has a joystick and an 8x8 RGB LED display
+  as well as several environmental sensors. It connects via i2c and
+  a gpio for irq.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+        - raspberrypi,sensehat
+        - rpi,rpisense
+
+  reg:
+    items:
+      - description: i2c bus address
+
+  keys-int-gpios:
+    items:
+      - description: gpio pin for joystick interrupt
+
+required:
+  - compatible
+  - reg
+  - keys-int-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      sensehat@46 {
+        compatible = "raspberrypi,sensehat";
+        reg = <0x46>;
+        keys-int-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+      };
+    };
-- 
2.31.1

