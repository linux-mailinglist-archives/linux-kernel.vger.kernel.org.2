Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24633250D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhCIMOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhCIMOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:14:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109FBC06174A;
        Tue,  9 Mar 2021 04:14:05 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u4so26725613lfs.0;
        Tue, 09 Mar 2021 04:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJrXfS7Tr1d3xV4PIT0xg70kR2pU0ho6aOnS9OMYEk8=;
        b=oejj2O7VEyKJ2VNIkcdrFSWH0PppqtbgvH7cOUP0/16W9+9Qze3bj/mqUN4nP/OO5f
         fU4Ksz33Z7GrkT//ZN95amU/SR+bMwyT//05joIoyQJusG6JbTYyfmoHEBo08i1ObQ4S
         S+UUAKzgv85yMPAaAyK62Cp7Y9xNnV0+iZIr/hCf7afUGEAH9wC8qNM8i0QR4zU1fLB5
         SGGEn750fpg0VRm+V1Ru5SHr1m2fwXb1VVEQl1rxDV+UgTPgTXttLJ9x4LiLBi9hF9pw
         zmKcRjht0HfhU6z+dVeX8P9lAD7MdQAGc0sYg5/2oeqQ59++hX+13Z3QOZeiDVRvt7No
         u0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJrXfS7Tr1d3xV4PIT0xg70kR2pU0ho6aOnS9OMYEk8=;
        b=AFRlUpEjxpoZ3Ik7SVSkNZcVEHoHYvPB92YlZjlPahVpVfgsQfYNbDI0Ax/jrNDy1r
         /M/mCkjmmJS8AbB0TTpTKvpvp8U2TsvsHxt6Jvbg2xeuLBmkbTC5kmHec3ShZf9c9nOD
         sjPn5aaR5gIw3ojhilkAgsj2CjHKYkRcyidqFBhevEbXxS9OVR0vBaH5872goYp1rr9Y
         xUfSm7HRlB5dd7zmrVdjgAnunSXsHvXrn47upjt74O6vWt/J3BCLW0qzlpFJHWxTDMS/
         lrXHy8WVLiG2k1RH1td5CCqCNJhaUrus53d2m8fIGn7DAQieZFN637qeNUE+6Sg9quTJ
         Bd5Q==
X-Gm-Message-State: AOAM5339+jw/iagipbKPcTiH8wdSKMjwtUx464HZvyPuPycKnUzZhTUW
        20QPbpK0QNH6EPqcOqvd71M=
X-Google-Smtp-Source: ABdhPJyhl0dy1nrHRh0FBKdIQp2WgS+HtiR62tJG5W5Sxo9kS1ZDYzv27UBuK3g33W/eF6wL2KZmIg==
X-Received: by 2002:a05:6512:22c8:: with SMTP id g8mr17479557lfu.388.1615292043308;
        Tue, 09 Mar 2021 04:14:03 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id v129sm1755991lfa.43.2021.03.09.04.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 04:14:02 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH robh next] dt-bindings: usb: add USB controller port
Date:   Tue,  9 Mar 2021 13:13:11 +0100
Message-Id: <20210309121311.7263-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

USB bindings already allow specifying USB device hard wired to a
specific controller port but they don't allow describing port on its
own.

This fixes:
arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dt.yaml: usb@23000: port@1: 'compatible' is a required property
        From schema: Documentation/devicetree/bindings/usb/generic-xhci.yaml

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
Please check if I got the $nodename part right. Somehow I don't see any
errors / warnings when using:

something@1 {
	reg = <1>;
};
---
 .../devicetree/bindings/usb/usb-hcd.yaml      |  4 +-
 .../devicetree/bindings/usb/usb-port.yaml     | 39 +++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-port.yaml

diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
index 56853c17af66..b0c6a79cad57 100644
--- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
@@ -33,7 +33,9 @@ patternProperties:
   "^.*@[0-9a-f]{1,2}$":
     description: The hard wired USB devices
     type: object
-    $ref: /usb/usb-device.yaml
+    oneOf:
+      - $ref: /usb/usb-port.yaml
+      - $ref: /usb/usb-device.yaml
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/usb/usb-port.yaml b/Documentation/devicetree/bindings/usb/usb-port.yaml
new file mode 100644
index 000000000000..68fe16c8703e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb-port.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/usb-port.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB port on USB controller
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+description: |
+  This binding describes a single USB controller port that doesn't have any
+  device hard wired.
+
+properties:
+  $nodename:
+    pattern: "^port@[0-9a-f]{1,2}$"
+
+  reg:
+    description: number of USB controller port
+    maxItems: 1
+
+required:
+  - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    usb@11270000 {
+        reg = <0x11270000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@1 {
+            reg = <1>;
+        };
+    };
-- 
2.26.2

