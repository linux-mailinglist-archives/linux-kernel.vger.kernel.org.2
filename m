Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1A636A0C4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 13:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbhDXLHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 07:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhDXLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 07:07:01 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74568C061756;
        Sat, 24 Apr 2021 04:06:22 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5C15222255;
        Sat, 24 Apr 2021 13:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619262380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mt+USGcgMuYRSvhgvaBBu5wVT3FzFNAP4aN4m/X9RA0=;
        b=dP34j55+3DThW1LIQWyGoET38bQeZRoYrlFVCAiJzMMsTT/lyjD02Nd9tqsqk0kFBVm3Fi
        L01xN9kozNL0RXnDQmIQj7uGsvzQVOh9JK4TjWrN6e4aaKQZz93oofKqq55HElt+RloFs6
        Sx38VwCWHqnebf3RWhj/1bwzXb/qKfw=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 3/5] dt-bindings: mtd: add OTP bindings
Date:   Sat, 24 Apr 2021 13:06:06 +0200
Message-Id: <20210424110608.15748-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210424110608.15748-1-michael@walle.cc>
References: <20210424110608.15748-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash devices can have one-time-programmable regions. Add a nvmem
binding so they can be used as a nvmem provider.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v1:
 - drop "mtd-" prefix for the compatible strings

Changes since RFC:
 - added missing "$"
 - dropped first example
 - use real device compatibles

   Please note, that this will lead to an error without patch 4/5, which
   introduces that property for the jedec,spi-nor. Should I keep it
   seperate or should I squash that patch into this one?

 .../devicetree/bindings/mtd/mtd.yaml          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index 086b0ecd1604..376b679cfc70 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -21,6 +21,25 @@ properties:
       based name) in order to ease flash device identification and/or
       describe what they are used for.
 
+patternProperties:
+  "^otp(-[0-9]+)?$":
+    type: object
+    $ref: ../nvmem/nvmem.yaml#
+
+    description: |
+      An OTP memory region. Some flashes provide a one-time-programmable
+      memory whose content can either be programmed by a user or is already
+      pre-programmed by the factory. Some flashes might provide both.
+
+    properties:
+      compatible:
+        enum:
+          - user-otp
+          - factory-otp
+
+    required:
+      - compatible
+
 additionalProperties: true
 
 examples:
@@ -36,4 +55,35 @@ examples:
         };
     };
 
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            reg = <0>;
+            compatible = "jedec,spi-nor";
+
+            otp-1 {
+                compatible = "factory-otp";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                electronic-serial-number@0 {
+                    reg = <0 8>;
+                };
+            };
+
+            otp-2 {
+                compatible = "user-otp";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                mac-address@0 {
+                    reg = <0 6>;
+                };
+            };
+        };
+    };
+
 ...
-- 
2.20.1

