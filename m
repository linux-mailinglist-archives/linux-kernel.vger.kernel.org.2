Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC92388322
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbhERXaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:30:25 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37397 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbhERXaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:30:20 -0400
Received: by mail-oi1-f174.google.com with SMTP id h9so11459782oih.4;
        Tue, 18 May 2021 16:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLME4T5Z2d1HlMwy8QAFy4LOtRjKYn3BtqB6DvAJbNI=;
        b=e0RsrMccImiE8w2czNudkkjnNH6RNPLS0kLBRpr6iYWsXebnWNW2KKW9v55tMBh1RY
         OCxysvaqdbEhyUwhP2g7RH0VM9v3MF7OcRp078zeOYXS5AoNq/oUViD/jJByd79TOh0G
         o2nAOMomtSqPBV83Nti8Cwqc10tUJZqEyExZ5OA+mRn34SXCm+Cw50VAp+Xq9k6Z7vWt
         OIKzfSMv1LxpVrPb1ax1xjLO3F4vaIqf0+/ygAtIwVS9PNKJo2lzIT1Pt1Pwq2k1GSD4
         SLNQ/s7exp25nbAgujaMCcnJfsHHN1GcJGy6ubn1JJ/Z9JEcfhDQ3+CoZbeBKzgbmxV8
         yBOA==
X-Gm-Message-State: AOAM530+YZdWv1pKQ5WIUMaGvT9FwWX3OLZGgHNig0yWjk05jmDU7R11
        Cqx6rsck55n7F0EuVPaidqLf8aBB7w==
X-Google-Smtp-Source: ABdhPJyIW4Wn119a+T/EF5RCa5wzDzw5cSDDOk8J+LcIBiNDw9i9niTL58i17Uz4LPonyJopSWQVkw==
X-Received: by 2002:a05:6808:245:: with SMTP id m5mr5791187oie.6.1621380541410;
        Tue, 18 May 2021 16:29:01 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id d19sm3985608oop.26.2021.05.18.16.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:29:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/6] dt-bindings: mfd: ti,j721e-system-controller: Fix mux node errors
Date:   Tue, 18 May 2021 18:28:53 -0500
Message-Id: <20210518232858.1535403-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210518232858.1535403-1-robh@kernel.org>
References: <20210518232858.1535403-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti,j721e-system-controller binding does not follow the standard mux
controller node name 'mux-controller' and the example is incomplete. Fix
these to avoid schema errors before the mux controller binding is
converted to schema.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../mfd/ti,j721e-system-controller.yaml       | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index 19fcf59fd2fe..272832e9f8f2 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -43,12 +43,10 @@ properties:
 
 patternProperties:
   # Optional children
-  "^serdes-ln-ctrl@[0-9a-f]+$":
+  "^mux-controller@[0-9a-f]+$":
     type: object
-    description: |
-      This is the SERDES lane control mux. It should follow the bindings
-      specified in
-      Documentation/devicetree/bindings/mux/reg-mux.txt
+    description:
+      This is the SERDES lane control mux.
 
 required:
   - compatible
@@ -68,9 +66,18 @@ examples:
         #size-cells = <1>;
         ranges;
 
-        serdes_ln_ctrl: serdes-ln-ctrl@4080 {
+        serdes_ln_ctrl: mux-controller@4080 {
             compatible = "mmio-mux";
             reg = <0x00004080 0x50>;
+
+            #mux-control-cells = <1>;
+            mux-reg-masks =
+                <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
+                <0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
+                <0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
+                <0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
+                <0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
+                /* SERDES4 lane0/1/2/3 select */
         };
     };
 ...
-- 
2.27.0

