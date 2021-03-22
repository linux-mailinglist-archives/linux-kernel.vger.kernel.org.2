Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B962344E61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhCVSUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhCVSUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:20:13 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D8C061574;
        Mon, 22 Mar 2021 11:20:12 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DE73822253;
        Mon, 22 Mar 2021 19:20:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616437208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ly/ltM96HKL3LdgK2QYn3SH/X0EmhT5KbbgmWYv46uU=;
        b=hdYWOGTit3OOOvsID+aU6tkg3/qj3c+sb6BxHOVnDVAcoy9CqpWUT7Ra+DO/lHlmttxKfP
        h2td37iA9iLD6IiUedxWBXkZEuR2uDWz0VUtD7B1CGigtvPFg/qCMQZUdjZCNuSuN1yqRN
        ii/QzZwKcOhDKubbVvPfVL3KVemQyFg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 3/4] dt-bindings: mtd: add OTP bindings
Date:   Mon, 22 Mar 2021 19:19:48 +0100
Message-Id: <20210322181949.2805-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210322181949.2805-1-michael@walle.cc>
References: <20210322181949.2805-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash devices can have one-time-programmable regions. Add a nvmem
binding so they can be used as a nvmem provider.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../devicetree/bindings/mtd/mtd.yaml          | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index 321259aab0f6..2b852f91a6a9 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -21,6 +21,25 @@ properties:
       based name) in order to ease flash device identification and/or
       describe what they are used for.
 
+patternProperties:
+  "^otp(-[0-9]+)?":
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
@@ -36,4 +55,56 @@ examples:
         };
     };
 
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            reg = <0>;
+            compatible = "some,flash";
+
+            otp {
+                compatible = "mtd-user-otp";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                serial-number@0 {
+                    reg = <0 16>;
+                };
+            };
+        };
+    };
+
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            reg = <0>;
+            compatible = "some,flash";
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

