Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A915A361F22
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbhDPLuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:50:07 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:58117 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbhDPLuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:50:02 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C2BDF22258;
        Fri, 16 Apr 2021 13:49:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618573777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwNQQwuvkXgYqZ0wPSlRqs63aHrarWZIIoxesnKvIpE=;
        b=bPmcm8zPeorjx7ZwkG7zbtjhQxJFmJ5u8UGbTWRnLpwXiuS2kKJYcuTD5CRv0/DoVe3/cH
        sUDcD1/ClOnAfQyKKPqNVShTkgrye0+3ZjOCZZk2xXz2S/Ieqg0B5GGyaYsTuuBwZ2wY0a
        sGaG0VlrcIxXaIGJ2lv7Cv62P4tol+s=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 3/5] dt-bindings: mtd: add OTP bindings
Date:   Fri, 16 Apr 2021 13:49:26 +0200
Message-Id: <20210416114928.27758-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416114928.27758-1-michael@walle.cc>
References: <20210416114928.27758-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash devices can have one-time-programmable regions. Add a nvmem
binding so they can be used as a nvmem provider.

Signed-off-by: Michael Walle <michael@walle.cc>
---
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
index 086b0ecd1604..dd43fb8b4fd1 100644
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
+          - mtd-user-otp
+          - mtd-factory-otp
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
+                compatible = "mtd-factory-otp";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                electronic-serial-number@0 {
+                    reg = <0 8>;
+                };
+            };
+
+            otp-2 {
+                compatible = "mtd-user-otp";
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

